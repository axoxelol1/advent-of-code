fn main() {
    let input: Vec<u16> = include_str!("../../input.txt")
        .lines()
        .map(|x| x.parse().unwrap())
        .collect();

    println!(
        "{}",
        input
            .windows(3)
            .zip(input.windows(3).skip(1))
            .filter(|(a, b)| a.iter().sum::<u16>() < b.iter().sum())
            .count()
    );
}
