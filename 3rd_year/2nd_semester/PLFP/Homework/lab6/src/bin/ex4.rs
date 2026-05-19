fn umple_rec(tabla: &mut [i32; 9], pas: usize, seed: &mut u64) {
    if pas == 9 {
        return;
    }
    *seed = seed.wrapping_mul(1664525).wrapping_add(1013904223);
    let mut idx = (*seed as usize) % 9;
    while tabla[idx] != -1 {
        idx = (idx + 1) % 9;
    }
    tabla[idx] = if pas % 2 == 0 { 1 } else { 0 };
    umple_rec(tabla, pas + 1, seed);
}

fn main() {
    let mut tabla = [-1; 9];
    let mut seed = 42u64;
    umple_rec(&mut tabla, 0, &mut seed);
    println!("{:?}", tabla);
}
