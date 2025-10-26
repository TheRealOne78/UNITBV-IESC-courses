use gradient_lib::train_single_sample_linear_neuron;

fn main() {
    const X1: f64 = 1.;
    const X2: f64 = 2.;
    const Y : f64 = 5.;

    const C: f64           = 0.01;
    const TOLERANCE: f64   = 1e-6;
    const MAX_ITERS: usize = 10_000;

    const W1_0: f64 = 0.;
    const W2_0: f64 = 0.;

    let (w1, w2) = train_single_sample_linear_neuron(
        W1_0, W2_0,
        X1, X2,
        Y,
        C,
        TOLERANCE,
        MAX_ITERS
    );

    println!("\nFinal weights: w1 = {:.6}, w2 = {:.6}", w1, w2);
    println!("Check: w1 + 2*w2 = {:.6}", w1 + 2. * w2);
    println!("Final error E = {:.6}", 0.5 * (Y - (w1 * X1 + w2 * X2)).powi(2));
}
