fn agregeaza<T, R>(colectie: &[T], f: impl Fn(&[T]) -> R) -> R {
    f(colectie)
}

fn mediana(nums: &[i32]) -> Option<i32> {
    if nums.is_empty() {
        return None;
    }
    let mut v = nums.to_vec();
    v.sort();
    Some(v[v.len() / 2])
}

fn main() {
    let nums = [9, 3, 1, 8, 7, 2, 6, 5, 4];

    let suma = agregeaza(&nums, |v| v.iter().sum::<i32>());
    let maxim = agregeaza(&nums, |v| *v.iter().max().unwrap());
    let med = agregeaza(&nums, mediana);

    println!("suma: {}", suma);
    println!("maxim: {}", maxim);
    println!("mediana: {:?}", med);
}
