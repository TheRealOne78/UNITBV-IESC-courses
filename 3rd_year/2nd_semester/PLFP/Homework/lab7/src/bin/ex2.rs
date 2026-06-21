fn f(x: f64, y: f64) -> Option<f64> {
    let num = x + y;
    let den = (x - y).powi(2);
    if den == 0.0 {
        return None;
    }
    let inside = num / den;
    if inside < 0.0 {
        return None;
    }
    let root = inside.sqrt();
    let div = 4.0 * root;
    if div == 0.0 {
        return None;
    }
    Some(x / div)
}

fn aplica_tva_catalog(produse: &[(String, f64)], tva: f64) -> Vec<(String, f64)> {
    produse.iter().map(|(n, p)| (n.clone(), p + p * tva)).collect()
}

fn compune_pure(f: fn(i32) -> i32, g: fn(i32) -> i32) -> impl Fn(i32) -> i32 {
    move |x| f(g(x))
}

fn dublu(x: i32) -> i32 { x * 2 }
fn adauga3(x: i32) -> i32 { x + 3 }

fn main() {
    println!("{:?}", f(10.0, 2.0));
    let p = vec![("Paine".to_string(), 5.5), ("Cafea".to_string(), 20.0)];
    println!("{:?}", aplica_tva_catalog(&p, 0.21));
    println!("{}", compune_pure(dublu, adauga3)(7));
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_f_ok() {
        assert!(f(10.0, 2.0).is_some());
    }

    #[test]
    fn test_f_div_zero() {
        assert_eq!(f(2.0, 2.0), None);
    }

    #[test]
    fn test_f_negative_root() {
        assert_eq!(f(-10.0, 1.0), None);
    }

    #[test]
    fn test_catalog_immutable() {
        let p = vec![("X".to_string(), 100.0)];
        let out = aplica_tva_catalog(&p, 0.21);
        assert_eq!(p[0].1, 100.0);
        assert_eq!(out[0].1, 121.0);
    }

    #[test]
    fn test_compune_pure() {
        let c = compune_pure(dublu, adauga3);
        assert_eq!(c(5), 16);
        assert_eq!(c(5), 16);
    }
}
