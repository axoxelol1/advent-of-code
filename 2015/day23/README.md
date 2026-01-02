# Day 23 usage

I don't want to include my assembly as it will reveal my input. But I wrote a python transpiler.
For part 2 you can simply add an inc a instruction at the top of your input file.

```
cat input.txt | python transpiler.py > main.s
clang -g main.s -o main
lldb ./main --batch -o "b exit" -o "run" -o "register read x19 x20"
```
