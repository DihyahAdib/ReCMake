package main

import "core:fmt"
import rl "vendor:raylib"
import u "utils"

main::proc() {
    rl.SetConfigFlags({.WINDOW_RESIZABLE})
    rl.InitWindow(u.windowWidth, u.windowHeight, "My Odin Raylib Game")

    player := createPlayer()

    for !rl.WindowShouldClose() {
        dt := rl.GetFrameTime()

        movePlayer(&player, dt)

        rl.BeginDrawing()
            rl.ClearBackground(rl.WHITE)

            drawPlayer(&player)
            playerCollisionCheck(&player)
            rl.DrawFPS(220, 5)

        rl.EndDrawing()
    }
    rl.CloseWindow()
}

