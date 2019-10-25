#!/usr/bin/env Rscript
# date: 2019-10-16
# draw volcano map
# data file(tsv csv rds xlsx) is a table that contains 5 column:
# 1. gene_id
# 2. logFC
# 3. logCPM
# 4. PValue
# 5. FDR
# eg:
# gene_id   logFC   logCPM  PValue  FDR
# ENSG0000183762    15.671  8.85    0   0
# ENSG0000183763    14.561  7.74    0   0
# ENSG0000183764    13.451  6.63    0   0
# (fdr)FDR (logfc)logFC argument is used to identify which gene is DEG
# size indicates the size of node
# alpha|dclr(down color)|nclr(no significant color)|uclr(up color) indicate node color
library(ggplot2, quietly=TRUE)
library(openxlsx, quietly=TRUE)
library(argparser, quietly=TRUE)


parser <- arg_parser("Volcano Map")
parser <- add_argument(parser, "--fdr", help="FDR", type="numeric", default=0.01)
parser <- add_argument(parser, "--logfc", help="logFC", type="numeric", default=2)
parser <- add_argument(parser, "--alpha", help="alpha", type="numeric", default=0.4)
parser <- add_argument(parser, "--size", help="size", type="numeric", default=3.5)
parser <- add_argument(parser, "--dclr", help="down color", default="blue")
parser <- add_argument(parser, "--nclr", help="no significant color", default="grey")
parser <- add_argument(parser, "--uclr", help="up color", default="red")
parser <- add_argument(parser, "--fmt", help="data file format", default="tsv")
parser <- add_argument(parser, "--png", help="output png file")
parser <- add_argument(parser, "--pdf", help="output pdf file")
parser <- add_argument(parser, "data_file", help="data file")

argv <- parse_args(parser)

if (! argv$fmt %in% c("tsv", "xlsx", "rds", "csv")) {
    # raise exception if format is not one of tsv xlsx rds csv
    stop("Invalid format")
}

data <- NULL
if (argv$fmt == "tsv") {
    data <- read.delim(argv$data_file)
}
if (argv$fmt == "xlsx") {
    data <- read.xlsx(argv$data_file)
}
if (argv$fmt == "rds") {
    data <- readRDS(argv$data_file)
}
if (argv$fmt == "csv") {
    data <- read.csv(argv$data_file)
}
if (is.null(data)) {
    # raise an exception for invalid file or format
    stop(sprintf('Invalid format of %s', argv$data_file))
}

data$threshold = as.factor(
	ifelse(
		data$FDR < argv$fdr & abs(data$logFC) >= argv$logfc,
        ifelse(data$logFC > argv$logfc ,'Up', 'Down'),
        'NoSignifi'
	)
)

image <- ggplot(
    data = data,
    aes(x = logFC, y = -log10(FDR), colour=threshold)
) + geom_point(
    alpha = argv$alpha, size = argv$size
) + scale_color_manual(
    values = c(argv$dclr, argv$nclr, argv$uclr)
)

if (! is.na(argv$pdf)) {
    # save pdf
    pdf(argv$pdf)
    print(image)
    dev.off()
}

if (! is.na(argv$png)) {
    # save png
    png(argv$png)
    print(image)
    dev.off()
}

