#!/bin/bash

for i in {4..28..2}; do
	for y in {5..20..5}; do
	sh bin/mallet evaluate-topics --input noticias-inferencer.$i.$y.model.output --output-doc-probs noticias-doc-probs.$i.$y.txt --output-prob noticias_prob.$i.$y.txt

        sh bin/mallet run cc.mallet.util.DocumentLengths --input noticias_test.mallet  > noticias_test.mallet.$i.$y"-doclengths.txt"

        docLen=($(cat noticias_test.mallet.$i.$y"-doclengths.txt"))
	docProb=($(cat noticias-doc-probs.$i.$y.txt ))

        logLikelihood=0
	totalWords=0

        for ((j=0; j<${#docProb[@]}; j++))
	do
	    logLikelihood=`echo "$logLikelihood + ${docProb[$j]}" | bc -l`
	    totalWords=`echo "$totalWords + ${docLen[$j]}" | bc -l`
	done

	perplexity=`echo "e(-1*$logLikelihood / $totalWords)" | bc -l`
	ppx[$i]=$perplexity
	echo -e $i"\t"$y"\t"${ppx[$i]} >> modelo$i.$y-perplexity.txt
	done
done


