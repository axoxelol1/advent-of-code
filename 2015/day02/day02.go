package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"slices"
	"strconv"
	"strings"
)

type box struct {
	l int
	w int
	h int
}

func parse_input(filename string) []box {
	file, err := os.Open(filename)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()
	scanner := bufio.NewScanner(file)
	boxes := make([]box, 1000)
	for scanner.Scan() {
		text := scanner.Text()
		parts := strings.Split(text, "x")
		l, _ := strconv.Atoi(parts[0])
		w, _ := strconv.Atoi(parts[1])
		h, _ := strconv.Atoi(parts[2])
		boxes = append(boxes, box{l, w, h})
	}
	return boxes
}

func main() {
	boxes := parse_input("input.txt")
	total := 0
	for _, b := range boxes {
		sides := []int{b.l * b.w, b.w * b.h, b.h * b.l}
		total += 2*sides[0] + 2*sides[1] + 2*sides[2] + slices.Min(sides)
	}
	fmt.Println("Part 1:", total)

	total = 0
	for _, b := range boxes {
		perimeters := []int{2 * (b.l + b.w), 2 * (b.w + b.h), 2 * (b.h + b.l)}
		volume := b.l * b.w * b.h
		total += slices.Min(perimeters) + volume
	}
	fmt.Println("Part 2:", total)
}
