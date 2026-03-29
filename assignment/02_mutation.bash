#!/bin/bash
#SBATCH --chdir=.
#SBATCH --cpus-per-task=10
#SBATCH --error=./stdeo/%x-%A.txt
#SBATCH --output=./stdeo/%x-%A.txt
#SBATCH --job-name=BME424-02_mutation
#SBATCH --mem=20G
#SBATCH --export=ALL
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=jwlee230@compbio.unist.ac.kr
# DO NOT MODIFY the above lines
/BiO/Share/Tools/gatk-4.6.1.0/gatk Mutect2 --java-options "-XX:+UseSerialGC -Xmx20g" --reference /BiO/Share/Tools/gatk-bundle/hg38/Homo_sapiens_assembly38.fasta --input "$(realpath ./NORMAL.Sort.MarkDuplicates.BQSR.bam)" --input "$(realpath ./TUMOR.Sort.MarkDuplicates.BQSR.bam)" --normal-sample NORMAL --output "$(realpath ./SAMPLE.vcf)" --native-pair-hmm-threads 10 --max-mnp-distance 0
/BiO/Share/Tools/gatk-4.6.1.0/gatk FilterMutectCalls --java-options "-XX:+UseSerialGC -Xmx20g" --reference /BiO/Share/Tools/gatk-bundle/hg38/Homo_sapiens_assembly38.fasta --variant "$(realpath ./SAMPLE.vcf)" --output "$(realpath ./SAMPLE.filter.vcf)"
/usr/bin/awk -F '\t' '{if($0 ~ /\#/) print; else if($7 == "PASS") print}' "$(realpath ./SAMPLE.filter.vcf)" > "(realpath ./SAMPLE.PASS.vcf)"
/BiO/Share/Tools/gatk-4.6.1.0/gatk IndexFeatureFile --java-options "-XX:+UseSerialGC -Xmx20g" --input /BiO/Live/jwlee230/BME424/week03/SAMPLE.PASS.vcf --output "$(realpath ./SAMPLE.PASS.vcf.idx)"
/usr/bin/perl /BiO/Share/Tools/vcf2maf-1.6.21/vcf2maf.pl --vep-path /BiO/Share/Tools/ensembl-vep-release-110.1/ --vep-data /BiO/Share/Tools/ensembl-vep-release-110.1/ --vep-forks 10 --ncbi-build 'GRCh38' --input-vcf "$(realpath ./SAMPLE.PASS.vcf)" --output "$(realpath ./SAMPLE.PASS.maf)" --tumor-id TUMOR --normal-id NORMAL --ref-fasta /BiO/Share/Tools/gatk-bundle/hg38/Homo_sapiens_assembly38.fasta --vep-overwrite
