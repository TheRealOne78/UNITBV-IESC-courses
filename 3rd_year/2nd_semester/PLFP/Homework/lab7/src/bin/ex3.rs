#[derive(Clone, Debug)]
struct Produs {
    nume: String,
    pret: f64,
    stoc: u32,
}

fn filtreaza_disponibile(produse: &[Produs]) -> Vec<Produs> {
    produse.iter().filter(|p| p.stoc > 0).cloned().collect()
}

fn aplica_discount(produse: &[Produs], procent: f64) -> Vec<Produs> {
    produse
        .iter()
        .map(|p| Produs { nume: p.nume.clone(), pret: p.pret * (1.0 - procent / 100.0), stoc: p.stoc })
        .collect()
}

fn total_stoc(produse: &[Produs]) -> f64 {
    produse.iter().map(|p| p.pret * p.stoc as f64).sum()
}

fn main() {
    let produse = vec![
        Produs { nume: "Paine".into(), pret: 5.5, stoc: 3 },
        Produs { nume: "Lapte".into(), pret: 7.0, stoc: 0 },
        Produs { nume: "Cafea".into(), pret: 20.0, stoc: 2 },
    ];

    let disponibile = filtreaza_disponibile(&produse);
    let reduse = aplica_discount(&disponibile, 10.0);
    println!("{:.2}", total_stoc(&reduse));
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_filtreaza() {
        let p = vec![
            Produs { nume: "A".into(), pret: 10.0, stoc: 1 },
            Produs { nume: "B".into(), pret: 20.0, stoc: 0 },
        ];
        assert_eq!(filtreaza_disponibile(&p).len(), 1);
    }

    #[test]
    fn test_discount() {
        let p = vec![Produs { nume: "Paine".into(), pret: 100.0, stoc: 1 }];
        let r = aplica_discount(&p, 10.0);
        assert_eq!(r[0].pret, 90.0);
    }

    #[test]
    fn test_total() {
        let p = vec![
            Produs { nume: "Paine".into(), pret: 10.0, stoc: 2 },
            Produs { nume: "Lapte".into(), pret: 5.0, stoc: 3 },
        ];
        assert_eq!(total_stoc(&p), 35.0);
    }
}
