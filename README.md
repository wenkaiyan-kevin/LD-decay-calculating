# LD-decay-calculating
## Directions
- Firstly, Using the [Haploview](https://www.broadinstitute.org/haploview/downloads) tool change vcf format file into the ped and info file .

__example__:
```
vcftools --gzvcf HH.vcf.gz  --plink --out HH
plink --file HH --recode HV --out HH 
java -jar ~/biosoftware/Haploview.jar -n -pedfile example.ped -info example.info \
-maxdistance 1000 -minMAF 0.05 -hwcutoff 0 -dprime -memory 4096 -out HH
```

- Then use the R script called from the command line to caculate the average LD values in each bin for the LD zone.

```
   Rscript LD_decay_calculating.R -i input.file -l 100000 -b 10000 -o output.file
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
