GPU=${1}
if [ ${GPU} == 0 ]; then
	TARGET="mha"
elif [ ${GPU} == 1 ]; then
	TARGET="mlp"
else
	echo "Invalid GPU"
	exit 1
fi


for (( i=0; i<32; i++ )); do
	bash llama_run.sh ${GPU} 3.1 Llama-3.1-8B ${i} ${TARGET}
done

# bash llama_run.sh 3 Llama-3-8b-hf 1 mlp

# for (( i=2; i<32; i++ )); do
# 	bash llama_run.sh 3 Llama-3-8b-hf ${i} mha
# 	bash llama_run.sh 3 Llama-3-8b-hf ${i} mlp
# done