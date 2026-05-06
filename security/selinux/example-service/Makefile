# Example daemon + SELinux policy
# You can run the commands in the order they are written, from
# top to bottom.

all: build

# A simple daemon that reads a file
build: mydaemon.c
	$(CC) -o mydaemon mydaemon.c

# Install the daemon service (systemd)
install: build mydaemon.service
	cp mydaemon /usr/local/bin
	cp mydaemon.service /usr/lib/systemd/system
	systemctl start mydaemon
	systemctl status mydaemon

# Generate some boilerplate for the policy
# `sepolicy` utility is in policycoreutils-devel package
.PHONY: generate
generate:
	sepolicy generate --init /usr/local/bin/mydaemon

# Install the policy
.PHONY: apply
apply:
	./mydaemon.sh

.PHONY: relable
relable:
	restorecon -v /usr/local/bin/mydaemon /usr/lib/systemd/system

# After installing the policy (an relabling the filesystem), the
# daemon will no longer have access to the file it was reading.
#
# You can check that the daemon is failing with the command:
#
#    ausearch -m AVC -ts recent
#
# We need to modify our policy to allow it to read the file. We
# can use `audit2allow` to suggest for us what to add.

# Suggest some policies
.PHONY: suggest
suggest:
	ausearch -m AVC -ts recent | audit2allow -R


# audit2allow will returned this string:
#
#     logging_write_generic_logs(mydaemon_t)
#
# This is actually a macro that expands to a policy. You can
# use the tool `macro-expander` to see that it expands to:
#
# macro-expander "logging_write_generic_logs(mydaemon_t)"

# We can finally patch our policy and reload it:
#
#  echo "logging_write_generic_logs(mydaemon_t)" >> mydaemon.te
#  ./mydaemon.sh
#
# You can check the error log again to verify that the daemon
# works again.
