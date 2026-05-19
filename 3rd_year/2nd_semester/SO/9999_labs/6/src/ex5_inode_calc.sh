#!/usr/bin/env sh

usage() {
    echo "Usage: ${0}" >&2
    echo "Computes inode file size limits and linkage blocks for 50MB." >&2
}

# Check args
[ "$#" -ne 0 ] && { usage; exit 1; }

blk_kb=2
ptr_b=4
inode_direct=10

addr_per_indirect=$((blk_kb * 1024 / ptr_b))

no_indirect_kb=$((inode_direct * blk_kb))
single_kb=$(((inode_direct + addr_per_indirect) * blk_kb))
double_kb=$(((inode_direct + addr_per_indirect + addr_per_indirect * addr_per_indirect) * blk_kb))
triple_kb=$(((inode_direct + addr_per_indirect + addr_per_indirect * addr_per_indirect + addr_per_indirect * addr_per_indirect * addr_per_indirect) * blk_kb))

echo "Adrese/bloc indirect: $addr_per_indirect"
echo "Fara indirecte: ${no_indirect_kb}KB"
echo "Cu simplu indirect: ${single_kb}KB"
echo "Cu dublu indirect: ${double_kb}KB"
echo "Cu triplu indirect: ${triple_kb}KB"

file_mb=50
file_kb=$((file_mb * 1024))
data_blocks=$((file_kb / blk_kb))
left=$((data_blocks - inode_direct))

indirect_blocks=0

if [ "$left" -gt 0 ]; then
    indirect_blocks=$((indirect_blocks + 1))
    if [ "$left" -le "$addr_per_indirect" ]; then
        left=0
    else
        left=$((left - addr_per_indirect))
    fi
fi

if [ "$left" -gt 0 ]; then
    indirect_blocks=$((indirect_blocks + 1))
    lvl2=$((left / addr_per_indirect))
    rem=$((left % addr_per_indirect))
    [ "$rem" -ne 0 ] && lvl2=$((lvl2 + 1))
    indirect_blocks=$((indirect_blocks + lvl2))
fi

echo "Blocuri legatura pentru 50MB: $indirect_blocks"
