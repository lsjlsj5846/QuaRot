GPU=${1-0}

MODEL_VERSION=${2-3.1}
MODEL_NAME=${3-Llama-3.1-8B}
MODEL_PTH=/mnt/models/llama/llama-${MODEL_VERSION}/${MODEL_NAME}
# MODEL_PTH=/mnt/models/llama/${2-Llama-3-8b-hf}

TARGET_LAYER=".${4}"
TARGET_MODULE="${5}"
TARGET_BIT="${6-3}"

if [ ! -z ${TARGET_MODULE} ]; then
    SAVE_NAME="${MODEL_NAME}-${4}-${TARGET_MODULE}-${TARGET_BIT}bit"
    if [ ${TARGET_MODULE} == "mha" ]; then
        TARGET_MODULES="${TARGET_LAYER}.self_attn.q_proj.module,${TARGET_LAYER}.self_attn.k_proj.module,${TARGET_LAYER}.self_attn.v_proj.module,${TARGET_LAYER}.self_attn.o_proj.module"
    elif [ ${TARGET_MODULE} == "mlp" ]; then
        TARGET_MODULES="${TARGET_LAYER}.mlp.up_proj.module,${TARGET_LAYER}.mlp.gate_proj.module,${TARGET_LAYER}.mlp.down_proj.module"
    elif [ ${TARGET_MODULE} == "all" ]; then
        TARGET_MODULES="${TARGET_LAYER}.self_attn.q_proj.module,${TARGET_LAYER}.self_attn.k_proj.module,${TARGET_LAYER}.self_attn.v_proj.module,${TARGET_LAYER}.self_attn.o_proj.module,${TARGET_LAYER}.mlp.up_proj.module,${TARGET_LAYER}.mlp.gate_proj.module,${TARGET_LAYER}.mlp.down_proj.module"
    else
        echo "Invalid \$TARGET_MODULE: ${TARGET_MODULE}"
        exit 1
    fi
else
    SAVE_NAME="${MODEL_NAME}-plain"
fi

CUDA_VISIBLE_DEVICES=${GPU} python main.py \
    --model $MODEL_PTH \
    --rotate \
    --a_bits 4 \
    --v_bits 4 \
    --k_bits 4 \
    --w_bits 4 \
    --w_clip \
    --target_module "${TARGET_MODULES}" \
    --target_bit ${TARGET_BIT} \
    --save_name "${SAVE_NAME}" \