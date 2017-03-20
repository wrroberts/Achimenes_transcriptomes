# Trinity assembly
# k-mer size 25 (default)

Trinity --seqType fq
        --max_memory 60G
        --left reads_left.fq
        --right reads_right.fq
        --SS_lib_type RF
        --CPU 12

# Velvet and Oases assemblies
# k-mer sizes 25,35,45,55,65,75

velveth oases_out
        25,75,10
        -fastq
        -separate
        reads_left.fq
        reads_right.fq

for i in oases_out* ;
        do ./velvetg $i -read_trkg yes -ins_length 300 ;
        done

for i in oases_out* ;
         do ./oases $i -ins_length 300 -min_trans_lgth 100;
         done

# EvidentialGene pipeline

perl trformat.pl
      -output oases_transcripts.fasta
      -format = Oases
      -MINTR = 100
      -prefix = Oases
      -input Oases.fasta

perl trformat.pl
      -output trinity_transcripts.fasta
      -format = Trinity
      -MINTR = 100
      -prefix = Trinity
      -input Trinity.fasta
      
perl tr2aacds.pl
      -mrnaseq all.transcripts.fasta
      -MINCDS = 100
      -NCPU = 12
      -MAXMEM = 60000
      -logfile
