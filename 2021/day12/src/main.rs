use std::{time::Instant, collections::{HashMap, HashSet}};

type Graph<'a> = HashMap<&'a str, HashSet<&'a str>>;

fn main() {
    let before = Instant::now();
    let mut input: Graph = HashMap::new();
    include_str!("../input.txt")
        .lines()
        .for_each(|line| {
            let (from, to) = line.split_once('-').unwrap();
            input.entry(from).or_insert(HashSet::new()).insert(to);
            input.entry(to).or_insert(HashSet::new()).insert(from);
        });

    println!("Part a: {}", part_a(&input, vec!["start"], HashSet::from(["start"])).len());
    println!("Part b: {}", part_b(&input, vec!["start"], HashMap::new()).len());
    
    println!("{:.2?}", before.elapsed());
}

fn part_a<'a>(caves: &'a Graph, current: Vec<&'a str>, visited: HashSet<&'a str>) -> Vec<Vec<&'a str>> {
    let mut paths = vec![];

    if current[current.len()-1] == "end" {
        paths.push(current);
        return paths
    }

    let options = caves.get(current[current.len()-1]).unwrap();
    for option in options {
        if visited.contains(option) {
            continue
        }
        let mut new_curr = current.clone();
        let mut new_visited = visited.clone();
        new_curr.push(option);
        if option.chars().nth(0).unwrap().is_ascii_lowercase() {
            new_visited.insert(option);
        }
        paths.extend(part_a(&caves, new_curr, new_visited))
    }

    paths
}

fn part_b<'a>(caves: &'a Graph, current: Vec<&'a str>, visited: HashMap<&'a str, u8>) -> Vec<Vec<&'a str>> {
    let mut paths = vec![];

    if current[current.len()-1] == "end" {
        paths.push(current);
        return paths
    }

    let options = caves.get(current[current.len()-1]).unwrap();
    for option in options {
        let count = *visited.get(option).unwrap_or(&0);
        if count >= 1 && visited.values().any(|&n| n == 2) || option == &"start" {
            continue;
        } else {
            let mut new_curr = current.clone();
            let mut new_visited = visited.clone();
            new_curr.push(option);
            if option.chars().nth(0).unwrap().is_ascii_lowercase() {
                *new_visited.entry(option).or_insert(0) += 1;
            }
            paths.extend(part_b(&caves, new_curr, new_visited))
        }
    }

    paths
}
