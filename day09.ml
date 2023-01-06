
(* http://alhassy.com/OCamlCheatSheet/CheatSheet.pdf *)
(* cd ocaml *)
(* dune build && dune exec ocaml *)

let file = "./input.txt"

class neighbor = 
  object
    val mutable name = ""
    val mutable distance = 0
      method get_name = name
      method set_name newName = name <- newName
      method get_distance = distance
      method set_distance newDistance = distance <- newDistance
  end;;

class node =
    object
      val mutable name = ""
      method get_name = name
      method set_name newName = name <- newName
      
      val mutable neighbors = ([]: neighbor list)
      method push x =
        neighbors <- x :: neighbors
      method size =                             
        List.length neighbors
    end;;

(* Create nodes *)
let read_file filename = 
  let nodes = Hashtbl.create 30 in
  let lines = ref [] in
  let chan = open_in filename in
    try
      while true; do
        let split = Str.split (Str.regexp " +") in
        let newLine = input_line chan in
        let tokens = split (newLine) in
        
        let neighbor = new neighbor in
        neighbor#set_name (List.nth tokens 2);
        neighbor#set_distance (int_of_string (List.nth tokens 4));
  
        let currentName = (List.nth tokens 0) in
        let currentNode = new node in
        currentNode#set_name currentName;
        
        Hashtbl.add nodes currentName currentNode;
        
        lines := newLine :: !lines
      done; nodes
    with End_of_file ->
      close_in chan;
      nodes;;

let partOne = 
  let hashTable = read_file file in
  hashTable |> Hashtbl.iter (fun x y -> Printf.printf "%s -> %s\n" x y#get_name);
  hashTable;;

partOne

(* Create BFS  *)
(* let bfs start nodes  *)
(*   =   *)

(* Run BFS *)
