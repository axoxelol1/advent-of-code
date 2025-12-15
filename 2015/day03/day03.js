const fs = require('fs');
const map1 = new Map();


const input = fs.readFileSync('input.txt', 'utf8').trim();

curr = [0, 0];
gifts = new Set();
gifts.add(curr.join());
for (let i = 0; i < input.length; i++) {
    c = input[i];
    if (c == '^') {
        curr[1]++;
    } else if (c == 'v') {
        curr[1]--;
    } else if (c == '>') {
        curr[0]++;
    } else if (c == '<') {
        curr[0]--;
    }
    gifts.add(curr.join());
}

console.log("Part 1: " + gifts.size);

gifts.clear();
curr = [0, 0];
currRobot = [0, 0];
gifts.add(curr.join());
for (let i = 0; i < input.length; i++) {
    c = input[i];
    if (i % 2 == 0) {
        if (c == '^') {
            curr[1]++;
        } else if (c == 'v') {
            curr[1]--;
        } else if (c == '>') {
            curr[0]++;
        } else if (c == '<') {
            curr[0]--;
        }
        gifts.add(curr.join());
    } else {
        if (c == '^') {
            currRobot[1]++;
        } else if (c == 'v') {
            currRobot[1]--;
        } else if (c == '>') {
            currRobot[0]++;
        } else if (c == '<') {
            currRobot[0]--;
        }
        gifts.add(currRobot.join());
    }
}

console.log("Part 2: " + gifts.size);
