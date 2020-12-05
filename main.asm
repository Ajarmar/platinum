    .gba
    .open "z2prac.gba", "z2prac-platinum.gba", 0x08000000
    .include "constants.asm"
    .include "regions.asm"
    .include "new-checkpoints.asm"
    .include "skip-funcs.asm"
    .include "stages/intro.asm"
    .include "stages/panter.asm"
    .include "stages/phoenix.asm"
    .include "stages/poler.asm"
    .include "stages/hyleg.asm"
    .include "stages/na1.asm"
    .include "stages/kuwagust.asm"
    .include "stages/cmdroom.asm"

    .close

    ; Script entrypoint: 0x0801B6EC
    ; Stage function entrypoint: 0x08014A5C
    ; 0x080C41B6
    ; Break at 0203B709