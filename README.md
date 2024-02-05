# (Archived) poc.workflow.pacta.ctm

**This project has been archived, as a proof of concept that worked in theory, but the team decided to take an alternate path.**

[![Project Status: Abandoned – Initial development has started, but there has not yet been a stable, usable release; the project has been abandoned and the author(s) do not intend on continuing development.](https://www.repostatus.org/badges/latest/abandoned.svg)](https://www.repostatus.org/#abandoned)

**This repo is a Proof of concept**.

This repo defines a Dockerfile and translation code to extend `workflow.pacta.report` to match the invokation logic for `workflow.transition.monitor`, in hopes that we can support a single docker stack.

```sh

docker build . -t fakectm

docker run -it --rm \
  --network none \
  --platform linux/amd64 \
  --env LOG_LEVEL=TRACE \
  --mount type=bind,source=./working_dir,target=/bound/working_dir \
  fakectm /bound/bin/run-r-scripts "1234"


```
  --mount type=bind,readonly,source=${data_dir},target=/pacta-data \
