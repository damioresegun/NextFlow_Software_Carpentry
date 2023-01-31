#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

process INDEX {

    input:
    path dirs

    script:
    "salmon index -t ${dirs}/data/yeast/transcriptome/Saccharomyces_cerevisiae.R64-1-1.cdna.all.fa.gz -i ${dirs}/data/yeast/salmon_index --kmerLen 31"
}



workflow {
    my_ch = Channel.fromPath("/mmfs1/groups/translational_apps/active/Dami/Personal/NextFlow_Software_Carpentry")
    //process is called like a function in the workflow block
    INDEX(my_ch)
}
