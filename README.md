# LD-decay-calculating
## Directions
### The first Method for Haploview outputs
- Using the [Haploview](https://www.broadinstitute.org/haploview/downloads) tool change vcf format file into the ped and info file .

__example__:
```
vcftools --gzvcf test.vcf.gz  --plink --out HH

plink --file test --recode HV --out test

java -jar ~/biosoftware/Haploview.jar -n -pedfile example.ped -info example.info \
-maxdistance 1000 -minMAF 0.05 -hwcutoff 0 -dprime -memory 4096 -out test
```

- Then use the R script called from the command line to caculate the average LD values in each bin for the LD zone.

```
   Rscript LD_decay_calculating_for_Haploview.R -i input.file -l 100000 -b 10000 -o output.file
```


### The second Method for vcftools outputs

- Using the [vcftools](http://vcftools.sourceforge.net/man_latest.html) to caculate the LD values .

```
vcftools --vcf test.vcf --geno-r2 --ld-window-bp 100000 --out ld_window_100000 --min-r2 0.000001

awk '{if($1=="CHR"){print $0"\tDISTENCE"}else{print $0"\t"$3-$2}}' ld_window_100000.geno.ld > input.file
```

- Then use the R script called from the command line to caculate the average LD values in each bin for the LD zone.

```
   Rscript LD_decay_calculating_for_vcftools.R -i input.file -l 100000 -b 10000 -o output.file
```

- The help manual is as follows：

```
Usage: LD_decay_calculating.R [options] args
Options:
	-i CHARACTER, --input=CHARACTER
		Input file name. The file output from Haploview. [required]

	-l INTEGER, --LD_length=INTEGER
		The farthest distance betweent two SNPs, Unit:bp. [required]

	-b INTEGER, --bin_size=INTEGER
		The bin size to caculating the avagerage LD, Unit:bp. [required]

	-o CHARACTER, --output=CHARACTER
		output file name [default= LD_decay_out.txt]

	-h, --help
		Show this help message and exit
```
