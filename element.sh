#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"
SYMBOL=$1



if [[ -z $SYMBOL ]]
then
  echo "Please provide an element as an argument."
else
  if [[ ! $SYMBOL =~ ^[0-9]+$ ]]
  then  
    FIND_ELEMENT=$($PSQL "SELECT * FROM elements WHERE symbol='$SYMBOL' OR name='$SYMBOL';")
    if [[ -z $FIND_ELEMENT ]]
    then
      echo "I could not find that element in the database."
    else
      DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE symbol='$SYMBOL' OR name='$SYMBOL';")
      echo "$DATA" | while read BAR BAR NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELTING BAR BOILING BAR TYPE 
      do
        echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
    fi
  else
    FIND_ATOMIC_NUMBER=$($PSQL "SELECT * FROM elements WHERE atomic_number=$SYMBOL;")
    if [[ -z $FIND_ATOMIC_NUMBER ]]
    then
      echo "I could not find that element in the database."
    else
      DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE atomic_number=$SYMBOL;")
      echo "$DATA" | while read BAR BAR NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELTING BAR BOILING BAR TYPE 
      do
        echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
    fi 
  fi
fi
  
