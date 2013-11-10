Homework 4. English to C translation

The problem

Your pointy-haired boss is having trouble reading your C and C++ code over your shoulder. He can't make heads or tails of expressions like "a<<b|d". "Do you shift first and then OR, or OR and then shift?" he asks. "Isn't there some way that you can make it clearer to me what's going on?"

To help him understand your code and designs, your boss proposes that you and he communicate expressions in a pseudocode that calls English Notation. He says that it will be more readable if you allow any of the usual English ways of saying an expression. For example, you can write either "add a and b" or "add a to b"; they both mean the same thing.

Your boss asks you to write a prototype to translate from English Notation to ordinary C expressions. He suggests that your prototype start by supporting expressions involving only unsigned decimal integer constants and operators. He's heard that Prolog is good for this sort of thing, so he suggests using Prolog.

In particular, your boss wants you to use the following English Notation. In each of the following table entries, E can be any English-Notation expression, and I and J can be any unsigned decimal integers, consisting entirely of digits. To formalize what each English expression means, we put next to it a Prolog structure that represents the same expression, assuming that the Prolog term E represents the English-Notation expression E.

English notation	 Prolog representation
add I to J	I+J
add I and J	I+J
E, then add J	E+J
subtract I from J	J-I
E, then subtract J	E-J
I unaltered	 +I
E, then do nothing	+E
negative of I	-I
E, then negate it	-E
complement of I	~I
E, then complement it	~E
multiply I by J	I*J
multiply I and J	I*J
E, then multiply by J	E*J
divide I by J	I/J
E, then divide by J	E/J
take the remainder of I after dividing by J	I'%'J
E, then divide by J and take the remainder	E'%'J
I shifted left J bits	I<<J
E, then shift left J bits	E<<J
I shifted right J bits	I>>J
E, then shift right J bits	E>>J
I and J	I&J
E, then and with J	E&J
I exclusive or J	I^J
E, then exclusive or with J	E^J
I or J	I!J
E, then or with J	E!J
discard I then use J instead	I,J
E, then discard and use J instead	E,J
Notice that your boss has taken pity on you, since | has another use in Prolog, so the above table specifies that you should use ! to represent logical OR (the C | operator), and similarly for % and '%'. These replacement operators should have precedence and associativity identical to the operators they replace.

You object that the Prolog doesn't have all those operators and that the Prolog operators don't follow the C's precedence and associativity rules, but your boss overrides your objections and asks you to use op/3 to fix any problems like that.

Assignment

Write a Prolog predicate english2C(E,C) that succeeds if E is an English-Notation expression corresponding to a term whose Prolog representation is C, using the rules described above. The English-Notation expressions are represented using lists of lower-case English words, commas, and unsigned decimal numbers, for example, [add, 3, to, 5, ',', then, negate, it]. The C expressions are represented using Prolog terms with the same appearance as C: for example, -(3+5). You may assume that the first argument to english2C/2 is a ground term, that is, it does not contain any logical variables. Your program may not use any side effects like assertz/1, retract/1, or I/O; however, it may use cuts (!/0).

At the start of your program, include a comment explaining any limitations of your program. For example, what happens if you try to run the program backwards, by invoking english2C(English, 3*5-7)?

To turn in your assignment, submit a file english2C.pl containing your predicate definitions. Make sure that your definitions work with the gprolog command installed on the SEASnet GNU/Linux servers under /usr/local/cs/bin/.

Examples

In these examples, the programmer repeatedly typed ";" in order to backtrack through all possible solutions. Your program's final response need not agree with the yes and ; no responses in the examples shown below; for example, it can output yes where the example below waits for the user to type ; before it outputs no. Output chatter such as file names and timings in milliseconds have been omitted from the following transcript.

$ gprolog
GNU Prolog 1.4.1
By Daniel Diaz
Copyright (C) 1999-2012 Daniel Diaz
| ?- consult('english2C.pl').
...

yes
| ?- english2C([subtract,1,from,0], C).

C = 0-1 ? ;

no
| ?- english2C([add,3,to,5,',',then,subtract,7], C).

C = 3+5-7 ? ;

no
| ?- english2C([multiply,3,by,5,',',then,subtract,7], C).

C = 3*5-7 ? ;

no
| ?- english2C([3,and,5,',',then,subtract,7], C).

C = (3&5)-7 ? ;

no
| ?- english2C([3,or,5,',',then,subtract,7], C).

C = (3!5)-7 ? ;

no
| ?- english2C([3,or,5,',',then,negate,it,',',
                then,divide,by,10,and,take,the,remainder],
	       C).

C = - (3!5) '%' 10 ? ;

no
| ?- english2C([negative,of,12,',',then,do,nothing], C).

C = + - (12) ? ;

no
| ?- english2C([5,unaltered,',',then,discard,and,use,12,instead], C).

C = (+5,12) ? ;

no
| ?- english2C([1,shifted,left,31,bits,',',then,complement,it,',',
                then,shift,right,31,bits],
	       C).

C = ~ (1<<31)>>31 ? ;

no
| ?- english2C([1,exclusive,or,3,',',then,or,with,5], C).

C = 1^3!5 ? ;

no
| ?- english2C([1,exclusive,or,3,',',then,and,with,5], C).

C = (1^3)&5 ? ;

no
| ?- english2C([1,or,3,',',then,exclusive,or,with,5], C).

C = (1!3)^5 ? ;

no
| ?- english2C([2,plus,2,equals,4], C).

no
In the above examples, the parentheses in - (12) distinguish it (a structure with functor -/1 and argument 12) from -12 (a negative integer). For example, the goal integer(-12) succeeds, but integer(- (12)) fails because structures are not integers.

© 2012 Paul Eggert. See copying rules.
$Id: hw4.html,v 1.72 2012/11/07 23:33:55 eggert Exp $