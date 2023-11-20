-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Images
local background = display.newImageRect( "background.png", 360, 570 )

background:rotate(90)
background.x = display.contentCenterX
background.y = display.contentCenterY

-- BPM Configuration
local bpm = 120 -- Beats Per Minute
local mspb = 60000 / bpm -- MilliSeconds Per Beat

-- Display Beat
local beatNo = 1
local beatText = display.newText( "Beat " .. beatNo, display.contentCenterX, 80, native.systemFont, 36 )
local function beat()
    if ( beatNo == 4 ) then
        beatNo = 1
    else
        beatNo = beatNo + 1
    end
    beatText.text = "Beat " .. beatNo
end

local beatTimer = timer.performWithDelay( mspb, beat , 0 )

-- Click Timing calculator
local startTime = system.getTimer() -- In milliseconds
local PERFECT = "PERFECT!"
local GOOD = "Good"
local MEH = "meh..."

local lastClickStatus = ""
local statusText = display.newText( lastClickStatus, display.contentCenterX, 180, native.systemFont, 24 )

local function handleClick()
    local currentTime = system.getTimer()
    local diff = (currentTime - startTime) % mspb -- Difference from beat in milliseconds
    diff = math.min(diff, math.abs(mspb - diff))
    print(diff)
    if ( diff <= 50 ) then
        lastClickStatus = PERFECT
    elseif ( diff <= 150 ) then
        lastClickStatus = GOOD
    else
        lastClickStatus = MEH
    end
    
    statusText.text = lastClickStatus
    timer.performWithDelay( 200, function() statusText.text = "" end)
end

display.currentStage:addEventListener( "tap", handleClick )
