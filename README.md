# [IceStorm](http://www.clifford.at/icestorm/) in a Docker container

For those who don't want to waste their time for compiling.

Contains the following components:

- [IceStorm tools](https://github.com/YosysHQ/icestorm)
- [NextPNR](https://github.com/YosysHQ/nextpnr)
- [Yosys](http://bygone.clairexen.net/yosys/)

## How to run?

The same way you run other Docker containers.
For example, if you want to run Yosys:

```bash
docker run --rm -it -v $PWD:/host -w host kovagoz/icestorm yosys
```

The command above mounts the current working directory to the container, so Yosys can access the files in it.

This projcect is based on [Dimitri del Marmol's work](https://github.com/ddm/icetools).
