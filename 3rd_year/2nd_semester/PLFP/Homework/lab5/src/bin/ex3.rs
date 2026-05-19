fn cel_mai_bun_curry(compara: fn(i32, i32) -> bool) -> impl Fn(&[i32]) -> Option<i32> {
    move |nums: &[i32]| {
        nums.iter().copied().reduce(|acc, x| if compara(x, acc) { x } else { acc })
    }
}

fn este_mai_mic(a: i32, b: i32) -> bool { a < b }
fn este_mai_mare(a: i32, b: i32) -> bool { a > b }

fn suma_pare_pana_la(n: usize) -> i32 {
    (0..).filter(|x| x % 2 == 0).take(n).sum()
}

fn suma_pare_curry(n: usize) -> impl Fn() -> i32 {
    move || suma_pare_pana_la(n)
}

#[derive(Debug)]
struct Proiect {
    nume: String,
    activ: bool,
}

fn filtreaza_dupa_activ(activ: bool) -> impl Fn(&Proiect) -> bool {
    move |p| p.activ == activ
}

fn main() {
    let minim_partial = cel_mai_bun_curry(este_mai_mic);
    let maxim_partial = cel_mai_bun_curry(este_mai_mare);

    let v = [7, 3, 10, -1, 8];
    println!("{:?} {:?}", minim_partial(&v), maxim_partial(&v));

    println!("{} {}", suma_pare_pana_la(10), suma_pare_curry(10)());

    let proiecte = [
        Proiect { nume: "Licenta".into(), activ: true },
        Proiect { nume: "Restante".into(), activ: false },
        Proiect { nume: "Orar".into(), activ: true },
    ];

    let filtreaza_active = filtreaza_dupa_activ(true);
    let filtreaza_inactive = filtreaza_dupa_activ(false);

    let active: Vec<&str> = proiecte.iter().filter(|p| filtreaza_active(p)).map(|p| p.nume.as_str()).collect();
    let inactive: Vec<&str> = proiecte.iter().filter(|p| filtreaza_inactive(p)).map(|p| p.nume.as_str()).collect();

    println!("active: {:?}", active);
    println!("inactive: {:?}", inactive);
}
