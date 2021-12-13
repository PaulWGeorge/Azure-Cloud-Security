#! /bin/bash

#I put -i for grep in case the user puts am instead of AM for example.

#single quotes on awk input and single quotes on time-AM/PM as well

grep -i "$1" $2_Dealer_schedule | awk '{print $1, $2, '$3', '$4'}'
