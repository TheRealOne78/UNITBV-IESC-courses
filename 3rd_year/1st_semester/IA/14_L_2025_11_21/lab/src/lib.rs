pub mod kmeans {
    use ndarray::Array1;
    use rand::seq::SliceRandom;
    use rand::thread_rng;
    
    #[derive(Debug, Clone)]
    pub struct KMeans {
        pub k: usize,
        pub centroids: Vec<Array1<f64>>,
        pub max_iterations: usize,
    }
    
    impl KMeans {
        pub fn new(k: usize, max_iterations: usize) -> Self {
            KMeans {
                k,
                centroids: Vec::new(),
                max_iterations,
            }
        }
        
        pub fn distance(&self, a: &Array1<f64>, b: &Array1<f64>) -> f64 {
            (a - b).mapv(|x| x * x).sum().sqrt()
        }
        
        pub fn initialize_centroids(&mut self, patterns: &[Array1<f64>]) {
            let mut rng                 = thread_rng();
            let mut indices: Vec<usize> = (0..patterns.len()).collect();
            
            indices.shuffle(&mut rng);
            
            
            
            
            self.centroids = indices[..self.k]
                .iter()
                .map(|&i| patterns[i].clone())
                .collect();
        }
        
        pub fn assign_to_clusters(&self, patterns: &[Array1<f64>]) -> Vec<usize> {
            patterns
                .iter()
                .map(|pattern| {
                    self.centroids
                        .iter()
                        .enumerate()
                        .map(|(i, centroid)| (i, self.distance(pattern, centroid)))
                        .min_by(|(_, d1), (_, d2)| d1.partial_cmp(d2).unwrap())
                        .unwrap()
                        .0
                })
                .collect()
        }
        
        pub fn update_centroids(&mut self, patterns: &[Array1<f64>], assignments: &[usize]) -> bool {
            let mut new_centroids = vec![Array1::zeros(patterns[0].len()); self.k];
            let mut counts = vec![0; self.k];
            
            // Cluster - sum all points
            for (pattern, &cluster) in patterns.iter().zip(assignments.iter()) {
                new_centroids[cluster] = &new_centroids[cluster] + pattern;
                counts[cluster] += 1;
            }
            
            // Comput e means
            for i in 0..self.k {
                if counts[i] > 0 {
                    new_centroids[i] = &new_centroids[i] / counts[i] as f64;
                }
            }
            
            let changed = self.centroids
                              .iter()
                              .zip(new_centroids.iter())
                              .any(|(old, new)| self.distance(old, new) > 1e-6);
            
            self.centroids = new_centroids;
            changed
        }
        
        pub fn fit(&mut self, patterns: &[Array1<f64>]) -> usize {
            // 1
            self.initialize_centroids(patterns);
            
            let mut iteration = 0;
            loop {
                iteration += 1;
                
                // 2
                let assignments = self.assign_to_clusters(patterns);
                
                // 3
                let changed = self.update_centroids(patterns, &assignments);
                
                // 4
                if !changed || iteration >= self.max_iterations {
                    break;
                }
            }
            
            iteration
        }
        
        pub fn predict(&self, patterns: &[Array1<f64>]) -> Vec<Vec<usize>> {
            let assignments = self.assign_to_clusters(patterns);
            let mut clusters = vec![Vec::new(); self.k];
            
            for (pattern_idx, &cluster_idx) in assignments.iter().enumerate() {
                clusters[cluster_idx].push(pattern_idx);
            }
            
            clusters
        }
    }
}
