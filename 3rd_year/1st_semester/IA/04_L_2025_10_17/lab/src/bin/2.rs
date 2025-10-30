use lib_lab::neural::Classifier;

fn main() {
    let cube_vertices = vec![
        vec![0.0, 0.0, 0.0], // 0
        vec![0.0, 0.0, 1.0], // 1
        vec![0.0, 1.0, 0.0], // 2
        vec![0.0, 1.0, 1.0], // 3
        vec![1.0, 0.0, 0.0], // 4
        vec![1.0, 0.0, 1.0], // 5
        vec![1.0, 1.0, 0.0], // 6
        vec![1.0, 1.0, 1.0], // 7
    ];

    let weights = vec![1.0, 1.0, 1.0];
    const BIAS: f64 = -1.5;

    let classifier = Classifier::new(weights, BIAS);

    println!("{:<7} {:^15} {:>5}", "Vertex", "Coords", "Class");
    println!("{:-<29}", "");

    let results = classifier.classify_batch(&cube_vertices);
    
    for (i, (point, &result)) in cube_vertices.iter().zip(results.iter()).enumerate() {
        let class = if result { '1' } else { '0' };
        println!("{:<7} {:^?} {:>5}", 
                 format!("v{}", i), 
                 point, 
                 class);
    }


    let class_1_count = results.iter().filter(|&&x| x).count();
    let class_0_count = results.len() - class_1_count;
    println!("\n\nClass 0: {} vertices", class_0_count);
    println!("Class 1: {} vertices", class_1_count);
}
