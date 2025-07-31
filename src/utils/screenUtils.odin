package utils

import rl "vendor:raylib"

screenWidth :: 1280
screenHeight :: 720

GetCurrentScreenWidth :: proc() -> f32 {
    return f32(rl.GetScreenWidth())
}

GetCurrentScreenHeight :: proc() -> f32 {
    return f32(rl.GetScreenHeight())
}

GetWinCenterX :: proc() -> f32 {
    return f32(rl.GetScreenWidth()) / 2.0
}

GetWinCenterY :: proc() -> f32 {
    return f32(rl.GetScreenHeight()) / 2.0
}
