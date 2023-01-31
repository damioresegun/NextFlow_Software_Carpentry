nextflow.enable.dsl = 2

process QUANT {
    publishDir "/mmfs1/groups/translational_apps/active/Dami/Personal/NextFlow_Software_Carpentry/my_code/cheking"

    input:
    tuple val(sample_id), path(reads)
    each index

    output:
    tuple val(sample_id), path("${sample_id}_salmon_output")

    script:
    """
    salmon quant -i $index \\
        -l A \\
        -1 ${reads[0]} \\
        -2 ${reads[1]} \\
        -o ${sample_id}_salmon_output
    """
}
mypath = "/mmfs1/groups/translational_apps/active/Dami/Personal/NextFlow_Software_Carpentry"

workflow {
    
    reads_ch = Channel.fromFilePairs( "${mypath}/data/yeast/reads/ref1_{1,2}.fq.gz" )
    index_ch = Channel.fromPath( "${mypath}/data/yeast/salmon_index" )
    QUANT( reads_ch, index_ch )
    QUANT.out.view()
}
