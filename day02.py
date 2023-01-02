import os
import string
from collections import defaultdict
import functools
import sys

#sys.setrecursionlimit(1000000)
dirs = ((-1, 0), (0, 1), (1, 0), (-1, 0))
dirs3 = ()

with open(r"input.txt") as f:
    s = f.read().strip()
    # print(s)

vectors = [[int(y) for y in x.split("x")] for x in s.split("\n")]
# print(vectors)

def part_one(vec):
    paper_surface = 0
    for [l, w, h] in vec:
        area1, area2, area3 = l*w, w*h, h*l
        slack = min(area1, area2, area3)
        paper = 2 * (area1 + area2 + area3)
        paper_surface += paper + slack
    return paper_surface

def part_two(vec):
    ribbon_length = 0
    for [l, w, h] in vec:
        sides = [l, w, h]
        side_1 = min(sides)
        sides.remove(side_1)
        side_2 = min(sides)
        present_ribbon = 2 * (side_1 + side_2)
        bow_ribbon = l*w*h
        ribbon_length += present_ribbon + bow_ribbon
    return ribbon_length

print(part_one(vectors))
print(part_two(vectors))
