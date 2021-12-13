#! /bin/bash

#I put -i for grep in case the user puts am instead of AM for example.

grep -i "$1" $2_Dealer_schedule | awk '{print $1, $2, $5, $6}'
