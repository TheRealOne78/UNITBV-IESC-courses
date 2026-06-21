fn aplica_tuturor(lista: &[i32], op: impl Fn(i32) -> i32) -> Vec<i32> {
    lista.iter().map(|x| op(*x)).collect()
}

fn main() {
    let n: i32 = 5;
    let inmulteste_cu_n = |x: i32| x * n;

    for x in 1..=10 {
        println!("{}", inmulteste_cu_n(x));
    }

    let lista: Vec<i32> = (1..=10).collect();
    let rezultat = aplica_tuturor(&lista, inmulteste_cu_n);

    println!("{:?}", rezultat);
}
