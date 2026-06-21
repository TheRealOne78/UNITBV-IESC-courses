use std::cmp::Ordering;
use std::time::Instant;

#[derive(Debug, Clone)]
struct Proiect {
    nume: String,
    activ: bool,
    data_creare: u64,
    data_modificare: u64,
}

#[derive(Debug)]
struct Info {
    nume: String,
    detalii: String,
}

fn sorteaza_dupa(camp: fn(&Proiect) -> u64) -> impl Fn(&Proiect, &Proiect) -> Ordering {
    move |a, b| camp(a).cmp(&camp(b))
}

fn filtreaza_activ(activ: bool) -> impl Fn(&Proiect) -> bool {
    move |p| p.activ == activ
}

fn extrage_info(p: &Proiect) -> Info {
    Info { nume: p.nume.clone(), detalii: format!("modificat: {}", p.data_modificare) }
}

fn main() {
    let proiecte = vec![
        Proiect { nume: "Licenta".into(), activ: true, data_creare: 20240201, data_modificare: 20260508 },
        Proiect { nume: "Restante".into(), activ: false, data_creare: 20240115, data_modificare: 20240310 },
        Proiect { nume: "Orar".into(), activ: true, data_creare: 20231001, data_modificare: 20260224 },
        Proiect { nume: "Factura camin".into(), activ: true, data_creare: 20241105, data_modificare: 20260430 },
        Proiect { nume: "Adeverinta".into(), activ: false, data_creare: 20230920, data_modificare: 20231212 },
        Proiect { nume: "Dosar Erasmus".into(), activ: true, data_creare: 20250110, data_modificare: 20260502 },
        Proiect { nume: "Practica".into(), activ: true, data_creare: 20250303, data_modificare: 20260418 },
        Proiect { nume: "Bursa".into(), activ: false, data_creare: 20241010, data_modificare: 20250107 },
    ];

    let sort_creare = sorteaza_dupa(|p| p.data_creare);
    let sort_modificare = sorteaza_dupa(|p| p.data_modificare);

    let t1 = Instant::now();
    let mut p1: Vec<Proiect> = proiecte.iter().filter(|p| filtreaza_activ(true)(p)).cloned().collect();
    p1.sort_by(sort_modificare);
    let i1: Vec<Info> = p1.iter().map(extrage_info).collect();
    let d1 = t1.elapsed();

    let t2 = Instant::now();
    let mut p2 = Vec::new();
    for p in &proiecte {
        if p.activ {
            p2.push(p.clone());
        }
    }
    p2.sort_by_key(|p| p.data_modificare);
    let mut i2 = Vec::new();
    for p in &p2 {
        i2.push(extrage_info(p));
    }
    let d2 = t2.elapsed();

    for i in &i1 { println!("{}: {}", i.nume, i.detalii); }
    let mut dupa_creare = proiecte.clone();
    dupa_creare.sort_by(sort_creare);
    println!("primul creat: {}", dupa_creare[0].nume);
    println!("pipeline: {:?}", d1);
    println!("imperativ: {:?}", d2);
    println!("{}", i2.len());
}
