import 'dart:async';
import 'dart:io';
import 'dart:convert';

readFile(String path) async {
  final arr = <String>[];
  await new File(path)
      .openRead()
      .map(utf8.decode)
      .transform(new LineSplitter())
      .forEach((line) => arr.add(line));
  return arr;
}

num countOccurences(mainString, search) {
  num lInx = 0;
  num count = 0;
  while (lInx != -1) {
    lInx = mainString.indexOf(search, lInx);
    if (lInx != -1) {
      count++;
      lInx += search.length;
    }
  }
  return count;
}

getNumberOfCharactersInMemory(String lne) {
  var line = lne.substring(1, lne.length-1);
  num count = line.length;

  var lineArr = line.split("");
  var shouldPass = false;
  for (var i = 0; i < lineArr.length; i++) {
    if (shouldPass) {
      shouldPass = false;
      continue;
    }
    if (lineArr[i] == "\\") {
      if (lineArr[i+1] == "x") {
        count -= 3;
      } else {
        count--;
      }
      shouldPass = true;
    }
  }
  return count;
}

partOne(String path) async {
  var lines = await readFile(path);
  num totalNbCharactersOfCode = 0;
  num totalNbCharactersInMemory = 0;
  for (var i = 0; i < lines.length; i++) {
    totalNbCharactersOfCode += lines[i].length;
    totalNbCharactersInMemory += getNumberOfCharactersInMemory(lines[i]);
  }

  return totalNbCharactersOfCode - totalNbCharactersInMemory;
}

getNewNumberOfCharactersOfCode(String lne) {
  var line = lne.replaceAll("\\", '\\\\');
  line = line.replaceAll('\"', '\\\"');
  return line.length + 2;
}

partTwo(String path) async {
  var lines = await readFile(path);
  num totalNbCharactersOfCode = 0;
  num newTotalNumberOfCharacterOfCode = 0;
  for (var i = 0; i < lines.length; i++) {
    totalNbCharactersOfCode += lines[i].length;
    newTotalNumberOfCharacterOfCode += getNewNumberOfCharactersOfCode(lines[i]);
  }

  return newTotalNumberOfCharacterOfCode - totalNbCharactersOfCode;
}

main() async {
  var sol1 = await partOne("input.txt");
  print("PART 1 - real: ${sol1}");
  
  var sol2 = await partTwo("input.txt");
  print("PART 2 - real: ${sol2}");
}

