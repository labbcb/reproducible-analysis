# Example of reproducible genomics data analysis

This repository is an example of genomics data analysis with *open science* in mind.
It can be used as starting point.
The sections belows presents best practices to make your data analysis more reproducible.

## Download files

Write a Bash script that downloads any resource files, such as reference genomes and databases, to documentent file versions and locations.
Also, it automates analysis environment preparation.

```bash
bash download_files.sh
```

## Workflow and input files

Provide files decribing data processing workflows ([WDL](http://www.openwdl.org), [CWL](https://www.commonwl.org), [Nextflow](https://www.nextflow.io)) and input files (normally JSON).
In this example we use QA workflow available at <https://github.com/labbcb/workflows> version 1.1.0.
Provide the command to execute the workflow.

```bash
wget https://raw.githubusercontent.com/labbcb/workflows/master/workflows/qa/1.1/qa.wdl
wget -O cromwell.jar https://github.com/broadinstitute/cromwell/releases/download/42/cromwell-42.jar
java -jar cromwell.jar run --options options.json --inputs qa.inputs.json qa.wdl
```

> Replace `run` subcommand with `submit --host http://server:8000` to submit to Cromwell Server.

## Ignored files

Use `.gitignore` file to skip downloaded or generated files that you do not want to share.
Examples: input data, Cromwell and temporary files.

## Docker image for data analysis

Use [rocker](https://hub.docker.com/u/rocker) or [Bioconductor](https://bioconductor.org/help/docker/) as base images to make your own Docker image containing all required packages and software libraries to run data analysis.
Keep Docker-related files separated from other files to reduce [Docker build context](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#understand-build-context).
*Do not add data file to Docker image*.
Tag your Docker image according to your analysis version.

Build Docker image:

```bash
docker build -t reproducible-analysis:1.1.0 docker
```

Run RStudio:

```bash
docker container run \
  --rm \
  --detach \
  -e DISABLE_AUTH=true \
  --volume $PWD:/home/rstudio \
  --publish 8787:8787 \
  -e USERID=`id -u` \
  -e GROUPID=`id -g`\
  reproducible-analysis:1.1.0
```

> Replace `-e DISABLE_AUTH=true` with `-e PASSWORD=secret` to set a password.

Compile RMarkdown file without running RStudio:

```bash
docker container run \
  --rm \
  --volume $PWD:/home/rstudio \
  --user `id -u`:`id -g` \
  -w /home/rstudio \
  reproducible-analysis:1.1.0 \
  R -e "rmarkdown::render('data-analysis.Rmd')"
```

## Versioning

Use [semantic versioning](https://semver.org) and GitHub releases.
For example, `x.y.z`, where:

- `x` major version of data analysis. Change only some software is replaced such as sequence aligner.
- `y` minor version. Change when some software is updated to newer version.
- `z` patch version. Change when you have found some bug or typos.

## Data sharing

Data should be publish to public repository, such as [NCBI GEO](https://www.ncbi.nlm.nih.gov/geo/) and [NCBI](https://www.ncbi.nlm.nih.gov/sra), according to the type of data.

## Licencing

Repository are meant to be **private** until paper describing the analysis is published.
