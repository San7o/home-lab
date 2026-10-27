PostgreSQL
==========

PostgreSQL is an object-relational database management system. A relation is
essentially a mathematical term for a table, which is a collection of rows
containing the same set of named columns. It uses a client-server design where
the sever manages the data and the client send queries to the server.

Compiling
---------

After downloading the sources, you can build the project with automake:

.. code-block:: bash

   ./configure
   make
   su
   make install
   adduser postgres
   mkdir -p /usr/local/pgsql/data
   chown postgres /usr/local/pgsql/data
   su - postgres
   /usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data
   /usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data -l logfile start
   /usr/local/pgsql/bin/createdb test
   /usr/local/pgsql/bin/psql test

Basic commands
--------------

Create a database:

.. code-block:: bash

   createdb mydb

Delete a database:

.. code-block:: bash

   dropdb mydb

To access a database:

.. code-block:: bash

   psql mydb

SQL Commands
^^^^^^^^^^^^

Create a table:

.. code-block:: bash

   CREATE TABLE weather (
     city            varchar(80),
     temp_lo         int,           -- low temperature
     temp_hi         int,           -- high temperature
     prcp            real,          -- precipitation
     date            date
   );

Delete a table:

.. code-block:: bash

   DROP TABLE tablename;

Inserting an element into the table:

.. code-block:: bash

   INSERT INTO weather VALUES ('San Francisco', 46, 50, 0.25, '1994-11-27');

To quickly insert values from a file:

.. code-block:: bash

   COPY weather FROM '/home/user/weather.txt';

Selecting elements:

.. code-block:: bash

   SELECT city, temp_lo, temp_hi, prcp, date FROM weather;
   SELECT DISTINCT city FROM weather;
   SELECT * FROM weather JOIN cities ON city = name;

Aggregate functions:

.. code-block:: bash

   SELECT max(temp_lo) FROM weather;
   SELECT city, count(*), max(temp_lo) FROM weather GROUP BY city;
   SELECT city, count(*) FILTER (WHERE temp_lo < 45), max(temp_lo)
      FROM wheather GROUP BY city;

The difference between `WHERE` and `HAVING` is that `WHERE` selects input rows
before groups and aggregates are computed, whereas `HAVING` selects them after.
Another way to select the rows that go into an aggregate computation is to use
`FILTER` which is a per-aggregate option.

Update:

.. code-block:: bash

   UPDATE weather
    SET temp_hi = temp_hi - 2,  temp_lo = temp_lo - 2
    WHERE date > '1994-11-28';

Deletions:

.. code-block:: bash

   DELETE FROM weather WHERE city = 'Hayward';

Views:

.. code-block:: bash

   CREATE VIEW myview AS
    SELECT name, temp_lo, temp_hi, prcp, date, location
        FROM weather, cities
        WHERE city = name;
   
   SELECT * FROM myview;

Foreign Keys:

.. code-block:: bash

   CREATE TABLE cities (
        name     varchar(80) primary key,
        location point
   );

   CREATE TABLE weather (
           city      varchar(80) references cities(name),
           temp_lo   int,
           temp_hi   int,
           prcp      real,
           date      date
   );

Transactions bound multiple steps into a single, all-or-nothing operation:

.. code-block:: bash

   BEGIN;
   UPDATE accounts SET balance = balance - 100.00
       WHERE name = 'Alice';
   -- etc etc
   COMMIT;

You can also have `savepoints` in transactions, so that you can rollback to a
previous savepoint with `ROLLBACK TO`:

.. code-block:: bash

   BEGIN;
   UPDATE accounts SET balance = balance - 100.00
       WHERE name = 'Alice';
   SAVEPOINT my_savepoint;
   UPDATE accounts SET balance = balance + 100.00
       WHERE name = 'Bob';
   -- oops ... forget that and use Wally's account
   ROLLBACK TO my_savepoint;
   UPDATE accounts SET balance = balance + 100.00
       WHERE name = 'Wally';
   COMMIT;

Window functions perform calculations across a set of table rows that are
somewhat related to the current row:

.. code-block:: bash

   SELECT depname, empno, salary,
       row_number() OVER (PARTITION BY depname ORDER BY salary DESC)
   FROM empsalary;

You can create inheritance relationships among tables:

.. code-block:: bash

   CREATE TABLE cities (
      name       text,
      population real,
      elevation  int     -- (in ft)
   );
   
   CREATE TABLE capitals (
     state      char(2) UNIQUE NOT NULL
   ) INHERITS (cities);

Maintainance
------------

Postgres, like other DBMS, requires periodic maintenance tasks. This includes
periodic backups, "vacuuming", updating statistics used by the query planner,
and log file management. The "check_postgres" cli program can be used for these
tasks.

PostgreSQL's `VACUUM` command needs to be executed for each table on a regular
basis for several reasons:

1. To recover or reuse disk space occupied by updated or deleted rows

2. To update data statistics used by the PostgreSQL query planner

3. To update the visibility map, which speeds up index-only scans

4. To protect against loss of very old data due to transaction ID wraparound or
   multixact ID wraparound

A variation of the command is `VACUUM FULL` which reclaims more disk space but
runs much more slowly. Normal `VACUUM` can run in parallel, but the full version
can't on the same table. Vacuum can be automatically done dynamically via the
autovacuum daemon, which will schedule vacuum periodically based on the
activity.

Indexes can be rebuilt with the `REINDEX` command, which should be done
regularly. This command requires an `ACCESS EXCLUSIVE` lock by default, hence it
is often preferable to execute it with its `CONCURRENTLY` option, which requires
only a `SHARE UPDATE EXCLUSIVE` lock.

You should also rotate the logs. There is a built-in functionality by setting
`logging_collector` to `true` in `postgresql.conf`, or use an external one.

As with everything that contains data, PostgreSQL databases should be backed up
regularly. There are three fundamentally different approaches to backing up
data:

* SQL dump: the idea is to generate a file with SQL commands that, when fed back
  to the server, will recreate the database in the same state as it was at the
  time of the dump. This can be done with the `pg_dump` utility:

.. code-block:: bash

   pg_dump dbname > dumpfile

  You can perform this backup procedure from any remote host that has access to
  the database, but it requires read access to all tables that you want to back
  up.

  To restore a dump, run the following command or use `pg_restore` for non-text
  file dumps:

.. code-block:: bash

   psql -X --set ON_ERROR_STOP=on dbname < dumpfile

  Before restoring and SQL dump, all the users who own objects or were granted
  permissions on objects in the dumped database must already exist, or the
  restore will fail. While restoring, you can also specify
  `--single-transaction` to perform an unique transaction so that the restore is
  either fully completed or fully rolled back.

  After restoring a backup, it is wise to run `ANALYZE` on each database so the
  query optimizer has useful statistics.

  To dump all databases and roles, use `pg_dumpall`:

.. code-block:: bash

   pg_dumpall > dumpfile

  This can be restored with `psql`:

.. code-block:: bash

   psql -X -f dumpfile postgres

  You can also create compressed backups:

.. code-block:: bash

   pg_dump dbname | gzip > filename.gz

* File system level backup: directly copy the files that PostgreSQL uses to
  store the data in the database:

.. code-block:: bash

   tar -cf backup.tar /usr/local/pgsql/data

  However, for this to work the database must be shut down. Additionally you
  cannot backup individual tables or databases. If the filesystem supports
  snapshots, then these can be used to crate backups when the database is
  running.

* Continuous archiving: use the write ahead log (WAL) which logs all
  transactions to replay them later.

High Availability
-----------------

Database servers can work together to allow a second server to take over quickly
if the primary server fails (high availability), or to allow several computers
to serve the same data (load-balancing). While read-only databases can be
combined relatively easily, this is more complicated for read / write servers: a
write to any server has to be propagated to all servers so that future read
requests to those servers return consistent results. This synchronization
problem is the fundamental difficulty for servers working together, and there
are multiple solutions for this problem for different use-cases. In general,
they can be categorized in the following ways:

* master servers: some solutions deal with synchronization by allowing only one
  server, the `master` or `primary` server, to modify the data. Servers that
  track changes in the primary are called `standby` or `secondary` servers, and
  one that can accept connections and servers read-only queries is called `hot
  standby` server.

* synchronous: in this approach, a data-modifying transition is not considered
  committed until all servers have committed the transaction. This guarantees
  that a failover will not lose any data and that all load-balanced servers will
  return consistent results no matter which server is queried. Asynchronous
  communications are used when synchronous would be too slow.

* granularity: they may deal only with an entire database server, while others
  allow control at the per-table or per-database level.

Various solutions are now provided:

* Shared Disk Failover: TODO

* File System (Block Device) Replication: TODO

* Write-Ahead Log Shipping: TODO

* Logical Replication: TODO

* Trigger-Based Primary-Standby Replication: TODO

* SQL-Based Replication Middleware: TODO

* Asynchronous Multimaster Replication: TODO

* Synchronous Multimaster Replication: TODO

* Data Partitioning: TODO

* Multiple-Server Parallel Query Execution: TODO

Log-Shipping Standby Severs
^^^^^^^^^^^^^^^^^^^^^^^^^^^

TODO

Architecture
------------

TODO
