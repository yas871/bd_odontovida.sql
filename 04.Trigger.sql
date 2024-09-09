DELIMITER //
CREATE TRIGGER AtualizarCustoTratamento
AFTER INSERT ON Tratamento_Procedimento
FOR EACH ROW
BEGIN
     DECLARE custo_total DECIMAL(10, 2);
     
     -- Calcula o custo total do tratamento
     SELECT SUM(tp-quantidade * p.custo) INTO custo_total
     FROM Tratamento_Procedimento tp
     JOIN Procedimento p ON tp.procedimento_id = p.procedimento_id
     WHERE tp.tratamento_id = NEW.tratamento_id;
     
     -- Atualiza o valor total do tratamento na tabela Tratamento
     UPDATE Tratamento
     SET valor_total = custo_total
     WHERE tratamento_id = NEW.tratamento_id;
END//
DELIMITER ;

/*Vamos criar um procedure para gerar um relatório de todas as consultas de um específico, incluindo informações sobre o paciente, 
  dentista e data da consulta. Essa procedure pode ser útil para consultas rápidas de histórico de atendimento de um paciente.
*/
DELIMITER //

CREATE PROCEDURE RelatorioConsultasPaciente(IN pacienteID INT)
BEGIN
     -- Seleciona detalhes das consultas do paciente
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
           Dentista d ON c.dentista_id = d.dentista_id
     WHERE
         p.paciente_id = pacienteID;
END//

DELIMITER ;