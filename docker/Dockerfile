FROM bioconductor/bioconductor_docker:RELEASE_3_12

RUN install2.r tidyverse

ADD install_packages.R .
RUN R -f install_packages.R