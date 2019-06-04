# Example of reproducible genomics data analysis

This repository is an example of genomics data analysis with reproducibility in mind.
It can be used as starting point.
The sections belows presents best practices to make your data analysis more reproducible.

## Download files

Write a Bash script that downloads any resource files, such as reference genomes and databases, to documentent file versions and locations.
Also, it automates analysis environment preparation.

## Workflow and input files

Provide files decribing data processing workflows ([WDL](http://www.openwdl.org), [CWL](https://www.commonwl.org), [Nextflow](https://www.nextflow.io)) and input files (normally JSON).
In this example we use QA workflow available at <https://github.com/labbcb/workflows> version 1.1.0.
Provide the command to execute the workflow.

```bash
java -jar cromwell.jar run --inputs qa.inputs.json qa.wdl
```

## Docker image for data analysis

Use [rocker](https://hub.docker.com/u/rocker) or [Bioconductor](http://bioconductor.org/help/docker/) as base images to make your own Docker image containing all required packages and software libraries to run data analysis.
*Do not add data file to Docker image*.
Tag your Docker image according to your analysis version.

Build Docker image:

```bash
docker build docker -t welliton/reproducible-analysis:1.0.0
```

Run RStudio:

```bash
docker run --volume $PWD:$PWD --publish 8787:8787 welliton/reproducible-analysis:1.0.0
```

## Versioning

Use [semantic versioning](https://semver.org) and GitHub releases.
For example, `x.y.z`, where:

- `x` major version of data analysis. Change only some software is replaced such as sequence aligner.
- `y` minor version. Change when some software is updated to newer version.
- `z` patch version. Change when you have found some bug or typos.

## Licencing

Repository are meant to be **private** until paper describing the analysis is published.
