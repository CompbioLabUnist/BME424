#!/bin/bash
/usr/bin/awk -F '	' '{if($0 ~ /\#/) print; else if($7 == "PASS") print}' /BiO/Live/jwlee230/BME424/week03/PS-826.filter.vcf > /BiO/Live/jwlee230/BME424/week03/PS-826.PASS.vcf