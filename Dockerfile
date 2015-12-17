FROM debian:wheezy

MAINTAINER Jason Valdron <jason@valdron.ca>

# Add ffmpeg repo.
RUN echo "deb http://www.deb-multimedia.org wheezy main non-free" >> /etc/apt/sources.list && \
	apt-get update && \
	apt-get install deb-multimedia-keyring -y --force-yes

# Install motion and it's dependencies.
RUN apt-get update && apt-get install motion ffmpeg v4l-utils -y

# Install motioneye's dependencies.
RUN apt-get update && apt-get install python-pip python-dev libssl-dev libcurl4-openssl-dev libjpeg-dev -y

# Install motioneye.
RUN pip install motioneye

# Expose the config and storage volumes.
VOLUME ["/etc/motioneye", "/var/lib/motioneye"]

# Expose the default port of motioneye.
EXPOSE 8765

# Start up motioneye.
CMD ["/usr/local/bin/meyectl","startserver","-c /etc/motioneye/motioneye.conf"]
