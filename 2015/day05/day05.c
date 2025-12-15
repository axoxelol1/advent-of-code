#include <stdio.h>
#include <unistd.h>

int main() {
  char buffer[16];
  char trash[2];
  int nice_strings = 0;
  int nice_strings2 = 0;
  for (int i = 0; i < 1000; i++) {
    read(0, buffer, 16);
    read(0, trash, 1);
    int vowel_count = 0;
    int double_letter = 0;
    int bad_string = 0;
    int pair = 0;
    int repeat = 0;
    for (int c = 0; c < 16; c++) {
      if (buffer[c] == 'a' || buffer[c] == 'e' || buffer[c] == 'i' ||
          buffer[c] == 'o' || buffer[c] == 'u') {
        vowel_count++;
      }
      if (c < 15 && buffer[c] == buffer[c + 1]) {
        double_letter = 1;
      }
      if (c < 15 && (buffer[c] == 'a' && buffer[c + 1] == 'b' ||
                     buffer[c] == 'c' && buffer[c + 1] == 'd' ||
                     buffer[c] == 'p' && buffer[c + 1] == 'q' ||
                     buffer[c] == 'x' && buffer[c + 1] == 'y')) {
        bad_string = 1;
      }
      if (c < 14 && buffer[c] == buffer[c + 2]) {
        repeat = 1;
      }
      for (int d = c + 2; d < 16; d++) {
        if (buffer[c] == buffer[d] && buffer[c + 1] == buffer[d + 1]) {
          pair = 1;
        }
      }
    }
    if (vowel_count >= 3 && double_letter && !bad_string) {
      nice_strings++;
    }
    if (pair && repeat) {
      nice_strings2++;
    }
  }
  printf("Part 1: %d\n", nice_strings);
  printf("Part 2: %d\n", nice_strings2);
}
