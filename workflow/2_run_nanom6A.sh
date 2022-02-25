#######################
####  environment  ####
#######################

guppy_path=/path to your guppy/

#######################
#### genome config ####
#######################

threads=/the number of cpu to process/
lib=/Lib name/
input=/path to your input fast5/
output=/path to output/

transcripts=/path to transcripts/
genome=/path to genome file/
bed=/path to bed6 file/

#######################
#######################

#Basecalling using guppy (version 3.6.1)
flowcell=FLO-PRO002
kit=SQK-RNA002


# Guppy can perform basecalling to generate FASTQ file and an additional FAST5 file that contains basecalling information, which is available to ONT customers. 
# Users should be an existing customer or register an account through the Nanopore community (https://community.nanoporetech.com/downloads) to download Guppy.

dir=$output/guppy/$lib
if [ ! -d "$dir/$lib" ]; then
       echo
       echo
       echo "[`date`] guppy"
       echo '-----------------------------------------------'
       export PATH=$guppy_path:$PATH
       mkdir -p $dir
       guppy_basecaller -i $input -s $dir/$lib --num_callers $threads --recursive --fast5_out --flowcell $flowcell --kit $kit
       echo "[`date`] Run complete for guppy"
       echo '-----------------------------------------------'
fi


#Miniconda coule be install to manage environment
#https://docs.conda.io/en/latest/miniconda.html#linux-installers
#wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
#sh Miniconda3-latest-Linux-x86_64.sh
#==> For changes to take effect, close and re-open your current shell


#Convert merged single big fast5 into small size fast5 file
#pip install ont-fast5-api
#https://pypi.org/project/ont-fast5-api/
#multi_to_single_fast5 -i $output/guppy/$i/workspace -s $dir/$lib -t 40 --recursive >$dir/$i/convert.log 2>&1
#https://github.com/nanoporetech/ont_fast5_api/issues/40

# In this step, user should activate tombo in conda or put the tombo PATH in environment.
# export PATH=/your tombo PATH/:$PATH
# for example : 
# export PATH=/home/Sorata/miniconda3/envs/tombo/bin:$PATH

conda activate tombo

dir=$output/multi_to_single_fast5
if [ ! -d "$dir/$lib" ]; then
        echo
        echo
        echo "[`date`] multi_to_single_fast5"
        echo '-----------------------------------------------'
        mkdir -p $dir
        export PYTHONPATH=""
        export PATH=$tombo_path:$PATH
        multi_to_single_fast5 -i $output/guppy/$lib/workspace -s $dir/$lib -t $threads --recursive
        echo "[`date`] Run complete for single_to_multi_fast5"
        echo '-----------------------------------------------'
fi


# pip install numpy
# pip install ont-tombo   #https://nanoporetech.github.io/tombo/

# The information of basecall_group was in the fast5 generated by Guppy, which was usually Basecall_1D_000 or Basecall_1D_001.
basecall_group=Basecall_1D_000

dir=$output/tombo
if [ ! -f "$dir/${lib}.txt" ]; then
        echo
        echo
        echo "[`date`] tombo resquiggle $lib"
        echo '-----------------------------------------------'
        mkdir -p $dir
        export PYTHONPATH=""
        tombo resquiggle --basecall-group $basecall_group --overwrite $output/multi_to_single_fast5/$lib $transcripts --processes $threads --fit-global-scale --include-
event-stde --ignore-read-locks --signal-matching-score 2
        find $output/multi_to_single_fast5/$lib*/ -name "*.fast5" >$dir/$lib.txt
        echo "[`date`] Run complete for tombo resquiggle $lib"
        echo '-----------------------------------------------'
fi


# In this case, user should activate nanom6A in conda or put the nanom6A PATH in environment PATH.
# export PATH=/your nanom6A PATH/:$PATH
# for example : 
# export PATH=/home/Sorata/miniconda3/envs/nanom6A/bin:$PATH

conda activate nanom6A

dir=$output/extract_raw_and_feature
if [ ! -f "$dir/${lib}.feature.tsv" ]; then
        echo
        echo
        echo "[`date`] extract_raw_and_feature for $dir/$lib"
        echo '-----------------------------------------------'
        mkdir -p $dir
        export PYTHONPATH=""
        extract_raw_and_feature_fast --cpu=$threads --fl=$output/tombo/"$lib".txt -o $dir/$lib --clip=10
        echo "[`date`] Run complete for extract_raw_and_feature for $dir/$lib"
        echo '-----------------------------------------------'
fi


###
#https://github.com/broadinstitute/gatk/releases
#conda install -c bioconda picard
#java -jar picard.jar CreateSequenceDictionary -R genome.fa -O genome.dict
#samtools faidx genome.fa
#samtools faidx transcript.fa
#conda install -c hcc jvarkit-sam2tsv
#conda install -c bioconda minimap2

dir=$output/m6A/$lib
if [ ! -d "$dir/$lib" ]; then
        echo
        echo
        echo "[`date`] predicting m6A site for $dir/$lib"
        echo '-----------------------------------------------'
        mkdir -p $dir/plot
        predict_sites --cpu $threads -i $output/extract_raw_and_feature/$lib -o $dir/$lib -r $bed -g $genome
        echo "[`date`] Run complete for predicting m6A site for $dir/$lib"
        echo '-----------------------------------------------'
fi

