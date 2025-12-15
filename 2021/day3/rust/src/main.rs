const BIT_COUNT: usize = 12;

fn main() {
    let input: Vec<u32> = include_str!("../../input.txt")
        .lines()
        .map(|l| u32::from_str_radix(l, 2).unwrap())
        .collect();
    parta(&input);
    partb(&input);
}

fn parta(input: &Vec<u32>) {
    let gamma = input
        .iter()
        .fold(vec![0; BIT_COUNT], |counts, bits| {
            counts
                .iter()
                .enumerate()
                .map(|(i, n)| n + ((bits & 1 << i) >> i))
                .collect()
        })
        .into_iter()
        .enumerate()
        .map(|(i, b)| ((b >= input.len() as u32 / 2) as u32) << i)
        .sum::<u32>();

    println!("{}", gamma * (!gamma & ((1 << BIT_COUNT) - 1)));
}

fn partb(input: &Vec<u32>) {
    let mut oxy = (0..BIT_COUNT).rev().scan(input.clone(), |nums, i| {
        let one = nums.iter().filter(|n| *n & 1 << i > 0).count() >= (nums.len() + 1) / 2;
        nums.retain(|n| (*n & 1 << i > 0) == one);
        nums.first().copied()
    }).last().unwrap();
    
    let co2 = (0..BIT_COUNT).rev().scan(input.clone(), |nums, i| {
        let one = nums.iter().filter(|n| *n & 1 << i > 0).count() >= (nums.len() + 1) / 2;
        nums.retain(|n| (*n & 1 << i > 0) != one);
        nums.first().copied()
    }).last().unwrap();

    println!("{}", oxy * co2);
}
