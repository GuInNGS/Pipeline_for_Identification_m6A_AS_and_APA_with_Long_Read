# activate environment
conda activate prapi_env

# build gmap index
gmap_build -d specie_name -D genome.fasta

# Analysis
Pacbio_v16.py -c conf.txt
