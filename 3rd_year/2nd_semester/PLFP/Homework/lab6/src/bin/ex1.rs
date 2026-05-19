fn putere(baza: i64, exp: u32) -> i64 {
    if exp == 0 { 1 } else { baza * putere(baza, exp - 1) }
}

fn putere_tail(baza: i64, exp: u32, acc: i64) -> i64 {
    if exp == 0 { acc } else { putere_tail(baza, exp - 1, acc * baza) }
}

fn putere_tc(baza: i64, exp: u32) -> i64 { putere_tail(baza, exp, 1) }

fn inverseaza(s: &str) -> String {
    let chars: Vec<char> = s.chars().collect();
    fn aux(v: &[char]) -> String {
        if v.len() <= 1 { v.iter().collect() } else {
            let mut r = aux(&v[1..]);
            r.push(v[0]);
            r
        }
    }
    aux(&chars)
}

fn este_palindrom(s: &str) -> bool {
    let v: Vec<char> = s.chars().collect();
    fn aux(v: &[char]) -> bool {
        if v.len() <= 1 { true } else { v[0] == v[v.len() - 1] && aux(&v[1..v.len() - 1]) }
    }
    aux(&v)
}

fn medie_recursiva(sir: &[f64]) -> f64 {
    fn suma_rec(sir: &[f64]) -> f64 {
        if sir.is_empty() { 0.0 } else { sir[0] + suma_rec(&sir[1..]) }
    }
    if sir.is_empty() { 0.0 } else { suma_rec(sir) / sir.len() as f64 }
}

fn main() {
    println!("{} {}", putere(2, 10), putere(3, 0));
    println!("{} {}", putere_tc(2, 10), putere_tc(3, 0));
    println!("{}", inverseaza("recursiv"));
    println!("{} {}", este_palindrom("capac"), este_palindrom("rust"));
    println!("{}", medie_recursiva(&[1.0, 2.0, 3.0, 4.0]));
}
