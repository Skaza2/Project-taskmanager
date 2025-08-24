#!/bin/bash

function smazani_tasku()
{
    read -p "Zadej ID tasku, ktery chces smazat: " id
    rm "$HOME/taskmanager/data/${id}.txt"
    sleep 1
}