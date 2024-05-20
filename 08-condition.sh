#!/bin/bash
Number= echo "enter the value:"
read Number
if [ $Number -gt 100 ]
then
     echo "the value $Number is greater than 100" # commands to execute if condition is true
else
     echo "the value $Number is less than 100"  # commands to execute if condition is false
fi