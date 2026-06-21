#[derive(Debug, Clone)]
struct Fel {
    id: u32,
    descriere: String,
    calorii: u32,
    pret: f64,
}

impl Fel {
    fn nou(id: u32, descriere: &str, calorii: u32, pret: f64) -> Fel {
        Fel {
            id,
            descriere: descriere.to_string(),
            calorii,
            pret,
        }
    }
}

fn afis_scurt(f: &Fel) -> String {
    format!("[{}] {}", f.id, f.descriere)
}

fn afis_complet(f: &Fel) -> String {
    format!("[{}] {} | {} kcal | {:.2} lei", f.id, f.descriere, f.calorii, f.pret)
}

fn tipareste_meniu(mese: &[Fel], fmt: fn(&Fel) -> String) {
    for f in mese {
        println!("{}", fmt(f));
    }
}

fn main() {
    let mese = vec![
        Fel::nou(1, "Supa de legume", 210, 17.0),
        Fel::nou(2, "Piept de pui cu orez", 540, 31.5),
        Fel::nou(3, "Clatite", 430, 19.0),
    ];

    let formatari: Vec<fn(&Fel) -> String> = vec![afis_scurt, afis_complet];

    for fmt in &formatari {
        for f in &mese {
            println!("{}", fmt(f));
        }
        println!();
    }

    tipareste_meniu(&mese, afis_scurt);
    println!();
    tipareste_meniu(&mese, afis_complet);
}
