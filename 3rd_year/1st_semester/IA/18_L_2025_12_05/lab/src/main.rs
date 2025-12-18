use lib_lab::regression::{LinearRegression, load_csv};
use std::process::Command;

fn main() {
    const C: f64        = 0.01;
    const EPOCHS: usize = 1000;

    let (x_data, y_data) = match load_csv("Salary_Data.csv") {
        Ok(data) => data,
        Err(e) => {
            eprintln!("Error loading CSV: {}", e);
            return;
        }
    };

    let mut model = LinearRegression::new(C);
    model.fit(&x_data, &y_data, EPOCHS, true);

    println!("** RESULTS **\n");
    println!("Final regression line: y = {:.3}x + {:.3}", model.w1, model.w2);

    let final_error = model.calculate_error(&x_data,
                                            &y_data);

    println!("Final Err: {:.6}\n\n", final_error);

    println!("Predictions:");
    println!("{:<20} {:<20} {:<20}", "Years", "Actual Salary", "Predicted Salary");

    for i in 0..x_data.len() {
        let predicted = model.predict(x_data[i]);
        println!("{:<20.1} {:<20.3} {:<20.3}", x_data[i], y_data[i], predicted);
    }
    println!();

    // Save data for plotting
    match model.save_for_plotting(&x_data, &y_data, "regression_data.csv") {
        Ok(_)  => println!("Saved regression_data.csv"),
        Err(e) => eprintln!("Error saving data: {}", e),
    }

    match model.save_history("training_history.csv") {
        Ok(_)  => println!("Saved training_history.csv"),
        Err(e) => eprintln!("Error saving history: {}", e),
    }
    println!();

    // Call Julia to plot
    println!("Generating plot --- Julia");
    Command::new("julia")
        .arg("plot_regression.jl")
        .status()
        .expect("failed to run julia");
    println!("DONE");
}
