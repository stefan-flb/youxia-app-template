/* eslint-disable */
import * as cc from './calculate'

export default {
  // ------------------ ssc ------------------
  // 五星直选 - 复式
  ZX5(method, state) {
    let n1, n2, n3, n4, n5, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1], n3 = ref[2], n4 = ref[3], n5 = ref[4];
    return n1 * n2 * n3 * n4 * n5;
  },
  // 五星直选 - 单式
  ZX5_S(method, state) {
    return cc.calculateByIuput(5, method, function () {
      return true;
    }, state);
  },
  // 五星组合5
  ZH5(method, state) {
    let n1, n2, n3, n4, n5, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1], n3 = ref[2], n4 = ref[3], n5 = ref[4];
    return n1 * n2 * n3 * n4 * n5 * 5;
  },
  // 五星组120
  WXZU120(method, state) {
    let h, m, n, ref;
    ref = cc.calculateMNH(method, state), m = ref[0], n = ref[1], h = ref[2];
    return cc.C(n, 5);
  },
  // 五星组60
  WXZU60(method, state) {
    let h, m, n, ref;
    ref = cc.calculateMNH(method, state), m = ref[0], n = ref[1], h = ref[2];
    return cc.C(m, 1) * cc.C(n, 3) - cc.C(h, 1) * cc.C(n - 1, 2);
  },
  // 五星组30
  WXZU30(method, state) {
    let h, m, n, ref;
    ref = cc.calculateMNH(method, state), m = ref[0], n = ref[1], h = ref[2];
    return cc.C(m, 2) * cc.C(n, 1) - cc.C(h, 2) * cc.C(2, 1) - cc.C(h, 1) * cc.C(m - h, 1);
  },
  // 五星组20
  WXZU20(method, state) {
    let h, m, n, ref;
    ref = cc.calculateMNH(method, state), m = ref[0], n = ref[1], h = ref[2];
    return cc.C(m, 1) * cc.C(n, 2) - cc.C(h, 1) * cc.C(n - 1, 1);
  },
  // 五星组10
  WXZU10(method, state) {
    let h, m, n, ref;
    ref = cc.calculateMNH(method, state), m = ref[0], n = ref[1], h = ref[2];
    return cc.C(m, 1) * cc.C(n, 1) - cc.C(h, 1);
  },
  // 五星组5
  WXZU5(method, state) {
    let h, m, n, ref;
    ref = cc.calculateMNH(method, state), m = ref[0], n = ref[1], h = ref[2];
    return cc.C(m, 1) * cc.C(n, 1) - cc.C(h, 1);
  },
  // 趣味 一帆风顺
  YFFS(method, state) {
    let n1, n2, n3, n4, n5, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1], n3 = ref[2], n4 = ref[3], n5 = ref[4];
    return n1;
  },
  // 趣味 好事成双
  HSCS(method, state) {
    let n1, n2, n3, n4, n5, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1], n3 = ref[2], n4 = ref[3], n5 = ref[4];
    return n1;
  },
  // 趣味 三星报喜
  SXBX(method, state) {
    let n1, n2, n3, n4, n5, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1], n3 = ref[2], n4 = ref[3], n5 = ref[4];
    return n1;
  },
  // 趣味 四季发财
  SJFC(method, state) {
    let n1, n2, n3, n4, n5, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1], n3 = ref[2], n4 = ref[3], n5 = ref[4];
    return n1;
  },
  // 四星 直选4
  ZX4(method, state) {
    let n1, n2, n3, n4, n5, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1], n3 = ref[2], n4 = ref[3], n5 = ref[4];
    return n1 * n2 * n3 * n4;
  },
  // 四星 直选4 单式
  ZX4_S(method, state) {
    return cc.calculateByIuput(4, method, function () {
      return true;
    }, state);
  },
  // 四星 直选4 组合4
  ZH4(method, state) {
    let n1, n2, n3, n4, n5, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1], n3 = ref[2], n4 = ref[3], n5 = ref[4];
    return n1 * n2 * n3 * n4 * 4;
  },
  // 四星 直选4 组24
  SXZU24(method, state) {
    let h, m, n, ref;
    ref = cc.calculateMNH(method, state), m = ref[0], n = ref[1], h = ref[2];
    return cc.C(n, 4);
  },
  // 四星 直选4 组12
  SXZU12(method, state) {
    let h, m, n, ref;
    ref = cc.calculateMNH(method, state), m = ref[0], n = ref[1], h = ref[2];
    return cc.C(m, 1) * cc.C(n, 2) - cc.C(h, 1) * cc.C(n - 1, 1);
  },
  // 四星 直选4 组6
  SXZU6(method, state) {
    let h, m, n, ref;
    ref = cc.calculateMNH(method, state), m = ref[0], n = ref[1], h = ref[2];
    return cc.C(n, 2);
  },
  // 四星 直选4 组4
  SXZU4(method, state) {
    let h, m, n, ref;
    ref = cc.calculateMNH(method, state), m = ref[0], n = ref[1], h = ref[2];
    return cc.C(m, 1) * cc.C(n, 1) - cc.C(h, 1);
  },

  // 三星 直选
  QZX3(method, state) {
    let n1, n2, n3, n4, n5, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1], n3 = ref[2], n4 = ref[3], n5 = ref[4];
    return n1 * n2 * n3;
  },
  // 三星 直选
  ZZX3(method, state) {
    return this.QZX3(method, state);
  },
  // 三星 直选
  HZX3(method, state) {
    return this.QZX3(method, state);
  },
  // 三星 直选 单式
  QZX3_S(method, state) {
    return cc.calculateByIuput(3, method, function () {
      return true;
    }, state);
  },
  // 三星 直选 单式
  ZZX3_S(method, state) {
    return this.QZX3_S(method, state);
  },
  // 三星 直选 单式
  HZX3_S(method, state) {
    return this.QZX3_S(method, state);
  },
  // 组合3
  QZH3(method, state) {
    let n1, n2, n3, n4, n5, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1], n3 = ref[2], n4 = ref[3], n5 = ref[4];
    return n1 * n2 * n3 * 3;
  },
  // 组合3
  ZZH3(method, state) {
    return this.QZH3(method, state);
  },
  // 组合3
  HZH3(method, state) {
    return this.QZH3(method, state);
  },
  // 三星 和值
  QZXHZ(method, state) {
    let data;
    data = [1, 3, 6, 10, 15, 21, 28, 36, 45, 55, 63, 69, 73, 75, 75, 73, 69, 63, 55, 45, 36, 28, 21, 15, 10, 6, 3, 1];
    return cc.calculateByPosition(data, method, state);
  },
  // 三星 和值
  ZZXHZ(method, state) {
    return this.QZXHZ(method, state);
  },
  // 三星 和值
  HZXHZ(method, state) {
    return this.QZXHZ(method, state);
  },

  // 三星 直选 跨度
  QZXKD(method, state) {
    let data;
    data = [10, 54, 96, 126, 144, 150, 144, 126, 96, 54];
    return cc.calculateByPosition(data, method, state);
  },
  // 三星 直选 跨度
  ZZXKD(method, state) {
    return this.QZXKD(method, state);
  },
  // 三星 直选 跨度
  HZXKD(method, state) {
    return this.QZXKD(method, state);
  },
  // 三星 组3
  QZU3(method, state) {
    let h, m, n, ref;
    ref = cc.calculateMNH(method, state), m = ref[0], n = ref[1], h = ref[2];
    return cc.C(n, 2) * 2;
  },
  // 三星 组3
  ZZU3(method, state) {
    return this.QZU3(method, state);
  },
  // 三星 组3
  HZU3(method, state) {
    return this.QZU3(method, state);
  },
  // 三星 组三 单式
  QZU3_S(method, state) {
    return cc.calculateByZuIuput(3, method, input => {
      let ref;
      if ((input[0] === (ref = input[1]) && ref === input[2])) {
        return false;
      }
      if (input[0] === input[1] || input[1] === input[2] || input[0] === input[2]) {
        return true;
      }
    }, state);
  },
  // 三星 组三 单式
  ZZU3_S(method, state) {
    return this.QZU3_S(method, state);
  },
  // 三星 组三 单式
  HZU3_S(method, state) {
    return this.QZU3_S(method, state);
  },
  // 三星 组六
  QZU6(method, state) {
    let h, m, n, ref;
    ref = cc.calculateMNH(method, state), m = ref[0], n = ref[1], h = ref[2];
    return cc.C(n, 3);
  },
  // 三星 组六
  ZZU6(method, state) {
    return this.QZU6(method, state);
  },
  // 三星 组六
  HZU6(method, state) {
    return this.QZU6(method, state);
  },
  // 三星 组六 单式
  QZU6_S(method, state) {
    return cc.calculateByZuIuput(3, method, input => {
      if (input[0] === input[1] || input[1] === input[2] || input[0] === input[2]) {
        return false;
      }
      return true;
    }, state);
  },
  // 三星 组六 单式
  ZZU6_S(method, state) {
    return this.QZU6_S(method, state);
  },
  // 三星 组六 单式
  HZU6_S(method, state) {
    return this.QZU6_S(method, state);
  },
  // 三星 - 混合组选
  QHHZX(method, state) {
    return cc.calculateByZuIuput(3, method, input => {
      let ref;
      if ((input[0] === (ref = input[1]) && ref === input[2])) {
        return false;
      }
      return true;
    }, state);
  },
  // 三星 - 混合组选
  ZHHZX(method, state) {
    return this.QHHZX(method, state);
  },
  // 三星 - 混合组选
  HHHZX(method, state) {
    return this.QHHZX(method, state);
  },
  // 三星 组3 和值
  QZUHZ(method, state) {
    let data;
    data = [1, 2, 2, 4, 5, 6, 8, 10, 11, 13, 14, 14, 15, 15, 14, 14, 13, 11, 10, 8, 6, 5, 4, 2, 2, 1];
    return cc.calculateByPosition(data, method, state);
  },
  // 三星 组3 和值
  // ZZUHZ(method, state) {
  //     console.log(1232323)
  //     return this.ZZUHZ(method, state);
  // },
  ZZUHZ(method, state) {
    let data;
    data = [1, 2, 2, 4, 5, 6, 8, 10, 11, 13, 14, 14, 15, 15, 14, 14, 13, 11, 10, 8, 6, 5, 4, 2, 2, 1];
    return cc.calculateByPosition(data, method, state);
  },
  // 三星 组3 和值
  // HZUHZ(method, state) {
  //     return this.HZUHZ(method, state);
  // },
  // 三星 组3 和值
  HZUHZ(method, state) {
    let data;
    data = [1, 2, 2, 4, 5, 6, 8, 10, 11, 13, 14, 14, 15, 15, 14, 14, 13, 11, 10, 8, 6, 5, 4, 2, 2, 1];
    return cc.calculateByPosition(data, method, state);
  },
  // 三星 组三 包胆
  QZU3BD(method, state) {
    let data;
    data = [54, 54, 54, 54, 54, 54, 54, 54, 54, 54];
    return cc.calculateByPosition(data, method, state);
  },
  // 三星 组三 包胆
  ZZU3BD(method, state) {
    return this.QZU3BD(method, state);
  },
  // 三星 组三 包胆
  HZU3BD(method, state) {
    return this.QZU3BD(method, state);
  },

  // 三星 和值尾数
  QHZWS(method, state) {
    let h, m, n, ref;
    ref = cc.calculateMNH(method, state), m = ref[0], n = ref[1], h = ref[2];
    return cc.C(n, 1);
  },
  // 三星 和值尾数
  ZHZWS(method, state) {
    return this.QHZWS(method, state);
  },
  // 三星 和值尾数
  HHZWS(method, state) {
    return this.QHZWS(method, state);
  },
  // 特殊3
  QTS3(method, state) {
    let data;
    data = [1, 1, 1];
    return cc.calculateByPosition(data, method, state);
  },
  // 特殊3
  ZTS3(method, state) {
    return this.QTS3(method, state);
  },
  // 特殊3
  HTS3(method, state) {
    return this.QTS3(method, state);
  },

  // 两星 直选 单式
  QZX2(method, state) {
    let n1, n2, n3, n4, n5, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1], n3 = ref[2], n4 = ref[3], n5 = ref[4];
    return n1 * n2;
  },
  // 两星 直选 单式
  HZX2(method, state) {
    return this.QZX2(method, state);
  },
  // 两星 直选 单式
  QZX2_S(method, state) {
    return cc.calculateByIuput(2, method, function () {
      return true;
    }, state);
  },
  // 两星 直选 单式
  HZX2_S(method, state) {
    return this.QZX2_S(method, state);
  },
  // 两星 直选 和值
  QZX2HZ(method, state) {
    let data;
    data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].concat([9, 8, 7, 6, 5, 4, 3, 2, 1]);
    return cc.calculateByPosition(data, method, state);
  },
  // 两星 直选 和值
  HZX2HZ(method, state) {
    return this.QZX2HZ(method, state);
  },
  // 两星 直选 跨度
  QZX2KD(method, state) {
    let data;
    data = [10, 18, 16, 14, 12, 10, 8, 6, 4, 2];
    return cc.calculateByPosition(data, method, state);
  },
  // 两星 直选 跨度
  HZX2KD(method, state) {
    return this.QZX2KD(method, state);
  },

  // 两星 组2
  QZU2(method, state) {
    let h, m, n, ref;
    ref = cc.calculateMNH(method, state), m = ref[0], n = ref[1], h = ref[2];
    return cc.C(n, 2);
  },
  // 两星 组2
  HZU2(method, state) {
    return this.QZU2(method, state);
  },
  // 两星 组2 单式
  QZU2_S(method, state) {
    return cc.calculateByZuIuput(2, method, input => {
      if (input[0] !== input[1]) {
        return true;
      }
      return false;
    }, state);
  },
  // 两星 组2 单式
  HZU2_S(method, state) {
    return this.QZU2_S(method, state);
  },

  // 两星 组选2和值
  QZU2HZ(method, state) {
    let data;
    data = [1, 1, 2, 2, 3, 3, 4, 4, 5, 4, 4, 3, 3, 2, 2, 1, 1];
    return cc.calculateByPosition(data, method, state);
  },
  // 两星 组选2和值
  HZU2HZ(method, state) {
    return this.QZU2HZ(method, state);
  },
  // 两星 组选2包胆
  QZU2BD(method, state) {
    let data;
    data = [9, 9, 9, 9, 9, 9, 9, 9, 9, 9];
    return cc.calculateByPosition(data, method, state);
  },
  // 两星 组选2包胆
  HZU2BD(method, state) {
    return this.QZU2BD(method, state);
  },
  // 定位胆
  DWD(method, state) {
    let n1, n2, n3, n4, n5, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1], n3 = ref[2], n4 = ref[3], n5 = ref[4];
    return n1 + n2 + n3 + n4 + n5;
  },
  // 不定位31
  QBDW31(method, state) {
    let n1, n2, n3, n4, n5, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1], n3 = ref[2], n4 = ref[3], n5 = ref[4];
    return cc.C(n1, 1);
  },
  HBDW31(method, state) {
    return this.QBDW31(method, state);
  },
  // 不定位32
  QBDW32(method, state) {
    let n1, n2, n3, n4, n5, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1], n3 = ref[2], n4 = ref[3], n5 = ref[4];
    return cc.C(n1, 2);
  },
  HBDW32(method, state) {
    return this.QBDW32(method, state);
  },
  // 不定位41
  BDW41(method, state) {
    let n1, n2, n3, n4, n5, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1], n3 = ref[2], n4 = ref[3], n5 = ref[4];
    return cc.C(n1, 1);
  },
  // 不定位42
  BDW42(method, state) {
    let n1, n2, n3, n4, n5, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1], n3 = ref[2], n4 = ref[3], n5 = ref[4];
    return cc.C(n1, 2);
  },
  // 不定位52
  BDW52(method, state) {
    let n1, n2, n3, n4, n5, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1], n3 = ref[2], n4 = ref[3], n5 = ref[4];
    return cc.C(n1, 2);
  },
  // 不定位53
  BDW53(method, state) {
    let n1, n2, n3, n4, n5, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1], n3 = ref[2], n4 = ref[3], n5 = ref[4];
    return cc.C(n1, 3);
  },
  // 大小单双
  DXDS(method, state) {
    let n1, n2, n3, n4, n5, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1], n3 = ref[2], n4 = ref[3], n5 = ref[4];
    return n1 * n2;
  },
  // 二星大小单双
  Q2DXDS(method, state) {
    return this.DXDS(method, state);
  },
  H2DXDS(method, state) {
    return this.DXDS(method, state);
  },
  // 三星大小单双
  Q3DXDS(method, state) {
    let n1, n2, n3, n4, n5, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1], n3 = ref[2], n4 = ref[3], n5 = ref[4];
    return n1 * n2 * n3;
  },
  Z3DXDS(method, state) {
    return this.Q3DXDS(method, state);
  },
  H3DXDS(method, state) {
    return this.Q3DXDS(method, state);
  },
  // 龙虎
  LHWQ(method, state) {
    let data;
    data = [1, 1, 1];
    return cc.calculateByPosition(data, method, state);
  },
  LHWB(method, state) {
    return this.LHWQ(method, state);
  },
  LHWS(method, state) {
    return this.LHWQ(method, state);
  },
  LHWG(method, state) {
    return this.LHWQ(method, state);
  },

  LHQB(method, state) {
    return this.LHWQ(method, state);
  },
  LHQS(method, state) {
    return this.LHWQ(method, state);
  },
  LHQG(method, state) {
    return this.LHWQ(method, state);
  },
  LHBS(method, state) {
    return this.LHWQ(method, state);
  },
  LHBG(method, state) {
    return this.LHWQ(method, state);
  },
  LHSG(method, state) {
    return this.LHWQ(method, state);
  },
  // 任选
  RZX2(method, state) {
    let arr, cnt, i, j, len, n1, n2, ref;
    cnt = 0;
    arr = cc.Combine(cc.calculateN(method, state), 2);
    for (i = j = 0, len = arr.length; j < len; i = ++j) {
      ref = arr[i], n1 = ref[0], n2 = ref[1];
      cnt += n1 * n2;
    }
    return [cnt, arr.length];
  },
  RZX2_S(method, state) {
    let cnt, m, n, tmp;
    n = cc.calculatePositionCnt(method, state);
    m = cc.C(n, 2);
    tmp = this.ZX2_S(method, state);
    cnt = m * tmp[0];
    return [cnt, m, tmp[1]];
  },
  RZXHZ2(method, state) {
    let cnt, m, n;
    n = cc.calculatePositionCnt(method, state);
    m = cc.C(n, 2);
    cnt = m * this.ZXHZ2(method, state);
    return [cnt, m];
  },
  RZU2(method, state) {
    let cnt, m, n;
    n = cc.calculatePositionCnt(method, state);
    m = cc.C(n, 2);
    cnt = m * this.ZU2(method, state);
    return [cnt, m];
  },
  RZU2_S(method, state) {
    let cnt, m, n, tmp;
    n = cc.calculatePositionCnt(method, state);
    m = cc.C(n, 2);
    tmp = this.ZU2_S(method, state);
    cnt = m * tmp[0];
    return [cnt, m, tmp[1]];
  },
  RZUHZ2(method, state) {
    let cnt, m, n;
    n = cc.calculatePositionCnt(method, state);
    m = cc.C(n, 2);
    cnt = m * this.ZUHZ2(method, state);
    return [cnt, m];
  },
  RZX3(method, state) {
    let arr, cnt, i, j, len, n1, n2, n3, ref;
    cnt = 0;
    arr = cc.Combine(cc.calculateN(method, state), 3);
    for (i = j = 0, len = arr.length; j < len; i = ++j) {
      ref = arr[i], n1 = ref[0], n2 = ref[1], n3 = ref[2];
      cnt += n1 * n2 * n3;
    }
    return [cnt, arr.length];
  },
  RZX3_S(method, state) {
    let cnt, m, n, tmp;
    n = cc.calculatePositionCnt(method, state);
    m = cc.C(n, 3);
    tmp = this.ZX3_S(method, state);
    cnt = m * tmp[0];
    return [cnt, m, tmp[1]];
  },
  RZXHZ(method, state) {
    let cnt, m, n;
    n = cc.calculatePositionCnt(method, state);
    m = cc.C(n, 3);
    cnt = m * this.ZXHZ(method, state);
    return [cnt, m];
  },
  RZUS(method, state) {
    let cnt, m, n;
    n = cc.calculatePositionCnt(method, state);
    m = cc.C(n, 3);
    cnt = m * this.ZUS(method, state);
    return [cnt, m];
  },
  RZUS_S(method, state) {
    let cnt, m, n, tmp;
    n = cc.calculatePositionCnt(method, state);
    m = cc.C(n, 3);
    tmp = this.ZUS_S(method, state);
    cnt = m * tmp[0];
    return [cnt, m, tmp[1]];
  },
  RZUL(method, state) {
    let cnt, m, n;
    n = cc.calculatePositionCnt(method, state);
    m = cc.C(n, 3);
    cnt = m * this.ZUL(method, state);
    return [cnt, m];
  },
  RZUL_S(method, state) {
    let cnt, m, n, tmp;
    n = cc.calculatePositionCnt(method, state);
    m = cc.C(n, 3);
    tmp = this.ZUL_S(method, state);
    cnt = m * tmp[0];
    return [cnt, m, tmp[1]];
  },
  RHHZX(method, state) {
    let cnt, m, n, tmp;
    n = cc.calculatePositionCnt(method, state);
    m = cc.C(n, 3);
    tmp = this.HHZX(method, state);
    cnt = m * tmp[0];
    return [cnt, m, tmp[1]];
  },
  RZUHZ(method, state) {
    let cnt, m, n;
    n = cc.calculatePositionCnt(method, state);
    m = cc.C(n, 3);
    cnt = m * this.ZUHZ(method, state);
    return [cnt, m];
  },
  RZX4(method, state) {
    let arr, cnt, i, j, len, n1, n2, n3, n4, ref;
    cnt = 0;
    arr = cc.Combine(cc.calculateN(method, state), 4);
    for (i = j = 0, len = arr.length; j < len; i = ++j) {
      ref = arr[i], n1 = ref[0], n2 = ref[1], n3 = ref[2], n4 = ref[3];
      cnt += n1 * n2 * n3 * n4;
    }
    return [cnt, arr.length];
  },
  RZX4_S(method, state) {
    let cnt, m, n, tmp;
    n = cc.calculatePositionCnt(method, state);
    m = cc.C(n, 4);
    tmp = this.ZX4_S(method, state);
    cnt = m * tmp[0];
    return [cnt, m, tmp[1]];
  },
  RSXZU24(method, state) {
    let cnt, m, n;
    n = cc.calculatePositionCnt(method, state);
    m = cc.C(n, 4);
    cnt = m * this.SXZU24(method, state);
    return [cnt, m];
  },
  RSXZU12(method, state) {
    let cnt, m, n;
    n = cc.calculatePositionCnt(method, state);
    m = cc.C(n, 4);
    cnt = m * this.SXZU12(method, state);
    return [cnt, m];
  },
  RSXZU6(method, state) {
    let cnt, m, n;
    n = cc.calculatePositionCnt(method, state);
    m = cc.C(n, 4);
    cnt = m * this.SXZU6(method, state);
    return [cnt, m];
  },
  RSXZU4(method, state) {
    let cnt, m, n;
    n = cc.calculatePositionCnt(method, state);
    m = cc.C(n, 4);
    cnt = m * this.SXZU4(method, state);
    return [cnt, m];
  },

  // ------------------快三------------------

  // 快3和值大小单双
  KSHZDXDS(method, state) {
    return cc.calculateN(method, state)[0];
  },
  // 快3和值
  KSHZ(method, state) {
    return cc.calculateN(method, state)[0];
  },
  // 三不同号
  SBTH(method, state) {
    return cc.calculateN(method, state)[0];
  },
  // 三同号
  STH(method, state) {
    return cc.calculateN(method, state)[0];
  },
  // 三连号
  SLH(method, state) {
    return cc.calculateN(method, state)[0];
  },
  // 半顺
  K3BS(method, state) {
    return cc.calculateN(method, state)[0];
  },
  // 二不同号
  EBTH(method, state) {
    return cc.calculateN(method, state)[0];
  },
  // 二同号
  ETH(method, state) {
    return cc.calculateN(method, state)[0];
  },
  // 单挑一骰
  DTYS(method, state) {
    return cc.calculateN(method, state)[0];
  },
  // ------------------ 乐透类型 ------------------

  LTQ3ZX3(method, state) {
    let A, AB, ABC, AC, B, BC, C, listA, listB, listC, ref, ref1, result;
    ref = cc.calculateN(method, state), A = ref[0], B = ref[1], C = ref[2];
    ref1 = cc.calculateNDetail(method, state), listA = ref1[0], listB = ref1[1], listC = ref1[2];
    BC = cc.N(listB, listC);
    AC = cc.N(listA, listC);
    AB = cc.N(listA, listB);
    ABC = cc.N(listA, listB, listC);
    result = A * B * C - A * BC - B * AC - C * AB + 2 * ABC;
    if (result > 0) {
      return result;
    } else {
      return 0;
    }
  },

  LTQ3ZX3_S(method, state) {
    return cc.calculateLTByIuput(method, 3, num => +num && +num >= 1 && +num <= 11, state);
  },

  LTQ3ZU3(method, state) {
    let n;
    n = cc.calculateN(method, state)[0];
    return cc.C(n, 3);
  },

  LTQ3ZU3_S(method, state) {
    return cc.calculateLTByIuput(method, 3, num => +num && +num >= 1 && +num <= 11, state);
  },

  LTQ3ZU3DT(method, state) {
    let n1, n2, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1];
    if (!n1) {
      return 0;
    }
    return cc.C(n2, 3 - n1);
  },

  LTQ2ZX2(method, state) {
    let A, AB, B, listA, listB, ref, ref1, result;
    ref = cc.calculateN(method, state), A = ref[0], B = ref[1];
    ref1 = cc.calculateNDetail(method, state), listA = ref1[0], listB = ref1[1];
    AB = cc.N(listA, listB);
    result = A * B - AB;
    if (result > 0) {
      return result;
    } else {
      return 0;
    }
  },

  LTQ2ZX2_S(method, state) {
    return cc.calculateLTByIuput(method, 2, num => +num && +num >= 1 && +num <= 11, state);
  },

  LTQ2ZU2(method, state) {
    let n;
    n = cc.calculateN(method, state)[0];
    return cc.C(n, 2);
  },

  LTQ2ZU2_S(method, state) {
    return cc.calculateLTByIuput(method, 2, num => +num && +num >= 1 && +num <= 11, state);
  },

  LTQ2DTZU2(method, state) {
    let n1, n2, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1];
    if (!n1) {
      return 0;
    }
    return cc.C(n2, 2 - n1);
  },

  LTBDW(method, state) {
    return cc.calculateN(method, state)[0];
  },

  LTDWD(method, state) {
    let n1, n2, n3, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1], n3 = ref[2];
    return n1 + n2 + n3;
  },

  // 11选5定位胆1
  LTDWD_1(method, state) {
    let n1, n2, n3, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1], n3 = ref[2];
    return n1 + n2 + n3;
  },
  // 11选5定位胆2
  LTDWD_2(method, state) {
    let n1, n2, n3, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1], n3 = ref[2];
    return n1 + n2 + n3;
  },
  // 11选5定位胆3
  LTDWD_3(method, state) {
    let n1, n2, n3, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1], n3 = ref[2];
    return n1 + n2 + n3;
  },

  LTDDS(method, state) {
    return cc.calculateN(method, state)[0];
  },

  LTCZW(method, state) {
    return cc.calculateN(method, state)[0];
  },

  LTRX1(method, state) {
    let n;
    n = cc.calculateN(method, state)[0];
    return cc.C(n, 1);
  },

  LTRX1_S(method, state) {
    return cc.calculateLTRXByIuput(method, 1, num => +num && +num >= 1 && +num <= 11, state);
  },

  LTRX2(method, state) {
    let n;
    n = cc.calculateN(method, state)[0];
    return cc.C(n, 2);
  },

  LTRX2_S(method, state) {
    return cc.calculateLTRXByIuput(method, 2, num => +num && +num >= 1 && +num <= 11, state);
  },

  LTRX3(method, state) {
    let n;
    n = cc.calculateN(method, state)[0];
    return cc.C(n, 3);
  },

  LTRX3_S(method, state) {
    return cc.calculateLTRXByIuput(method, 3, num => +num && +num >= 1 && +num <= 11, state);
  },

  LTRX4(method, state) {
    let n;
    n = cc.calculateN(method, state)[0];
    return cc.C(n, 4);
  },

  LTRX4_S(method, state) {
    return cc.calculateLTRXByIuput(method, 4, num => +num && +num >= 1 && +num <= 11, state);
  },

  LTRX5(method, state) {
    let n;
    n = cc.calculateN(method, state)[0];
    return cc.C(n, 5);
  },

  LTRX5_S(method, state) {
    return cc.calculateLTRXByIuput(method, 5, num => +num && +num >= 1 && +num <= 11, state);
  },

  LTRX6(method, state) {
    let n;
    n = cc.calculateN(method, state)[0];
    return cc.C(n, 6);
  },

  LTRX6_S(method, state) {
    return cc.calculateLTRXByIuput(method, 6, num => +num && +num >= 1 && +num <= 11, state);
  },

  LTRX7(method, state) {
    let n;
    n = cc.calculateN(method, state)[0];
    return cc.C(n, 7);
  },

  LTRX7_S(method, state) {
    return cc.calculateLTRXByIuput(method, 7, num => +num && +num >= 1 && +num <= 11, state);
  },

  LTRX8(method, state) {
    let n;
    n = cc.calculateN(method, state)[0];
    return cc.C(n, 8);
  },

  LTRX8_S(method, state) {
    return cc.calculateLTRXByIuput(method, 8, num => +num && +num >= 1 && +num <= 11, state);
  },

  LTRXDT2(method, state) {
    let n1, n2, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1];
    if (n1 < 1) {
      return 0;
    }
    return cc.C(n2, 2 - n1);
  },

  LTRXDT3(method, state) {
    let n1, n2, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1];
    if (n1 < 1) {
      return 0;
    }
    return cc.C(n2, 3 - n1);
  },

  LTRXDT4(method, state) {
    let n1, n2, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1];
    if (n1 < 1) {
      return 0;
    }
    return cc.C(n2, 4 - n1);
  },

  LTRXDT5(method, state) {
    let n1, n2, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1];
    if (n1 < 1) {
      return 0;
    }
    return cc.C(n2, 5 - n1);
  },

  LTRXDT6(method, state) {
    let n1, n2, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1];
    if (n1 < 1) {
      return 0;
    }
    return cc.C(n2, 6 - n1);
  },

  LTRXDT7(method, state) {
    let n1, n2, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1];
    if (n1 < 1) {
      return 0;
    }
    return cc.C(n2, 7 - n1);
  },

  LTRXDT8(method, state) {
    let n1, n2, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1];
    if (n1 < 1) {
      return 0;
    }
    return cc.C(n2, 8 - n1);
  },

  // ------------------PK10------------------
  // 猜冠军
  PKQZX1(method, state) {
    let n1;
    n1 = cc.calculateN(method, state)[0];
    return n1;
  },

  // 猜冠军单式
  PKQZX1_S(method, state) {
    return cc.calculateLTByIuput(method, 1, num => +num && +num >= 1 && +num <= 10, state);
  },

  // 猜第2
  PKQD2(method, state) {
    let n1;
    n1 = cc.calculateN(method, state)[0];
    return n1;
  },

  // 猜第2 单式
  PKQD2_S(method, state) {
    return cc.calculateLTByIuput(method, 1, num => +num && +num >= 1 && +num <= 10, state);
  },

  // 猜前二
  PKQZX2(method, state) {
    let A, AB, B, listA, listB, ref, ref1, result;
    ref = cc.calculateN(method, state), A = ref[0], B = ref[1];
    ref1 = cc.calculateNDetail(method, state), listA = ref1[0], listB = ref1[1];
    AB = cc.N(listA, listB);
    result = A * B - AB;
    if (result > 0) {
      return result;
    }

    return 0;
  },

  // 猜前二单式
  PKQZX2_S(method, state) {
    return cc.calculateLTByIuput(method, 2, num => +num && +num >= 1 && +num <= 10, state);
  },

  // 猜第3
  PKQD3(method, state) {
    let n1;
    n1 = cc.calculateN(method, state)[0];
    return n1;
  },

  // 猜第3 单式
  PKQD3_S(method, state) {
    return cc.calculateLTByIuput(method, 1, num => +num && +num >= 1 && +num <= 10, state);
  },

  // 猜前三
  PKQZX3(method, state) {
    let A, AB, ABC, AC, B, BC, C, listA, listB, listC, ref, ref1, result;
    ref = cc.calculateN(method, state), A = ref[0], B = ref[1], C = ref[2];
    ref1 = cc.calculateNDetail(method, state), listA = ref1[0], listB = ref1[1], listC = ref1[2];
    BC = cc.N(listB, listC);
    AC = cc.N(listA, listC);
    AB = cc.N(listA, listB);
    ABC = cc.N(listA, listB, listC);
    result = A * B * C - A * BC - B * AC - C * AB + 2 * ABC;
    if (result > 0) {
      return result;
    } else {
      return 0;
    }
  },

  // 猜前3单式
  PKQZX3_S(method, state) {
    return cc.calculateLTByIuput(method, 3, num => +num && +num >= 1 && +num <= 10, state);
  },

  // 猜第4
  PKQD4(method, state) {
    let n1;
    n1 = cc.calculateN(method, state)[0];
    return n1;
  },

  // 猜第4 单式
  PKQD4_S(method, state) {
    return cc.calculateLTByIuput(method, 1, num => +num && +num >= 1 && +num <= 10, state);
  },

  // 猜前4
  PKQZX4(method, state) {
    let choices     = state.choices;
    let _result     = [
      [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
      [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
      [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
      [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
    ];

    // 过滤
    for(let a = 0; a < choices.length; a ++) {
      let row = choices[a];

      for(let b = 0; b < row.length; b ++) {
        if (row[b]) {
          _result[a][b] = b;
        }
      }
    }

    // 递归
    let data = _.reduce(_result, function (last, current) {
      if (!last) {
        return current;
      }

      let _data = [];
      for(let i = 0; i < last.length; i ++) {
        if (last[i] < 0) {
          continue;
        }

        for(let k = 0; k < current.length; k ++) {
          if (current[k] < 0) {
            continue;
          }
          _data.push(last[i] + '' + current[k]);
        }
      }

      return _data;
    });

    let total = 0;
    for (let z = 0; z < data.length; z ++) {
      let codeArr  = _.split(data[z], '');

      // 判断是否合适
      let _codeArr = _.uniq(codeArr);
      if (codeArr.length != _.size(_codeArr)) {
        continue;
      }

      total ++;
    }

    data    = [];
    _result = [];

    return total;
  },

  // 猜前４单式
  PKQZX4_S(method, state) {
    return cc.calculateLTByIuput(method, 4, num => +num && +num >= 1 && +num <= 10, state);
  },

  // 猜第5
  PKQD5(method, state) {
    let n1;
    n1 = cc.calculateN(method, state)[0];
    return n1;
  },

  // 猜第5 单式
  PKQD5_S(method, state) {
    return cc.calculateLTByIuput(method, 1, num => +num && +num >= 1 && +num <= 10, state);
  },

  // 猜前5
  PKQZX5(method, state) {
    let choices     = state.choices;
    let _result     = [
      [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
      [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
      [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
      [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
      [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
    ];

    // 过滤
    for(let a = 0; a < choices.length; a ++) {
      let row = choices[a];

      for(let b = 0; b < row.length; b ++) {
        if (row[b]) {
          _result[a][b] = b;
        }
      }
    }

    // 递归
    let data = _.reduce(_result, function (last, current) {
      if (!last) {
        return current;
      }

      let _data = [];
      for(let i = 0; i < last.length; i ++) {
        if (last[i] < 0) {
          continue;
        }

        for(let k = 0; k < current.length; k ++) {
          if (current[k] < 0) {
            continue;
          }
          _data.push(last[i] + '' + current[k]);
        }
      }

      return _data;
    });

    let total = 0;
    for (let z = 0; z < data.length; z ++) {
      let codeArr  = _.split(data[z], '');

      // 判断是否合适
      let _codeArr = _.uniq(codeArr);
      if (codeArr.length != _.size(_codeArr)) {
        continue;
      }

      total ++;
    }

    data    = [];
    _result = [];
    return total;
  },

  // 猜前5单式
  PKQZX5_S(method, state) {
    return cc.calculateLTByIuput(method, 5, num => +num && +num >= 1 && +num <= 10, state);
  },

  // 定位胆
  PKDWD(method, state) {
    let n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, ref;
    // let n1, n2, n3, n4, n5, ref;
    //ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1], n3 = ref[2], n4 = ref[3], n5 = ref[4], n6 = ref[5], n7 = ref[6], n8 = ref[7], n9 = ref[8], n10 = ref[9];
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1], n3 = ref[2], n4 = ref[3], n5 = ref[4], n6 = ref[5], n7 = ref[6], n8 = ref[7], n9 = ref[8], n10 = ref[9];
    //return n1 + n2 + n3 + n4 + n5 + n6 + n7 + n8 + n9 + n10;
    return n1 + n2 + n3 + n4 + n5 + n6 + n7 + n8 + n9 + n10;
  },
  // 六合彩不中
  LHCBZ_5(method, state) {
    let n;
    n = cc.calculateN(method, state)[0];
    return cc.C(n, 5);
  },
  LHCBZ_6(method, state) {
    let n;
    n = cc.calculateN(method, state)[0];
    return cc.C(n, 6);
  },
  LHCBZ_7(method, state) {
    let n;
    n = cc.calculateN(method, state)[0];
    return cc.C(n, 7);
  },
  LHCBZ_8(method, state) {
    let n;
    n = cc.calculateN(method, state)[0];
    return cc.C(n, 8);
  },
  LHCBZ_9(method, state) {
    let n;
    n = cc.calculateN(method, state)[0];
    return cc.C(n, 9);
  },
  LHCBZ_10(method, state) {
    let n;
    n = cc.calculateN(method, state)[0];
    return cc.C(n, 10);
  },
  LHC_LX(method, state) {
    let n;
    n = cc.calculateN(method, state)[0];
    return cc.C(n, 6);
  },
  // PCDD
  TM(method, state) { return 1; },
  PCDDDXDS(method, state) { return 1; },
  BZ(method, state) { return 1; },
  BO(method, state) { return 1; },
  // 快乐十分
  KLSF_DT2Z2(method, state) {
    let n1, n2, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1];
    if (n1 < 1) {
      return 0;
    }
    return cc.C(n2, 2 - n1);
  },
  KLSF_DT3Z3(method, state) {
    let n1, n2, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1];
    if (n1 < 1) {
      return 0;
    }
    return cc.C(n2, 3 - n1);
  },
  KLSF_DT4Z4(method, state) {
    let n1, n2, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1];
    if (n1 < 1) {
      return 0;
    }
    return cc.C(n2, 4 - n1);
  },
  KLSF_DT5Z5(method, state) {
    let n1, n2, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1];
    if (n1 < 1) {
      return 0;
    }
    return cc.C(n2, 5 - n1);
  },
  // 三星 直选
  KLSF_Q_ZX3(method, state) {
    let A, AB, ABC, AC, B, BC, C, listA, listB, listC, ref, ref1, result;
    ref = cc.calculateN(method, state), A = ref[0], B = ref[1], C = ref[2];
    ref1 = cc.calculateNDetail(method, state), listA = ref1[0], listB = ref1[1], listC = ref1[2];
    BC = cc.N(listB, listC);
    AC = cc.N(listA, listC);
    AB = cc.N(listA, listB);
    ABC = cc.N(listA, listB, listC);
    result = A * B * C - A * BC - B * AC - C * AB + 2 * ABC;
    if (result > 0) {
      return result;
    } else {
      return 0;
    }
  },
  // 三星 直选
  KLSF_H_ZX3(method, state) {
    return this.KLSF_Q_ZX3(method, state);
  },
  KLSF_Q_ZU3(method, state) {
    let n;
    n = cc.calculateN(method, state)[0];
    return cc.C(n, 3);
  },
  KLSF_H_ZU3(method, state) {
    let n;
    n = cc.calculateN(method, state)[0];
    return cc.C(n, 3);
  },
  KLSF_Q_ZX2(method, state) {
    let A, AB, B, listA, listB, ref, ref1, result;
    ref = cc.calculateN(method, state), A = ref[0], B = ref[1];
    ref1 = cc.calculateNDetail(method, state), listA = ref1[0], listB = ref1[1];
    AB = cc.N(listA, listB);
    result = A * B - AB;
    if (result > 0) {
      return result;
    } else {
      return 0;
    }
  },
  KLSF_Q_ZU2(method, state) {
    let n;
    n = cc.calculateN(method, state)[0];
    return cc.C(n, 2);
  },
  KLSF_DXDS_D1(method, state) {
    let n1, n2, n3, n4, n5, ref;
    ref = cc.calculateN(method, state), n1 = ref[0], n2 = ref[1], n3 = ref[2], n4 = ref[3], n5 = ref[4];
    return n1 + n2 + n3 + n4 + n5;
  },
  KLSF_DXDS_D2(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_DXDS_D3(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_DXDS_D4(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_DXDS_D5(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_DXDS_D6(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_DXDS_D7(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_DXDS_D8(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_DXDS_DXH(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_SJFW_D1(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_SJFW_D2(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_SJFW_D3(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_SJFW_D4(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_SJFW_D5(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_SJFW_D6(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_SJFW_D7(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_SJFW_D8(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_WX_D1(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_WX_D2(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_WX_D3(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_WX_D4(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_WX_D5(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_WX_D6(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_WX_D7(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_WX_D8(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_LH_L(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_LH_H(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_DWD_D1(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_DWD_D2(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_DWD_D3(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_DWD_D4(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_DWD_D5(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_DWD_D6(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_DWD_D7(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_DWD_D8(method, state) {
    return this.KLSF_DXDS_D1(method, state);
  },
  KLSF_RX1Z1(method, state) {
    let n;
    n = cc.calculateN(method, state)[0];
    return cc.C(n, 1);
  },
  KLSF_RX2Z2(method, state) {
    let n;
    n = cc.calculateN(method, state)[0];
    return cc.C(n, 2);
  },
  KLSF_RX3Z3(method, state) {
    let n;
    n = cc.calculateN(method, state)[0];
    return cc.C(n, 3);
  },
  KLSF_RX4Z4(method, state) {
    let n;
    n = cc.calculateN(method, state)[0];
    return cc.C(n, 4);
  },
  KLSF_RX5Z5(method, state) {
    let n;
    n = cc.calculateN(method, state)[0];
    return cc.C(n, 5);
  },
}
