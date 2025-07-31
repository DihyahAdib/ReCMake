package main

import "core:fmt"
import rl "vendor:raylib"
import u "utils"

initWindowSetup :: proc() {
    rl.SetConfigFlags({.WINDOW_RESIZABLE})
    rl.InitWindow(u.screenWidth, u.screenHeight, "ReMake")
    rl.SetTargetFPS(120)
}

initGameAssets::proc() -> (Player, Enemy) {
    playerTexture := rl.LoadTexture("src/assets/sword.png")
    enemyTexture := rl.LoadTexture("src/assets/SmirkDude.png")

        if enemyTexture.id == 0 {
        fmt.println("ERROR: Failed to load enemy texture! Check path and file: src/assets/SmirkDude.png")
    } else {
        fmt.println("Enemy texture loaded successfully! ID:", enemyTexture.id, " Size:", enemyTexture.width, "x", enemyTexture.height)
    }

    playerInstance := createPlayer(playerTexture)
    enemyInstance := createEnemy(enemyTexture)

    return playerInstance, enemyInstance
}

update::proc(p: ^Player, e:^Enemy, dt: f32) {
    movePlayer(p, dt)
    playerCollisionCheck(p)
    enemyCollisionCheck(e)
}

drawGameObjects::proc(p: Player, e: Enemy) {
    rl.ClearBackground({110, 184, 168, 255})
    drawPlayer(p)
    drawEnemy(e)
    rl.DrawFPS(220, 5)
}


main::proc() {
    initWindowSetup()
    playerInstance, enemyInstance := initGameAssets()

    for !rl.WindowShouldClose() {
        dt := rl.GetFrameTime()

        update(&playerInstance, &enemyInstance, dt)

        rl.BeginDrawing()
            drawGameObjects(playerInstance, enemyInstance)
        rl.EndDrawing()
    }
    unloadAllTextures(playerInstance, enemyInstance)
    rl.CloseWindow()
}

unloadAllTextures::proc(p: Player , e: Enemy) {
    rl.UnloadTexture(p.texture)
    rl.UnloadTexture(e.texture)
}