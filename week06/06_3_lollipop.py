#!/usr/bin/env python3
import argparse
import os
import pandas
import tqdm


def parse_arguments():
    parser = argparse.ArgumentParser()

    parser.add_argument("input", help="Input MAF file")
    parser.add_argument("output", help="Output directory")
    parser.add_argument("--gene", help="Select gene name(s)", nargs="+")

    return parser.parse_args()


def main():
    args = parse_arguments()

    input_data = pandas.read_csv(args.input, sep="\t", comment="#")
    print(input_data)

    for gene in tqdm.tqdm(args.gene):
        print(gene)
        gene_data = input_data[(input_data["Hugo_Symbol"] == gene) & ~(input_data["HGVSp_Short"].isna())]

        if gene_data.empty:
            print(f"{gene} has no mutations!!")
            continue

        proteins = ""
        for _, row in gene_data.iterrows():
            proteins += f"{row['HGVSp_Short'][2:]} "

        os.system(f"/BiO/Share/Tools/lollipops -legend -labels -o {args.output}/{gene}.png -dpi=600 -show-motifs {gene} {proteins}")

if __name__ == "__main__":
    main()
