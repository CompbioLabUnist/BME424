#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

python3 -B mutect.py $(realpath ../week02/PS-826-B_DNA.Sort.MarkDuplicates.BQSR.bam) $(realpath ../week02/PS-826-T_DNA.Sort.MarkDuplicates.BQSR.bam) PS-826.maf
