## 1.启动，暂停虚拟机

*class* `openstack.compute.v2._proxy.``Proxy`(*session*, *statsd_client=None*, *statsd_prefix=None*, *prometheus_counter=None*, *prometheus_histogram=None*, *influxdb_config=None*, *influxdb_client=None*, **args*, ***kwargs*)

- `reboot_server`(*server*, *reboot_type*)

  Reboot a serverParameters**server** – Either the ID of a server or a [`Server`](https://docs.openstack.org/openstacksdk/latest/user/resources/compute/v2/server.html#openstack.compute.v2.server.Server) instance.**reboot_type** (*str*) – The type of reboot to perform. “HARD” and “SOFT” are the current options.ReturnsNone

- `pause_server`(*server*)

  Pauses a server and changes its status to `PAUSED`.Parameters**server** – Either the ID of a server or a [`Server`](https://docs.openstack.org/openstacksdk/latest/user/resources/compute/v2/server.html#openstack.compute.v2.server.Server) instance.ReturnsNone

- `unpause_server`(*server*)

  Unpauses a paused server and changes its status to `ACTIVE`.Parameters**server** – Either the ID of a server or a [`Server`](https://docs.openstack.org/openstacksdk/latest/user/resources/compute/v2/server.html#openstack.compute.v2.server.Server) instance.ReturnsNone

- `suspend_server`(*server*)

  Suspends a server and changes its status to `SUSPENDED`.Parameters**server** – Either the ID of a server or a [`Server`](https://docs.openstack.org/openstacksdk/latest/user/resources/compute/v2/server.html#openstack.compute.v2.server.Server) instance.ReturnsNone

- `resume_server`(*server*)

  Resumes a suspended server and changes its status to `ACTIVE`.Parameters**server** – Either the ID of a server or a [`Server`](https://docs.openstack.org/openstacksdk/latest/user/resources/compute/v2/server.html#openstack.compute.v2.server.Server) instance.ReturnsNone