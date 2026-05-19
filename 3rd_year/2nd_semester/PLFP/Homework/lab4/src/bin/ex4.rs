fn compune_n(fns: Vec<Box<dyn Fn(i32) -> i32>>) -> impl Fn(i32) -> i32 {
    move |x| fns.iter().fold(x, |acc, f| f(acc))
}

fn main() {
    let fns: Vec<Box<dyn Fn(i32) -> i32>> = vec![
        Box::new(|x| x + 1),
        Box::new(|x| x * 2),
        Box::new(|x| x - 3),
        Box::new(|x| x * x),
    ];

    let compusa = compune_n(fns);
    println!("{}", compusa(5));

    println!(
        "La [Album], agregarea trebuie sa foloseasca un camp numeric (ex: durata, rating), nu varste inexistente."
    );
}
