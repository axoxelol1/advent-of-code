use std::time::Instant;
type Board = [[(u32, bool); 5]; 5];

fn main() {
    let before = Instant::now();
    let mut input = include_str!("../../input.txt").lines();
    let numbers: Vec<u32> = input.next().unwrap().split(',').map(|n| n.parse::<u32>().unwrap()).collect();
    let rows: Vec<Vec<u32>> = input.filter(|l| *l != "").map(|l| l.split_whitespace().map(|n| n.parse::<u32>().unwrap()).collect()).collect();
    let boards: Vec<Board> = rows.chunks(5).map(|rows| {
        let mut board = [[(0u32, false); 5]; 5];
        rows.iter().enumerate().for_each(|(i, row)| {
            row.iter().enumerate().for_each(|(j, val)| {
                board[i][j].0 = *val;
            });
        });
        board
    }).collect();
    parta(boards.clone(), numbers.clone());
    partb(boards.clone(), numbers.clone());
    println!("Elapsed time: {:.2?}", before.elapsed());
}

// Return score if winner, else nothing
fn round(boards: &mut Vec<Board>, drawn: u32) -> Option<u32> {
    let relevant_indexes: Vec<usize> = boards.iter().enumerate().filter(|(_, board)| board.iter().any(|row| row.contains(&(drawn, false)))).map(|(i, _)| i).collect();

    for i in &relevant_indexes {
        boards[*i].iter_mut().flatten().for_each(|(val, marked)| {
            if *val == drawn {
                *marked = true;
            }
        })
    }
    
    for i in &relevant_indexes{
        if let Some(unmarked_sum) = has_won(&boards[*i]) {
            return Some(unmarked_sum * drawn);
        }
    }
    None
}

fn has_won(board: &Board) -> Option<u32> {
    let horiz = board.iter().any(|row| row.iter().all(|(_, marked)| *marked));
    let vert = (0..5).any(|col| (0..5).all(|row| board[row][col].1));
    let diag = (0..5).all(|x| board[x][x].1);
    if horiz || vert || diag {
        return Some(board.iter().flat_map(|row| row.iter()).filter(|(_, marked)| !*marked).map(|(val, _)| *val).sum::<u32>());
    }
    None
}

fn parta(mut boards: Vec<Board>, numbers: Vec<u32>) {
    for num in numbers {
        if let Some(score) = round(&mut boards, num) {
            println!{"{}", score};
            break;
        }
    }
}

fn partb(mut boards: Vec<Board>, numbers: Vec<u32>) {
    for num in numbers {
        let relevant_indexes: Vec<usize> = boards.iter().enumerate().filter(|(_, board)| board.iter().any(|row| row.contains(&(num, false)))).map(|(i, _)| i).collect();

        for i in &relevant_indexes {
            boards[*i].iter_mut().flatten().for_each(|(val, marked)| {
                if *val == num {
                    *marked = true;
                }
            })
        }

        let tmp = boards[0];
        boards.retain(|board| has_won(board) == None);
        if boards.is_empty() {
            println!("{}", has_won(&tmp).unwrap() * num);
            break;
        }
    }
}
