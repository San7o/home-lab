Linux Kernel Dev Notes
======================

The Kernel Commandments:

* Don't follow The Kernel Commandments blindly, use your brain

* Thou shalt not sleep nor call `kmalloc(size, GFP_KERNEL)` in interrupt
  context.

* Thou shalt use `rmb()` and `wmb()` before or after `iowrite()` or `ioread()`
  to instruct o'slave compiler to produce the side effects when you need them.

* Dereferencing a `__user` pointer is strictly forbidden, even to the bravest
  and enlightened kernel developer.

* A good C developer always cleans up its garbage, in reverse initialization
  order.

* Thou shalt synchronize an RCU data structure before writing to it

* Thou shalt use floating point ops only in a special fpu context

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
  after the `---`?)

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

    ./scripts/checkpatch.pl -f drivers/staging/your-driver/your-file.c

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

    # Make sure your ~/.gitconfig is correct
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
