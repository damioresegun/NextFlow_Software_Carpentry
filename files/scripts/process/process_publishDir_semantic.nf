#!/usr/bin/env
nextflow.enable.dsl = 2

process QUANT {

    publishDir "/mmfs1/groups/translational_apps/active/Dami/Personal/NextFlow_Software_Carpentry/my_code/cheking/bams", pattern: "*.bam", mode: "copy"
    publishDir "/mmfs1/groups/translational_apps/active/Dami/Personal/NextFlow_Software_Carpentry/my_code/cheking/quant", pattern: "${sample_id}_salmon_output", mode: "copy"

    input:
    tuple val(sample_id), path(reads)
    path index

    output:
    tuple val(sample_id), path("${sample_id}.bam")
    path "${sample_id}_salmon_output"

    script:
    """
    salmon quant -i $index \\
        -l A \\
        -1 ${reads[0]} \\
        -2 ${reads[1]} \\
        -o ${sample_id}_salmon_output \\
        --validateMappings --writeMappings | samtools sort | samtools view -bS -o ${sample_id}.bam
    """
}
mypath = "/mmfs1/groups/translational_apps/active/Dami/Personal/NextFlow_Software_Carpentry"
reads_ch = Channel.fromFilePairs( "${mypath}/data/yeast/reads/ref1_{1,2}.fq.gz" )
index_ch = Channel.fromPath( "${mypath}/data/yeast/salmon_index" )
workflow {
    QUANT( reads_ch, index_ch )
}
