use std::collections::{HashMap, HashSet, VecDeque};

type Graf<'a> = HashMap<&'a str, Vec<&'a str>>;

fn bfs_rec<'a>(graf: &Graf<'a>, coada: &mut VecDeque<&'a str>, viz: &mut HashSet<&'a str>, out: &mut Vec<&'a str>) {
    if let Some(nod) = coada.pop_front() {
        out.push(nod);
        if let Some(vecini) = graf.get(nod) {
            for v in vecini {
                if viz.insert(*v) {
                    coada.push_back(*v);
                }
            }
        }
        bfs_rec(graf, coada, viz, out);
    }
}

fn bfs<'a>(graf: &Graf<'a>, start: &'a str) -> Vec<&'a str> {
    let mut coada = VecDeque::from([start]);
    let mut viz = HashSet::from([start]);
    let mut out = vec![];
    bfs_rec(graf, &mut coada, &mut viz, &mut out);
    out
}

fn toate_caile<'a>(graf: &Graf<'a>, start: &'a str, end: &'a str) -> Vec<Vec<&'a str>> {
    fn dfs<'a>(graf: &Graf<'a>, cur: &'a str, end: &'a str, viz: &mut HashSet<&'a str>, cale: &mut Vec<&'a str>, rez: &mut Vec<Vec<&'a str>>) {
        if cur == end {
            rez.push(cale.clone());
            return;
        }
        if let Some(vecini) = graf.get(cur) {
            for v in vecini {
                if viz.insert(*v) {
                    cale.push(*v);
                    dfs(graf, v, end, viz, cale, rez);
                    cale.pop();
                    viz.remove(v);
                }
            }
        }
    }

    let mut rez = vec![];
    let mut viz = HashSet::from([start]);
    let mut cale = vec![start];
    dfs(graf, start, end, &mut viz, &mut cale, &mut rez);
    rez
}

fn main() {
    let graf: Graf = HashMap::from([
        ("Ana", vec!["Bogdan", "Carmen"]),
        ("Bogdan", vec!["Dan", "Elena"]),
        ("Carmen", vec!["Elena"]),
        ("Dan", vec!["Filip"]),
        ("Elena", vec!["Filip"]),
        ("Filip", vec![]),
    ]);

    println!("{:?}", bfs(&graf, "Ana"));
    println!("{:?}", toate_caile(&graf, "Ana", "Filip"));
}
