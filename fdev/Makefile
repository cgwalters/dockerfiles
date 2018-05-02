PREFIX ?= cgwalters

f27-base:
	./build-base.sh registry.fedoraproject.org/fedora $(PREFIX)/fedora-dev 27
f27:
	./build.sh $(PREFIX)/fedora-dev 27
f27-all: f27-base f27

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
