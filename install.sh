#!/bin/bash

#prikaz while na zaklade vyberu volby provede seriu prikazu

# ====== Nastavenia ======
nazev_aplikace="taskmanager"
slozka="$HOME/$nazev_aplikace"
datova_slozka="$HOME/$nazev_aplikace/data"
zdrojovy_kod="Main.sh"
prikaz="run_taskmanager"

echo "Inštalujem $nazev_aplikace ..."

# 1. Vytvorenie priečinka pre aplikáciu a pre ukladanie dát v nej
mkdir -p "$slozka"

mkdir -p "$datova_slozka"

# 2. Vytvorenie prveho testovacieho suboru
touch "$datova_slozka/1.txt"

echo "name="Projekt"" >> $datova_slozka/1.txt
echo "priority=100" >> $datova_slozka/1.txt
echo "due_date="10.08.2025"" >> $datova_slozka/1.txt
echo "status=Rozpracovany" >> $datova_slozka/1.txt
echo "description="Je to dokonale"" >> $datova_slozka/1.txt

# 3. Vytvorenie priečinka pre aplikáciu a pre ukladanie dát v nej
cp -r src/* "$slozka"

# 4. Nastavenie spustiteľného práva pre main.sh
chmod 711 "$slozka/$zdrojovy_kod"

# 5. Nastavenie spustiteľného práva pre Main.sh
echo "alias $prikaz='bash $slozka/$zdrojovy_kod'" >> "$HOME/.bashrc"

# 6. Načítanie aliasov
source "$HOME/.bashrc"

echo "Inštalácia dokončená. Teraz môžeš spustiť aplikáciu príkazom: $prikaz"








