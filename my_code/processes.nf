#!/usr/bin/env nextflow

// add the dsl2 notation
nextflow.enable.dsl = 2

// write a simple process that prints the salmon version
process SALMON_VERSION {
    script:
    """
    salmon --version
    """
}
/* write a process that carries out some salmon indexing 
* where the kmer value has a default value but also can
* be changed by the user */
params.kmer = 31
dataPath = "/mmfs1/groups/translational_apps/active/Dami/\
Personal/NextFlow_Software_Carpentry"
process INDEX {
    script:
    """
    echo "salmon index -t ${dataPath}/data/yeast/transcriptome/Saccharomyces_cerevisiae.R64-1-1.cdna.all.fa.gz \
    -i index --kmer ${params.kmer}"
    echo "kmer size is" $params.kmer
    """
}

process FASTQC {
    // add input channel
    input:
    path reads

    script:
    """
    mkdir fastqc_out
    fastqc -o fastqc_out ${reads}
    ls -l fastqc_out
    """
}
reads_ch = Channel.fromPath('data/yeast/reads/ref1*_{1,2}.fq.gz')
workflow {
    SALMON_VERSION()
    INDEX()
    FASTQC(reads_ch)
}
