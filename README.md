# LD-decay-calculating
## Directions
Use the [Haploview](https://www.broadinstitute.org/haploview/downloads) tool to produce the ped and info file .

__example__:
```
vcftools --gzvcf HH.vcf.gz  --plink --out HH
plink --file HH --recode HV --out HH 
java -jar ~/biosoftware/Haploview.jar -n -pedfile example.ped -info example.info \
-maxdistance 1000 -minMAF 0.05 -hwcutoff 0 -dprime -memory 4096 -out HH
```

Then use the R script called from the command line to caculate the average LD values in each bin for the LD zone.

```
   Rscript LD_decay_calculating.R -i input.file -l 100000 -b 10000 -o output.file
```

