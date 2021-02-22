sessiond provides a DBus service on the session bus at the well-known name
**_org.sessiond.session1_**.

See the _DBus Service_ section of [sessiond(1)][1]
for descriptions of methods, properties, and signals.

For complete introspection data, use **gdbus**:

```
gdbus introspect --session --dest org.sessiond.session1 --object-path /org/sessiond/session1
```

[1]: {{< ref "/man/sessiond.1.md#dbus-service" >}}

## sessionctl

The `sessionctl` script is provided to run a sessiond session and interact with
its DBus service.

```
usage: sessionctl [-h]
                  {run,stop,status,lock,unlock,properties,backlight,version}
                  ...

With no arguments, show session status.

positional arguments:
  {run,stop,status,lock,unlock,properties,backlight,version}
    run                 Run session
    stop                Stop the running session
    status              Show session status
    lock                Lock the session
    unlock              Unlock the session
    properties          List session properties
    backlight           Interact with backlights
    version             Show sessiond version

optional arguments:
  -h, --help            show this help message and exit
```

See [sessionctl(1)][2] for more information.

[2]: {{< ref "/man/sessionctl.1.md" >}}
