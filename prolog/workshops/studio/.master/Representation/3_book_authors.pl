/*
book(x, y).
book x has the genre y
*/
book('Os Maias', 'romance').

/*
author(x, y).
author x is of nationality y.
*/
author('Eça de Queiroz', 'português').

/*
wrote(x, y).
author x wrote book y.
*/
wrote('Eça de Queiroz', 'Os Maias').

/*
nationality(x).
x is a nationality.
*/
nationality('português').
nationality('inglês').

/*
genre(x).
x is a genre.
*/
genre('romance').
genre('ficção').

/*
questionB(Author).
finds portuguese authors who wrote romances.
*/
questionB(Author) :-
    author(Author, 'português'),
    wrote(Author, book),
    book(book, 'romance').


/*
questionC(Author).
finds authors of fiction books who have written books of other genres as well. 
*/
questionC(Author) :-
    wrote(Author, book1),
    book(book1, 'ficção'),
    wrote(Author, book2),
    book(book2, Genero),
    Genero \= 'ficção'.

/*
Answers to exercises:
    a) wrote(author, 'Os Maias').
    b) questionB(author).
    c) questionC(author).
*/