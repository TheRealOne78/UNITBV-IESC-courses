
pub mod regression {
    use std::fs::File;
    use std::io::Write;
    use ndarray::Array1;

    #[derive(Debug, Clone)]
    pub struct LinearRegression {
        pub w1: f64,
        pub w2: f64,
        pub learning_rate: f64,
        pub history: Vec<(f64, f64, f64)>,
    }

    impl LinearRegression {
        pub fn new(learning_rate: f64) -> Self {
            LinearRegression {
                w1: 0.0,
                w2: 0.0,
                learning_rate,
                history: Vec::new(),
            }
        }

        pub fn predict(&self, x: f64) -> f64 {
            self.w1 * x + self.w2
        }

        pub fn calculate_error(&self, x_data: &Array1<f64>, y_data: &Array1<f64>) -> f64 {
            let n              = x_data.len() as f64;
            let predictions    = x_data.mapv(|x| self.predict(x));
            let errors         = y_data - &predictions;
            let squared_errors = errors.mapv(|e| e * e);
            squared_errors.sum() / (2.0 * n)
        }

        fn partial_derivative_w1(&self, x_data: &Array1<f64>, y_data: &Array1<f64>) -> f64 {
            let n           = x_data.len() as f64;
            let predictions = x_data.mapv(|x| self.predict(x));
            let errors      = y_data - &predictions;
            let gradient    = (&errors * x_data).sum();
            -gradient / n
        }

        fn partial_derivative_w2(&self, x_data: &Array1<f64>, y_data: &Array1<f64>) -> f64 {
            let n           = x_data.len() as f64;
            let predictions = x_data.mapv(|x| self.predict(x));
            let errors      = y_data - &predictions;
            -errors.sum() / n
        }

        pub fn gradient_step(&mut self, x_data: &Array1<f64>, y_data: &Array1<f64>) {
            let grad_w1 = self.partial_derivative_w1(x_data, y_data);
            let grad_w2 = self.partial_derivative_w2(x_data, y_data);

            self.w1 -= self.learning_rate * grad_w1;
            self.w2 -= self.learning_rate * grad_w2;
        }

        pub fn fit(&mut self, x_data: &Array1<f64>, y_data: &Array1<f64>, epochs: usize, verbose: bool) {
            self.history.clear();

            for epoch in 0..epochs {
                let error = self.calculate_error(x_data, y_data);
                
                self.history.push((self.w1, self.w2, error));

                self.gradient_step(x_data, y_data);

                if verbose && (epoch % 100 == 0 || epoch == epochs - 1) {
                    println!("Epoch {}: w1 = {:.6}, w2 = {:.6}, Error = {:.6}", 
                             epoch, self.w1, self.w2, error);
                }
            }

            let final_error = self.calculate_error(x_data, y_data);
            self.history.push((self.w1, self.w2, final_error));
        }

        pub fn save_for_plotting(&self, x_data: &Array1<f64>, y_data: &Array1<f64>, filename: &str) -> std::io::Result<()> {
            let mut file = File::create(filename)?;
            
            writeln!(file, "x,y_actual,y_predicted")?;
            
            for i in 0..x_data.len() {
                let predicted = self.predict(x_data[i]);
                writeln!(file, "{},{},{}", x_data[i], y_data[i], predicted)?;
            }
            
            Ok(())
        }

        pub fn save_history(&self, filename: &str) -> std::io::Result<()> {
            let mut file = File::create(filename)?;
            
            writeln!(file, "epoch,w1,w2,error")?;
            
            for (epoch, (w1, w2, error)) in self.history.iter().enumerate() {
                writeln!(file, "{},{},{},{}", epoch, w1, w2, error)?;
            }
            
            Ok(())
        }

        pub fn r_squared(&self, x_data: &Array1<f64>, y_data: &Array1<f64>) -> f64 {
            let y_mean      = y_data.mean().unwrap();
            let ss_tot      = y_data.mapv(|y| (y - y_mean).powi(2)).sum();
            let predictions = x_data.mapv(|x| self.predict(x));
            let residuals   = y_data - &predictions;
            let ss_res      = residuals.mapv(|r| r.powi(2)).sum();
            
            1.0 - (ss_res / ss_tot)
        }
    }

    pub fn load_csv(filename: &str) -> Result<(Array1<f64>, Array1<f64>), Box<dyn std::error::Error>> {
        use csv::ReaderBuilder;
        
        let mut reader = ReaderBuilder::new()
            .has_headers(true)
            .from_path(filename)?;
        
        let mut x_data = Vec::new();
        let mut y_data = Vec::new();
        
        for result in reader.records() {
            let record = result?;
            let x: f64 = record[0].parse()?;
            let y: f64 = record[1].parse()?;
            x_data.push(x);
            y_data.push(y);
        }
        
        Ok((x_data.into(), y_data.into()))
    }
}
