% Prendre chacune des primitives prolog proposées en Annexe du cours
% et les compléter à l’aide de la documentation SWI-Prolog.

%— abolish/1
%abolish(x/1).

%— all_different/1

%— append/3
%append([a,b], [c], X).
%X = [a, b, c].

%— assert/1
%assert(parent('Bob', 'Jane')).
%true.

%— clpfd:librairiepourlagestiondescontraintesàdomainefini. — consult/1
%consult(['.../0-initiation/ex_14.pl']). % where ... is the absolute path to the file

%— debug/0

%— dif/2
%dif(5,5). %false.
%dif(5,4). %true.

%— in/2
%use_module(library(clpfd)).
%1 in 0..2. %true.

%— ins/2
%[1] ins 0..2. %true.
%[1] ins 2..3. %false.

%— labeling/2
% [X,Y] ins 10..20, labeling([max(X),min(Y)],[X,Y]).
%X = 20,
%Y = 10.

%— length/2
%length(List,4).
%List = [_, _, _, _].

%— listing/[0,1]
%listing(append([], _, _)).
%listing(file_search_path, [source(true)]).

%— lists:librairiepourlagestiondeslistes.
%https://www.swi-prolog.org/pldoc/man?section=lists

%— member/2
%member(X, [One]).
%X = One ;
%X = Two.
%member(One, [One,Two]).
%true ;
%One = Two.

%— notrace/0

%— nth0/[3,4]
%nth0(1, [1,2], X).
%X = 2.
%nth0(2, [1,2], X).
%false.

%— nth1/[3,4]
%nth1(1, [1,2], X).
%X = 1.

%— reconsult/1 %deprecated
%https://www.swi-prolog.org/pldoc/doc_for?object=edinburgh%3Areconsult/1

%— select/3
%select(10,[1,2,3],R).
%false.
%select(10,[1,2,10],R).
%R = [1, 2].

%— select/4
%select(b, [a,b,c,b], 2, X).
%X = [a, 2, c, b] ;
%X = [a, b, c, 2] ;
%false.

%— setof/3

%— statistics/[0,2]
%statistics().
%https://www.swi-prolog.org/pldoc/man?predicate=statistics/2
%statistics(+Key, -Value)

% — sum/3
%https://www.swi-prolog.org/pldoc/man?predicate=sum/3
%[A,B,C] ins 0..sup, sum([A,B,C], #=, 100).
%A in 0..100,
%A+B+C#=100,
%B in 0..100,
%C in 0..100.

%— trace/0
%https://www.swi-prolog.org/pldoc/man?predicate=trace/0