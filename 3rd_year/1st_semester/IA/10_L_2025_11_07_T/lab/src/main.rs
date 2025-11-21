use perceptron_learning::{Perceptron, add_bias};
use std::fs::File;
use std::io::{BufRead, BufReader};
use ndarray::Array1;

#[derive(Debug, Clone)]
struct IrisData {
    features: Vec<f64>,
    species: String,
}

impl IrisData {
    fn from_line(line: &str) -> Option<Self> {
        let parts: Vec<&str> = line.trim().split(',').collect();
        if parts.len() != 5 {
            return None;
        }

        let features: Vec<f64> = parts[..4]
            .iter()
            .filter_map(|s| s.parse().ok())
            .collect();

        if features.len() != 4 {
            return None;
        }

        Some(IrisData {
            features,
            species: parts[4].to_string(),
        })
    }
}

fn load_iris_data(filename: &str) -> Result<Vec<IrisData>, std::io::Error> {
    let file = File::open(filename)?;
    let reader = BufReader::new(file);
    
    let mut data = Vec::new();
    for line in reader.lines() {
        let line = line?;
        if let Some(iris) = IrisData::from_line(&line) {
            data.push(iris);
        }
    }
    
    Ok(data)
}

fn main() {
    println!("=== Perceptron Learning - Iris Dataset ===\n");

    let iris_data = match load_iris_data("../iris/iris.data") {
        Ok(data) => data,
        Err(e) => {
            eprintln!("Error loading iris.data: {}", e);
            return







;
        }
    };

    println!("Loaded {}\n", iris_data.len());

    let setosa: Vec<_> = iris_data.iter()
        .filter(|d| d.species == "Iris-setosa")
        .collect();
    
    let versicolor: Vec<_> = iris_data.iter()
        .filter(|d| d.species == "Iris-versicolor")
        .collect();

    // Training data
    let training_setosa = &setosa[..5.min(setosa.len())];
    let training_versicolor = &versicolor[..5.min(versicolor.len())];

    // Remaining testing data TODO: FIXME!!!
    let test_setosa = if setosa.len() > 5 { &setosa[5..] } else { &[] };
    let test_versicolor = if versicolor.len() > 5 { &versicolor[5..] } else { &[] };

    println!("Training set: {} setosa (+1), {} versicolor (-1)",
             training_setosa.len(), training_versicolor.len());
    println!("Test set: {} setosa, {} versicolor\n",
             test_setosa.len(), test_versicolor.len());

    let mut training_data: Vec<(Array1<f64>, i8)> = Vec::new();
    for iris in training_setosa {
        training_data.push((add_bias(&iris.features), 1));
    }
    for iris in training_versicolor {
        training_data.push((add_bias(&iris.features), -1));
    }

    let mut test_data: Vec<(Array1<f64>, i8)> = Vec::new();
    for iris in test_setosa {
        test_data.push((add_bias(&iris.features), 1));
    }
    for iris in test_versicolor {
        test_data.push((add_bias(&iris.features), -1));
    }

    let learning_rate = 0.1;
    let max_epochs    = 100;
    
    let mut perceptron = Perceptron::new(4, learning_rate);
    
    println!("Initial weights: {:?}\n", perceptron.weights());

    // Train the perceptron
    println!("Starting training...");
    let epochs_needed = perceptron.train(&training_data, max_epochs);
    
    if ! epochs_needed < max_epochs {
        println!("Training not converged! {} epochs", max_epochs);
    }
    
    println!("Final weights: {:?}\n", perceptron.weights());

    println!("#### Testing ################\n");
    
    if !test_data.is_empty() {
        
        let setosa_test: Vec<_> = test_data.iter()
            .filter(|(_, desired)| *desired == 1)
            .cloned()
            .collect();
        
        let versicolor_test: Vec<_> = test_data.iter()
            .filter(|(_, desired)| *desired == -1)
            .cloned()
            .collect();
        
        if !setosa_test.is_empty() {
            let setosa_accuracy = perceptron.test(&setosa_test);
            println!("Iris-setosa accuracy: {:.2}% ({}/{})",
                     setosa_accuracy,
                     (setosa_accuracy * setosa_test.len() as f64 / 100.0).round() as usize,
                     setosa_test.len());
        }
        
        if !versicolor_test.is_empty() {
            let versicolor_accuracy = perceptron.test(&versicolor_test);
            println!("Iris-versicolor accuracy: {:.2}% ({}/{})",
                     versicolor_accuracy,
                     (versicolor_accuracy * versicolor_test.len() as f64 / 100.0).round() as usize,
                     versicolor_test.len());
        }
    } else {
        println!("NO DATA AVAILABLE");
    }

    println!("\n#### Predictions ############\n");
    
    for (i, (x, desired)) in test_data.iter().take(5).enumerate() {
        let prediction = perceptron.predict(&x.view());
        let species = if *desired == 1 { "setosa" } else { "versicolor" };
        println!("Sample {}: Features: [{:.1}, {:.1}, {:.1}, {:.1}] --- Predicted: {:+}, Expected: {:+} ({})",
                 i + 1,
                 x[1], x[2], x[3], x[4],
                 prediction,
                 desired,
                 species);
    }
}
