use std::time::Instant;

fn main() {
    let before = Instant::now();
    let input = include_str!("../../input.txt")
        .split(',').map(|x| x.parse::<u32>().unwrap()).collect();

    parta(&input);
    partb(&input);
    println!("Elapsed time: {:.2?}", before.elapsed());
}

fn parta(input: &Vec<u32>) {
    let min = *input.iter().min().unwrap();
    let max = *input.iter().max().unwrap();

    let mut current_best = u32::MAX;
    for pos in min..=max {
        let current: u32 = input.iter().map(|&x| (x as isize - pos as isize).abs() as u32).sum();
        if current < current_best {
            current_best = current
        }
    }

    println!("{:?}", current_best)
}

fn partb(input: &Vec<u32>) {
    let min = *input.iter().min().unwrap();
    let max = *input.iter().max().unwrap();

    let mut current_best = u32::MAX;
    for pos in min..=max {
        let current: u32 = input.iter().map(|&x| {
            let diff = (x as isize - pos as isize).abs();
            (1..=diff).map(|x| x as u32).sum::<u32>()
        }).sum();
        if current < current_best {
            current_best = current
        }
    }

    println!("{:?}", current_best)
}
