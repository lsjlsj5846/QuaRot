TARGET_BIT=${1-3}
MODEL_NAME=${2-Llama-3.1-8B}
N=${3-32}

mkdir ${MODEL_NAME}
BASE_LOG_PATH="${HOME}/QuaRot/fake_quant/log/${MODEL_NAME}/${TARGET_BIT}bit"
# for FILE_NAME in ${HOME}/QuaRot/fake_quant/log/${MODEL_NAME}/${TARGET_BIT}bit/*; do
#     if [ -f $FILE_NAME ]; then
#         cat ${FILE_NAME} | tail -1 >> ${MODEL_NAME}/res_${TARGET_BIT}bit.csv
#     fi
# done

for (( i=0; i<$N; i++ )); do
    cat ${BASE_LOG_PATH}/${MODEL_NAME}-${i}-mha-${TARGET_BIT}bit.log | tail -1 >> ${MODEL_NAME}/res_${TARGET_BIT}bit.csv
    cat ${BASE_LOG_PATH}/${MODEL_NAME}-${i}-mlp-${TARGET_BIT}bit.log | tail -1 >> ${MODEL_NAME}/res_${TARGET_BIT}bit.csv
done

sed -i 's/: /,/gi' ${MODEL_NAME}/res_${TARGET_BIT}bit.csv
