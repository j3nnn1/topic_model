# Unigramas

#train - Pasa formato txt a Mallet train
bin/mallet import-dir --input ./train \
--keep-sequence  TRUE  \
--output noticias.mallet \
--gram-sizes 1 \
--stoplist-file ./stoplists/es3.txt 

#test - Pasar formato txt a mallet test
bin/mallet import-dir --input ./test \
--keep-sequence  TRUE  \
--output noticias_test.mallet \
--gram-sizes 1 \
--stoplist-file ./stoplists/es3.txt \
--use-pipe-from noticias.mallet

#Entrenando Modelo
bin/mallet train-topics \
--input noticias.mallet \
--optimize-interval 20 \
--num-topics 20 \
--word-topic-counts-file  noticias_word-topic-counts.txt \
--output-state noticias-topic-state.gz \
--output-topic-keys noticias_keys.txt \
--output-doc-topics noticias_composition.txt \
--testing noticias_test.mallet

#Inferencia.

sh bin/mallet infer-topics --inferencer   noticias-inferencer.4.5.model \
--input noticias_test.mallet \
--output-doc-topics noticias-inferencer.4.5.model.output \
--num-iterations 10 \
--sample-interval 4 \

#evaluando Modelo

 sh bin/mallet  evaluate-topics --evaluator noticias-evaluator.4.5.evaluator \   
--input noticias_test.mallet \
--output-doc-probs noticias_output_doc_probs.txt \
--output-prob noticias_prob.txt

# bigramas
bin/mallet import-dir --input ./train \
--keep-sequence  TRUE  \
--output noticias.mallet \
--stoplist-file ./stoplists/es3.txt \
--gram-sizes 1,2 \
--keep-sequence-bigrams

# acuerdense de cambiar el script de entrenamiento que está haciendo referencia a unigramas
bin/mallet train-topics \
--input noticias.mallet \
--use-ngrams TRUE \
--optimize-interval 20 \
--num-topics 20 \
--word-topic-counts-file  noticias_word-topic-counts.txt \
--output-state noticias-topic-state.gz \
--output-topic-keys noticias_keys.txt \
--output-doc-topics noticias_composition.txt


#Ejecutar 1ero entrenamiento.sh
#luego inference.sh
#y de ultimo evaluate.sh

