use std::cmp::Ordering;

#[derive(Debug, Clone)]
struct Album {
    titlu: String,
    gen: String,
}

fn cel_mai_bun_dupa<'a>(albume: &'a [Album], cheie: fn(&Album) -> &str) -> Option<&'a Album> {
    albume.iter().min_by(|a, b| cheie(a).cmp(cheie(b)))
}

fn main() {
    let mut albume = vec![
        Album { titlu: "Black Monday".into(), gen: "Metal".into() },
        Album { titlu: "Scientist".into(), gen: "Dub".into() },
        Album { titlu: "Fireworks".into(), gen: "Pop".into() },
        Album { titlu: "Fade".into(), gen: "Pop".into() },
        Album { titlu: "Undertow".into(), gen: "Metal".into() },
    ];

    albume.sort_by(|a, b| {
        let g = a.gen.cmp(&b.gen);
        if g == Ordering::Equal { a.titlu.cmp(&b.titlu) } else { g }
    });

    for a in &albume {
        println!("{} - {}", a.gen, a.titlu);
    }

    let minim_dupa_titlu = cel_mai_bun_dupa(&albume, |a| &a.titlu).unwrap();
    println!("min titlu: {:?}", minim_dupa_titlu);

    let div7: Vec<i32> = (1..=1000).filter(|n| n % 7 == 0).collect();
    let suma: i32 = div7.iter().sum();
    println!("count: {}, suma: {}", div7.len(), suma);
}
