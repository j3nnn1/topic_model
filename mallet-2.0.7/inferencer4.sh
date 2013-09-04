#!/bin/bash

i=4
for y in {5..20..5}; do
	sh bin/mallet infer-topics --inferencer noticias-inferencer.$i.$y.model --input noticias_test.mallet --output-doc-topics noticias-inferencer.$i.$y.model.output  --num-iterations 10 --sample-interval 4
done
