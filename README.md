### docker-motioneye
A debian based Dockerfile which grabs the latest version of Motioneye 
from Git.

#### Building the image
Clone this repo and then build like so:

```bash
git clone https://github.com/jValdron/docker-motioneye.git
docker built -t motioneye .		# or any other name than motioneye
```

#### Creating a new container
Spin up a new container like so:

```bash
docker run -d \
	-p 1234:8765 \
	-v /local_storage:/var/lib/motioneye \
	-v /etc/motioneye:/etc/motioneye \
	--name motioneye \
	--restart=always \
	motioneye
```

Forward the port to whichever port you'd like, in this example we're using 1234.
You can then access motioneye from http://localhost:1234. The default
credentials are *admin* for the username with a blank password.

Whenever you want to update to the latest version of motioneye, you can 
just delete the image using `docker rmi motioneye` and then rebuild it 
using `--nocache` to update packages.

##### Running behind a reverse proxy (or overriding any other settings)
If you want to run motioneye behind a reverse proxy, you need to override 
the default settings.py file. To do so, copy the [latest settings.py]
(https://github.com/ccrisan/motioneye/blob/master/motioneye/settings.py)
to a path on your machine. Personally I have it at /etc/motioneye/settings.py.
Once you have it on your machine, edit the BASE_PATH (or any other settings 
for that matter), and then create a new container while overriding the 
settings.py file like so:

```bash
docker run -d \
        -p 80:8765 \
        -v /local_storage:/var/lib/motioneye \
        -v /etc/motioneye:/etc/motioneye \
	-v /etc/motioneye/settings.py:/usr/local/lib/python2.7/dist-packages/motioneye/settings.py \
        --name motioneye \
        --restart=always \
        motioneye
```



