#!/bin/bash

newfile=""

function novy_task ()
{
    # Najdeme všechna jména souborů *.txt
    numbers=()
    for f in $HOME/taskmanager/data/*.txt; do
        filename=$(basename "$f" .txt)
        numbers+=("$filename")
    done

    # Pokud pole numbers je prázdné, začneme od 1
    if [[ ${#numbers[@]} == 0 ]]; then
        next=1
    else
        # Najdeme nejvyšší číslo
        max=0
        for n in "${numbers[@]}"; do
            (( n > max )) && max=$n
        done
        next=$((max + 1))
    fi

    # Vytvoříme nový soubor s číslem next.txt
    newfile="$HOME/taskmanager/data/$next.txt"
    touch "$newfile"
    sleep 1
}

function nazov_tasku ()
{
    echo -e "Zadaj nazov noveho tasku task.\nMaximalne pouzi 30 pismen/znakov."
    # Načteme input, a zkontrolujeme ho jestli byl zadán správně - délku inputu 1-30 znakov
    while true; do
        read nova_uloha
        length=${#nova_uloha}
            if (( $length < 1 )); then
	            echo "Nezadal jsi nazev tasku. Task nebyl zapsan!"
            elif (( $length > 30 )); then
                echo "Delka nazvu tasku je prilis dlouha. Task nebyl zapsan!"
            else
	            echo "Delka je fajn. Task byl zapsan."
                break	
            fi 
    done
    # Vytvoříme nový řádek, který naimportujeme do textového souboru newfile (1.řádek)
    echo "name=\"$nova_uloha\""  >> $newfile
    sleep 1
}

function priorita_tasku ()
{
    echo -e "Zadaj prioritu.\nStupnica 0-100."
    # Načteme input, a zkontrolujeme ho jestli byl zadán správně - jestli se jedná o číslo 0-100
    while true; do

        read priorita

        if [[ "$priorita" =~ ^[0-9]+$ ]]; then
            if (( $priorita >= 0 )) && (($priorita <= 100 )); then
	            echo "Priorita byla zadana."
                break
            else
	            echo "Zadej cislo od 0-100!"	
            fi 
        else
            echo "Zadej cislo od 0-100!"
        fi        
    done
    # Vytvoříme nový řádek, který naimportujeme do textového souboru newfile (2.řádek)
    echo "priority=$priorita"  >> $newfile
    sleep 1
}

function datum_dokonceni ()
{
    # Vypiseme moznosti pro zadani datumu
    printf "%-40s » [%d]\n" \
        "DNESNY datum - zmackni cislo" 0 \
        "VLASTNI datum - zmackni cislo" 1 \
        "NEZNAMY datum - zmackni cislo" 2
    # Načteme input, podle zadane volby probehne serie prikazu  
    while true; do
        read -p "Zadej datum dokonceni úlohy [0-2]: " vyber
        case "$vyber" in
            0)
                echo "Dokonceni tasku dnes."
                datum=$(date +"%d.%m.%Y")
                break
                ;;
            1)  
                # Vypíšeme prompt zvlášť, aby šlo zalomit řádek
                echo "Zadej datum ve formatu DD.MM.YYYY"
                
                while true; do
                    read -p "> " datum
                
                    # Rozdělíme podle teček (.)
                    IFS="." read -r den mesic rok <<< "$datum"
                    
                    # Složíme do formátu YYYY-MM-DD pro date
                    datum_yyyymmdd="$rok-$mesic-$den"
                    
                    # Ověříme validitu datumu
                    if date -d "$datum_yyyymmdd" >/dev/null 2>&1; then
                    	break
                    else
                        echo "Neplatné datum, zkus to znovu."
                    fi
                done

                echo "Dokonceni tasku musi byt $datum."
                break
                ;;
            2)
                echo "Dokonceni tasku kdo vi kdy. "
                datum="-"
                break
                ;;
            *)
                echo "Neplatná volba!"
                ;;
        esac
    done
    # Vytvoříme nový řádek, který naimportujeme do textového souboru newfile (3.řádek)
    echo "due_date=\"$datum\"" >> $newfile
    sleep 1
}


function stav_tasku ()
{
    # Vytvorime promenne pole kde preddefinujeme moznosti stavu tasku
    moznosti_stavu=("Nedokonceny" "Rozpracovany" "Dokonceny" "Neznamy")

    printf "%-40s » [%d]\n" \
        "NEDOKONCENY task - zmackni cislo" 0 \
        "ROZPRACOVANY task - zmackni cislo" 1 \
        "DOKONCENY task - zmackni cislo" 2 \
        "NEZNAMY task - zmackni cislo" 3
    # Vytvorime prazdnu premennu do ktorej potom vlozime stav tasku 
    vybrany_stav=""  
    # Podle vyberu vlozime do prazdenj premennej moznost stavu z preddefinovaheo pole 
    while true; do
        read -p "Zadej stav úlohy [0-3]: " vyber

        case "$vyber" in
            0)
                echo "Task je nedokončený."
                vybrany_stav=${moznosti_stavu[0]}
                break
                ;;
            1)
                echo "Task je rozpracovaný."
                vybrany_stav=${moznosti_stavu[1]}
                break
                ;;
            2)
                echo "Task je dokončený."
                vybrany_stav=${moznosti_stavu[2]}
                break
                ;;
            3)
                echo "Task je v neznámém stavu."
                vybrany_stav=${moznosti_stavu[3]}
                break
                ;;
            *)
                echo "Neplatná volba!"
                ;;
        esac
    done
    # Vytvoříme nový řádek, který naimportujeme do textového souboru newfile (4.řádek)
    echo "status=$vybrany_stav"  >> $newfile
    sleep 1
}

function popis_tasku ()
{
    # Načteme input, podle zadane volby... nevzknikne popis ... poziadame o vhodnu delku popisu ... zapiseme popis do promenne 
    echo -e "Zadaj popis tasku.\nJestli nechces psat popis stiskni klavesu enter.\nMaximalne pouzi 50 pismen/znakov. "
        read popis
        length=${#popis}
			while true; do
	            if (( $length < 1 )); then
		            echo "Popis nebyl zadan."
		            break
	            elif (( $length > 50 )); then
	                echo "Delka nazvu tasku je prilis dlouha. Task nebyl zapsan!"
	            else
	                echo "Popis tasku je: $popis"
	            	break
	            fi
			done	            
    # Vytvoříme nový řádek, který naimportujeme do textového souboru newfile (5.řádek)
    echo "description=\"$popis\""  >> $newfile
    sleep 1
}

