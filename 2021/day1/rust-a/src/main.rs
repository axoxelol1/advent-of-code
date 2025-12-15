fn main() {
    let input: Vec<u16> = include_str!("../../input.txt")
        .lines()
        .map(|x| x.parse().unwrap())
        .collect();
    println!("{}", input.windows(2).filter(|arr| arr[0] < arr[1]).count());
}
