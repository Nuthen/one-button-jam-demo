game2 = {}

-- game2 TODO:
--      * Add identity and title to conf.lua

function game2:enter()
    self.pattern = {1, 2, 1, 2}
    self.holds = {false, false, true, false}
    self.step = 1

    self.holdThreshold = 0.15

    self.holdTimer = {0, 0}
end

function game2:update(dt)
    for i = 1, 2 do
        local char = "1"
        if i == 2 then char = "2" end

        if love.keyboard.isDown(char) then
            self.holdTimer[i] = self.holdTimer[i] + dt

        else
            if self.holdTimer[i] > 0 then
                local hold = false -- single press by default

                if self.holdTimer[i] > self.holdThreshold then -- hold
                    hold = true
                end

                if self.pattern[self.step] == i then
                    if self.holds[self.step] == hold then
                        self.step = self.step + 1
                    else
                        self.step = 1 -- fail
                    end
                else
                    self.step = 1 -- fail
                end
            end

            self.holdTimer[i] = 0
        end
    end
end

function game2:keypressed(key, code)
    if key == "return" then
        if self.step > #self.pattern then
            self.step = 1
        end
    end
end

function game2:keyreleased(key, code)
    
end

function game2:mousepressed(x, y, mbutton)

end

function game2:draw()
    love.graphics.setColor(255, 255, 255)

    love.graphics.setFont(font[48])
    local x = love.graphics.getWidth()/2
    local y = love.graphics.getHeight()/2

    for i, match in ipairs(self.pattern) do
        love.graphics.setColor(255, 255, 255)

        if i < self.step then
            love.graphics.setColor(0, 0, 255)
        end

        love.graphics.print(match, x + (i-1)*40, y)
    end

    for i, time in ipairs(self.holdTimer) do
        love.graphics.setColor(255, 255, 255)

        local text = "false"
        if time > self.holdThreshold then text = "true" end

        love.graphics.print(text, x + (i-1)*100, y + 100)
    end
end