use std::time::Instant;

fn main() {
    let before = Instant::now();
    let input = include_bytes!("../input.txt");
    let mut start = [[0u8; 10]; 10];
    for i in 0..10 {
        for j in 0..10 {
            start[i][j] = input[i*11 + j] - 48
        }
    }

    println!("Part 1: {:?}", rounds(start, 100).0);
    println!("Part 2: {:?}", rounds(start, 1000).1);
    println!("{:.2?}", before.elapsed());
}

fn rounds(mut octopi: [[u8; 10]; 10], rounds: u32) -> (u32, u32) {
    let mut first_sync = 0;
    let mut flash_count = 0;
    let mut flashed = [[false; 10]; 10];
    for round in 0..rounds {
        for i in 0..10 {
            for j in 0..10 {
                octopi[i][j] += 1;
            }
        }
        loop {
            let mut keep_going = false;
            for i in 0..10 {
                for j in 0..10 {
                    if octopi[i][j] > 9 && !flashed[i][j] {
                        flashed[i][j] = true;
                        flash_count += 1;
                        for (x, y) in get_neighbours(i, j) {
                            octopi[x][y] += 1;
                        }
                        keep_going = true;
                    }
                }
            }
            if !keep_going {
                break
            }
        }
        if first_sync == 0 && flashed.iter().all(|&x| x.iter().all(|&x| x)) {
            first_sync = round + 1
        }
        for i in 0..10 {
            for j in 0..10 {
                if flashed[i][j] {
                    octopi[i][j] = 0;
                }
            }
        }
        flashed = [[false; 10]; 10];
    }
    
    (flash_count, first_sync)
}

fn get_neighbours(i: usize, j: usize) -> Vec<(usize, usize)> {
    let mut neighbours = vec![];
    let i = i as i32;
    let j = j as i32;
    for x in -1..2i32 {
        for y in -1..2i32 {
            if (x, y) == (0, 0) || i+x < 0 || i+x > 9 || j+y < 0 || j+y > 9 {
                continue;
            }
            neighbours.push(((i+x) as usize, (y+j) as usize));
        }
    }
    neighbours
}
