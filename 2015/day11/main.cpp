#include <chrono>
#include <cstddef>
#include <iostream>
#include <optional>
#include <string>

bool check(std::string_view password) {
  if (password.contains('i') || password.contains('o') ||
      password.contains('l')) {
    return false;
  }

  int pairs{false};
  std::optional<char> p1{};

  bool threeInc{false};
  for (size_t i{0}; i < password.length() - 1; ++i) {
    if (i < password.length() - 2 && password[i] + 1 == password[i + 1] &&
        password[i + 1] + 1 == password[i + 2]) {
      threeInc = true;
    }
    if (password[i] == password[i + 1]) {
      if (!p1) {
        p1 = password[i];
      } else if (p1 && p1.value() != password[i]) {
        pairs = true;
      }
    }
  }

  return (threeInc && pairs);
}

void increment_password(std::string& password) {
  for (size_t i{password.length() - 1}; 0 <= i; --i) {
    if (password[i] == 'z') {
      password[i] = 'a';
    } else {
      password[i] += 1;
      break;
    }
  }
}

int main() {
  auto start = std::chrono::high_resolution_clock::now();
  std::string password{};
  std::cin >> password;
  while (!check(password)) {
    increment_password(password);
  }
  std::cout << "Part 1: " << password << '\n';
  auto p1end = std::chrono::high_resolution_clock::now();

  increment_password(password);
  while (!check(password)) {
    increment_password(password);
  }
  std::cout << "Part 2: " << password << '\n';

  auto p2end = std::chrono::high_resolution_clock::now();

  using namespace std::chrono;
  auto t1 = duration_cast<milliseconds>(p1end - start);
  auto t2 = duration_cast<milliseconds>(p2end - p1end);
  auto total = duration_cast<milliseconds>(p2end - start);
  std::cout << "Timings:\nPart 1: " << t1 << "\nPart 2: " << t2
            << "\nTotal: " << total;

  return 0;
}
