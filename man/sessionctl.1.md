# NAME

sessionctl - standalone X session manager client

# SYNOPSIS

**sessionctl** \[command\]

# DESCRIPTION

sessionctl is responsible for running a sessiond session and interacting with
its DBus service.

# COMMANDS

- **run**

    Run a new session.

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

James Reed <jcrd@tuta.io>

# REPORTING BUGS

Bugs and issues can be reported here: [https://github.com/jcrd/sessiond/issues](https://github.com/jcrd/sessiond/issues)

# COPYRIGHT

Copyright 2019-2020 James Reed. sessiond is licensed under the
GNU General Public License v3.0 or later.

# SEE ALSO

**systemctl**(1), **gdbus**(1)
