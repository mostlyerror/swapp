export function classNames(...classes) {
  return classes.filter(Boolean).join(' ')
}

export function getDaysArray(start, end) {
  for (
    var arr = [], dt = new Date(start);
    dt <= end;
    dt.setDate(dt.getDate() + 1)
  ) {
    arr.push(new Date(dt))
  }
  return arr
}
