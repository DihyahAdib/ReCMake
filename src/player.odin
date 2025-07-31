package main

import "core:fmt"
import rl "vendor:raylib"
import u "utils"

Player::struct {
    pos: rl.Vector2,
    speed: f32,
    scale: f32,
    size:rl.Vector2,
    health: f32,
    name: string,
    isDead: bool,
    roomKey: string,
    color: rl.Color,
    texture: rl.Texture2D,
}

createPlayer::proc(playerImg: rl.Texture2D) -> Player {
    pScale := f32(0.3)

    return Player {
        pos   = rl.Vector2 {u.GetWinCenterX(), u.GetWinCenterY()},
        speed = 400.0,
        scale = pScale,
        size  = rl.Vector2 {
            f32(playerImg.width) * pScale, 
            f32(playerImg.height) * pScale
        },
        health = 100.0,
        name = "Bon Bon",
        isDead = false,
        roomKey = "", // should equal starting room (or) current saved room
        color = rl.GREEN,
        texture = playerImg,
    }
}

drawPlayer::proc(p: Player) {
    rotation := f32(0.0)
    rl.DrawTextureEx(p.texture, p.pos, rotation, p.scale, p.color)
}

movePlayer::proc(p: ^Player, dt: f32) {
    if rl.IsKeyDown(.A) {
        p.pos.x -= p.speed * dt
    }
    if rl.IsKeyDown(.D) {
        p.pos.x += p.speed * dt
    }
    if rl.IsKeyDown(.W) {
        p.pos.y -= p.speed * dt
    }
    if rl.IsKeyDown(.S) {
        p.pos.y += p.speed * dt
    }
}

playerCollisionCheck::proc(p: ^Player) {
    crntScnW := u.GetCurrentScreenWidth()
    crntScnH := u.GetCurrentScreenHeight()
    if p.pos.x < 0 {
        p.pos.x = 0
    }
    if p.pos.x + p.size.x > crntScnW {
        p.pos.x = crntScnW - p.size.x
        //playertouching wall is true - for later when adding rooms
    }
    if p.pos.y < 0 {
        p.pos.y = 0
    }
    if p.pos.y + p.size.y > crntScnH  {
        p.pos.y = crntScnH - p.size.y
    }
}