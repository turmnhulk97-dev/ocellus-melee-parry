
-- Ocellus Melee Parry Practice Trainer
-- Standalone Lua reaction-time trainer
-- Requires Lua 5.1 or later

local CONFIG = {
    parry_window = 0.250, -- Target reaction time in seconds
    min_delay = 1,
    max_delay = 4,
    rounds = 10
}

local stats = {
    attempts = 0,
    successful = 0,
    missed = 0,
    total_reaction = 0
}

local function sleep(seconds)
    local start = os.clock()
    while os.clock() - start < seconds do
        -- Wait for the next practice round
    end
end

local function random_delay()
    return CONFIG.min_delay
        + math.random() * (CONFIG.max_delay - CONFIG.min_delay)
end

local function show_stats()
    local accuracy = 0
    local average = 0

    if stats.attempts > 0 then
        accuracy = stats.successful / stats.attempts * 100
    end

    if stats.successful > 0 then
        average = stats.total_reaction / stats.successful
    end

    print("\n------ SESSION STATS ------")
    print("Attempts: " .. stats.attempts)
    print("Successful parries: " .. stats.successful)
    print("Missed parries: " .. stats.missed)
    print(string.format("Accuracy: %.1f%%", accuracy))
    print(string.format("Average successful reaction: %.3fs", average))
    print("---------------------------")
end

local function practice_round(round)
    print(string.format("\nRound %d/%d", round, CONFIG.rounds))
    print("Get ready...")

    sleep(random_delay())

    print("\n>>> ATTACK! Type P and press ENTER immediately!")
    local started = os.clock()
    local response = io.read()
    local reaction = os.clock() - started

    stats.attempts = stats.attempts + 1

    if response and response:lower():match("^%s*p%s*$")
        and reaction <= CONFIG.parry_window then
        stats.successful = stats.successful + 1
        stats.total_reaction = stats.total_reaction + reaction
        print(string.format("PARRY SUCCESS! Reaction: %.3fs", reaction))
    else
        stats.missed = stats.missed + 1
        if response and response:lower():match("^%s*p%s*$") then
            print(string.format("TOO SLOW! Reaction: %.3fs", reaction))
        else
            print("MISSED! Enter P to attempt a parry.")
        end
    end

    show_stats()
end

math.randomseed(os.time())

print("================================")
print("   OCELLUS PARRY TRAINER")
print("================================")
print("Practice your melee parry timing.")
print("Target window: " .. CONFIG.parry_window .. " seconds")
print("Rounds: " .. CONFIG.rounds)
print("\nThis is a standalone reaction trainer.")
print("It does not send inputs to Ocellus.")
io.write("\nPress ENTER to start...")
io.read()

for round = 1, CONFIG.rounds do
    practice_round(round)
end

print("\nTraining complete!")
show_stats()
print("Practice again to improve your reaction time.")
