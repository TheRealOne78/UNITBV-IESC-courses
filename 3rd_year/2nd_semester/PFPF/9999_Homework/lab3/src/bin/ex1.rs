fn cel_mai_mare(x: i32, y: i32) -> i32 {
    if x > y { x } else { y }
}

fn cel_mai_mic(x: i32, y: i32) -> i32 {
    if x < y { x } else { y }
}

fn alege_comparator(crescator: bool) -> fn(i32, i32) -> i32 {
    if crescator {
        cel_mai_mare
    } else {
        cel_mai_mic
    }
}

fn main() {
    let comparatoare: Vec<fn(i32, i32) -> i32> = vec![cel_mai_mare, cel_mai_mic];
    let perechi = [(3, 7), (10, 2), (5, 5)];

    for cmp in &comparatoare {
        for (x, y) in perechi {
            println!("({}, {}) -> {}", x, y, cmp(x, y));
        }
    }

    let cmp1 = alege_comparator(true);
    let cmp2 = alege_comparator(false);

    println!("true  -> {}", cmp1(10, 2));
    println!("false -> {}", cmp2(10, 2));
}
