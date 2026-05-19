fn compune_vec(fns: Vec<Box<dyn Fn(i32) -> i32>>) -> impl Fn(i32) -> i32 {
    move |x| fns.iter().fold(x, |acc, f| f(acc))
}

fn main() {
    let f = compune_vec(vec![
        Box::new(|x| x + 5),
        Box::new(|x| x * 3),
        Box::new(|x| x - 4),
    ]);

    println!("{}", f(10));
}
