import sys

if sys.stdin.isatty():
    print("Provide input via stdin", file=sys.stderr)
    exit()

print("""\
.global _main
.align 4

_main:
mov x19, #0
mov x20, #0
""")


def to_asm_reg(r: str) -> str:
    if r == "a":
        return "x19"
    elif r == "b":
        return "x20"
    else:
        raise ValueError(f"No register called {r}")


instr = 0
jumped_to = set()
for line in sys.stdin.readlines():
    words = line.strip().split()
    print(f"i{instr}: ; {line.strip()}")
    if words[0] == "hlf":
        r = to_asm_reg(words[1])
        print(f"lsr {r}, {r}, #1")
    elif words[0] == "tpl":
        r = to_asm_reg(words[1])
        print("mov x0, #3")
        print(f"mul {r}, {r}, x0")
    elif words[0] == "inc":
        r = to_asm_reg(words[1])
        print(f"add {r}, {r}, #1")
    elif words[0] == "jmp":
        offset = int(words[1])
        print(f"b i{instr + offset}")
        jumped_to.add(instr + offset)
    elif words[0] == "jie":
        r = to_asm_reg(words[1].split(",")[0])
        offset = int(words[2])
        print(f"tbnz {r}, #0, i{instr + 1}")
        print(f"b i{instr + offset}")
        jumped_to.add(instr + offset)
    elif words[0] == "jio":
        r = to_asm_reg(words[1].split(",")[0])
        offset = int(words[2])
        print(f"cmp {r}, #1")
        print(f"beq i{instr + offset}")
        jumped_to.add(instr + offset)
    instr += 1
    print()

for num in jumped_to:
    if instr <= num:
        print(f"i{num}:")

print("""\
exit:
    mov     X0, #0
    mov     X16, #1
    svc     #0x80""")
