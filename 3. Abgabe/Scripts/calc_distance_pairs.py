import itertools
OrtIDs = [number for number in range(1, 17)]
cartesianID = []
DMLStatements = ""
for element in itertools.product(OrtIDs, OrtIDs):
    a, b = element
    if (b, a) not in cartesianID:
        cartesianID.append(element)
for element in cartesianID:
    Startpunkt, Endpunkt = element
    if Startpunkt == Endpunkt:
        singleDMLStatement = "INSERT INTO kalkulierte_Distanz(Startpunkt, Endpunkt, kalkulierte_Distanz)\n\t" + \
            f"Values({Startpunkt}, {Endpunkt}, 0);" + "\n"
    else:
        singleDMLStatement = "INSERT INTO kalkulierte_Distanz (Startpunkt, Endpunkt)\n\t" + \
            f"VALUES({Startpunkt}, {Endpunkt});" + "\n"
    DMLStatements += singleDMLStatement


with open("calc_distance_DML.txt", "w+") as text_file:
    text_file.write(DMLStatements)
