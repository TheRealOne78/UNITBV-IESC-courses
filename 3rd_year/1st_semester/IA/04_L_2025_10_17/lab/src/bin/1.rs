use lib_lab::vectors::Vector;

fn main() {
    let x = Vector::new(vec![2.0, 1.0, 2.0]);
    let y = Vector::new(vec![1.0, -1.0, 4.0]);
    println!("x: {:?}", x.data);
    println!("y: {:?}", y.data);


    let dot_prod = x.dot(&y);
    println!("\nDot prod: {}", dot_prod);


    let magn_x = x.magnitude();
    let magn_y = y.magnitude();
    println!("\nMagn x: {:.4}", magn_x);
    println!("Magn y: {:.4}"  , magn_y);


    let cos_angle  = x.cosine_angle(&y);
    let angle_rads = cos_angle.acos();
    let angle_degs = angle_rads.to_degrees();
    println!("\nCos: {:.4}", cos_angle);
    println!("Rad: {:.4}"  , angle_rads);
    println!("Deg: {:.4}°" , angle_degs);
}
