fn partition(a: &mut [i32], p: usize, r: usize) -> usize {
    let x = a[p];
    let mut i = p.wrapping_sub(1);
    let mut j = r + 1;

    loop {
        loop {
            j -= 1;
            if a[j] <= x {
                break;
            }
        }

        loop {
            i = i.wrapping_add(1);
            if a[i] >= x {
                break;
            }
        }

        if i < j {
            a.swap(i, j);
        } else {
            return j;
        }
    }
}

fn quicksort(a: &mut [i32], p: usize, r: usize) {
    if p < r {
        let q = partition(a, p, r);
        if q > 0 {
            quicksort(a, p, q);
        }
        quicksort(a, q + 1, r);
    }
}


fn main() {
    let mut arr = vec![33, 10, 55, 71, 29, 3, 87];
    let len = arr.len();
    if len > 0 {
        quicksort(&mut arr, 0, len - 1);
    }
    println!("{:?}", arr);
}
