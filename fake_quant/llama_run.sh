GPU=${1-0}

MODEL_VERSION=${2-3.1}
MODEL_NAME=${3-Llama-3.1-8B}
MODEL_PTH=/mnt/models/llama/llama-${MODEL_VERSION}/${MODEL_NAME}

ADDITIONAL_ARGS=${4}

CUDA_VISIBLE_DEVICES=${GPU} python main.py \
    --model $MODEL_PTH \
    --rotate \
    --a_bits 4 \
    --v_bits 4 \
    --k_bits 4 \
    --w_bits 4 \
    --w_clip \
    ${ADDITIONAL_ARGS}