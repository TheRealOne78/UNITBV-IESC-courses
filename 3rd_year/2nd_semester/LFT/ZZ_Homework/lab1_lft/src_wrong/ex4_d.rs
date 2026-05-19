fn main() {
    let s = String::from("salut");
    let r = &s;
    drop(s);
    println!("{}", r);
}
