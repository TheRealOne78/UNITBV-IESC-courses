use ndarray::{Array1, ArrayView1};
use std::fmt;

#[derive(Debug, Clone, Copy)]
pub enum ActivationFunction {
    BipolarBinary,
    BipolarContinuous(f64), // lambda
}

impl ActivationFunction {
    pub fn apply(&self, net: f64) -> f64 {
        match self {
            ActivationFunction::BipolarBinary => {
                if net >= 0.0 { 1.0 } else { -1.0 }
            }
            ActivationFunction::BipolarContinuous(lambda) => {
                2.0 / (1.0 + (-lambda * net).exp()) - 1.0
            }
        }
    }
}

#[derive(Debug, Clone)]
pub struct HebbianNeuron {
    pub weights: Array1<f64>,
    pub activation: ActivationFunction,
    pub learning_rate: f64,
}

impl HebbianNeuron {
    pub fn new(weights: Vec<f64>, activation: ActivationFunction, learning_rate: f64) -> Self {
        Self {
            weights: Array1::from(weights),
            activation,
            learning_rate,
        }
    }

    pub fn compute_net(&self, input: &ArrayView1<f64>) -> f64 {
        self.weights.dot(input)
    }

    pub fn compute_output(&self, input: &ArrayView1<f64>) -> f64 {
        let net = self.compute_net(input);
        self.activation.apply(net)
    }

    pub fn learn(&mut self, input: &ArrayView1<f64>) -> (f64, f64) {
        let net = self.compute_net(input);
        let output = self.activation.apply(net);
        
        // w_new = w_old + c * o * x
        self.weights = &self.weights + &(self.learning_rate * output * input);
        
        (net, output)
    }

    pub fn weights(&self) -> &Array1<f64> {
        &self.weights
    }
}

impl fmt::Display for HebbianNeuron {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "w = [")?;
        for (i, w) in self.weights.iter().enumerate() {
            if i > 0 {
                write!(f, " ")?;
            }
            write!(f, "{:7.3}", w)?;
        }
        write!(f, "]")
    }
}

pub fn format_vector(v: &[f64]) -> String {
    let mut s = String::from("[");
    for (i, val) in v.iter().enumerate() {
        if i > 0 {
            s.push_str(" ");
        }
        s.push_str(&format!("{:7.3}", val));
    }
    s.push(']');
    s
}
