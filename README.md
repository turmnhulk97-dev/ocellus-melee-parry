
-- Ocellus Melee Parry Practice
-- Standalone Lua training simulator
-- Requires LuaSocket for accurate timed input? No.
-- Runs with standard Lua 5.1+

local CONFIG = {
    rounds = 20,
    parryWindow = 0.250,
    minDelay = 1.5,
    maxDelay = 4.0
}

local stats = {
    attempts = 0,
    parries = 0,
    misses = 0,
    reactionTotal = 0
}

math.randomseed(os.time())

local function wait(seconds)
    local start = os.clock()
    while os.clock() - start < seconds do end
end

local function printStats()
    local accuracy = stats.attempts > 0
        and stats.parries / stats.attempts * 100 or 0

    local average = stats.parries > 0
        and stats.reactionTotal / stats.parries or 0

    print("\n--- Training Statistics ---")
    print("Attempts: " .. stats.attempts)
    print("Successful: " .. stats.parries)
    print("Missed: " .. stats.misses)
    print(string.format("Accuracy: %.1f%%", accuracy))
    print(string.format("Average reaction: %.3fs", average))
end

local function runRound(round)
    print(string.format("\nRound %d/%d", round, CONFIG.rounds))
    print("Wait for the attack cue...")

    local delay = CONFIG.minDelay
        + math.random() * (CONFIG.maxDelay - CONFIG.minDelay)

    wait(delay)

    print("\n!!! ATTACK !!!")
    print("Press ENTER to parry!")
    
    local start = os.clock()
    io.read()
    local reaction = os.clock() - start

    stats.attempts = stats.attempts + 1

    if reaction <= CONFIG.parryWindow then
        stats.parries = stats.parries + 1
        stats.reactionTotal = stats.reactionTotal + reaction
        print(string.format("PARRY SUCCESS: %.3fs", reaction))
    else
        stats.misses = stats.misses + 1
        print(string.format("MISSED: %.3fs", reaction))
    end

    printStats()
end

print("==============================")
print(" OCELLUS MELEE PARRY TRAINER")
print("==============================")
print("Parry window: " .. CONFIG.parryWindow .. " seconds")
print("Rounds: " .. CONFIG.rounds)
print("This is a standalone practice tool.")
print("Terminal input timing is approximate.")

io.write("\nPress ENTER to start training...")
io.read()

for round = 1, CONFIG.rounds do
    runRound(round)
end

print("\nTraining session complete!")
printStats()

# Ocellus Melee Parry Trainer

A lightweight Lua project for practicing reaction timing for melee parries.

## Features

- Randomized attack cues
- Configurable parry window
- Successful parry and miss tracking
- Reaction-time statistics
- No external dependencies

## Requirements

- Lua 5.1 or newer
- Terminal or command prompt

## Usage

Run:

```bash
lua main.lua
```

Press Enter when the attack cue appears.

## Configuration

Edit the CONFIG table in main.lua:

- rounds: Number of practice attempts
- parryWindow: Target time in seconds
- minDelay: Minimum delay before an attack
- maxDelay: Maximum delay before an attack

## Limitations

This is a standalone reaction-time simulator. It does not
read Ocellus game events or send in-game parry inputs.

## License

MIT

MIT License

Copyright (c) 2026

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files, to deal in the Software
without restriction, including without limitation the rights to use, copy,
modify, merge, publish, distribute, sublicense, and/or sell copies.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.


