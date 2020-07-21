docker-ubuntunovnc-3aSem
=======================

Docker image used for teaching in the "Software Science" 3rd year at [CentraleSupélec](http://www.centralesupelec.fr).

Available on [Docker hub](https://hub.docker.com/r/fredblgr/ubuntunovnc-3aSem)

Based on the work by [Doro Wu](https://github.com/fcwu), see on [Docker](https://hub.docker.com/r/dorowu/ubuntu-desktop-lxde-vnc/)

This image contains Isabelle 2020, the Coq IDE, and Why3 with various solvers

The source files are available on [GitHub](https://github.com/Frederic-Boulanger-UPS/docker-ubuntunovnc-3asem).

Typical usage is:

```
docker run --rm -d -p 6080:80 -v $PWD:/workspace:rw -e USER=username -e PASSWORD=password -e RESOLUTION=1680x1050 --name ubuntu3aSem-novnc fredblgr/ubuntunovnc-3aSem:2020
```

Very Quick Start
----------------
Run ```./start3Asl.sh```, you will have Ubuntu 20.04 in your browser, with the current working directory mounted on /workspace. The container will be removed when it stops, so save your work in /workspace if you want to keep it.

There is a ```start3Asl.ps1``` for the PowerShell of Windows. You may have to allow the execution of scripts with the command:

```Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser```.

Quick Start
-------------------------

Run the docker container and access with port `6080`

```
docker run -p 6080:80 fredblgr/ubuntunovnc-3aSem:2020
```

Browse http://127.0.0.1:6080/


Shared directory
----------------

The image is configured to make things easy if your working directory is shared on /workspace in the container:

```
docker run -p 6080:80 -v $PWD:/workspace:rw fredblgr/ubuntunovnc-3aSem:2020
```

For instance, Eclipse is configured to create workspaces in /workspace, and the file manager has a bookmark for /workspace.


HTTP Base Authentication
---------------------------

This image provides base access authentication of HTTP via `HTTP_PASSWORD`

```
docker run -p 6080:80 -e HTTP_PASSWORD=mypassword fredblgr/ubuntunovnc-3aSem:2020
```

Screen Resolution
------------------

The Resolution of virtual desktop adapts browser window size when first connecting the server. You may choose a fixed resolution by passing `RESOLUTION` environment variable, for example

```
docker run -p 6080:80 -e RESOLUTION=1920x1080 fredblgr/ubuntunovnc-3aSem:2020
```

Default Desktop User
--------------------

The default user is `root`. You may change the user and password respectively by `USER` and `PASSWORD` environment variable, for example,

```
docker run -p 6080:80 -e USER=name -e PASSWORD=password fredblgr/ubuntunovnc-3aSem:2020
```


License
==================

Apache License Version 2.0, January 2004 http://www.apache.org/licenses/LICENSE-2.0

Original work by [Doro Wu](https://github.com/fcwu)

Adapted by [Frédéric Boulanger](https://github.com/Frederic-Boulanger-UPS)
