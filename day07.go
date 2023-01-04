// null -> nil
// type for a list of strings -> []string

package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

const (
	AND    string = "AND"
	OR            = "OR"
	LSHIFT        = "LSHIFT"
	RSHIFT        = "RSHIFT"
	NOT           = "NOT"
	ASSIGN        = "ASSIGN"
  ASSIGN_VAR    = "ASSIGN_VAR"
)

type Node struct {
	name       string
	value      int32
	operation  string
	shiftValue int
	neighbors  []string
}

func readLines(path string) ([]string, error) {
	file, err := os.Open(path)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	var lines []string
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}
	return lines, scanner.Err()
}

func createNodes(lines []string) (allNodes []Node, knownNodes []Node) {
	var nodes []Node
	var nodesWithValues []Node
	for _, line := range lines {
		if strings.Contains(line, AND) {
			splitOperation := strings.Split(line, AND)
			neighbor1 := strings.Trim(splitOperation[0], " ")
			splitArrow := strings.Split(splitOperation[1], "->")
			neighbor2 := strings.Trim(splitArrow[0], " ")
			nodeName := strings.Trim(splitArrow[1], " ")

			nodes = append(nodes, Node{
				name:       nodeName,
				value:      -1,
				operation:  AND,
				shiftValue: 0,
				neighbors:  []string{neighbor1, neighbor2},
			})

		} else if strings.Contains(line, OR) {
			splitOperation := strings.Split(line, OR)
			neighbor1 := strings.Trim(splitOperation[0], " ")
			splitArrow := strings.Split(splitOperation[1], "->")
			neighbor2 := strings.Trim(splitArrow[0], " ")
			nodeName := strings.Trim(splitArrow[1], " ")

			nodes = append(nodes, Node{
				name:       nodeName,
				value:      -1,
				operation:  OR,
				shiftValue: 0,
				neighbors:  []string{neighbor1, neighbor2},
			})

		} else if strings.Contains(line, LSHIFT) {
			splitOperation := strings.Split(line, LSHIFT)
			neighbor1 := strings.Trim(splitOperation[0], " ")
			splitArrow := strings.Split(splitOperation[1], "->")
			shiftVal := strings.Trim(splitArrow[0], " ")
			nodeName := strings.Trim(splitArrow[1], " ")

			shiftValue, _ := strconv.Atoi(shiftVal)
			nodes = append(nodes, Node{
				name:       nodeName,
				value:      -1,
				operation:  LSHIFT,
				shiftValue: shiftValue,
				neighbors:  []string{neighbor1},
			})

		} else if strings.Contains(line, RSHIFT) {
			splitOperation := strings.Split(line, RSHIFT)
			neighbor1 := strings.Trim(splitOperation[0], " ")
			splitArrow := strings.Split(splitOperation[1], "->")
			shiftVal := strings.Trim(splitArrow[0], " ")
			nodeName := strings.Trim(splitArrow[1], " ")

			shiftValue, _ := strconv.Atoi(shiftVal)
			nodes = append(nodes, Node{
				name:       nodeName,
				value:      -1,
				operation:  RSHIFT,
				shiftValue: shiftValue,
				neighbors:  []string{neighbor1},
			})

		} else if strings.Contains(line, NOT) {
			splitOperation := strings.Split(line, NOT)
			splitArrow := strings.Split(splitOperation[1], "->")
			neighbor2 := strings.Trim(splitArrow[0], " ")
			nodeName := strings.Trim(splitArrow[1], " ")

			nodes = append(nodes, Node{
				name:       nodeName,
				value:      -1,
				operation:  NOT,
				shiftValue: 0,
				neighbors:  []string{neighbor2},
			})

		} else {
			splitArrow := strings.Split(line, "->")
			val := strings.Trim(splitArrow[0], " ")
			nodeName := strings.Trim(splitArrow[1], " ")

			value, err := strconv.Atoi(val)
			if err != nil {
				nodes = append(nodes, Node{
					name:       nodeName,
					value:      -1,
					operation:  ASSIGN_VAR,
					shiftValue: 0,
					neighbors:  []string{val},
				})
			} else {
				valuei32 := int32(value)
				nodesWithValues = append(nodesWithValues, Node{
					name:       nodeName,
					value:      valuei32,
					operation:  ASSIGN,
					shiftValue: 0,
					neighbors:  nil,
				})
			}

		}
	}

	return nodes, nodesWithValues
}

func isNodeComputable(node Node, knownNodes []Node) bool {
	isComputable := true
	for _, neighbor := range node.neighbors {
		foundNeighbor := false
    _, err := strconv.Atoi(neighbor)
    if err == nil {
      foundNeighbor = true
      continue
    }
		for _, known := range knownNodes {
			if neighbor == known.name {
				foundNeighbor = true
				break
			}
		}
		if !foundNeighbor {
			isComputable = false
			break
		}
	}

	return isComputable
}

func findNodeValue(nodeName string, nodes []Node) int32 {
	var value int32 = -1
	for _, node := range nodes {
		if node.name == nodeName {
			value = node.value
			break
		}
	}
	return value
}

func solve(path string, nodeToFind string) []Node {
	lines, err := readLines(path)
	if err != nil {
		log.Fatalf("readLines: %s", err)
	}

	couldNotComputeSomeValues := true
	nodes, knownNodes := createNodes(lines)
	for couldNotComputeSomeValues {

		tmpCouldNoCompute := false
		for i, node := range nodes {
			canComputeNode := isNodeComputable(node, knownNodes)
			if node.value != -1 {
				continue
			}
			if canComputeNode {
				switch operation := node.operation; operation {
				case AND:
          var value1 int32
          var value2 int32
          val1, err1 := strconv.Atoi(node.neighbors[0])
          val2, err2 := strconv.Atoi(node.neighbors[1])
          if err1 != nil {
            value1 = findNodeValue(node.neighbors[0], knownNodes)  
          } else {
            value1 = int32(val1)
          }
          if err2 != nil {
            value2 = findNodeValue(node.neighbors[1], knownNodes) 
          } else {
            value2 = int32(val2)
          }
					node.value = value1 & value2
					nodes[i].value = node.value
				case OR:
					node.value = findNodeValue(node.neighbors[0], knownNodes) | findNodeValue(node.neighbors[1], knownNodes)
					nodes[i].value = node.value
				case LSHIFT:
					node.value = findNodeValue(node.neighbors[0], knownNodes) << node.shiftValue
					nodes[i].value = node.value
				case RSHIFT:
					node.value = findNodeValue(node.neighbors[0], knownNodes) >> node.shiftValue
					nodes[i].value = node.value
				case NOT:
					node.value = ^findNodeValue(node.neighbors[0], knownNodes)
					nodes[i].value = node.value
				case ASSIGN_VAR:
					node.value = findNodeValue(node.neighbors[0], knownNodes)
					nodes[i].value = node.value
				default:
					// pass
				}
				if nodeToFind == node.name {
				  fmt.Println(node.value)
				}
				knownNodes = append(knownNodes, node)
			} else {
				tmpCouldNoCompute = true
			}
		}
		couldNotComputeSomeValues = tmpCouldNoCompute
	}

	return knownNodes
}

func main() {
	solve("input.txt", "a")
}
