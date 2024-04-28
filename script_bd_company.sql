 /* No código a seguir, está sendo criado um esquema denominado "azure_company_aju", 
caso ele ainda não exista, e em seguida é selecionado esse esquema para ser utilizado. 
Em seguida, é realizada uma consulta na tabela "table_constraints" do schema 
"information_schema", filtrando os resultados para mostrar apenas as restrições de 
tabela que pertencem ao esquema "azure_company_aju". Essa consulta retornará 
informações sobre as restrições de tabela presentes no esquema específico 
"azure_company_aju", se houver alguma.*/

create schema if not exists azure_company_aju;
use azure_company_aju;

select * from information_schema.table_constraints
	where constraint_schema = 'azure_company_aju';


-- restrição atribuida a um domínio
-- create domain D_num as int check(D_num> 0 and D_num< 21);

/* No código a seguir, está sendo criada uma tabela chamada "employee", que armazena 
informações sobre funcionários. Os campos incluem o primeiro nome (Fname), inicial 
do segundo nome (Minit), sobrenome (Lname), número do Seguro Social (Ssn), data de 
nascimento (Bdate), endereço (Address), sexo (Sex), salário (Salary), número do 
Seguro Social do supervisor (Super_ssn), número do departamento (Dno) e restrições 
como garantir que o salário seja superior a $2000.00 e que o número do Seguro 
Social seja único (pk_employee). Essa estrutura de tabela permite a gestão de 
dados detalhados sobre os funcionários de uma empresa, facilitando o controle 
e organização das informações. */

CREATE TABLE employee(
	Fname varchar(15) not null,
    Minit char,
    Lname varchar(15) not null,
    Ssn char(9) not null, 
    Bdate date,
    Address varchar(30),
    Sex char,
    Salary decimal(10,2),
    Super_ssn char(9),
    Dno int not null,
    constraint chk_salary_employee check (Salary> 2000.0),
    constraint pk_employee primary key (Ssn)
);


/* No código a seguir, está sendo adicionada uma restrição de chave 
estrangeira na tabela "employee", referenciando a coluna "Super_ssn" 
à coluna "Ssn" da mesma tabela. Essa restrição define que, ao excluir
 uma entrada na tabela referenciada, o valor da coluna "Super_ssn" 
 será definido como nulo, e ao atualizar uma entrada na tabela 
 referenciada, as alterações serão propagadas para a tabela "employee". 
 Além disso, está sendo modificado o tipo de dados da coluna "Dno" 
 para inteiro, tornando-a obrigatória (not null) e atribuindo o valor 
 padrão 1 caso não seja especificado. Em seguida, é exibida a descrição 
 da tabela "employee". */

alter table employee 
	add constraint fk_employee 
	foreign key(Super_ssn) references employee(Ssn)
    on delete set null
    on update cascade;

alter table employee modify Dno int not null default 1;
desc employee;


/* No código a seguir, está sendo criada uma tabela chamada "departament" 
com os campos Dname, Dnumber, Mgr_ssn, Mgr_start_date e Dept_create_date. 
Dname é uma string não nula de até 15 caracteres, Dnumber é um número 
inteiro não nulo, Mgr_ssn é uma string de 9 caracteres não nula que serve 
como chave estrangeira referenciando a tabela de funcionários (employee), 
Mgr_start_date e Dept_create_date são datas. Há restrições de integridade 
para garantir que a data de criação do departamento (Dept_create_date) seja 
anterior à data de início do gerente (Mgr_start_date), além de uma chave 
primária (pk_dept) no campo Dnumber e uma restrição de unicidade 
(unique_name_dept) no campo Dname. */

create table departament(
	Dname varchar(15) not null,
    Dnumber int not null,
    Mgr_ssn char(9) not null,
    Mgr_start_date date, 
    Dept_create_date date,
    constraint chk_date_dept check (Dept_create_date < Mgr_start_date),
    constraint pk_dept primary key (Dnumber),
    constraint unique_name_dept unique(Dname),
    foreign key (Mgr_ssn) references employee(Ssn)
);


-- 'def', 'company_constraints', 'departament_ibfk_1', 'company_constraints', 'departament', 'FOREIGN KEY', 'YES'
-- modificar uma constraint: drop e add

/* No código a seguir, está sendo realizada uma série de operações SQL para modificar a 
estrutura da tabela "departament". Primeiramente, é removida uma restrição de chave 
estrangeira chamada "departament_ibfk_1" da tabela "departament". Em seguida, é 
adicionada uma nova restrição de chave estrangeira chamada "fk_dept", que vincula 
a coluna "Mgr_ssn" da tabela "departament" à coluna "Ssn" da tabela "employee", 
com ação de atualização em cascata. Por fim, é exibida a descrição da estrutura 
atualizada da tabela "departament". */

alter table departament drop  departament_ibfk_1;
alter table departament 
		add constraint fk_dept foreign key(Mgr_ssn) references employee(Ssn)
        on update cascade;

desc departament;


/* No código a seguir, está sendo definida a estrutura de uma tabela chamada "dept_locations", 
que armazenará informações sobre as localizações dos departamentos. A tabela possui três colunas: 
"Dnumber" para o número do departamento, "Dlocation" para a localização do departamento e 
"constraint pk_dept_locations" para a definição de uma chave primária composta pelas colunas 
"Dnumber" e "Dlocation". Além disso, é estabelecida uma restrição de chave estrangeira 
"constraint fk_dept_locations", que referencia a coluna "Dnumber" à tabela "departament", 
garantindo integridade referencial entre as tabelas. */

create table dept_locations(
	Dnumber int not null,
	Dlocation varchar(15) not null,
    constraint pk_dept_locations primary key (Dnumber, Dlocation),
    constraint fk_dept_locations foreign key (Dnumber) references departament (Dnumber)
);


/* No código a seguir, está sendo realizado um processo de alteração na tabela "dept_locations". 
Primeiramente, é removida a restrição de chave estrangeira denominada "fk_dept_locations". 
Em seguida, é adicionada uma nova restrição de chave estrangeira, chamada "fk_dept_locations", 
que faz referência à coluna "Dnumber" da tabela "departament", utilizando a cláusula "on delete 
cascade" e "on update cascade" para especificar que, caso ocorra uma exclusão ou atualização na 
tabela "departament", essas ações serão refletidas automaticamente na tabela "dept_locations", 
garantindo a integridade referencial entre as tabelas. */

alter table dept_locations drop fk_dept_locations;
alter table dept_locations 
	add constraint fk_dept_locations foreign key (Dnumber) references departament(Dnumber)
	on delete cascade
    on update cascade;

	
/* No código a seguir, está sendo criada uma tabela chamada "project" com colunas para o nome 
do projeto ("Pname"), número do projeto ("Pnumber"), localização do projeto ("Plocation") e 
número do departamento associado ("Dnum"). A coluna "Pname" é definida como única, enquanto 
"Pnumber" é a chave primária. Além disso, há uma restrição de chave estrangeira ("fk_project") 
que referencia o número do departamento na tabela "departament". Isso garante que cada projeto 
esteja associado a um departamento existente, mantendo a integridade referencial dos dados. */

create table project(
	Pname varchar(15) not null,
	Pnumber int not null,
    Plocation varchar(15),
    Dnum int not null,
    primary key (Pnumber),
    constraint unique_project unique (Pname),
    constraint fk_project foreign key (Dnum) references departament(Dnumber)
);


/* No código a seguir, está sendo criada a tabela "works_on", que armazena informações sobre 
funcionários que trabalham em projetos específicos. A tabela possui três colunas: "Essn" para 
o número de seguridade social do funcionário, "Pno" para o número do projeto e "Hours" para as 
horas trabalhadas no projeto. A chave primária é composta pelas colunas "Essn" e "Pno", garantindo 
unicidade de cada entrada. Duas restrições de chave estrangeira são aplicadas para garantir que 
os valores em "Essn" estejam presentes na tabela "employee" e que os valores em "Pno" estejam 
presentes na tabela "project". As colunas são definidas com tipos de dados específicos para 
garantir precisão e integridade dos dados. */

create table works_on(
	Essn char(9) not null,
    Pno int not null,
    Hours decimal(3,1) not null,
    primary key (Essn, Pno),
    constraint fk_employee_works_on foreign key (Essn) references employee(Ssn),
    constraint fk_project_works_on foreign key (Pno) references project(Pnumber)
);


/* No código a seguir, está sendo realizado o gerenciamento de uma tabela chamada "dependent" em 
um banco de dados. Inicialmente, é solicitada a exclusão da tabela, caso já exista, seguida pela 
sua criação. A tabela "dependent" possui campos para armazenar o número de Seguro Social do 
funcionário ("Essn"), o nome do dependente ("Dependent_name"), sexo, data de nascimento, 
relacionamento com o funcionário e uma chave primária composta pelos campos "Essn" e "Dependent_name". 
Além disso, é definida uma restrição de chave estrangeira ("fk_dependent") para garantir que o campo 
"Essn" faça referência à tabela "employee". Por fim, são exibidas as tabelas existentes e suas 
descrições para verificação e validação. */

drop table dependent;

create table dependent(
	Essn char(9) not null,
    Dependent_name varchar(15) not null,
    Sex char,
    Bdate date,
    Relationship varchar(8),
    primary key (Essn, Dependent_name),
    constraint fk_dependent foreign key (Essn) references employee(Ssn)
);

show tables;
desc dependent;