


##service manual
suppressPackageStartupMessages(require(optparse))

option_list = list(
  make_option(c("-i", "--input"), type="character", default=NULL,help="Input file name. The file output from Haploview. [required]", 
              metavar="character"),
  make_option(c("-l", "--LD_length"), type="integer", default=NULL,help="The farthest distance betweent two SNPs, Unit:bp. [required]", 
              metavar="integer"),
  make_option(c("-b", "--bin_size"), type="integer", default=NULL,help="The bin size to caculating the avagerage LD, Unit:bp. [required]", 
              metavar="integer"),
  make_option(c("-o", "--output"), type="character", default="LD_decay_out.txt",help="output file name [default= %default]", 
              metavar="character")
)
opt_parser = OptionParser(usage = "usage: %prog [options] args",option_list=option_list)
opt = parse_args(opt_parser)

if (is.null(opt$input) | is.null(opt$LD_length) | is.null(opt$bin_size)){
  print_help(opt_parser)
  #stop("At least one argument must be supplied (input file)", call.=TRUE)
  stop("At least three argument must be supplied")
}


## program...

#Reading the LD values
LD_data <- read.table(opt$input,header=T)[,c(5,8)] 

#Produce the index of bin
bin_index_set <- c(seq(0,opt$LD_length,opt$bin_size))                
                                             


#Define the function for calculating the LD mean
ld_avg<- function( LD_data, bin_index_set ) {
  
  ld_out<-NULL
  
  for (i in 1:(length(bin_index_set)-1)){
    
    index <- LD_data[,2]>bin_index_set[i] & LD_data[,2]< bin_index_set[i+1] 
    
    mean_ld <-mean( LD_data[index,1])
    
    ld_out<-c(ld_out,mean_ld)
  }
  
  ld_decay <- data.frame(zone_index=bin_index_set[-1], LD_value=ld_out)
  
  return(ld_decay)
}


#caculating the average LD value
LDdecay <- ld_avg(LD_data,bin_index_set)

write.table(LDdecay,file = opt$output,  row.names=F)











