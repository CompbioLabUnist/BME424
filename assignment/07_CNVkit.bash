#!/bin/bash
#SBATCH --chdir=.
#SBATCH --cpus-per-task=10
#SBATCH --error=./stdeo/%x-%A.txt
#SBATCH --output=./stdeo/%x-%A.txt
#SBATCH --job-name=BME424-07_CNVkit
#SBATCH --mem=20G
#SBATCH --export=ALL
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=jwlee230@compbio.unist.ac.kr
# DO NOT MODIFY the above lines
"$(realpath ../week09/bin/cnvkit.py)" batch --processes 10 --normal "$(realpath ./NORMAL.Sort.MarkDuplicates.BQSR.bam)" --fasta "/BiO/Share/Tools/gatk-bundle/hg38/Homo_sapiens_assembly38.fasta" --targets "/BiO/Share/Database/UCSC/hg38/UCSC_hg38.bed" --annotate "/BiO/Share/Database/UCSC/hg38/refFlat.txt"  --scatter --diagram --output-dir "$(realpath .)" "$(realpath ./TUMOR.Sort.MarkDuplicates.BQSR.bam)"
grep --invert-match '_' "$(realpath ./TUMOR.Sort.MarkDuplicates.BQSR.cnr)" > "$(realpath TUMOR.cnr)"
"$(realpath ../week09/bin/cnvkit.py)" segment --output TUMOR.cns --processes 10 TUMOR.cnr
"$(realpath ../week09/bin/cnvkit.py)" diagram --segment TUMOR.cns --output Diagram.pdf TUMOR.cnr && pdftoppm Diagram.pdf Diagram.png -png
"$(realpath ../week09/bin/cnvkit.py)" scatter --segment TUMOR.cns --vcf "$(realpath ./SAMPLE.PASS.vcf)" --output Scatter.pdf TUMOR.cnr && pdftoppm Scatter.pdf Scatter -png
"$(realpath ../week09/bin/cnvkit.py)" heatmap --output Heatmap.pdf TUMOR.cns && pdftoppm Heatmap.pdf Heatmap -png
