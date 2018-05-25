PREFIX ?= cgwalters

f27-base:
	./build-base.sh registry.fedoraproject.org/fedora:27 $(PREFIX)/fedora-dev 27
f27:
	./build.sh $(PREFIX)/fedora-dev 27
f27-all: f27-base f27

f28-base:
	./build-base.sh registry.fedoraproject.org/fedora:28 $(PREFIX)/fedora-dev 28
f28:
	./build.sh $(PREFIX)/fedora-dev 28
f28-all: f28-base f28

rawhide-base:
	./build-base.sh registry.fedoraproject.org/fedora $(PREFIX)/fedora-dev rawhide
rawhide:
	./build.sh $(PREFIX)/fedora-dev rawhide
rawhide-all: rawhide-base rawhide

c7-base:
	./build-base.sh registry.centos.org/centos/centos:7 $(PREFIX)/centos-dev 7
c7:
	./build.sh $(PREFIX)/centos-dev 7
c7-all: c7-base c7

r7-base:
	./build-base.sh registry.access.redhat.com/rhel7 $(PREFIX)/rhel-dev 7
r7:
	./build.sh $(PREFIX)/rhel-dev 7
r7-all: r7-base r7

r8-base:
	./build-base.sh docker-registry.engineering.redhat.com/rhel-appstream/rhel8 $(PREFIX)/rhel-dev 8
r8:
	./build.sh $(PREFIX)/rhel-dev 8
r8-all: r8-base r8
