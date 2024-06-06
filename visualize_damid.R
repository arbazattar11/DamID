### Visualization Script (`visualize_damid.R`)

Create a script for visualization in R:

```r
# visualize_damid.R

args <- commandArgs(trailingOnly=TRUE)
peaks_dir <- args[1]
visualization_dir <- args[2]

library(ggplot2)
library(GenomicRanges)
library(rtracklayer)

# Function to load peak files
load_peaks <- function(peaks_file) {
  peaks <- read.table(peaks_file, header=FALSE, sep="\t")
  colnames(peaks) <- c("chr", "start", "end", "name", "score", "strand", "signal", "pvalue", "qvalue", "peak")
  return(peaks)
}

# List all peak files
peak_files <- list.files(peaks_dir, pattern="*.narrowPeak", full.names=TRUE)

# Load and visualize each peak file
for (peak_file in peak_files) {
  peaks <- load_peaks(peak_file)
  p <- ggplot(peaks, aes(x=start, y=signal, color=chr)) +
    geom_point() +
    theme_minimal() +
    labs(title=basename(peak_file), x="Genomic Position", y="Signal")
  
  ggsave(filename=paste0(visualization_dir, "/", basename(peak_file), ".png"), plot=p)
}
