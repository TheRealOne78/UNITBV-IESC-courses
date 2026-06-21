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
        Produs {
            id,
            nume: nume.to_string(),
            pret,
            stoc,
        }
    }

    fn descriere(&self) -> String {
        format!(
            "[{}] {} — {:.2} lei (stoc: {} buc)",
            self.id, self.nume, self.pret, self.stoc
        )
    }

    fn cu_pret_nou(&self, pret: f64) -> Produs {
        Produs {
            pret,
            ..self.clone()
        }
    }

    fn pentru_afisare(&self) -> ProdusAfisare {
        ProdusAfisare {
            id: self.id,
            nume: self.nume.clone(),
            pret: self.pret,
        }
    }
}

fn aplica_promotie(p: &Produs, discount: f64, stoc_extra: u32) -> Produs {
    Produs {
        pret: p.pret * (1.0 - discount / 100.0),
        stoc: p.stoc + stoc_extra,
        ..p.clone()
    }
}

fn main() {
    // 1
    let p = Produs::nou(1, "idk", 350., 15);
    println!("{}", p.descriere());

    let p_nou = p.cu_pret_nou(299.);
    println!("Cu pret nou: {}", p_nou.descriere());
    println!("Original: {}", p.descriere());

    // 2
    let produs = Produs::nou(2, "Blåhaj 55 cm", 24.9, 8);
    println!("Inainte: {}", produs.descriere());

    let produs_promo = aplica_promotie(&produs, 15., 20);
    println!("Cu pret nou (-15%, +20 stoc): {}", produs_promo.descriere());
    println!("Original: {}", produs.descriere());

    // 3
    let p3 = Produs::nou(3, "Blåhaj 100 cm", 99.9, 4);
    println!("Produs intern: {:?}", p3);

    let p3_afisare = p3.pentru_afisare();
    println!("Produs public: {:?}", p3_afisare);
}
