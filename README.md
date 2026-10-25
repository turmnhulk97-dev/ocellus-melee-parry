
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

