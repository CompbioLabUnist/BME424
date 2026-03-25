#!/bin/bash
#SBATCH --chdir=.
#SBATCH --cpus-per-task=10
#SBATCH --error=$HOME/BME424/assignment/stdeo/%x-%A.txt
#SBATCH --output=$HOME/BME424/assignment/stdeo/%x-%A.txt
#SBATCH --job-name=BME424-01_alignment
#SBATCH --mem=20G
#SBATCH --export=ALL
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=jwlee230@compbio.unist.ac.kr
# DO NOT MODIFY the above lines
/BiO/Share/Tools/bwa-0.7.18/bwa mem -M -t 10 -R '@RG\tID:NORMAL\tPL:ILLUMINA\tLB:NORMAL\tSM:NORMAL\tCN:UNIST' -v 3 /BiO/Share/Tools/gatk-bundle/hg38/Homo_sapiens_assembly38.fasta /BiO/Teach/BME42401/Data/NORMAL_R1.fastq.gz /BiO/Teach/BME42401/Data/NORMAL_R2.fastq.gz | /BiO/Share/Tools/samtools-1.21/samtools view --bam --with-header --threads 10 --reference /BiO/Share/Tools/gatk-bundle/hg38/Homo_sapiens_assembly38.fasta --output "$(realpath ./NORMAL.bam)"
/BiO/Share/Tools/bwa-0.7.18/bwa mem -M -t 10 -R '@RG\tID:TUMOR\tPL:ILLUMINA\tLB:TUMOR\tSM:TUMOR\tCN:UNIST' -v 3 /BiO/Share/Tools/gatk-bundle/hg38/Homo_sapiens_assembly38.fasta /BiO/Teach/BME42401/Data/TUMOR_R1.fastq.gz /BiO/Teach/BME42401/Data/TUMOR_R2.fastq.gz | /BiO/Share/Tools/samtools-1.21/samtools view --bam --with-header --threads 10 --reference /BiO/Share/Tools/gatk-bundle/hg38/Homo_sapiens_assembly38.fasta --output "$(realpath ./TUMOR.bam)"
