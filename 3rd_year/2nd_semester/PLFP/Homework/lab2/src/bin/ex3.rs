#[derive(Debug, Clone)]
struct Produs {
    id: u32,
    nume: String,
    pret: f64,
    stoc: u32,
}

#[derive(Debug)]
struct ProdusAfisare {
    id: u32,
    nume: String,
    pret: f64,
}

impl Produs {
    fn nou(id: u32, nume: &str, pret: f64, stoc: u32) -> Produs {
        Produs { id, nume: nume.to_string(), pret, stoc }
    }
}

fn in_afisare(p: Produs) -> ProdusAfisare {
    ProdusAfisare { id: p.id, nume: p.nume, pret: p.pret }
}

fn are_stoc(p: &Produs) -> bool {
    p.stoc > 0
}

fn este_ieftin(p: &Produs) -> bool {
    p.pret < 100.0
}

fn aduna_valoare(acc: f64, p: &Produs) -> f64 {
    acc + p.pret * p.stoc as f64
}

fn cu_reducere_5(p: Produs) -> Produs {
    Produs { pret: p.pret * 0.95, ..p }
}

fn aduna_valoare_owned(acc: f64, p: Produs) -> f64 {
    acc + p.pret * p.stoc as f64
}

fn main() {
    println!("=== 6.3.1 — Adaugare imuabila cu chain ===");
    let produse: Vec<Produs> = vec![
        Produs::nou(1, "Tastatura", 200.0 , 10),
        Produs::nou(2, "Mouse"    , 80.0  , 25),
        Produs::nou(3, "Monitor"  , 1100.0, 5) ,
        Produs::nou(4, "Casti"    , 150.0 , 12),
        Produs::nou(5, "Webcam"   , 90.0  , 8) ,
    ];

    let produs_nou = Produs::nou(6, "Hub USB", 45.0, 30);

    let produse_v2: Vec<Produs> = produse.iter()
        .cloned()
        .chain(std::iter::once(produs_nou))
        .collect();

    println!("Original: {} produse", produse.len());
    println!("Actualizat: {} produse", produse_v2.len());

    let produse_afisare: Vec<Produs> = vec![
        Produs::nou(1, "Tastatura", 200.0 , 10),
        Produs::nou(2, "Mouse"    , 80.0  , 25),
        Produs::nou(3, "Monitor"  , 1100.0, 5) ,
    ];

    let afisare: Vec<ProdusAfisare> = produse_afisare.into_iter()
        .map(in_afisare)
        .collect();

    println!("Produse pentru afisare:");
    for p in &afisare {
        println!("  {:?}", p);
    }

    println!("\n=== 6.3.3 — filter cu predicate ===");
    let produse_filter: Vec<Produs> = vec![
        Produs::nou(1, "Tastatura" , 200.0 , 10),
        Produs::nou(2, "Mouse"     , 80.0  , 0) ,
        Produs::nou(3, "Monitor"   , 1100.0, 5) ,
        Produs::nou(4, "Cablu HDMI", 25.0  , 50),
        Produs::nou(5, "Webcam"    , 90.0  , 3) ,
    ];

    let cu_stoc: Vec<&Produs> = produse_filter.iter()
        .filter(|p| are_stoc(p))
        .collect();
    println!("Produse cu stoc: {}", cu_stoc.len());

    let ieftine: Vec<&Produs> = produse_filter.iter()
        .filter(|p| este_ieftin(p))
        .collect();
    println!("Produse sub 100 lei: {}", ieftine.len());

    let disponibile_ieftine: Vec<&Produs> = produse_filter.iter()
        .filter(|p| are_stoc(p) && este_ieftin(p))
        .collect();
    println!("Disponibile si ieftine: {}", disponibile_ieftine.len());
    for p in &disponibile_ieftine {
        println!("  {} — {:.2} lei, stoc: {}", p.nume, p.pret, p.stoc);
    }

    let produse_fold: Vec<Produs> = vec![
        Produs::nou(1, "Tastatura" , 200.0 , 10),
        Produs::nou(2, "Mouse"     , 80.0  , 25),
        Produs::nou(3, "Monitor"   , 1100.0, 5) ,
        Produs::nou(4, "Cablu HDMI", 25.0  , 50),
        Produs::nou(5, "Webcam"    , 90.0  , 8) ,
    ];

    let valoare_totala: f64 = produse_fold.iter()
        .fold(0.0, aduna_valoare);
    println!("Valoarea totala a stocului: {:.2} lei", valoare_totala);

    let produse_chain: Vec<Produs> = vec![
        Produs::nou(1, "Tastatura" , 200.0 , 10),
        Produs::nou(2, "Mouse"     , 80.0  , 0) ,
        Produs::nou(3, "Monitor"   , 1100.0, 5) ,
        Produs::nou(4, "Cablu HDMI", 25.0  , 50),
        Produs::nou(5, "Webcam"    , 90.0  , 3) ,
    ];

    let total_initial: f64 = produse_chain.iter()
        .filter(|p| are_stoc(p))
        .fold(0.0, aduna_valoare);
    println!("Total stoc disponibil (fara reducere): {:.2} lei", total_initial);

    let total_redus: f64 = produse_chain.iter()
        .filter(|p| are_stoc(p))
        .cloned()
        .map(cu_reducere_5)
        .fold(0.0, aduna_valoare_owned);
    println!("Total dupa reducere 5%: {:.2} lei", total_redus);
    println!("Economie: {:.2} lei", total_initial - total_redus);

    println!("\nOriginalul are {} produse", produse_chain.len());
}
