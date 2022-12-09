#!/bin/bash

if [ ! -f accounts ]
then
touch accounts
fi

echo "
	________________________________________________________"
echo "	|                              			   	|
	|              	WELCOME to DIU BANK          		|
	|                                              		|
	|          Make banking Easy & Pleasant!                |
	|                                              		|
	|_______________________________________________________|"

while [ 1 ]
do
echo -e "\n\n\n-->>  Press '1' for Sign Up \n"
echo  "-->>  Have an Existing Account ?"
echo -e "    	Press '2' for Log In \n"
echo -e "-->>  Press '3' View all Account Info \n"
echo -e "-->>  Press '4' Update an User Account \n"
echo -e "-->>  Press '5' Delete an Account \n"
echo -e "-->>  Press '6' for Exit Bank \n"
read -p "    	Your Choice is: " c1
clear

case $c1 in
1) #Sign Up Panel
read -p "Enter an ID Number: " uid
while ! [[ $uid =~ [0-9]+$ ]]
do
echo -e "\nInvalid ID Number! Please Try Again\n"
read -p "Enter an ID Number: " uid
done
common=`grep -c "$uid" accounts`
if [ $common -eq 1 ]
then
echo -e "\nAn User Account is already Existing on this ID!\n"
echo -e "  Please Enter an Unique ID.\n"
read -p "Enter an ID Number: " uid
fi

user_information () {
read -p "Enter First Name: " fn1  
while [[ "$fn1" =~ [^a-zA-Z] || -z "$fn1" ]]
do
echo -e "\nInvalid Type of Name! Please Try Again.\n"
read -p "Enter First Name: " fn1  
done

read -p "Enter Last Name: " ln1  
while [[ "$ln1" =~ [^a-zA-Z] || -z "$ln1" ]]
do
echo -e "\nInvalid Type of Name! Please Try Again.\n"
read -p "Enter Last Name: " ln1  
done

read -p "Enter an Unique User Name (7-8 char): " ac1
common1=`grep -c "$ac1" accounts`
if [ $common1 -eq 1 ]
then
echo -e "\nThis Account Name is already Existing!\n"
echo -e "  Please Enter an Unique Account Name\n"
read -p "Enter an Unique Account Name (7-8 char): " ac1
fi

read -p "Enter Your Email Adress: " em1
while [[ ${em1} != *"@"* || -z $em1 ]]
do
echo -e "\nInvalid Email Adress! Please enter an Email Adress containing '@' \n"
read -p "Enter Your Email Adress: " em1
done
common2=`grep -c "$em1" accounts`
if [ $common2 -eq 1 ]
then
echo -e "\nInvalid Email Adress! Please Try Again\n"
read -p "Enter Your Email Adress: " em1
fi

read -p "Enter National ID or Passport Number: " nid
while ! [[ $nid =~ [0-9]+$ ]]
do
echo -e "\nInvalid National ID or Passport Number! Please Try Again\n"
read -p "Enter Your National ID or Passport Number: " nid
done
common3=`grep -c "$nid" accounts`
if [ $common3 -eq 1 ]
then
echo -e "\nNational ID or Passport Number! Please Try Again\n"
read -p "Enter Your National ID or Passport Number: " nid
echo ""
fi

read -p "Enter Your Phone Number: " phn1
while ! [[ $phn1 =~ [0-9]+$ ]]
do
echo -e "\nInvalid Phone Number! Please Try Again\n"
read -p "Enter Your Phone Number: " phn1
done
common3=`grep -c "$phn1" accounts`
if [ $common3 -eq 1 ]
then
echo -e "\nInvalid Phone Number! Please Try Again\n"
read -p "Enter Your Phone Number: " phn1
fi

user_password () {
read -p "Enter a Password: "  	acp1
read -p "Confirm Your Password: " acp2
}

password_check () {
echo -e "\nPassword Doesn't matched! Please Try Again\n"
user_password
}

user_password
if [ $acp1 != $acp2 ]
then
password_check
fi

echo -e "\nWhat Kind of Account, You want to Sign Up?\n"
echo -e "-->>  1. Current Account"
echo -e "           	or     	"
echo -e "-->>  2. Savings Account"
echo -e "\nYour Choice is - "
read acc_type

case $acc_type in
1)
acc_type="Current"
;;
2)
acc_type="Savings"
;;
*)
echo -e "\nInvalid Entry\n"
read -p acc_type
;;
esac

read -p "Enter The Amount of Depositing Money(Taka): " money1
while ! [[ $money1 =~ [0-9]+$ ]]
do
echo -e "\nPlease Give us an Valid Amount!\n"
read -p "Enter The Amount of Depositing Money(Taka): " money1
done
}

user_information

clear
echo -e "\n          	_ _ _ _Signed Up Successfull!_ _ _ _      	"
echo ""

echo " $uid|$ac1|$fn1|$ln1|$em1|$nid|$phn1|$acc_type|$money1 Tk. " | cat >> accounts

echo -e "\n______ID - $uid info______\n"
echo -e "User Name   	: $ac1"
echo -e "First Name  	: $fn1"
echo -e "Last Name   	: $ln1"
echo -e "Email Adress	: $em1"
echo -e "National ID 	: $nid"
echo -e "Phone Number	: $phn1"
echo -e "Type of Account : $acc_type"
echo -e "Current Balance : $money1"


while [ 1 ]
do
echo -e "\n\n_____You Are Welcome To Do_____\n"
echo -e "-->>  1. Add Money "
echo -e "-->>  2. Withdraw Money "
echo -e "-->>  3. Send Money "
echo -e "-->>  4. Sign Out & Exit \n"
read -p "	Your Choice is: " c2

clear




case $c2 in
1) #ADD MONEY
read -p "Enter your User ID: " id
echo ""
search1=`grep -c -i "$id" accounts`
if [ $search1 -eq 0 ]
then
echo " No Such User exist in the Bank! "
else

grep -v "$id" accounts > temp
mv temp accounts #save other acc

read -p "Enter your Current Balance: " m1  
while ! [[ $m1 =~ [0-9]+$ ]]
do
echo -e "\nPlease Give us an Valid Amount!\n"
read -p "Enter your Current Balance: " m1  
done
if [ $m1 != $money1 ]
then
echo -e "\nInappropriate Balance! Try again."
read -p "Enter your Current Balance: " m1  
else

echo ""
read -p "Enter an Amount to Add: " m2  
while ! [[ $m1 =~ [0-9]+$ ]]
do
echo -e "\nPlease Give us an Valid Amount!\n"
read -p "Enter an Amount to Add: " m2  
done

addedbalance=$(( $m1 + $m2 ))
echo " $id|$ac1|$fn1|$ln1|$em1|$nid|$phn1|$acc_type|$addedbalance Tk. " | cat >> accounts
fi

echo -e "\n\n$m2 Tk. Added Successfully!"
echo -e "\nYour New Balance is: $addedbalance Tk."
fi
;;



2) #withdraw
read -p "Enter your User ID: " id2
echo ""
search2=` grep -c -i "$id2" accounts `
if [ $search2 -eq 0 ]
then
echo " No Such User exist in the Bank! "
else

grep -v "$id2" accounts > temp
mv temp accounts #save other acc

read -p "Enter your Current Balance: " m3  
while ! [[ $m3 =~ [0-9]+$ ]]
do
echo -e "\nPlease Give us an Valid Amount!\n"
read -p "Enter your Current Balance: " m3  
done

read -p "Enter an Amount to Withdraw: " m4  
while ! [[ $m4 =~ [0-9]+$ ]]
do
echo -e "\nPlease Give us an Valid Amount!\n"
read -p "Enter an Amount to Withdraw: " m4  
done

new_balance2=$(( $m3 - $m4 ))
echo " $id2|$ac1|$fn1|$ln1|$em1|$nid|$phn1|$acc_type|$new_balance2 Tk. " | cat >> accounts

echo -e "\n\n$m4 Tk. Withdrawn Successfully!"
echo -e "\nYour New Balance is: $new_balance2 Tk."
fi
;;




3) #TRANSACTION
read -p "Enter Your User ID: " s1  
echo ""
commonS=`grep -c -i "$s1" accounts`
if [ $commonS -eq 0 ]
then
echo " No Such User exist in the Bank! "
fi

grep -v "$s1" accounts > temp
mv temp accounts #save other acc

read -p "Enter your Current Balance: " m5  
while ! [[ $m5 =~ [0-9]+$ ]]
do
echo -e "\nPlease Give us an Valid Amount!\n"
read -p "Enter your Current Balance: " m5  
done

read -p "Enter an Amount You want to Send: " m6
while ! [[ $m6 =~ [0-9]+$ ]]
do
echo -e "\nPlease Give us an Valid Amount!\n"
read -p "Enter an Amount You want to Send: " m6  
done
if [ $m6 -gt $m5 ]
then
echo -e "\nInappropriate Amount! You don't have that sufficiant balance."
read -p "Enter an Amount You want to Send: " m6  
fi

new_balance3=$(( $m5 - $m6 ))



read -p "Enter Reciver User ID: " r1  
echo ""
commonR=`grep -c -i "$r1" accounts`
if [ $commonR -eq 0 ]
then
echo " No Such User exist in the Bank! "
fi
grep -v "$r1" accounts > temp
mv temp accounts #save other acc

read -p "Enter Reciver's Current Balance: " m7  
while ! [[ $m5 =~ [0-9]+$ ]]
do
echo -e "\nPlease Give us an Valid Amount!\n"
read -p "Enter Reciver's Current Balance: " m7  
done

new_balance4=$(( $m7 + $m6 ))
echo " $r1|$new_balance4 Tk. " | cat >> accounts
echo " $s1|$ac1|$fn1|$ln1|$em1|$nid|$phn1|$acc_type|$new_balance3 Tk. " | cat >> accounts


echo -e "\n\n$m6 Tk. Send Successfully from User ID - $s1 to ID - $r1 account.\n"
echo -e "\n\nSender New Balance is: $new_balance3"
echo -e "\nReciver New Balance is: $new_balance4"

;;




4)
echo "                	Thank You for using DIU BANK     	"
echo "                      Come Back Anytime            	"
exit
;;



*)
echo -e "\nInvalid Entry\n"
;;
esac
done
;;




2)#Log in Panel
read -p "Enter your User ID: " uid2
read -p "Enter Your User Name: " n1
read -p "Enter Your Password: " p1
echo ""
clear

common7=` grep -c "$uid2" accounts`
if [ $common7 -eq 0 ]
then
echo -e "\n  No Such User exist in the Bank! "
echo -e "  Please Enter Correct User ID.\n"
else


while [ 1 ]
do
echo -e "\n\n_____You Are Welcome To Do_____\n"
echo -e "-->>  1. Add Money "
echo -e "-->>  2. Withdraw Money "
echo -e "-->>  3. Send Money "
echo -e "-->>  4. Sign Out & Exit \n"
read -p "	Your Choice is: " c2

clear




case $c2 in
1) #ADD MONEY
read -p "Enter your User ID: " id
echo ""
search1=`grep -c -i "$id" accounts`
if [ $search1 -eq 0 ]
then
echo " No Such User exist in the Bank! "
else

grep -v "$id" accounts > temp
mv temp accounts #save other acc

read -p "Enter your Current Balance: " m1  
while ! [[ $m1 =~ [0-9]+$ ]]
do
echo -e "\nPlease Give us an Valid Amount!\n"
read -p "Enter your Current Balance: " m1  
done
if [ $m1 != $money1 ]
then
echo -e "\nInappropriate Balance! Try again."
read -p "Enter your Current Balance: " m1  
else

echo ""
read -p "Enter an Amount to Add: " m2  
while ! [[ $m1 =~ [0-9]+$ ]]
do
echo -e "\nPlease Give us an Valid Amount!\n"
read -p "Enter an Amount to Add: " m2  
done

addedbalance=$(( $m1 + $m2 ))
echo " $id|$ac1|$fn1|$ln1|$em1|$nid|$phn1|$acc_type|$addedbalance Tk. " | cat >> accounts
fi


echo -e "\n\n$m2 Tk. Added Successfully!"
echo -e "\nYour New Balance is: $addedbalance Tk."
fi
;;



2) #withdraw
read -p "Enter your User ID: " id2
echo ""
search2=` grep -c -i "$id2" accounts `
if [ $search2 -eq 0 ]
then
echo " No Such User exist in the Bank! "
else

grep -v "$id2" accounts > temp
mv temp accounts #save other acc

read -p "Enter your Current Balance: " m3  
while ! [[ $m3 =~ [0-9]+$ ]]
do
echo -e "\nPlease Give us an Valid Amount!\n"
read -p "Enter your Current Balance: " m3  
done

read -p "Enter an Amount to Withdraw: " m4  
while ! [[ $m4 =~ [0-9]+$ ]]
do
echo -e "\nPlease Give us an Valid Amount!\n"
read -p "Enter an Amount to Withdraw: " m4  
done

new_balance2=$(( $m3 - $m4 ))
echo " $id2|$ac1|$fn1|$ln1|$em1|$nid|$phn1|$acc_type|$new_balance2 Tk. " | cat >> accounts

echo -e "\n\n$m4 Tk. Withdrawn Successfully!"
echo -e "\nYour New Balance is: $new_balance2 Tk."
fi
;;



3) #TRANSACTION
read -p "Enter Your User ID: " s1  
echo ""
commonS=`grep -c -i "$s1" accounts`
if [ $commonS -eq 0 ]
then
echo " No Such User exist in the Bank! "
fi

grep -v "$s1" accounts > temp
mv temp accounts #save other acc

read -p "Enter your Current Balance: " m5  
while ! [[ $m5 =~ [0-9]+$ ]]
do
echo -e "\nPlease Give us an Valid Amount!\n"
read -p "Enter your Current Balance: " m5  
done

read -p "Enter an Amount You want to Send: " m6
while ! [[ $m6 =~ [0-9]+$ ]]
do
echo -e "\nPlease Give us an Valid Amount!\n"
read -p "Enter an Amount You want to Send: " m6  
done
if [ $m6 -gt $m5 ]
then
echo -e "\nInappropriate Amount! You don't have that sufficiant balance."
read -p "Enter an Amount You want to Send: " m6  
fi

new_balance3=$(( $m5 - $m6 ))



read -p "Enter Reciver User ID: " r1  
echo ""
commonR=`grep -c -i "$r1" accounts`
if [ $commonR -eq 0 ]
then
echo " No Such User exist in the Bank! "
fi
grep -v "$r1" accounts > temp
mv temp accounts #save other acc

read -p "Enter Reciver's Current Balance: " m7  
while ! [[ $m5 =~ [0-9]+$ ]]
do
echo -e "\nPlease Give us an Valid Amount!\n"
read -p "Enter Reciver's Current Balance: " m7  
done

new_balance4=$(( $m7 + $m6 ))
echo " $r1|$new_balance4 Tk. " | cat >> accounts
echo " $s1|$ac1|$fn1|$ln1|$em1|$nid|$phn1|$acc_type|$new_balance3 Tk. " | cat >> accounts


echo -e "\n\n$m6 Tk. Send Successfully from User ID - $s1 to ID - $r1 account.\n"
echo -e "\n\nSender New Balance is: $new_balance3"
echo -e "\nReciver New Balance is: $new_balance4"

;;




4)
echo "                	Thank You for using DIU BANK     	"
echo "                       Come Back Anytime            	"
exit
;;



*)
echo -e "\nInvalid Entry\n"
;;
esac
done
fi
;;




3)
cat accounts
;;




4)
read -p "Enter User ID to Update: " uid9
echo ""
clear

common9=` grep -c "$uid9" accounts`
if [ $common9 -eq 0 ]
then
echo -e "\n  No Such User exist in the Bank! "
echo -e "  Please Enter Correct User ID.\n"
else
grep -v "$uid9" accounts > temp
mv temp accounts

user_information

echo " $uid9|$ac1|$fn1|$ln1|$em1|$nid|$phn1|$acc_type|$money1 Tk. " | cat >> accounts

echo -e "\n  Account of User ID - $uid9 has been Updated successfully! "
fi
;;





5)
read -p "Enter User ID to Delete: " uid6
echo ""
clear

common8=` grep -c "$uid6" accounts`
if [ $common8 -eq 0 ]
then
echo -e "\n  No Such User exist in the Bank! "
echo -e "  Please Enter Correct User ID.\n"
else
grep -v "$uid6" accounts > temp
mv temp accounts
echo -e "\n  Account of User ID - $uid6 has been Deleted successfully from the Bank! "
fi
;;





6)
echo "                	Thank You for using DIU BANK     	"
echo "                       Come Back Anytime            	"
exit
;;

*)
echo -e "\nInvalid Entry\n"
;;
esac

done


