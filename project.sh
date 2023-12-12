#!/bin/bash
<<hi
Name:Purandhar Murarisetty
Date:
Description:command line test
Sample input:
Sample output:
hi
menu="
1.sign up
2.sign in
3.exit"
echo "$menu"
touch username.csv pass.csv
ufile=username.csv
pfile=pass.csv
read -p "Enter the option : " op
case $op in
    1)#signup
        while true
        do
            read -p "Enter the username: " username
            if `grep -q "^$username$" $ufile` 
            then
                echo -e "\e[31mUsername is already taken,please try with new name\e[0m"
            else
                read -s -p "Enter the password: " password
                echo
                read -s -p "Confirm Password : " password1
                echo
                if [ $password = $password1 ]
                then
                    echo "$username" >> $ufile
                    echo "$password" >> $pfile
                    echo -e "\e[32mUsername and Password are created sucessfully\e[0m"
                    break
                else
                    echo -e "\e[31mPasswords doesnot match please enter again\e[0m"
                fi
            fi
        done;;
    2)#signin
        while true
        do
            read -p "Enter the username: " username
            read -s -p "Enter the password: :" pass
            echo
            if grep -q -n "^$username$" "$ufile"
            then
                a=$(grep -n "^$username$" "$ufile" | cut -d ":" -f1)
                c=$(sed -n "${a}p" "$pfile")
                if [ "$c" == "$pass" ]
                then
                    echo -e "\e[32mSignin successful\e[0m"
                    echo "1.Take test"
                    echo "2.Exit"
                    read -p"Enter the choice : " ch
                    case $ch in
                        1)#take test
                            echo -e "\e[92m                  ALL THE BEST $username     \e[0m"
                            for i in $(seq 5 5 50)
                            do
                                head -$i questionbank.txt|tail -5
                                for t in $(seq 10 -1 1)
                                do
                                    echo -ne "\e[94m\rEnter the option : $t \e[0m"
                                    read -t 1 op
                                    if [ -n "$op" ]
                                    then
                                        break
                                    else
                                        op=e
                                     fi
                                 done
                                 echo $op >> userans.txt
                                 echo
                             done                  
                             #result page
                             echo -e "\e[96m                 RESULT PAGE         \e[0m"
                             count=0
                             for i in $(seq 5 5 50)
                             do
                                 head -$i questionbank.txt|tail -5
                                 j=$((i/5))
                                 val1=$(sed -n "${j}p" "correctans.txt") 
                                 val2=$(sed -n "${j}p" "userans.txt")
                                 if [ "$val1" = "$val2" ]
                                 then
                                     echo -e "\e[32mCorrectanswer : $val1\e[0m"
                                     let count=$count+1
                                 elif [ "$val2" = e ]
                                 then
                                     echo -e "\e[93mTime out\e[0m"
                                     echo "Correct answer : $val1"
                                 else
                                     echo -e "\e[31mWorng answer\e[0m"
                                     echo "Your answer : $val2"
                                     echo "Correct answer : $val1"
                                 fi
                                 echo
                             done
                                 echo -e "\e[96mTotal marks: $count\e[0m";;

                        2)#exit
                            break;;
                        *)echo "Enter valid option";;
                    esac
                    

                    break
                else
                    echo -e "\e[91mUsername or Password is incorrect, Please try again.\e[0m"
                fi
            else
                echo -e "\e[91mUsername or Password is incorrect,please try again.\e[0m"
            fi
        done;;
    3)#exit
        while true
        do
            break
        done;;
    *)#default
        echo "Enter valid choice"
esac
: > "userans.txt"
