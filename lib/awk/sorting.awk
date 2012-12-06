function selSort(keyArr,outArr,   swap,thisIdx,minIdx,cmpIdx,numElts) {
  for (thisIdx in keyArr) {
      outArr[++numElts] = thisIdx
  }
  for (thisIdx=1; thisIdx<=numElts; thisIdx++) {
      minIdx = thisIdx
      for (cmpIdx=thisIdx + 1; cmpIdx <= numElts; cmpIdx++) {
          if (keyArr[outArr[minIdx]] > keyArr[outArr[cmpIdx]]) {
              minIdx = cmpIdx
          }
      }
      if (thisIdx != minIdx) {
          swap = outArr[thisIdx]
          outArr[thisIdx] = outArr[minIdx]
          outArr[minIdx] = swap
      }
  }
  return numElts+0
}

function keySort(keyArr,outArr,   \
                occArr,thisIdx,thisKey,cmpIdx,outIdx,numElts) {
  for (thisIdx in keyArr) {
      thisKey = keyArr[thisIdx]
      outIdx=++occArr[thisKey]  # start at 1 plus num occurrences
      for (cmpIdx in keyArr) {
          if (thisKey > keyArr[cmpIdx]) {
              outIdx++
          }
      }
      outArr[outIdx] = thisIdx
      numElts++
  }
  return numElts+0
}

function genSort(sortAlg,sortType,inArr,outArr,fldNum,fldSep,           \
              keyArr,thisIdx,thisArr) {
  if (fldNum) {
      if (sortType == "n") {
          for (thisIdx in inArr) {
              split(inArr[thisIdx],thisArr,fldSep)
              keyArr[thisIdx] = thisArr[fldNum]+0
          }
      } else {
          for (thisIdx in inArr) {
              split(inArr[thisIdx],thisArr,fldSep)
              keyArr[thisIdx] = thisArr[fldNum]""
          }
      }
  } else {
      if (sortType == "n") {
          for (thisIdx in inArr) {
              keyArr[thisIdx] = inArr[thisIdx]+0
          }
      } else {
          for (thisIdx in inArr) {
              keyArr[thisIdx] = inArr[thisIdx]""
          }
      }
  }
  if (sortAlg ~ /^sel/) {
      numElts = selSort(keyArr,outArr)
  } else {
      numElts = keySort(keyArr,outArr)
  }
  return numElts
}

# Main Loop - read all input lines, store in memory
{ inArr[NR]=$0 }

# End of input - sort the lines
END {
  numElts = genSort(sortAlg,sortType,inArr,outArr,fldNum,FS)
  for (outIdx=1;outIdx<=numElts;outIdx++) {
      print inArr[outArr[outIdx]]
  }
}
