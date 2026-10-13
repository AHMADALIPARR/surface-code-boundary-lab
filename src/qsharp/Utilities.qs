// SPDX-License-Identifier: AGPL-3.0-or-later
// Copyright (C) 2026 SnapKitty Collective

namespace SurfaceCodeBoundaryLab.Utilities {
    function DataIndex(d : Int, x : Int, y : Int) : Int {
        return y * d + x;
    }

    function DataCoord(d : Int, idx : Int) : (Int, Int) {
        return (idx % d, idx / d);
    }

    function ZPlaquettes(d : Int) : Int[][] {
        mutable faces = [];
        for y in 0..d-2 {
            for x in 0..d-2 {
                set faces += [[DataIndex(d, x, y), DataIndex(d, x+1, y),
                               DataIndex(d, x, y+1), DataIndex(d, x+1, y+1)]];
            }
        }
        return faces;
    }

    function LogicalZSupport(d : Int) : Int[] {
        mutable s = [];
        for x in 0..d-1 {
            set s += [DataIndex(d, x, 0)];
        }
        return s;
    }

    function LogicalXSupport(d : Int) : Int[] {
        mutable s = [];
        for y in 0..d-1 {
            set s += [DataIndex(d, 0, y)];
        }
        return s;
    }
}
    // Helper 1
    function Idx1(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord1(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 2
    function Idx2(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord2(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 3
    function Idx3(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord3(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 4
    function Idx4(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord4(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 5
    function Idx5(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord5(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 6
    function Idx6(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord6(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 7
    function Idx7(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord7(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 8
    function Idx8(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord8(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 9
    function Idx9(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord9(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 10
    function Idx10(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord10(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 11
    function Idx11(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord11(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 12
    function Idx12(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord12(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 13
    function Idx13(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord13(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 14
    function Idx14(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord14(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 15
    function Idx15(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord15(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 16
    function Idx16(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord16(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 17
    function Idx17(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord17(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 18
    function Idx18(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord18(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 19
    function Idx19(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord19(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 20
    function Idx20(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord20(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 21
    function Idx21(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord21(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 22
    function Idx22(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord22(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 23
    function Idx23(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord23(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 24
    function Idx24(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord24(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 25
    function Idx25(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord25(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 26
    function Idx26(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord26(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 27
    function Idx27(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord27(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 28
    function Idx28(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord28(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 29
    function Idx29(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord29(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 30
    function Idx30(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord30(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 31
    function Idx31(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord31(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 32
    function Idx32(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord32(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 33
    function Idx33(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord33(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 34
    function Idx34(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord34(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 35
    function Idx35(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord35(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 36
    function Idx36(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord36(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 37
    function Idx37(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord37(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 38
    function Idx38(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord38(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 39
    function Idx39(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord39(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 40
    function Idx40(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord40(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 41
    function Idx41(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord41(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 42
    function Idx42(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord42(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 43
    function Idx43(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord43(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 44
    function Idx44(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord44(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 45
    function Idx45(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord45(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 46
    function Idx46(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord46(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 47
    function Idx47(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord47(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 48
    function Idx48(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord48(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 49
    function Idx49(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord49(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 50
    function Idx50(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord50(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 51
    function Idx51(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord51(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 52
    function Idx52(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord52(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 53
    function Idx53(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord53(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 54
    function Idx54(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord54(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 55
    function Idx55(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord55(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 56
    function Idx56(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord56(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 57
    function Idx57(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord57(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 58
    function Idx58(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord58(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 59
    function Idx59(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord59(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 60
    function Idx60(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord60(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 61
    function Idx61(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord61(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 62
    function Idx62(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord62(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 63
    function Idx63(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord63(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 64
    function Idx64(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord64(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 65
    function Idx65(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord65(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 66
    function Idx66(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord66(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 67
    function Idx67(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord67(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 68
    function Idx68(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord68(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 69
    function Idx69(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord69(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 70
    function Idx70(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord70(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 71
    function Idx71(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord71(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 72
    function Idx72(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord72(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 73
    function Idx73(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord73(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 74
    function Idx74(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord74(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 75
    function Idx75(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord75(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 76
    function Idx76(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord76(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 77
    function Idx77(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord77(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 78
    function Idx78(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord78(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 79
    function Idx79(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord79(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 80
    function Idx80(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord80(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 81
    function Idx81(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord81(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 82
    function Idx82(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord82(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 83
    function Idx83(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord83(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 84
    function Idx84(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord84(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 85
    function Idx85(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord85(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 86
    function Idx86(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord86(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 87
    function Idx87(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord87(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 88
    function Idx88(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord88(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 89
    function Idx89(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord89(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 90
    function Idx90(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord90(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 91
    function Idx91(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord91(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 92
    function Idx92(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord92(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 93
    function Idx93(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord93(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 94
    function Idx94(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord94(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 95
    function Idx95(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord95(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 96
    function Idx96(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord96(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 97
    function Idx97(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord97(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 98
    function Idx98(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord98(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 99
    function Idx99(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord99(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 100
    function Idx100(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord100(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 101
    function Idx101(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord101(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 102
    function Idx102(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord102(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 103
    function Idx103(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord103(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 104
    function Idx104(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord104(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 105
    function Idx105(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord105(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 106
    function Idx106(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord106(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 107
    function Idx107(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord107(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 108
    function Idx108(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord108(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 109
    function Idx109(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord109(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 110
    function Idx110(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord110(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 111
    function Idx111(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord111(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 112
    function Idx112(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord112(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 113
    function Idx113(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord113(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 114
    function Idx114(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord114(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 115
    function Idx115(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord115(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 116
    function Idx116(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord116(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 117
    function Idx117(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord117(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 118
    function Idx118(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord118(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 119
    function Idx119(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord119(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 120
    function Idx120(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord120(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 121
    function Idx121(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord121(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 122
    function Idx122(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord122(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 123
    function Idx123(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord123(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 124
    function Idx124(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord124(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 125
    function Idx125(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord125(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 126
    function Idx126(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord126(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 127
    function Idx127(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord127(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 128
    function Idx128(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord128(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 129
    function Idx129(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord129(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 130
    function Idx130(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord130(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 131
    function Idx131(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord131(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 132
    function Idx132(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord132(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 133
    function Idx133(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord133(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 134
    function Idx134(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord134(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 135
    function Idx135(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord135(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 136
    function Idx136(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord136(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 137
    function Idx137(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord137(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 138
    function Idx138(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord138(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 139
    function Idx139(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord139(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 140
    function Idx140(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord140(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 141
    function Idx141(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord141(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 142
    function Idx142(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord142(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 143
    function Idx143(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord143(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 144
    function Idx144(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord144(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 145
    function Idx145(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord145(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 146
    function Idx146(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord146(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 147
    function Idx147(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord147(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 148
    function Idx148(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord148(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 149
    function Idx149(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord149(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 150
    function Idx150(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord150(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 151
    function Idx151(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord151(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 152
    function Idx152(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord152(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 153
    function Idx153(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord153(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 154
    function Idx154(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord154(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 155
    function Idx155(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord155(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 156
    function Idx156(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord156(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 157
    function Idx157(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord157(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 158
    function Idx158(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord158(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 159
    function Idx159(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord159(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 160
    function Idx160(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord160(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 161
    function Idx161(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord161(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 162
    function Idx162(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord162(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 163
    function Idx163(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord163(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 164
    function Idx164(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord164(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 165
    function Idx165(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord165(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 166
    function Idx166(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord166(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 167
    function Idx167(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord167(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 168
    function Idx168(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord168(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 169
    function Idx169(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord169(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 170
    function Idx170(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord170(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 171
    function Idx171(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord171(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 172
    function Idx172(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord172(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 173
    function Idx173(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord173(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 174
    function Idx174(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord174(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 175
    function Idx175(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord175(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 176
    function Idx176(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord176(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 177
    function Idx177(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord177(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 178
    function Idx178(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord178(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 179
    function Idx179(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord179(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 180
    function Idx180(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord180(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 181
    function Idx181(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord181(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 182
    function Idx182(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord182(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 183
    function Idx183(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord183(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 184
    function Idx184(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord184(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 185
    function Idx185(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord185(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 186
    function Idx186(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord186(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 187
    function Idx187(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord187(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 188
    function Idx188(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord188(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 189
    function Idx189(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord189(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 190
    function Idx190(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord190(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 191
    function Idx191(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord191(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 192
    function Idx192(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord192(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 193
    function Idx193(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord193(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 194
    function Idx194(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord194(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 195
    function Idx195(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord195(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 196
    function Idx196(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord196(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 197
    function Idx197(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord197(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 198
    function Idx198(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord198(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 199
    function Idx199(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord199(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 200
    function Idx200(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord200(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 201
    function Idx201(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord201(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 202
    function Idx202(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord202(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 203
    function Idx203(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord203(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 204
    function Idx204(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord204(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 205
    function Idx205(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord205(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 206
    function Idx206(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord206(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 207
    function Idx207(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord207(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 208
    function Idx208(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord208(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 209
    function Idx209(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord209(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 210
    function Idx210(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord210(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 211
    function Idx211(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord211(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 212
    function Idx212(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord212(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 213
    function Idx213(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord213(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 214
    function Idx214(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord214(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 215
    function Idx215(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord215(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 216
    function Idx216(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord216(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 217
    function Idx217(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord217(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 218
    function Idx218(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord218(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 219
    function Idx219(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord219(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 220
    function Idx220(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord220(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 221
    function Idx221(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord221(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 222
    function Idx222(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord222(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 223
    function Idx223(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord223(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 224
    function Idx224(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord224(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 225
    function Idx225(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord225(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 226
    function Idx226(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord226(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 227
    function Idx227(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord227(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 228
    function Idx228(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord228(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 229
    function Idx229(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord229(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 230
    function Idx230(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord230(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 231
    function Idx231(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord231(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 232
    function Idx232(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord232(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 233
    function Idx233(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord233(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 234
    function Idx234(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord234(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 235
    function Idx235(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord235(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 236
    function Idx236(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord236(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 237
    function Idx237(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord237(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 238
    function Idx238(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord238(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 239
    function Idx239(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord239(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 240
    function Idx240(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord240(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 241
    function Idx241(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord241(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 242
    function Idx242(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord242(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 243
    function Idx243(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord243(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 244
    function Idx244(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord244(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 245
    function Idx245(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord245(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 246
    function Idx246(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord246(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 247
    function Idx247(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord247(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 248
    function Idx248(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord248(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 249
    function Idx249(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord249(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 250
    function Idx250(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord250(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 251
    function Idx251(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord251(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 252
    function Idx252(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord252(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 253
    function Idx253(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord253(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 254
    function Idx254(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord254(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 255
    function Idx255(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord255(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 256
    function Idx256(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord256(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 257
    function Idx257(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord257(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 258
    function Idx258(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord258(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 259
    function Idx259(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord259(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 260
    function Idx260(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord260(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 261
    function Idx261(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord261(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 262
    function Idx262(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord262(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 263
    function Idx263(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord263(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 264
    function Idx264(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord264(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 265
    function Idx265(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord265(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 266
    function Idx266(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord266(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 267
    function Idx267(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord267(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 268
    function Idx268(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord268(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 269
    function Idx269(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord269(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 270
    function Idx270(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord270(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 271
    function Idx271(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord271(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 272
    function Idx272(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord272(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 273
    function Idx273(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord273(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 274
    function Idx274(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord274(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 275
    function Idx275(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord275(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 276
    function Idx276(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord276(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 277
    function Idx277(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord277(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 278
    function Idx278(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord278(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 279
    function Idx279(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord279(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 280
    function Idx280(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord280(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 281
    function Idx281(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord281(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 282
    function Idx282(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord282(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 283
    function Idx283(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord283(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 284
    function Idx284(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord284(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 285
    function Idx285(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord285(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 286
    function Idx286(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord286(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 287
    function Idx287(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord287(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 288
    function Idx288(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord288(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 289
    function Idx289(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord289(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 290
    function Idx290(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord290(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 291
    function Idx291(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord291(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 292
    function Idx292(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord292(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 293
    function Idx293(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord293(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 294
    function Idx294(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord294(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 295
    function Idx295(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord295(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 296
    function Idx296(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord296(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 297
    function Idx297(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord297(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 298
    function Idx298(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord298(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 299
    function Idx299(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord299(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 300
    function Idx300(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord300(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 301
    function Idx301(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord301(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 302
    function Idx302(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord302(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 303
    function Idx303(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord303(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 304
    function Idx304(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord304(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 305
    function Idx305(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord305(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 306
    function Idx306(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord306(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 307
    function Idx307(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord307(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 308
    function Idx308(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord308(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 309
    function Idx309(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord309(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 310
    function Idx310(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord310(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 311
    function Idx311(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord311(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 312
    function Idx312(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord312(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 313
    function Idx313(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord313(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 314
    function Idx314(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord314(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 315
    function Idx315(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord315(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 316
    function Idx316(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord316(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 317
    function Idx317(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord317(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 318
    function Idx318(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord318(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 319
    function Idx319(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord319(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 320
    function Idx320(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord320(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 321
    function Idx321(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord321(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 322
    function Idx322(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord322(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 323
    function Idx323(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord323(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 324
    function Idx324(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord324(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 325
    function Idx325(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord325(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 326
    function Idx326(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord326(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 327
    function Idx327(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord327(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 328
    function Idx328(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord328(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 329
    function Idx329(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord329(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 330
    function Idx330(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord330(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 331
    function Idx331(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord331(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 332
    function Idx332(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord332(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 333
    function Idx333(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord333(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 334
    function Idx334(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord334(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 335
    function Idx335(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord335(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 336
    function Idx336(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord336(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 337
    function Idx337(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord337(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 338
    function Idx338(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord338(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 339
    function Idx339(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord339(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 340
    function Idx340(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord340(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 341
    function Idx341(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord341(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 342
    function Idx342(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord342(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 343
    function Idx343(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord343(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 344
    function Idx344(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord344(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 345
    function Idx345(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord345(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 346
    function Idx346(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord346(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 347
    function Idx347(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord347(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 348
    function Idx348(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord348(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 349
    function Idx349(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord349(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 350
    function Idx350(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord350(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 351
    function Idx351(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord351(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 352
    function Idx352(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord352(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 353
    function Idx353(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord353(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 354
    function Idx354(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord354(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 355
    function Idx355(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord355(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 356
    function Idx356(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord356(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 357
    function Idx357(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord357(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 358
    function Idx358(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord358(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 359
    function Idx359(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord359(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 360
    function Idx360(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord360(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 361
    function Idx361(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord361(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 362
    function Idx362(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord362(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 363
    function Idx363(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord363(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 364
    function Idx364(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord364(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 365
    function Idx365(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord365(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 366
    function Idx366(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord366(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 367
    function Idx367(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord367(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 368
    function Idx368(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord368(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 369
    function Idx369(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord369(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 370
    function Idx370(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord370(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 371
    function Idx371(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord371(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 372
    function Idx372(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord372(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 373
    function Idx373(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord373(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 374
    function Idx374(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord374(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 375
    function Idx375(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord375(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 376
    function Idx376(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord376(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 377
    function Idx377(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord377(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 378
    function Idx378(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord378(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 379
    function Idx379(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord379(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 380
    function Idx380(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord380(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 381
    function Idx381(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord381(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 382
    function Idx382(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord382(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 383
    function Idx383(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord383(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 384
    function Idx384(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord384(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 385
    function Idx385(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord385(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 386
    function Idx386(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord386(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 387
    function Idx387(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord387(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 388
    function Idx388(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord388(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 389
    function Idx389(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord389(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 390
    function Idx390(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord390(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 391
    function Idx391(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord391(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 392
    function Idx392(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord392(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 393
    function Idx393(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord393(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 394
    function Idx394(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord394(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 395
    function Idx395(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord395(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 396
    function Idx396(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord396(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 397
    function Idx397(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord397(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 398
    function Idx398(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord398(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 399
    function Idx399(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord399(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 400
    function Idx400(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord400(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 401
    function Idx401(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord401(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 402
    function Idx402(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord402(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 403
    function Idx403(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord403(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 404
    function Idx404(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord404(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 405
    function Idx405(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord405(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 406
    function Idx406(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord406(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 407
    function Idx407(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord407(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 408
    function Idx408(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord408(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 409
    function Idx409(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord409(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 410
    function Idx410(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord410(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 411
    function Idx411(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord411(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 412
    function Idx412(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord412(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 413
    function Idx413(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord413(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 414
    function Idx414(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord414(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 415
    function Idx415(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord415(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 416
    function Idx416(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord416(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 417
    function Idx417(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord417(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 418
    function Idx418(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord418(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 419
    function Idx419(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord419(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 420
    function Idx420(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord420(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 421
    function Idx421(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord421(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 422
    function Idx422(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord422(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 423
    function Idx423(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord423(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 424
    function Idx424(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord424(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 425
    function Idx425(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord425(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 426
    function Idx426(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord426(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 427
    function Idx427(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord427(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 428
    function Idx428(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord428(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 429
    function Idx429(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord429(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 430
    function Idx430(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord430(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 431
    function Idx431(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord431(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 432
    function Idx432(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord432(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 433
    function Idx433(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord433(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 434
    function Idx434(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord434(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 435
    function Idx435(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord435(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 436
    function Idx436(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord436(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 437
    function Idx437(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord437(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 438
    function Idx438(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord438(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 439
    function Idx439(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord439(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 440
    function Idx440(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord440(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 441
    function Idx441(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord441(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 442
    function Idx442(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord442(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 443
    function Idx443(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord443(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 444
    function Idx444(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord444(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 445
    function Idx445(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord445(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 446
    function Idx446(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord446(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 447
    function Idx447(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord447(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 448
    function Idx448(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord448(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 449
    function Idx449(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord449(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 450
    function Idx450(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord450(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 451
    function Idx451(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord451(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 452
    function Idx452(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord452(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 453
    function Idx453(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord453(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 454
    function Idx454(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord454(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 455
    function Idx455(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord455(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 456
    function Idx456(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord456(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 457
    function Idx457(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord457(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 458
    function Idx458(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord458(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 459
    function Idx459(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord459(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 460
    function Idx460(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord460(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 461
    function Idx461(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord461(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 462
    function Idx462(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord462(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 463
    function Idx463(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord463(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 464
    function Idx464(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord464(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 465
    function Idx465(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord465(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 466
    function Idx466(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord466(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 467
    function Idx467(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord467(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 468
    function Idx468(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord468(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 469
    function Idx469(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord469(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 470
    function Idx470(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord470(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 471
    function Idx471(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord471(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 472
    function Idx472(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord472(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 473
    function Idx473(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord473(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 474
    function Idx474(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord474(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 475
    function Idx475(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord475(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 476
    function Idx476(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord476(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 477
    function Idx477(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord477(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 478
    function Idx478(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord478(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 479
    function Idx479(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord479(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 480
    function Idx480(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord480(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 481
    function Idx481(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord481(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 482
    function Idx482(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord482(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 483
    function Idx483(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord483(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 484
    function Idx484(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord484(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 485
    function Idx485(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord485(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 486
    function Idx486(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord486(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
    // Helper 487
    function Idx487(d : Int, x : Int, y : Int) : Int { return y * d + x; }
    function Coord487(d : Int, idx : Int) : (Int, Int) { return (idx % d, idx / d); }
