const TVA: f64 = 0.21; // :3

fn pret_cu_tva(pret: f64) -> f64 {
    pret + pret * TVA
}

fn aplica_discount(pret: f64, procent: f64) -> f64 {
    pret * (1.0 - procent / 100.0)
}

// const MAX: f64 = f64::sqrt(2.0);
//
// f64::sqrt() executes at runtime, not compile-time.
// A const has to be evaled by the comipler.

fn main() {
    // 1
    println!("* 1");
    let pret_baza = 100.0;
    let pret_final = pret_cu_tva(pret_baza);
    println!("Pret fara TVA: {:.2} lei", pret_baza);
    println!("TVA ({}%): {:.2} lei", TVA * 100.0, pret_baza * TVA);
    println!("Pret cu TVA: {:.2} lei", pret_final);

    // 2
    println!("\n\n* 2");
    let pret = 67.0;
    println!("Pret initial: {:.2} lei", pret);

    let pret = aplica_discount(pret, 15.0);
    println!("15%: {:.2} lei", pret);

    let pret = aplica_discount(pret, 10.0);
    println!("10%: {:.2} lei", pret);

    let pret = aplica_discount(pret, 5.0);
    println!("5%: {} lei", pret);

    // 3
    println!("\n\n* 3.");
    let max = f64::sqrt(4.0);
    println!("sqrt 4 = {}", max);
}
