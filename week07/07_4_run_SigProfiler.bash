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
SigProfilerPlotting plotSBS --savefig_format 'png' --dpi 600 "$(realpath ./output/SBS/week07.SBS96.exome)" "$(realpath Plot/)" 'week07' '96' && mv -v PlotSBS_96_plots_PS-826.png Plot/SBS_96_plots_PS-826.png
SigProfilerPlotting plotSBS --savefig_format 'png' --dpi 600 "$(realpath ./output/SBS/week07.SBS6.exome)" "$(realpath Plot/)" 'week07' '6'
SigProfilerPlotting plotDBS --savefig_format 'png' --dpi 600 "$(realpath ./output/DBS/week07.DBS78.exome)" "$(realpath Plot/)" 'week07' '78' && mv -v PlotDBS_78_plots_PS-826.png Plot/DBS_78_plots_PS-826.png
