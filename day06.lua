-- Indexes start at 1 in lua

local function partOne (lines)
    -- creating the lights array
    local lights = {}
    for i = 1, 1000 do
        lights[i] = {}
        for j = 1, 1000 do
            lights[i][j] = 0
        end
    end
    
    -- iterate through lines
    for line in lines do
      -- retrieving coords
      local index = 1
      local coords = {}
      for v1, v2 in string.gmatch(line, " (%d+),(%d+)" ) do
        coords[index] = {v1+1, v2+1}
        index = index + 1
      end
    
      -- retrieving action
      local action = nil
      for key in string.gmatch(line, " on " ) do
        if key then
          action = "on"
        end
      end
      if not action then
        for key in string.gmatch(line, " off " ) do
          if key then
            action = "off"
          end
        end
      end
    
      -- filling lights
      for i = coords[1][2], coords[2][2], 1 do
        for j = coords[1][1], coords[2][1], 1 do
          if action == "on" then
            lights[i][j] = 1
          elseif action == "off" then
            lights[i][j] = 0
          else
            if lights[i][j] == 1 then
              lights[i][j] = 0
            else
              lights[i][j] = 1
            end
          end  
        end
      end
    end
    
    -- counting lights
    local count = 0
    for i = 1, 1000, 1 do
      for j = 1, 1000, 1 do
        if lights[i][j] == 1 then
            count = count + 1
        end
      end
    end
    
    return count
  end
  
  local function partTwo (lines)
    -- creating the lights array
    local lights = {}
    for i = 1, 1000 do
        lights[i] = {}
        for j = 1, 1000 do
            lights[i][j] = 0
        end
    end
    
    -- iterate through lines
    for line in lines do
      -- retrieving coords
      local index = 1
      local coords = {}
      for v1, v2 in string.gmatch(line, " (%d+),(%d+)" ) do
        coords[index] = {v1+1, v2+1}
        index = index + 1
      end
    
      -- retrieving action
      local action = nil
      for key in string.gmatch(line, " on " ) do
        if key then
          action = "on"
        end
      end
      if not action then
        for key in string.gmatch(line, " off " ) do
          if key then
            action = "off"
          end
        end
      end
    
      -- filling lights
      for i = coords[1][2], coords[2][2], 1 do
        for j = coords[1][1], coords[2][1], 1 do
          if action == "on" then
            lights[i][j] = lights[i][j] + 1
          elseif action == "off" then
            lights[i][j] = lights[i][j] > 0 and lights[i][j] - 1 or 0
          else
            lights[i][j] = lights[i][j] + 2
          end
        end
      end
    end
    
    -- counting lights
    local count = 0
    for i = 1, 1000, 1 do
      for j = 1, 1000, 1 do
            count = count + lights[i][j]
      end
    end
    
    return count
  end
  
  local fileP1 = io.open("input.txt")
  local fileLinesP1 = fileP1:lines()
  print("PART 1 - real: ", partOne(fileLinesP1))
  
  local fileP2 = io.open("input.txt")
  local fileLinesP2 = fileP2:lines()
  print("PART 2 - real: ", partTwo(fileLinesP2))