use std::time::Instant;

fn pipeline(val: i32, pasi: &[fn(i32) -> i32]) -> i32 {
    pasi.iter().fold(val, |acc, f| f(acc))
}

fn pipeline_rev(val: i32, pasi: &[fn(i32) -> i32]) -> i32 {
    pasi.iter().rev().fold(val, |acc, f| f(acc))
}

fn adauga_1(x: i32) -> i32 { x + 1 }
fn dublu(x: i32) -> i32 { x * 2 }
fn la_patrat(x: i32) -> i32 { x * x }

fn main() {
    let a: &[fn(i32) -> i32] = &[adauga_1, dublu, la_patrat];
    let b: &[fn(i32) -> i32] = &[la_patrat, dublu, adauga_1];
    println!("{} == {}", pipeline_rev(5, a), pipeline(5, b));

    let t1 = Instant::now();
    let v: Vec<i32> = (1..=1000).filter(|n| n % 10 == 0).collect();
    let s1: i32 = v.iter().sum();
    let d1 = t1.elapsed();

    let t2 = Instant::now();
    let mut v2 = Vec::new();
    for n in 1..=1000 {
        if n % 10 == 0 {
            v2.push(n);
        }
    }
    let s2: i32 = v2.iter().sum();
    let d2 = t2.elapsed();

    println!("pipeline: {} {:?}", s1, d1);
    println!("for: {} {:?}", s2, d2);
}
