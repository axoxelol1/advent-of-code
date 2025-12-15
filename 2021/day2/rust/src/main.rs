use std::num::ParseIntError;

#[derive(Debug)]
enum Instruction {
    Forward(i32),
    Down(i32),
    Up(i32),
}

#[derive(Debug)]
enum ParseInstructionError {
    InvalidString,
    InvalidDirection,
    ParseInt(ParseIntError),
}

impl TryFrom<&str> for Instruction {
    type Error = ParseInstructionError;

    fn try_from(value: &str) -> Result<Self, Self::Error> {
        let (dir, val) = value
            .split_once(' ')
            .ok_or(ParseInstructionError::InvalidString)?;

        let val = val
            .parse()
            .map_err(|err| ParseInstructionError::ParseInt(err))?;

        match dir.to_lowercase().trim() {
            "forward" => Ok(Instruction::Forward(val)),
            "down" => Ok(Instruction::Down(val)),
            "up" => Ok(Instruction::Up(val)),
            _ => Err(ParseInstructionError::InvalidDirection),
        }
    }
}

fn main() {
    let input: Vec<Instruction> = include_str!("../../input.txt")
        .lines()
        .map(|line| Instruction::try_from(line).unwrap())
        .collect();

    parta(&input);
    partb(&input);
}

fn parta(input: &Vec<Instruction>) {
    let (mut horizontal, mut depth) = (0, 0);

    for instruction in input {
        match instruction {
            Instruction::Forward(num) => horizontal += num,
            Instruction::Down(num) => depth += num,
            Instruction::Up(num) => depth -= num,
        };
    }
    dbg!(horizontal * depth);
}

fn partb(input: &Vec<Instruction>) {
    let (mut aim, mut horizontal, mut depth) = (0, 0, 0);

    for instruction in input {
        match instruction {
            Instruction::Forward(num) => {
                horizontal += num;
                depth += aim * num
            }
            Instruction::Down(num) => aim += num,
            Instruction::Up(num) => aim -= num,
        };
    }
    dbg!(horizontal * depth);
}
