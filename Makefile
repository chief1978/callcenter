#!make

all: venv config build run

clean:
    @docker-compose down

venv:
    ifeq ($(OS),Windows_NT)
		python -m venv venv
		( \
			source venv/Scripts/activate; \
			pip install -r requirements.txt; \
		)
    else
		python3 -m venv venv
		( \
			source venv/bin/activate; \
			pip3 install -r requirements.txt; \
		)
    endif

config:
    ifeq ($(OS),Windows_NT)
		@venv/Scripts/python configure.py
    else
		@venv/bin/python3 configure.py
    endif

build:
    @docker-compose build

run:
    @docker-compose up -d

db_init:
    @echo post
