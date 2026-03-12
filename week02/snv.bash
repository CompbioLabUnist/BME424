#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

python3 -B snv.py /BiO/Teach/BME42401/Data/PS-826-B_DNA_1.fastq.gz /BiO/Teach/BME42401/Data/PS-826-B_DNA_2.fastq.gz $(realpath .)
python3 -B snv.py /BiO/Teach/BME42401/Data/PS-826-T_DNA_1.fastq.gz /BiO/Teach/BME42401/Data/PS-826-T_DNA_2.fastq.gz $(realpath .)