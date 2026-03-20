#!/bin/bash
#SBATCH --chdir=.
#SBATCH --cpus-per-task=10
#SBATCH --error=$HOME/BME424/assignment/stdeo/%x-%A.txt
#SBATCH --output=$HOME/BME424/assignment/stdeo/%x-%A.txt
#SBATCH --job-name=BME424-00_form
#SBATCH --mem=20G
#SBATCH --export=ALL
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=jwlee230@compbio.unist.ac.kr
# DO NOT MODIFY the above lines
echo "$USER"
