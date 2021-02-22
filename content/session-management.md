## Starting the session

A sessiond-based session should be started via a display manager, using
the provided `sessiond.desktop` X session file.

For example, configure `lightdm` to start a sessiond session by setting
`user-session=sessiond` in `/etc/lightdm/lightdm.conf`.

## Running services

`sessiond-session.target` binds to `graphical-session.target` provided
by systemd. See _graphical-session.target_ in [systemd.special(7)][1]
for more information about graphical sessions.

To run a service in the graphical session, `<service>.service` should contain:

```
[Unit]
PartOf=graphical-session.target
```

so the service is stopped when the session ends, and:

```
[Install]
WantedBy=graphical-session.target
```

so the service is started when the session begins.

It can then be enabled with `systemctl --user enable <service>`.

See below for example services.

[1]: https://www.freedesktop.org/software/systemd/man/systemd.special.html#graphical-session.target

## Locking the session

By default, the session is locked when it becomes idle and before sleeping.
This is configured in the `[Lock]` section of the configuration file.
The session can be manually locked by running `sessionctl lock`.

To configure a service to act as the screen locker, include:

```
[Service]
ExecStopPost=/usr/bin/sessionctl unlock
```

so the session is considered unlocked when the locker exits, and:

```
[Install]
WantedBy=graphical-lock.target
```

so the service is started when the session locks. Then enable it.

Below is an example `i3lock.service`:

```
[Unit]
Description=Lock X session with i3lock
PartOf=graphical-session.target

[Service]
ExecStart=/usr/bin/i3lock -n -c 000000
ExecStopPost=/usr/bin/sessionctl unlock

[Install]
WantedBy=graphical-lock.target
```

## Stopping the session

The session can be stopped with `sessionctl stop`. This will stop
`graphical-session.target` and all units that are part of the session.

A service that is part of the graphical session can be responsible for stopping
the session. To configure a service to stop the session when it exits, include:

```
[Service]
ExecStopPost=/usr/bin/sessionctl stop
```

Below is an example `awesome.service` that stops the session when the Awesome
window manager exits:

```
[Unit]
Description=Awesome window manager
PartOf=graphical-session.target

[Service]
ExecStart=/usr/bin/awesome
ExecStopPost=/usr/bin/sessionctl stop

[Install]
WantedBy=graphical-session.target
```

## Inhibiting inactivity

Inhibitor locks can be acquired when the session should be considered active
while a given command is running, e.g. a media player.

The `sessiond-inhibit` script provides a simple interface to acquire a lock
before running a command and release it when the command returns.

```
usage: sessiond-inhibit [-h] [-w WHO] [-y WHY] [-s] [-i] [-u [ID]] [command]

With no command, list running inhibitors.

positional arguments:
  command               Command to run

optional arguments:
  -h, --help            show this help message and exit
  -w WHO, --who WHO     Set who is inhibiting
  -y WHY, --why WHY     Set why this inhibitor is running
  -s, --stop            Stop running inhibitors
  -i, --inhibit         Inhibit without a command
  -u [ID], --uninhibit [ID]
                        Uninhibit last inhibitor or by ID
```

See [sessiond-inhibit(1)][2] for more information.

See the _DBus Service_ section of [sessiond(1)][3]
for descriptions of inhibitor-related methods.

[2]: {{< ref "/man/sessiond-inhibit.1.md" >}}
[3]: {{< ref "/man/sessiond.1.md#dbus-service" >}}
