# docker-base
Currently, it's pretty confusing to configure users inside containers : processes in containers are running as Root user, 
if I'm using volumes I can't edit generated files from them with my local user, It's pretty hard to keep in mind who is my local user in my containers, etc .
The goal is too ease the user management with commands.

## How does it work ?
By default, docker-base creates a user named `docker` with uid=1000 and gid=1000 using `gosu` ([Documentation](https://github.com/tianon/gosu)).

If you mount a volume in the current workspace (`WORKDIR` docker's instruction), the `docker` user will change its uid and gid by the local one. 
In this case, you could share the same user, the same UID and GID, inside and outside your container with the same permission.

Now, you've to use the `docker` user for your usage inside containers. 

### Without volume
```console
anthonykgross$ id
uid=501(anthonykgross) gid=20(staff) groups=20(staff)
anthonykgross$ docker run -ti anthonykgross/docker-base:latest bash
$ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
User      : uid=0(root) gid=0(root) groups=0(root)
Workspace : uid=0(root) gid=0(root)

[ WARNING ] You're root ! Use 'gosu' to change

Documentation : https://github.com/anthonykgross/docker-base/tree/master
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
root@dcd22da86a9c:/src# gosu docker bash
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
User      : uid=1000(docker) gid=1000(docker) groups=1000(docker)
Workspace : uid=0(root) gid=0(root)

Documentation : https://github.com/anthonykgross/docker-base/tree/master
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
docker@dcd22da86a9c:/src$
```
_Note_ : In this case, you've an **non-root** useful to run commands like Composer, etc. 

### With volume (On Mac OSX)
```console
anthonykgross$ id
uid=501(anthonykgross) gid=20(staff) groups=20(staff)
anthonykgross$ docker run -v $PWD:/src -ti anthonykgross/docker-base:latest bash
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
User      : uid=0(root) gid=0(root) groups=0(root)
Workspace : uid=1000(docker) gid=50(staff)

[ WARNING ] You're root ! Use 'gosu' to change

Documentation : https://github.com/anthonykgross/docker-base/tree/master
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
root@dcd22da86a9c:/src# gosu docker bash
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
User      : uid=1000(docker) gid=50(staff) groups=50(staff)
Workspace : uid=1000(docker) gid=50(staff)

Documentation : https://github.com/anthonykgross/docker-base/tree/master
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
docker@dcd22da86a9c:/src$
```
_Note_ : On Mac OSX, Docker using VirtualBox. The UID 501 is UID 1000 in the VM automatically.

## Creator
**Anthony K GROSS*
- <http://anthonykgross.fr>
- <https://twitter.com/anthonykgross>
- <https://github.com/anthonykgross>

## Copyright and license
Code and documentation copyright 2017. Code released under [the MIT license](https://github.com/anthonykgross/docker-base/blob/master/LICENSE).