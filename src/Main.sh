#!/bin/bash

source $HOME/taskmanager/Taskmanager_uvodni_obrazovka.sh

source $HOME/taskmanager/Novy_taks.sh

source $HOME/taskmanager/smazani_tasku.sh

source $HOME/taskmanager/Uprava_task.sh

clear
tabulka
moznosti_tabulky
#prikaz while na zaklade vyberu volby provede seriu prikazu
while true; do
        read -p "" volba
        case $volba in
            1)
                #prikaz 1 seradi ID tasku
                #nahrajeme vsechny nazvy .txt do promenne tasks
                tasks=($(ls $HOME/taskmanager/data/*.txt | sort -V))
                #prejmenujeme vsechny .txt na docasny nazev _tmp_*.txt
                i=1
                for f in "${tasks[@]}"; do
                    mv -f "$f" "$HOME/taskmanager/data/_tmp_${i}.txt"
                    ((i++))
                done
                #prejmenujeme vsechny .txt ktere jsme nahrali do promenne tasks a zacneme od 1
                i=1
                for f in $HOME/taskmanager/data/_tmp_*.txt; do
                    mv -f "$f" "$HOME/taskmanager/data/${i}.txt"
                    ((i++))
                done

                echo "Polozky jsou setreseny."
                sleep 1
                clear
                tabulka
                moznosti_tabulky
                ;;
            2)  
                #prikaz 2 vytvori novy task
                clear
                tabulka
                novy_task
                nazov_tasku

                clear
                tabulka
                priorita_tasku

                clear
                tabulka
                datum_dokonceni

                clear
                tabulka
                stav_tasku

                clear
                tabulka
                popis_tasku

                clear
                tabulka
                moznosti_tabulky
                ;;
            3)  
                #prikaz 3 upravy task
                clear
                tabulka
                id_tasku

                clear
                tabulka
                uprava_nazev_tasku

                clear
                tabulka
                uprava_priorita_tasku

                clear
                tabulka
                uprava_datum_dokonceni

                clear
                tabulka
                uprava_stav_tasku

                clear
                tabulka
                uprava_popis_tasku

                clear
                tabulka
                moznosti_tabulky
                ;;
            4)  
                #prikaz 4 smaze task
                smazani_tasku
                clear
                tabulka
                moznosti_tabulky
                ;;
            5)  
                #prikaz 5 vypne taskmanager
                sleep 1
                clear
                tabulka
                exit 0 
                ;;
            *)  
                #poziada o vhodny vstup
                echo "Neplatná volba!"
                ;;
        esac
    
done
