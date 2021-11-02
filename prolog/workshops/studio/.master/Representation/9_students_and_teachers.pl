aluno(joao, paradigmas).
aluno(maria, paradigmas).
aluno(joel, lab2).
aluno(joel, estruturas).

frequenta(joao, feup).
frequenta(maria, feup).
frequenta(joel, ist).

professor(carlos, paradigmas).
professor(ana_paula, estruturas).
professor(pedro, lab2).

funcionario(pedro, ist).
funcionario(ana_paula, feup).
funcionario(carlos, feup).

alunos_do_professor(X, Aluno) :-
    aluno(Aluno, Cadeira),
    professor(X, Cadeira).

pessoas_da_universidade(X, Pessoa) :-
    frequenta(Pessoa, X) ;
    funcionario(Pessoa, X).

colegas(P1, P2) :-
    (
        aluno(P1, Cadeira), aluno(P2, Cadeira) ;
        frequenta(P1, Faculdade), frequenta(P2, Faculdade) ;
        funcionario(P1, Faculdade), funcionario(P2, Faculdade)        
    ),
    P1 \= P2.