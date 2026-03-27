#!/bin/bash
#SBATCH --chdir=.
#SBATCH --cpus-per-task=10
#SBATCH --error=./stdeo/%x-%A.txt
#SBATCH --output=./stdeo/%x-%A.txt
#SBATCH --job-name=BME424-01_alignment
#SBATCH --mem=20G
#SBATCH --export=ALL
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=jwlee230@compbio.unist.ac.kr
# DO NOT MODIFY the above lines
/BiO/Share/Tools/bwa-0.7.18/bwa mem -M -t 10 -R '@RG\tID:NORMAL\tPL:ILLUMINA\tLB:NORMAL\tSM:NORMAL\tCN:UNIST' -v 3 /BiO/Share/Tools/gatk-bundle/hg38/Homo_sapiens_assembly38.fasta /BiO/Teach/BME42401/Data/NORMAL_R1.fastq.gz /BiO/Teach/BME42401/Data/NORMAL_R2.fastq.gz | /BiO/Share/Tools/samtools-1.21/samtools view --bam --with-header --threads 10 --reference /BiO/Share/Tools/gatk-bundle/hg38/Homo_sapiens_assembly38.fasta --output "$(realpath ./NORMAL.bam)"
/BiO/Share/Tools/samtools-1.21/samtools sort -l 9 --threads 10 --reference /BiO/Share/Tools/gatk-bundle/hg38/Homo_sapiens_assembly38.fasta --write-index -o NORMAL.Sort.bam NORMAL.bam
/BiO/Share/Tools/gatk-4.6.1.0/gatk MarkDuplicatesSpark --input NORMAL.Sort.bam --output NORMAL.Sort.MarkDuplicates.bam --reference /BiO/Share/Tools/gatk-bundle/hg38/Homo_sapiens_assembly38.fasta --metrics-file NORMAL.Sort.MarkDuplicates.metrics --duplicate-tagging-policy 'OpticalOnly' -- --spark-master 'local[10]' --spark-verbosity 'INFO'
/BiO/Share/Tools/gatk-4.6.1.0/gatk BaseRecalibrator --input NORMAL.Sort.MarkDuplicates.bam --reference /BiO/Share/Tools/gatk-bundle/hg38/Homo_sapiens_assembly38.fasta --output NORMAL.Sort.MarkDuplicates.BQSR.table --create-output-bam-index true --known-sites /BiO/Share/Tools/gatk-bundle/hg38/1000G_phase1.snps.high_confidence.hg38.vcf --known-sites /BiO/Share/Tools/gatk-bundle/hg38/1000G_omni2.5.hg38.vcf.gz --known-sites /BiO/Share/Tools/gatk-bundle/hg38/Homo_sapiens_assembly38.dbsnp138.vcf --known-sites /BiO/Share/Tools/gatk-bundle/hg38/Mills_and_1000G_gold_standard.indels.hg38.vcf
/BiO/Share/Tools/gatk-4.6.1.0/gatk ApplyBQSR --bqsr-recal-file NORMAL.Sort.MarkDuplicates.BQSR.table --input NORMAL.Sort.MarkDuplicates.bam --output NORMAL.Sort.MarkDuplicates.BQSR.bam --reference /BiO/Share/Tools/gatk-bundle/hg38/Homo_sapiens_assembly38.fasta --create-output-bam-index true

/BiO/Share/Tools/bwa-0.7.18/bwa mem -M -t 10 -R '@RG\tID:TUMOR\tPL:ILLUMINA\tLB:TUMOR\tSM:TUMOR\tCN:UNIST' -v 3 /BiO/Share/Tools/gatk-bundle/hg38/Homo_sapiens_assembly38.fasta /BiO/Teach/BME42401/Data/TUMOR_R1.fastq.gz /BiO/Teach/BME42401/Data/TUMOR_R2.fastq.gz | /BiO/Share/Tools/samtools-1.21/samtools view --bam --with-header --threads 10 --reference /BiO/Share/Tools/gatk-bundle/hg38/Homo_sapiens_assembly38.fasta --output "$(realpath ./TUMOR.bam)"
/BiO/Share/Tools/samtools-1.21/samtools sort -l 9 --threads 10 --reference /BiO/Share/Tools/gatk-bundle/hg38/Homo_sapiens_assembly38.fasta --write-index -o TUMOR.Sort.bam TUMOR.bam
/BiO/Share/Tools/gatk-4.6.1.0/gatk MarkDuplicatesSpark --input TUMOR.Sort.bam --output TUMOR.Sort.MarkDuplicates.bam --reference /BiO/Share/Tools/gatk-bundle/hg38/Homo_sapiens_assembly38.fasta --metrics-file TUMOR.Sort.MarkDuplicates.metrics --duplicate-tagging-policy 'OpticalOnly' -- --spark-master 'local[10]' --spark-verbosity 'INFO'
/BiO/Share/Tools/gatk-4.6.1.0/gatk BaseRecalibrator --input TUMOR.Sort.MarkDuplicates.bam --reference /BiO/Share/Tools/gatk-bundle/hg38/Homo_sapiens_assembly38.fasta --output TUMOR.Sort.MarkDuplicates.BQSR.table --create-output-bam-index true --known-sites /BiO/Share/Tools/gatk-bundle/hg38/1000G_phase1.snps.high_confidence.hg38.vcf --known-sites /BiO/Share/Tools/gatk-bundle/hg38/1000G_omni2.5.hg38.vcf.gz --known-sites /BiO/Share/Tools/gatk-bundle/hg38/Homo_sapiens_assembly38.dbsnp138.vcf --known-sites /BiO/Share/Tools/gatk-bundle/hg38/Mills_and_1000G_gold_standard.indels.hg38.vcf
/BiO/Share/Tools/gatk-4.6.1.0/gatk ApplyBQSR --bqsr-recal-file TUMOR.Sort.MarkDuplicates.BQSR.table --input TUMOR.Sort.MarkDuplicates.bam --output TUMOR.Sort.MarkDuplicates.BQSR.bam --reference /BiO/Share/Tools/gatk-bundle/hg38/Homo_sapiens_assembly38.fasta --create-output-bam-index true
