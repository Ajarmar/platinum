    .org REG_NEW_CAMERA_DATA
    .area REG_NEW_CAMERA_DATA_AREA

final_camera_1:
    .db     0x6, 0x8, 0x0, 0x0
    .dw     0x0
    .dw     0x0
    .dw     0x0
    .dw     0x0
    .dw     0x0
    .dw     0x0
    .dw     0x0
    .dw     0x3C0000
    .dw     0x0
    .dw     0x0CB000
final_camera_2:
    .db     0x6, 0x8, 0x0, 0x0
    .dw     0x0
    .dw     0x0
    .dw     0x0
    .dw     0x0
    .dw     0x0
    .dw     0x0
    .dw     0x0
    .dw     0x3C0000
    .dw     0x0
    .dw     0x071000

    .endarea