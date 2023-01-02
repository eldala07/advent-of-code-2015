use std::fs::File;
use std::io::prelude::*;

fn extract_content(file_path: &str) -> String {
    let mut file = File::open(file_path).expect("Can't open the file");

    let mut contents = String::new();
    file.read_to_string(&mut contents)
        .expect("Oops! Can not read the file...");

    // There is something weird while reading the file since I have 2 more characters (don't know which ones) that are found -> We can see it if I remove the else if in the main function
    return contents;
}

fn part_one(directions: &mut Vec<&str>) -> i16 {
    let mut floor = 0;

    for el in &mut *directions {
        floor += if *el == "(" {
            1
        } else if *el == ")" {
            -1
        } else {
            0
        };
    }

    return floor;
}

fn part_two(directions: &mut Vec<&str>) -> usize {
    let mut instruction_index: usize = 0;
    let mut floor: i16 = 0;

    for (i, el) in &mut (*directions).iter().enumerate() {
        floor += if *el == "(" {
            1
        } else if *el == ")" {
            -1
        } else {
            0
        };
        if floor == -1 {
            instruction_index = i;
            break;
        }
    }

    return instruction_index;
}

fn main() {
    let input_path = "src/input.txt";
    let contents = extract_content(&input_path);
    let split = contents.split("");

    let mut directions: Vec<&str> = split.collect();

    // Part one
    let floor = part_one(&mut directions);
    println!("The final floor is: {}", floor);

    // Part two
    let instruction_index = part_two(&mut directions);
    println!(
        "The index of the instruction leading to basement is: {}",
        instruction_index
    );
}
