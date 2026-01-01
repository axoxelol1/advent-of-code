bool player_wins(int player_dmg, int player_armor)
{
    int player_hp = 100;
    var input = File.ReadAllLines("input.txt");
    int boss_hp = int.Parse(input[0].Split().Last());
    int boss_dmg = int.Parse(input[1].Split().Last());
    int boss_armor = int.Parse(input[2].Split().Last());
    while (true)
    {
        boss_hp -= Math.Max(1, player_dmg - boss_armor);
        if (boss_hp <= 0)
            return true;
        player_hp -= Math.Max(1, boss_dmg - player_armor);
        if (player_hp <= 0)
            return false;
    }
}


var weapons = new Item[] {
new(8, 4, 0),
new(10, 5, 0),
new(25, 6, 0),
new(40, 7, 0),
new(74, 8, 0)};

var armors = new Item[] {
new(13, 0, 1),
new(31, 0, 2),
new(53, 0, 3),
new(75, 0, 4),
new(102, 0, 5),
new(0,0,0)}; // armor is optional

var rings = new Item[] {
new(25, 1, 0),
new(50, 2, 0),
new(100, 3, 0),
new(20, 0, 1),
new(40, 0, 2),
new(80, 0, 3),
new(0,0,0),new(0,0,0)}; // rings are optional

int min_cost = int.MaxValue;
int max_cost = int.MinValue;
foreach (Item weapon in weapons)
{
    foreach (Item armor in armors)
    {
        for (int i = 0; i < rings.Length; i++)
        {
            for (int j = i + 1; j < rings.Length; j++)
            {
                var ring1 = rings[i];
                var ring2 = rings[j];
                var won = player_wins(weapon.dmg + ring1.dmg + ring2.dmg, armor.armor + ring1.armor + ring2.armor);
                var cost = weapon.cost + armor.cost + ring1.cost + ring2.cost;
                if (won)
                {
                    min_cost = Math.Min(min_cost, cost);
                }
                else
                {
                    max_cost = Math.Max(max_cost, cost);
                }
            }
        }
    }
}

Console.WriteLine($"Part 1: {min_cost}");
Console.WriteLine($"Part 2: {max_cost}");

public record Item(int cost, int dmg, int armor);
