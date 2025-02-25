DATASET=voc12
CONFIG=/kaggle/working/DRS/DeepLab-V2-PyTorch/configs/voc12.yaml
LOG_DIR=/kaggle/working/DRS/DeepLab-V2-PyTorch/Deeplabv2_pseudo_segmentation_labels_2gpu
GT_DIR=/kaggle/working/DRS/DeepLab-V2-PyTorch/refined_pseudo_segmentation_labels

# Training DeepLab-V2 using pseudo segmentation labels
CUDA_VISIBLE_DEVICES=0,1 python train.py --config_path ${CONFIG} --gt_path ${GT_DIR} --log_dir ${LOG_DIR}


# evaluation
CUDA_VISIBLE_DEVICES=0 python main.py test \
-c configs/${DATASET}.yaml \
-m data/models/${LOG_DIR}/deeplabv2_resnet101_msc/*/checkpoint_final.pth  \
--log_dir=${LOG_DIR}


# evaluate the model with CRF post-processing
CUDA_VISIBLE_DEVICES=0 python main.py crf \
-c configs/${DATASET}.yaml \
--log_dir=${LOG_DIR}
