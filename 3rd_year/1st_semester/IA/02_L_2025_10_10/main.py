#!/usr/bin/env python3

import csv
import numpy as np

myList = []

with open('./iris.data') as datafile:
    readCSV = csv.reader(datafile, delimiter=',')
    for row in readCSV:
        if len(row) == 5:
            myList.append([
                float(row[0]),
                float(row[1]),
                float(row[2]),
                float(row[3]),
                row[4]
            ])

npArray = np.array([x[:4] for x in myList], dtype=float)
np_norm = np.zeros_like(npArray)

for i in range(npArray.shape[1]):
    col           = npArray[:, i]
    col_min       = np.min(col)
    col_max       = np.max(col)
    np_norm[:, i] = (col - col_min) / (col_max - col_min)

ponderi  = np.array([0.1, 0.8, -1.1, 0.6])
sum_pond = np.dot(np_norm, ponderi)
rez_fin  = np.column_stack((np_norm, sum_pond, [x[4] for x in myList]))

with open("iris_procesed.csv", "w", newline="") as f:
    wr = csv.writer(f)
    wr.writerow(["col1", "col2", "col3", "col4", "suma_ponderata", "specie"])
    wr.writerows(rez_fin)
