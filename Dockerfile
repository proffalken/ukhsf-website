FROM python:3.7-alpine AS base
WORKDIR /usr/src/app

RUN pip install --no-cache-dir pipenv \
    && apk add --no-cache postgresql-client

# We need a build environment for some of our python dependencies.
# This mess is mostly from the upstream python-alpine dockerfile.
RUN apk add --no-cache --virtual .build-deps  \
		bzip2-dev \
		coreutils \
		dpkg-dev dpkg \
		expat-dev \
		findutils \
		gcc \
		gdbm-dev \
		libc-dev \
		libffi-dev \
		libnsl-dev \
		libressl-dev \
		libtirpc-dev \
		linux-headers \
		make \
		ncurses-dev \
		pax-utils \
		readline-dev \
		sqlite-dev \
		tcl-dev \
		tk \
		tk-dev \
		util-linux-dev \
		xz-dev \
		zlib-dev \
		postgresql-dev

COPY Pipfile ./
COPY Pipfile.lock ./
RUN pipenv sync --dev

EXPOSE 8000
ENTRYPOINT ["pipenv", "run"]
CMD ["./docker/start_dev.sh"]
