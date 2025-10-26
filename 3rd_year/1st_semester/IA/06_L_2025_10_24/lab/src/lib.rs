pub fn gradient_descent_1d<F, G>(
    mut x: f64,
    c: f64,
    tolerance: f64,
    max_iters: usize,
    f: F,
    grad_f: G,
) -> f64
where
    F: Fn(f64) -> f64,
    G: Fn(f64) -> f64,
{
    println!("Iter 0: x = {:.6}, f(x) = {:.6}", x, f(x));
    for i in 1..=max_iters {
        let new_x = x - c * grad_f(x);
        println!("Iter {}: x = {:.6}, f(x) = {:.6}", i, new_x, f(new_x));
        if (new_x - x).abs() < tolerance {
            println!("STOPPED: {} iters", i);
            return new_x;
        }
        x = new_x;
    }
    x
}

pub fn gradient_descent_2d<F, G>(
    mut w1: f64,
    mut w2: f64,
    c: f64,
    tolerance: f64,
    max_iters: usize,
    f: F,
    grad_f: G,
) -> (f64, f64)
where
    F: Fn(f64, f64) -> f64,
    G: Fn(f64, f64) -> (f64, f64),
{
    println!(
        "Iter 0: w1 = {:.6}, w2 = {:.6}, E = {:.6}",
        w1,
        w2,
        f(w1, w2)
    );
    for i in 1..=max_iters {
        let (dw1, dw2) = grad_f(w1, w2);
        let new_w1 = w1 - c * dw1;
        let new_w2 = w2 - c * dw2;
        println!(
            "Iter {}: w1 = {:.6}, w2 = {:.6}, E = {:.6}",
            i,
            new_w1,
            new_w2,
            f(new_w1, new_w2)
        );
        if (new_w1 - w1).abs() < tolerance && (new_w2 - w2).abs() < tolerance {
            println!("STOPPED: {} iters", i);
            return (new_w1, new_w2);
        }
        w1 = new_w1;
        w2 = new_w2;
    }
    (w1, w2)
}

pub fn train_single_sample_linear_neuron(
    mut w1: f64,
    mut w2: f64,
    x1: f64,
    x2: f64,
    y: f64,
    c: f64,
    tolerance: f64,
    max_iters: usize,
) -> (f64, f64) {
    let e = |w1: f64, w2: f64| {
        let o = w1 * x1 + w2 * x2;
        0.5 * (y - o).powi(2)
    };

    println!(
        "Iter 0: w1 = {:.6}, w2 = {:.6}, E = {:.6}",
        w1,
        w2,
        e(w1, w2)
    );

    for i in 1..=max_iters {
        let o = w1 * x1 + w2 * x2;
        let error = y - o;

        let dw1 = -error * x1;
        let dw2 = -error * x2;

        let new_w1 = w1 - c * dw1;
        let new_w2 = w2 - c * dw2;

        println!(
            "Iter {}: w1 = {:.6}, w2 = {:.6}, E = {:.6}",
            i,
            new_w1,
            new_w2,
            e(new_w1, new_w2)
        );

        if (new_w1 - w1).abs() < tolerance && (new_w2 - w2).abs() < tolerance {
            println!("STOPPED: {} iters", i);
            return (new_w1, new_w2);
        }

        w1 = new_w1;
        w2 = new_w2;
    }

    (w1, w2)
}
