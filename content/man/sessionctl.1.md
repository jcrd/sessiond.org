---
title: sessionctl.1
---

# NAME

sessionctl - standalone X session manager client

# SYNOPSIS

**sessionctl** \[command\]

# DESCRIPTION

sessionctl is responsible for running a sessiond session and interacting with
its DBus service.

# COMMANDS

- **run** \[_SERVICE_\]

    Run a new session, with _SERVICE_ as the window manager service if provided.
    By default, the service installed under the _window-manager.service_ alias is
    used.

- **stop**

    Stop the running session.

- **status**

    Show session status.

- **lock**

    Lock the session.

- **unlock**

    Unlock the session.

- **properties**

    List sessiond properties.

- **backlight**

    Interact with backlights. Subcommands:

    - **list**

        List backlights.

    - **get** _BACKLIGHT_

        Get backlight brightness.

    - **set** _BACKLIGHT_ _VALUE_

        Set backlight brightness.

    - **inc** _BACKLIGHT_ _VALUE_

        Increment backlight brightness. Prints the new brightness value.

- **version**

    Show sessiond version.

# AUTHOR

James Reed <jcrd@sessiond.org>

# REPORTING BUGS

Bugs and issues can be reported here: [https://github.com/jcrd/sessiond/issues](https://github.com/jcrd/sessiond/issues)

# COPYRIGHT

Copyright 2019-2020 James Reed. sessiond is licensed under the
GNU General Public License v3.0 or later.

# SEE ALSO

[systemctl(1)](https://www.commandlinux.com/man-page/man1/systemctl.1.html), [gdbus(1)](https://www.commandlinux.com/man-page/man1/gdbus.1.html)
