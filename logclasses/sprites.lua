Sprite = class("Sprite", {
	origin = nil
})

function Sprite:init(origin)
	Stache.checkArg("origin", origin, "vector", "Sprite:init")

	self.origin = origin
end

StaticSprite = Sprite:extend("StaticSprite", {
	quad = nil
})

function StaticSprite:init(data)
	Sprite.init(self, data.origin)

	self.quad = lg.newQuad(data.x, data.y, data.w, data.h, data.dimw, data.dimh)
end

function StaticSprite:update(dt)
end

function StaticSprite:draw(sheet, offset, angRad, scale)
	lg.draw(sheet, self.quad, offset.x, offset.y, angRad, scale.x, scale.y, self.origin.x, self.origin.y)
end

AnimatedSprite = Sprite:extend("AnimatedSprite", {
	animation = nil,
	duration = nil
})

function AnimatedSprite:init(data)
	Sprite.init(self, data.origin)

	self.animation = anim8.newAnimation(anim8.newGrid(unpack(data.grid)):getFrames(unpack(data.frames)), data.durations, data.onLoop)
	self.duration = data.duration
end

function AnimatedSprite:update(dt)
	self.animation:update(60 * dt) -- Durations are stored at 60fps
end

function AnimatedSprite:draw(sheet, offset, angRad, scale)
	self.animation:draw(sheet, offset.x, offset.y, angRad, scale.x, scale.y, self.origin.x, self.origin.y)
end
