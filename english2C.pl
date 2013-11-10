% Invoking english2C(English, 3*5-7) will cause my program to hang as it has
% not yet been implemented to convert from C to English. I'm also uncertain
% of the priorities at which I ranked my operators. I've found that setting
% them too high will induce parenthesis around the final output. I have since
% resolved it but now knowing that the priority value has an effect on the
% outcome, I cannot guarantee that the values I've used will have no side
% effects.

english2C([add, I, to, J], I+J) :- integer(I), integer(J).
english2C([add, I, and, J], I+J) :- integer(I), integer(J).
english2C(E, C) :- 
    append(Start, [',', then, add, J], E), 
    english2C(Start, COther), integer(J), C = COther + J.

english2C([subtract, I, from, J], J-I) :- integer(I), integer(J).
english2C(E, C) :-
    append(Start, [',', then, subtract, J], E),
    english2C(Start, COther), integer(J), C = COther - J.

english2C([I, unaltered], +(I)) :- integer(I).
english2C(E, C) :-
    append(Start, [',', then, do, nothing], E),
    english2C(Start, COther), C = +(COther).

english2C([negative, of, I], -(I)) :- integer(I).
english2C(E, C) :-
    append(Start, [',', then, negate, it], E),
    english2C(Start, COther), C = -(COther).

english2C([complement, of, I], C) :- op(200, fy, ~), integer(I), C = ~(I).
english2C(E, C) :- 
    op(200, fy, ~),
    append(Start, [',', then, complement, it], E),
    english2C(Start, COther), C = ~(COther).

english2C([multiply, I, by, J], I*J) :- integer(I), integer(J).
english2C([multiply, I, and, J], I*J) :- integer(I), integer(J).
english2C(E, C) :-
    append(Start, [',', then, multiply, by, J], E),
    english2C(Start, COther), integer(J), C = COther * J.

english2C([divide, I, by, J], I/J) :- integer(I), integer(J).
english2C(E, C) :-
    append(Start, [',', then, divide, by, J], E),
    english2C(Start, COther), integer(J), C = COther / J.

english2C([take, the, remainder, of, I, after, dividing, by, J], C) :- 
    op(400, xfy, '%'), integer(I), integer(J), C = '%'(I,J).
english2C(E, C) :-
    op(400, xfy, '%'),
    append(Start, [',', then, divide, by, J, and, take, the, remainder], E),
    english2C(Start, COther), integer(J), C = '%'(COther,J).

english2C([I, shifted, left, J, bits], C) :- 
    op(600, xfy, <<), integer(I), integer(J), C = '<<'(I,J).
english2C(E, C) :-
    op(600, xfy, <<),
    append(Start, [',', then, shift, left, J, bits], E),
    english2C(Start, COther), integer(J), C = '<<'(COther,J).

english2C([I, shifted, right, J, bits], C) :- 
    op(600, xfy, >>), integer(I), integer(J), C = '>>'(I,J).
english2C(E, C) :-
    op(600, xfy, >>),
    append(Start, [',', then, shift, right, J, bits], E),
    english2C(Start, COther), integer(J), C = '>>'(COther,J).

english2C([I, and, J], C) :- 
    op(610, xfy, &), integer(I), integer(J), C = '&'(I,J).
english2C(E, C) :-
    op(610, xfy, &),
    append(Start, [',', then, and, with, J], E),
    english2C(Start, COther), integer(J), C = '&'(COther,J).

english2C([I, exclusive, or, J], C) :- 
    op(620, xfy, ^), integer(I), integer(J), C = '^'(I,J).
english2C(E, C) :-
    op(620, xfy, ^),
    append(Start, [',', then, exclusive, or, with, J], E),
    english2C(Start, COther), integer(J), C = '^'(COther,J).

english2C([I, or, J], C) :- 
    op(630, xfy, !), integer(I), integer(J), C = '!'(I,J).
english2C(E, C) :- 
    op(630, xfy, !),
    append(Start, [',', then, or, with, J], E),
    english2C(Start, COther), integer(J), C = '!'(COther,J).

english2C([discard, I, then, use, J, instead], C) :- 
    integer(I), integer(J), C = ','(I,J).
english2C(E, C) :-
    append(Start, [',', then, discard, and, use, J, instead], E),
    english2C(Start, COther), integer(J), C = ','(COther,J).
