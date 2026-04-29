#!/bin/bash
rm -rfv ./lib/python3.10/site-packages/SigProfilerMatrixGenerator/references/*
ln -sfv /BiO/Teach/Standard-Pipeline/08_Mutational_signatures/lib/python3.10/site-packages/SigProfilerMatrixGenerator/references/* "$(realpath ./lib/python3.10/site-packages/SigProfilerMatrixGenerator/references)"
rm -rfv "$(realpath ./input)" && mkdir input
ln -sfv "$(realpath ../week03/PS-826.PASS.vcf)" "$(realpath input)"
