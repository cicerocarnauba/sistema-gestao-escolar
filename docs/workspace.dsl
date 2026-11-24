workspace "Sistema de Gestão Escolar" "Arquitetura Hexagonal - Modelo C4 (Equipe 5)" {

    model {
        aluno = person "Aluno" "Consulta turmas matriculadas e visualiza o boletim acadêmico."
        professor = person "Professor" "Consulta suas turmas vinculadas e lança ou edita notas dos alunos."
        admin = person "Administrador" "Gerencia cadastros de alunos, professores, turmas e matrículas."

        sistemaEscolar = softwareSystem "Sistema de Gestão Escolar" "Aplicação web para gerenciamento acadêmico de alunos, turmas e notas." {

            webApp = container "Aplicação Web (Frontend)" "Interface web responsiva para acesso diferenciado de alunos, professores e administradores." "React / TypeScript (SPA)" "Web Browser"

            apiBackend = container "API de Gestão Escolar (Backend)" "Implementa os casos de uso e regras de negócio acadêmicas seguindo a Arquitetura Hexagonal (Ports and Adapters)." "Node.js / TypeScript (REST API)" {

                # Faixa 1: Driving Side (Adaptadores de Entrada REST)
                authController = component "AuthController" "POST /auth/login e middleware RBAC/JWT para autenticação e autorização por perfil (RF01, RF02)." "Express / Driving Adapter"
                academicoController = component "AcademicoController" "POST/GET /usuarios, POST/GET /turmas e POST /matriculas para gestão acadêmica (RF03 a RF07, RF09)." "Express / Driving Adapter"
                avaliacaoController = component "AvaliacaoController" "POST/PUT /notas e GET /boletim para lançamento de notas e consulta de boletim (RF08, RF10)." "Express / Driving Adapter"

                # Faixas 2 e 3: Núcleo Hexagonal (Casos de Uso, Domínio e Portas)
                group "Núcleo Hexagonal (Casos de Uso, Domínio e Portas)" {
                    securityComponent = component "Security & Auth Core" "Porta AutenticarUsuarioPort; valida credenciais e perfil de acesso com a entidade Usuario." "Input Port / Use Case" "Core"
                    academicoCore = component "Gestão Acadêmica Core" "Portas CadastrarUsuarioPort, ListarUsuariosPort, CriarTurmaPort, ConsultarTurmasPort e MatricularAlunoPort; entidades Usuario, Aluno, Professor, Turma e Matricula (RN03)." "Input Ports / Domain" "Core"
                    avaliacaoCore = component "Avaliação e Notas Core" "Portas LancarNotaPort e ConsultarBoletimPort; entidades Nota e Boletim e regras RN01, RN02, RN04 e RN05." "Input Ports / Domain" "Core"

                    authServicePort = component "AuthServicePort" "Contrato para hash de senha (bcrypt) e emissão/validação de token JWT." "Output Port (Interface)" "Core"
                    usuarioRepoPort = component "UsuarioRepoPort" "Contrato de busca e persistência de Usuario, Aluno e Professor." "Output Port (Interface)" "Core"
                    turmaRepoPort = component "TurmaRepoPort" "Contrato de busca e persistência de Turma e Matricula." "Output Port (Interface)" "Core"
                    notaRepoPort = component "NotaRepoPort" "Contrato de busca e persistência de Nota." "Output Port (Interface)" "Core"
                }

                # Faixa 4: Driven Side (Adaptadores de Saída / Infraestrutura)
                authAdapter = component "JwtBcryptAuthAdapter" "Implementa AuthServicePort com jsonwebtoken (JWT) e bcryptjs." "Driven Adapter / Security"
                usuarioRepository = component "UsuarioRepositoryAdapter" "Implementa UsuarioRepoPort com persistência relacional SQL." "Driven Adapter / SQL"
                turmaRepository = component "TurmaRepositoryAdapter" "Implementa TurmaRepoPort com persistência relacional SQL." "Driven Adapter / SQL"
                notaRepository = component "NotaRepositoryAdapter" "Implementa NotaRepoPort com persistência relacional SQL." "Driven Adapter / SQL"
            }

            database = container "Banco de Dados" "Armazena dados cadastrais de usuários, turmas, matrículas e notas." "PostgreSQL / SQLite" "Database"
        }

        # Relacionamentos Nível 1 e 2
        aluno -> webApp "Acessa para consultar notas e turmas" "HTTPS"
        professor -> webApp "Acessa para lançar notas e gerenciar turmas" "HTTPS"
        admin -> webApp "Acessa para administrar cadastros, turmas e matrículas" "HTTPS"
        webApp -> apiBackend "Realiza requisições de casos de uso (Portas de Entrada)" "JSON / HTTPS (REST)"
        apiBackend -> database "Lê e persiste dados acadêmicos (Adaptador de Saída)" "SQL / TCP"

        # Relacionamentos Nível 3: Frontend -> Driving Adapters
        webApp -> authController "POST /auth/login" "JSON / HTTPS"
        webApp -> academicoController "/usuarios, /turmas, /matriculas" "JSON / HTTPS"
        webApp -> avaliacaoController "POST/PUT /notas · GET /boletim" "JSON / HTTPS"

        # Driving Adapters -> Core (Input Ports)
        authController -> securityComponent "Aciona Input Port"
        academicoController -> academicoCore "Aciona Input Ports"
        avaliacaoController -> avaliacaoCore "Aciona Input Ports"

        # Core -> Output Ports (Interfaces do Núcleo)
        securityComponent -> authServicePort "Hash e JWT"
        securityComponent -> usuarioRepoPort "Busca usuário"
        academicoCore -> authServicePort "Hash senha"
        academicoCore -> usuarioRepoPort "Usuários"
        academicoCore -> turmaRepoPort "Turmas e matrículas"
        avaliacaoCore -> turmaRepoPort "Titular e matrícula"
        avaliacaoCore -> notaRepoPort "Notas e boletim"

        # Output Ports -> Driven Adapters (em runtime, via Inversão de Dependência)
        authServicePort -> authAdapter "Implementado por (DIP)"
        usuarioRepoPort -> usuarioRepository "Implementado por (DIP)"
        turmaRepoPort -> turmaRepository "Implementado por (DIP)"
        notaRepoPort -> notaRepository "Implementado por (DIP)"

        # Driven Adapters -> Banco de Dados
        usuarioRepository -> database "Lê e grava usuários" "SQL / TCP"
        turmaRepository -> database "Lê e grava turmas e matrículas" "SQL / TCP"
        notaRepository -> database "Lê e grava notas" "SQL / TCP"
    }

    views {
        properties {
            "kroki.url" "https://kroki.io"
            "kroki.format" "png"
            "structurizr.metadata" "false"
        }

        systemContext sistemaEscolar "SystemContext" {
            include *
            autoLayout lr
        }

        container sistemaEscolar "Containers" {
            include *
            autoLayout lr
        }

        component apiBackend "Components" {
            include *
            autoLayout lr 300 180
        }

        # ------------------------------------------------------------
        # Nível 4 (C4) - Abre dentro do próprio Structurizr Local
        # (Para usar no Playground Web, utilize docs/workspace-web.dsl)
        # ------------------------------------------------------------
        image authController "CodeAuthController" {
            kroki "plantuml" "code/auth-controller.puml"
            title "Code View: Sistema de Gestão Escolar - AuthController"
        }

        image academicoController "CodeAcademicoController" {
            kroki "plantuml" "code/academico-controller.puml"
            title "Code View: Sistema de Gestão Escolar - AcademicoController"
        }

        image avaliacaoController "CodeAvaliacaoController" {
            kroki "plantuml" "code/avaliacao-controller.puml"
            title "Code View: Sistema de Gestão Escolar - AvaliacaoController"
        }

        image securityComponent "CodeSecurityAuthCore" {
            kroki "plantuml" "code/security-auth-core.puml"
            title "Code View: Sistema de Gestão Escolar - Security & Auth Core"
        }

        image academicoCore "CodeGestaoAcademicaCore" {
            kroki "plantuml" "code/gestao-academica-core.puml"
            title "Code View: Sistema de Gestão Escolar - Gestão Acadêmica Core"
        }

        image avaliacaoCore "CodeAvaliacaoNotasCore" {
            kroki "plantuml" "code/avaliacao-notas-core.puml"
            title "Code View: Sistema de Gestão Escolar - Avaliação e Notas Core"
        }

        image authServicePort "CodeAuthServicePort" {
            kroki "plantuml" "code/auth-service-port.puml"
            title "Code View: Sistema de Gestão Escolar - AuthServicePort"
        }

        image usuarioRepoPort "CodeUsuarioRepoPort" {
            kroki "plantuml" "code/usuario-repo-port.puml"
            title "Code View: Sistema de Gestão Escolar - UsuarioRepoPort"
        }

        image turmaRepoPort "CodeTurmaRepoPort" {
            kroki "plantuml" "code/turma-repo-port.puml"
            title "Code View: Sistema de Gestão Escolar - TurmaRepoPort"
        }

        image notaRepoPort "CodeNotaRepoPort" {
            kroki "plantuml" "code/nota-repo-port.puml"
            title "Code View: Sistema de Gestão Escolar - NotaRepoPort"
        }

        image authAdapter "CodeJwtBcryptAuthAdapter" {
            kroki "plantuml" "code/jwt-bcrypt-auth-adapter.puml"
            title "Code View: Sistema de Gestão Escolar - JwtBcryptAuthAdapter"
        }

        image usuarioRepository "CodeUsuarioRepositoryAdapter" {
            kroki "plantuml" "code/usuario-repository-adapter.puml"
            title "Code View: Sistema de Gestão Escolar - UsuarioRepositoryAdapter"
        }

        image turmaRepository "CodeTurmaRepositoryAdapter" {
            kroki "plantuml" "code/turma-repository-adapter.puml"
            title "Code View: Sistema de Gestão Escolar - TurmaRepositoryAdapter"
        }

        image notaRepository "CodeNotaRepositoryAdapter" {
            kroki "plantuml" "code/nota-repository-adapter.puml"
            title "Code View: Sistema de Gestão Escolar - NotaRepositoryAdapter"
        }

        styles {
            element "Person" {
                shape Person
                background #ffffff
                stroke #08427b
                color #08427b
            }
            element "Software System" {
                background #ffffff
                stroke #1168bd
                color #1168bd
            }
            element "Container" {
                background #ffffff
                stroke #438dd5
                color #1168bd
            }
            element "Component" {
                shape Component
                background #ffffff
                stroke #438dd5
                color #1168bd
            }
            element "Core" {
                shape Component
                background #f8fbff
                stroke #1168bd
                color #0b4f8a
            }
            element "Web Browser" {
                shape WebBrowser
                background #ffffff
                stroke #438dd5
                color #1168bd
            }
            element "Database" {
                shape Cylinder
                background #ffffff
                stroke #438dd5
                color #1168bd
            }
            relationship "Relationship" {
                color #707070
                dashed true
            }
        }
    }
}
