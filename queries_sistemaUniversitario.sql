CREATE TABLE IF NOT EXISTS tb_pessoa (
    pessoa_id SERIAL PRIMARY KEY,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    logradouro VARCHAR(255),
    num INT,
    complemento VARCHAR(100),
    bairro VARCHAR(100),
    senha_hash VARCHAR(255) NOT NULL 
);

CREATE TABLE IF NOT EXISTS tb_curso (
    curso_id VARCHAR(20) PRIMARY KEY, 
    nome VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS tb_aluno (
    aluno_pessoa_id INT PRIMARY KEY,                 
    matricula_aluno VARCHAR(50) UNIQUE NOT NULL,
    curso_id VARCHAR(20) NOT NULL,               
    
    FOREIGN KEY (aluno_pessoa_id) REFERENCES tb_pessoa(pessoa_id) ON DELETE CASCADE,
    FOREIGN KEY (curso_id) REFERENCES tb_curso(curso_id)
);


CREATE TABLE IF NOT EXISTS tb_professor (
    professor_pessoa_id INT PRIMARY KEY,                 
    professor_id_funcional VARCHAR(50) UNIQUE NOT NULL, 
    especialidade VARCHAR(100),
    curso_id VARCHAR(20) UNIQUE NOT NULL,
    
    FOREIGN KEY (professor_pessoa_id) REFERENCES tb_pessoa(pessoa_id) ON DELETE CASCADE,
    FOREIGN KEY (curso_id) REFERENCES tb_curso(curso_id)
);

CREATE TABLE IF NOT EXISTS tb_disciplina (
    codigo VARCHAR(20) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    creditos INT,
    curso_id VARCHAR(20) NOT NULL,
    
    FOREIGN KEY (curso_id) REFERENCES tb_curso(curso_id)
);

CREATE TABLE IF NOT EXISTS tb_turma (
    turma_id VARCHAR(20) PRIMARY KEY,     
    periodo_letivo VARCHAR(10) NOT NULL,
    vagas INT,
    disciplina_codigo VARCHAR(20) NOT NULL,
    professor_pessoa_id INT NOT NULL,   
    
    FOREIGN KEY (disciplina_codigo) REFERENCES tb_disciplina(codigo),
    FOREIGN KEY (professor_pessoa_id) REFERENCES tb_professor(professor_pessoa_id)
);

CREATE TABLE IF NOT EXISTS tb_matricula_aluno_turma (
    aluno_pessoa_id INT NOT NULL, 
    turma_id VARCHAR(20) NOT NULL, 
    
    
    nota_final FLOAT,
    frequencia FLOAT,
    
   
    PRIMARY KEY (aluno_pessoa_id, turma_id),
    
    
    FOREIGN KEY (aluno_pessoa_id) REFERENCES tb_aluno(aluno_pessoa_id) ON DELETE CASCADE,
    FOREIGN KEY (turma_id) REFERENCES tb_turma(turma_id) ON DELETE CASCADE
);


SELECT p.nome, p.email, a.matricula_aluno
FROM tb_pessoa p
JOIN tb_aluno a ON p.pessoa_id = a.aluno_pessoa_id


SELECT
    p.nome,
    p.email,
    a.matricula_aluno,
    pr.professor_id_funcional
FROM
    tb_pessoa p
LEFT JOIN
    tb_aluno a ON p.pessoa_id = a.aluno_pessoa_id
LEFT JOIN
    tb_professor pr ON p.pessoa_id = pr.professor_pessoa_id;
