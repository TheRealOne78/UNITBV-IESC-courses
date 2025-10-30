use lib_lab::memory::MemoryNetwork;
use rand::seq::IndexedRandom;

fn main() {
    let pattern_0 = vec![
        1, 1, 1,
        1, -1, 1,
        1, 1, 1,
    ];

    let pattern_1 = vec![
        -1, 1, -1,
        -1, 1, -1,
        -1, 1, -1,
    ];

    println!("Digit 0:");
    print_bipolar_pattern(&pattern_0, 3, 3);
    
    println!("\nDigit 1:");
    print_bipolar_pattern(&pattern_1, 3, 3);

    let mut network = MemoryNetwork::new(9);
    network.train(&[pattern_0.clone(), pattern_1.clone()]);

    println!("\nTesting digit 0:");
    let recalled_0 = network.recall(&pattern_0, 10);
    print_bipolar_pattern(&recalled_0, 3, 3);
    println!("Stable: {}\n", recalled_0 == pattern_0);

    println!("\nTesting digit 1:");
    let recalled_1 = network.recall(&pattern_1, 10);
    print_bipolar_pattern(&recalled_1, 3, 3);
    println!("Stable: {}\n", recalled_1 == pattern_1);



    let noisy_0 = vec![
        1, 1, 1,
        1, -1, -1,  // flipped one bit
        1, 1, 1,
    ];

    println!("\n\nNoisy input (digit 0):");
    print_bipolar_pattern(&noisy_0, 3, 3);
    println!("\nRecalled pattern:");
    let recalled_noisy_0 = network.recall(&noisy_0, 10);
    print_bipolar_pattern(&recalled_noisy_0, 3, 3);
    
    if recalled_noisy_0 == pattern_0 {
        println!("Successfully recalled digit 0");
    } else if recalled_noisy_0 == pattern_1 {
        println!("Recalled digit 1");
    } else {
        println!("Recalled an undecisive state");
    }

    let noisy_1 = vec![
        1, 1, -1,   // flipped two bits
        -1, 1, -1,
        -1, 1, -1,
    ];

    println!("\n\nNoisy input (digit 1):");
    print_bipolar_pattern(&noisy_1, 3, 3);
    println!("\nRecalled pattern:");
    let recalled_noisy_1 = network.recall(&noisy_1, 10);
    print_bipolar_pattern(&recalled_noisy_1, 3, 3);
    
    if recalled_noisy_1 == pattern_1 {
        println!("Successfully recalled digit 1");
    } else if recalled_noisy_1 == pattern_0 {
        println!("Recalled digit 0");
    } else {
        println!("Recalled an undecisive state");
    }

    println!("\n\nRandom input pattern:");
    let random: Vec<i32> = (0..9)
        .map(|_| *[1, -1].choose(&mut rand::rng()).unwrap())
        .collect();
    print_bipolar_pattern(&random, 3, 3);
    println!("\nRecalled pattern:");
    let recalled_random = network.recall(&random, 10);
    print_bipolar_pattern(&recalled_random, 3, 3);
    
    if recalled_random == pattern_0 {
        println!("Converged to digit 0");
    } else if recalled_random == pattern_1 {
        println!("Converged to digit 1");
    } else {
        println!("Converged to an undecisive state");
    }
}

fn print_bipolar_pattern(pattern: &[i32], rows: usize, cols: usize) {
    for i in 0..rows {
        for j in 0..cols {
            let idx = i * cols + j;
            let symbol = if pattern[idx] == 1 { '#' } else { ' ' };
            print!("{} ", symbol);
        }
        println!();
    }
}
