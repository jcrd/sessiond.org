---
title: Overview
---

sessiond is a standalone X session manager that reports the idle status of a
graphical session to **systemd-logind**. It can be used alongside a window
manager or desktop environment that does not provide its own session management.

## Features

* automatic screen locking on session idle and before sleeping
* automatic backlight dimming on session idle
* systemd targets activated by systemd-logind's lock, unlock, sleep,
  and shutdown signals
* hooks triggered by inactivity or signals
* a DBus service
* (optional) management of DPMS settings

{{< button size="large" relref="/getting-started" >}}Get started{{< /button >}}
