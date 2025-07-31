package main

import "core:fmt"
import rl "vendor:raylib"
import u "utils"

Enemy::struct {
    pos: rl.Vector2,
    speed: f32,
    size: rl.Vector2,
    health: f32,
    name: string,
    isDead: bool,
    roomKey: string,
    color: rl.Color,
    texture: rl.Texture2D,
}

enemyNameDictionary :: struct {

}

createEnemy::proc(enemyImg: rl.Texture2D) -> Enemy {
    return Enemy {
        pos = rl.Vector2 {640, 320},
        speed = 350.0,
        size = rl.Vector2 {64, 64},
        health = 50.0,
        name = "Smirk Dude",
        isDead = false,
        roomKey = "",
        color = rl.WHITE,
        texture = enemyImg
    }
}

drawEnemy::proc(e: Enemy) {
    rotation := f32(0.0)
    scale := f32(0.5)
    rl.DrawTextureEx(e.texture, e.pos, rotation, scale, e.color)
}

enemyCollisionCheck::proc(e: ^Enemy) {
    crntScnW := u.GetCurrentScreenWidth()
    crntScnH := u.GetCurrentScreenHeight()
    if e.pos.x < 0 {
        e.pos.x = 0
    }
    if e.pos.x + e.size.x > crntScnW {
        e.pos.x = crntScnW - e.size.x
    }
    if e.pos.y < 0 {
        e.pos.y = 0
    }
    if e.pos.y + e.size.y > crntScnH {
        e.pos.y = crntScnH - e.size.y
    }
}