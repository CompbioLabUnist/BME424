#!/bin/bash
#SBATCH --chdir=.
#SBATCH --cpus-per-task=10
#SBATCH --error=%x-%A.txt
#SBATCH --output=%x-%A.txt
#SBATCH --job-name=BME424-week07
#SBATCH --mem=20G
#SBATCH --export=ALL
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=jwlee230@compbio.unist.ac.kr
# DO NOT MODIFY the above lines
SigProfilerMatrixGenerator matrix_generator --exome --output_directory "$(realpath .)" Signatures 'GRCh38' "$(realpath .)"
SigProfilerExtractor sigprofilerextractor --reference_genome 'GRCh38' --exome --cpu 10 --assignment_cpu 10 'vcf' "$(realpath .)" "$(realpath .)"
rm -rfv "$(realpath Plot)"
SigProfilerPlotting plotSBS --savefig_format 'png' --dpi 600 "$(realpath ./output/SBS/PS-826.SBS96.exome)" "$(realpath Plot)" 'PS-826' '96'
SigProfilerPlotting plotSBS --savefig_format 'png' --dpi 600 "$(realpath ./output/SBS/PS-826.SBS6.exome)" "$(realpath Plot)" 'PS-826' '6'
SigProfilerPlotting plotDBS --savefig_format 'png' --dpi 600 "$(realpath ./output/DBS/PS-826.DBS78.exome)" "$(realpath Plot)" 'PS-826' '78'
