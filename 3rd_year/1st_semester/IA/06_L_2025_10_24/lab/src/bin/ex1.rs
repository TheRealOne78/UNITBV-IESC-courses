use gradient_lib::gradient_descent_1d;

const fn f(x: f64) -> f64 {
    3.0 * x * x - 6.0 * x + 2.0
}

const fn grad_f(x: f64) -> f64 {
    6.0 * x - 6.0
}

fn main() {
    const C: f64           = 0.01;
    const TOLERANCE: f64   = 1e-5;
    const MAX_ITERS: usize = 200;
    const X0: f64          = 10.0;

    let x_min = gradient_descent_1d(
        X0,
        C,
        TOLERANCE,
        MAX_ITERS,
        f,
        grad_f
    );

    println!("\nMinimum approx: x = {:.6}", x_min);
    println!("f(x_min)  {:.6}", f(x_min));
}
