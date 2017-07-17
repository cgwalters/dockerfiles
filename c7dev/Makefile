all: build-base build

build-base:
	sudo docker build -t cgwalters/c7dev-base -f Dockerfile.base .

build:
	sudo docker build -t cgwalters/c7dev -f Dockerfile .

.NOTPARALLEL:
