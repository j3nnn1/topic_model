#!/bin/bash

for i in {4..28..2}; do
	for y in {5..20..5}; do
	sh bin/mallet train-topics --input noticias.mallet --optimize-interval $y --num-topics $i --word-topic-counts-file  noticias_word-topic-counts.$i.$y.txt --output-state noticias-topic-state.$i.$y.gz --output-topic-keys noticias_keys.$i.$y.txt --output-doc-topics noticias_composition.$i.$y.txt --inferencer-filename noticias-inferencer.$i.$y.model --evaluator-filename noticias-evaluator.$i.$y.evaluator
	done
done
