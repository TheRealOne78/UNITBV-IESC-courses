struct Data {
    zi: u32,
    luna: u32,
    an: u32,
}

fn fmt_literar(d: &Data) -> String {
    let luni = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    format!("{} {} {}", d.zi, luni[(d.luna - 1) as usize], d.an)
}

fn fmt_iso(d: &Data) -> String {
    format!("{:04}-{:02}-{:02}", d.an, d.luna, d.zi)
}

fn fmt_slash_dmy(d: &Data) -> String {
    format!("{:02}/{:02}/{:04}", d.zi, d.luna, d.an)
}

fn fmt_slash_mdy(d: &Data) -> String {
    format!("{:02}/{:02}/{:04}", d.luna, d.zi, d.an)
}

fn fmt_punct(d: &Data) -> String {
    format!("{:04}.{:02}.{:02}", d.an, d.luna, d.zi)
}

fn fmt_scurt(d: &Data) -> String {
    format!("{}/{}/{}", d.zi, d.luna, d.an % 100)
}

fn fmt_literar_zero(d: &Data) -> String {
    let luni = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    format!("{:02} {} {}", d.zi, luni[(d.luna - 1) as usize], d.an)
}

fn adauga_unu(x: i32) -> i32 { x + 1 }
fn dublu(x: i32) -> i32 { x * 2 }
fn scade_trei(x: i32) -> i32 { x - 3 }
fn patrat(x: i32) -> i32 { x * x }

fn aplica_pipeline(val: i32, pasi: &[fn(i32) -> i32]) -> i32 {
    let mut rezultat = val;
    for (i, f) in pasi.iter().enumerate() {
        rezultat = f(rezultat);
        println!("pas {} -> {}", i + 1, rezultat);
    }
    rezultat
}

fn main() {
    let data = Data { zi: 5, luna: 4, an: 1981 };

    let formate: Vec<fn(&Data) -> String> = vec![
        fmt_literar,
        fmt_iso,
        fmt_slash_dmy,
        fmt_slash_mdy,
        fmt_punct,
        fmt_scurt,
        fmt_literar_zero,
    ];

    for fmt in &formate {
        println!("{}", fmt(&data));
    }

    let pasi: Vec<fn(i32) -> i32> = vec![adauga_unu, dublu, scade_trei, patrat];
    let rezultat = aplica_pipeline(5, &pasi);
    println!("rezultat final: {}", rezultat);
}
