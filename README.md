==================================
 TaskManager - README
==================================

Popis:
-------
TaskManager je jednoduchý nástroj na správu úloh.
Umožňuje vytvárať, zobrazovať a mazať úlohy
uložené v textových súboroch.

Štruktúra adresárov:
--------------------
/taskmanager
Main.sh        -> hlavný spúšťací skript,

data/          -> priečinok s uloženými úlohami (*.txt),

install.sh     -> inštalačný skript

Použitie:
---------
1. Spusti inštaláciu:
   ./install.sh

2. Spusti aplikáciu:
   bash Main.sh
   alias -> run_taskmanager

3. Úlohy sa ukladajú do:
   /home/<užívateľ>/taskmanager/data/

Poznámky:
---------
- Každá úloha je uložená ako samostatný .txt súbor.
- Pre správne fungovanie taskmanagera je potrebne mať v zložke data aspoň jeden task
- Nepoužívať diakritiku

Autor:
------
Juraj Šaradín - Skaza
