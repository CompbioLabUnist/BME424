#!/bin/bash
#SBATCH --chdir=.
#SBATCH --cpus-per-task=10
#SBATCH --error=./stdeo/%x-%A.txt
#SBATCH --output=./stdeo/%x-%A.txt
#SBATCH --job-name=BME424-00_form
#SBATCH --mem=20G
#SBATCH --export=ALL
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=jwlee230@compbio.unist.ac.kr
# DO NOT MODIFY the above lines
mkdir -p Rainfall
${HOME}/BME424/week05/bin/python3 ${HOME}/BME424/week05/05_3_draw_rainfall.py "$(realpath ./SAMPLE.PASS.vcf)" "$(realpath ./Rainfall)"
