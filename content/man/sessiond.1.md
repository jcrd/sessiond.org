---
title: sessiond.1
---

# NAME

sessiond - standalone X session manager

# SYNOPSIS

**sessiond** \[OPTIONS\]

# DESCRIPTION

sessiond is a standalone X session manager that reports the idle status of a
session to [systemd-logind.service(8)](https://www.commandlinux.com/man-page/man8/systemd-logind.service.8.html) and handles its lock, unlock, sleep, and
shutdown signals. sessiond also provides hooks triggered by inactivity or a
signal, automatic backlight dimming on idle, and optional management of DPMS
settings.

# OPTIONS

- **-h**, **--help**

    Show help options.

- **-c**, **--config**=_CONFIG_

    Path to config file. See [sessiond.conf(5)]({{< ref "/man/sessiond.conf.5.md" >}}) for configuration options.

- **-i**, **--idle-sec**=_SEC_

    Seconds the session must be inactive before considered idle.

- **-v**, **--version**

    Show version.

# DBUS SERVICE

sessiond provides a DBus service on the session bus at the well-known name
_org.sessiond.session1_.

## Session interface

The **/org/sessiond/session1** object implements the
**org.sessiond.session1.Session** interface, which exposes the following
methods, properties, and signals:

### METHODS

- **Lock**

    Lock the session. Returns an error if the session is already locked.

- **Unlock**

    Unlock the session. Returns an error if the session is not locked.

- **Inhibit**

    Inhibit inactivity. The session will always be considered active if at least
    one inhibitor is running. Takes two arguments:

    - _who_

        A string describing who is inhibiting.

    - _why_

        A string describing why the inhibitor is running.

    Returns a unique ID used to stop the inhibitor.

- **Uninhibit**

    Stop an inhibitor. Takes one argument:

    - _id_

        The unique ID of the inhibitor to stop.

    Returns an error if the ID is not valid or does not exist.

- **StopInhibitors**

    Stop running inhibitors. Returns the number of inhibitors stopped.

- **ListInhibitors**

    List running inhibitors. Returns a dictionary mapping IDs to tuples of the
    creation timestamp and _who_ and _why_ strings.

### PROPERTIES

- **InhibitedHint**

    The inhibited state of the session.

- **LockedHint**

    The locked state of the session.

- **IdleHint**

    The idle state of the session.

- **IdleSinceHint**

    The timestamp of the last change to **IdleHint**.

- **IdleSinceHintMonotonic**

    The timestamp of the last change to **IdleHint** in monotonic time.

- **Backlights**

    An array of object paths to exported Backlights.

- **Version**

    The version of sessiond.

### SIGNALS

- **Lock**

    Emitted when the session is locked. **LockedHint** will be true.

- **Unlock**

    Emitted when the session is unlocked. **LockedHint** will be false.

- **Idle**

    Emitted when the session becomes idle. **IdleHint** will be true.

- **Active**

    Emitted when activity resumes in an inactive session.
    **IdleHint** will be false.

- **Inactive** **seconds**

    Emitted when the session becomes inactive, with the **seconds** argument being
    the number of seconds since activity. Its value will be equal to either the
    _IdleSec_ or _DimSec_ configuration option (see [sessiond.conf(5)]({{< ref "/man/sessiond.conf.5.md" >}})), or the
    _InactiveSec_ option of a hook with an **Inactive** trigger
    (see [sessiond-hooks(5)]({{< ref "/man/sessiond-hooks.5.md" >}})).

- **PrepareForSleep** **state**

    Emitted before and after system sleep, with the **state** argument being true
    and false respectively.

- **PrepareForShutdown** **state**

    Emitted before and after system shutdown, with the **state** argument being true
    and false respectively.

- **AddBacklight** **path**

    Emitted when a backlight is added, with **path** being the object path of the
    new backlight.

- **RemoveBacklight** **path**

    Emitted when a backlight is removed, with **path** being the old object path of
    the backlight.

## Backlight interface

The **/org/sessiond/session1/backlight/\*** objects implement the
**org.sessiond.session1.Backlight** interface, which exposes the following
methods and properties:

### METHODS

- **SetBrightness**

    Set the brightness of the backlight. Takes one argument:

    - _brightness_

        An unsigned integer value.

    Returns an error if unable to set brightness.

- **IncBrightness**

    Increment the brightness of the backlight. Takes one argument:

    - _value_

        An integer value added to the backlight's current brightness.

    Returns the new brightness value or an error if unable to set brightness.

### PROPERTIES

- **Online**

    True if the backlight is online, false otherwise.

- **DevPath**

    Path to the backlight device without the sys mount point.

- **Name**

    Name of the backlight.

- **Subsystem**

    Subsystem to which the backlight belongs. Possible values are: "backlight" or
    "leds".

- **SysPath**

    Path to the device via sys mount point. Format is:
    "/sys/class/_Subsystem_/_Name_".

- **Brightness**

    Current brightness of backlight.

- **MaxBrightness**

    Max brightness of backlight.

## Introspection

- For complete introspection data, use [gdbus(1)](https://www.commandlinux.com/man-page/man1/gdbus.1.html):

    **gdbus** introspect --session --dest _org.sessiond.session1_ --object-path
    _/org/sessiond/session1_

# DEBUGGING

Running sessiond with the environment variable _G\_MESSAGES\_DEBUG_ set to "all"
will print debug messages.

# AUTHOR

James Reed <jcrd@sessiond.org>

# REPORTING BUGS

Bugs and issues can be reported here: [https://github.com/jcrd/sessiond/issues](https://github.com/jcrd/sessiond/issues)

# COPYRIGHT

Copyright 2018-2020 James Reed. sessiond is licensed under the
GNU General Public License v3.0 or later.

# SEE ALSO

[sessiond.conf(5)]({{< ref "/man/sessiond.conf.5.md" >}}), [sessiond-hooks(5)]({{< ref "/man/sessiond-hooks.5.md" >}}), [systemd-logind.service(8)](https://www.commandlinux.com/man-page/man8/systemd-logind.service.8.html), [gdbus(1)](https://www.commandlinux.com/man-page/man1/gdbus.1.html)
