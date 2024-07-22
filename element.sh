#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
elif [[ $1 =~ ^[0-9]+$ ]]
then
  echo "It's a number"
elif [[ ! $1 =~ ^[0-9]+$ ]]
then
  echo "It's a string"
else
  echo I could not find that element in the database.
fi