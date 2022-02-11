[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0)

# NanoPrapi

This is an analysis pipeline for identification of m6A, alternative splicing and polyadenylation using Third-generation sequencing.

This pipeline include nanom6A([https://github.com/gaoyubang/nanom6A](https://github.com/gaoyubang/nanom6A)) to identify m6A in single-base

and

PRAPI([http://forestry.fafu.edu.cn/tool/PRAPI/help.php](http://forestry.fafu.edu.cn/tool/PRAPI/help.php)) to detect AS and APA events.


## Installation

- __Running environment__: 
    - The workflow was constructed based on the __centos__ and __ubuntu__.

- __Required software and versions__: 
    - [Anaconda](https://docs.conda.io/en/latest/miniconda.html)
    - [Guppy v3.1.5](https://community.nanoporetech.com/downloads)
    - [Ont_fast5_api v0.3.2](https://github.com/nanoporetech/ont_fast5_api)
    - [Tombo v1.5.1](https://github .com/nanoporetech/tombo)
    - [Nanom6A 2021_3_18 version](https://github.com/gaoyubang/nanom6A)
    - [PRAPI](http://forestry.fafu.edu.cn/tool/PRAPI/)
    - [LoRDEC v0.9](https://gite.lirmm.fr/lordec/lordec-releases/-/wikis/home)
    - [Picard v2.26.8](https://github.com/broadinstitute/picard)
    - [GMAP version 2019-12-01](http://research-pub.gene.com/gmap/)
    - [python](https://www.python.org/)


## Input Data

1.For m6A identification based on nanom6A, input data should be transcriptome reference sequences and the fast5 file generated by using Oxford Nanopore platform.
2.For identification of AS and APA based on PRAPI, input file should include genome file, annotation file (genePred format), long reads data, which has been generated by Third Sequcencing Technologies and corrected by LoRDEC.


- R1 FASTQ file: `input/reads1.fastq`  
- R2 FASTQ file: `input/reads2.fastq`  

Each entry in a FASTQ files consists of 4 lines:  

1. A sequence identifier with information about the sequencing run and the cluster. The exact contents of this line vary by based on the BCL to FASTQ conversion software used.  
2. The sequence (the base calls; A, C, T, G and N).  
3. A separator, which is simply a plus (+) sign.  
4. The base call quality scores. These are Phred +33 encoded, using ASCII characters to represent the numerical quality scores.  

The first entry of the input data:
```
@HWI-ST361_127_1000138:2:1101:1195:2141/1
CGTTNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNGGAGGGGTTNNNNNNNNNNNNNNN
+
[[[_BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
```


## Major steps

### Usage for Nanom6A
- test

#### Step 1: running the FastQC to conduct quality checking
- Note that you have to normalize the path in the shell script.

```
sh workflow/1_run_fastqc.sh
```

#### Step 2: aggregate results from FastQC

```
sh workflow/2_aggregate_results.sh
```

#### Step 3: view the results

- Results can be visualized by clicking `output/multiqc_report.html`.
- Alternatively, you can plot the results yourself using the below R code.

```
3_visualize_results.Rmd
```

## Expected results

![](graphs/figure1.png)

## License
It is a free and open source software, licensed under []() (choose a license from the suggested list:  [GPLv3](https://github.com/github/choosealicense.com/blob/gh-pages/_licenses/gpl-3.0.txt), [MIT](https://github.com/github/choosealicense.com/blob/gh-pages/LICENSE.md), or [CC BY 4.0](https://github.com/github/choosealicense.com/blob/gh-pages/_licenses/cc-by-4.0.txt)).
