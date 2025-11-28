use lib_lab::wta::WinnerTakesAll;
use ndarray::Array1;

fn main() {
    let patterns: Vec<Array1<f64>> = vec![
        Array1::from_vec(vec![45.0, 85.0]),
        Array1::from_vec(vec![50.0, 43.0]),
        Array1::from_vec(vec![40.0, 80.0]),
        Array1::from_vec(vec![55.0, 42.0]),
        Array1::from_vec(vec![200.0, 43.0]),
        Array1::from_vec(vec![48.0, 40.0]),
        Array1::from_vec(vec![195.0, 41.0]),
        Array1::from_vec(vec![43.0, 87.0]),
        Array1::from_vec(vec![190.0, 40.0]),
    ];

    let   learning_rates = vec![1.0, 0.5, 0.1, ];
    const EPOCHS: usize  = 999;

    for &lr in &learning_rates {
        println!("Learning rate: {}", lr);

        let mut wta = WinnerTakesAll::new(3, 2, lr);



        println!("Initial protos:");
        for (i, proto) in wta.prototypes.iter().enumerate() {
            println!("w{}: [{:.2}, {:.2}]", i + 1, proto[0], proto[1]);
        }


        wta.train(&patterns, EPOCHS);


        println!("\nFinal protos:");
        for (i, proto) in wta.prototypes.iter().enumerate() {
            println!("w{}: [{:.2}, {:.2}]", i + 1, proto[0], proto[1]);
        }

        let assings = wta.assign_patterns(&patterns);

        println!("\n\n\n*** PATTERNS ******************");
        for (i, assigned) in assings.iter().enumerate() {
            println!("\nPrototype {}:", i + 1);
            if assigned.is_empty() {
                println!("N/A");
            } else {
                for &pattern_idx in assigned {
                    let p = &patterns[pattern_idx];
                    println!("Pattern {}: [{:.0}, {:.0}]", 
                             pattern_idx + 1, p[0], p[1]);
                }
            }
        }

        println!("\n\n===========================\n")
    }
}
