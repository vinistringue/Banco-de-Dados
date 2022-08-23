/*	ATIVIDADE 2	*/


/* EXERCICIO 1 - Crie um stored procedure que receba id de cliente, data inicial e data final e que mostre a lista de compras 
realizadas pelo referido cliente entre as datas informadas (incluindo essas datas), mostrando nome do cliente, id da compra, total, nome 
e quantidade de cada produto comprado. No script, inclua o código de criação e uma chamada ao procedure.*/

DELIMITER $$
create procedure consulta_comprasClientes (id int, data_inicio date, data_final date)
begin
	select c.id as 'id_cliente', c.nome as 'nome_cliente', v.id as 'id_vendaProduto', i_t.nome_produto as 'nome_produto', i_t.quantidade
    as 'quantidade', i_t.subtotal as 'valor_total'
    
    from item_venda as i_t
    join venda as v on v.id = i_t.venda_id
    join cliente as c on c.id = v.cliente_id
    
    where c.id = id and date_format(v.data, '%y-%m-%d') between data_inicio and data_final
    order by v.id;
    
end
$$

call consulta_comprasClientes(2, '20220102', '20220501');




/* EXERCICIO 2 - Crie uma stored function que receba id de funcionário, data inicial e data final e retorne a comissão total desse 
funcionário no período indicado. No script, inclua o código de criação e uma chamada à function.*/

DELIMITER $$
create function comissao_funcionario (id_funcionario int, data_inicio date, data_final date)
returns decimal (10,2) deterministic
begin
	declare v_comissao float;
	declare v_total decimal(9,2);
    
    select c.comissao, SUM(subtotal) into v_comissao, v_total
    
    from funcionario as f
    join cargo as c on f.cargo_id=c.id 
    join venda as v on v.funcionario_id=f.id
    join item_venda as i on v.id=i.venda_id
    
    where f.id = id_funcionario and v.data between data_ini and data_fim ;
    
    return v_comissao*v_total/100;
end
$$

call comissao_funcionario(1, '20210210', '20221012')




/* EXERCICIO 3 - Crie uma stored function que receba id de cliente e retorne se o cliente é “PREMIUM” ou “REGULAR”. Um cliente é 
“PREMIUM” se já realizou mais de R$ 10 mil em compras nos últimos dois anos. Um cliente é “REGULAR” se ao contrário. No script, inclua o 
código de criação e uma chamada à function. */

create function fn_verificacaoCliente (Id int)
returns string

begin 
	declare cliente varchar
    select sum(v.valor_total) from venda as v
    where v.cliente_id = Id and v.data_envio > '2022-11-09'
    if sum(v.valor_total > 10000) then 
    set cliente := 'Cliente Premium'
    else 
    set cliente := 'Cliente Regular'
    end if
    select cliente 
    end 
$$
DELIMITER ;


select fn_verificacaoCliente(1, '2012-06-12', '2022-11-09');




/* EXERCICIO 4 - Crie um trigger que atue sobre a tabela “usuário” de modo que, ao incluir um novo usuário, aplique automaticamente
 MD5() à coluna “senha”. */
 
 DELIMITER $$
 create trigger insertmd5 before insert on usuario
 for each row
 begin 
	update usuario
    set senha = new.md5(senha)
    where id = new.id;
end 
$$
 




