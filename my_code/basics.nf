#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

my_list = [1,2,3,4,5,6,7,8,9,10] 
// can also make the list with my_list = 1..10
fifthEle = my_list[4]
fifthElel2 = my_list.get(4)

println("The square notation gives: ${fifthEle}")
println("The get notation gives: ${fifthElel2}")

// Using maps to make lists with keys and values
roi = [ chromosome : "chr17", start: 7640755, end: 7718054, genes: ['ATP1B2','TP53','WRAP53']]
//Use of the square brackets
roi['chromosome'] = '67'

//Use a dot notation        
//roi.chromosome = 'chr17'  

//Use of put method              
roi.put('genome', 'hg38') 
println(roi)

/* practising closures and closure parameters
* Here, I have to make a closure to append 'chr'
* in front of the list content
*/
x = [1,2,3,4,5,6]
x_close = {"chr" + it}
// another way to do this is: x_close = {"chr${it}"}
y = x.collect(x_close)
// another way to do this: x = [1,2,3,4,5,6].collect(x_close)
println y

// testing out how if/else and for statements work in nextflow
x = 2
if(x > 10)
	println "$x is greater than 10"
else
	println "$x is not greater than 10"
x = 25
if(x>10){
	println "$x is greater than 10"
}
else {
	println "$x is not greater than 10"
}
for (int i = 0; i <3; i++){
	println("Hello World $i")
}
// iterating through list objects look like
list = ["a", "b", "c"]
for(String elem:list){
	println elem
}