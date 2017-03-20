# Abundance estimation using RSEM

# prep reference
perl rsem-prepare-reference.pl
      --bowtie
      --no-polyA
      all.transcripts.fasta
      REF
      
# calculate abundance - bud stage
perl rsem-calculate-expression.pl
      --paired-end
      --num-threads 12
      reads_bud_R1.fq
      reads_bud_R2.fq
      REF
      REF_bud

# calculate expression - D stage
perl rsem-calculate-expression.pl
      --paired-end
      --num-threads 12
      reads_D_R1.fq
      reads_D_R2.fq
      REF
      REF_stageD

# calculate expression - preA stage
perl rsem-calculate-expression.pl
      --paired-end
      --num-threads 12
      reads_preA_R1.fq
      reads_preA_R2.fq
      REF
      REF_preA
      
# Combine estimates to matrix using Trinity util script
perl abundance_estimates_to_matrix.pl
      --est_method RSEM
      --cross_sample_norm TMM
      --out_prefix counts
      bud.isoforms.results
      stageD.isoforms.results
      preA.isoforms.results
