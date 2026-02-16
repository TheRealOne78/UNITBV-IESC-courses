pub mod backprop {
    use ndarray::{Array1, Array2};
    use rand::distr::{Distribution, Uniform};

    #[derive(Debug, Clone)]
    pub struct NeuralNetwork {
        pub v: Array2<f64>,
        pub w: Array2<f64>,
        pub learning_rate: f64,
        pub max_error:     f64,
        pub num_inputs:    usize,
        pub num_hidden:    usize,
        pub num_outputs:   usize,
    }

    impl NeuralNetwork {
        pub fn new(
            num_inputs:    usize,
            num_hidden:    usize,
            num_outputs:   usize,
            learning_rate: f64,
            max_error:     f64,
        ) -> Self {
            let mut rng = rand::rng();
            let dist    = Uniform::new(-1.0, 1.0).unwrap();



            let v = Array2::from_shape_fn((num_hidden, num_inputs), |_| {
                dist.sample(&mut rng)
            });

            let w = Array2::from_shape_fn((num_outputs, num_hidden + 1), |_| {
                dist.sample(&mut rng)
            });

            NeuralNetwork {
                v,
                w,
                learning_rate,
                max_error,
                num_inputs,
                num_hidden,
                num_outputs,
            }
        }

        fn activation(&self, net: f64) -> f64 {
            2.0 / (1.0 + (-net).exp()) - 1.0
        }

        pub fn forward(&self, input: &Array1<f64>) -> (Array1<f64>, Array1<f64>) {
            let mut y = Array1::zeros(self.num_hidden);
            for j in 0..self.num_hidden {
                let net = self.v.row(j).dot(input);
                y[j]    = self.activation(net);
            }

            let mut y_with_bias = Array1::zeros(self.num_hidden + 1);
            for j in 0..self.num_hidden {
                y_with_bias[j] = y[j];
            }
            y_with_bias[self.num_hidden] = -1.0;

            let mut o = Array1::zeros(self.num_outputs);
            for k in 0..self.num_outputs {
                let net = self.w.row(k).dot(&y_with_bias);
                o[k]    = self.activation(net);
            }

            (y, o)
        }

        fn train_pattern(&mut self, input: &Array1<f64>, desired: &Array1<f64>) -> f64 {
            let (y, o) = self.forward(input);

            // 3- Calculate error signals
            let mut delta_o = Array1::zeros(self.num_outputs);
            for k in 0..self.num_outputs {
                delta_o[k] = 0.5 * (desired[k] - o[k]) * (1.0 - o[k] * o[k]);
            }

            let mut delta_y = Array1::zeros(self.num_hidden);
            for j in 0..self.num_hidden {
                let mut sum = 0.0;
                for k in 0..self.num_outputs {
                    sum += delta_o[k] * self.w[[k, j]];
                }
                delta_y[j] = 0.5 * (1.0 - y[j] * y[j]) * sum;
            }

            // 4 - Update weights
            for k in 0..self.num_outputs {
                for j in 0..self.num_hidden {
                    self.w[[k, j]] += self.learning_rate * delta_o[k] * y[j];
                }
                self.w[[k, self.num_hidden]] += self.learning_rate * delta_o[k] * (-1.0);
            }

            for j in 0..self.num_hidden {
                for i in 0..self.num_inputs {
                    self.v[[j, i]] += self.learning_rate * delta_y[j] * input[i];
                }
            }

            // 5 - Calculate cumulative error
            let mut error = 0.0;
            for k in 0..self.num_outputs {
                error += 0.5 * (desired[k] - o[k]).powi(2);
            }
            error
        }

        pub fn train(
            &mut self,
            patterns: &[Array1<f64>],
            desired_outputs: &[Array1<f64>],
            max_epochs: usize,
        ) -> usize {
            let mut epoch = 0;

            loop {
                epoch += 1;
                let mut total_error = 0.0;

                for p in 0..patterns.len() {
                    let error = self.train_pattern(&patterns[p], &desired_outputs[p]);
                    total_error += error;
                }

                if epoch % 50 == 0 || epoch == 1 {
                    println!("Epoch {}:\tError = {:.6}", epoch, total_error);
                }

                if total_error <= self.max_error {
                    println!("Target at epoch {} w/ error {:.6}", epoch, total_error);
                    break;
                }

                if epoch >= max_epochs {
                    println!("REACHED MAX EPOCHS w/ error {:.6}", total_error);
                    break;
                }
            }

            epoch
        }

        pub fn predict(&self, input: &Array1<f64>) -> f64 {
            let (_, o) = self.forward(input);
            o[0]
        }

        pub fn classify(&self, input: &Array1<f64>) -> i32 {
            if self.predict(input) > 0.0 { 1 } else { -1 }
        }
    }
}
