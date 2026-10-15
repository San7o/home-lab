Linux Kernel Dev Notes
======================

The Kernel Commandments
-----------------------

aka some things to keep in mind.

* Don't follow The Kernel Commandments blindly, use your brain

* Use the proper memory allocation functions based on what you want:

    * `vmalloc()` allocates virtually contiguous memory only. Physical pages can
      be scattered everywhere. Slower, but handles massive allocations. Cannot
      be called in IRQ context.

    * `kmalloc()` allocates physically and virtually contiguous memory. Fast, but
      limited in size.

    * `kvmalloc()` tries `kmalloc()` first for performance, and automatically
      falls back to `vmalloc()` if the contiguous allocation fails.

  Additionally, there are different ways to get the memory:

    * `GFP_KERNEL` in a process context, it may block / wait so use it when you
      can sleep

    * `GFP_ATOMIC` used in interrupt handlers, bottom halves, soft irqs.

  Historically, there have been multiple "slab" allocators known as `SLAB` (K&R
  free-list based), `SLOB` (cache friendly) and `SLUB` (fast and simple), but
  now you should use only SLUB. Indeed, SLOB has been fully deprecated and SLAB
  is soon to be. There are of course other allocators like the page allocator
  and continuous memory allocator that are used by the various `kmalloc`
  functions.

* Thou shalt not sleep nor call `kmalloc(size, GFP_KERNEL)` in interrupt
  context.

* Thou shalt use `rmb()` and `wmb()` before or after `iowrite()` or `ioread()`
  to instruct o'slave compiler to produce the side effects when you need them.
  An `udelay()` after the write may be good to have, to wait for the operation
  to complete.

* Dereferencing a `__user` pointer is strictly forbidden, even to the bravest
  and enlightened kernel developer. You need to read from an user pointer with
  `copy_from_user()` and write with `copy_to_user()`.

* A good C developer always cleans up its garbage, in reverse initialization
  order.

* Thou shalt synchronize an RCU data structure before writing to it. The RCU api
  is the following:

    * `rcu_read_lock()`: used by a reader to inform the reclaimer that the
      reader is enetering an RCU read-side critical section. It is illegal to
      block while in an RCU read-side critical-section, tough kernels built with
      `CONFIG_PREEMPT_RCU` can preempt RCU read-side critical sections.

    * `rcu_read_unlock()`: used by a reader to inform the relcaimer that the
      reader is exiting an RCU read-size critical section.

    * `synchronize_rcu()` / `call_rcu()`: mark the end of updater code and the
      beginning of reclaimer code. It does this by blocking until all
      pre-existing RCU read-side critical sections on all CPUs have completed.
      Use `call_rcu()` if the thread cannot block, which will call a callback.

    * `rcu_assign_pointer()`: the updater uses this macro to assign a new value
      to an RCU-protected pointer, in order to safely communicate the change in
      value from the updater to the reader.

    * `rcu_dereference()`: the reader uses this macro to fetch an RCU-protected
      pointer, which returns a value that may then be safely dereferenced.

    * Other specific apis, such as for lists

  For example, a reader would look like the following:

  .. code-block:: c

    rcu_read_lock();
    p = rcu_dereference(head.next);
    // Do stuff with p ...
    rcu_read_unlock();
    // Cannout use p anymore
    x = p->address; /* BUG!!! */
    rcu_read_lock();
    y = p->data;    /* BUG!!! */
    rcu_read_unlock();

Example writer:

  .. code-block:: c

    struct my_node *old_node, *new_node;

    // Allocate and populate the replacement object
    new_node = kmalloc(sizeof(*new_node), GFP_KERNEL);
    if (!new_node)
        return -ENOMEM;
    new_node->address = 0xDEADBEEF;
    new_node->data = 42;
    
    // Acquire the writer lock to serialize concurrent updates
    spin_lock(&writer_lock);
    
    // Grab the current pointer safely (under the writer lock)
    old_node = rcu_dereference_protected(head.next, lockdep_is_held(&writer_lock));
    
    // Link the new node into the structure
    new_node->next = old_node;
    rcu_assign_pointer(head.next, new_node);
    
    spin_unlock(&writer_lock);
    
    // Wait for all pre-existing readers to finish their critical sections
    synchronize_rcu();
    
    // Safe to free the old node now that no reader can possibly see it
    kfree(old_node);

  The real power of RCU is zero-cost read sides. You could implement this
  through "smart pointers" and reference counting, but that would mean that
  readers need to interact with a variable (the counter) across CPUs and cause
  lots of cache misses. With RCU, a reader only increases its own per-CPU
  counter, and all CPUs are synchronized during reclaim time (after a grace
  period) in `synchronize_rcu()`. This traces space-time complexity at read time
  for asynchronous tracking at reclaim time.

* Thou shalt use floating point ops only in a special fpu context. Relevant
  functions are: `kernel_fpu_available()`, `kernel_fpu_begin()`,
  `kernel_fpu_end()`.

* Lists are of type `struct list_head`, an element can be accessed via
  `container_of()`. Hash maps are of type `struct hlist_head`.

* Thou shalt never use sysfs API directly, unless he works deep in filesystems.
  Always use groups, or you will create a race condition and made fun of
  (`sysfs_create_group`)

* Beware of the scary spectre when reading memory indexed by an user variable.
  Use `array_index_nospec()` or `speculation_barrier()` when necessary.

* Add `"Fixes: <commmit-id> ("<commit-message>")"` tag if you are fixing a
  previous patch

* Add `Assisted-By: <my-agent>` to tell that you had help from AI.

* Thou shalt use `devm_*` functions whenever possible, as they are less error
  prone, but only if the device does not require explicit logic when
  de-initializing (i.e. if it has a custom `.remove` callback).

* Before touching a per-CPU variable, thou must disable preemption or interrupts
  using `get_cpu_var()` and release it with `put_cpu_var()`

* For most cases, use `fsleep()` for sleeping, instead of `usleep_range()`. Use
  `udelay()` in IRQ path

* Document why you are sleeping and why that specific time

* beware of overflows. Use `size_add()`, `size_mul()`, `array_size()` and
  similar functions when necessary.

* Consider using macros from `cleanup.h`:

    * Use `guard(mutex)(&mu_mutex)` instead of `mutex_lock(&my_mutex)` /
      `mutex_unlock(&my_mutex)`

    * Use things like `struct pmu *pmu __free(pmu_unregister) = _pmu;` and then
      when returning successfully `_pmu = no_free_ptr(pmu);` or
      `return_tr(pmu)`.

* Consider using the macros in `bits.h` and `bitfield.h`, like `BIT()`,
  `GENMASK()`, `FIELD_GET()`. If you have many registers, consider using
  `regmap.h`.

* Do not break UAPI. For example, by changing the string formatting of a
  `sysfs_emit()`

* Use `if (err < 0) \n return dev_err_probe(...)` when checking for an error
  during probing. Otherwise use `dev_err()`, `dev_warn()` and similar functions
  when printing from a device, as they prepend the device name in the logs.

* Add trailing commas in all entries of an array or struct.

* If you are fixing a build error, show the build error in the patch (maybe
  after the three `-`?)

* Sort the headers alphabetically

* If a `static struct` never changes, mark it as `static const struct`. Show
  size of elf sections before and after the change.

Networking:

* Do not register stuff in `procfs`, `debugfs` or `ioctls`, modern netdev uses
  only `netlink`.

* When declaring variables at the start of a function, netdev use an autistic
  order called reverse christmas tree: longest lines first, shortest last.

Useful commands
---------------

Get who owns what in the kernel. `--nogit-fallback` will not output developers
who modified the file:

.. code-block:: bash

    ./scripts/get_maintainer.pl -f <path> --nogit-fallback

When building your module, ensure you have warnings enabled (1, 2 or 3):

.. code-block:: bash

    make W=1

Always checkpatch before thinking about sending a patch:

.. code-block:: bash

    ./scripts/checkpatch.pl --strict -f drivers/staging/your-driver/your-file.c

Also run coccinelle, a static code analysis tool:

.. code-block:: bash

    make coccicheck MODE=report M=drivers/staging/iio/

Generate the ctags so you can jump to definitions in your code editor:

.. code-block:: bash

    make tags
    # For emacs gtags:
    make TAGS

Check the offsets of a struct, and how it aligns with the cache:

.. code-block:: bash

   pahole -C sk_buff | less

Sending a patch
---------------

Make your modifications (after running checkpatch and coccinelle):

.. code-block:: bash

    # Make sure your ~/.gitconfig is correct and can send emails
    git commit -s

Generate patch:

.. code-block:: bash

    git format-patch -1 HEAD
    # For a series
    # git format-patch -v1 --cover-letter staging/staging-next -o outgoing/
    scripts/get_maintainer.pl outgoing/0001-your-patch-name.patch
    # Modify the patch
    git send-email \
      --to="gregkh@linuxfoundation.org" \
      --cc="linux-staging@lists.linux.dev" \
      --cc="linux-kernel@vger.kernel.org" \
      outgoing/0001-your-patch-name.patch

Videos
------

Greg explaining release cycle and patch flow from mailing list to stable:

    https://www.youtube.com/watch?v=vyenmLqJQjs

Linus talking about Linux:

    https://www.youtube.com/watch?v=WVTWCPoUt8w

    Some very interesting topic from Linus:

    - Software is almost never designed, because rarely anymody knows exactly
      what they want to do, or they don't after some time. Instead, software
      evolves over time as many interests and goals shape the project as it
      goes.

    - How much GPL is important for ensuring the evolution of linux. If comanies
      (which are greedy) make modifications and keep them to themselves, then
      linux would never be able to grow and evolve the way it does with
      GPL. Same for closed source software, the company that manages the
      software limits its potential and evolution.

Reverse engineering vendor firmware drivers for little fun and no profit [linux.conf.au 2014]

    Scary horror adventure about the experience of reversing engineering a
    binary.

    https://www.youtube.com/watch?v=j5NciKpHZzs&list=LL&index=1&t=2310s
