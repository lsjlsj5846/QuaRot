# GPU=${1}
# if [ ${GPU} == 2 ]; then
# 	TARGET="mha"
# 	START_IDX=2
# elif [ ${GPU} == 3 ]; then
# 	TARGET="mlp"
# 	START_IDX=1
# else
# 	echo "Do not use GPU #0,1"
# 	exit 1
# fi


# for (( i=${START_IDX}; i<32; i++ )); do
# 	bash llama_run.sh ${GPU} Llama-3-8b-hf ${i} ${TARGET}
# done

bash llama_run.sh 3 Llama-3-8b-hf 1 mlp

for (( i=2; i<32; i++ )); do
	bash llama_run.sh 3 Llama-3-8b-hf ${i} mha
	bash llama_run.sh 3 Llama-3-8b-hf ${i} mlp
done