let paren_to_int c =
  match c with
  | '(' -> 1
  | ')' -> -1
  | _ -> raise (Invalid_argument "paren_to_int")

let p1 (input) = String.fold_left (fun acc c -> acc + (paren_to_int c)) 0 input

let rec p2rec seq acc : int =
    match Seq.uncons seq with
        | Some ((i, c), rest) -> 
            let acc' = acc + (paren_to_int c) in
            if acc' < 0 then i+1 else p2rec rest acc'
        | None -> raise (Invalid_argument "p2rec")
let p2 (input) = p2rec (String.to_seqi input) 0

let read_input = String.trim(In_channel.with_open_bin "input.txt" In_channel.input_all)

let () = read_input |> p1 |> Printf.printf "Part 1: %d\n"
let () = read_input |> p2 |> Printf.printf "Part 2: %d\n"
