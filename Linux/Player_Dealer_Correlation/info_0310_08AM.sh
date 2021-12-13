#!/bin/bash
grep '8:00:00 AM' 0310_Dealer_schedule  | awk '{print $1, $2, $5, $6}'
