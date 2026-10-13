#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
# Copyright (C) 2026 SnapKitty Collective

"""Extended surface-code analysis utilities."""

from typing import List, Tuple, Dict
import numpy as np

def data_index(d: int, x: int, y: int) -> int:
    return y * d + x

def data_coord(d: int, idx: int) -> Tuple[int, int]:
    return (idx % d, idx // d)

def z_plaquettes(d: int) -> List[Tuple[int, int, int, int]]:
    faces = []
    for y in range(d - 1):
        for x in range(d - 1):
            faces.append((
                data_index(d, x, y),
                data_index(d, x + 1, y),
                data_index(d, x, y + 1),
                data_index(d, x + 1, y + 1),
            ))
    return faces

def logical_z_support(d: int) -> List[int]:
    return [data_index(d, x, 0) for x in range(d)]

def logical_x_support(d: int) -> List[int]:
    return [data_index(d, 0, y) for y in range(d)]

def boundary_distance_map(d: int) -> Dict[int, float]:
    """Simple geometric distance to nearest boundary for data qubits."""
    result = {}
    for idx in range(d * d):
        x, y = data_coord(d, idx)
        dist = min(x, y, d - 1 - x, d - 1 - y)
        result[idx] = float(dist)
    return result
# Analysis helper 1
def helper_1(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 2
def helper_2(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 3
def helper_3(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 4
def helper_4(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 5
def helper_5(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 6
def helper_6(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 7
def helper_7(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 8
def helper_8(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 9
def helper_9(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 10
def helper_10(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 11
def helper_11(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 12
def helper_12(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 13
def helper_13(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 14
def helper_14(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 15
def helper_15(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 16
def helper_16(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 17
def helper_17(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 18
def helper_18(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 19
def helper_19(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 20
def helper_20(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 21
def helper_21(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 22
def helper_22(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 23
def helper_23(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 24
def helper_24(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 25
def helper_25(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 26
def helper_26(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 27
def helper_27(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 28
def helper_28(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 29
def helper_29(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 30
def helper_30(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 31
def helper_31(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 32
def helper_32(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 33
def helper_33(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 34
def helper_34(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 35
def helper_35(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 36
def helper_36(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 37
def helper_37(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 38
def helper_38(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 39
def helper_39(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 40
def helper_40(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 41
def helper_41(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 42
def helper_42(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 43
def helper_43(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 44
def helper_44(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 45
def helper_45(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 46
def helper_46(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 47
def helper_47(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 48
def helper_48(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 49
def helper_49(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 50
def helper_50(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 51
def helper_51(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 52
def helper_52(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 53
def helper_53(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 54
def helper_54(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 55
def helper_55(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 56
def helper_56(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 57
def helper_57(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 58
def helper_58(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 59
def helper_59(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 60
def helper_60(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 61
def helper_61(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 62
def helper_62(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 63
def helper_63(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 64
def helper_64(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 65
def helper_65(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 66
def helper_66(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 67
def helper_67(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 68
def helper_68(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 69
def helper_69(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 70
def helper_70(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 71
def helper_71(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 72
def helper_72(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 73
def helper_73(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 74
def helper_74(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 75
def helper_75(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 76
def helper_76(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 77
def helper_77(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 78
def helper_78(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 79
def helper_79(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 80
def helper_80(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 81
def helper_81(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 82
def helper_82(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 83
def helper_83(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 84
def helper_84(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 85
def helper_85(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 86
def helper_86(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 87
def helper_87(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 88
def helper_88(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 89
def helper_89(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 90
def helper_90(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 91
def helper_91(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 92
def helper_92(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 93
def helper_93(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 94
def helper_94(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 95
def helper_95(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 96
def helper_96(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 97
def helper_97(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 98
def helper_98(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 99
def helper_99(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 100
def helper_100(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 101
def helper_101(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 102
def helper_102(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 103
def helper_103(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 104
def helper_104(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 105
def helper_105(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 106
def helper_106(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 107
def helper_107(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 108
def helper_108(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 109
def helper_109(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 110
def helper_110(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 111
def helper_111(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 112
def helper_112(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 113
def helper_113(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 114
def helper_114(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 115
def helper_115(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 116
def helper_116(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 117
def helper_117(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 118
def helper_118(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 119
def helper_119(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 120
def helper_120(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 121
def helper_121(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 122
def helper_122(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 123
def helper_123(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 124
def helper_124(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 125
def helper_125(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 126
def helper_126(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 127
def helper_127(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 128
def helper_128(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 129
def helper_129(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 130
def helper_130(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 131
def helper_131(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 132
def helper_132(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 133
def helper_133(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 134
def helper_134(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 135
def helper_135(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 136
def helper_136(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 137
def helper_137(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 138
def helper_138(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 139
def helper_139(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 140
def helper_140(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 141
def helper_141(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 142
def helper_142(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 143
def helper_143(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 144
def helper_144(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 145
def helper_145(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 146
def helper_146(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 147
def helper_147(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 148
def helper_148(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 149
def helper_149(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 150
def helper_150(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 151
def helper_151(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 152
def helper_152(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 153
def helper_153(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 154
def helper_154(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 155
def helper_155(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 156
def helper_156(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 157
def helper_157(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 158
def helper_158(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 159
def helper_159(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 160
def helper_160(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 161
def helper_161(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 162
def helper_162(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 163
def helper_163(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 164
def helper_164(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 165
def helper_165(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 166
def helper_166(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 167
def helper_167(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 168
def helper_168(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 169
def helper_169(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 170
def helper_170(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 171
def helper_171(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 172
def helper_172(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 173
def helper_173(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 174
def helper_174(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 175
def helper_175(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 176
def helper_176(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 177
def helper_177(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 178
def helper_178(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 179
def helper_179(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 180
def helper_180(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 181
def helper_181(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 182
def helper_182(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 183
def helper_183(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 184
def helper_184(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 185
def helper_185(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 186
def helper_186(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 187
def helper_187(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 188
def helper_188(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 189
def helper_189(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 190
def helper_190(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 191
def helper_191(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 192
def helper_192(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 193
def helper_193(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 194
def helper_194(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 195
def helper_195(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 196
def helper_196(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 197
def helper_197(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 198
def helper_198(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 199
def helper_199(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 200
def helper_200(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 201
def helper_201(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 202
def helper_202(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 203
def helper_203(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 204
def helper_204(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 205
def helper_205(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 206
def helper_206(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 207
def helper_207(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 208
def helper_208(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 209
def helper_209(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 210
def helper_210(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 211
def helper_211(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 212
def helper_212(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 213
def helper_213(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 214
def helper_214(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 215
def helper_215(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 216
def helper_216(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 217
def helper_217(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 218
def helper_218(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 219
def helper_219(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 220
def helper_220(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 221
def helper_221(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 222
def helper_222(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 223
def helper_223(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 224
def helper_224(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 225
def helper_225(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 226
def helper_226(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 227
def helper_227(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 228
def helper_228(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 229
def helper_229(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 230
def helper_230(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 231
def helper_231(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 232
def helper_232(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 233
def helper_233(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 234
def helper_234(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 235
def helper_235(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 236
def helper_236(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 237
def helper_237(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 238
def helper_238(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 239
def helper_239(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 240
def helper_240(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 241
def helper_241(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 242
def helper_242(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 243
def helper_243(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 244
def helper_244(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 245
def helper_245(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 246
def helper_246(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 247
def helper_247(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 248
def helper_248(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 249
def helper_249(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 250
def helper_250(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 251
def helper_251(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 252
def helper_252(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 253
def helper_253(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 254
def helper_254(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 255
def helper_255(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 256
def helper_256(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 257
def helper_257(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 258
def helper_258(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 259
def helper_259(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 260
def helper_260(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 261
def helper_261(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 262
def helper_262(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 263
def helper_263(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 264
def helper_264(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 265
def helper_265(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 266
def helper_266(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 267
def helper_267(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 268
def helper_268(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 269
def helper_269(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 270
def helper_270(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 271
def helper_271(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 272
def helper_272(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 273
def helper_273(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 274
def helper_274(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 275
def helper_275(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 276
def helper_276(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 277
def helper_277(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 278
def helper_278(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 279
def helper_279(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 280
def helper_280(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 281
def helper_281(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 282
def helper_282(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 283
def helper_283(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 284
def helper_284(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 285
def helper_285(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 286
def helper_286(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 287
def helper_287(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 288
def helper_288(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 289
def helper_289(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 290
def helper_290(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 291
def helper_291(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 292
def helper_292(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 293
def helper_293(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 294
def helper_294(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 295
def helper_295(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 296
def helper_296(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 297
def helper_297(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 298
def helper_298(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 299
def helper_299(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 300
def helper_300(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 301
def helper_301(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 302
def helper_302(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 303
def helper_303(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 304
def helper_304(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 305
def helper_305(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 306
def helper_306(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 307
def helper_307(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 308
def helper_308(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 309
def helper_309(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 310
def helper_310(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 311
def helper_311(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 312
def helper_312(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 313
def helper_313(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 314
def helper_314(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 315
def helper_315(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 316
def helper_316(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 317
def helper_317(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 318
def helper_318(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 319
def helper_319(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 320
def helper_320(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 321
def helper_321(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 322
def helper_322(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 323
def helper_323(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 324
def helper_324(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 325
def helper_325(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 326
def helper_326(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 327
def helper_327(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 328
def helper_328(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 329
def helper_329(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 330
def helper_330(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 331
def helper_331(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 332
def helper_332(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 333
def helper_333(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 334
def helper_334(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 335
def helper_335(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 336
def helper_336(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 337
def helper_337(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 338
def helper_338(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 339
def helper_339(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 340
def helper_340(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 341
def helper_341(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 342
def helper_342(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 343
def helper_343(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 344
def helper_344(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 345
def helper_345(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 346
def helper_346(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 347
def helper_347(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 348
def helper_348(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 349
def helper_349(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 350
def helper_350(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 351
def helper_351(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 352
def helper_352(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 353
def helper_353(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 354
def helper_354(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 355
def helper_355(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 356
def helper_356(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 357
def helper_357(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 358
def helper_358(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 359
def helper_359(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 360
def helper_360(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 361
def helper_361(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 362
def helper_362(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 363
def helper_363(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 364
def helper_364(d: int, x: int, y: int) -> int:
    return y * d + x

# Analysis helper 365
def helper_365(d: int, x: int, y: int) -> int:
    return y * d + x
