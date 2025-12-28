import Foundation

@available(macOS 13.0, *)
@main
struct day19 {
    static func main() {
        let input = try! String(contentsOfFile: "input.txt", encoding: .utf8)
        let lines = input.split(separator: "\n")
        let molecule = lines.last!
        var transformations = [String: [String]]()
        var reversedTransformations = [String: String]()
        for transformation in lines[0...lines.count - 2] {
            let parts = transformation.components(separatedBy: " => ")
            transformations[parts.first!, default: []].append(parts.last!)
            if reversedTransformations[parts.last!] != nil {
                fatalError("Duplicate rule for \(parts.last!)")
            }
            reversedTransformations[parts.last!] = parts.first!
        }
        var possibilities: Set<String> = []
        for (key, replacements) in transformations {
            for replacement in replacements {
                var i = molecule.startIndex
                while let fromMatch = molecule.range(
                    of: key,
                    range: i..<molecule.endIndex
                ) {
                    possibilities.insert(
                        molecule.replacingCharacters(
                            in: fromMatch,
                            with: replacement
                        )
                    )
                    i = molecule.index(after: fromMatch.lowerBound)
                }
            }
        }
        print("Part 1: \(possibilities.count)")

        var keys = Array(reversedTransformations.keys)
        var curr = String(molecule)
        var steps = 0
        var prev = ""
        while curr != "e" {
            if prev == curr {
                keys.shuffle()
                curr = String(molecule)
                steps = 0
                prev = ""
            }
            prev = curr
            for from in keys {
                let to = reversedTransformations[from]!
                if let range = curr.ranges(of: from).last {
                    curr.replaceSubrange(range, with: to)
                    steps += 1
                    break
                }
            }

        }

        print("Part 2: \(steps)")
    }
}
