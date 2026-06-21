fn make_squares_up_to(x: u64) -> Vec<u64> {
    (0..x).map(|n| n * n).collect()
}

fn factorial(n: u64) -> u64 {
    if n <= 1 { 1 } else { n * factorial(n - 1) }
}

fn make_factorial() -> impl FnMut(u64) -> u64 {
    move |n| factorial(n)
}

fn make_running_sum() -> impl FnMut(i32) -> i32 {
    let mut suma = 0;
    move |x| {
        suma += x;
        suma
    }
}

fn main() {
    println!("{:?}", make_squares_up_to(10));

    let mut fact = make_factorial();
    println!("{} {} {}", fact(3), fact(5), fact(7));

    let mut run = make_running_sum();
    println!("{} {} {}", run(3), run(5), run(2));
}
