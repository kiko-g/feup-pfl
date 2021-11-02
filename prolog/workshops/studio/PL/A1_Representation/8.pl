cargo(tecnico, rogerio).
cargo(tecnico, ivone).
cargo(engenheiro, daniel).
cargo(engenheiro, isabel).
cargo(engenheiro, oscar).
cargo(engenheiro, tomas).
cargo(engenheiro, ana).
cargo(supervisor, luis).
cargo(supervisor_chefe, sonia).
cargo(secretaria_exec, laura).
cargo(diretor, santiago).

chefiado_por(tecnico, engenheiro).
chefiado_por(engenheiro, supervisor).
chefiado_por(analista, supervisor).
chefiado_por(supervisor, supervisor_chefe).
chefiado_por(supervisor_chefe, director).
chefiado_por(secretaria_exec, director).

%   Escreva em linguagem natural as seguintes interrogações Prolog:
%       a) ?- chefiado_por(tecnico, X), chefiado_por(X,Y).
%       b) ?- chefiado_por(tecnico, X), cargo(X,ivone), cargo(Y,Z).
%       c) ?- cargo(supervisor, X); cargo(supervisor, X).
%       d) ?- cargo(J,P), (chefiado_por(J, supervisor_chefe); chefiado_por(J, supervisor)).
%       e) ?- chefiado_por(P, director), not(cargo(P, carolina)).

%   a) Quem é o chefe do chefe do tecnico?
%   b) Se a Ivone for chefe do tecnico, quais sao todos os cargos?
%   c) 
%   d) 
%   e) 