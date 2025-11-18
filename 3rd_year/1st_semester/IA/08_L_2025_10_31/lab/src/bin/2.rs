use lib_lab::{ActivationFunction, HebbianNeuron, format_vector};
use ndarray::Array1;

fn main() {
    let patterns = vec![
        vec![1.0, -2.0],
        vec![0.0, 1.0],
        vec![2.0, 3.0],
        vec![1.0, -1.0],
    ];

    let initial_weights = vec![1.0, -1.0];
    
    println!("\nInitial weights: w0 = {}", format_vector(&initial_weights));
    println!("Learning rate: c = 1\n");

    // a) BipolarBinary 
    println!("=== Part a: Bipolar Binary (sgn) ===\n");
    
    let mut neuron_binary = HebbianNeuron::new(
        initial_weights.clone(),
        ActivationFunction::BipolarBinary,
        1.0,
    );

    for (step, pattern) in patterns.iter().enumerate() {
        println!("Step {}:", step + 1);
        println!("x{} = {}", step + 1, format_vector(pattern));
        
        let pattern_array = Array1::from(pattern.clone());
        let (net, output) = neuron_binary.learn(&pattern_array.view());
        
        println!("net = {:.3}, o = {:.3}", net, output);
        println!("{}", neuron_binary);
        println!();
    }

    // b) BipolarContinuous
    println!("\n=== BipolarContinuous ==================\n\n");
    
    let mut neuron_continuous = HebbianNeuron::new(
        initial_weights.clone(),
        ActivationFunction::BipolarContinuous(1.0),
        1.0,
    );

    for (step, pattern) in patterns.iter().enumerate() {
        println!("Step {}:", step + 1);
        println!("x{} = {}", step + 1, format_vector(pattern));
        
        let pattern_array = Array1::from(pattern.clone());
        let (net, output) = neuron_continuous.learn(&pattern_array.view());
        
        println!("net = {:.3}, o = {:.3}", net, output);
        println!("{}", neuron_continuous);
        println!();
    }
}
