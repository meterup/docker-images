build-latest:
	docker build -t meterup/ubuntu-golang:latest .

upload-latest:
	docker push meterup/ubuntu-golang:latest

build:
	docker build -t meterup/ubuntu-golang:1.12.7 .

upload:
	docker push meterup/ubuntu-golang:1.12.7

release: build upload
