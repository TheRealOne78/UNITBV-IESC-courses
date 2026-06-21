// 3 curiei si o harta, iar harta va fi reprezentata de un graph. Pentru fiecare
// livrare, o sa aveti 2 rute: Cea mai rapida si a 2 cea mai rapida in cazul in
// care exista blocaje in prima ruta.

pub struct Djkstra {

}

fn main() {

    // 'F' - pickup
    // 'x' - house
    // ' ' - empty
    const MAP: [[char; 10]; 10] = [[' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                   [' ', ' ', ' ', ' ', 'x', ' ', ' ', ' ', ' ', 'x'],
                                   [' ', ' ', 'x', ' ', ' ', ' ', 'x', ' ', ' ', ' '],
                                   [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                   ['F', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                   [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                   [' ', ' ', ' ', ' ', ' ', ' ', ' ', 'x', ' ', ' '],
                                   [' ', ' ', ' ', 'x', ' ', ' ', ' ', ' ', ' ', ' '],
                                   [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
                                   [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']];

    const F_INDEX: [u8; 2] = [0, 4];

    println!("x: {} | y: {}", F_INDEX[0], F_INDEX[1]);
}
