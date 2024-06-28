#!/bin/bash

#Date Created  18/05/2024
#Date Modified 18/05/2024
#Author: Omar AbdelWahab
#E-mail: omarabdelwahabmb@gmail.com

#Description:
#User Management Script

print_choices() {
    echo -e "User Management Menu:
1. Add User
2. Remove User
3. Update password for current user
4. List all users and count them
5. Quit";
}

add_user() {
    read -p "Please, enter username to add: " username;
    sudo useradd "$username";
    
    if [ $? -eq 0 ]; then
        echo "User $username has been added successfully";
    else
        echo "An Error happened while trying to add the user.";
    fi
    
    read -p "Press Enter to Continue...";
}
remove_user() {
    read -p "Please, enter username to remove: " username;
    sudo userdel "$username";
    
    if [ $? -eq 0 ]; then
        echo "User $username has been removed successfully";
    else
        echo "An Error happened while trying to remove the user.";
    fi
    
    read -p "Press Enter to Continue...";
}
update_pass() {
    read -p "Please, enter username to change his password: " username;
    sudo passwd "$username";
    
    if [ $? -eq 0 ]; then
        echo "Password for user $username has been changed successfully";
    else
        echo "An Error happened while trying to change password the user: $username.";
    fi
    
    read -p "Press Enter to Continue...";

}
list_users() {
    echo "Here is a list of the users:";
    cut -d: -f1,3 /etc/passwd | grep -E ':[0-9]{4,5}$' | cut -d: -f1 | grep -v nobody;
    total=$(cut -d: -f1,3 /etc/passwd | grep -E ':[0-9]{4,5}$' | cut -d: -f1 | grep -v nobody | wc -l);
    echo -e "\nTotal number of users = $total";
    read -p "Press Enter to Continue...";

#    readarray -t users < <(cut -d: -f1,3 /etc/passwd | grep -E ':[0-9]{4,5}$' | cut -d: -f1 | grep -v nobody)
#
#    for user in "${users[@]}"; do
#        echo "$user";
#    done
#
#    echo -e "\nTotal number of users = ${#users[@]}"
#
#    read -p "Press Enter to Continue...";
}
quit () {
    echo -e "Exiting...";
    exit 0;
}
wrong () {
    echo "Wrong Choice!";
    read -p "Please, press Enter to try again...";
}

while [ true ]; do
   clear;
   print_choices;
   read -p "Enter your choice (1-5): " choice;
   case "$choice" in
       1) add_user;;
       2) remove_user;;
       3) update_pass;;
       4) list_users;;
       5) quit;;
       *) wrong;;
   esac
done
