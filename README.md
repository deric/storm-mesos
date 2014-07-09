# Storm-mesos

Storm framework for Mesos for running Storm in production. Currently includes several services:

   * `storm-mesos` - Nimbus (Mesos scheduler)
   * `storm-ui` - web interface (default port is `8080`)
   * `storm-drpc` - DRPC daemon
   * `storm-log` - service for displaying logs in web UI (fetching logs from computing nodes)

Note that Storm supervisor daemons are not needed as they are launched by Mesos.

## how to build

    $ ./bin/package --version 0.9.1-incubating

where specified version of `apache-storm` should exists on Storm website: e.g. http://www.us.apache.org/dist/incubator/storm/

eventually you can specify a patch version for package

    $ ./bin/package --version 0.9.1-incubating --patch "-p1"

Storm integration with the Mesos cluster resource manager. This runs in production within Twitter.

Prebuilt Storm/Mesos releases are available from the [downloads page](https://github.com/nathanmarz/storm-mesos/downloads).

To use a release, you first need to unpack the distribution, fill in configurations listed below into the conf/storm.yaml file, and then repack the distribution.

Be sure to use Mesos as of [this commit](https://github.com/apache/mesos/commit/caff34a67fd855067089f30f68e46e325659ad08), as prior versions of Mesos had some bugs.

Along with the Mesos master and Mesos cluster, you'll need to run the Storm master as well. Launch Nimbus with this command:

```
$ /etc/init.d/storm-mesos start
```
or using upstart on Ubuntu:
```
$ service storm-mesos start
```

It's recommended that you also run the UI on the same machine as Nimbus via the following command:

```
$ /etc/init.d/storm-ui start
```

for displaying nodes you will also need to start log service:
```
$ /etc/init.d/storm-log start
```




Topologies are submitted to a Storm/Mesos cluster the exact same way they are submitted to a regular Storm cluster.

Storm/Mesos provides resource isolation between topologies. So you don't need to worry about topologies interfering with one another.

## Mandatory configurations:

1. `mesos.executor.uri`: Once you fill in the configs and repack the distribution, you need to place the distribution somewhere where Mesos executors can find it. Typically this is on HDFS, and this config is the location of where you put the distibution.
2. `mesos.master.url`: URL for the Mesos master.
3. `java.library.path`: Needs the location of the ZeroMQ libs and the Mesos native libraries. The Storm/Mesos distribution comes with the native ZeroMQ libraries in the "native" folder (for Linux). This config is typically set to "native:{location of mesos native libs}"
4. `storm.zookeeper.servers`: The location of the Zookeeper servers to be used by the Storm master.
5. `nimbus.host`: The hostname of where you run Nimbus.

