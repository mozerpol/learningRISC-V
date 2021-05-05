### Base Instruction Formats
![bis](https://user-images.githubusercontent.com/43972902/106677743-94848500-65b9-11eb-80f0-bdef052e8ef1.png)

### Cheat sheet
1. **ADD** - *ADD    x3, x1, x2*
2. **ADDI** - *ADDI    x2, x1, 0x5*
3. **ANDI** - *ANDI    x2, x1, 0x2*
4. **AUIPC** - *AUIPC    x5, 0xFFFFF*
5. **BNE** - *bne    x2, x1, label*
6. **BNEZ** - *bnez    x1, isNotEqualZero*
7. **J** - *j    loop*
8. **JAL** - *jal    x4, label*
9. **JALR** - *jalr    x1, x2, 2*
10. **LA** - *la    x1, numb*
11. **LBU** - *lbu    x3, 1(x1)*
12. **LI** - *li    x1, 0xff*
13. **LUI** - *lui    x1, 0xFFFFF*
14. **ORI** - *ori    x1, x0, 0x673*
15. **SLTI** - *slti    x2, x1, 4*
16. **SLTIU** - *sltiu    x2, x1, -2048*
17. **SW** - *sw    x1, 0x20, x8*
