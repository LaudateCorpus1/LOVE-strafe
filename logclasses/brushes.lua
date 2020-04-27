CircleBrush = CircleCollider:extend("CircleBrush", {
	height = 0,
	color = Stache.colors.white
})

function CircleBrush:__index(key)
	local slf = rawget(self, "members")

	if slf[key] ~= nil then return slf[key]
	else return CircleCollider.__index(self, key) end
end

function CircleBrush:__newindex(key, value)
	local slf = rawget(self, "members")

	if key == "pos" then
		slf.pos = value
		slf.ppos = value
	elseif key == "height" then
		if type(value) ~= "number" then
			formatError("Attempted to set 'height' key of class 'CircleBrush' to a non-numerical value: %q", value)
		end

		slf.height = value
	elseif key == "color" then
		if type(value) ~= "table" and type(value) ~= "userdata" then
			formatError("Attempted to set 'color' key of class 'CircleBrush' to a value that isn't a table or userdata: %q", value)
		end

		slf.color = value
	else
		CircleCollider.__newindex(self, key, value)
	end
end

function CircleBrush:init(radius, pos, height, color)
	CircleCollider.init(self, radius)

	if pos then self.pos = pos end
	if height then self.height = height end
	if color then self.color = color end
end

function CircleBrush:draw()
	CircleCollider.draw(self, self.color)
end
