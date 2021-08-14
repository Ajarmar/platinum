    .gba
    .open "z2.gba", "z2-platinum.gba", 0x08000000
    .include "constants.asm"
    .include "regions.asm"
    .include "new-checkpoints.asm"
    .include "new-camera-data.asm"
    .include "skip-funcs.asm"
    .include "stages/intro.asm"
    .include "stages/panter.asm"
    .include "stages/phoenix.asm"
    .include "stages/poler.asm"
    .include "stages/hyleg.asm"
    .include "stages/na1.asm"
    .include "stages/kuwagust.asm"
    .include "stages/harpuia.asm"
    .include "stages/burble.asm"
    .include "stages/leviathan.asm"
    .include "stages/fefnir.asm"
    .include "stages/na2.asm"
    .include "stages/fefnirap.asm"
    .include "stages/leviathanap.asm"
    .include "stages/harpuiaap.asm"
    .include "stages/final.asm"
    .include "stages/cmdroom.asm"

    .org REG_MAIN
    .area REG_MAIN_AREA
    
    .ascii "PLAT"

    .endarea

    ; Change the sound effect that plays when the game is started
    ; For easier verification purposes
    .org ROMADDR_START_GAME_SOUND_EFFECT
    mov     r0,#0x88                    ; Moero
    
    ; Set the Zero max entity count to 1
    ; This will break multiplayer but frees up a chunk of RAM that can be used (0x304 bytes)
    .org ROMADDR_SET_ZERO_ENTITY_MAX_LOCATION
    mov     r2,#0x1

    .close
