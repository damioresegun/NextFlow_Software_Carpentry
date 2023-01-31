#!/usr/bin/env nextflow
/* code to test out making multiple output files
*/
nextflow.enable.dsl = 2

process INDEX {
    input:
    path transcriptome
    each kmer

    // add output block to capture index folders
    output:
    path "index_$kmer"

    script:
    """
    salmon index -t $transcriptome -i index_$kmer -k $kmer
    """
}
mypath = "/mmfs1/groups/translational_apps/active/Dami/Personal/NextFlow_Software_Carpentry"
transcriptome_ch = channel.fromPath("${mypath}/data/yeast/transcriptome/Saccharomyces_cerevisiae.R64-1-1.cdna.all.fa.gz")
kmer_ch = channel.of('21', '27', '31')

workflow {
    INDEX(transcriptome_ch, kmer_ch)
    INDEX.out.view()
}