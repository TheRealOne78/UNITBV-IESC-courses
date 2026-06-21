use ndarray::{Array1, ArrayView1};
use rand::Rng;

pub struct Perceptron {
    weights: Array1<f64>,
    learning_rate: f64,
}

impl Perceptron {
    pub fn new(input_size: usize, learning_rate: f64) -> Self {
        let mut rng = rand::thread_rng();
        // Init random values between -0.5..0.5
        let weights = Array1::from_vec(
            (0..=input_size)
                .map(|_| rng.gen_range(-0.5..0.5))
                .collect()
        );
        
        Self {
            weights,
            learning_rate,
        }
    }

    fn sgn(net: f64) -> i8 {
        if net >= 0.0 {
            1
        } else {
            -1
        }
    }

    fn compute_net(&self, x: &ArrayView1<f64>) -> f64 {
        self.weights.dot(x)
    }

    pub fn predict(&self, x: &ArrayView1<f64>) -> i8 {
        let net = self.compute_net(x);
        Self::sgn(net)
    }

    pub fn train_step(&mut self, x: &ArrayView1<f64>, desired: i8) -> bool {
        let net = self.compute_net(x);
        let output = Self::sgn(net);
        
        let error = desired - output;
        
        if error != 0 {
            let delta = x.mapv(|xi| self.learning_rate * (error as f64) * xi);
            self.weights = &self.weights + &delta;
            true
        } else {
            false
        }
    }

    pub fn train(&mut self, data: &[(Array1<f64>, i8)], max_epochs: usize) -> usize {
        for epoch in 0..max_epochs {
            let mut cumulative_error = 0;
            
            for (x, desired) in data {
                if self.train_step(&x.view(), *desired) {
                    cumulative_error += 1;
                }
            }
            
            if cumulative_error == 0 {
                return epoch + 1;
            }
        }
        
        max_epochs
    }

    pub fn test(&self, data: &[(Array1<f64>, i8)]) -> f64 {
        if data.is_empty() {
            return 0.0;
        }
        
        let correct = data.iter()
            .filter(|(x, desired)| self.predict(&x.view()) == *desired)
            .count();
        
        (correct as f64 / data.len() as f64) * 100.0
    }

    /// Returns a reference to the weight vector
    pub fn weights(&self) -> &Array1<f64> {
        &self.weights
    }
}

pub fn add_bias(features: &[f64]) -> Array1<f64> {
    let mut extended = Vec::with_capacity(features.len() + 1);
    extended.push(1.0); // bias component
    extended.extend_from_slice(features);
    Array1::from_vec(extended)
}
