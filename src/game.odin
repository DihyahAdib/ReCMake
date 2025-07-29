package main

import "core:fmt"
import rl "vendor:raylib"
import u "utils"

initWindowSetup :: proc() {
    rl.SetConfigFlags({.WINDOW_RESIZABLE})
    rl.InitWindow(u.ScreenWidth, u.ScreenHeight, "ReMake")
    rl.SetTargetFPS(120)
}

update::proc(player: ^Player, dt: f32) {
    movePlayer(player, dt)
    playerCollisionCheck(player)
}

drawGameElement::proc(player: Player) {
    rl.ClearBackground(rl.WHITE)
    drawPlayer(player)
    rl.DrawFPS(220, 5)
}

main::proc() {
    initWindowSetup()

    playerTexture := rl.LoadTexture("src/assets/sword.png")
    if playerTexture.id == 0 {
    fmt.println("ERROR: Failed to load player texture! Check path and file.")
    } else {
        fmt.println("Player texture loaded successfully! ID:", playerTexture.id, " Size:", playerTexture.width, "x", playerTexture.height)
    }
    playerInstance := createPlayer(playerTexture)

    for !rl.WindowShouldClose() {
        dt := rl.GetFrameTime()

        update(&playerInstance, dt)

        rl.BeginDrawing()
            drawGameElement(playerInstance)
        rl.EndDrawing()
    }
    rl.UnloadTexture(playerTexture)
    rl.CloseWindow()
}