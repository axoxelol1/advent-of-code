use std::time::Instant;

fn main() {
    let before = Instant::now();
    let input = include_str!("../../input.txt")
        .split(',').fold([0; 9], |mut acc, x| {acc[x.parse::<usize>().unwrap()] += 1; acc});

    solve(input, 80);
    solve(input, 256);
    println!("Elapsed time: {:.2?}", before.elapsed());
}

fn solve(mut f: [usize; 9], days: usize) {
    for _ in 0..days {
        f = [f[1], f[2], f[3], f[4], f[5], f[6], f[0] + f[7], f[8], f[0]];
    }
    println!("{}", f.iter().sum::<usize>());
}
