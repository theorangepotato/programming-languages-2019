# LambdaNatInc

This is my way to build and run LambdaNat, using docker fully. [Here](https://apiumhub.com/tech-blog-barcelona/top-benefits-using-docker/)
are some reason to use it. A major advantage in this project is the fact that it only takes 2 command to build ans execute
the whole project respectively. I also use multi-stage builds to make workflow much smoother.

## Setup

- Install [Docker](https://docs.docker.com/install/). (On Windows make sure to run Linux containers)

- Enter this folder in terminal.

- Run `docker build . -t lambdanat`. (warning: may take a while since a lot has to be downloaded/built)

- Run `echo "\x.x" | docker run -i --rm lambdanat` to test that the setup is working.

## Run Only the Parser

The command `docker build . -t lambdaparse --target parser`
Can be used to only build up to the parser stage, see [Docker multi-stage builds](https://docs.docker.com/develop/develop-images/multistage-build/). Keep in mind that the image will now be tagged with `lambdaparse`,
 so an example command would have to be `echo "\x.x" | docker run -i --rm lambdanat` instead.

## Run a File

Easiest way to run a file is with `cat test/test-xxyz.lc | docker run -i --rm lambdaparse`.

## Debug

The following commands can help debugging issues when building.

`docker build . -t lambdanat --target=full` for stopping the build before discarding everything.

`docker run -it --rm lambdanat bash` to inspect the building stage. This can also be done for the parser stage.

## Migrating a New Project to This Build Setup

Given a preexisting LambdaNat project, this is all that should need to be done to use Docker.

- Copy over the `Dockerfile` into the root of the project.
- Copy the contents of `LambdaNat.cabal` into the project's Cabal file, or make it if it doesn't exist.
- Make sure the name of the grammar file is `LambdaNat.cf`, or change the Dockerfile to run a differently named one.

## Saving Image

Save the image with: `docker save lambdanat > lambdanat.tar`.

And import it with `docker load < lambdanat.tar` in the same directory as `lambdanat.tar`.

test
