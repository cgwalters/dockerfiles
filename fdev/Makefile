all: build-base build

build-base:
	sudo docker build -t cgwalters/fdev-base -f Dockerfile.base .

build:
	sudo docker build -t cgwalters/fdev -f Dockerfile .

.NOTPARALLEL:
