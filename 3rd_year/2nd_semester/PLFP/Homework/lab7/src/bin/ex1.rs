// regula 1+2+3+4: depinde de stare globala, fara parametri, nedeterminist daca starea se schimba, efect secundar
static TVA: f64 = 0.21;
fn calculeaza_tva_impura() -> f64 { 100.0 * TVA }

struct Appender {
    sufix: String,
}

impl Appender {
    fn append_to_word_impura(&self, baza: &str) -> String {
        format!("{}{}", baza, self.sufix)
    }
}

fn append_to_word_pura(baza: &str, sufix: &str) -> String {
    format!("{}{}", baza, sufix)
}

fn pret_total(pret: f64, tva: f64) -> f64 {
    pret + pret * tva
}

fn adauga(v: &[i32], item: i32) -> Vec<i32> {
    let mut rez = v.to_vec();
    rez.push(item);
    rez
}

fn main() {
    let a = Appender { sufix: "!".into() };
    println!("{}", calculeaza_tva_impura());
    println!("{} {}", a.append_to_word_impura("Salut"), append_to_word_pura("Salut", "!"));
    println!("{} {:?}", pret_total(100.0, 0.21), adauga(&[1, 2, 3], 4));
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_append_pura() {
        assert_eq!(append_to_word_pura("ana", "_x"), "ana_x");
    }

    #[test]
    fn test_pret_total_pura() {
        assert_eq!(pret_total(10.0, 0.21), 12.1);
    }

    #[test]
    fn test_adauga_pura() {
        let v = vec![1, 2, 3];
        let v2 = adauga(&v, 4);
        assert_eq!(v, vec![1, 2, 3]);
        assert_eq!(v2, vec![1, 2, 3, 4]);
    }
}
