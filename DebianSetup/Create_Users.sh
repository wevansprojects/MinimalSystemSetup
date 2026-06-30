#!/bin/bash

$locked_users
$interactive_user
locked_users=$(sudo cat /etc/shadow |grep '!' |cut -d ':' -f1)
for luser in ${locked_users}; do
     interactive_user=$(grep "^$luser:" /etc/passwd |grep -E "bash" |cut -d":" -f 1)
     if [ -n  "$interactive_user" ]; then
            echo "User $interactive_user is LOCKED"
     fi
done

function New_User_Creation() {
new_user_list=("Sam.Anderson" "John.Walis" "debuser" "Tim.Cook" "Paul.Kennedy")

for name in "${new_user_list[@]}"
do	
   if [[ $name == $(cat /etc/passwd) ]]; then
       echo "$name is an active user no need to create them"
    else 
       echo "$name is not an active user creating new user"
fi    
done
}
#New_User_Creation
