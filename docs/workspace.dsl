workspace "Sistema de Gestão Escolar" "Arquitetura Hexagonal - Modelo C4 (Equipe 5)" {

    model {
        aluno = person "Aluno" "Consulta turmas matriculadas e visualiza o boletim acadêmico."
        professor = person "Professor" "Consulta suas turmas vinculadas e lança ou edita notas dos alunos."
        admin = person "Administrador" "Gerencia cadastros de alunos, professores, turmas e matrículas."

        sistemaEscolar = softwareSystem "Sistema de Gestão Escolar" "Aplicação web para gerenciamento acadêmico de alunos, turmas e notas." {

            webApp = container "Aplicação Web (Frontend)" "Interface web responsiva para acesso diferenciado de alunos, professores e administradores." "React / TypeScript (SPA)" "Web Browser"

            apiBackend = container "API de Gestão Escolar (Backend)" "Implementa os casos de uso e regras de negócio acadêmicas seguindo a Arquitetura Hexagonal (Ports and Adapters)." "Node.js / TypeScript (REST API)" {

                # Faixa 1: Driving Side (Adaptadores de Entrada REST)
                authController = component "AuthController" "Adaptador REST (POST /auth/login) e middleware RBAC/JWT para autenticação e autorização por perfil (RF01, RF02)." "Express / Driving Adapter"
                academicoController = component "AcademicoController" "Adaptador REST (POST/GET /usuarios, POST/GET /turmas, POST /matriculas) para gestão acadêmica (RF03 a RF07, RF09)." "Express / Driving Adapter"
                avaliacaoController = component "AvaliacaoController" "Adaptador REST (POST/PUT /notas, GET /boletim) para lançamento de notas e consulta de boletim (RF08, RF10)." "Express / Driving Adapter"

                # Faixa 2: Núcleo Hexagonal - Portas de Entrada, Casos de Uso e Domínio
                securityComponent = component "Security & Auth Core" "Porta de entrada AutenticarUsuarioPort; valida credenciais e perfil de acesso (Usuario, Perfil)." "Hexagonal Core / Input Port"
                academicoCore = component "Gestão Acadêmica Core" "Portas CadastrarUsuario, ListarUsuarios, CriarTurma, ConsultarTurmas e MatricularAluno; entidades Usuario, Aluno, Professor, Turma e Matricula (RN03)." "Hexagonal Core / Domain"
                avaliacaoCore = component "Avaliação e Notas Core" "Portas LancarNotaPort e ConsultarBoletimPort; entidades Nota e Boletim e regras RN01, RN02, RN04 e RN05." "Hexagonal Core / Domain"

                # Faixa 3: Núcleo Hexagonal - Portas de Saída (Interfaces)
                authServicePort = component "AuthServicePort" "Porta de saída (interface) para geração/comparação de hash de senha e emissão/validação de token JWT." "Output Port (Interface)"
                usuarioRepoPort = component "UsuarioRepoPort" "Porta de saída (interface) para busca e persistência de Usuario, Aluno e Professor." "Output Port (Interface)"
                turmaRepoPort = component "TurmaRepoPort" "Porta de saída (interface) para busca e persistência de Turma e Matricula." "Output Port (Interface)"
                notaRepoPort = component "NotaRepoPort" "Porta de saída (interface) para busca e persistência de Nota." "Output Port (Interface)"

                # Faixa 4: Driven Side (Adaptadores de Saída / Infraestrutura)
                authAdapter = component "JwtBcryptAuthAdapter" "Adaptador de saída que implementa AuthServicePort usando JWT e bcrypt." "Driven Adapter / Security"
                usuarioRepository = component "UsuarioRepository Adapter" "Adaptador de saída SQL que implementa UsuarioRepoPort." "Driven Adapter / SQL"
                turmaRepository = component "TurmaRepository Adapter" "Adaptador de saída SQL que implementa TurmaRepoPort." "Driven Adapter / SQL"
                notaRepository = component "NotaRepository Adapter" "Adaptador de saída SQL que implementa NotaRepoPort." "Driven Adapter / SQL"
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
        webApp -> academicoController "POST/GET /usuarios, /turmas · POST /matriculas" "JSON / HTTPS"
        webApp -> avaliacaoController "POST/PUT /notas · GET /boletim" "JSON / HTTPS"

        # Driving Adapters -> Core (Input Ports)
        authController -> securityComponent "Aciona Input Port"
        academicoController -> academicoCore "Aciona Input Ports"
        avaliacaoController -> avaliacaoCore "Aciona Input Ports"

        # Core -> Output Ports (Interfaces do Núcleo)
        securityComponent -> authServicePort "Compara hash e emite JWT"
        securityComponent -> usuarioRepoPort "Busca usuário"
        academicoCore -> authServicePort "Gera hash de senha"
        academicoCore -> usuarioRepoPort "Persiste e lista usuários"
        academicoCore -> turmaRepoPort "Persiste e consulta turmas/matrículas"
        avaliacaoCore -> turmaRepoPort "Verifica titular e matrícula ativa"
        avaliacaoCore -> notaRepoPort "Persiste e consulta notas"

        # Driven Adapters -> Output Ports (Inversão de Dependência)
        authAdapter -> authServicePort "Implementa"
        usuarioRepository -> usuarioRepoPort "Implementa"
        turmaRepository -> turmaRepoPort "Implementa"
        notaRepository -> notaRepoPort "Implementa"

        # Driven Adapters -> Banco de Dados
        usuarioRepository -> database "Lê e grava usuários" "SQL / TCP"
        turmaRepository -> database "Lê e grava turmas e matrículas" "SQL / TCP"
        notaRepository -> database "Lê e grava notas" "SQL / TCP"
    }

    views {
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
            autoLayout lr
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
