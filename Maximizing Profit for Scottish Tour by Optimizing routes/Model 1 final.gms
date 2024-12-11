Option optcr = 0.00;


Set
    i Attractions /1*21/;
alias(i, j);


Parameter distance(i,j) "Distance between attractions (miles)";

Parameter time(i,j)     "Travel time between attractions (minutes)";

Parameter entryFee(i)   "Entry cost for visiting site i"
/
1 17.5, 2 17.5, 3 0, 4 0, 5 10.5, 6 0, 7 10, 8 0, 9 10, 10 16.5,
11 0, 12 20, 13 0, 14 15, 15 0, 16 4, 17 0, 18 0, 19 18.95, 20 17, 21 0
/;

Parameter rating(i)    "Attractiveness rating for each site i (1-5 scale) based on google reviews"
/
1 4.7, 2 4.5, 3 4.8, 4 4.6, 5 4.4, 6 4.3, 7 4.9, 8 4.2, 9 4.8,
10 4.6, 11 4.7, 12 4.5, 13 4.6, 14 4.8, 15 4.3, 16 4.4,
17 4.7, 18 4.6, 19 4.5, 20 4.8, 21 0/ ;

Parameter visitTime(i) "Average time spent at each site"
/
1 120, 2 60, 3 60, 4 25, 5 90, 6 60, 7 60, 8 30, 9 120, 10 45,
11 120, 12 120, 13 180, 14 120, 15 30, 16 120, 17 120, 18 60, 19 60, 20 120,
21 0 
/;



Scalar maxTime      "Maximum allowable time for the trip (minutes)" /480/;

Scalar fuelCost     "Cost for fuel per mile (in pounds)" /0.165/;

Scalar driverSalary "Driver's hourly wage (in pounds)" /16.1/;

Scalar a            "Weight for attractiveness rating" /25.12/;

Scalar N            "Number of attraction sites" /21/;

Table distance(i,j) "Distance between attractions (miles)"
    1       2       3       4       5       6       7       8       9       10      11      12      13      14      15      16      17      18      19      20      21
1   0       18.5    29.4    16.9    44      28.1    8.2     96      21.5    70.4    77.9    35.8    61.7    45.5    86      87.7    19.3    224     159     237     42.3
2   18.5    0       44      4.7     33.3    22.8    20.4    109     10.4    84.9    90.4    44.8    73.9    32.1    98.5    77      13.2    236     171     249     30.8
3   29.4    44      0       44.9    72      27.6    28.9    85.6    49.5    42.5    67.5    60.9    86.9    52.3    75.6    116     47.3    196     137     208     72.4
4   16.9    4.7     44.9    0       30.7    27.6    21.3    109     8.2     85.8    91.2    43.8    74.7    31      99.3    74.5    12.2    237     172     250     28.4
5   44      33.3    72      30.7    0       48.6    48.9    137     23.3    112     119     55.4    84      33.6    127     49      33.7    246     181     259     7.7
6   28.1    22.8    27.6    27.6    48.6    0       32.8    109     32.6    66.1    91      60.3    86.3    28.1    99.1    92.1    30.4    219     184     232     46.1
7   8.2     20.4    28.9    21.3    48.9    32.8    0       88.6    26.3    70.9    70.5    32.3    58.3    50.8    78.6    92.6    24.2    199     156     211     43.6
8   96      109     85.6    109     137     109     88.6    0       115     46.6    19.4    105     96.8    133     18.4    181     112     136     76.5    148     132
9   21.5    10.4    49.5    8.2     23.3    32.6    26.3    115     0       90.7    96.1    43.6    72.2    27.3    104     67      17.1    235     170     247     18.3
10  70.4    84.9    42.5    85.8    112     66.1    70.9    46.6    90.7    0       55.4    87.4    87.5    89.6    37.8    157     88.2    184     125     196     110
11  77.9    90.4    67.5    91.2    119     91      70.5    19.4    96.1    55.4    0       86.9    90.7    115     37.6    163     94.2    130     70.4    142     114
12  35.8    44.8    60.9    43.8    55.4    60.3    32.3    105     43.6    87.4    86.9    0       32.5    70.3    95.1    98.4    42.2    195     130     208     46.1
13  61.7    73.9    86.9    74.7    84      86.3    58.3    96.8    72.2    87.5    90.7    32.5    0       99.3    95.3    127     71.2    132     34.9    145     74.7
14  45.5    32.1    52.3    31      33.6    28.1    50.8    133     27.3    89.6    115     70.3    99.3    0       122     80.8    39.9    263     198     275     34.5
15  86      98.5    75.6    99.3    127     99.1    78.6    18.4    104     37.8    37.6    95.1    95.3    122     0       171     102     154     94.6    166     122
16  87.7    77      116     74.5    49      92.1    92.6    181     67      157     163     98.4    127     80.8    171     0       77.3    290     225     303     47.2
17  19.3    13.2    47.3    12.2    33.7    30.4    24.2    112     17.1    88.2    94.2    42.2    71.2    39.9    102     77.3    0       233     168     246     24.4
18  224     236     196     237     246     219     199     136     235     184     130     195     132     263     154     290     233     0       100     24.4    237
19  159     171     137     172     181     184     156     76.5    170     125     70.4    130     34.9    198     94.6    225     168     100     0       113     168
20  237     249     208     250     259     232     211     148     247     196     142     208     145     275     166     303     246     24.4    113     0       250
21  42.3    30.8    72.4    28.4    7.7     46.1    43.6    132     18.3    110     114     46.1    74.7    34.5    122     47.2    24.4    237     168     250     0
;

    
Table time(i,j) "Travel time between attractions (minutes)"
    1       2       3       4       5       6       7      8      9      10      11      12      13      14      15      16      17      18      19      20      21
1   0       28      50      29.5    70      47.5    16     150    34     115     125     60      77.5    67.5    135     125     28      330     205     345     72.5
2   28      0       75      16      77.5    47.5    40     175    29.5   140     150     77.5    102.5   72.5    160     125     31.5    350     225     360     77.5
3   50      75      0       70      110     52.5    50     135    75     67.5    105     95      115     92.5    125     165     72.5    320     220     335     115
4   29.5    16      70      0       67.5    52.5    30.5   170    23     130     140     70      95      67.5    155     115     25      340     215     355     60
5   70      77.5    110     67.5    0       80      67.5   210    42.5   165     180     77.5    105     65      195     72.5    60      360     230     370     34.5
6   47.5    47.5    52.5    52.5    80      0       50     165    52.5   102.5   140     90      110     50      160     140     50      355     235     365     87.5
7   16      40      50      30.5    67.5    50      0      135    37.5   110     110     55      75      75      125     135     35      320     195     340     75
8   150     175     135     170     210     165     135    0      165    75      30      165     140     200     35      245     165     225     125     235     215
9   34      29.5    75      23      42.5    52.5    37.5   165    0      140     145     60      92.5    57.5    160     107.5   30.5    340     215     350     50
10  115     140     67.5    130     165     102.5   110    75     140    0       82.5    145     140     135     62.5    210     135     295     195     310     170
11  125     150     105     140     180     140     110    30     145    82.5    0       150     130     175     60      230     145     210     115     225     200
12  60      77.5    95      70      77.5    90      55     165    60     145     150     0       52.5    105     165     145     60      305     235     315     80
13  77.5    102.5   115     95      105     110     75     140    92.5   140     130     52.5    0       130     150     170     87.5    205     52.5    220     107.5
14  67.5    72.5    92.5    67.5    65      50      75     200    57.5   135     175     105     130     0       205     130     75      385     265     400     82.5
15  135     160     125     155     195     160     125    35     160    62.5    60      165     150     205     0       235     160     250     155     265     200
16  125     125     165     115     72.5    140     135    245    107.5  210     230     145     170     130     235     0       120     420     290     435     75
17  28      31.5    72.5    25      60      50      35     165    30.5   135     145     60      87.5    75      160     120     0       340     215     350     60
18  330     350     320     340     360     355     320    225    340    295     210     305     205     385     250     420     340     0       160     45      355
19  205     225     220     215     230     235     195    125    215    195     115     235     52.5    265     155     290     215     160     0       170     230
20  345     360     335     355     370     365     340    235    350    310     225     315     220     400     265     435     350     45      170     0       370
21  72.5    77.5    115     60      34.5    87.5    75     215    50     170     200     80      107.5   82.5    200     75      60      355     230     370     0
;


Variables
z       "profitablity of tour"
cost    "cost of the tour"
;

Positive Variable
u(i)    "Auxiliary variable for subtour elimination (MTZ method)"
;

Binary Variables
x(i,j)  "1 if route from attraction site i to attraction site j is taken else 0"
y(i)    "1 if attraction site i visited else 0"
;

Equations
    objective               "Objective to maximize profitability"
    time_constraint         "Total trip time constraint"
    flow_conservation       "To conserve the flow of tour"
    start_at_edi            "Ensure the tour starts at Edinburgh"
    end_at_edi              "Ensure the tour ends at Edinburgh"
    cost_trip               "Cost incurred by the trip"
    dependency_constraint   "The site travelled to is marked as visited"
    subtour_elimination     "Elimination of subtours that may form within model"
    ;
    

objective.. z =e= a * sum(i, rating(i) * y(i)) - (sum((i,j),distance(i,j) * fuelCost * x(i,j)) + sum((i,j),time(i,j)/60 * driverSalary * x(i,j)) + sum(i,visitTime(i)/60 * driverSalary * y(i))+  sum(i,entryFee(i) * y(i)));

time_constraint..   sum((i,j),time(i,j) * x(i,j)) + sum(i, visitTime(i) * y(i)) =l= maxTime;

flow_conservation(j)$(ord(j) <> 21).. sum(i$(not sameas(i,j)), x(i,j)) =e= sum(i$(not sameas(i,j)), x(j,i));

dependency_constraint(i)..    y(i) =e= sum(j$(not sameas(i,j)), x(i,j));

start_at_edi.. sum(j, x('21',j)) =e= 1;

end_at_edi.. sum(i, x(i,'21')) =e= 1;

cost_trip.. cost =e=  sum((i,j),distance(i,j) * fuelCost * x(i,j)) + sum((i,j),time(i,j)/60 * driverSalary * x(i,j)) + sum(i,visitTime(i)/60 * driverSalary * y(i))+  sum(i,entryFee(i) * y(i));

subtour_elimination(i,j)$(ord(i) <> ord(j) and ord(i) <> 21 and ord(j) <> 21)..
    u(i) - u(j) + N * x(i,j) =l= N - 1;

Model tsp_max_attract /objective, cost_trip, time_constraint, flow_conservation, dependency_constraint, start_at_edi, end_at_edi, subtour_elimination/;
Solve tsp_max_attract using mip maximizing z;

display cost.l, x.l, y.l, z.l;