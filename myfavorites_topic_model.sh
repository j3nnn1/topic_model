
sh ./bin/mallet  import-file --input inputForMalletFavorites.csv \
 --output myfavorites.mallet --keep-sequence --remove-stopwords \
 --extra-stopwords myfav_stopwords.txt

sh ./bin/mallet train-topics \
--input myfavorites.mallet \
--optimize-interval 20 \
--num-topics 20 \
--word-topic-counts-file  myfavorites_word-topic-counts.txt \
--output-state myfavorites-topic-state.gz \
--output-topic-keys myfavorites_keys.txt \
--output-doc-topics myfavorites_composition.txt


