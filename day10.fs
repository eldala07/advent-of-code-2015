// changing values have to be names mutable and use the <- operator instead of the = operator
// access list item with .[] e.g. -> array.[1]
// methods and properties are PascalCase -> Equals, Length

open System

let mutable input = "1,3,2,1,1,3,1,1,1,2"

[<EntryPoint>]
let main argv =
    let mutable totalLength = 0
    let repeat = 50 // 40 - part1, 50 - part2
    
    for n = 1 to repeat do
      let resultArr = ResizeArray<string>()
      let result = input.Split ","
      let mutable i2 = 0
      for i = 0 to result.Length - 1 do
          if i < i2 then
            () // continue
          else
            let intValue = result.[i] |> int
            
            let mutable j = i + 1
            let mutable valCount = 1
            let mutable continueLooping = j <= result.Length - 1 && result.[j].Equals(result.[i])
            while continueLooping do
              valCount <- valCount + 1
              j <- j + 1
              continueLooping <- j <= result.Length - 1 && result.[j].Equals(result.[i])
            i2 <- j
            let valCountS = valCount |> string
            let intValueS = intValue |> string
            resultArr.Add valCountS
            resultArr.Add intValueS
            if n.Equals(repeat) then
              totalLength <- totalLength + 2
      input <- resultArr.ToArray() |> String.concat ","
    printf "\nPART 1 - real: %i" totalLength
    0 // return an integer exit code
