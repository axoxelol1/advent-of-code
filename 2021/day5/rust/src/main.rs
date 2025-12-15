use std::time::Instant;
use std::cmp::{min, max};

type Point = (usize, usize);
type Line = (Point, Point);
const GRID_SIZE: usize = 1000;

fn main() {
    let before = Instant::now();
    let input: Vec<Line> = 
    include_str!("../../input.txt").lines().map(|l| { 
            let (start, end) = l.split_once(" -> ").unwrap();
            let (x1, y1) = start.split_once(',').unwrap();
            let (x2, y2) = end.split_once(',').unwrap();
            ((x1.parse().unwrap(), y1.parse().unwrap()),
            (x2.parse().unwrap(), y2.parse().unwrap()))
        }).collect();

    parta(&input);
    partb(&input);
    println!("Elapsed time: {:.2?}", before.elapsed());
}

fn parta(lines: &Vec<Line>) {
    let mut board = [[0u8; GRID_SIZE]; GRID_SIZE];
    
    lines.iter()
        .filter(|&((x1, y1), (x2, y2))| x1 == x2 || y1 == y2)
        .for_each(|&((x1, y1), (x2, y2))| {
            for i in min(y1,y2)..=max(y1,y2) {
                for j in min(x1,x2)..=max(x1,x2) {
                    board[i][j] += 1;
                }
            }
    });

    println!("{}", board.iter().flat_map(|r| r.iter()).filter(|&&x| x >= 2).count());
}

fn partb(lines: &Vec<Line>) {
    let mut board = [[0u8; GRID_SIZE]; GRID_SIZE];
    
    // Had ranges first but got overflow error, was actually due to a print of whole board
    // Wont fix now, this works >:(
    for &((x1, y1), (x2, y2)) in lines {
        if x1 == x2 || y1 == y2 {
            for i in min(y1,y2)..=max(y1,y2) {
                for j in min(x1,x2)..=max(x1,x2) {
                    board[i][j] += 1;
                }
            }
        } else {
            let mut x = x1;
            let mut y = y1;
            let mut coords = vec![];
            loop {
                coords.push((x, y));
                if x1 < x2 {
                    x += 1;
                } else {
                    x -= 1;
                }
                if y1 < y2 {
                    y += 1;
                } else {
                    y -= 1;
                }
                if x == x1 || x == x2 {
                    coords.push((x,y));
                    break;
                }
            }
            for c in coords {
                board[c.1][c.0] += 1;
            }
        }
    }

    println!("{}", board.iter().flat_map(|r| r.iter()).filter(|&&x| x >= 2).count());
}
