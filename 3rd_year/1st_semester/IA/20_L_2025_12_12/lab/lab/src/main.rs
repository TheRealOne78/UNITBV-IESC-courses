use lib_lab::backprop::NeuralNetwork;
use ndarray::Array1;

fn main() {
    let pattern_data = vec![
        (45.0, 85.0, 1.0),
        (50.0, 43.0, -1.0),
        (40.0, 80.0, 1.0),
        (187.0, 107.0, -1.0),
        (55.0, 42.0, -1.0),
        (200.0, 43.0, 1.0),
        (48.0, 40.0, -1.0),
        (195.0, 41.0, 1.0),
        (43.0, 87.0, 1.0),
        (192.0, 105.0, -1.0),
        (190.0, 40.0, 1.0),
        (188.0, 100.0, -1.0),
    ];

    // Normalize inputs to [0..1]
    let x_values: Vec<f64> = pattern_data.iter().map(|(x, _, _)| *x).collect();
    let y_values: Vec<f64> = pattern_data.iter().map(|(_, y, _)| *y).collect();
    
    let x_min = x_values.iter().cloned().fold(f64::INFINITY, f64::min);
    let x_max = x_values.iter().cloned().fold(f64::NEG_INFINITY, f64::max);
    let y_min = y_values.iter().cloned().fold(f64::INFINITY, f64::min);
    let y_max = y_values.iter().cloned().fold(f64::NEG_INFINITY, f64::max);

    let inputs: Vec<Array1<f64>> = pattern_data
        .iter()
        .map(|(x, y, _)| {
            let x_norm = (x - x_min) / (x_max - x_min);
            let y_norm = (y - y_min) / (y_max - y_min);
            Array1::from(vec![x_norm, y_norm, -1.0])
        })
        .collect();

    let desired: Vec<Array1<f64>> = pattern_data
        .iter()
        .map(|(_, _, d)| Array1::from(vec![*d]))
        .collect();

    let mut nn = NeuralNetwork::new(3, 3, 1, 0.5, 0.01);
    nn.train(&inputs, &desired, 20000);

    println!("\n{:<10} {:<10} {:<10} {:<10}", "Pattern", "Desired", "Output", "Classified");
    println!("{}", "=".repeat(43));

    for (i, pattern) in inputs.iter().enumerate() {
        println!("{:<10} {:<10.0} {:<10.6} {:<10}",
                 format!("P{}", i + 1),
                 desired[i][0],
                 nn.predict(pattern),
                 nn.classify(pattern));
    }
}
