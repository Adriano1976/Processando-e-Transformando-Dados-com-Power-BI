# Desafio de Projeto DIO Processando e Transformando Dados com Power BI

Este projeto foi desenvolvido integrando uma base de dados MySQL com o uso do MySQL Workbench e Power BI. Após a construção e o tratamento da base de dados via Power Query, os dados foram exportados e ativados na nuvem, acessíveis através do link abaixo da imagem. Essa plataforma permite interações e comparações claras e objetivas dos dados por meio de gráficos de fácil compreensão. O `objetivo do projeto` é caracterizar os dados, que provêm de uma base de teste local, devido à impossibilidade de criar uma conta gratuita no Azure por falta de cartão de crédito.

![img-08](https://github.com/Adriano1976/Processando-e-Transformando-Dados-com-Power-BI/assets/17755195/d787785d-7a0f-4444-ba7b-229d87f2e4c6)

Fonte: https://app.powerbi.com/view?r=eyJrIjoiZjNkZTYzYTEtZjExMy00ZGI2LThjYzUtYTJjYjYxZjc1ZmI1IiwidCI6ImRmODY3OWNkLWE4MGUtNDVkOC05OWFjLWM4M2VkN2ZmOTVhMCJ9&pageName=ReportSection

# Análise do Gráfico da Company Aju

1. **Distribuição de Departamentos e Colaboradores**:
   - Existem três departamentos: Administração, Headquarters e Research.
   - O departamento de Research possui o maior número de funcionários (3), seguido pela Administração (2) e Headquarters (2).

2. **Horas Trabalhadas por Departamento**:
   - O total de horas trabalhadas é 275.
   - O departamento de Headquarters tem a maior quantidade de horas trabalhadas (44%), seguido por Research (29%) e Administração (27%).

3. **Gerenciamento de Funcionários**:
   - Cada gerente (Elizabeth, Michael, Joy e Theodore) é responsável por 7 funcionários.

4. **Salário por Funcionário**:
   - James é o funcionário com o salário mais alto, seguido por Jennifer, Franklin e Ramesh.
   - Ahmad, Alicia e Joyce estão na faixa mais baixa de salários (45,45%).

5. **Localização dos Colaboradores**:
   - Os funcionários estão distribuídos em quatro locais: Bellaire, Houston, Stafford e Sugarland.

6. **Horas Trabalhadas por Funcionário**:
   - Ahmad, Alicia, Franklin, James, Jennifer, John, Joyce e Ramesh são os funcionários cujas horas trabalhadas foram analisadas, destacando diferentes níveis de contribuição em horas.

Esses insights esclarecem a distribuição de recursos humanos, a carga de trabalho, os salários e a gestão de funcionários na empresa.

<hr>

### Tabela: departament

| Coluna           | Tipo      |
|------------------|-----------|
| ID_Departament   | Inteiro   |
| Dname            | Texto     |
| Dnumber          | Inteiro   |
| Mgr_ssn          | Desconhecido |
| Mgr_start_date   | Desconhecido |
| Dept_create_date | Desconhecido |

Resumo das Transformações:
1. Conexão com o banco de dados MySQL "azure_company_aju".
2. Remoção das colunas "azure_company_aju.dept_locations", "azure_company_aju.employee" e "azure_company_aju.project".
3. Adição de um índice à tabela.
4. Reordenação das colunas.
5. Renomeação da coluna de índice para "ID_Departament".

### Tabela: dependent

| Coluna          | Tipo      |
|-----------------|-----------|
| ID_Dependent    | Inteiro   |
| Dependent_name  | Texto     |
| Relationship    | Texto     |
| Sex             | Texto     |
| Date            | Data      |
| Essn            | Desconhecido |
| ID_Calendar     | Inteiro   |

Resumo das Transformações (tabela "dependent"):
1. Conexão com o banco de dados MySQL "azure_company_aju".
2. Remoção da coluna "azure_company_aju.employee".
3. Renomeação da coluna "Bdate" para "Date".
4. Adição de um índice à tabela.
5. Reordenação das colunas.
6. Mesclagem com a tabela "calendar_base" com base na coluna "Date".
7. Expansão da tabela mesclada.
8. Remoção da coluna "Date".

### Tabela: calendar_base

| Coluna          | Tipo      |
|-----------------|-----------|
| ID_Calendar     | Inteiro   |
| Date            | Data      |
| Dia             | Inteiro   |
| Nome do Dia     | Texto     |
| Nome do Mês     | Texto     |
| Ano             | Inteiro   |

Resumo das Transformações (tabela "calendar_base"):
1. Criação de uma lista de datas a partir de 01/01/1900 até a data atual.
2. Conversão da lista em uma tabela.
3. Renomeação das colunas.
4. Adição de um índice à tabela.
5. Reordenação das colunas.

### Tabela: dept_locations

| Coluna             | Tipo    |
|--------------------|---------|
| ID_Dept_Locations  | Inteiro |
| Dlocation          | Texto   |
| Dnumber            | Inteiro |

Resumo das Transformações:
1. Conexão com o banco de dados MySQL "azure_company_aju".
2. Remoção da coluna "azure_company_aju.departament".
3. Adição de um índice à tabela.
4. Reordenação das colunas.
5. Renomeação da coluna de índice para "ID_Dept_Locations".

### Tabela: employee

| Coluna      | Tipo    |
|-------------|---------|
| ID_Employee | Inteiro |
| Fname       | Texto   |
| Minit       | Texto   |
| Lname       | Texto   |
| Ssn         | Texto   |
| Date        | Data    |
| Address     | Texto   |
| Sex         | Texto   |
| Salary      | Desconhecido |
| Super_ssn   | Texto   |
| Dno         | Inteiro |

Resumo das Transformações (tabela "employee"):
1. Conexão com o banco de dados MySQL "azure_company_aju".
2. Substituição de valores nulos na coluna "Super_ssn" por "000000000".
3. Remoção das colunas "azure_company_aju.departament", "azure_company_aju.dependent" e "azure_company_aju.works_on".
4. Renomeação da coluna "Bdate" para "Date".
5. Adição de um índice à tabela.
6. Reordenação das colunas.
7. Mesclagem com a tabela "calendar_base" com base na coluna "Date".
8. Expansão da tabela mesclada.

### Tabela: calendar_base

| Coluna      | Tipo    |
|-------------|---------|
| ID_Calendar | Inteiro |
| Date        | Data    |
| Dia         | Inteiro |
| Nome do Dia | Texto   |
| Nome do Mês | Texto   |
| Ano         | Inteiro |

Resumo das Transformações (tabela "calendar_base"):
1. Criação de uma lista de datas a partir de 01/01/1900 até a data atual.
2. Conversão da lista em uma tabela.
3. Adição de colunas para o dia, nome do dia, nome do mês e ano.
4. Adição de um índice à tabela.
5. Reordenação das colunas.

### Tabela: project

| Coluna      | Tipo    |
|-------------|---------|
| ID_Project  | Inteiro |
| Pname       | Texto   |
| Pnumber     | Inteiro |
| Plocation   | Texto   |
| Dnum        | Inteiro |

Resumo das Transformações:
1. Conexão com o banco de dados MySQL "azure_company_aju".
2. Remoção das colunas "azure_company_aju.departament" e "azure_company_aju.works_on".
3. Classificação das linhas pela coluna "Pname" em ordem ascendente.
4. Adição de um índice à tabela.
5. Reordenação das colunas.
6. Renomeação da coluna de índice para "ID_Project".

Claro! Aqui está a documentação completa da tabela "works_on":

### Tabela: works_on

| Coluna       | Tipo    |
|--------------|---------|
| ID_Works_On  | Inteiro |
| Essn         | Texto   |
| Pno          | Inteiro |
| Hours        | Desconhecido |

Resumo das Transformações:
1. Conexão com o banco de dados MySQL "azure_company_aju".
2. Remoção das colunas "azure_company_aju.employee" e "azure_company_aju.project".
3. Adição de um índice à tabela.
4. Reordenação das colunas.
5. Renomeação da coluna de índice para "ID_Works_On".
6. Adição da coluna "HoursTime", calculada multiplicando a coluna "Hours" por 86400 (segundos em um dia).
7. Remoção da coluna "HoursTime".
8. Substituição dos valores de "Hours" igual a 0 pela média, que é 17.5.

Claro! Aqui está a documentação completa da tabela "calendar_base":

### Tabela: calendar_base

| Coluna      | Tipo    |
|-------------|---------|
| ID_Calendar | Inteiro |
| Date        | Data    |
| Dia         | Inteiro |
| Nome do Dia | Texto   |
| Nome do Mês | Texto   |
| Ano         | Inteiro |

Resumo das Transformações:
1. Geração de uma lista de datas a partir de 01/01/1900 até a data atual.
2. Conversão da lista de datas em uma tabela.
3. Renomeação da coluna da tabela para "Date".
4. Transformação do tipo de dados da coluna "Date" para tipo data.
5. Adição da coluna "Dia", que extrai o dia da data.
6. Adição da coluna "Nome do Dia", que mostra o nome do dia da semana.
7. Adição da coluna "Nome do Mês", que mostra o nome do mês.
8. Adição da coluna "Ano", que extrai o ano da data.
9. Adição de um índice à tabela.
10. Reordenação das colunas.
11. Renomeação da coluna de índice para "ID_Calendar".

<div align="center">
<br><p align="centre"><b>Contagem de visitantes</b></p>  
<p align="center"><img align="center" src="https://profile-counter.glitch.me/{Processando-e-Transformando-Dados-com-Power-BI}/count.svg" /></p> 
<br>  

<img width=100% src="https://capsule-render.vercel.app/api?type=waving&color=87CEFA&height=120&section=footer"/>**** 
</div>
