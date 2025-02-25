ROOT=/kaggle/input/voc2012-updated/VOC2012/
MODEL=deeplabv3plus_resnet101 # deeplabv3plus_resnet101, deeplabv3_resnet101
ITER=20000
BATCH=32
LR=0.05


# training with 1 GPUs
CUDA_VISLBLE_DEVICES=0 python main.py --data_root ${ROOT} --model ${MODEL} --gpu_id 0 --amp --total_itrs ${ITER} --batch_size ${BATCH} --lr ${LR}  --crop_val


# evalutation with crf
CUDA_VISIBLE_DEVICES=0 python eval.py --gpu_id 0 --data_root ${ROOT} --model ${MODEL}  --val_batch_size 16  --ckpt checkpoints/best_${MODEL}_voc_os16.pth  --crop_val
