use lib_lab::kmeans::KMeans;
use ndarray::Array1;

fn main()  {
    let patterns: Vec<Array1<f64>> = vec![
        Array1::from_vec(vec![45. , 85.]), // P1
        Array1::from_vec(vec![50. , 43.]), // P2
        Array1::from_vec(vec![40. , 80.]), // P3
        Array1::from_vec(vec![55. , 42.]), // P4
        Array1::from_vec(vec![200., 43.]), // P5
        Array1::from_vec(vec![48. , 40.]), // P6
        Array1::from_vec(vec![195., 41.]), // P7
        Array1::from_vec(vec![43. , 87.]), // P8
        Array1::from_vec(vec![190., 40.]), // P9
    ];
    
    let mut kmeans = KMeans::new(3, 100);
    
    let iterations = kmeans.fit(&patterns);
    println!("ITERATIOS: {}\n", iterations);
    
    println!("FINAL CENTROIDS:");
    for (i, centroid) in kmeans.centroids.iter().enumerate() {
        println!("\t{}: [{:.2}, {:.2}]",
                 i + 1,
                 centroid[0],
                 centroid[1]
        );
    }
    
    let clusters = kmeans.predict(&patterns);
    
    for (cluster_idx, pattern_indices) in clusters.iter().enumerate() {
        println!("\n\t* Cluster {}", cluster_idx + 1);
        
        for &pattern_idx in pattern_indices {
            let p = &patterns[pattern_idx];
            println!("\t\t- P{}: {}",
                     pattern_idx + 1,
                     p
            );
        }
    }
}
