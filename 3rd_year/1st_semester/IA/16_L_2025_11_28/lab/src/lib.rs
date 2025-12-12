pub mod genetic {
    use rand::Rng;

    #[derive(Debug, Clone)]
    pub struct Chromosome {
        pub genes: Vec<bool>,
        pub fitness: f64,
    }

    impl Chromosome {
        pub fn new(genes: Vec<bool>) -> Self {
            Chromosome {
                genes,
                fitness: 0.0,
            }
        }


        pub fn random(n: usize) -> Self {
            let mut rng = rand::thread_rng();
            let genes: Vec<bool> = (0..n).map(|_| rng.gen_bool(0.5)).collect();
            Chromosome {
                genes,
                fitness: 0.0,
            }
        }


        pub fn to_binary_string(&self) -> String {
            self.genes.iter().map(|&b| if b { '1' } else { '0' }).collect()
        }
    }

    #[derive(Debug)]
    pub struct GeneticAlgorithm {
        pub population_size: usize,
        pub num_cards: usize,
        pub target_sum: i32,
        pub target_product: i32,
        pub mutation_rate: f64,
        pub crossover_rate: f64,
        pub population: Vec<Chromosome>,
    }

    impl GeneticAlgorithm {
        pub fn new(
            population_size: usize,
            num_cards: usize,
            target_sum: i32,
            target_product: i32,
            mutation_rate: f64,
            crossover_rate: f64,
        ) -> Self {
            GeneticAlgorithm {
                population_size,
                num_cards,
                target_sum,
                target_product,
                mutation_rate,
                crossover_rate,
                population: Vec::new(),
            }
        }

        pub fn initialize_population(&mut self) {
            self.population = (0..self.population_size)
                .map(|_| Chromosome::random(self.num_cards))
                .collect();
        }

        pub fn evaluate_chromosome(&self, chromosome: &Chromosome) -> f64 {
            let mut sum_packet = 0;
            let mut product_packet = 1;

            for (i, &gene) in chromosome.genes.iter().enumerate() {
                let card_value = (i + 1) as i32;
                if gene {
                    product_packet *= card_value;
                } else {
                    sum_packet += card_value;
                }
            }

            let sum_error = (sum_packet - self.target_sum).abs();
            let product_error = (product_packet - self.target_product).abs();
            
            let total_error = sum_error + product_error;

            1.0 / (1.0 + total_error as f64)
        }

        pub fn evaluate_population(&mut self) {
            let fitnesses: Vec<f64> = self.population
                .iter()
                .map(|c| self.evaluate_chromosome(c))
                .collect();
            
            for (chromosome, fitness) in self.population.iter_mut().zip(fitnesses.iter()) {
                chromosome.fitness = *fitness;
            }
        }

        pub fn calculate_selection_probabilities(&self) -> Vec<f64> {
            let total_fitness: f64 = self.population.iter().map(|c| c.fitness).sum();
            
            self.population
                .iter()
                .map(|c| c.fitness / total_fitness)
                .collect()
        }

        pub fn select_parent(&self, probabilities: &[f64]) -> usize {
            let mut rng = rand::thread_rng();
            let r: f64 = rng.gen();
            
            let mut cumulative = 0.0;
            for (i, &prob) in probabilities.iter().enumerate() {
                cumulative += prob;
                if r <= cumulative {
                    return i;
                }
            }
            
            probabilities.len() - 1
        }

        pub fn crossover(&self, parent1: &Chromosome, parent2: &Chromosome) -> (Chromosome, Chromosome) {
            let mut rng = rand::thread_rng();
            
            if rng.gen::<f64>() > self.crossover_rate {
                return (parent1.clone(), parent2.clone());
            }

            let point = rng.gen_range(1..self.num_cards);
            
            let mut child1_genes = parent1.genes[..point].to_vec();
            child1_genes.extend_from_slice(&parent2.genes[point..]);
            
            let mut child2_genes = parent2.genes[..point].to_vec();
            child2_genes.extend_from_slice(&parent1.genes[point..]);
            
            (Chromosome::new(child1_genes), Chromosome::new(child2_genes))
        }

        pub fn mutate(&self, chromosome: &mut Chromosome) {
            let mut rng = rand::thread_rng();
            
            for gene in &mut chromosome.genes {
                if rng.gen::<f64>() < self.mutation_rate {
                    *gene = !*gene;
                }
            }
        }

        pub fn create_next_generation(&mut self) {
            let probabilities      = self.calculate_selection_probabilities();
            let mut new_population = Vec::new();

            while new_population.len() < self.population_size {
                let parent1_idx = self.select_parent(&probabilities);
                let parent2_idx = self.select_parent(&probabilities);
                
                let parent1 = &self.population[parent1_idx];
                let parent2 = &self.population[parent2_idx];
                
                let (mut child1, mut child2) = self.crossover(parent1, parent2);
                
                // Apply mutation
                self.mutate(&mut child1);
                self.mutate(&mut child2);
                
                new_population.push(child1);
                if new_population.len() < self.population_size {
                    new_population.push(child2);
                }
            }

            self.population = new_population;
        }

        pub fn get_best_chromosome(&self) -> &Chromosome {
            self.population
                .iter()
                .max_by(|a, b| a.fitness.partial_cmp(&b.fitness).unwrap())
                .unwrap()
        }

        pub fn calculate_error(&self, chromosome: &Chromosome) -> i32 {
            let mut sum_packet = 0;
            let mut product_packet = 1;

            for (i, &gene) in chromosome.genes.iter().enumerate() {
                let card_value = (i + 1) as i32;
                if gene {
                    product_packet *= card_value;
                } else {
                    sum_packet += card_value;
                }
            }

            let sum_error     = (sum_packet - self.target_sum).abs();
            let product_error = (product_packet - self.target_product).abs();
            
            sum_error + product_error
        }

        pub fn get_packets(&self, chromosome: &Chromosome) -> (Vec<i32>, Vec<i32>) {
            let mut sum_packet = Vec::new();
            let mut product_packet = Vec::new();

            for (i, &gene) in chromosome.genes.iter().enumerate() {
                let card_value = (i + 1) as i32;
                if gene {
                    product_packet.push(card_value);
                } else {
                    sum_packet.push(card_value);
                }
            }

            (sum_packet, product_packet)
        }

        pub fn run(&mut self, max_generations: usize, target_error: i32) -> usize {
            self.initialize_population();
            
            for generation in 0..max_generations {
                self.evaluate_population();
                
                // Get best solution
                let best  = self.get_best_chromosome();
                let error = self.calculate_error(best);
                
                if error <= target_error {
                    return generation + 1;
                }
                
                self.create_next_generation();
            }

            max_generations
        }
    }
}
