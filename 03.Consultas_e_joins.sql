SELECT
c.consulta_id,
p.nome AS paciente_nome,
d.nome AS dentista_nome,
c.data_consulta
FROM
   Consulta c 
INNER JOIN
   Paciente p ON c.paciente_id = p.paciente_id
INNER JOIN
   Dentista d ON c.dentista_id = d.dentista_id;

SELECT 
t.tratamento_id, 
t.descricao AS tratamento_descricao,
p.nome AS procedimento_nome,
tp.quantidade,
pr.custo,
(tp.quantidade * pr.custo) AS custo_total
FROM
    Tratamento t
INNER JOIN 
	Tramento_Procedimento tp ON t.tratamento_id = tp.tratamento_id
INNER JOIN
Procedimento pr ON tp.procedimento_id = pr.procedimento_id;

select
p.pagamento_id,
t.descricao AS tratamento_descricao,
p.valor AS valor_pago,
p.data_pagamento

from
pagamento p

inner join
Tratamento t ON p.tratamento_id = t.tratamento_id;

Delimiter //
create trigger AtualizarCustoTratamento
after insert on Tratamento_procedimento
for each ROW
begin
 declare custo_total decimal(10, 2);




select SUM(tp.quantidade * p.custo) into custo_total
from tratamento_procedimento tp
join procedimento p ON tp.procedimento_id
where tp.tratamento_id = NEW.tratamento_id;


update tratamento
set valor_total = custo_total
where tratamento_id = NEW.tratamento_id;
end//
delimiter ;

