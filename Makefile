build-latest:
	docker build -t meterup/ubuntu-golang:latest .

release:
	docker build -t meterup/ubuntu-golang:1.12.7 .
