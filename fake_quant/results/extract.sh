for FILE_NAME in /workspace/QuaRot/fake_quant/log/Llama-3-8b-hf/*; do
    if [ -f $FILE_NAME ]; then
        cat ${FILE_NAME} | tail -1 >> result.csv
    fi
done