#!/usr/bin/env bash

mkdir data
cd data
wget \
  https://github.com/Bioconductor/ShortRead/raw/master/inst/extdata/E-MTAB-1147/ERR127302_1_subset.fastq.gz \
  https://github.com/Bioconductor/ShortRead/raw/master/inst/extdata/E-MTAB-1147/ERR127302_2_subset.fastq.gz