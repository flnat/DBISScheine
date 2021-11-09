**Aufgabe B Tandem 34**
Florian Natterer
Matej Majesky
Johannes Tzeggai


*Legende*:
    AK: Alternate Key (Alternativschlüssel)
    FK: Foreign Key (Fremdschlüssel)
    varchar(\<X>): Zeichenkette mit max. X Zeichen
    char(\<X>): Zeichenkette mit genau X Zeichen
    \<Attribute> NOT NULL: Attribut muss einen Wert zugeordnet haben (darf keinen NULL-Wert annehmen)



sch(Ferienwohnungen) = ({[<ins>Wohnungs-ID: integer</ins>, Größe (qm): decimal, Zimmerzahl: integer, beschreibungstext: varchar(1024)]},$\Sigma$Ferienwohnungen)
$\Sigma$Ferienwohnungen = {Größe (qm) NOT NULL, Zimmerzahl NOT NULL, Tagespreis NOT NULL}

sch(bietet) = ({[<ins>Wohnungs-ID: integer, Austattungsbeschreibung: varchar(256)</ins>]}, $\Sigma$bietet)

sch(Zusatzaustattungen) = ({[<ins>Beschreibung: varchar(256)</ins>]}, $\Sigma$Zusatzaustattungen)

sch(bildet_ab) = ({[<ins>Wohnungs-ID: integer, Datei-ID: integer</ins>]}, $\Sigma$bildet_ab)

sch(Bilder) = ({[<ins> Datei-ID: integer</ins>, Bildbeschreibung: varchar(256), Dateipfad: varchar(256)]}, $\Sigma$Bilder)
$\Sigma$Bilder = {Dateipfad NOT NULL}

sch(Adressen) = ({[<ins>Adress-ID: Integer</ins>, Straße: varchar(64),   ]})