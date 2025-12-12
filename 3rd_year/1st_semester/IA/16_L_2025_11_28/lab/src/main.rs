use lib_lab::genetic::GeneticAlgorithm;

fn main() {
    const POPULATION_SIZE: usize = 50;
    const NUM_CARDS: usize       = 10;
    const TARGET_SUM: i32        = 36;
    const TARGET_PRODUCT: i32    = 360;
    const MUTATION_RATE: f64     = 0.01;
    const CROSSOVER_RATE: f64    = 0.7;
    const MAX_GENERATIONS: i32   = 1_000;
    const TARGET_ERROR: i32      = 0;
    const DISPLAY_INTERVAL: i32  = 50;

    let mut ga = GeneticAlgorithm::new(
        POPULATION_SIZE,
        NUM_CARDS,
        TARGET_SUM,
        TARGET_PRODUCT,
        MUTATION_RATE,
        CROSSOVER_RATE,
    );

    ga.initialize_population();
    ga.evaluate_population();

    let mut final_generation = 0;

    for generation in 0..MAX_GENERATIONS {
        final_generation = generation;
        
        ga.evaluate_population();

        let best  = ga.get_best_chromosome();
        let error = ga.calculate_error(best);

        if generation % DISPLAY_INTERVAL == 0 || error <= TARGET_ERROR {
            let (sum_packet, product_packet) = ga.get_packets(best);
            let sum: i32                     = sum_packet.iter().sum();
            let product: i32                 = product_packet.iter().product();

            println!("* Generation {}:", generation);
            println!("\t- Error = {}", error);
            println!("\t- Chromosome: {}", best.to_binary_string());
            println!("\t- Sum packet: {:?} - sum = {}", sum_packet, sum);
            println!("\t- Product packet: {:?} - product = {}", product_packet, product);
            println!("\t- Fitness: {:.6}", best.fitness);
            println!();
        }

        if error <= TARGET_ERROR {
            println!("Found optimal solution");
            break;
        }

        ga.create_next_generation();
    }

    println!("\n\nFINAL RESULTS");

    ga.evaluate_population();
    let best                         = ga.get_best_chromosome();
    let (sum_packet, product_packet) = ga.get_packets(best);
    let sum: i32                     = sum_packet.iter().sum();
    let product: i32                 = product_packet.iter().product();
    let error                        = ga.calculate_error(best);

    println!("Generations executed: {}", final_generation + 1);
    println!("Final err: {}\n", error);

    println!("LEGENDARY CHROMOSOME: {}", best.to_binary_string());
    println!("Fitness: {:.6}\n", best.fitness);

    println!("* Package 1 (Sum target: {}):", TARGET_SUM);
    println!("\t- Cards: {:?}", sum_packet);
    println!("\t- Sum: {}", sum);
    println!("\t- Err: {}\n", (sum - TARGET_SUM).abs());

    println!("* Package 2 (Product target: {}):\n", TARGET_PRODUCT);
    println!("\t- Cards: {:?}", product_packet);
    println!("\t- Product: {}", product);
    println!("\t- Error: {}", (product - TARGET_PRODUCT).abs());
    println!();

    if error == 0 {
        println!("0 error");
    } else if error <= 10 {
        println!("Decent error");
    } else {
        println!("Bad error");
    }

    println!("\n\nCARDS:\n");
    for (i, &gene) in best.genes.iter().enumerate() {
        let card   = i + 1;
        let packet = if gene { "Product" } else { "Sum" };
        println!("{}. {} => {} packet", card, gene as u8, packet);
    }
}
