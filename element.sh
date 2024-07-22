#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
elif [[ $1 =~ ^[0-9]+$ ]]
then
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
  if [[ -z $ATOMIC_NUMBER ]]
  then
    echo "I could not find that element in the database."
  else
    echo "The element with atomic number $ATOMIC_NUMBER"
  fi
else
  NAME=$($PSQL "SELECT name FROM elements WHERE name='$1' OR symbol='$1'")
  if [[ -z $NAME ]]
  then
    echo "I could not find that element in the database."
  else
    echo "The element with name '$NAME'"
  fi
fi