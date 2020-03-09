build-scratch:
	docker build .

build-latest:
	docker build -t meterup/ubuntu-ruby:latest -f Dockerfile ../

upload-latest:
	docker push meterup/ubuntu-ruby:latest

build:
	docker build -t meterup/ubuntu-ruby:2.7.0 -f Dockerfile ../

upload:
	docker push meterup/ubuntu-ruby:2.7.0
