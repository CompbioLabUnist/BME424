#!/bin/bash
#SBATCH --chdir=.
#SBATCH --cpus-per-task=10
#SBATCH --error=./stdeo/%x-%A.txt
#SBATCH --output=./stdeo/%x-%A.txt
#SBATCH --job-name=BME424-06_PureCN
#SBATCH --mem=20G
#SBATCH --export=ALL
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=jwlee230@compbio.unist.ac.kr
# DO NOT MODIFY the above lines
"$(realpath ../week08/conda/bin/Rscript)" --vanilla "$(realpath ../week08/conda/lib/R/library/PureCN/extdata/IntervalFile.R)" --in-file "/BiO/Share/Tools/gatk-bundle/hg38/Illumina_Exome_TargetedRegions_v1.2.hg38.bed" --fasta "/BiO/Share/Tools/gatk-bundle/hg38/Homo_sapiens_assembly38.fasta" --genome 'hg38' --out-file "$(realpath ./baits_hg38_intervals.txt)" --force

"$(realpath ../week08/conda/bin/Rscript)" --vanilla "$(realpath ../week08/conda/lib/R/library/PureCN/extdata/Coverage.R)" --bam "$(realpath ./NORMAL.Sort.MarkDuplicates.BQSR.bam)" --intervals "$(realpath ./baits_hg38_intervals.txt)" --keep-duplicates --out-dir "$(realpath .)" --cores 10 --seed 123 --force
"$(realpath ../week08/conda/bin/Rscript)" --vanilla "$(realpath ../week08/conda/lib/R/library/PureCN/extdata/Coverage.R)" --bam "$(realpath ./TUMOR.Sort.MarkDuplicates.BQSR.bam)" --intervals "$(realpath ./baits_hg38_intervals.txt)" --keep-duplicates --out-dir "$(realpath .)" --cores 10 --seed 123 --force

"$(realpath ../week08/conda/bin/Rscript)" --vanilla "$(realpath ../week08/conda/lib/R/library/PureCN/extdata/PureCN.R)" --sampleid "SAMPLE" --normal "$(realpath ./NORMAL.Sort.MarkDuplicates.BQSR_coverage_loess.txt.gz)" --tumor "$(realpath ./TUMOR.Sort.MarkDuplicates.BQSR_coverage_loess.txt.gz)" --genome 'hg38' --intervals "$(realpath ./baits_hg38_intervals.txt)" --post-optimize --out "$(realpath .)" --seed 123 --parallel --cores 10 --force
