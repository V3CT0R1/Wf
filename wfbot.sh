#!/bin/bash
[ ! -f bot.lst ] && { touch bot.lst;}
ini()
{
echo "[+] Checking dependency !"
sleep 1
sud=$(who am i | awk '{print $1}')
[ ! -f /usr/bin/curl ] && { echo "[-] curl not found!"; read -p "[-] Press [ENTER] to exit!"; exit;} || { echo "[+] curl check OK!";}
sleep 1
[ ! -f /usr/bin/tmux ] && { echo "[-] tmux not found!"; read -p "[-] Press [ENTER] to exit!"; exit 1;} || { echo "[+] tmux check OK!";}
sleep 1
[ ! -f /usr/bin/python3 ] && { echo "[-] python3 not found!"; read -p "[-] Press [ENTER] to exit!"; exit 1;} || { echo "[+] python3 check OK!";}
sleep 1
clear
}
update()
{
mkdir tmp
cd tmp
git clone https://github.com/Levak/warfacebot
cd ..
cp -f tmp/warfacebot/cfg/server/* cfg/server/
rm -r -f tmp
Main
}
botchange()
{
botn="$1"
usn="$2"
pwd="$3"
sed -i "s/^\(login=\).*/\1\"${usn}\"/" ${botn}.sh
sed -i "s/^\(psswd=\).*/\1\"${pwd}\"/"  ${botn}.sh
./wb_restart
Main
}
botfrnd()
{
value="$1"
for line in $(tmux ls |  cut -d ":" -f 1)
do
 tmux send-keys -t $line  "add ${value}"  C-m >/dev/null
done
unset value
Main
}
botfrndcmd()
{
value="$1"
for line in $(tmux ls |  cut -d ":" -f 1)
do
 tmux send-keys -t $line  "add ${value}"  C-m >/dev/null
done
unset value
}
wbstat()
{
[[ ! -s bot.lst ]] && { echo "    No bot found to execute stats!" >stat;}
nick=$(head -n 1 bot.lst | cut -d ' ' -f2)
tmux send-keys -t ${nick}  "stats"  C-m >/dev/null
exit
}
wbwho()
{
[[ ! -s bot.lst ]] && { echo "    No bot found to execute stats!" >stat;}
nick=$(head -n 1 bot.lst | cut -d ' ' -f2)
tmux send-keys -t $nick  "whois ${1}"  C-m >/dev/null
unset $nick $1
exit
}
botlst()
{
[[ ! -s bot.lst ]] && { echo "    No bot found"; read -p "    Press [ENTER] to continue!" no ; Main;}
echo "     "
cat bot.lst
echo "       "
read -p "    Press any key to continue!" nothn
Main
}
botadd()
{
botn="$1"
usn="$2"
pwd="$3"
cp wb.sh ${botn}.sh
sed -i "s/^\(login=\).*/\1\"${usn}\"/" ${botn}.sh
sed -i "s/^\(psswd=\).*/\1\"${pwd}\"/"  ${botn}.sh
echo "tmux kill-session -t ${botn}" >> wb_restart
echo "tmux new -d -s ${botn}"  >> wb_restart
echo "tmux send-keys -t ${botn} \"while true; do ./${botn}.sh eu ;done\" C-m" >> wb_restart
chmod +x wb_restart
./wb_restart
Main
}
botrm()
{
botn="$1"
rm -f ${botn}.sh 
sed -i "/${botn}/d" wb_restart
tmux kill-session -t ${botn}
./wb_restart
Main
}
botaddc()
{ 
 while [ -z $botn ]
  do 
   while [[ -z $tmp ]]
    do
       read -p "    Enter Botname => " botn
       egrep "^$botn" bot.lst>/dev/null
    [ $? -eq 1 ] &&  tmp="2" 
       egrep "^$botn" bot.lst>/dev/null
    [ $? -eq 0 ] && { echo "    Name not allowed, Please enter new! ";}
    done
  done
 while [ -z $usn ]
  do
   read -p "    Enter email id => " usn
   done
 while [ -z $psswd ]
  do
  read -p "    Enter passowrd => " psswd
  done
  echo "    Checking credentials..."
res=$(curl -s \
            -A "Downloader/1940" \
            -d '<?xml version="1.0" encoding="UTF-8"?><Auth Username="'"${usn}"'" Password="'"${psswd}"'" ChannelId="'"35"'"/>' \
            'https://authdl.my.com/mygc.php?hint=Auth')
        echo "$res" | grep -- 'ErrorCode' >/dev/null
        [ $? -eq 0 ] && { echo "    Wrong Username/Password!"; read -p "    Press [ENTER] to continue..." ; Main;}
  echo " $botn    $usn    $psswd ">>bot.lst
  botadd $botn $usn $psswd
}
botchangec()
{
while [ -z $botn ]
  do 
   while [[ -z $tmp ]]
    do
       read -p "    Enter Botname => " botn
       egrep "$botn" bot.lst>/dev/null
    [ $? -eq 0 ] &&  tmp="2" 
       egrep "$botn" bot.lst>/dev/null
    [ $? -eq 1 ] && { echo "    Bot not found with name $botn "; read -p "    Press [ENTER] continue!" non ; Main;}
    done
  done
   while [ -z $usn ]
  do
   read -p "    Enter new email id => " usn
   done
 while [ -z $psswd ]
  do
  read -p "    Enter new passowrd => " psswd
  done
  echo "    Checking credentials..."
res=$(curl -s \
            -A "Downloader/1940" \
            -d '<?xml version="1.0" encoding="UTF-8"?><Auth Username="'"${usn}"'" Password="'"${pwd}"'" ChannelId="'"35"'"/>' \
            'https://authdl.my.com/mygc.php?hint=Auth')
        echo "$res" | grep -- 'ErrorCode' >/dev/null
        [ $? -eq 0 ] && { echo "    Wrong Username/Password!"; read -p "    Press [ENTER] to continue..." ; Main;}
  sed -i "/${botn}/c\ ${botn}    ${usn}    ${psswd}" bot.lst
  botchange $botn $usn $psswd
}
botrmc()
{
while [ -z $botn ]
  do 
   while [[ -z $tmp ]]
    do
       read -p "    Enter Botname => " botn
       egrep "$botn" bot.lst>/dev/null
    [ $? -eq 0 ] &&  tmp="2" 
       egrep "$botn" bot.lst>/dev/null
    [ $? -eq 1 ] && { echo "    Bot not found with name $botn "; read -p "    Press [ENTER] to continue!" nan; Main ;}
    done
  done
  sed -i "/${botn}/d" bot.lst
  botrm $botn
}
botfrndc()
{
while [ -z $name ]
do
read -p "Enter warface player nickname => " name
done
botfrnd $name
}
Main()
{
unset botn
unset tmp
unset usn
unset psswd
clear
echo "  ==========================================  "
echo "             Warfacebot Tool              "
echo "    => Created/Moded By Envy              "
echo "    => Orginal base code created by Levak "
echo "    => Contact Discord Envy#4508          "
echo "  ==========================================  "
echo "    1. LIST INSTALLED BOTS                " 
echo "    2. SEND FRIEND REQUEST FROM BOT       "
echo "    3. ADD BOT                            "
echo "    4. REMOVE BOT                         "
echo "    5. CHANGE BOT USERNAME/PASSWORD       "
echo "    6. TURN-OFF BOTS                      "
echo "    7. RESTART BOTS                       "
echo "    8. UPDATE (USE AFTER GAME UPDATE ONLY)"
echo "    9. SET DISCORDBOT SECRET              "
echo "   10. RESTART DISCORDBOT                 "
echo "   11. TURN-OFF DISCORDBOT                "
echo "   12. EXIT                               "
echo "  ==========================================  "
red=13
while [[  $red -gt 12 ]]
do
read -p "    Enter your choice here == > " red
[[  $red -gt 9 ]] && { echo "    please enter valid choice "; }
[ -z $red ] && { echo "    Bad choice!"; Main ; } 
done

case $red in
 "1")
 botlst
 ;;
 "2")
 botfrndc
 ;;
 "3")
 botaddc
 ;;
 "4")
 botrmc
 ;;
 "5")
 botchangec
 ;;
 "6")
 pkill -f tmux>/dev/null ; Main;
 ;;
 "7")
 ./wb_restart>/dev/null ; Main; 
 ;;
 "8")
 update
 ;;
 "9")
 while [ -z $skey ]
  do 
       read -p "    Enter Discord App Secret => " skey
  done
  echo "${skey}" > disc.cfg
  unset skey
  Main
 ;;
 "10")
  tmux kill-session -t discbot
  tmux new -d -s discbot
  tmux send-keys -t discbot "python3 wbd.py" C-m
  clear
  Main
 ;;
 "11")
  tmux kill-session -t discbot
  clear 
  Main
 ;;
 "12")
 clear; exit;
 ;;
 esac
}
[ $# -lt 1 ] && { ini ;}
case $1 in
 "add")
 botfrndcmd $2
 ;;
 "stat")
 wbstat 
 ;;
 "whois")
 wbwho $2
 ;;
 esac
[ $# -lt 1 ] && { Main; }
