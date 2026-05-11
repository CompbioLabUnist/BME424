#!/bin/bash
pip3 install --require-virtualenv --no-cache-dir --requirement "$(realpath ./09_2_requirements.txt)"
Rscript --vanilla -e 'install.packages("BiocManager", repos="https://cloud.r-project.org")' -e 'BiocManager::install("DNAcopy")'
