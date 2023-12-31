% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bowtie2.R
\name{bowtie2}
\alias{bowtie2}
\title{Interface to bowtie2 of bowtie2-2.2.3}
\usage{
bowtie2(
  bt2Index,
  samOutput,
  seq1,
  ...,
  seq2 = NULL,
  interleaved = FALSE,
  overwrite = FALSE
)
}
\arguments{
\item{bt2Index}{\code{Character} scalar. bowtie2 index files
prefix: 'dir/basename'
(minus trailing '.*.bt2' of 'dir/basename.*.bt2').}

\item{samOutput}{\code{Character} scalar. A path to a SAM file
used for the alignment output.}

\item{seq1}{\code{Character} vector. For single-end sequencing,
it contains sequence file paths.
For paired-end sequencing, it can be file paths with #1 mates
paired with file paths in seq2.
And it can also be interleaved file paths when argument
interleaved=\code{TRUE}}

\item{...}{Additional arguments to be passed on to the binaries.
See below for details.}

\item{seq2}{\code{Character} vector. It contains file paths with
#2 mates paired with file paths in seq1.
For single-end sequencing files and interleaved paired-end
sequencing files(argument interleaved=\code{TRUE}),
it must be \code{NULL}.}

\item{interleaved}{\code{Logical}. Set \code{TRUE} when files are
interleaved paired-end sequencing data.}

\item{overwrite}{\code{Logical}. Force overwriting of existing
files if setting \code{TRUE}.}
}
\value{
An invisible \code{Integer} of call
status. The value is 0 when there is not any mistakes
Otherwise the value is non-zero.
}
\description{
This function can be use to call wrapped \code{bowtie2}
binary.
}
\details{
All additional arguments in ... are interpreted as
additional parameters to be passed on to
bowtie2. All of them should be \code{Character} or
\code{Numeric} scalar. You can put all aditional
arguments in one \code{Character}(e.g. "--threads 8 --no-mixed")
with white space splited just like command line,
or put them in different \code{Character}
(e.g. "--threads","8","--no-mixed"). Note that some
arguments("-x","--interleaved","-U","-1","-2","-S") to the
bowtie2 are invalid if they are already handled as explicit
function arguments. See the output of
\code{bowtie2_usage()} for details about available parameters.
}
\examples{
td <- tempdir()
## Building a bowtie2 index
refs <- dir(system.file(package="Rbowtie2", "extdata", "bt2","refs"),
full=TRUE)
bowtie2_build(references=refs, bt2Index=file.path(td, "lambda_virus"),
"--threads 4 --quiet",overwrite=TRUE)
## Alignments
reads_1 <- system.file(package="Rbowtie2", "extdata", "bt2", "reads",
"reads_1.fastq")
reads_2 <- system.file(package="Rbowtie2", "extdata", "bt2", "reads",
"reads_2.fastq")
if(file.exists(file.path(td, "lambda_virus.1.bt2"))){
    cmdout<-bowtie2(bt2Index = file.path(td, "lambda_virus"),
       samOutput = file.path(td, "result.sam"),
       seq1=reads_1,seq2=reads_2,overwrite=TRUE,"--threads 3");cmdout
    head(readLines(file.path(td, "result.sam")))
}

}
\references{
Langmead, B., & Salzberg, S. L. (2012).
Fast gapped-read alignment with Bowtie 2. Nature methods, 9(4), 357-359.
}
\author{
Zheng Wei
}
