# Sistema de Gestão Escolar

Trabalho Final da disciplina **Arquitetura de Software** — Universidade Federal do Ceará (UFC).

Aplicação web para a rotina acadêmica de uma instituição de ensino, projetada segundo a **Arquitetura Hexagonal (Ports and Adapters)** e documentada com o **modelo C4 (Structurizr)**.

- **Domínio sorteado:** Tema 7 — Sistema de Gestão Escolar
- **Estilo arquitetural:** Arquitetura Hexagonal

## Equipe

| Integrante | Matrícula | Responsabilidade principal |
|---|---|---|
| Cícero Higor de Medeiros Carnauba | 574228 | Documento de visão (estruturação e revisão) |
| Emilly Wictoria Pinheiro Ferreira | 567253 | Documento de funcionalidades |
| Gabriel Ribeiro de Sousa | 567908 | Diagrama de Container e documento de entrega (decisão arquitetural) |
| Kawan Torres Lopes | 563869 | Diagramas |
| Layssa da Silva de Oliveira | 564923 | Documento de visão (redação) |
| Mel Barbosa Mello | 571597 | README, Issues do GitHub e revisão do documento de funcionalidades |

> A divisão detalhada das atividades está nas **Issues** deste repositório.

## Sobre o sistema

O foco é o fluxo básico entre secretaria, professores e alunos: cadastro de usuários, abertura de turmas, matrícula de alunos e lançamento de notas com consulta de boletim.

### Perfis de acesso

| Perfil | Pode | Restrições |
|---|---|---|
| **Administrador** (`ADMIN`) | Cadastrar alunos e professores, criar turmas (disciplina, período letivo e professor) e matricular alunos | Não lança notas |
| **Professor** (`PROFESSOR`) | Ver suas turmas e lançar/editar notas dos alunos matriculados | Não cria turmas, não cadastra usuários e não acessa turmas de outros professores |
| **Aluno** (`ALUNO`) | Consultar suas turmas e o boletim (notas e média) | Somente leitura dos próprios dados |

### Funcionalidades

| ID | Funcionalidade | Perfil |
|---|---|---|
| RF01 | Login e controle de acesso (e-mail e senha, token JWT com o perfil) | Todos |
| RF02 | Cadastro de alunos e professores | Administrador |
| RF03 | Criação e listagem de turmas | Administrador |
| RF04 | Matrícula de alunos | Administrador |
| RF05 | Lançamento de notas | Professor |
| RF06 | Consulta de boletim | Aluno |

### Regras de negócio

- **Faixa de notas:** toda nota deve estar entre 0 e 10.
- **Vínculo do professor:** só lança ou altera notas em turmas em que é o professor responsável.
- **Matrícula única:** um aluno não pode ser matriculado duas vezes na mesma turma.
- **Nota só para matriculados:** é necessário haver matrícula ativa do aluno na turma.
- **Situação no boletim:** média das notas da turma; *Em curso*, *Aprovado* (média ≥ 7,0) ou *Reprovado* (média < 7,0).

### Fluxos principais

1. Administrador: login → cria turma vinculada a um professor → matricula um aluno.
2. Professor: login → abre turma sob sua responsabilidade → lança a nota do aluno.
3. Aluno: login → abre o boletim → vê nota, média e situação.

## Arquitetura

A aplicação segue a Arquitetura Hexagonal, isolando as regras acadêmicas de frameworks e do banco de dados.

- **Domínio (núcleo):** entidades e regras de negócio (Aluno, Professor, Turma, Disciplina, Matrícula, Nota), sem dependência de framework ou driver de banco.
- **Portas de entrada (driving):** contratos dos casos de uso, por exemplo `MatricularAlunoUseCase`, `LancarNotaUseCase`, `ConsultarBoletimUseCase`, acionados por adaptadores primários (controladores REST).
- **Portas de saída (driven):** interfaces de persistência e integração, por exemplo `AlunoRepository`, `TurmaRepository`, `NotaRepository`, implementadas por adaptadores secundários (banco relacional).

### Containers (C4 — nível 2)

| Container | Responsabilidade | Tecnologia |
|---|---|---|
| Aplicação Web (Frontend) | Interface no navegador para os três perfis | A definir |
| API de Gestão Escolar (Backend) | Casos de uso e regras de negócio, estruturado em hexágono | A definir (REST) |
| Banco de Dados | Persistência de usuários, turmas, matrículas e notas | A definir (relacional) |

### Diagramas

Os diagramas ficam na pasta [`docs/diagramas`](docs/diagramas) e o código-fonte do workspace Structurizr em [`docs/structurizr/workspace.dsl`](docs/structurizr/workspace.dsl).

- [ ] Nível 1 — Contexto
- [ ] Nível 2 — Containers
- [ ] Nível 3 — Componentes (entrega 23 e 24/11)
- [ ] Nível 4 — Código (entrega 23 e 24/11)

### Decisões arquiteturais

O documento de decisão arquitetural (justificativa da Arquitetura Hexagonal e consequências) está em [`docs/decisoes`](docs/decisoes).

## Estrutura do repositório

```
.
├── README.md
├── docs/
│   ├── decisoes/        # documento de decisões arquiteturais
│   ├── diagramas/       # imagens exportadas dos diagramas C4
│   └── structurizr/     # workspace.dsl
├── backend/             # API (núcleo hexagonal + adaptadores)
└── frontend/            # aplicação web
```

> Estrutura sugerida. Ajustar quando a stack for definida pela equipe.

## Como executar

_A preencher quando a stack for definida e o código estiver rodando (entrega de 01/12 a 08/12)._

## Cronograma

| Data | Entrega |
|---|---|
| 16/11 e 17/11 | Equipe alinhada, app e funcionalidades documentados, estilo arquitetural, repositório criado, diagramas de Contexto e Container |
| 23/11 e 24/11 | Diagramas de Componentes e Código |
| 01/12, 07/12 e 08/12 | Código rodando, conformidade com os diagramas e apresentação para a turma |

## Documentos do projeto

- Visão e Definição do Aplicativo
- Documento de Decisão Arquitetural e Visão de Containers
- Documento de Funcionalidades
