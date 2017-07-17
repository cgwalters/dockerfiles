all: build-base build

build-base:
	sudo docker build -t cgwalters/r7dev-base -f Dockerfile.base .

build:
	sudo docker build -t cgwalters/r7dev -f Dockerfile .

.NOTPARALLEL:
