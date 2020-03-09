build-scratch:
	docker build .

build-latest:
	docker build -t meterup/ubuntu-golang:latest -f Dockerfile ../

upload-latest:
	docker push meterup/ubuntu-golang:latest

build:
	docker build -t meterup/ubuntu-golang:1.14 -f Dockerfile ../

upload:
	docker push meterup/ubuntu-golang:1.14

release: build upload
