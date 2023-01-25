#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

/* script to test out how channels and processes are created
* and work. */

// create a value channel
ch_vl = Channel.value('GRCh38')

// create a queue channel
ch_qu = Channel.of(1..4)

// view the contents of the channel
ch_vl.view()
ch_qu.view()

// create a queue channel from a list using Channel.fromList
list_of_aligner = ['bwa', 'minimap2', 'kallisto', 'salmon']
aligner_ch = Channel.fromList(list_of_aligner)
println "Below is a channel made using Channel.fromList factory"
aligner_ch.view()

/* create a channel using the fromPath method and also expand it
* to include all subdirectories of the folder and hidden files
*/
dirChan = Channel.fromPath("data/yeast/**", hidden: true)
//dirChan.view()

// create a channel using fromFilePairs that holds 3 tuples
tupChan = Channel.fromFilePairs('data/yeast/reads/temp33*_{1,2}*')
tupChan.view()