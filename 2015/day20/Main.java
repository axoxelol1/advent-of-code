public static void main(String[] args) {
  if (args.length < 2) {
    System.out.println("Give p1 input");
    System.exit(0);
  }
  int[] houses = new int[1000000];
  for (int i = 1; i < houses.length; i++) {
    int curr = i;
    while (curr < houses.length) {
      houses[curr] += (i) * 10;
      curr += i;
    }
  }
  for (int i = 0; i < houses.length; i++) {
    if (houses[i] >= Integer.parseInt(args[1])) {
      System.out.println("Part 1: " + i);
      break;
    }
  }

  houses = new int[1000000];
  for (int i = 1; i < houses.length; i++) {
    int curr = i;
    int delivered = 0;
    while (curr < houses.length && delivered < 50) {
      houses[curr] += (i) * 11;
      curr += i;
      delivered += 1;
    }
  }
  for (int i = 0; i < houses.length; i++) {
    if (houses[i] >= Integer.parseInt(args[1])) {
      System.out.println("Part 2: " + i);
      break;
    }
  }
}
