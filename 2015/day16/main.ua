Keys ← {"children" "cats" "samoyeds" "pomeranians" "akitas" "vizslas" "goldfish" "trees" "cars" "perfumes"}
Goal ← [3 7 2 3 0 0 5 3 2 1]

Lines ← ⊜□ ⊸≠@\n &fras "./sues.txt"

GetVal ← |2 (
  ⊢⋕↙1↘1⬚"¯1"⊢ regex $"_: (\\d+)"
)

Sues ← ⍉⊞GetVal Keys Lines
+1⊚≡(=3/+=Goal)Sues

# There are for sure much better ways to do this in uiua with coole operators
# But I didn't want to spend too much time. Just see the language
Exists ← ≠¯1 Sues
IsGt   ← × Exists ≡(>Goal) Sues
IsLt   ← × Exists ≡(<Goal) Sues
IsEq   ← × Exists ≡(=Goal) Sues

MatchesGt ← ≡(/+⊏ [1 7]) IsGt
MatchesLt ← ≡(/+⊏ [3 6]) IsLt
MatchesEq ← ≡(/+⊏ [0 2 4 5 8 9]) IsEq

+1⊚(=3)++MatchesGt MatchesEq MatchesLt
