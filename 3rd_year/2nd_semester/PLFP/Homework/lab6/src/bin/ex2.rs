#[derive(Debug)]
enum Arbore {
    Gol,
    Nod { val: i32, st: Box<Arbore>, dr: Box<Arbore> },
}

impl Arbore {
    fn contine(&self, val: i32) -> bool {
        match self {
            Arbore::Gol => false,
            Arbore::Nod { val: v, st, dr } => {
                if *v == val { true } else if val < *v { st.contine(val) } else { dr.contine(val) }
            }
        }
    }

    fn adancime(&self) -> usize {
        match self {
            Arbore::Gol => 0,
            Arbore::Nod { st, dr, .. } => 1 + st.adancime().max(dr.adancime()),
        }
    }
}

fn construieste_perechi<A: Clone, B: Clone>(a: &[A], b: &[B]) -> Vec<(A, B)> {
    if a.is_empty() || b.is_empty() {
        vec![]
    } else {
        let mut rest = construieste_perechi(&a[1..], &b[1..]);
        rest.insert(0, (a[0].clone(), b[0].clone()));
        rest
    }
}

fn main() {
    let arbore = Arbore::Nod {
        val: 8,
        st: Box::new(Arbore::Nod {
            val: 3,
            st: Box::new(Arbore::Nod { val: 1, st: Box::new(Arbore::Gol), dr: Box::new(Arbore::Gol) }),
            dr: Box::new(Arbore::Nod { val: 6, st: Box::new(Arbore::Gol), dr: Box::new(Arbore::Gol) }),
        }),
        dr: Box::new(Arbore::Nod {
            val: 10,
            st: Box::new(Arbore::Gol),
            dr: Box::new(Arbore::Nod { val: 14, st: Box::new(Arbore::Gol), dr: Box::new(Arbore::Gol) }),
        }),
    };

    println!("{} {}", arbore.contine(6), arbore.contine(9));
    println!("{}", arbore.adancime());
    println!("{:?}", construieste_perechi(&['a', 'b', 'c', 'd'], &[1, 2, 3, 4]));
}
