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
    - [Guppy](https://community.nanoporetech.com/downloads) v3.1.5
    - [Ont_fast5_api](https://github.com/nanoporetech/ont_fast5_api) v0.3.2
    - [Tombo](https://github.com/nanoporetech/tombo) v1.5.1
    - [Nanom6A](https://github.com/gaoyubang/nanom6A) 2021_3_18 version
    - [PRAPI](http://forestry.fafu.edu.cn/tool/PRAPI/)
    - [LoRDEC](https://gite.lirmm.fr/lordec/lordec-releases/-/wikis/home) v0.9
    - [Picard](https://github.com/broadinstitute/picard) v2.26.8
    - [GMAP](http://research-pub.gene.com/gmap/) version 2019-12-01
    - [python](https://www.python.org/)


## Input Data

1.For m6A identification based on nanom6A, input data should be transcriptome reference sequences and the fast5 file generated by using Oxford Nanopore platform.

2.For identification of AS and APA based on PRAPI, input file should include genome file, annotation file (genePred format), long reads data, which has been generated by Third Sequcencing Technologies and corrected by LoRDEC.

### nanom6A
- Example FAST5 file in nanom6A: `input/nano/test.fast5`
- Example genome file in nanom6A : `input/nano/ref.fasta`
- Example bed6 file in nanom6A: `input/nano/ano.bed6`

The `fast5` file from Nanopore DRS, which included raw signal, is stored in HDF5 format and could be viewed by [HDFView](https://www.hdfgroup.org/downloads/hdfview).
This is a typical fast5 file:



Each entry in a `FASTA` files consists of 2 lines:  

1. A sequence identifier with information about the sequencing run and the cluster. The exact contents of this line vary by based on the BCL to FASTQ conversion software used.  
2. The sequence (the base calls; A, C, T, G and N).   

The first entry of the input data:
```
@HWI-ST361_127_1000138:2:1101:1195:2141/1
CGTTNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNGGAGGGGTTNNNNNNNNNNNNNNN
+
[[[_BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
```

The bed6 file corresponding to each reference transcript in gene:
```
chrom   st  ed  name    .   strand
chr7    5566779 5570232 ACTB    .   -
```




### PRAPI
- Example FASTA file in PRPAI: `input/prapi/pacbio.fasta`
- Example genome file in PRPAI: `input/prapi/new.fasta`
- Example conf file in PRPAI: `input/prapi/conf.txt`
- Example RNA-seq bam file in PRPAI: `input/prapi/bam/*bam`
- Example annotation file in PRPAI: `input/prapi/phe.txt`


Configuration file `conf.txt` can be edited by Vim text Editor in Linux system and contains several important parameters:

-Long read: PacBio Iso-seq or DRS long reads with FASTA format

-Genome_Annotion file `phe.txt`: Reference annotation with [GenePred](https://genome.ucsc.edu/FAQ/FAQformat.html#format9) format




## Major steps

### Usage for Nanom6A

#### Step 1: Download nanom6A package
Download nanom6A_2021_3_18.tar.gz package can be downloaded from following link:
[https://drive.google.com/drive/folders/1Dodt6uJC7lBihSNgT3Mexzpl_uqBagu0?usp=sharing](https://drive.google.com/drive/folders/1Dodt6uJC7lBihSNgT3Mexzpl_uqBagu0?usp=sharing)

Make sure the package and the script in the same directory

#### Step 2: Install the dependence

```
sh workflow/install_nanom6A.sh
```

#### Step 3: Identification of modified nucleotide using nanom6A

```
sh workflow/run_nanom6A.sh
```



### Usage for PRAPI

#### Step 1: Download PRAPI package

```
sh workflow/install_prapi.sh
```

#### Step 2: Identification of AS and APA 

```
sh workflow/run_prapi.sh
```



## Expected results

![](graphs/figure1.png)



## License
It is a free and open source software, licensed under []() (choose a license from the suggested list:  [GPLv3](https://github.com/github/choosealicense.com/blob/gh-pages/_licenses/gpl-3.0.txt), [MIT](https://github.com/github/choosealicense.com/blob/gh-pages/LICENSE.md), or [CC BY 4.0](https://github.com/github/choosealicense.com/blob/gh-pages/_licenses/cc-by-4.0.txt)).
