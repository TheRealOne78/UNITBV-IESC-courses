use std::collections::HashSet;
use std::usize::MAX;

fn dijkstra(n: usize, l: Vec<Vec<usize>>) -> Vec<usize> {
    let mut d = vec![MAX; n];
    let mut c: HashSet<usize> = (1..n).collect();
    let mut s: HashSet<usize> = HashSet::new();

    d[0] = 0;
    s.insert(0);
    for i in 1..n {
        d[i] = l[0][i];
    }

    for _ in 1..n - 1 {
        let &v = c.iter()
            .min_by_key(|&&node| d[node])
            .expect("Niciun nod in C");

        c.remove(&v);
        s.insert(v);

        for &w in c.iter() {
            d[w] = d[w].min(d[v].saturating_add(l[v][w]));
        }
    }

    d
}

const N: usize = 10;
static mut SET: [usize; N] = [0; N];

fn find(x: usize) -> usize {
    unsafe { SET[x] }
}

fn merge(a: usize, b: usize) {
    let mut i = a;
    let mut j = b;
    if i > j {
        std::mem::swap(&mut i, &mut j);
    }

    unsafe {
        for k in 0..N {
            if SET[k] == j {
                SET[k] = i;
            }
        }
    }
}

#[derive(Debug, Clone, Copy)]
struct Muchie {
    u: usize,
    v: usize,
    cost: usize,
}

struct DisjSet {
    parent: Vec<usize>,
}

impl DisjSet {
    fn new(n: usize) -> Self {
        let mut parent = Vec::with_capacity(n);
        for i in 0..n {
            parent.push(i);
        }
        Self { parent }
    }

    fn find(&mut self, x: usize) -> usize {
        if self.parent[x] != x {
            self.parent[x] = self.find(self.parent[x]);
        }
        self.parent[x]
    }

    fn merge(&mut self, a: usize, b: usize) {
        let ra = self.find(a);
        let rb = self.find(b);
        if ra != rb {
            self.parent[rb] = ra;
        }
    }
}

fn kruskal(n: usize, mut edges: Vec<Muchie>) -> Vec<Muchie> {
    edges.sort_by_key(|e| e.cost);
    let mut ds = DisjSet::new(n);
    let mut mst = Vec::new();

    for edge in edges {
        let ucomp = ds.find(edge.u);
        let vcomp = ds.find(edge.v);
        if ucomp != vcomp {
            ds.merge(ucomp, vcomp);
            mst.push(edge);
            if mst.len() == n - 1 {
                break;
            }
        }
    }

    mst
}

fn prim(c: Vec<Vec<usize>>) -> Vec<(usize, usize)> {
    let n = c.len();
    let mut mincost = vec![MAX; n];
    let mut vecin = vec![0; n];
    let mut in_tree = vec![false; n];
    let mut a = Vec::new();

    in_tree[0] = true;
    for i in 1..n {
        mincost[i] = c[0][i];
        vecin[i] = 0;
    }

    for _ in 1..n {
        let mut min = MAX;
        let mut k = 0;
        for j in 1..n {
            if !in_tree[j] && mincost[j] < min {
                min = mincost[j];
                k = j;
            }
        }

        a.push((k, vecin[k]));
        in_tree[k] = true;
        mincost[k] = MAX;

        for j in 1..n {
            if !in_tree[j] && c[k][j] < mincost[j] {
                mincost[j] = c[k][j];
                vecin[j] = k;
            }
        }
    }

    a
}

fn main() {
    let l = vec![
        vec![0, 2, 4, 3],
        vec![6, 0, 1, 7],
        vec![4, 1, 0, 3],
        vec![1, 8, 12, 0],
    ];
    let dists = dijkstra(4, l);
    println!("Cea mai scurtă distanță de la nodul 0: {:?}", dists);

    unsafe {
        for i in 0..N {
            SET[i] = i;
        }
    }

    merge(1, 2);
    merge(2, 3);

    for x in 0..5 {
        println!("FIND({}) = {}", x, find(x));
    }

    let edges = vec![
        Muchie { u: 0, v: 1, cost: 2 },
        Muchie { u: 0, v: 2, cost: 4 },
        Muchie { u: 1, v: 2, cost: 1 },
        Muchie { u: 1, v: 3, cost: 7 },
        Muchie { u: 2, v: 3, cost: 3 },
    ];
    let mst_k = kruskal(4, edges);
    for edge in mst_k {
        println!("({}, {}) cu cost {}", edge.u, edge.v, edge.cost);
    }

    let mat = vec![
        vec![0, 2, 4, 7],
        vec![2, 0, 1, 7],
        vec![4, 1, 0, 3],
        vec![7, 7, 3, 0],
    ];
    let mst_p = prim(mat);
    for (u, v) in mst_p {
        println!("Muchie: ({}, {})", u, v);
    }
}
