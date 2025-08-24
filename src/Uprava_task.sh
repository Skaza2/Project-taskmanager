#!/bin/bash

upraveny_file=""

function id_tasku ()
{
    echo "Zadaj ID tasku pro upravu"
    while true; do
        read -p "" ID
        if [[ -f "$HOME/taskmanager/data/$ID.txt" ]]; then
            sleep 2
            break
        else
            echo "Soubor neexistuje."
        fi
    done
    upraveny_file="$HOME/taskmanager/data/$ID.txt"
}

function uprava_nazev_tasku ()
{
    echo "Chces upravit nazev tasku? y/n"
        while true; do
	        read -p "" volba
	        if [[ "$volba" == "n" ]]; then
	            return 0
	        elif [[ "$volba" == "y" ]]; then
	            break
	        else
	            echo "Zadaj y/n."
	        fi
	    done	


    echo -e "Zadaj novy nazov tasku.\nMaximalne pouzi 30 pismen/znakov."

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
	sed -i '1d' "$upraveny_file"
    sed -i "1i name=\"$nova_uloha\"" "$upraveny_file"    
}

function uprava_priorita_tasku ()
{
    echo "Chces upravit prioritu tasku? y/n"
        while true; do
	        read -p "" volba
	        if [[ "$volba" == "n" ]]; then
	            return 0
	        elif [[ "$volba" == "y" ]]; then
	            break
	        else
	            echo "Zadaj y/n."
	        fi
	    done

    echo -e "Zadaj prioritu.\nStupnica 0-100."
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

	sed -i '2d' "$upraveny_file"
    sed -i "2i priority=\"$priorita\"" "$upraveny_file" 
}

function uprava_datum_dokonceni ()
{
    echo "Chces upravit datum dokonceni tasku? y/n"
        while true; do
	        read -p "" volba
	        if [[ "$volba" == "n" ]]; then
	            return 0
	        elif [[ "$volba" == "y" ]]; then
	            break
	        else
	            echo "Zadaj y/n."
	        fi
	    done
    printf "%-20s » [%d]\n" \
        "DNESNY datum" 0 \
        "VLASTNI datum" 1 \
        "Neznamy" 2
        
    while true; do
        read -p "Zadej datum dokonceni úlohy [0-2]: " vyber
        case "$vyber" in
            0)
                echo "Dokonceni tasku dnes."
                datum=$(date +"%d.%m.%Y")
                sleep 2
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
                sleep 2
                break
                ;;
            2)
                echo "Dokonceni tasku kdo vi kdy. "
                sleep 2
                break
                ;;
            *)
                echo "Neplatná volba!"
                ;;
        esac
    done
    sed -i '3d' "$upraveny_file"
    sed -i "3i due_date=\"$datum\"" "$upraveny_file" 
}

function uprava_stav_tasku ()
{
    moznosti_stavu=("Nedokonceny" "Rozpracovany" "Dokonceny" "Neznamy")

    echo "Chces upravit status tasku? y/n"
        while true; do
	        read -p "" volba
	        if [[ "$volba" == "n" ]]; then
	            return 0
	        elif [[ "$volba" == "y" ]]; then
	            break
	        else
	            echo "Zadaj y/n."
	        fi
	    done

    printf "%-20s » [%d]\n" \
        "Nedokonceny" 0 \
        "Rozpracovany" 1 \
        "Dokonceny" 2 \
        "Neznamy" 3
    vybrany_stav=""    
    while true; do
        read -p "Zadej stav úlohy [0-3]: " vyber
    
        case "$vyber" in
            0)
                echo "Task je nedokončený."
                vybrany_stav=${moznosti_stavu[0]}
                sleep 2
                break
                ;;
            1)
                echo "Task je rozpracovaný."
                vybrany_stav=${moznosti_stavu[1]}
                sleep 2
                break
                ;;
            2)
                echo "Task je dokončený."
                vybrany_stav=${moznosti_stavu[2]}
                sleep 2
                break
                ;;
            3)
                echo "Task je v neznámém stavu."
                vybrany_stav=${moznosti_stavu[3]}
                sleep 2
                break
                ;;
            *)
                echo "Neplatná volba!"
                ;;
        esac
    done
    sed -i '4d' "$upraveny_file"
    sed -i "4i status=$vybrany_stav" "$upraveny_file" 
}

function uprava_popis_tasku ()
{
	echo "Chces upravit popis tasku? y/n"
	        while true; do
		        read -p "" volba
		        if [[ "$volba" == "n" ]]; then
		            return 0
		        elif [[ "$volba" == "y" ]]; then
		            break
		        else
		            echo "Zadaj y/n."
		        fi
		    done
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
    sleep 2
    sed -i '5d' "$upraveny_file"
    sed -i "4a description=\"$popis\"" "$upraveny_file"
}
