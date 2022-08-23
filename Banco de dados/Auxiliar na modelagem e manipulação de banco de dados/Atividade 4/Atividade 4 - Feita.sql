/*ATIVIDADE 2 - Montandos as tabelas, estruturas e fazendo o relacionamento*/
/* Criando e usando o banco de dados*/
create database hospital;
use hospital;


/*Criando tabela "medicos" no banco de dados*/
create table medicos (
idMedicos int not null auto_increment,
nome varchar (150) not null, 
cpf varchar (14) not null unique, 
crm varchar (20) not null,
data_nascimento date not null, 
telefone varchar (20) not null, 
endereco varchar (200)not null,
primary key (idMedicos));


/*Criando tabela "especialidade" no banco de dados*/
create table especialidade (
idEspecialidade int not null auto_increment, 
descricao text not null, 
especialidade varchar (75) not null,
primary key (idEspecialidade));


/*Criando tabela "medicos_especialidade no banco de dados*/
create table medicos_especialidades (
medicos_id int not null , 
especialidade_id int not null,
foreign key (medicos_id) references medicos(idMedicos) on delete cascade,
foreign key (especialidade_id) references especialidade(idEspecialidade) on delete cascade);


/*Criando tabela "convenio" no banco de dados*/
create table convenio (
idConvenio int not null auto_increment,
nome varchar (150) not null, 
cnpj varchar (30) not null unique, 
tempo_carencia datetime not null, 
num_carteirinha varchar (25) not null, 
primary key (idConvenio));


/*Criando tabela "pacientes" no banco de dados*/
create table pacientes (
idPacientes int not null auto_increment, 
nome varchar (150) not null, 
data_nascimento date not null, 
endereço varchar (200) not null, 
telefone varchar (20) not null, 
email varchar (150) not null, 
cpf varchar (20) not null unique, 
rg varchar (45) not null, 
convenio_id int not null, 
primary key (idPacientes), 
foreign key (convenio_id) references convenio(idConvenio) on delete cascade);


/*Criando tabela "consultas" no banco de dados*/
create table consultas (
idConsulta int not null auto_increment, 
data_hora datetime not null, 
valor decimal (9,2), 
medicos_id int not null, 
pacientes_id int not null, 
convenio_id int not null,
primary key (idConsulta), 
foreign key (medicos_id) references medicos(idMedicos) on delete cascade,
foreign key(pacientes_id) references pacientes(idPacientes) on delete cascade,
foreign key (convenio_id) references convenio(idConvenio) on delete cascade);


/*Criando tabela "receitas" no banco de dados*/
create table receitas (
idReceita int not null auto_increment, 
receita_medica varchar (200),
consulta_id int not null, 
primary key (idReceita), 
foreign key (consulta_id) references consultas(idConsulta) on delete cascade);


/*Criando tabela "tipo_quarto" no banco de dados*/
create table tipo_quarto (
idtipo_quarto int not null auto_increment, 
descrição varchar (150) not null, 
valor decimal (9,2), 
primary key (idtipo_quarto));


/*Criando tabela "enfermeira" no banco de dados*/
create table enfermeira (
idEnfermeira int not null auto_increment, 
nome varchar (150) not null, 
cpf varchar (15) not null, 
cre varchar (45) not null, 
primary key(idEnfermeira));


/*Criando tabela "quartos" no banco de dados*/
create table quartos (
idQuarto int not null auto_increment, 
num_quarto int not null, 
tipo_quarto_id int not null, 
primary key (idQuarto), 
foreign key (tipo_quarto_id) references tipo_quarto (idtipo_quarto) on delete cascade);


/*Criando tabela "internacoes" no banco de dados*/
create table internacoes (
idInternacoes int not null auto_increment, 
data_entrada datetime not null,
data_prevista_alta datetime not null, 
data_alta datetime not null, 
quarto_id int not null, 
paciente_id int not null, 
medicos_id int not null,
primary key (idInternacoes), 
foreign key (quarto_id) references quartos(idQuarto) on delete cascade, 
foreign key (paciente_id) references pacientes(idPacientes) on delete cascade, 
foreign key (medicos_id) references medicos (idMedicos) on delete cascade);


/*Criando tabela "internacoes_enfermeira no banco de dados*/
create table internacoes_enfermeira (
internacoes_id int not null, 
enfermeira_id int not null,
foreign key (internacoes_id) references internacoes(idInternacoes) on delete cascade, 
foreign key (enfermeira_id) references enfermeira(idEnfermeira) on delete cascade);


/*ATIVIDADE 3 - PARTE 01* - INSERINDO DADOS NAS TABELAS*/
/*Inserindo dados na tabela "medicos"*/
insert into medicos (idMedicos, nome, cpf, crm, data_nascimento, telefone, endereco) values
(default, 'Anny Quintanilha', '861324730-09', '120935', '1970-11-10', '(69)3752-5488', 'Rio Grande do Sul'), 
(default, 'Alisson Sacramento', '808142790-23', '178105', '1981-01-15', '(79)2718-0264', 'Minas Gerais'), 
(default, 'Lívia Veloso', '209249870-30', '17897', '1972-03-22', '(61)3019-1483', 'Minas Gerais'), 
(default, 'Gael Milheiro Lemes', '386037370-61', '9826', '1964-02-13', '(82)2433-7762', 'Rio Grande do Sul'), 
(default, 'Gisela Espinosa', '235290910-49', '34548', '1980-09-12', '(86)3368-4812', 'São Paulo'), 
(default, 'Nelson Anjos Palmeira', '036266390-45', '344789', '1980-10-14', '(54)3941-4795', 'São Paulo'),
(default, 'Ezequiel Pestana Henriques', '672979590-57', '9756', '1979-06-30', '(69)2537-6076', 'Rio Grande do Sul'),
(default, 'Tito Carqueijeiro', '745886510-56', '14777', '1973-05-19', '(83)3272-8326', 'Rio Grande do Sul'),
(default, 'Cristovão Xavier', '926904900-05', '67432', '1979-12-12', '(24)2448-9465', 'Rio Grande do Sul'), 
(default, 'Júlia Camarinho', '744925960-54', '24654', '1980-07-05', '(61)2615-4776', 'Minas Gerais');

/*Consultar dados tabela "medicos"*/
select * from medicos;


/*Inserindo dados na tabela "especialidade"*/
insert into especialidade (idEspecialidade, descricao, especialidade) values
(default, 'A pediatria é a especialidade médica dedicada à assistência à criança e ao adolescente, nos seus diversos aspectos, sejam eles preventivos ou curativos.', 'Pediatria'), 
(default, 'A dermatologia é a especialidade médica que se ocupa do diagnóstico e tratamento clínico-cirúrgico das enfermidades relacionados à pele e aos anexos cutâneos.', 'Dermatologia'),
(default, 'A gastroenterelogia é a especialidade responsável pelo cuidado do estômago, intestinos, pâncreas e fígado.', 'Gastroenterelogia'),
(default, 'Médico de família é a denominação pela qual é habitualmente conhecido o médico especialista em atenção primária, para tal é necessário ampla capacitação em diversas áreas da medicina', 'Clinico Geral'),
(default, 'Neurologia é a especialidade médica que trata dos distúrbios estruturais do sistema nervoso.' , 'Neurologia'),
(default, 'Cardiologia é a especialidade médica que se ocupa do diagnóstico e tratamento das doenças que acometem o coração bem como os outros componentes do sistema circulatório.', 'Cardiologia'),
(default, 'Endocrinologia é uma especialidade médica que estuda as ordens do sistema endócrino e suas secreções específicas, chamadas de secreções fisiológicas.', 'Endocrionologia'),
(default, 'A oncologia ou cancerologia, também chamada cancrologia, é a especialidade médica que, à procura do tratamento do paciente, estuda os cânceres, também chamados cancros, que são tumores malignos, e a forma como essas doenças desenvolvem-se nos organismos em que estão.', 'Oncologia');

/*Consultar dados tabela "especialidade"*/
select * from especialidade;


/*Inserindo dados/relacionamento "medicos_especialidades"*/
insert into medicos_especialidades values
(1,8),
(2,2),
(2,4),
(3,1),
(4,1),
(4,4),
(5,5),
(6,5), 
(7,8),
(8,7), 
(8,4),
(9,3),
(9,4), 
(10,2),
(10,4);

/*Consultar dados tabela "medicos_especialidades"*/
select * from medicos_especialidades;


/*Inserindo dados na tabela "convenio*/
insert into convenio (idConvenio, nome, cnpj, tempo_carencia, num_carteirinha) values 
(default, 'MedMais', '66.455.126/0001-69', '2022-10-20 19:00:00', '55643215'), 
(default, 'UniSaude', '05.954.618/0001-04', '2023-05-10 20:00:00', '12341234'), 
(default, 'ProHeath', '18.492.111/0001-28', '2024-04-29 13:00:00', '12342342'),
(default, 'Bradesco', '76.847.987/0001-46', '2024-11-03 17:00:00', '23940268');

/*Consultar dados tabela "convenio"*/
select * from convenio;

 
/*Inserindo dados na tabela "pacientes"*/
insert into pacientes (idPacientes, nome, data_nascimento, endereço, telefone, email, cpf, rg, convenio_id) values 
(default, 'Manuela Isabelle Lopes', '1952-06-08', 'São Paulo', '(11)98218-0894', 'manuela_isa@arecocomercial.com.br', '843.823.061-08', '24.535.348-3', 1),
(default, 'Sophia Alana Malu Galvão', '1973-03-16', 'Rio Grande do Sul', '(69)98575-5325', 'sophia.alana.galvao@estagiarios.com', '349.322.022-70', '10.472.940-5', 2),
(default, 'Nicolas Benício Mário Nascimento', '1949-06-04', 'Rio Grande do Sul', '(69)98248-7159', 'nicolasbenicionascimento@transmazza.com.br', '068.960.900-06', '47.847.276-6', 2),
(default, 'Lívia Emanuelly Jaqueline Gomes', '1943-04-20', 'Minas Gerais', '(61)99798-3080', 'livia-gomes72@edepbr.com.br', '385.615.652-68', '36.315.125-4', 1), 
(default, 'Bento Fábio Barros', '1960-03-08', 'São Paulo', '(11)99221-3010', 'bento.fabio.barros@hushmail.com', '059.128.884-28', '41.250.728-6', 3), 
(default, 'Elisa Giovana Moreira', '1988-03-24', 'São Paulo', '(11)99861-5800', 'elisagiovanamoreira@ctecnologia.com.br', '369.991.199-37', '17.493.670-9', 2), 
(default, 'Luan Edson da Mota', '1972-06-06', 'Minas Gerais', '(61) 99452-2418', 'luan-damota78@laramjeirabaumann.com.br', '446.651.867-07', '43.487.242-8', 4), 
(default, 'Iago Pedro Martins', '1988-05-18', 'Rio Grande do Sul', '(69)98584-2337', 'iago_pedro_martins@dvdja.com.br', '696.516.993-10', '29.422.060-4', 1),
(default, 'Kamilly Raquel Almada', '1958-04-24', 'São Paulo', '(11)99469-3567', 'kamillyraquelalmada@clubedorei.com.br', '915.466.759-30', '18.485.172-5', 2), 
(default, 'Cristiane Sara', '1951-06-14', 'Minas Gerais', '(61)99631-4726', 'cristiane_monteiro@rcstechnology.com.br', '982.387.179-57', '14.921.016-4', 3), 
(default, 'Vicente Noah Marcelo Silva', '2004-06-10', 'São Paulo', '(11)99934-7248', 'vicentenoahsilva@s2solucoes.com.br', '004.336.732-14', '31.781.294-4', 4), 
(default, 'Benedito Filipe Carvalho', '2000-10-10', 'Rio Grande do Sul', '(69)98480-5267', 'benedito_filipe_carvalho@ficopola.net', '238.685.001-38', '35.432.289-8', 1), 
(default, 'Laís Priscila Nina Nunes', '1997-12-20', 'Minas Gerais', '(61)94783-8938', 'lais.priscila.nunes@somma.net.br', '351.229.811-75', '44.593.696-4', 1),
(default, 'Luciana Emily Brito', '1990-09-10', 'Rio Grande do Sul', '(69)94563-9809', 'luciana-brito78@yahoo.com.br', '628.813.714-69', '26.165.512-7', 2),
(default, 'Ester Lara Lara Aragão', '1987-01-07', 'São Paulo', '(11)94355-0987', 'ester.lara.aragao@debiasi.com.br', '778.591.340-47', '50.502.069-5', 3);

/*Consultar dados tabela "pacientes"*/
select * from pacientes;


/*Inserindo dados na tabela "consultas"*/
insert into consultas (idConsulta, data_hora, valor, medicos_id, pacientes_id, convenio_id) values 
(default, '2015-03-12 11:30:00', '130.00', 6, 1, 1),
(default, '2015-08-20 15:00:00', '180.00', 5, 1, 1),
(default, '2016-02-16 08:45:00', '140.00', 2, 2, 2), 
(default, '2016-10-08 10:30:00', '140.00', 5, 3, 2),
(default, '2017-01-21 09:30:00', '130.00', 1, 4, 1), 
(default, '2017-05-10 17:00:00', '180.00', 9, 5, 3),
(default, '2018-08-28 15:45:00', '200.00', 1, 6, 2),
(default, '2018-11-01 09:00:00', '190.00', 8, 7, 4),
(default, '2018-12-15 11:30:00', '200.00', 2, 7, 4),
(default, '2019-01-17 11:00:00', '180.00', 3, 11, 4),
(default, '2019-04-10 08:45:00', '200.00', 8, 8, 1),
(default, '2019-10-11 10:00:00', '180.00', 3, 11, 4),
(default, '2020-03-10 07:45:00', '190.00', 4, 9, 2),
(default, '2020-06-08 08:30:00', '220.00', 8, 10, 3),
(default, '2020-10-22 10:15:00', '200.00', 2, 12, 1), 
(default, '2021-07-02 09:50:00', '190.00', 10, 13, 1),
(default, '2021-10-09 10:45:00', '230.00', 6, 14, 2),
(default, '2021-12-20 16:00:00', '240.00', 5, 15, 3),
(default, '2022-01-01 15:30:00', '230.00', 6, 15, 3);

/*Consultar dados tabela "consultas"*/
select * from consultas;

/*Inserindo dados na tabela "tipo_quarto"*/
insert into tipo_quarto values 
(default, 'Apartamento', '1.000'), 
(default, 'Quarto Duplo', '700.00'),
(default, 'Enfermaria', '500.00');

/*Consultar dados da tabela "tipo_quarto"*/
select * from tipo_quarto;


/*Inserindo dados na tabela "receitas"*/
insert into receitas values 
(default, 'Tomar Depakene 500mg duas vezes ao dia de 12h em 12 horas', 2),
(default, 'Tomar Depekane 250mg duas vezes ao dia de 12h em 12 horas', 4), 
(default, 'Passar polaramine 3 vezes ao dia, manha, tarde e noite antes de dormir', 3),
(default, 'Tomar cataflan 3 vezes ao dia, manha, tarde e noite antes de deitar', 8),
(default, 'Tomar Allegra 180 mg uma vez ao dia', 13),
(default, 'Passar polaramine 3 vezes ao dia', 5),
(default, 'Tomar Allegra 180 mg uma vez ao dia', 8), 
(default, 'Tomar Benegrip de 8h em 8horas', 9), 
(default, 'Tomar Depakene 250mg de manha e de 500mg a noite (12h em 12horas)', 16);

/*Consultar dados na tabela "receitas"*/
select * from receitas;


select * from consultas;
select * from tipo_quarto;

/*Inserindo dados a tabela "quartos"*/
insert into quartos values 
(default, 1, 1), 
(default, 2, 1),
(default, 3, 2),
(default, 4, 3), 
(default, 5, 2),
(default, 6, 1);

/*Consultar dados na tabela "quartos"*/
select * from quartos;


/*Inserindo dados na tabela "internacoes"*/
insert into internacoes (idInternacoes, data_entrada, data_prevista_alta, data_alta, quarto_id, paciente_id, medicos_id) values
(default, '2015-03-12 11:30:00', '2015-03-17 12:00:00', '2015-03-17 12:00:00', 1, 1, 6),
(default, '2015-08-20 15:00:00', '2015-08-26 15:00:00', '2015-08-26 15:00:00', 1, 1, 5),
(default, '2016-10-08 10:30:00', '2016-10-12 10:30:00', '2016-10-12 10:00:00', 2, 3, 5), 
(default, '2016-02-16 08:45:00', '2016-02-18 10:00:00', '2016-02-18 10:00:00', 3, 2, 2), 
(default, '2017-01-21 09:30:00', '2017-01-29 10:00:00', '2017-01-29 10:00:00', 4, 4, 1), 
(default, '2018-11-01 09:00:00', '2018-11-05 10:00:00', '2018-11-05 10:00:00', 5, 7, 8),
(default, '2018-12-15 11:30:00', '2018-12-18 11:00:00', '2018-12-18 11:00:00', 6, 7, 2), 
(default, '2021-07-02 09:50:00', '2021-07-10 09:50:00', '2021-07-10 09:50:00', 1, 13, 10);

/*Consultar dados da tabela "internacoes"*/
select * from internacoes;


/*Inserindo dados na tabela "enfermeira"*/
insert into enfermeira values 
(default, 'Ana Laura Santos', '297524581-57', '29752'),
(default, 'Ana Pires', '164029237-37', '16202'), 
(default, 'Isadora Campos', '856268676-00', '85626'), 
(default, 'Camila Nunes', '467621447-21', '46762'),
(default, 'Isabella Moura', '256394012-57', '25639'),
(default, 'Júlia Alves', '423382599-55', '42338'), 
(default, 'Isadora Melo', '443674847-26', '44367'),
(default, 'Rafael Nogueira', '547374521-06', '54737'),
(default, 'Davi Luiz Almeida', '666773432-00', '66677'),
(default, 'Alexandre da Paz', '656113964-02', '65611');

/*Consultar dados da tabela "enfermeira"*/
select * from enfermeira;


select * from internacoes_enfermeira;
select * from enfermeira;
select * from internacoes;

/*Inserindo dados na tabela "internacoes_enfermeira"*/
insert into internacoes_enfermeira values 
(1, 1), 
(1, 2), 
(2, 3),
(2, 4), 
(3, 5),
(3, 6),
(4, 7),
(4, 8), 
(5, 9), 
(5, 10), 
(6, 1), 
(6, 2), 
(7, 3), 
(7, 4), 
(8, 5), 
(8, 6);

/*Consultar a tabela internacoes_enfermeira*/
select * from internacoes_enfermeira;


/*ATIVIDADE 3 - PARTE 02 - ATUALIZANDO E EXCLUINDO DADOS*/
/*Adicionando nova coluna na tabela"*/
alter table medicos add column em_andamento varchar (15) not null;

/*Atualizando dados da tabela "medicos" na coluna "em_andamento"*/
update medicos set em_andamento = 'Ativo' where idMedicos = 1;
update medicos set em_andamento = 'Ativo' where idMedicos = 2;
update medicos set em_andamento = 'Ativo' where idMedicos = 3;
update medicos set em_andamento = 'Inativo' where idMedicos = 4;
update medicos set em_andamento = 'Ativo' where idMedicos = 5;
update medicos set em_andamento = 'Ativo' where idMedicos = 6;
update medicos set em_andamento = 'Inativo' where idMedicos = 7;
update medicos set em_andamento = 'Ativo' where idMedicos = 8;
update medicos set em_andamento = 'Ativo' where idMedicos = 9;
update medicos set em_andamento = 'Ativo' where idMedicos = 10;

/*Consultar os dados atualizados da tabela "medicos"*/
select * from medicos;


/*Atualizando dados da tabela "internacoes"*/
update internacoes set data_prevista_alta = '2017-01-24 10:00:00' where idInternacoes = 5;
update internacoes set data_alta = '2017-01-24 10:00:00' where idInternacoes = 5;

/*Consultar dados atualizados na tabela "internacoes"*/
select * from internacoes;


/*Apagando dados da tabela "convenio"*/
delete from convenio where idConvenio = 4;

/*Consultar dado que foi deletado da tabela "convenio"*/
select * from convenio;


/*ATIVIDADE 4 - CONSULTAS*/

/*QUESTÃO 01*/
SELECT YEAR(data_hora) as Ano , COUNT(*) as Total, AVG(valor) as Média
FROM consultas WHERE convenio_id IS NOT NULL and YEAR(data_hora) = '2020'
GROUP BY YEAR(data_hora);


/*QUESTÃO 02*/
SELECT * FROM internacoes
WHERE data_prevista_alta < data_alta;


/*QUESTÃO 03*/
SELECT R.receita_medica, C.idConsulta
FROM receitas AS R  INNER JOIN consultas as C on (C.idConsulta=R.consulta_id)
WHERE C.idConsulta between 0 and 10;


/*QUESTÃO 04*/
SELECT * FROM consultas WHERE valor = (SELECT MAX(valor)FROM consultas WHERE convenio_id IS NULL) AND convenio_id IS NULL;
SELECT * FROM consultas WHERE valor = (SELECT MIN(valor)FROM consultas WHERE convenio_id IS NULL) AND convenio_id IS NULL;


/*QUESTÃO 05*/
SELECT i.idInternacoes AS 'ID', i.data_entrada AS 'DATA ENTRADA', i.data_prevista_alta AS 'DATA PREVISÃO ALTA',i.data_alta AS 'DATA ALTA',
 i.quarto_id AS 'Nº QUARTO', tp.valor AS 'VALOR DIÁRIA',
(tp.valor * DATEDIFF(i.data_alta, i.data_entrada)) AS 'TOTAL INTERNAÇÃO', DATEDIFF(i.data_alta, i.data_entrada) AS 'TOTAL DE DIAS'
FROM
internacoes AS i
JOIN quartos AS q ON q.idQuarto = i.quarto_id
JOIN tipo_quarto AS tp ON tp.idtipo_quarto = q.idQuarto
ORDER BY i.idInternacoes;

/*QUESTÃO 06*/	
SELECT i.data_entrada, i.data_prevista_alta, i.data_alta, q.num_quarto
FROM internacoes AS i
JOIN quartos AS q
WHERE q.num_quarto = "1";

/*QUESTÃO 07*/
 SELECT p.nome AS 'PACIENTE', c.data_hora AS 'DATA', e.especialidade AS 'ESPECIALIDADE'
 FROM consultas AS c
 LEFT JOIN pacientes AS p ON p.idPacientes = c.pacientes_id
 INNER JOIN especialidade AS e ON e.idEspecialidade = me.especialidade_id
 JOIN medicos_especialidades as me ON me.medicos_id = m.idMedicos
 JOIN medicos AS m
 WHERE TIMESTAMPDIFF(YEAR, p.data_nascimento, curdate()) <= 18 AND idEspecialidade NOT LIKE '1';


/*QUESTÃO 08*/ 
SELECT p.nome AS 'PACIENTE', m.nome AS 'MEDICO', i.data_entrada AS 'DATA DE ENTRADA', 
 i.data_prevista_alta AS 'DATA PREVISTA PARA ALTA', i.data_alta AS 'DATA DE ALTA',
  e.especialidade AS 'ESPECIALIDADE', tq.descrição AS 'TIPO DO QUARTO'
 FROM
 internacoes AS i
 JOIN pacientes AS p 
 JOIN medicos AS m 
 JOIN medicos_especialidades AS me ON m.idMedicos = me.medicos_id
 JOIN especialidade AS e ON me.medicos_especialidades = e.idEspecialidade
 JOIN quartos AS q ON q.idQuarto = i.quarto_id
 JOIN tipo_quarto AS tq ON tq.idtipo_quarto = q.tipo_quarto_id
 WHERE e.especialidade LIKE 'Gastroenterologista' AND tq.descrição LIKE 'enfermeira'
 ORDER BY i.idInternacoes;
 

/*QUESTÃO 09*/
SELECT m.nome AS 'NOME MÉDICO', m.crm AS 'CRM', COUNT(m.nome) AS 'N° CONSULTAS'
 FROM medicos AS m
 JOIN consultas c ON c.medicos_id = m.idMedicos
 GROUP BY m.idMedicos;


/*QUESTÃO 10*/
SELECT e.nome AS 'ENFERMEIRO(A)', e.cre AS 'CRE', COUNT(e.nome) AS 'N° INTERNAÇÕES'
 FROM enfermeira AS e
 JOIN internacoes_enfermeira AS ie ON ie.internacoes_id = e.idEnfermeira
 GROUP BY e.idEnfermeira HAVING COUNT(*) > 1;
