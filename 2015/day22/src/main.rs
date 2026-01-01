use std::cmp;

#[derive(Clone, Debug)]
struct GameState {
    player_hp: i32,
    player_mana: i32,
    boss_hp: i32,
    boss_dmg: i32,
    shield_timer: i32,
    poison_timer: i32,
    recharge_timer: i32,
}

#[derive(PartialEq, Clone, Copy)]
enum Spell {
    MagicMissile,
    Drain,
    Shield,
    Poison,
    Recharge,
}

impl Spell {
    fn cost(&self) -> i32 {
        use Spell::*;
        match self {
            MagicMissile => 53,
            Drain => 73,
            Shield => 113,
            Poison => 173,
            Recharge => 229,
        }
    }
}

fn can_cast(spell: &Spell, state: &GameState) -> bool {
    if state.shield_timer > 0 && *spell == Spell::Shield {
        return false;
    }
    if state.poison_timer > 0 && *spell == Spell::Poison {
        return false;
    }
    if state.recharge_timer > 0 && *spell == Spell::Recharge {
        return false;
    }
    spell.cost() <= state.player_mana
}

// Don't really like this C style pass pointer and void return
fn min_mana(mut state: GameState, mana_spent: i32, current_best: &mut i32, p2: bool) {
    if p2 {
        state.player_hp -= 1;
    }
    if mana_spent >= *current_best {
        return;
    }
    if state.player_hp <= 0 {
        return;
    }
    state.shield_timer -= 1;
    if state.poison_timer > 0 {
        state.boss_hp -= 3
    }
    state.poison_timer -= 1;
    if state.recharge_timer > 0 {
        state.player_mana += 101
    }
    state.recharge_timer -= 1;
    if state.boss_hp <= 0 {
        *current_best = cmp::min(*current_best, mana_spent);
        return;
    }

    use Spell::*;
    [MagicMissile, Drain, Shield, Poison, Recharge]
        .into_iter()
        .filter(|spell| can_cast(spell, &state))
        .for_each(|spell| {
            let new_cost = mana_spent + spell.cost();
            let mut new_state = state.clone();
            new_state.player_mana -= spell.cost();
            match spell {
                MagicMissile => new_state.boss_hp -= 4,
                Drain => {
                    new_state.player_hp += 2;
                    new_state.boss_hp -= 2;
                }
                Shield => {
                    new_state.shield_timer = 6;
                }
                Poison => new_state.poison_timer = 6,
                Recharge => new_state.recharge_timer = 5,
            }
            //Boss turn
            new_state.shield_timer -= 1;
            if new_state.poison_timer > 0 {
                new_state.boss_hp -= 3
            }
            new_state.poison_timer -= 1;
            if new_state.recharge_timer > 0 {
                new_state.player_mana += 101
            }
            new_state.recharge_timer -= 1;

            if new_state.boss_hp <= 0 {
                *current_best = cmp::min(*current_best, new_cost);
                return;
            }

            let armor = if new_state.shield_timer > 0 { 7 } else { 0 };
            new_state.player_hp -= (new_state.boss_dmg - armor).max(1);
            min_mana(new_state, new_cost, current_best, p2)
        })
}

fn main() {
    let input = include_str!("input.txt");
    let nums: Vec<i32> = input
        .split_whitespace()
        .filter_map(|s| s.parse().ok())
        .collect();
    let state = GameState {
        player_hp: 50,
        player_mana: 500,
        boss_hp: nums[0],
        boss_dmg: nums[1],
        shield_timer: 0,
        poison_timer: 0,
        recharge_timer: 0,
    };
    let mut best = i32::MAX;
    min_mana(state.clone(), 0, &mut best, false);
    println!("Part 1: {}", best);
    best = i32::MAX;
    min_mana(state, 0, &mut best, true);
    println!("Part 2: {}", best);
}
