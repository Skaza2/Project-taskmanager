#!/bin/bash
function tabulka() 
{
radek="______________________________________________________________________________________________________________________"

# Hlavicka task listu
printf "%-4s | %-30s | %-10s | %-12s | %-12s | %-50s\n" \
    "ID" "Nazev" "Priorita" "Termin" "Status" "Popis"
printf "%s\n" "$radek"

# Cez všetky task súbory v ciselnom poradi
for file in $(ls $HOME/taskmanager/data/*.txt | sort -V); do
    unset name priority due_date status description
    source "$file"

    id=$(basename "$file" .txt)

    printf "%-4s | %-30s | %-10s | %-12s | %-12s | %-50s\n" \
        "$id" "$name" "$priority" "$due_date" "$status" "$description"
done

printf "%s\n" "$radek"

}

function moznosti_tabulky() 
{
# Vypíšeme možnosti pro další práci s taskmanažerem
radek="______________________________________________________________________________________________________________________"
printf "%-50s » [%d]\n" \
    "Pro AKTUALIZACI LISTU (seradi ID) zmackni cislo" 1 \
    "Pro ZADANI NOVEHO TASKU zmackni cislo"    2 \
    "Pro UPRAVU EXISTUJICIHO TASKU zmackni cislo" 3 \
    "Pro SMAZANI TASKU zmackni cislo"          4
printf "%s\n" "$radek"
printf "%-50s » [%d]\n" "Pro VYPNUTI task manageru zmackni cislo" 5
printf "%s\n" "$radek"
}