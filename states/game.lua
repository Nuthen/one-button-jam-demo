game = {}

-- Game TODO:
--      * Add identity and title to conf.lua

function game:enter()
    self.pattern = {1, 2, 1, 2}
    self.holds = {"start", false, "stop", false}
    self.step = 1

    self.playersHolding = {false, false}
end

function game:update(dt)

end

function game:keypressed(key, code)
    if key == "return" then
        if self.step > #self.pattern then
            self.step = 1
            self.playersHolding = {false, false}
        end
    end

    if tonumber(key) == self.pattern[self.step] then
        if self.holds[self.step] then
            if self.holds[self.step] == "start" then
                self.step = self.step + 1

                self.playersHolding[tonumber(key)] = true
            else
                self.step = 1 -- fail
            end
        else
            self.step = self.step + 1
        end
    else
        self.step = 1 -- fail
    end
end

function game:keyreleased(key, code)
    if tonumber(key) == self.pattern[self.step] then
        if self.holds[self.step] == "stop" then
            self.step = self.step + 1
        else
            self.step = 1 -- fail
        end
    elseif self.playersHolding[tonumber(key)] then
        self.step = 1 -- fail
    end
end

function game:mousepressed(x, y, mbutton)

end

function game:draw()
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

    for i, match in ipairs(self.playersHolding) do
        love.graphics.setColor(255, 255, 255)

        local text = "false"
        if match then text = "true" end

        love.graphics.print(text, x + (i-1)*100, y + 100)
    end
end