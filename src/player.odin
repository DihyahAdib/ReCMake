package main

import "core:fmt"
import rl "vendor:raylib"
import u "utils"

Player :: struct {
    pos: rl.Vector2,
    speed: f32,
    size:rl.Vector2,
    color: rl.Color,
}

createPlayer :: proc() -> Player {
    return Player {
        pos   = rl.Vector2 {640, 320},
        speed = 400.0,
        size  = rl.Vector2 {64, 64},
        color = rl.GREEN,
    }
}

drawPlayer::proc(p: ^Player) {
    rl.DrawRectangleV(p.pos, p.size, p.color)
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
    if p.pos.x < 0 {
        p.pos.x = 0
    }
    if p.pos.x + p.size.x > f32(rl.GetScreenWidth()) {
        p.pos.x = f32(rl.GetScreenWidth()) - p.size.x
    }
    if p.pos.y < 0 {
        p.pos.y = 0
    }
    if p.pos.y + p.size.y > f32(rl.GetScreenHeight()) {
        p.pos.y = f32(rl.GetScreenHeight()) - p.size.y
    }
}