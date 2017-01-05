#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

input_hpp=mtlpp.hpp
output_hpp=../mtlpp.hpp
input_mm=*.mm
output_mm=../mtlpp.mm

cd ../src/

solve ()
{
  local out=$1
  local in=$2

  files+=($in)

  incls=$(awk -F '"' '/#include \"/{print $2}' $in)

  for incl in $incls
  do
    if ! [[ " ${files[@]} " == *" $incl "* ]]; then
      solve $out $incl
    fi
  done

  echo "//////////////////////////////////////" >> $out
  echo "// FILE: $in" >> $out
  echo "//////////////////////////////////////" >> $out

  awk '/(#include \")|(#pragma)/{print "// " $0} !/(#include\ ")|(#pragma)/{print $0}' $in >> $out

  echo "" >> $out
}

files=()

# mtlpp.hpp
echo "/*" > $output_hpp
echo " * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved." >> $output_hpp
echo " * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE" >> $output_hpp
echo " */" >> $output_hpp
echo "" >> $output_hpp
echo "#pragma once" >> $output_hpp
echo "" >> $output_hpp
solve $output_hpp $input_hpp

# mtlpp.mm
echo "/*" > $output_mm
echo " * Copyright 2016-2017 Nikolay Aleksiev. All rights reserved." >> $output_mm
echo " * License: https://github.com/naleksiev/mtlpp/blob/master/LICENSE" >> $output_mm
echo " */" >> $output_mm
echo "#include \"mtlpp.hpp\"" >> $output_mm
echo "" >> $output_mm
for input in $input_mm
do
  echo "//////////////////////////////////////" >> $output_mm
  echo "// FILE: $input" >> $output_mm
  echo "//////////////////////////////////////" >> $output_mm
  awk '/(#include \")/{print "// " $0} !/(#include\ ")|(#pragma)/{print $0}' $input >> $output_mm
  echo "" >> $output_mm
done
#cat $input_mm >> $output_mm

cd - > /dev/null

