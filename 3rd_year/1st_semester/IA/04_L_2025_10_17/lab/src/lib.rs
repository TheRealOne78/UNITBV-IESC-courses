pub mod vectors {
    #[derive(Debug, Clone)]
    pub struct Vector {
        pub data: Vec<f64>,
    }

    impl Vector {
        pub fn new(data: Vec<f64>) -> Self {
            Vector { data }
        }

        pub fn dot(&self, other: &Vector) -> f64 {
            self.data.iter()
                .zip(other.data.iter())
                .map(|(a, b)| a * b)
                .sum()
        }

        pub fn magnitude(&self) -> f64 {
            self.data.iter().map(|x| x * x).sum::<f64>().sqrt()
        }

        pub fn cosine_angle(&self, other: &Vector) -> f64 {
            let dot_product = self.dot(other);
            let mag_product = self.magnitude() * other.magnitude();
            dot_product / mag_product
        }
    }
}

pub mod neural {
    #[derive(Debug, Clone)]
    pub struct Perceptron {
        pub weights: Vec<f64>,
        pub bias: f64,
    }

    impl Perceptron {
        pub fn new(weights: Vec<f64>, bias: f64) -> Self {
            Perceptron { weights, bias }
        }

        pub fn weighted_sum(&self, inputs: &[f64]) -> f64 {
            self.weights.iter()
                .zip(inputs.iter())
                .map(|(w, x)| w * x)
                .sum::<f64>() + self.bias
        }

        pub fn step_activation(&self, inputs: &[f64]) -> i32 {
            if self.weighted_sum(inputs) > 0.0 {
                1
            } else {
                0
            }
        }

        pub fn classify(&self, inputs: &[f64]) -> bool {
            self.step_activation(inputs) == 1
        }
    }

    #[derive(Debug)]
    pub struct Classifier {
        perceptron: Perceptron,
    }

    impl Classifier {
        pub fn new(weights: Vec<f64>, bias: f64) -> Self {
            Classifier {
                perceptron: Perceptron::new(weights, bias),
            }
        }

        pub fn classify_point(&self, point: &[f64]) -> bool {
            self.perceptron.classify(point)
        }

        pub fn classify_batch(&self, points: &[Vec<f64>]) -> Vec<bool> {
            points.iter()
                .map(|p| self.classify_point(p))
                .collect()
        }
    }
}

pub mod patterns {
    use super::neural::Perceptron;

    pub type Pattern = Vec<Vec<i32>>;

    pub fn pattern_to_vector(pattern: &Pattern) -> Vec<f64> {
        pattern.iter()
            .flat_map(|row| row.iter())
            .map(|&x| x as f64)
            .collect()
    }

    pub fn print_pattern(pattern: &Pattern) {
        for row in pattern {
            for &val in row {
                print!("{}", val);
            }
            println!();
        }
    }

    #[derive(Debug)]
    pub struct DigitClassifier {
        perceptron: Perceptron,
    }

    impl DigitClassifier {
        pub fn new(weights: Vec<f64>, bias: f64) -> Self {
            DigitClassifier {
                perceptron: Perceptron::new(weights, bias),
            }
        }

        pub fn classify_pattern(&self, pattern: &Pattern) -> i32 {
            let input = pattern_to_vector(pattern);
            self.perceptron.step_activation(&input)
        }

        pub fn test_accuracy(&self, test_patterns: &[(Pattern, i32)]) -> f64 {
            let correct = test_patterns.iter()
                .filter(|(pattern, expected)| {
                    self.classify_pattern(pattern) == *expected
                })
                .count();
            correct as f64 / test_patterns.len() as f64
        }
    }
}

pub mod memory {
    pub type Pattern = Vec<i32>;

    #[derive(Debug, Clone)]
    pub struct MemoryNetwork {
        weights: Vec<Vec<f64>>,
        size: usize,
    }

    impl MemoryNetwork {
        pub fn new(size: usize) -> Self {
            MemoryNetwork {
                weights: vec![vec![0.0; size]; size],
                size,
            }
        }

        pub fn train(&mut self, patterns: &[Pattern]) {
            for pattern in patterns {
                for i in 0..self.size {
                    for j in 0..self.size {
                        if i != j {
                            self.weights[i][j] += (pattern[i] as f64) * (pattern[j] as f64);
                        }
                    }
                }
            }
        }

        pub fn recall(&self, input: &Pattern, max_iterations: usize) -> Pattern {
            let mut state = input.clone();
            let mut previous_state = state.clone();
            
            for iteration in 0..max_iterations {
                for i in 0..self.size {
                    let sum: f64 = (0..self.size)
                        .map(|j| self.weights[i][j] * state[j] as f64)
                        .sum();
                    state[i] = if sum > 0.0 { 1 } else { -1 };
                }

                if state == previous_state {
                    println!("Converged at iter {}", iteration + 1);
                    break;
                }
                previous_state = state.clone();
            }
            
            state
        }

        pub fn pattern_to_matrix(&self, pattern: &Pattern, rows: usize, cols: usize) -> Vec<Vec<i32>> {
            assert_eq!(pattern.len(), rows * cols);
            pattern.chunks(cols)
                .map(|chunk| chunk.to_vec())
                .collect()
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_vector_operations() {
        let v1 = vectors::Vector::new(vec![2.0, 1.0, 2.0]);
        let v2 = vectors::Vector::new(vec![1.0, -1.0, 4.0]);
        
        assert_eq!(v1.dot(&v2), 9.0);
        assert_eq!(v1.magnitude(), 3.0);
    }

    #[test]
    fn test_perceptron() {
        let p = neural::Perceptron::new(vec![1.0, 1.0], 0.0);
        assert_eq!(p.step_activation(&[1.0, 1.0]), 1);
        assert_eq!(p.step_activation(&[-1.0, -1.0]), 0);
    }
}
