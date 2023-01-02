import java.io.File
import java.io.InputStream

val readFile: (String) -> MutableList<String> = { filePath ->
  val inputStream: InputStream = File(filePath).inputStream()
  val lineList = mutableListOf<String>()

  inputStream.bufferedReader().forEachLine { lineList.add(it) }
  // println(lineList)
  lineList
}

val partOne: () -> Int = {
  val lines = readFile("input.txt")
  var x = 0
  var y = 0
  val housesCoord: HashSet<String> = hashSetOf()
  
  lines[0].forEach {
    housesCoord.add(x.toString() + "-" + y.toString())
    when (it) {
      "^".toCharArray()[0] -> y--
      ">".toCharArray()[0] -> x++
      "<".toCharArray()[0] -> x--
      "v".toCharArray()[0] -> y++
    }
  }
  
  housesCoord.size
}

val partTwo: () -> Int = {
  val lines = readFile("input.txt")
  var xSanta = 0
  var ySanta = 0
  var xRoboSanta = 0
  var yRoboSanta = 0
  val housesCoord: HashSet<String> = hashSetOf()
  
  lines[0].forEachIndexed  { index, direction ->
    val isSanta  = index % 2 == 0
    when (direction) {
      "^".toCharArray()[0] -> if (isSanta) ySanta-- else yRoboSanta--
      ">".toCharArray()[0] -> if (isSanta) xSanta++ else xRoboSanta++
      "<".toCharArray()[0] -> if (isSanta) xSanta-- else xRoboSanta--
      "v".toCharArray()[0] -> if (isSanta) ySanta++ else yRoboSanta++
    }
    if (isSanta) {
      housesCoord.add(xSanta.toString() + "-" + ySanta.toString())  
    } else {
      housesCoord.add(xRoboSanta.toString() + "-" + yRoboSanta.toString())
    }
    
  }
  
  housesCoord.size
}

fun main(args: Array<String>) {
  val nbHouses = partOne()
  println("PART 1 - real input: $nbHouses")
  
  val nbHousesP2 = partTwo()
  println("PART 2 - real input: $nbHousesP2")
}
