
    .org REG_NEW_CHECKPOINTS
    .area REG_NEW_CHECKPOINTS_AREA
intro_chkpnt_4:
    .dw     0
    .dw     0x1C2500
    .dw     0x01BFFF
    .dw     0x0
panter_chkpnt_4:    ; This is actually the position before the perspective changes, but Zero needs some place to spawn
    .dw     0
    .dw     0x26B280
    .dw     0x013FFF
    .dw     0x1
phoenix_chkpnt_7:
    .dw     0
    .dw     0x0EB000
    .dw     0x057FFF
    .dw     0x1
phoenix_chkpnt_8:
    .dw     0
    .dw     0x127000
    .dw     0x025FFF
    .dw     0x1
phoenix_chkpnt_9:
    .dw     0
    .dw     0x163000
    .dw     0x04DFFF
    .dw     0x1
phoenix_chkpnt_A:
    .dw     0
    .dw     0x19F000
    .dw     0x025FFF
    .dw     0x1
phoenix_boss_spawns:
    .dw     0x0F4B80
    .dw     0x04E8AF
    .dw     0x130B80
    .dw     0x01C8AF
    .dw     0x16CB80
    .dw     0x0448AF
    .dw     0x1A8B80
    .dw     0x01C8AF
poler_chkpnt_4:
    .dw     0
    .dw     0x24E87F
    .dw     0x01CFFF
    .dw     0x1
hyleg_chkpnt_4:
    .dw     0
    .dw     0x1A6000
    .dw     0x037FFF
    .dw     0x1
kuwagust_chkpnt_6:
    .dw     0
    .dw     0x141000
    .dw     0x0B1FFF
    .dw     0x1
kuwagust_chkpnt_8:
    .dw     0
    .dw     0x0EEA80
    .dw     0x101FFF
    .dw     0x1
kuwagust_ciel_spawn:
    .db     0x6, 0x5, 0x2C, 0x0
    .dw     0x147000
    .dw     0x0B1FFF
    .dw     0x1
harpuia_chkpnt_4:
    .dw     0
    .dw     0x1D4800
    .dw     0x061FFF
    .dw     0x1
burble_chkpnt_4:
    .dw     0
    .dw     0x20127F
    .dw     0x01CFFF
    .dw     0x1
cmdroom_chkpnt_A:
    .dw     0
    .dw     0x0B6000
    .dw     0x012FFF
    .dw     0x1
cmdroom_chkpnt_B:
    .dw     0
    .dw     0x017780
    .dw     0x01CFFF
    .dw     0x0

    .endarea