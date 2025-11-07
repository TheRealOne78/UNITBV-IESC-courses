#!/usr/bin/env python3

import numpy as np

with open("optdigits-orig.tra/optdigits-orig.tra") as f:
    lines = [line.strip() for line in f if line.strip()]

header_end = 20
data_lines = lines[header_end:]
img_size   = 32
block_size = img_size + 1
n_images   = len(data_lines) // block_size

images = np.zeros((n_images, img_size, img_size), dtype=int)
labels = np.zeros(n_images, dtype=int)

# Load
for i in range(n_images):
    start     = i * block_size
    block     = data_lines[start:start + block_size]
    img_lines = [row[:32] for row in block[:img_size]]
    label     = block[-1]

    images[i] = np.array([[int(ch) for ch in row] for row in img_lines], dtype=int)
    labels[i] = int(label)

def scale_down_np(img):
    n      = img.shape[0]
    blocks = img.reshape(n//2, 2, n//2, 2).transpose(0, 2, 1, 3)
    zeros  = np.sum(blocks == 0, axis=(2,3))

    return np.where(zeros >= 3, 0, 1)

idx   = 0
img32 = images[idx]
label = labels[idx]
img16 = scale_down_np(img32)
img8  = scale_down_np(img16)

def print_img(img):
    for row in img:
        print("".join(" " if x == 0 else "$" for x in row))

print(f"\n{label}\n")
print("32x32 (OG):")
print_img(img32)

print("\n16x16:")
print_img(img16)

print("\n8x8:")
print_img(img8)
