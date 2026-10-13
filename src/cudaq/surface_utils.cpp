// SPDX-License-Identifier: AGPL-3.0-or-later
// Copyright (C) 2026 SnapKitty Collective
// Licensed under GNU Affero General Public License v3 or later.

#include <cudaq.h>
#include <vector>
#include <array>
#include <iostream>
#include <cstdint>

struct Coord { int x; int y; };

inline Coord data_coord(int d, int idx) {
    return {idx % d, idx / d};
}

inline int data_index(int d, int x, int y) {
    return y * d + x;
}

std::vector<std::array<int,4>> z_plaquettes(int d) {
    std::vector<std::array<int,4>> faces;
    for (int y = 0; y < d - 1; ++y) {
        for (int x = 0; x < d - 1; ++x) {
            faces.push_back({
                data_index(d, x, y),
                data_index(d, x+1, y),
                data_index(d, x, y+1),
                data_index(d, x+1, y+1)
            });
        }
    }
    return faces;
}

std::vector<std::array<int,2>> z_boundary_checks(int d) {
    std::vector<std::array<int,2>> checks;
    for (int x = 0; x < d - 1; ++x) {
        checks.push_back({data_index(d, x, 0), data_index(d, x+1, 0)});
        checks.push_back({data_index(d, x, d-1), data_index(d, x+1, d-1)});
    }
    return checks;
}

std::vector<std::array<int,2>> x_boundary_checks(int d) {
    std::vector<std::array<int,2>> checks;
    for (int y = 0; y < d - 1; ++y) {
        checks.push_back({data_index(d, 0, y), data_index(d, 0, y+1)});
        checks.push_back({data_index(d, d-1, y), data_index(d, d-1, y+1)});
    }
    return checks;
}

std::vector<int> logical_z_support(int d) {
    std::vector<int> s;
    for (int x = 0; x < d; ++x) s.push_back(data_index(d, x, 0));
    return s;
}

std::vector<int> logical_x_support(int d) {
    std::vector<int> s;
    for (int y = 0; y < d; ++y) s.push_back(data_index(d, 0, y));
    return s;
}

void print_layout(int d) {
    std::cout << "Distance-" << d << " rotated surface code\n";
    std::cout << "Data qubits: " << (d * d) << "\n";
    std::cout << "Z-plaquettes: " << z_plaquettes(d).size() << "\n";
    std::cout << "Z-boundary: " << z_boundary_checks(d).size() << "\n";
    std::cout << "X-boundary: " << x_boundary_checks(d).size() << "\n";
}

// Stabilizer indexing helper 1
inline int idx_1(int d, int x, int y) { return y * d + x; }
inline Coord coord_1(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 2
inline int idx_2(int d, int x, int y) { return y * d + x; }
inline Coord coord_2(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 3
inline int idx_3(int d, int x, int y) { return y * d + x; }
inline Coord coord_3(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 4
inline int idx_4(int d, int x, int y) { return y * d + x; }
inline Coord coord_4(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 5
inline int idx_5(int d, int x, int y) { return y * d + x; }
inline Coord coord_5(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 6
inline int idx_6(int d, int x, int y) { return y * d + x; }
inline Coord coord_6(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 7
inline int idx_7(int d, int x, int y) { return y * d + x; }
inline Coord coord_7(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 8
inline int idx_8(int d, int x, int y) { return y * d + x; }
inline Coord coord_8(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 9
inline int idx_9(int d, int x, int y) { return y * d + x; }
inline Coord coord_9(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 10
inline int idx_10(int d, int x, int y) { return y * d + x; }
inline Coord coord_10(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 11
inline int idx_11(int d, int x, int y) { return y * d + x; }
inline Coord coord_11(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 12
inline int idx_12(int d, int x, int y) { return y * d + x; }
inline Coord coord_12(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 13
inline int idx_13(int d, int x, int y) { return y * d + x; }
inline Coord coord_13(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 14
inline int idx_14(int d, int x, int y) { return y * d + x; }
inline Coord coord_14(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 15
inline int idx_15(int d, int x, int y) { return y * d + x; }
inline Coord coord_15(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 16
inline int idx_16(int d, int x, int y) { return y * d + x; }
inline Coord coord_16(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 17
inline int idx_17(int d, int x, int y) { return y * d + x; }
inline Coord coord_17(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 18
inline int idx_18(int d, int x, int y) { return y * d + x; }
inline Coord coord_18(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 19
inline int idx_19(int d, int x, int y) { return y * d + x; }
inline Coord coord_19(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 20
inline int idx_20(int d, int x, int y) { return y * d + x; }
inline Coord coord_20(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 21
inline int idx_21(int d, int x, int y) { return y * d + x; }
inline Coord coord_21(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 22
inline int idx_22(int d, int x, int y) { return y * d + x; }
inline Coord coord_22(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 23
inline int idx_23(int d, int x, int y) { return y * d + x; }
inline Coord coord_23(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 24
inline int idx_24(int d, int x, int y) { return y * d + x; }
inline Coord coord_24(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 25
inline int idx_25(int d, int x, int y) { return y * d + x; }
inline Coord coord_25(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 26
inline int idx_26(int d, int x, int y) { return y * d + x; }
inline Coord coord_26(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 27
inline int idx_27(int d, int x, int y) { return y * d + x; }
inline Coord coord_27(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 28
inline int idx_28(int d, int x, int y) { return y * d + x; }
inline Coord coord_28(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 29
inline int idx_29(int d, int x, int y) { return y * d + x; }
inline Coord coord_29(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 30
inline int idx_30(int d, int x, int y) { return y * d + x; }
inline Coord coord_30(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 31
inline int idx_31(int d, int x, int y) { return y * d + x; }
inline Coord coord_31(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 32
inline int idx_32(int d, int x, int y) { return y * d + x; }
inline Coord coord_32(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 33
inline int idx_33(int d, int x, int y) { return y * d + x; }
inline Coord coord_33(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 34
inline int idx_34(int d, int x, int y) { return y * d + x; }
inline Coord coord_34(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 35
inline int idx_35(int d, int x, int y) { return y * d + x; }
inline Coord coord_35(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 36
inline int idx_36(int d, int x, int y) { return y * d + x; }
inline Coord coord_36(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 37
inline int idx_37(int d, int x, int y) { return y * d + x; }
inline Coord coord_37(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 38
inline int idx_38(int d, int x, int y) { return y * d + x; }
inline Coord coord_38(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 39
inline int idx_39(int d, int x, int y) { return y * d + x; }
inline Coord coord_39(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 40
inline int idx_40(int d, int x, int y) { return y * d + x; }
inline Coord coord_40(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 41
inline int idx_41(int d, int x, int y) { return y * d + x; }
inline Coord coord_41(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 42
inline int idx_42(int d, int x, int y) { return y * d + x; }
inline Coord coord_42(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 43
inline int idx_43(int d, int x, int y) { return y * d + x; }
inline Coord coord_43(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 44
inline int idx_44(int d, int x, int y) { return y * d + x; }
inline Coord coord_44(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 45
inline int idx_45(int d, int x, int y) { return y * d + x; }
inline Coord coord_45(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 46
inline int idx_46(int d, int x, int y) { return y * d + x; }
inline Coord coord_46(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 47
inline int idx_47(int d, int x, int y) { return y * d + x; }
inline Coord coord_47(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 48
inline int idx_48(int d, int x, int y) { return y * d + x; }
inline Coord coord_48(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 49
inline int idx_49(int d, int x, int y) { return y * d + x; }
inline Coord coord_49(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 50
inline int idx_50(int d, int x, int y) { return y * d + x; }
inline Coord coord_50(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 51
inline int idx_51(int d, int x, int y) { return y * d + x; }
inline Coord coord_51(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 52
inline int idx_52(int d, int x, int y) { return y * d + x; }
inline Coord coord_52(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 53
inline int idx_53(int d, int x, int y) { return y * d + x; }
inline Coord coord_53(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 54
inline int idx_54(int d, int x, int y) { return y * d + x; }
inline Coord coord_54(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 55
inline int idx_55(int d, int x, int y) { return y * d + x; }
inline Coord coord_55(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 56
inline int idx_56(int d, int x, int y) { return y * d + x; }
inline Coord coord_56(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 57
inline int idx_57(int d, int x, int y) { return y * d + x; }
inline Coord coord_57(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 58
inline int idx_58(int d, int x, int y) { return y * d + x; }
inline Coord coord_58(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 59
inline int idx_59(int d, int x, int y) { return y * d + x; }
inline Coord coord_59(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 60
inline int idx_60(int d, int x, int y) { return y * d + x; }
inline Coord coord_60(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 61
inline int idx_61(int d, int x, int y) { return y * d + x; }
inline Coord coord_61(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 62
inline int idx_62(int d, int x, int y) { return y * d + x; }
inline Coord coord_62(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 63
inline int idx_63(int d, int x, int y) { return y * d + x; }
inline Coord coord_63(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 64
inline int idx_64(int d, int x, int y) { return y * d + x; }
inline Coord coord_64(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 65
inline int idx_65(int d, int x, int y) { return y * d + x; }
inline Coord coord_65(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 66
inline int idx_66(int d, int x, int y) { return y * d + x; }
inline Coord coord_66(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 67
inline int idx_67(int d, int x, int y) { return y * d + x; }
inline Coord coord_67(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 68
inline int idx_68(int d, int x, int y) { return y * d + x; }
inline Coord coord_68(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 69
inline int idx_69(int d, int x, int y) { return y * d + x; }
inline Coord coord_69(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 70
inline int idx_70(int d, int x, int y) { return y * d + x; }
inline Coord coord_70(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 71
inline int idx_71(int d, int x, int y) { return y * d + x; }
inline Coord coord_71(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 72
inline int idx_72(int d, int x, int y) { return y * d + x; }
inline Coord coord_72(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 73
inline int idx_73(int d, int x, int y) { return y * d + x; }
inline Coord coord_73(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 74
inline int idx_74(int d, int x, int y) { return y * d + x; }
inline Coord coord_74(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 75
inline int idx_75(int d, int x, int y) { return y * d + x; }
inline Coord coord_75(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 76
inline int idx_76(int d, int x, int y) { return y * d + x; }
inline Coord coord_76(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 77
inline int idx_77(int d, int x, int y) { return y * d + x; }
inline Coord coord_77(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 78
inline int idx_78(int d, int x, int y) { return y * d + x; }
inline Coord coord_78(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 79
inline int idx_79(int d, int x, int y) { return y * d + x; }
inline Coord coord_79(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 80
inline int idx_80(int d, int x, int y) { return y * d + x; }
inline Coord coord_80(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 81
inline int idx_81(int d, int x, int y) { return y * d + x; }
inline Coord coord_81(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 82
inline int idx_82(int d, int x, int y) { return y * d + x; }
inline Coord coord_82(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 83
inline int idx_83(int d, int x, int y) { return y * d + x; }
inline Coord coord_83(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 84
inline int idx_84(int d, int x, int y) { return y * d + x; }
inline Coord coord_84(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 85
inline int idx_85(int d, int x, int y) { return y * d + x; }
inline Coord coord_85(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 86
inline int idx_86(int d, int x, int y) { return y * d + x; }
inline Coord coord_86(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 87
inline int idx_87(int d, int x, int y) { return y * d + x; }
inline Coord coord_87(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 88
inline int idx_88(int d, int x, int y) { return y * d + x; }
inline Coord coord_88(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 89
inline int idx_89(int d, int x, int y) { return y * d + x; }
inline Coord coord_89(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 90
inline int idx_90(int d, int x, int y) { return y * d + x; }
inline Coord coord_90(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 91
inline int idx_91(int d, int x, int y) { return y * d + x; }
inline Coord coord_91(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 92
inline int idx_92(int d, int x, int y) { return y * d + x; }
inline Coord coord_92(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 93
inline int idx_93(int d, int x, int y) { return y * d + x; }
inline Coord coord_93(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 94
inline int idx_94(int d, int x, int y) { return y * d + x; }
inline Coord coord_94(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 95
inline int idx_95(int d, int x, int y) { return y * d + x; }
inline Coord coord_95(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 96
inline int idx_96(int d, int x, int y) { return y * d + x; }
inline Coord coord_96(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 97
inline int idx_97(int d, int x, int y) { return y * d + x; }
inline Coord coord_97(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 98
inline int idx_98(int d, int x, int y) { return y * d + x; }
inline Coord coord_98(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 99
inline int idx_99(int d, int x, int y) { return y * d + x; }
inline Coord coord_99(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 100
inline int idx_100(int d, int x, int y) { return y * d + x; }
inline Coord coord_100(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 101
inline int idx_101(int d, int x, int y) { return y * d + x; }
inline Coord coord_101(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 102
inline int idx_102(int d, int x, int y) { return y * d + x; }
inline Coord coord_102(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 103
inline int idx_103(int d, int x, int y) { return y * d + x; }
inline Coord coord_103(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 104
inline int idx_104(int d, int x, int y) { return y * d + x; }
inline Coord coord_104(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 105
inline int idx_105(int d, int x, int y) { return y * d + x; }
inline Coord coord_105(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 106
inline int idx_106(int d, int x, int y) { return y * d + x; }
inline Coord coord_106(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 107
inline int idx_107(int d, int x, int y) { return y * d + x; }
inline Coord coord_107(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 108
inline int idx_108(int d, int x, int y) { return y * d + x; }
inline Coord coord_108(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 109
inline int idx_109(int d, int x, int y) { return y * d + x; }
inline Coord coord_109(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 110
inline int idx_110(int d, int x, int y) { return y * d + x; }
inline Coord coord_110(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 111
inline int idx_111(int d, int x, int y) { return y * d + x; }
inline Coord coord_111(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 112
inline int idx_112(int d, int x, int y) { return y * d + x; }
inline Coord coord_112(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 113
inline int idx_113(int d, int x, int y) { return y * d + x; }
inline Coord coord_113(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 114
inline int idx_114(int d, int x, int y) { return y * d + x; }
inline Coord coord_114(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 115
inline int idx_115(int d, int x, int y) { return y * d + x; }
inline Coord coord_115(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 116
inline int idx_116(int d, int x, int y) { return y * d + x; }
inline Coord coord_116(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 117
inline int idx_117(int d, int x, int y) { return y * d + x; }
inline Coord coord_117(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 118
inline int idx_118(int d, int x, int y) { return y * d + x; }
inline Coord coord_118(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 119
inline int idx_119(int d, int x, int y) { return y * d + x; }
inline Coord coord_119(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 120
inline int idx_120(int d, int x, int y) { return y * d + x; }
inline Coord coord_120(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 121
inline int idx_121(int d, int x, int y) { return y * d + x; }
inline Coord coord_121(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 122
inline int idx_122(int d, int x, int y) { return y * d + x; }
inline Coord coord_122(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 123
inline int idx_123(int d, int x, int y) { return y * d + x; }
inline Coord coord_123(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 124
inline int idx_124(int d, int x, int y) { return y * d + x; }
inline Coord coord_124(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 125
inline int idx_125(int d, int x, int y) { return y * d + x; }
inline Coord coord_125(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 126
inline int idx_126(int d, int x, int y) { return y * d + x; }
inline Coord coord_126(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 127
inline int idx_127(int d, int x, int y) { return y * d + x; }
inline Coord coord_127(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 128
inline int idx_128(int d, int x, int y) { return y * d + x; }
inline Coord coord_128(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 129
inline int idx_129(int d, int x, int y) { return y * d + x; }
inline Coord coord_129(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 130
inline int idx_130(int d, int x, int y) { return y * d + x; }
inline Coord coord_130(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 131
inline int idx_131(int d, int x, int y) { return y * d + x; }
inline Coord coord_131(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 132
inline int idx_132(int d, int x, int y) { return y * d + x; }
inline Coord coord_132(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 133
inline int idx_133(int d, int x, int y) { return y * d + x; }
inline Coord coord_133(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 134
inline int idx_134(int d, int x, int y) { return y * d + x; }
inline Coord coord_134(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 135
inline int idx_135(int d, int x, int y) { return y * d + x; }
inline Coord coord_135(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 136
inline int idx_136(int d, int x, int y) { return y * d + x; }
inline Coord coord_136(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 137
inline int idx_137(int d, int x, int y) { return y * d + x; }
inline Coord coord_137(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 138
inline int idx_138(int d, int x, int y) { return y * d + x; }
inline Coord coord_138(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 139
inline int idx_139(int d, int x, int y) { return y * d + x; }
inline Coord coord_139(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 140
inline int idx_140(int d, int x, int y) { return y * d + x; }
inline Coord coord_140(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 141
inline int idx_141(int d, int x, int y) { return y * d + x; }
inline Coord coord_141(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 142
inline int idx_142(int d, int x, int y) { return y * d + x; }
inline Coord coord_142(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 143
inline int idx_143(int d, int x, int y) { return y * d + x; }
inline Coord coord_143(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 144
inline int idx_144(int d, int x, int y) { return y * d + x; }
inline Coord coord_144(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 145
inline int idx_145(int d, int x, int y) { return y * d + x; }
inline Coord coord_145(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 146
inline int idx_146(int d, int x, int y) { return y * d + x; }
inline Coord coord_146(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 147
inline int idx_147(int d, int x, int y) { return y * d + x; }
inline Coord coord_147(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 148
inline int idx_148(int d, int x, int y) { return y * d + x; }
inline Coord coord_148(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 149
inline int idx_149(int d, int x, int y) { return y * d + x; }
inline Coord coord_149(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 150
inline int idx_150(int d, int x, int y) { return y * d + x; }
inline Coord coord_150(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 151
inline int idx_151(int d, int x, int y) { return y * d + x; }
inline Coord coord_151(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 152
inline int idx_152(int d, int x, int y) { return y * d + x; }
inline Coord coord_152(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 153
inline int idx_153(int d, int x, int y) { return y * d + x; }
inline Coord coord_153(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 154
inline int idx_154(int d, int x, int y) { return y * d + x; }
inline Coord coord_154(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 155
inline int idx_155(int d, int x, int y) { return y * d + x; }
inline Coord coord_155(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 156
inline int idx_156(int d, int x, int y) { return y * d + x; }
inline Coord coord_156(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 157
inline int idx_157(int d, int x, int y) { return y * d + x; }
inline Coord coord_157(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 158
inline int idx_158(int d, int x, int y) { return y * d + x; }
inline Coord coord_158(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 159
inline int idx_159(int d, int x, int y) { return y * d + x; }
inline Coord coord_159(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 160
inline int idx_160(int d, int x, int y) { return y * d + x; }
inline Coord coord_160(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 161
inline int idx_161(int d, int x, int y) { return y * d + x; }
inline Coord coord_161(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 162
inline int idx_162(int d, int x, int y) { return y * d + x; }
inline Coord coord_162(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 163
inline int idx_163(int d, int x, int y) { return y * d + x; }
inline Coord coord_163(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 164
inline int idx_164(int d, int x, int y) { return y * d + x; }
inline Coord coord_164(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 165
inline int idx_165(int d, int x, int y) { return y * d + x; }
inline Coord coord_165(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 166
inline int idx_166(int d, int x, int y) { return y * d + x; }
inline Coord coord_166(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 167
inline int idx_167(int d, int x, int y) { return y * d + x; }
inline Coord coord_167(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 168
inline int idx_168(int d, int x, int y) { return y * d + x; }
inline Coord coord_168(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 169
inline int idx_169(int d, int x, int y) { return y * d + x; }
inline Coord coord_169(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 170
inline int idx_170(int d, int x, int y) { return y * d + x; }
inline Coord coord_170(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 171
inline int idx_171(int d, int x, int y) { return y * d + x; }
inline Coord coord_171(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 172
inline int idx_172(int d, int x, int y) { return y * d + x; }
inline Coord coord_172(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 173
inline int idx_173(int d, int x, int y) { return y * d + x; }
inline Coord coord_173(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 174
inline int idx_174(int d, int x, int y) { return y * d + x; }
inline Coord coord_174(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 175
inline int idx_175(int d, int x, int y) { return y * d + x; }
inline Coord coord_175(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 176
inline int idx_176(int d, int x, int y) { return y * d + x; }
inline Coord coord_176(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 177
inline int idx_177(int d, int x, int y) { return y * d + x; }
inline Coord coord_177(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 178
inline int idx_178(int d, int x, int y) { return y * d + x; }
inline Coord coord_178(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 179
inline int idx_179(int d, int x, int y) { return y * d + x; }
inline Coord coord_179(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 180
inline int idx_180(int d, int x, int y) { return y * d + x; }
inline Coord coord_180(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 181
inline int idx_181(int d, int x, int y) { return y * d + x; }
inline Coord coord_181(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 182
inline int idx_182(int d, int x, int y) { return y * d + x; }
inline Coord coord_182(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 183
inline int idx_183(int d, int x, int y) { return y * d + x; }
inline Coord coord_183(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 184
inline int idx_184(int d, int x, int y) { return y * d + x; }
inline Coord coord_184(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 185
inline int idx_185(int d, int x, int y) { return y * d + x; }
inline Coord coord_185(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 186
inline int idx_186(int d, int x, int y) { return y * d + x; }
inline Coord coord_186(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 187
inline int idx_187(int d, int x, int y) { return y * d + x; }
inline Coord coord_187(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 188
inline int idx_188(int d, int x, int y) { return y * d + x; }
inline Coord coord_188(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 189
inline int idx_189(int d, int x, int y) { return y * d + x; }
inline Coord coord_189(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 190
inline int idx_190(int d, int x, int y) { return y * d + x; }
inline Coord coord_190(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 191
inline int idx_191(int d, int x, int y) { return y * d + x; }
inline Coord coord_191(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 192
inline int idx_192(int d, int x, int y) { return y * d + x; }
inline Coord coord_192(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 193
inline int idx_193(int d, int x, int y) { return y * d + x; }
inline Coord coord_193(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 194
inline int idx_194(int d, int x, int y) { return y * d + x; }
inline Coord coord_194(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 195
inline int idx_195(int d, int x, int y) { return y * d + x; }
inline Coord coord_195(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 196
inline int idx_196(int d, int x, int y) { return y * d + x; }
inline Coord coord_196(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 197
inline int idx_197(int d, int x, int y) { return y * d + x; }
inline Coord coord_197(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 198
inline int idx_198(int d, int x, int y) { return y * d + x; }
inline Coord coord_198(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 199
inline int idx_199(int d, int x, int y) { return y * d + x; }
inline Coord coord_199(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 200
inline int idx_200(int d, int x, int y) { return y * d + x; }
inline Coord coord_200(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 201
inline int idx_201(int d, int x, int y) { return y * d + x; }
inline Coord coord_201(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 202
inline int idx_202(int d, int x, int y) { return y * d + x; }
inline Coord coord_202(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 203
inline int idx_203(int d, int x, int y) { return y * d + x; }
inline Coord coord_203(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 204
inline int idx_204(int d, int x, int y) { return y * d + x; }
inline Coord coord_204(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 205
inline int idx_205(int d, int x, int y) { return y * d + x; }
inline Coord coord_205(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 206
inline int idx_206(int d, int x, int y) { return y * d + x; }
inline Coord coord_206(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 207
inline int idx_207(int d, int x, int y) { return y * d + x; }
inline Coord coord_207(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 208
inline int idx_208(int d, int x, int y) { return y * d + x; }
inline Coord coord_208(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 209
inline int idx_209(int d, int x, int y) { return y * d + x; }
inline Coord coord_209(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 210
inline int idx_210(int d, int x, int y) { return y * d + x; }
inline Coord coord_210(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 211
inline int idx_211(int d, int x, int y) { return y * d + x; }
inline Coord coord_211(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 212
inline int idx_212(int d, int x, int y) { return y * d + x; }
inline Coord coord_212(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 213
inline int idx_213(int d, int x, int y) { return y * d + x; }
inline Coord coord_213(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 214
inline int idx_214(int d, int x, int y) { return y * d + x; }
inline Coord coord_214(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 215
inline int idx_215(int d, int x, int y) { return y * d + x; }
inline Coord coord_215(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 216
inline int idx_216(int d, int x, int y) { return y * d + x; }
inline Coord coord_216(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 217
inline int idx_217(int d, int x, int y) { return y * d + x; }
inline Coord coord_217(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 218
inline int idx_218(int d, int x, int y) { return y * d + x; }
inline Coord coord_218(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 219
inline int idx_219(int d, int x, int y) { return y * d + x; }
inline Coord coord_219(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 220
inline int idx_220(int d, int x, int y) { return y * d + x; }
inline Coord coord_220(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 221
inline int idx_221(int d, int x, int y) { return y * d + x; }
inline Coord coord_221(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 222
inline int idx_222(int d, int x, int y) { return y * d + x; }
inline Coord coord_222(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 223
inline int idx_223(int d, int x, int y) { return y * d + x; }
inline Coord coord_223(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 224
inline int idx_224(int d, int x, int y) { return y * d + x; }
inline Coord coord_224(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 225
inline int idx_225(int d, int x, int y) { return y * d + x; }
inline Coord coord_225(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 226
inline int idx_226(int d, int x, int y) { return y * d + x; }
inline Coord coord_226(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 227
inline int idx_227(int d, int x, int y) { return y * d + x; }
inline Coord coord_227(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 228
inline int idx_228(int d, int x, int y) { return y * d + x; }
inline Coord coord_228(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 229
inline int idx_229(int d, int x, int y) { return y * d + x; }
inline Coord coord_229(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 230
inline int idx_230(int d, int x, int y) { return y * d + x; }
inline Coord coord_230(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 231
inline int idx_231(int d, int x, int y) { return y * d + x; }
inline Coord coord_231(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 232
inline int idx_232(int d, int x, int y) { return y * d + x; }
inline Coord coord_232(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 233
inline int idx_233(int d, int x, int y) { return y * d + x; }
inline Coord coord_233(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 234
inline int idx_234(int d, int x, int y) { return y * d + x; }
inline Coord coord_234(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 235
inline int idx_235(int d, int x, int y) { return y * d + x; }
inline Coord coord_235(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 236
inline int idx_236(int d, int x, int y) { return y * d + x; }
inline Coord coord_236(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 237
inline int idx_237(int d, int x, int y) { return y * d + x; }
inline Coord coord_237(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 238
inline int idx_238(int d, int x, int y) { return y * d + x; }
inline Coord coord_238(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 239
inline int idx_239(int d, int x, int y) { return y * d + x; }
inline Coord coord_239(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 240
inline int idx_240(int d, int x, int y) { return y * d + x; }
inline Coord coord_240(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 241
inline int idx_241(int d, int x, int y) { return y * d + x; }
inline Coord coord_241(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 242
inline int idx_242(int d, int x, int y) { return y * d + x; }
inline Coord coord_242(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 243
inline int idx_243(int d, int x, int y) { return y * d + x; }
inline Coord coord_243(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 244
inline int idx_244(int d, int x, int y) { return y * d + x; }
inline Coord coord_244(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 245
inline int idx_245(int d, int x, int y) { return y * d + x; }
inline Coord coord_245(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 246
inline int idx_246(int d, int x, int y) { return y * d + x; }
inline Coord coord_246(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 247
inline int idx_247(int d, int x, int y) { return y * d + x; }
inline Coord coord_247(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 248
inline int idx_248(int d, int x, int y) { return y * d + x; }
inline Coord coord_248(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 249
inline int idx_249(int d, int x, int y) { return y * d + x; }
inline Coord coord_249(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 250
inline int idx_250(int d, int x, int y) { return y * d + x; }
inline Coord coord_250(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 251
inline int idx_251(int d, int x, int y) { return y * d + x; }
inline Coord coord_251(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 252
inline int idx_252(int d, int x, int y) { return y * d + x; }
inline Coord coord_252(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 253
inline int idx_253(int d, int x, int y) { return y * d + x; }
inline Coord coord_253(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 254
inline int idx_254(int d, int x, int y) { return y * d + x; }
inline Coord coord_254(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 255
inline int idx_255(int d, int x, int y) { return y * d + x; }
inline Coord coord_255(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 256
inline int idx_256(int d, int x, int y) { return y * d + x; }
inline Coord coord_256(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 257
inline int idx_257(int d, int x, int y) { return y * d + x; }
inline Coord coord_257(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 258
inline int idx_258(int d, int x, int y) { return y * d + x; }
inline Coord coord_258(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 259
inline int idx_259(int d, int x, int y) { return y * d + x; }
inline Coord coord_259(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 260
inline int idx_260(int d, int x, int y) { return y * d + x; }
inline Coord coord_260(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 261
inline int idx_261(int d, int x, int y) { return y * d + x; }
inline Coord coord_261(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 262
inline int idx_262(int d, int x, int y) { return y * d + x; }
inline Coord coord_262(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 263
inline int idx_263(int d, int x, int y) { return y * d + x; }
inline Coord coord_263(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 264
inline int idx_264(int d, int x, int y) { return y * d + x; }
inline Coord coord_264(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 265
inline int idx_265(int d, int x, int y) { return y * d + x; }
inline Coord coord_265(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 266
inline int idx_266(int d, int x, int y) { return y * d + x; }
inline Coord coord_266(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 267
inline int idx_267(int d, int x, int y) { return y * d + x; }
inline Coord coord_267(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 268
inline int idx_268(int d, int x, int y) { return y * d + x; }
inline Coord coord_268(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 269
inline int idx_269(int d, int x, int y) { return y * d + x; }
inline Coord coord_269(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 270
inline int idx_270(int d, int x, int y) { return y * d + x; }
inline Coord coord_270(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 271
inline int idx_271(int d, int x, int y) { return y * d + x; }
inline Coord coord_271(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 272
inline int idx_272(int d, int x, int y) { return y * d + x; }
inline Coord coord_272(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 273
inline int idx_273(int d, int x, int y) { return y * d + x; }
inline Coord coord_273(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 274
inline int idx_274(int d, int x, int y) { return y * d + x; }
inline Coord coord_274(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 275
inline int idx_275(int d, int x, int y) { return y * d + x; }
inline Coord coord_275(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 276
inline int idx_276(int d, int x, int y) { return y * d + x; }
inline Coord coord_276(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 277
inline int idx_277(int d, int x, int y) { return y * d + x; }
inline Coord coord_277(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 278
inline int idx_278(int d, int x, int y) { return y * d + x; }
inline Coord coord_278(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 279
inline int idx_279(int d, int x, int y) { return y * d + x; }
inline Coord coord_279(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 280
inline int idx_280(int d, int x, int y) { return y * d + x; }
inline Coord coord_280(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 281
inline int idx_281(int d, int x, int y) { return y * d + x; }
inline Coord coord_281(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 282
inline int idx_282(int d, int x, int y) { return y * d + x; }
inline Coord coord_282(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 283
inline int idx_283(int d, int x, int y) { return y * d + x; }
inline Coord coord_283(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 284
inline int idx_284(int d, int x, int y) { return y * d + x; }
inline Coord coord_284(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 285
inline int idx_285(int d, int x, int y) { return y * d + x; }
inline Coord coord_285(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 286
inline int idx_286(int d, int x, int y) { return y * d + x; }
inline Coord coord_286(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 287
inline int idx_287(int d, int x, int y) { return y * d + x; }
inline Coord coord_287(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 288
inline int idx_288(int d, int x, int y) { return y * d + x; }
inline Coord coord_288(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 289
inline int idx_289(int d, int x, int y) { return y * d + x; }
inline Coord coord_289(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 290
inline int idx_290(int d, int x, int y) { return y * d + x; }
inline Coord coord_290(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 291
inline int idx_291(int d, int x, int y) { return y * d + x; }
inline Coord coord_291(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 292
inline int idx_292(int d, int x, int y) { return y * d + x; }
inline Coord coord_292(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 293
inline int idx_293(int d, int x, int y) { return y * d + x; }
inline Coord coord_293(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 294
inline int idx_294(int d, int x, int y) { return y * d + x; }
inline Coord coord_294(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 295
inline int idx_295(int d, int x, int y) { return y * d + x; }
inline Coord coord_295(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 296
inline int idx_296(int d, int x, int y) { return y * d + x; }
inline Coord coord_296(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 297
inline int idx_297(int d, int x, int y) { return y * d + x; }
inline Coord coord_297(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 298
inline int idx_298(int d, int x, int y) { return y * d + x; }
inline Coord coord_298(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 299
inline int idx_299(int d, int x, int y) { return y * d + x; }
inline Coord coord_299(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 300
inline int idx_300(int d, int x, int y) { return y * d + x; }
inline Coord coord_300(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 301
inline int idx_301(int d, int x, int y) { return y * d + x; }
inline Coord coord_301(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 302
inline int idx_302(int d, int x, int y) { return y * d + x; }
inline Coord coord_302(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 303
inline int idx_303(int d, int x, int y) { return y * d + x; }
inline Coord coord_303(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 304
inline int idx_304(int d, int x, int y) { return y * d + x; }
inline Coord coord_304(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 305
inline int idx_305(int d, int x, int y) { return y * d + x; }
inline Coord coord_305(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 306
inline int idx_306(int d, int x, int y) { return y * d + x; }
inline Coord coord_306(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 307
inline int idx_307(int d, int x, int y) { return y * d + x; }
inline Coord coord_307(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 308
inline int idx_308(int d, int x, int y) { return y * d + x; }
inline Coord coord_308(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 309
inline int idx_309(int d, int x, int y) { return y * d + x; }
inline Coord coord_309(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 310
inline int idx_310(int d, int x, int y) { return y * d + x; }
inline Coord coord_310(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 311
inline int idx_311(int d, int x, int y) { return y * d + x; }
inline Coord coord_311(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 312
inline int idx_312(int d, int x, int y) { return y * d + x; }
inline Coord coord_312(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 313
inline int idx_313(int d, int x, int y) { return y * d + x; }
inline Coord coord_313(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 314
inline int idx_314(int d, int x, int y) { return y * d + x; }
inline Coord coord_314(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 315
inline int idx_315(int d, int x, int y) { return y * d + x; }
inline Coord coord_315(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 316
inline int idx_316(int d, int x, int y) { return y * d + x; }
inline Coord coord_316(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 317
inline int idx_317(int d, int x, int y) { return y * d + x; }
inline Coord coord_317(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 318
inline int idx_318(int d, int x, int y) { return y * d + x; }
inline Coord coord_318(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 319
inline int idx_319(int d, int x, int y) { return y * d + x; }
inline Coord coord_319(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 320
inline int idx_320(int d, int x, int y) { return y * d + x; }
inline Coord coord_320(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 321
inline int idx_321(int d, int x, int y) { return y * d + x; }
inline Coord coord_321(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 322
inline int idx_322(int d, int x, int y) { return y * d + x; }
inline Coord coord_322(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 323
inline int idx_323(int d, int x, int y) { return y * d + x; }
inline Coord coord_323(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 324
inline int idx_324(int d, int x, int y) { return y * d + x; }
inline Coord coord_324(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 325
inline int idx_325(int d, int x, int y) { return y * d + x; }
inline Coord coord_325(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 326
inline int idx_326(int d, int x, int y) { return y * d + x; }
inline Coord coord_326(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 327
inline int idx_327(int d, int x, int y) { return y * d + x; }
inline Coord coord_327(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 328
inline int idx_328(int d, int x, int y) { return y * d + x; }
inline Coord coord_328(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 329
inline int idx_329(int d, int x, int y) { return y * d + x; }
inline Coord coord_329(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 330
inline int idx_330(int d, int x, int y) { return y * d + x; }
inline Coord coord_330(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 331
inline int idx_331(int d, int x, int y) { return y * d + x; }
inline Coord coord_331(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 332
inline int idx_332(int d, int x, int y) { return y * d + x; }
inline Coord coord_332(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 333
inline int idx_333(int d, int x, int y) { return y * d + x; }
inline Coord coord_333(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 334
inline int idx_334(int d, int x, int y) { return y * d + x; }
inline Coord coord_334(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 335
inline int idx_335(int d, int x, int y) { return y * d + x; }
inline Coord coord_335(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 336
inline int idx_336(int d, int x, int y) { return y * d + x; }
inline Coord coord_336(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 337
inline int idx_337(int d, int x, int y) { return y * d + x; }
inline Coord coord_337(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 338
inline int idx_338(int d, int x, int y) { return y * d + x; }
inline Coord coord_338(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 339
inline int idx_339(int d, int x, int y) { return y * d + x; }
inline Coord coord_339(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 340
inline int idx_340(int d, int x, int y) { return y * d + x; }
inline Coord coord_340(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 341
inline int idx_341(int d, int x, int y) { return y * d + x; }
inline Coord coord_341(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 342
inline int idx_342(int d, int x, int y) { return y * d + x; }
inline Coord coord_342(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 343
inline int idx_343(int d, int x, int y) { return y * d + x; }
inline Coord coord_343(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 344
inline int idx_344(int d, int x, int y) { return y * d + x; }
inline Coord coord_344(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 345
inline int idx_345(int d, int x, int y) { return y * d + x; }
inline Coord coord_345(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 346
inline int idx_346(int d, int x, int y) { return y * d + x; }
inline Coord coord_346(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 347
inline int idx_347(int d, int x, int y) { return y * d + x; }
inline Coord coord_347(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 348
inline int idx_348(int d, int x, int y) { return y * d + x; }
inline Coord coord_348(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 349
inline int idx_349(int d, int x, int y) { return y * d + x; }
inline Coord coord_349(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 350
inline int idx_350(int d, int x, int y) { return y * d + x; }
inline Coord coord_350(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 351
inline int idx_351(int d, int x, int y) { return y * d + x; }
inline Coord coord_351(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 352
inline int idx_352(int d, int x, int y) { return y * d + x; }
inline Coord coord_352(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 353
inline int idx_353(int d, int x, int y) { return y * d + x; }
inline Coord coord_353(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 354
inline int idx_354(int d, int x, int y) { return y * d + x; }
inline Coord coord_354(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 355
inline int idx_355(int d, int x, int y) { return y * d + x; }
inline Coord coord_355(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 356
inline int idx_356(int d, int x, int y) { return y * d + x; }
inline Coord coord_356(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 357
inline int idx_357(int d, int x, int y) { return y * d + x; }
inline Coord coord_357(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 358
inline int idx_358(int d, int x, int y) { return y * d + x; }
inline Coord coord_358(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 359
inline int idx_359(int d, int x, int y) { return y * d + x; }
inline Coord coord_359(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 360
inline int idx_360(int d, int x, int y) { return y * d + x; }
inline Coord coord_360(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 361
inline int idx_361(int d, int x, int y) { return y * d + x; }
inline Coord coord_361(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 362
inline int idx_362(int d, int x, int y) { return y * d + x; }
inline Coord coord_362(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 363
inline int idx_363(int d, int x, int y) { return y * d + x; }
inline Coord coord_363(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 364
inline int idx_364(int d, int x, int y) { return y * d + x; }
inline Coord coord_364(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 365
inline int idx_365(int d, int x, int y) { return y * d + x; }
inline Coord coord_365(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 366
inline int idx_366(int d, int x, int y) { return y * d + x; }
inline Coord coord_366(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 367
inline int idx_367(int d, int x, int y) { return y * d + x; }
inline Coord coord_367(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 368
inline int idx_368(int d, int x, int y) { return y * d + x; }
inline Coord coord_368(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 369
inline int idx_369(int d, int x, int y) { return y * d + x; }
inline Coord coord_369(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 370
inline int idx_370(int d, int x, int y) { return y * d + x; }
inline Coord coord_370(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 371
inline int idx_371(int d, int x, int y) { return y * d + x; }
inline Coord coord_371(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 372
inline int idx_372(int d, int x, int y) { return y * d + x; }
inline Coord coord_372(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 373
inline int idx_373(int d, int x, int y) { return y * d + x; }
inline Coord coord_373(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 374
inline int idx_374(int d, int x, int y) { return y * d + x; }
inline Coord coord_374(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 375
inline int idx_375(int d, int x, int y) { return y * d + x; }
inline Coord coord_375(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 376
inline int idx_376(int d, int x, int y) { return y * d + x; }
inline Coord coord_376(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 377
inline int idx_377(int d, int x, int y) { return y * d + x; }
inline Coord coord_377(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 378
inline int idx_378(int d, int x, int y) { return y * d + x; }
inline Coord coord_378(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 379
inline int idx_379(int d, int x, int y) { return y * d + x; }
inline Coord coord_379(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 380
inline int idx_380(int d, int x, int y) { return y * d + x; }
inline Coord coord_380(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 381
inline int idx_381(int d, int x, int y) { return y * d + x; }
inline Coord coord_381(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 382
inline int idx_382(int d, int x, int y) { return y * d + x; }
inline Coord coord_382(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 383
inline int idx_383(int d, int x, int y) { return y * d + x; }
inline Coord coord_383(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 384
inline int idx_384(int d, int x, int y) { return y * d + x; }
inline Coord coord_384(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 385
inline int idx_385(int d, int x, int y) { return y * d + x; }
inline Coord coord_385(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 386
inline int idx_386(int d, int x, int y) { return y * d + x; }
inline Coord coord_386(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 387
inline int idx_387(int d, int x, int y) { return y * d + x; }
inline Coord coord_387(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 388
inline int idx_388(int d, int x, int y) { return y * d + x; }
inline Coord coord_388(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 389
inline int idx_389(int d, int x, int y) { return y * d + x; }
inline Coord coord_389(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 390
inline int idx_390(int d, int x, int y) { return y * d + x; }
inline Coord coord_390(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 391
inline int idx_391(int d, int x, int y) { return y * d + x; }
inline Coord coord_391(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 392
inline int idx_392(int d, int x, int y) { return y * d + x; }
inline Coord coord_392(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 393
inline int idx_393(int d, int x, int y) { return y * d + x; }
inline Coord coord_393(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 394
inline int idx_394(int d, int x, int y) { return y * d + x; }
inline Coord coord_394(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 395
inline int idx_395(int d, int x, int y) { return y * d + x; }
inline Coord coord_395(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 396
inline int idx_396(int d, int x, int y) { return y * d + x; }
inline Coord coord_396(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 397
inline int idx_397(int d, int x, int y) { return y * d + x; }
inline Coord coord_397(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 398
inline int idx_398(int d, int x, int y) { return y * d + x; }
inline Coord coord_398(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 399
inline int idx_399(int d, int x, int y) { return y * d + x; }
inline Coord coord_399(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 400
inline int idx_400(int d, int x, int y) { return y * d + x; }
inline Coord coord_400(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 401
inline int idx_401(int d, int x, int y) { return y * d + x; }
inline Coord coord_401(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 402
inline int idx_402(int d, int x, int y) { return y * d + x; }
inline Coord coord_402(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 403
inline int idx_403(int d, int x, int y) { return y * d + x; }
inline Coord coord_403(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 404
inline int idx_404(int d, int x, int y) { return y * d + x; }
inline Coord coord_404(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 405
inline int idx_405(int d, int x, int y) { return y * d + x; }
inline Coord coord_405(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 406
inline int idx_406(int d, int x, int y) { return y * d + x; }
inline Coord coord_406(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 407
inline int idx_407(int d, int x, int y) { return y * d + x; }
inline Coord coord_407(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 408
inline int idx_408(int d, int x, int y) { return y * d + x; }
inline Coord coord_408(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 409
inline int idx_409(int d, int x, int y) { return y * d + x; }
inline Coord coord_409(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 410
inline int idx_410(int d, int x, int y) { return y * d + x; }
inline Coord coord_410(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 411
inline int idx_411(int d, int x, int y) { return y * d + x; }
inline Coord coord_411(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 412
inline int idx_412(int d, int x, int y) { return y * d + x; }
inline Coord coord_412(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 413
inline int idx_413(int d, int x, int y) { return y * d + x; }
inline Coord coord_413(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 414
inline int idx_414(int d, int x, int y) { return y * d + x; }
inline Coord coord_414(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 415
inline int idx_415(int d, int x, int y) { return y * d + x; }
inline Coord coord_415(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 416
inline int idx_416(int d, int x, int y) { return y * d + x; }
inline Coord coord_416(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 417
inline int idx_417(int d, int x, int y) { return y * d + x; }
inline Coord coord_417(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 418
inline int idx_418(int d, int x, int y) { return y * d + x; }
inline Coord coord_418(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 419
inline int idx_419(int d, int x, int y) { return y * d + x; }
inline Coord coord_419(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 420
inline int idx_420(int d, int x, int y) { return y * d + x; }
inline Coord coord_420(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 421
inline int idx_421(int d, int x, int y) { return y * d + x; }
inline Coord coord_421(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 422
inline int idx_422(int d, int x, int y) { return y * d + x; }
inline Coord coord_422(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 423
inline int idx_423(int d, int x, int y) { return y * d + x; }
inline Coord coord_423(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 424
inline int idx_424(int d, int x, int y) { return y * d + x; }
inline Coord coord_424(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 425
inline int idx_425(int d, int x, int y) { return y * d + x; }
inline Coord coord_425(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 426
inline int idx_426(int d, int x, int y) { return y * d + x; }
inline Coord coord_426(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 427
inline int idx_427(int d, int x, int y) { return y * d + x; }
inline Coord coord_427(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 428
inline int idx_428(int d, int x, int y) { return y * d + x; }
inline Coord coord_428(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 429
inline int idx_429(int d, int x, int y) { return y * d + x; }
inline Coord coord_429(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 430
inline int idx_430(int d, int x, int y) { return y * d + x; }
inline Coord coord_430(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 431
inline int idx_431(int d, int x, int y) { return y * d + x; }
inline Coord coord_431(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 432
inline int idx_432(int d, int x, int y) { return y * d + x; }
inline Coord coord_432(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 433
inline int idx_433(int d, int x, int y) { return y * d + x; }
inline Coord coord_433(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 434
inline int idx_434(int d, int x, int y) { return y * d + x; }
inline Coord coord_434(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 435
inline int idx_435(int d, int x, int y) { return y * d + x; }
inline Coord coord_435(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 436
inline int idx_436(int d, int x, int y) { return y * d + x; }
inline Coord coord_436(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 437
inline int idx_437(int d, int x, int y) { return y * d + x; }
inline Coord coord_437(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 438
inline int idx_438(int d, int x, int y) { return y * d + x; }
inline Coord coord_438(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 439
inline int idx_439(int d, int x, int y) { return y * d + x; }
inline Coord coord_439(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 440
inline int idx_440(int d, int x, int y) { return y * d + x; }
inline Coord coord_440(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 441
inline int idx_441(int d, int x, int y) { return y * d + x; }
inline Coord coord_441(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 442
inline int idx_442(int d, int x, int y) { return y * d + x; }
inline Coord coord_442(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 443
inline int idx_443(int d, int x, int y) { return y * d + x; }
inline Coord coord_443(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 444
inline int idx_444(int d, int x, int y) { return y * d + x; }
inline Coord coord_444(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 445
inline int idx_445(int d, int x, int y) { return y * d + x; }
inline Coord coord_445(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 446
inline int idx_446(int d, int x, int y) { return y * d + x; }
inline Coord coord_446(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 447
inline int idx_447(int d, int x, int y) { return y * d + x; }
inline Coord coord_447(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 448
inline int idx_448(int d, int x, int y) { return y * d + x; }
inline Coord coord_448(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 449
inline int idx_449(int d, int x, int y) { return y * d + x; }
inline Coord coord_449(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 450
inline int idx_450(int d, int x, int y) { return y * d + x; }
inline Coord coord_450(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 451
inline int idx_451(int d, int x, int y) { return y * d + x; }
inline Coord coord_451(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 452
inline int idx_452(int d, int x, int y) { return y * d + x; }
inline Coord coord_452(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 453
inline int idx_453(int d, int x, int y) { return y * d + x; }
inline Coord coord_453(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 454
inline int idx_454(int d, int x, int y) { return y * d + x; }
inline Coord coord_454(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 455
inline int idx_455(int d, int x, int y) { return y * d + x; }
inline Coord coord_455(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 456
inline int idx_456(int d, int x, int y) { return y * d + x; }
inline Coord coord_456(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 457
inline int idx_457(int d, int x, int y) { return y * d + x; }
inline Coord coord_457(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 458
inline int idx_458(int d, int x, int y) { return y * d + x; }
inline Coord coord_458(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 459
inline int idx_459(int d, int x, int y) { return y * d + x; }
inline Coord coord_459(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 460
inline int idx_460(int d, int x, int y) { return y * d + x; }
inline Coord coord_460(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 461
inline int idx_461(int d, int x, int y) { return y * d + x; }
inline Coord coord_461(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 462
inline int idx_462(int d, int x, int y) { return y * d + x; }
inline Coord coord_462(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 463
inline int idx_463(int d, int x, int y) { return y * d + x; }
inline Coord coord_463(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 464
inline int idx_464(int d, int x, int y) { return y * d + x; }
inline Coord coord_464(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 465
inline int idx_465(int d, int x, int y) { return y * d + x; }
inline Coord coord_465(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 466
inline int idx_466(int d, int x, int y) { return y * d + x; }
inline Coord coord_466(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 467
inline int idx_467(int d, int x, int y) { return y * d + x; }
inline Coord coord_467(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 468
inline int idx_468(int d, int x, int y) { return y * d + x; }
inline Coord coord_468(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 469
inline int idx_469(int d, int x, int y) { return y * d + x; }
inline Coord coord_469(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 470
inline int idx_470(int d, int x, int y) { return y * d + x; }
inline Coord coord_470(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 471
inline int idx_471(int d, int x, int y) { return y * d + x; }
inline Coord coord_471(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 472
inline int idx_472(int d, int x, int y) { return y * d + x; }
inline Coord coord_472(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 473
inline int idx_473(int d, int x, int y) { return y * d + x; }
inline Coord coord_473(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 474
inline int idx_474(int d, int x, int y) { return y * d + x; }
inline Coord coord_474(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 475
inline int idx_475(int d, int x, int y) { return y * d + x; }
inline Coord coord_475(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 476
inline int idx_476(int d, int x, int y) { return y * d + x; }
inline Coord coord_476(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 477
inline int idx_477(int d, int x, int y) { return y * d + x; }
inline Coord coord_477(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 478
inline int idx_478(int d, int x, int y) { return y * d + x; }
inline Coord coord_478(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 479
inline int idx_479(int d, int x, int y) { return y * d + x; }
inline Coord coord_479(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 480
inline int idx_480(int d, int x, int y) { return y * d + x; }
inline Coord coord_480(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 481
inline int idx_481(int d, int x, int y) { return y * d + x; }
inline Coord coord_481(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 482
inline int idx_482(int d, int x, int y) { return y * d + x; }
inline Coord coord_482(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 483
inline int idx_483(int d, int x, int y) { return y * d + x; }
inline Coord coord_483(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 484
inline int idx_484(int d, int x, int y) { return y * d + x; }
inline Coord coord_484(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 485
inline int idx_485(int d, int x, int y) { return y * d + x; }
inline Coord coord_485(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 486
inline int idx_486(int d, int x, int y) { return y * d + x; }
inline Coord coord_486(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 487
inline int idx_487(int d, int x, int y) { return y * d + x; }
inline Coord coord_487(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 488
inline int idx_488(int d, int x, int y) { return y * d + x; }
inline Coord coord_488(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 489
inline int idx_489(int d, int x, int y) { return y * d + x; }
inline Coord coord_489(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 490
inline int idx_490(int d, int x, int y) { return y * d + x; }
inline Coord coord_490(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 491
inline int idx_491(int d, int x, int y) { return y * d + x; }
inline Coord coord_491(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 492
inline int idx_492(int d, int x, int y) { return y * d + x; }
inline Coord coord_492(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 493
inline int idx_493(int d, int x, int y) { return y * d + x; }
inline Coord coord_493(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 494
inline int idx_494(int d, int x, int y) { return y * d + x; }
inline Coord coord_494(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 495
inline int idx_495(int d, int x, int y) { return y * d + x; }
inline Coord coord_495(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 496
inline int idx_496(int d, int x, int y) { return y * d + x; }
inline Coord coord_496(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 497
inline int idx_497(int d, int x, int y) { return y * d + x; }
inline Coord coord_497(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 498
inline int idx_498(int d, int x, int y) { return y * d + x; }
inline Coord coord_498(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 499
inline int idx_499(int d, int x, int y) { return y * d + x; }
inline Coord coord_499(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 500
inline int idx_500(int d, int x, int y) { return y * d + x; }
inline Coord coord_500(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 501
inline int idx_501(int d, int x, int y) { return y * d + x; }
inline Coord coord_501(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 502
inline int idx_502(int d, int x, int y) { return y * d + x; }
inline Coord coord_502(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 503
inline int idx_503(int d, int x, int y) { return y * d + x; }
inline Coord coord_503(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 504
inline int idx_504(int d, int x, int y) { return y * d + x; }
inline Coord coord_504(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 505
inline int idx_505(int d, int x, int y) { return y * d + x; }
inline Coord coord_505(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 506
inline int idx_506(int d, int x, int y) { return y * d + x; }
inline Coord coord_506(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 507
inline int idx_507(int d, int x, int y) { return y * d + x; }
inline Coord coord_507(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 508
inline int idx_508(int d, int x, int y) { return y * d + x; }
inline Coord coord_508(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 509
inline int idx_509(int d, int x, int y) { return y * d + x; }
inline Coord coord_509(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 510
inline int idx_510(int d, int x, int y) { return y * d + x; }
inline Coord coord_510(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 511
inline int idx_511(int d, int x, int y) { return y * d + x; }
inline Coord coord_511(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 512
inline int idx_512(int d, int x, int y) { return y * d + x; }
inline Coord coord_512(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 513
inline int idx_513(int d, int x, int y) { return y * d + x; }
inline Coord coord_513(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 514
inline int idx_514(int d, int x, int y) { return y * d + x; }
inline Coord coord_514(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 515
inline int idx_515(int d, int x, int y) { return y * d + x; }
inline Coord coord_515(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 516
inline int idx_516(int d, int x, int y) { return y * d + x; }
inline Coord coord_516(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 517
inline int idx_517(int d, int x, int y) { return y * d + x; }
inline Coord coord_517(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 518
inline int idx_518(int d, int x, int y) { return y * d + x; }
inline Coord coord_518(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 519
inline int idx_519(int d, int x, int y) { return y * d + x; }
inline Coord coord_519(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 520
inline int idx_520(int d, int x, int y) { return y * d + x; }
inline Coord coord_520(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 521
inline int idx_521(int d, int x, int y) { return y * d + x; }
inline Coord coord_521(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 522
inline int idx_522(int d, int x, int y) { return y * d + x; }
inline Coord coord_522(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 523
inline int idx_523(int d, int x, int y) { return y * d + x; }
inline Coord coord_523(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 524
inline int idx_524(int d, int x, int y) { return y * d + x; }
inline Coord coord_524(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 525
inline int idx_525(int d, int x, int y) { return y * d + x; }
inline Coord coord_525(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 526
inline int idx_526(int d, int x, int y) { return y * d + x; }
inline Coord coord_526(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 527
inline int idx_527(int d, int x, int y) { return y * d + x; }
inline Coord coord_527(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 528
inline int idx_528(int d, int x, int y) { return y * d + x; }
inline Coord coord_528(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 529
inline int idx_529(int d, int x, int y) { return y * d + x; }
inline Coord coord_529(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 530
inline int idx_530(int d, int x, int y) { return y * d + x; }
inline Coord coord_530(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 531
inline int idx_531(int d, int x, int y) { return y * d + x; }
inline Coord coord_531(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 532
inline int idx_532(int d, int x, int y) { return y * d + x; }
inline Coord coord_532(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 533
inline int idx_533(int d, int x, int y) { return y * d + x; }
inline Coord coord_533(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 534
inline int idx_534(int d, int x, int y) { return y * d + x; }
inline Coord coord_534(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 535
inline int idx_535(int d, int x, int y) { return y * d + x; }
inline Coord coord_535(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 536
inline int idx_536(int d, int x, int y) { return y * d + x; }
inline Coord coord_536(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 537
inline int idx_537(int d, int x, int y) { return y * d + x; }
inline Coord coord_537(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 538
inline int idx_538(int d, int x, int y) { return y * d + x; }
inline Coord coord_538(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 539
inline int idx_539(int d, int x, int y) { return y * d + x; }
inline Coord coord_539(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 540
inline int idx_540(int d, int x, int y) { return y * d + x; }
inline Coord coord_540(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 541
inline int idx_541(int d, int x, int y) { return y * d + x; }
inline Coord coord_541(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 542
inline int idx_542(int d, int x, int y) { return y * d + x; }
inline Coord coord_542(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 543
inline int idx_543(int d, int x, int y) { return y * d + x; }
inline Coord coord_543(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 544
inline int idx_544(int d, int x, int y) { return y * d + x; }
inline Coord coord_544(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 545
inline int idx_545(int d, int x, int y) { return y * d + x; }
inline Coord coord_545(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 546
inline int idx_546(int d, int x, int y) { return y * d + x; }
inline Coord coord_546(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 547
inline int idx_547(int d, int x, int y) { return y * d + x; }
inline Coord coord_547(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 548
inline int idx_548(int d, int x, int y) { return y * d + x; }
inline Coord coord_548(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 549
inline int idx_549(int d, int x, int y) { return y * d + x; }
inline Coord coord_549(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 550
inline int idx_550(int d, int x, int y) { return y * d + x; }
inline Coord coord_550(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 551
inline int idx_551(int d, int x, int y) { return y * d + x; }
inline Coord coord_551(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 552
inline int idx_552(int d, int x, int y) { return y * d + x; }
inline Coord coord_552(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 553
inline int idx_553(int d, int x, int y) { return y * d + x; }
inline Coord coord_553(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 554
inline int idx_554(int d, int x, int y) { return y * d + x; }
inline Coord coord_554(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 555
inline int idx_555(int d, int x, int y) { return y * d + x; }
inline Coord coord_555(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 556
inline int idx_556(int d, int x, int y) { return y * d + x; }
inline Coord coord_556(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 557
inline int idx_557(int d, int x, int y) { return y * d + x; }
inline Coord coord_557(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 558
inline int idx_558(int d, int x, int y) { return y * d + x; }
inline Coord coord_558(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 559
inline int idx_559(int d, int x, int y) { return y * d + x; }
inline Coord coord_559(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 560
inline int idx_560(int d, int x, int y) { return y * d + x; }
inline Coord coord_560(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 561
inline int idx_561(int d, int x, int y) { return y * d + x; }
inline Coord coord_561(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 562
inline int idx_562(int d, int x, int y) { return y * d + x; }
inline Coord coord_562(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 563
inline int idx_563(int d, int x, int y) { return y * d + x; }
inline Coord coord_563(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 564
inline int idx_564(int d, int x, int y) { return y * d + x; }
inline Coord coord_564(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 565
inline int idx_565(int d, int x, int y) { return y * d + x; }
inline Coord coord_565(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 566
inline int idx_566(int d, int x, int y) { return y * d + x; }
inline Coord coord_566(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 567
inline int idx_567(int d, int x, int y) { return y * d + x; }
inline Coord coord_567(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 568
inline int idx_568(int d, int x, int y) { return y * d + x; }
inline Coord coord_568(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 569
inline int idx_569(int d, int x, int y) { return y * d + x; }
inline Coord coord_569(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 570
inline int idx_570(int d, int x, int y) { return y * d + x; }
inline Coord coord_570(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 571
inline int idx_571(int d, int x, int y) { return y * d + x; }
inline Coord coord_571(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 572
inline int idx_572(int d, int x, int y) { return y * d + x; }
inline Coord coord_572(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 573
inline int idx_573(int d, int x, int y) { return y * d + x; }
inline Coord coord_573(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 574
inline int idx_574(int d, int x, int y) { return y * d + x; }
inline Coord coord_574(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 575
inline int idx_575(int d, int x, int y) { return y * d + x; }
inline Coord coord_575(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 576
inline int idx_576(int d, int x, int y) { return y * d + x; }
inline Coord coord_576(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 577
inline int idx_577(int d, int x, int y) { return y * d + x; }
inline Coord coord_577(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 578
inline int idx_578(int d, int x, int y) { return y * d + x; }
inline Coord coord_578(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 579
inline int idx_579(int d, int x, int y) { return y * d + x; }
inline Coord coord_579(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 580
inline int idx_580(int d, int x, int y) { return y * d + x; }
inline Coord coord_580(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 581
inline int idx_581(int d, int x, int y) { return y * d + x; }
inline Coord coord_581(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 582
inline int idx_582(int d, int x, int y) { return y * d + x; }
inline Coord coord_582(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 583
inline int idx_583(int d, int x, int y) { return y * d + x; }
inline Coord coord_583(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 584
inline int idx_584(int d, int x, int y) { return y * d + x; }
inline Coord coord_584(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 585
inline int idx_585(int d, int x, int y) { return y * d + x; }
inline Coord coord_585(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 586
inline int idx_586(int d, int x, int y) { return y * d + x; }
inline Coord coord_586(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 587
inline int idx_587(int d, int x, int y) { return y * d + x; }
inline Coord coord_587(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 588
inline int idx_588(int d, int x, int y) { return y * d + x; }
inline Coord coord_588(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 589
inline int idx_589(int d, int x, int y) { return y * d + x; }
inline Coord coord_589(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 590
inline int idx_590(int d, int x, int y) { return y * d + x; }
inline Coord coord_590(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 591
inline int idx_591(int d, int x, int y) { return y * d + x; }
inline Coord coord_591(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 592
inline int idx_592(int d, int x, int y) { return y * d + x; }
inline Coord coord_592(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 593
inline int idx_593(int d, int x, int y) { return y * d + x; }
inline Coord coord_593(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 594
inline int idx_594(int d, int x, int y) { return y * d + x; }
inline Coord coord_594(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 595
inline int idx_595(int d, int x, int y) { return y * d + x; }
inline Coord coord_595(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 596
inline int idx_596(int d, int x, int y) { return y * d + x; }
inline Coord coord_596(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 597
inline int idx_597(int d, int x, int y) { return y * d + x; }
inline Coord coord_597(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 598
inline int idx_598(int d, int x, int y) { return y * d + x; }
inline Coord coord_598(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 599
inline int idx_599(int d, int x, int y) { return y * d + x; }
inline Coord coord_599(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 600
inline int idx_600(int d, int x, int y) { return y * d + x; }
inline Coord coord_600(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 601
inline int idx_601(int d, int x, int y) { return y * d + x; }
inline Coord coord_601(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 602
inline int idx_602(int d, int x, int y) { return y * d + x; }
inline Coord coord_602(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 603
inline int idx_603(int d, int x, int y) { return y * d + x; }
inline Coord coord_603(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 604
inline int idx_604(int d, int x, int y) { return y * d + x; }
inline Coord coord_604(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 605
inline int idx_605(int d, int x, int y) { return y * d + x; }
inline Coord coord_605(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 606
inline int idx_606(int d, int x, int y) { return y * d + x; }
inline Coord coord_606(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 607
inline int idx_607(int d, int x, int y) { return y * d + x; }
inline Coord coord_607(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 608
inline int idx_608(int d, int x, int y) { return y * d + x; }
inline Coord coord_608(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 609
inline int idx_609(int d, int x, int y) { return y * d + x; }
inline Coord coord_609(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 610
inline int idx_610(int d, int x, int y) { return y * d + x; }
inline Coord coord_610(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 611
inline int idx_611(int d, int x, int y) { return y * d + x; }
inline Coord coord_611(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 612
inline int idx_612(int d, int x, int y) { return y * d + x; }
inline Coord coord_612(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 613
inline int idx_613(int d, int x, int y) { return y * d + x; }
inline Coord coord_613(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 614
inline int idx_614(int d, int x, int y) { return y * d + x; }
inline Coord coord_614(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 615
inline int idx_615(int d, int x, int y) { return y * d + x; }
inline Coord coord_615(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 616
inline int idx_616(int d, int x, int y) { return y * d + x; }
inline Coord coord_616(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 617
inline int idx_617(int d, int x, int y) { return y * d + x; }
inline Coord coord_617(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 618
inline int idx_618(int d, int x, int y) { return y * d + x; }
inline Coord coord_618(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 619
inline int idx_619(int d, int x, int y) { return y * d + x; }
inline Coord coord_619(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 620
inline int idx_620(int d, int x, int y) { return y * d + x; }
inline Coord coord_620(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 621
inline int idx_621(int d, int x, int y) { return y * d + x; }
inline Coord coord_621(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 622
inline int idx_622(int d, int x, int y) { return y * d + x; }
inline Coord coord_622(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 623
inline int idx_623(int d, int x, int y) { return y * d + x; }
inline Coord coord_623(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 624
inline int idx_624(int d, int x, int y) { return y * d + x; }
inline Coord coord_624(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 625
inline int idx_625(int d, int x, int y) { return y * d + x; }
inline Coord coord_625(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 626
inline int idx_626(int d, int x, int y) { return y * d + x; }
inline Coord coord_626(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 627
inline int idx_627(int d, int x, int y) { return y * d + x; }
inline Coord coord_627(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 628
inline int idx_628(int d, int x, int y) { return y * d + x; }
inline Coord coord_628(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 629
inline int idx_629(int d, int x, int y) { return y * d + x; }
inline Coord coord_629(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 630
inline int idx_630(int d, int x, int y) { return y * d + x; }
inline Coord coord_630(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 631
inline int idx_631(int d, int x, int y) { return y * d + x; }
inline Coord coord_631(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 632
inline int idx_632(int d, int x, int y) { return y * d + x; }
inline Coord coord_632(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 633
inline int idx_633(int d, int x, int y) { return y * d + x; }
inline Coord coord_633(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 634
inline int idx_634(int d, int x, int y) { return y * d + x; }
inline Coord coord_634(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 635
inline int idx_635(int d, int x, int y) { return y * d + x; }
inline Coord coord_635(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 636
inline int idx_636(int d, int x, int y) { return y * d + x; }
inline Coord coord_636(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 637
inline int idx_637(int d, int x, int y) { return y * d + x; }
inline Coord coord_637(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 638
inline int idx_638(int d, int x, int y) { return y * d + x; }
inline Coord coord_638(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 639
inline int idx_639(int d, int x, int y) { return y * d + x; }
inline Coord coord_639(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 640
inline int idx_640(int d, int x, int y) { return y * d + x; }
inline Coord coord_640(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 641
inline int idx_641(int d, int x, int y) { return y * d + x; }
inline Coord coord_641(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 642
inline int idx_642(int d, int x, int y) { return y * d + x; }
inline Coord coord_642(int d, int idx) { return {idx % d, idx / d}; }
// Stabilizer indexing helper 643
