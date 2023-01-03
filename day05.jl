
# LESSONS LEARNED

# In Julia, indexes start at 1..
# String concatenation in julia is done with * or ^
# There is a difference between strings and chars
# -> a string is surrounded by "" and a char by ''
# -> so 'a' is different than "a"

function readFile(inputPath)
    lines = []
  
    open(inputPath) do f
      line = 0  
      while ! eof(f) 
         s = readline(f)         
        push!(lines, s)
      end
    end
    
    lines
  end
  
  const VOWELS = ['a', 'e', 'i', 'o', 'u']
  const FORBIDDEN_CHAINS = ["ab", "cd", "pq", "xy"]
  
  function partOne()
    lines = readFile("input.txt")
    niceStringCounter = 0
    
    for line in lines
      vowels = []
      hasDoubleLetter = false
      hasForbiddenChain = false
      for (j, char) in enumerate(line)
        charIndexes = indexin( [char], VOWELS )
        if length(charIndexes[charIndexes.!=nothing]) > 0
          push!(vowels, char)
        end
        if j === 1
          continue
        end
        if line[j-1] === line[j]
          hasDoubleLetter = true
        end
        if line[j-1] * line[j] in FORBIDDEN_CHAINS
          hasForbiddenChain = true
          break
        end
      end
      if !hasForbiddenChain && length(vowels) >= 3 && hasDoubleLetter
      niceStringCounter += 1
      end
    end
    
    niceStringCounter
  end
  
  function partTwo()
    lines = readFile("input.txt")
    niceStringCounter = 0
  
    for line in lines
      hasSamePattern = false
      hasSeparatedLetters = false
      for (j, char) in enumerate(line)  
        if j < 2 
          continue
        end
        if !hasSamePattern
          hasSamePattern = length(collect(eachmatch(r""*line[j-1]*line[j], line))) > 1
        end
        if j < 3
          continue
        end
        if !hasSeparatedLetters && line[j-2] === line[j]
          hasSeparatedLetters = true
        end
      end
      if hasSamePattern && hasSeparatedLetters
        niceStringCounter += 1
      end
    end
  
    niceStringCounter
  end
  
  println("PART 1 - real: ", partOne())
  println("PART 2 - real: ", partTwo())