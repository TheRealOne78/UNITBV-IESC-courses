fn minim<T: PartialOrd + Clone>(lista: &[T]) -> Option<T> {
    if lista.is_empty() {
        return None;
    }

    let mut min = lista[0].clone();
    for el in lista.iter() {
        if *el < min {
            min = el.clone();
        }
    }
    Some(min)
}

#[derive(Debug)]
struct Interval<T> {
    min: T,
    max: T,
}

impl<T: PartialOrd> Interval<T> {
    fn nou(min: T, max: T) -> Interval<T> {
        Interval { min, max }
    }

    fn contine(&self, val: &T) -> bool {
        val >= &self.min && val <= &self.max
    }
}

#[derive(Debug, Clone)]
struct Catalog<T> {
    titlu: String,
    inregistrari: Vec<T>,
}

impl<T: Clone> Catalog<T> {
    fn nou(titlu: &str) -> Self {
        Catalog { titlu: titlu.to_string(), inregistrari: Vec::new() }
    }

    fn adauga(&self, el: T) -> Catalog<T> {
        let mut noua_lista = self.inregistrari.clone();
        noua_lista.push(el);
        Catalog { inregistrari: noua_lista, ..self.clone() }
    }

    fn count(&self) -> usize {
        self.inregistrari.len()
    }

    fn filtreaza_catalog(&self, pred: fn(&T) -> bool) -> Catalog<T> {
        let filtrat: Vec<T> = self.inregistrari.iter()
            .filter(|el| pred(el))
            .cloned()
            .collect();
        Catalog { inregistrari: filtrat, ..self.clone() }
    }
}

#[derive(Debug, Clone)]
struct Student {
    id: u32,
    nume: String,
    medie: f64,
}

impl Student {
    fn nou(id: u32, nume: &str, medie: f64) -> Student {
        Student { id, nume: nume.to_string(), medie }
    }
}

#[derive(Debug, Clone)]
struct Produs {
    id: u32,
    nume: String,
    pret: f64,
    stoc: u32,
}

impl Produs {
    fn nou(id: u32, nume: &str, pret: f64, stoc: u32) -> Produs {
        Produs { id, nume: nume.to_string(), pret, stoc }
    }
}

fn este_merituos(s: &Student) -> bool {
    s.medie >= 8.0
}

fn este_disponibil(p: &Produs) -> bool {
    p.stoc > 0
}

fn main() {
    // 1
    let note    = [7.5, 9.2, 6.0, 8.8, 5.5];
    let varste  = [20u32, 19, 22, 18, 21];
    let prenume = ["Ion", "Ana", "Zoe", "Bogdan"];

    println!("Nota minima: {:?}"   , minim(&note));
    println!("Varsta minima: {:?}" , minim(&varste));
    println!("Primul prenume: {:?}", minim(&prenume));

    let gol: Vec<i32> = vec![];
    println!("Lista goala: {:?}", minim(&gol));

    // 2
    let note_admis = Interval::<f64>::nou(5.0, 10.0);
    println!("Interval note: {:?}" , note_admis);
    println!("Nota 7.5 admisa? {}" , note_admis.contine(&7.5));
    println!("Nota 4.9 admisa? {}" , note_admis.contine(&4.9));
    println!("Nota 10.0 admisa? {}", note_admis.contine(&10.0));

    let varste_facultate = Interval::<u32>::nou(18, 30);
    println!("Interval varste: {:?}", varste_facultate);
    println!("Varsta 22 ok? {}"     , varste_facultate.contine(&22));
    println!("Varsta 17 ok? {}"     , varste_facultate.contine(&17));
    println!("Varsta 31 ok? {}"     , varste_facultate.contine(&31));

    // 3
    let studenti = Catalog::nou("Grupa 30231")
        .adauga(Student::nou(1, "Ana"   , 8.5))
        .adauga(Student::nou(2, "Ion"   , 6.2))
        .adauga(Student::nou(3, "Maria" , 9.4))
        .adauga(Student::nou(4, "Andrei", 7.8));

    let merituosi = studenti.filtreaza_catalog(este_merituos);
    println!("Total studenti: {}"  , studenti.count());
    println!("Merituosi: {}"       , merituosi.count());
    println!("Original neatins: {}", studenti.count());

    let produse = Catalog::nou("Depozit")
        .adauga(Produs::nou(1, "Tastatura", 200.0 , 10))
        .adauga(Produs::nou(2, "Mouse"    , 80.0  , 0))
        .adauga(Produs::nou(3, "Monitor"  , 1100.0, 3));

    let disponibile = produse.filtreaza_catalog(este_disponibil);
    println!("\nTotal produse: {}", produse.count());
    println!("Disponibile: {}"    , disponibile.count());
}
