Windows commands
================

Quick tip: you can use the new windows terminal on windows 10 by installing it
from the microsoft store. The windows terminal has some multiplexing features
built-in which are very useful.

To get an up to date powershell, you need to download it and install it from the
official website -- do not use the default powershell because it is really old!
-- and then configure the terminal to use the new shell.

To install program, you can use `winget` which is a command line packet manager,
in the style of Linux's packet managers.

Note: to run some of the following commands you need to run the shell as
administrator.

Command utilities
-----------------

Network Utilities
^^^^^^^^^^^^^^^^^

Show ip information:

.. code-block:: powershell

    ipconfig /all

Drop / reassing ip:

.. code-block:: powershell

    ipconfig /release
    ipconfig /renew

Get interfaces with netsh. This tool offers a broader range of capabilities than
ipconfig:

.. code-block:: powershell

    netsh interface show interface

List ports:

.. code-block:: powershell

    netstat -af

Filesystem utilities
^^^^^^^^^^^^^^^^^^^^

Check and repair issues in /f disk and /r sectors:

.. code-block:: powershell

    chkdsk /f
    chkdsk /r

Repair corrupted filesystem files:

.. code-block:: powershell

    sfc /scannnow

Format a drive:

.. code-block:: powershell

    format [drive letter]: /fs:[file system] /q

Manage, create and delete disk partitions:

.. code-block:: powershell

    diskpart

Encrypt all files in current folder:

.. code-block:: powershell

    cipher /E

Robust file copy, better than simple copy:

.. code-block:: powershell

    robocopy source dest /E

General utilities
^^^^^^^^^^^^^^^^^

Get info about the system:

.. code-block:: powershell

    systeminfo

Find a substring:

.. code-block:: powershell

    findstr

Copy to clipboard:

.. code-block:: powershell

    clip

Get a report on power consumption:

.. code-block:: powershell

    powercfg /energy
    powercfg /batteryreport

List and kill processes:

.. code-block:: powershell

    tasklist
    taskkill

Reboot to bios:

.. code-block:: powershell

    shutdown /r /fw /f /t 0

Get the windows version:

.. code-block:: powershell

    winver

NTop - windows version of "top":

    https://github.com/gsass1/NTop

Powershell examples
-------------------

Command help:

.. code-block:: powershell

    Get-Help dir -detailed

Install latest Powershell (the one that is pre-installed is very old):

.. code-block:: powershell

    winget install --id Microsoft.PowerShell --source winget

Update the help documentation:

.. code-block:: powershell

    Update-Help -Verbose -Force -ErrorAction SilentlyContinue

Get all processes, print their members:

.. code-block:: powershell

    Get-Process | Get-Member

Format objects:

.. code-block:: powershell

    dir | Format-List
    dir | Format-Table

Get the number of objects:

.. code-block:: powershell

    Get-Process | Measure

Where filters the objects that meet a condition:

.. code-block:: powershell

    dir | Where { $_.Extension -eq '.json' }
    Get-Process | Where { $_.CPU -ge 10 } | Sort { $_.id }

Get just the name of the directories:

.. code-block:: powershell

    ls | ForEach { $_.Name }

Get all processes with an ID above 4000, and work out the average CPU time:

.. code-block:: powershell

    Get-Process | Where { $_.Id -ge 4000 } | ForEach { $_.CPU } | Measure -Average

Get the drives:

.. code-block:: powershell

    Get-PSDrive

Get the commands using a filter:

.. code-block:: powershell

    Get-Command | Where { $_.Name -like '*process*' }

in this case, Get-Command already accepts a wildcard as argument:

.. code-block:: powershell

    Get-Command *process*

Windows sandbox
---------------

Windows Sandbox is a lightweight, isolated desktop environment that allows users
to safely run applications without affecting their main operating system.

To enable Windows Sandbox, you need to open "Turn Windows features off and off"
and enable it, then restart the machie.

Sandboxes are defines as a XML file, for example the following creates an
isolated sandbox that can access the Download folder in read only mode, and it
runs the explorer when it starts:

.. code-block:: powershell

  <Configuration>
    <VGpu>Disable</VGpu>
    <Networking>Disable</Networking>
    <MappedFolders>
      <MappedFolder>
        <HostFolder>C:\Users\Public\Downloads</HostFolder>
        <SandboxFolder>C:\temp</SandboxFolder>
        <ReadOnly>true</ReadOnly>
      </MappedFolder>
    </MappedFolders>
    <LogonCommand>
      <Command>explorer.exe C:\temp</Command>
    </LogonCommand>
  </Configuration>

To run the sandbox, you need to save the XML as a .wsb file and then double
click or run `start` on it.

WSL
---

Installing WSL is quite straight forward, just run:

.. code-block:: powershell

     wsl --install

sysinternals
------------

Useful tools for sysadmins:

    https://learn.microsoft.com/en-us/sysinternals/

Other tools include
- total commander
- FurMark2 (GPU benchmarks)
- system informer
