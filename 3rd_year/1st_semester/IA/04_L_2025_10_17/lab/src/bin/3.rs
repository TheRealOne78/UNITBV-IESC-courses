use lib_lab::patterns::{DigitClassifier, Pattern, print_pattern};

fn main() {
    let training_0_variants: Vec<Pattern> = vec![
        vec![
            vec![1, 1, 1],
            vec![1, 0, 1],
            vec![1, 1, 1],
        ],
        vec![
            vec![0, 1, 0],
            vec![1, 0, 1],
            vec![0, 1, 0],
        ],
    ];

    let training_1_variants: Vec<Pattern> = vec![
        vec![
            vec![0, 1, 0],
            vec![0, 1, 0],
            vec![0, 1, 0],
        ],
        vec![
            vec![1, 1, 0],
            vec![0, 1, 0],
            vec![0, 1, 0],
        ],
    ];

    println!("\nDigit 0, Variant 1:");
    print_pattern(&training_0_variants[0]);

    println!("\nDigit 0, Variant 2:");
    print_pattern(&training_0_variants[1]);

    println!("\nDigit 1, Variant 1:");
    print_pattern(&training_1_variants[0]);

    println!("\nDigit 1, Variant 2:");
    print_pattern(&training_1_variants[1]);
    println!();

    let weights = vec![
        1.0, 1.0, 1.0, 
        1.0, -2.0, 1.0,
        1.0, 1.0, 1.0,
    ];
    const BIAS: f64 = -3.0;

    let classifier = DigitClassifier::new(weights, BIAS);

    for (i, pattern) in training_0_variants.iter().enumerate() {
        let result = classifier.classify_pattern(pattern);
        println!("Digit 0 variant {}: classified as {} (expected 1)", i + 1, result);
    }
    
    for (i, pattern) in training_1_variants.iter().enumerate() {
        let result = classifier.classify_pattern(pattern);
        println!("Digit 1 variant {}: classified as {} (expected 0)", i + 1, result);
    }

    let perturbed_patterns = vec![
        /* Expected - 1 */
        (vec![
            vec![1, 1, 1],
            vec![1, 0, 0],  // missing pixel
            vec![1, 1, 1],
        ], 1, "Perturbed 0 (missing pixel)"),
        (vec![
            vec![0, 1, 1],
            vec![1, 0, 1],
            vec![1, 1, 0],  // shift
        ], 1, "Perturbed 0 (shift)"),
        (vec![
            vec![1, 1, 1],
            vec![1, 1, 1],  // fill
            vec![1, 1, 1],
        ], 1, "Perturbed 0 (filled)"),
        
        /* Expected - 0 */
        (vec![
            vec![0, 1, 0],
            vec![0, 1, 1],  // +1 pixel
            vec![0, 1, 0],
        ], 0, "Perturbed 1 (extra pixel)"),
        (vec![
            vec![1, 1, 0],
            vec![0, 0, 0],  // no middle
            vec![0, 1, 0],
        ], 0, "Perturbed 1 (broken)"),
        (vec![
            vec![0, 0, 1],  // shif right
            vec![0, 0, 1],
            vec![0, 0, 1],
        ], 0, "Perturbed 1 (shifted)"),
    ];

    let mut correct = 0;
    let total       = perturbed_patterns.len();

    for (pattern, expected, description) in &perturbed_patterns {
        let result = classifier.classify_pattern(pattern);
        let is_correct = result == *expected;
        if is_correct {
            correct += 1;
        }
        
        println!("{}:", description);
        print_pattern(pattern);
        println!("Classified: {} (expected: {}) - {}\n", 
                 result, expected, 
                 if is_correct { "RIGHT" } else { "WRONG" });
    }

    let accuracy = (correct as f64 / total as f64) * 100.0;
    println!("Accuracy: {}/{} ({:.1}%)", correct, total, accuracy);
}
