use std::time::Instant;

fn main() {
    let before = Instant::now();
    let input: Vec<(Vec<&str>, Vec<&str>)> = include_str!("../../example.txt")
        .lines()
        .map(|l| {
            let mut iter = l.split('|');
            let obs = iter.next().unwrap().split_whitespace().collect();
            let nums = iter.next().unwrap().split_whitespace().collect();
            (obs, nums)
        }).collect();

    parta(&input);
    partb(&input);

    println!("Elapsed time: {:.2?}", before.elapsed());
}

fn parta(input: &Vec<(Vec<&str>, Vec<&str>)>) {
    println!("{}", input.iter()
        .map(|(obs, nums)| {
            nums.iter().filter(|x| [2, 3, 4, 7].contains(&x.len())).count()
    }).sum::<usize>())
}

fn partb(input: &Vec<(Vec<&str>, Vec<&str>)>) {
    
}

/*
* 0 = 6
* 1 = 2 unique
* 2 = 5
* 3 = 5
* 4 = 4 unique
* 5 = 5
* 6 = 6
* 7 = 3 unique
* 8 = 7 unique
* 9 = 6
*/
