/*
 * **********************************************
 * Printing result depth
 *
 * You can enlarge it, if needed.
 * **********************************************
 */
maximum_printing_depth(100).

:- current_prolog_flag(toplevel_print_options, A),
   (select(max_depth(_), A, B), ! ; A = B),
   maximum_printing_depth(MPD),
   set_prolog_flag(toplevel_print_options, [max_depth(MPD)|B]).

% helper predicate 1: added list from meni lecture notes
list([]).
list([X|Xs]) :- list(Xs).


% Signature: sub_list(Sublist, List)/2
% Purpose: All elements in Sublist appear in List in the same order.
% Precondition: List is fully instantiated (queries do not include variables in their second argument).
sub_list([], List):- list(List).
sub_list([X|Xs],[X|Ys]):-sub_list(Xs,Ys).
sub_list([X|Xs],[_|Ys]):-sub_list([X|Xs],Ys).



% helper predicate 2: added append from meni lecture notes
append([], Xs, Xs):-list(Xs).
append([X | Xs], Ys, [X | Zs]) :- append(Xs, Ys, Zs).

% Signature: swap_list(List, InversedList)/2
% Purpose: InversedList is the ‘mirror’ representation of List, i.e, each item in the list is recursively replaced with the item at the position, with refers to the beginning and the end of the list.   
% Example:
% ?- swap_list([a,b,c,d,e],T).
% T = [e,d,c,b,a];
% ?- swap_list([[a,b],[c,d],e],T).
% T = [e,[d,c],[b,a]];
swap_list([],[]).
swap_list([X|Xs], Y):-list(X), !, swap_list(X, Xr), swap_list(Xs, Yp), append(Yp,[Xr|[]],Y).
swap_list([X|Xs], Y):-swap_list(Xs, Yp), append(Yp,[X|[]],Y).




% Signature: sub_tree(Subtree, Tree)/2
% Purpose: Tree contains Subtree.
sub_tree(tree(X,L,R), tree(X,L,R)).
sub_tree(X, tree(_,Left,_)):- sub_tree(X, Left).
sub_tree(X, tree(_,_,Right)):- sub_tree(X, Right).



% Signature: swap_tree(Tree, InversedTree)/2
% Purpose: InversedTree is the mirror representation of Tree.
swap_tree(void,void).
swap_tree(
    tree(X, Left, Right), 
    tree(X, RightR, LeftR)
):- swap_tree(Left, LeftR), swap_tree(Right, RightR).