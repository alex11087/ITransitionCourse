#!/bin/bash

RANDOM=$$       # Инициализация генератора случайных чисел числом PID процесса-сценария.

PIPS=6          # Кубик имеет 6 граней.
MAXTHROWS=700   # Можете увеличить, если не знаете куда девать свое время.
throw=0         # Счетчик бросков.

zeroes=0        # Обнулить счетчики выпадения отдельных граней.
ones=0          # т.к. неинициализированные переменные - "пустые", и не равны нулю!.
twos=0
threes=0
fours=0
fives=0
sixes=0

print_result ()
{
echo
echo "единиц   =   $ones"
echo "двоек    =   $twos"
echo "троек    =   $threes"
echo "четверок =   $fours"
echo "пятерок  =   $fives"
echo "шестерок =   $sixes"
echo
}

update_count()
{
case "$1" in
  0) let "ones += 1";;   # 0 соответствует грани "1".
  1) let "twos += 1";;   # 1 соответствует грани "2", и так далее
  2) let "threes += 1";;
  3) let "fours += 1";;
  4) let "fives += 1";;
  5) let "sixes += 1";;
esac
}

echo

while [ "$throw" -lt "$MAXTHROWS" ]
do
  let "die1 = RANDOM % $PIPS"
  update_count $die1
  let "throw += 1"
done

print_result
exit 0
