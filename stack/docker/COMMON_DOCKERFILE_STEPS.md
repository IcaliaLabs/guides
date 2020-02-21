# Dockerfiles: Common Dockerfile tasks

The purpose of this guide is to have a library on how do we implement tasks for
stuff we use on all of our Dockerfiles.

Also, since we also use Alpine Linux for some of our projects, we'll have two
versions to accomplish each step.

## Create the development user:

We use a "development" user when we need to run scripts and commands inside the
container that will generate code (i.e. `rails g scaffold`). This way, we ensure
the resulting files are owned by the developer user - instead of root - when
working on a Linux host.

Sometimes the docker image will have a user with the same user id as the host's user, so
we will use `getent passwd "${DEVELOPER_UID}"` command to prevent the user creation in case
it already exists.

Given we have the following arguments - notice that there are defaults for these
arguments:

```Dockerfile
ARG DEVELOPER_UID=1000
ARG DEVELOPER_USERNAME=developer
# We'll persist the Developer UID variable:
ENV DEVELOPER_UID=${DEVELOPER_UID}
```

On alpine, we use `adduser`:

```Dockerfile
RUN getent passwd "${DEVELOPER_UID}" || \
  adduser -D -H -u ${DEVELOPER_UID} -h /usr/src -g "Developer User,,," ${DEVELOPER_USERNAME}
```

On debian, we use `useradd` - notice the difference in the option flags:

```Dockerfile
RUN getent passwd "${DEVELOPER_UID}" || \
  useradd -r -M -u ${DEVELOPER_UID} -d /usr/src -c "Developer User,,," ${DEVELOPER_USERNAME}
```


## Adding su-exec

We use `su-exec` to scale down from root to a user, specially where we need to
run the container as root, but expose a service for which we need to invoke
the executable as a user.

It's easy to install on Alpine Linux via `apk` on a "runtime stage":

```Dockerfile
# Add the package at the "runtime" stage: ======================================
RUN apk add --no-cache su-exec
```

However, since there are no pre-built binaries for Debian, we should compile it
in the "development" stage, and copy the executable at the "release" stage.
(It requires the `build-essential` package, which should be installed in a
 previous step)

```Dockerfile
# Build the executable in the "development" stage: =============================

RUN curl -o /usr/local/bin/su-exec.c https://raw.githubusercontent.com/ncopa/su-exec/master/su-exec.c \
 && gcc -Wall /usr/local/bin/su-exec.c -o/usr/local/bin/su-exec \
 && chown root:root /usr/local/bin/su-exec \
 && chmod 0755 /usr/local/bin/su-exec \
 && rm /usr/local/bin/su-exec.c

# Copy the executable in the "release" stage: ==================================

COPY --from=development /usr/local/bin/su-exec /usr/local/bin/su-exec
```

## Installing Chromium from prebuilt binaries

There's a bit of a problem keeping everything working when some browser
automation libraries and frameworks - such as pupeteer, capybara, etc - require
a specific version of Chromium to work properly. If Chromium gets installed via
`apt` or `apk`, the Chromium version may get updated without us noticing, and
tests may break - it has happened before!

The only way we've found to lock down the Chromium version is to download and
use prebuilt Chromium binaries... but we need to install the chromium
dependencies ourselves.

### 1: Downloading prebuilt Chromium

This works the same for both Alpine & Debian (you'll need the `unzip` package):

```Dockerfile
# Step XX: Fetch the pre-built specific version of Chromium & Chromedriver:
# NOTE: In case your'e using "puppeteer", check the "puppeteer.chrome_revision"
# key at puppeteer's package.json to check which chromium build number is
# compatible with your project's puppeteer version:
RUN export CHROMIUM_BUILD_NUMBER=722234 \
 && mkdir -p /tmp/chromium \
 && cd /tmp/chromium \
 && for FILE in chrome-linux.zip chromedriver_linux64.zip; do \
      # Use wget -O ${FILE} on alpine!
      curl --progress-bar --location --output $FILE \ 
      "http://commondatastorage.googleapis.com/chromium-browser-snapshots/Linux_x64/${CHROMIUM_BUILD_NUMBER}/${FILE}" ; \
      unzip ${FILE} -d /opt ; \
    done \
 && ln -s /opt/chrome-linux/chrome /usr/bin/chromium \
 && ln -s /opt/chromedriver_linux64/chromedriver /usr/bin/chromedriver \
 && cd ${HOME} \
 && rm -rf /tmp/chromium
```

### 2: Installing the dependencies

Instead of adding an ultra-long list of dependencies, I prefer to ask `apt`
or `apk` for the dependency list instead, and then install them at once

On Alpine it's easy:

```Dockerfile
RUN apk add --no-cache $(apk info --no-cache --depends --quiet chromium)
```

On Debian, it's not difficult:

```Dockerfile
RUN apt-get update && apt-get install -y  \
    $(apt-cache depends \
      -o APT::Cache::ShowOnlyFirstOr=true \
      --no-pre-depends \
      --no-breaks \
      --no-conflicts \
      --no-recommends \
      --no-suggests \
      --no-replaces \
      --no-enhances \
      --important chromium | grep "^\w" | sort -u) && \
    rm -rf /var/lib/apt/lists/*
```

## Installing dockerize

[`dockerize`](https://github.com/jwilder/dockerize) is an "utility to simplify running applications in docker containers". Our main use case in at development stage to wait until a newly created service - such as postgres or elasticsearch - is accepting connections.

We use a combination of `curl`/`wget` + `tar`, depending on the base:

On alpine:

```Dockerfile
RUN wget -O - \
  https://github.com/jwilder/dockerize/releases/download/v0.6.1/dockerize-linux-amd64-v0.6.1.tar.gz \
  | tar -C /usr/local/bin -xz
```

On Debian:

```Dockerfile
RUN curl -L \
    https://github.com/jwilder/dockerize/releases/download/v0.6.1/dockerize-linux-amd64-v0.6.1.tar.gz \
    | tar -C /usr/local/bin -xz
```
