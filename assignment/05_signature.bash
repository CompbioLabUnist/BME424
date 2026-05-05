#!/bin/bash
#SBATCH --chdir=.
#SBATCH --cpus-per-task=10
#SBATCH --error=./stdeo/%x-%A.txt
#SBATCH --output=./stdeo/%x-%A.txt
#SBATCH --job-name=BME424-05_signature
#SBATCH --mem=20G
#SBATCH --export=ALL
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=jwlee230@compbio.unist.ac.kr
# DO NOT MODIFY the above lines
rm -rfv input && mkdir -p input && ln -sfv "$(realpath ./SAMPLE.PASS.vcf)" "$(realpath input)"
"$(realpath ../week07/bin/SigProfilerMatrixGenerator)" matrix_generator --exome --output_directory "$(realpath .)"  Signatures 'GRCh38' "$(realpath .)"
"$(realpath ../week07/bin/SigProfilerExtractor)" sigprofilerextractor --reference_genome 'GRCh38' --exome --cpu 10 --assignment_cpu 10 'vcf' "$(realpath .)" "$(realpath .)"

rm -rfv "$(realpath Plot)"
"$(realpath ../week07/bin/SigProfilerPlotting)" plotSBS --savefig_format 'png' --dpi 600 "$(realpath ./output/SBS/assignment.SBS96.exome)" "$(realpath Plot/)" 'assignment' '96' && mv -v PlotSBS_96_plots_SAMPLE.png Plot/SBS_96_plots_SAMPLE.png
"$(realpath ../week07/bin/SigProfilerPlotting)" plotSBS --savefig_format 'png' --dpi 600 "$(realpath ./output/SBS/assignment.SBS6.exome)" "$(realpath Plot/)" 'assignment' '6'
"$(realpath ../week07/bin/SigProfilerPlotting)" plotDBS --savefig_format 'png' --dpi 600 "$(realpath ./output/DBS/assignment.DBS78.exome)" "$(realpath Plot/)" 'assignment' '78' && mv -v PlotDBS_78_plots_SAMPLE.png Plot/DBS_78_plots_SAMPLE.png
