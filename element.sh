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
    ELEMENT_INFO=$($PSQL "SELECT * FROM elements LEFT JOIN properties USING(atomic_number) WHERE atomic_number=$ATOMIC_NUMBER")
    IFS="|"
    echo "$ELEMENT_INFO" | while read ATOMIC_ID SYMBOL NAME TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE_ID 
    do
      echo "The element with atomic number $ATOMIC_ID is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
  fi
else
  NAME=$($PSQL "SELECT name FROM elements WHERE name='$1' OR symbol='$1'")
  if [[ -z $NAME ]]
  then
    echo "I could not find that element in the database."
  else
    ELEMENT_INFO=$($PSQL "SELECT * FROM elements LEFT JOIN properties USING(atomic_number) WHERE name='$NAME' OR symbol='$NAME'")
    IFS="|"
    echo "$ELEMENT_INFO" | while read ATOMIC_ID SYMBOL NAME TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE_ID 
    do
      echo "The element with atomic number $ATOMIC_ID is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
  fi
fi