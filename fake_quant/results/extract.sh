TARGET_BIT=${1-3}
MODEL_NAME=${2-Llama-3.1-8B}

mkdir ${MODEL_NAME}
for FILE_NAME in ${HOME}/QuaRot/fake_quant/log/${MODEL_NAME}/${TARGET_BIT}bit/*; do
    if [ -f $FILE_NAME ]; then
        cat ${FILE_NAME} | tail -1 >> ${MODEL_NAME}/res_${TARGET_BIT}bit.csv
    fi
done

sed -i 's/: /,/gi' ${MODEL_NAME}/res_${TARGET_BIT}bit.csv
