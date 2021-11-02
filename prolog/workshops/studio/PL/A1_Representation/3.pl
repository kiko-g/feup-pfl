/*      Exercise 3 | Books

Questions
    a) Quem escreveu “Os Maias”?
    b) Que autores portugueses escrevem romances? 
    c) Quais os autores de livros de ficção que escreveram livros de outro tipo também?
Answers
    a) wrote(author, 'Os Maias').
    b) questionB(Author).
    c) questionC(Author).
*/
book('Os Maias', 'romance').
author('Eça de Queiroz', 'portugues').
wrote('Eça de Queiroz', 'Os Maias').
nationality('portugues').
nationality('ingles').
genre('romance').
genre('ficcao').


questionB(Author):-
    author(Author, 'portugues'),
    wrote(Author, book),
    book(book, 'romance').

questionC(Author):-
    wrote(Author, book1),
    book(book1, 'ficcao'),
    wrote(Author, book2),
    book(book2, Genre),
    Genre \= 'ficcao'.
