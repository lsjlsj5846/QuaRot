GPU=${1}
TARGET_BIT=${2-3}

if [ ${GPU} == 0 ]; then
	TARGET="mha"
elif [ ${GPU} == 1 ]; then
	TARGET="mlp"
else
	echo "Invalid GPU"
	exit 1
fi


for (( i=0; i<32; i++ )); do
	bash llama_run.sh ${GPU} 3.1 Llama-3.1-8B ${i} ${TARGET} ${TARGET_BIT}
done