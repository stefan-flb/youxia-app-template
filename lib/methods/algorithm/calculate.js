export function C(arr, num) {
  let _results
  const r = []
  arr = (() => {
    _results = []
    for (let _i = 1; 0 <= arr ? _i <= arr : _i >= arr; 0 <= arr ? _i++ : _i--) {
      _results.push(_i)
    }
    return _results
  }).apply(this);
  (function f(t, a, n) {
    if (n == 0) return r.push(t)
    for (let i = 0, l = a.length; i <= l - n; i++) {
      f(t.concat(a[i]), a.slice(i + 1), n - 1)
    }
  })([], arr, num)
  return r.length;
}

export function Combine(arr, num) {
  const r = [];
  (function f(t, a, n) {
    if (n == 0) return r.push(t)
    for (let i = 0, l = a.length; i <= l - n; i++) {
      f(t.concat(a[i]), a.slice(i + 1), n - 1)
    }
  })([], arr, num)
  return r
}

export function N(a, b, c) {
  let i, item, j, len, len1, oldResult, result
  result = []
  for (i = 0, len = a.length; i < len; i++) {
    item = a[i]
    if (b.indexOf(item) >= 0) {
      result.push(item)
    }
  }
  if (c) {
    oldResult = result
    result = []
    for (j = 0, len1 = oldResult.length; j < len1; j++) {
      item = oldResult[j]
      if (c.indexOf(item) >= 0) {
        result.push(item)
      }
    }
  }
  return result.length
}

export function calculateN(method, state) {
  let arr, col, i, l, len, len1, o, ref, row, selectColNum
  arr = [0, 0, 0, 0, 0]
  ref = state.choices
  for (i = l = 0, len = ref.length; l < len; i = ++l) {
    row = ref[i] || []
    selectColNum = 0
    for (o = 0, len1 = row.length; o < len1; o++) {
      col = row[o]
      if (col) {
        selectColNum++
      }
    }
    arr[i] = selectColNum
  }
  return arr
}
export function calculateNDetail(method, state) {
  let arr, col, i, j, l, len, len1, o, ref, row, selectColNum
  arr = [[], [], [], [], []]
  ref = state.choices
  for (i = l = 0, len = ref.length; l < len; i = ++l) {
    row = ref[i] || []
    selectColNum = []
    for (j = o = 0, len1 = row.length; o < len1; j = ++o) {
      col = row[j]
      if (col) {
        selectColNum.push(j + 1)
      }
    }
    arr[i] = selectColNum
  }
  return arr
}
export function calculateMNH(method, state) {
  let col, h, i, item, l, len, len1, len2, m, n, o, q, ref, ref1, row, selectColNum, selected
  selected = []
  ref = state.choices
  for (l = 0, len = ref.length; l < len; l++) {
    row = ref[l] || []
    selectColNum = 0
    for (o = 0, len1 = row.length; o < len1; o++) {
      col = row[o]
      if (col) {
        selectColNum++
      }
    }
    selected.push(selectColNum)
  }
  n = m = selected[0]
  h = 0
  if (selected.length === 2) {
    n = selected[1]
    if (!state.choices[0]) state.choices[0] = []
    ref1 = state.choices[0]
    for (i = q = 0, len2 = ref1.length; q < len2; i = ++q) {
      item = ref1[i] || false
      if (item && state.choices[1][i]) {
        h++
      }
    }
  }
  return [m, n, h]
}
export function calculateByPosition(data, method, state) {
  var count, i, item, _i, _len, _ref
  count = 0
  _ref = state.choices[0] || []
  for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
    item = _ref[i]
    if (item && state.choices[0]) {
      count += data[i]
    }
  }
  return count
}
export function calculatePositionCnt(method, state) {
  let count, item, k, ref
  count = 0
  ref = state.__position
  for (k in ref) {
    item = ref[k]
    if (item) {
      count += 1
    }
  }
  return count
}
export function calculateByZuIuput(num, method, f, state) {
  let __codes, _c, _codes, _exists, c, codes, k, l, len, n, ref
  ref = calculateByIuput(num, method, f, state), n = ref[0], codes = ref[1]
  _codes = codes.split(',')
  _exists = {}
  __codes = []
  for (k = l = 0, len = _codes.length; l < len; k = ++l) {
    c = _codes[k]
    if (!(c !== '')) {
      continue
    }
    _c = c.split('').sort().join('')
    if (_exists[_c] === 1) {
      continue
    }
    _exists[_c] = 1
    __codes.push(c)
  }
  n = __codes.length
  return [n, __codes.join(',')]
}
export function calculateByIuput(num, method, f, state) {
  let arr, codes, count, input, item, l, len, reg
  input = state.input || ''
  input = input.replace(/\n/g, ',').replace(/[\s\r,;，； ]/g, ',').replace(/(\|)+/g, ',')
  input = input.replace(/０/g, '0').replace(/１/g, '1').replace(/２/g, '2').replace(/３/g, '3').replace(/４/g, '4').replace(/５/g, '5').replace(/６/g, '6').replace(/７/g, '7').replace(/８/g, '8').replace(/９/g, '9')
  f = f || (() => true)
  if (input) {
    arr = input.split(',')
    reg = new RegExp(`^[0-9]{${num}}$`)
    count = 0
    codes = []
    for (l = 0, len = arr.length; l < len; l++) {
      item = arr[l]
      if (!(reg.test(item) && f(item))) {
        continue
      }
      count++
      codes.push(item)
    }
    return [count, codes.join(',')]
  } else {
    return [0, '']
  }
}
export function calculateLTRXByIuput(method, num, f, state) {
  let _c, _codes, _exists, c, codes, k, l, len, n, ref
  ref = calculateLTByIuput(method, num, f, state), n = ref[0], codes = ref[1]
  _codes = codes.split(',')
  _exists = {}
  for (k = l = 0, len = _codes.length; l < len; k = ++l) {
    c = _codes[k]
    _c = c.split(' ').sort().join(' ')
    _exists[_c] = 1
  }
  return [n, Object.keys(_exists).join(',')]
}
export function calculateLTByIuput(method, num, f, state) {
  let arr, code, codes, count, i, input, item, item2, l, len, len1, numbers, o, p

  input = state.input || ''
  input = input.replace(/\n/g, ',').replace(/[\r,;，；]/g, ',').replace(/(\|)+/g, ',')
  input = input.replace(/０/g, '0').replace(/１/g, '1').replace(/２/g, '2').replace(/３/g, '3').replace(/４/g, '4').replace(/５/g, '5').replace(/６/g, '6').replace(/７/g, '7').replace(/８/g, '8').replace(/９/g, '9')
  f = f || (() => true)
  if (input) {
    arr = input.split(',')
    count = 0
    codes = []
    for (l = 0, len = arr.length; l < len; l++) {
      item = arr[l]
      numbers = Array.from(new Set(item.split(' ')))
      if (numbers.length === num) {
        p = false
        for (i = o = 0, len1 = numbers.length; o < len1; i = ++o) {
          item2 = numbers[i]

          item2 = parseInt(item2)
          if (!f(item2)) {
            p = true
          }
        }
        if (!p) {
          count++
          code = numbers.join(' ')
          codes.push(code)
        }
      }
    }
    return [count, codes.join(',')]
  } else {
    return [0, 0]
  }
}
