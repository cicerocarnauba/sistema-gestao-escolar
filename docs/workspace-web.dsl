workspace "Sistema de Gestão Escolar" "Arquitetura Hexagonal - Modelo C4 (Equipe 5)" {

    model {
        aluno = person "Aluno" "Consulta turmas matriculadas e visualiza o boletim acadêmico."
        professor = person "Professor" "Consulta suas turmas vinculadas e lança ou edita notas dos alunos."
        admin = person "Administrador" "Gerencia cadastros de alunos, professores, turmas e matrículas."

        sistemaEscolar = softwareSystem "Sistema de Gestão Escolar" "Aplicação web para gerenciamento acadêmico de alunos, turmas e notas." {

            webApp = container "Aplicação Web (Frontend)" "Interface web responsiva para acesso diferenciado de alunos, professores e administradores." "React / TypeScript (SPA)" "Web Browser"

            apiBackend = container "API de Gestão Escolar (Backend)" "Implementa os casos de uso e regras de negócio acadêmicas seguindo a Arquitetura Hexagonal (Ports and Adapters)." "Node.js / TypeScript (REST API)" {

                # Faixa 1: Driving Side (Adaptadores de Entrada REST)
                authController = component "AuthController" "POST /auth/login e middleware RBAC/JWT para autenticação e autorização por perfil (RF01, RF02)." "Express / Driving Adapter" {
                    url "https://kroki.io/plantuml/svg/eNqdVW1PE0EQ_n6_YoJfSkSgGI25NA0vWpEoNBT1gxoyvZu2m253jt09Chh_jT_FP-bscZTtC2CcJr1055mZZ56Zve46j9aXE5048uCoQIueLRg2lHguwDP02XueQK4sZV6xSdxYmQCcQB-z8dByafID1hL2rFNZhHAjzHmqzBAGqB1FnrxQ0HyzHZ_QAEvtO2z8MU4I1npoXI-sGqytRvXUDUFzJ3IWQgiH1PPXmmDAOie77N1_kvUdkK0kqEEvK1sGVUSqen2pF_kzjc49XauCHRJKpX8EP04LreXpo87AuAbsVBYBDPsV-uyFzyIqZvG6siSpNYG1vdKPDqSOZa3JrgE6KMbDc5Tj82x2Dj8TEFPGkx1gRiBhZLzK0H52JVrFXba-RgV7DnRFWSlL2xAupU-XIz6E83VIoWt5ohy1lhAnpRdIu0r6K1lmMJKdu1QZLdW-DLsYEp3xmEzDh-8UnLey36FiddzFa82Yx9mrqcG8JFHiF4CLFCFdLUVERvNQmYalixRO6aIk5zfAkgu_XMHG0QYYuhKFjuW7U5rq7sa6XLLK26tpflJ5rmmKlhZp3mlzSzBWKqJ2387_8Au85gauhsp2ZTzKNYrqIT2Ep_72I-Dr7IdohLNdbuhjEKoGvT07mZuoygPRMNNc1vhulhHAkRnhvGNV8tuOFrNXC7Iqazmbcj1byVBOWOLjCgsLs7nZfuB-pICZiIfQOO1sN9cfCl4UQqRGrXKEjG3BT0Tddyj9yD2QyBuEo97J8Sww2pqa69xNmpXbJ4FYOPp6VhHeWU-k4QyLsADw3bScvNbT5qt2q98-4Jzgi6JpCj3lPE1Q3v_wXhr485vhnctYo5XNnOfd2uq3W1shTTvZJZOH_7e_CmdOYw=="
                }
                academicoController = component "AcademicoController" "POST/GET /usuarios, POST/GET /turmas e POST /matriculas para gestão acadêmica (RF03 a RF07, RF09)." "Express / Driving Adapter" {
                    url "https://kroki.io/plantuml/svg/eNqlVttuEzEQfd-vGIWXVpReaYFVtLREvSBxiZrCC6DK2Z0Eq17P1vZSLuJr-BR-jNnNJnI2TgJ0Iq0Sz_E5x-Oxs8fWCePKXEUWHVgshBGODGjSGDkqwBEMyTnKIZMGUydJR_ZG6gqYw1CkN2NDpc56pHjag7M6PIT9LDK6k3oMI6EsepmskLD3dNcfwZEolTsj7d6IHKEzENoO0MhRJ4wayO8Ie_tesmBDYowD900hjEhlaBazL9a6ngLJMEEDOqhjEVQbqfWGrOflUyWsXa9Vwy5QsNJfglfbEsbQ3cpk5bgB7NfhATS5QH1Oqk8b5bs4qiOKmppA5yTlBeUypR6LGVIKTQeEheJmfC2muet0loQfEXBI7dCMRIrQE5mwzgjzzpbCSOqTcQ2oioeAXzEtuXs32FTp4oUJL6vhTYihbyiXFrvNeFJz_Ixaeq9kdRQajF2uNpKKLfd5llTPmbz-EpD58GmJUM9IYa5Kk4v1S5pBFxZTjy5TIG35hDRT7XqZeXxYa-l6XgtnZFoqYU5UqdfvUwu_oDbLz-nVjQ-BrvK0HkHa6gGIg33kzVBz2874xT7w-WcbAnFrI33UfD0hDu2Ih8_nKwJxqKZeRQuyrjG4YfA2hku8LdG6LTBoq1-2YD30i_qFZJZ4FGOcMtj_pahc1Mu5h4dJOe7jYFapfydpOivUU9vbSfgCYp63gyvYKacNs3F5tnuwuZIocLPEcH7aZjlazdK6NqZG3KTFKoLHawgCt0LjwyM52gJ-Pqmfz1YThg7-1NaspSesh5sRVzsVRfX-AB911_I_d7x3mHSHSY8yhPcS72IYcKWQzxYPnPMu_v5FcGpTYgU-JQEb3Z1h0t2puJLoGHVWvcf8AQ1L864="
                }
                avaliacaoController = component "AvaliacaoController" "POST/PUT /notas e GET /boletim para lançamento de notas e consulta de boletim (RF08, RF10)." "Express / Driving Adapter" {
                    url "https://kroki.io/plantuml/svg/eNqlVW1P1EAQ_t5fMTm_QFSOw2hIc2l4ERBjgFD0CxIybefODdudursFxfhr_Cn-MaelR_aOemCc-3T7PDPz7MxsZ8t5tL4udeTIg6MKLXq2YNhQ5LkCz5Cx91xCoSzlXrGJ3JUyDbGEDPOrqeXaFLusxe3ZfmsBw33Bgm-UmcIEtaMAKSoFo8318IQmWGu_z8YfYUkwSNG4lKyaDPpZqbolGG0EYCWCcEqp_64JJqwLsg_RnUdVz4hsJUBHetXaQ1IrpM2XSb4AzzU693iulvaOUDI9kbxcFlrLN0vBRnFH2GgtIBj2PfXZbn6LrFDFm9aiqKsJDLavUSvMkXclmWWtyQ4AHVRX00ucYZf5PQg_IhBTxpOdYE7wAU2O9og9nrD1HdzYc6BvlNcytysip_ZxQD1sDlYhhhPLpXI0bg6T1vVntJBAhDmZI7Q7rMmr8u9pUNeGD4sYnLcyyWH8zvf8Yi5J2yXoKUEQ_yXoe9kQL1w3YOULMoXbpzzQXbHzTaAVS19jOKWvNTn_Aiy55p-rxJvCO1yzKpLQv_4v9yn5Tte_R5ir30Jb53pTWZ6Qc2wPC5j1JYC7jvVBvrYl9kPSL5nlGExdZvLdeCCou9bsCm_Pjuc0LYlcKJerSiuDfai8JnkZs7znFwFUUqFwXtId4JSvm9maj9fJ7Zu8tbVk8U1JB47Ts-HJxzMY3mlYOd1f31xdGqP32cRwsCdBsm5EJcxoffWJUu6aG0MpBAQSFha41LenD1IF2RNCv0V4nx4fRVKJHKtmXcFnM3ayKOLR62ScJbtcEHxSdBNDqpynEmWjwIFM6O9fDHsuZ41W3l1P8vEwS8bDJlYSbZEpmrX5B-WVYL0="
                }

                # Faixas 2 e 3: Núcleo Hexagonal (Casos de Uso, Domínio e Portas)
                group "Núcleo Hexagonal (Casos de Uso, Domínio e Portas)" {
                    securityComponent = component "Security & Auth Core" "Porta AutenticarUsuarioPort; valida credenciais e perfil de acesso com a entidade Usuario." "Input Port / Use Case" "Core" {
                        url "https://kroki.io/plantuml/svg/eNq9lVFv0zAQx9_zKU5DQkOoGxsCoaiKNsrGJsE6LSpPSNMlubZWE19kO4wN8Wn4KHwxzm7KUpqtiAfchzb-_3z3951TH1mHxjVVGVlyYKlGg44NaNYUOa7BMWTsHFdQKEO5U6wju1DagxVkmC9mhhtdjLiUZU9Ow-gQdo4F3yg9gymWljpKUSs4ePOiO0NTbEp3ytpdYEWwk6K2KRk13emnUnVHcHDYEWsxhDNK3W1JMOWyILOpvt3qegWykQAt9DKMTSgYCfkyydfR8xKt3Z4rYGeEkukv4cdtoTF886joHbfAYRgdQLPrqc-x__xJdV28DiOK2ppI6yhvjHK38BSOGzeHERvaAbRQL2bXthWvUaTrXCT4FoEMpR2ZKebkF5F2KkczsQ0axZdsXEv58Rzoq0SR07srphoXb6449_PPIIZLw5WyNNwgxo0TJAlBv0fhKxR4M9bE0ggtgarqkirR7FaHA2iW81dUs7iY3D95ssP5Ksgx_6Jk32Efq6c17j_vOMRaK7gqPDEVppCWx2Cdkfe6A1jSc1wXHs-xdLOWxPGCdF_wtpjnRZ-ouaK--VpOkyp9QcKPriXMhMbctd5aR2v9Uz25BkAVhpAbQtj-Gdp5n9jnpPXI1jZqOb27xFaUb2XGXBLqrnXSTdUSHb_H7z6eX_x-urwan56k6fjqXv8wuRh3wzx4yPf2kofOQwxyCVBG_xCgbXYMteGiudseYdWSGL5gqQqE3JAcwVyhskBtRUOYFTkYJKu6xG1dI9lsjrW_t-CzHlq5MeKDV8kwS0ZcEHxSdBNDqqyTtsrVAu_Jup8_GE5sziUa6VzfP9lwP0uG-z5YEh2RLvwF-gtgQ2Vh"
                    }
                    academicoCore = component "Gestão Acadêmica Core" "Portas CadastrarUsuarioPort, ListarUsuariosPort, CriarTurmaPort, ConsultarTurmasPort e MatricularAlunoPort; entidades Usuario, Aluno, Professor, Turma e Matricula (RN03)." "Input Ports / Domain" "Core" {
                        url "https://kroki.io/plantuml/svg/eNq1V81u20YQvuspBspFruE4TtCiEAQ1qpA0AZLAiOxcksIYkSN5YXKH2F3aaYs-TW99jbxYZ5ekREqrn6bp6iLufDPf_C6Xz61D48o861lyYKlAg44NaNbUc1yAY5izc5xDqgwlTrHu2TulPTCHOSZ3S8OlTqecidqjl2G1EPYWU35QegkLzCy1JGmh4OLHJ-0dWmCZuZes3TvMCfoz1HZGRi36cdRM_U5w8bQlLMQhXNLM_ZYRLDhLyWxLfz7odQNkIwZq0LOwtkHBkcA3F76WPMnQ2sNcAfaKUJiOBO93C43hh71C73ENeBpWC6DZRfIz8b9NVNuLH8Lq9eqcQP8Xsu7LXwyTBNMvf-cqQZiyoT6gheJuebMUOfINipi89CYRKfzRA1lKOzILTAimmKJ1Bs21LdEovmTjapBfp0CfKSmlhQfiWemGWwqv_fYJDOHScK4sjer9cbDxZ2-D743y81Bj7G62hcqc4UvRUtlPYjz8idB8_HUH0dQoNFelyfFwSCvoVjBhdxcDaytjUqvawzRdfJxrZzxv0RmVlBmaSVbqw3XawG-xreQdvtD9WzW-tjRFS6DyIqOctLOH-uYMymr_PRUsrNfrJ49s4bB0t3IC3SuJcQiT9VMH9436sAqv24OR4PY26bGh_fdmroux6s5YGXZ1-Rk4v1v7eNX830j-v47kayamDqPb_bFY9s7TMQF9m5mr_N2Yn4i_-yfy_y3A1003zv3EJK4OsabrOK1SsSIouU-0djXnFNunHFUWE6SclD5LHBNa0rf4Cu1tTFiE4YBmSlo5KNjaUlXbgwrWnqU5c0aotysZMiQZdKTTWNCnkDfZ6jrUsSKZXZC18iqOW-qAQ7mPyGvCqVpGc5Qqm6giUxp3JElxym_IqfuoetF4-zrCe7oWv7hSznfRoKXQ4PcmddVgR0SJoUWjojAjcRFKbLjhQj0McjpPvHRwEpfrhIy8GYL4nlXadn_Xu-3x4_GqokNI5ICrG-d8XfpgIP722FCvj52KcesA9-CqRWomgnulQzZdVY9KMX5ktrXDmwVlNEw9OEFxx9nlFd-2Wn0pN025X0CpVaJSuSbC4P27J89Ogo2Kof9dH87OxtC_6LcmYAiO8o6ra7NtjSqBwya4PcgmngYpxUqw8N9C8EmPrHyFDC--H4_m4ymLmx8UPQxhJoWQA0g-V6C5C7-wCYtL0j07bsej8_l4dO7tjXvPZYr9d9k_Zf9oGA=="
                    }
                    avaliacaoCore = component "Avaliação e Notas Core" "Portas LancarNotaPort e ConsultarBoletimPort; entidades Nota e Boletim e regras RN01, RN02, RN04 e RN05." "Input Ports / Domain" "Core" {
                        url "https://kroki.io/plantuml/svg/eNqtVttuGjEQfecrRvSFqIFA2lTVCqEQQlukhkSQ5iWN0LA7UCu79sr2Jm2jfE0fqn5Hfqy22U0MLKRSaiS08pyZM3PGt0OlUeosiSuKNChKUaIWErjgVNEiBS1gKrQWCURMUqiZ4BV1zbgFJjDF8HouRcajnoiN26sPbngI9Q0jccv4HGYYK_IsUcqg9b7pz9AMs1h_EFwPMSGojpGrMUk2q5ajxuwnQWvfM6YmIZzTWP-ICWYijkiuW4-ezboACmkC5KA3bqyDXCKOb2r4PHsYo1LPcznYJ0LD9I_g7WmhlOJ2q9FmnAP23fAAXOgSfbr2t4rys3jnRqWSawLV7g3GDB9-P_wSQDAUGhX0hKQqmI_0ej5BBwhRTLg1TkJjhLsKmMG4JjnDkOAz8hCl9T4TUudmO14DfacwM4u3ZnLKdOBBB3ZiBwI4kyJhitp2suNc7ysrBD3BlVlMKI9ETJolm2kwzrgYRAEoLc1y9uPnvpdXSySuVV5aXxT1UBGwJI0pIa7V5vLqoDOZ4IhSYXjOi2-L8jBWuBwyzD-XEC8TaZH_qkAlVTyj4X-v5cWdcLUvdTmVYkZKCTmIoIjrmXPGMpOrrdxkFrjZGgHwLJmaY2gtIZvKkk6sJEwdEjQzYRaXstTLWBb0d-Zo1yy8h1Ayo5oXpoiyu3AufHdy7ZcKNxsF5YWF1dbAN4JFXiaPhHZnRygHdpdZpy2eS4Lk3VvqzBZ93bnxWPnllWdKKGJYJopiOrOHjrGN88-ctVQ5jK1ispZn8SSc436itjX5cfKyyNhXebzq-ieT7vC4e9Ifnp8-TnbPRqcX3eOniVHfn8kjrx8rjUZnbYkHYK5smtIWF7cIg7xl0Gw0Wk2ojYbN1i6Y_333_3bHBdh0FNgwRXFBoRkkD39sD2ysg4V_gfFocS5pjotlSGoJVa931qQL7OXPzMvEqBBiah8j8JW3lXkGBK2DTnva6YmI4ILRre2v0pSgcYGPpLS9iPoqFKadZq1uup7ae9NOe88G7FQOiUf2ZfQXCffs1A=="
                    }

                    authServicePort = component "AuthServicePort" "Contrato para hash de senha (bcrypt) e emissão/validação de token JWT." "Output Port (Interface)" "Core" {
                        url "https://kroki.io/plantuml/svg/eNqNVMFu00AQvfsrRuFSBGlJEQhZkdVQGooEiVUDJ6RobE-SVewda3fdqCC-hhPf0R9jd5OUjRtaxpLtnffezPOstWfaoDJtXUWaDGhqUKFhBZIlRYYbMAw5G8M1lEJRYQTLSK-EdMQacixWC8WtLM-5srInYx8BQy-x5LWQC5hjpSlAykbA4M2LMENzbCszZmkmWBP0MpQ6IyXmvcOsTHwnGJwGYGMN4YIyc1MRzLkqSd1H3z7qekdkZQtsSS993Cd5I75fbvsFeFGh1o_38rRLQtvpP8kP20KleP0g6BxvCac-AoJkc2A-I3d1WaGL1z6iaDsT6I1as7Rbdy0KSlmZHqCGZrWYoc3P9AaYNRaBHxHYENKQmmNB0FFucRfPYEEK1SVqS5BLPNLunrYKY9BG2Z_sKcSQKq6FpuEmkwTqgmtnX_1D_Bx8ypU_VC9nrghl0rXzmVckjxq8qRjLGPwy3aycfFMoEF27H1oUO6Fx97BfWMDLfkb-4bd-D90bjW7zQ92oRlEdAho7bo-k_iXsRLKtt-mgxejdpw-Tu1V6NR1fZNn06i_-8ctkGpbpbuTxcbJvP7buhCGgu5l43R6n3092VmK7gdLc_q4j26DAxp1F8E0OtT0F4sGrZJgn51wSfBW0jiET2tiPt8cFvCdtbn8xXOiCK1TQ71obnuTJ8MTVSaIzkqU7D_8ANeWxJQ=="
                    }
                    usuarioRepoPort = component "UsuarioRepoPort" "Contrato de busca e persistência de Usuario, Aluno e Professor." "Output Port (Interface)" "Core" {
                        url "https://kroki.io/plantuml/svg/eNqVVNtu00AQffdXjMJLUEVLikDIikxL1QIPQEUEL4CisXccVlnvWHtpy-1r-BR-jLHjoG1qtTB-cLLnnJmzo_Ec-YAuxMZkngJ4atFhYAeWLWWBWwgMJYfADSjtqAqabebX2nbEBkqs1ivH0aoTNiK7d9ZHwvBfUPGltiuo0XhKENVqmD19mJ5QjdGEM7bhDTYEkwVavyCn68k4a6G_EcwOE7AVQ7iiRfhqCGo2itxN9PmdrrdEdpJgID3q4yapN9LXK6VeglcGvb-7Vk97SSiV_pF8uy10ji9vBTvHA-Gwj4RgOYz057h7dlmpiyd9ZNnQE5i89xGd5nfU8jm7MAH00K5Xy7g5XzoBlq0g8D0DCW0DuRorgh3lgHexBx7NBbrpkCTfcu9DDueOG-1pfsFaFYmkjL5CJ5leqalWOfjgZBpTxZAEfoCNxoxqTxvU5m18jSKuokHJRDboWlcy3e7_khrdfXPTVq6rzTNR9D9GtB8_b2Q_s_6FpVTBKmxmYHv1pD0PQCvYeklOLcu3NHJO3aXGAMVVbOR-PAZufMPWd-pwY-zYRMtAV4GsGrO5B822jdfzX8sivajJe5mt8UwDeXdY9veLv8S88-ql2wQEsrui_MVMhBW23R6DT3buZYPks8fFvCxOWBF80HSZw6ITNSirBl6QD79_MZz6ig06acBOyflBWcwPujxFdiRGu136B4sox0c="
                    }
                    turmaRepoPort = component "TurmaRepoPort" "Contrato de busca e persistência de Turma e Matricula." "Output Port (Interface)" "Core" {
                        url "https://kroki.io/plantuml/svg/eNqVVdtu00AQffdXjMKLEaWlRSBkRVFLRaESoIpUvACqxt5JWHW9Y-2uW5XL1_Ap_BizjpPYjduUyUOsOefMnJ3dtQ99QBfq0iSeAniq0GFgB5YtJYErCAw5h8AlKO2oCJpt4i-1jcQSciwu545rq47ZiOzRSRMdhv-Oiq-1ncMMjacOoioN-6-edTM0w9qEE7bhI5YEoylaPyWnZ6Nh1lT_INg_6ICVGMI5TcONIZixUeQ20ddbXS-J7KRAS3rexCapMdL0y6VfBy8Mer-9V0N7RyidHki-3xY6x9f3gtFxSzhookOwHAbmcxR_t1ldFy-bSJJ2JjA6r12Jn6jiM3ZhBOihupxfhJi9cJK-qCQPPxOQ0DaQm2FB0FO1aIwn4NFcoUubAtmC9xgyOHNcak_jK9Zq0qHntS_QSZVTlWqVgQ9OzmBX0ZSAX2BrYwaVx6z0nNOi-VtW2IFKziMrfk9BX_H_FDY63rVzVujTDf6Xb5tU8SCcGXnPLq2WT6d3r-aOIkemtvwBRVPURm5jijHx4DqLya_0abl8ymCV3L4VK-qRzA1vW9iBZmOHPa2kvaH-Tpq_5kIszkPnvDwFrWBZq5NdbOYQorQvdGW0xSG0t-mDhPX29OGezfVKtlttJzQEtbMaVMXpCpAzG0LbtdC_W7u7k3ZqWVydl8NCQDIg6-Xlinco1gsYVkmrAqv4kYCvduzl9Zztv5iM84lcJoLPmq4zmEaR9JXEW_Lh7x-GN75gg07891qO9_LJeC9WmSSHZFX8TP0DNTs0KQ=="
                    }
                    notaRepoPort = component "NotaRepoPort" "Contrato de busca e persistência de Nota." "Output Port (Interface)" "Core" {
                        url "https://kroki.io/plantuml/svg/eNqVVFFv00AMfs-vsMpLEGOjQyAUVdHGtMEemCaK9gKoci5uOfVyju4urdjYr-Gn8Mfwpa120LIN5yGR_X32Z9_FRz6gC11jMk8BPLXoMLADy5aywC0EhopD4AZq7UgFzTbzc20jsIEK1XzmuLP1CRuhPTnrLUH4b1jzUtsZTNF4SiJ1q2H45kXqoSl2JpyxDRfYEAzGaP2YnJ4OdqPG-ppgeJgEWxGEMxqH74ZgyqYmtx19-6DqDZCdJFiDXva2DeqF9PUqqZfElUHvH67Vw94TSqVHgu-Xhc7x8t5gVLwGHPaWACyHHfM5js_fqFTF696ybD0TGFxwwI_U8iW7MAD00M5nE6HhxIl30oobbjIQ0zaQm6IiSDnrYLRn4NEs0OWRXvSop1DApeNGexotWNdlAsbQodHXj8ZXnVfopOZ5neu6AB-cXNeUETPAD7CdMTuJH1AoqjOYN5uv8_9JZHT8CyXRseksn37qXIM5xu-7NHsQovvfeT9_XaW8zfpXf1H63pNJPgddwyZB4k1k7wovMJ5xIbqbSv6nO-E3ojtodQvKaZn3ju73VuQNN4qOmtLjMnL86K4iLN8Cx8NK2_rjiuzvl6sOC2jJeZkiAYFi62U_YCYUhW3cWPDFjrzsimL4qhxV5QnXBFealgWMI6lBWSrwjnz49ZPh1Cs26KTvtNjooCpHBzFJmR2RrePK_A2c679r"
                    }
                }

                # Faixa 4: Driven Side (Adaptadores de Saída / Infraestrutura)
                authAdapter = component "JwtBcryptAuthAdapter" "Implementa AuthServicePort com jsonwebtoken (JWT) e bcryptjs." "Driven Adapter / Security" {
                    url "https://kroki.io/plantuml/svg/eNrtVdtuE0EMfd-vsMJLEdDSIhCKolUvaik8oIggnpAi766TDpkdr2a8DQXxNXwKP4Znkoppu7R8AI60lznn2N6xPTkMgl761haBBAJ16FHYg2NHhXAHwlCxCLfQGE-1GHZFWBkXiS1UWK-WnnvXnLBV2aOzZBkjXGDDa-OWsEAbKEOazsD-6-f5Ci2wt3LGTt5jSzCaoQsz8mYxGmbNzDeC_YMM7DQhXNJMrizBgm1D_i56_GDW10T26mBLepHsLiklkuJVGi_Da4shPBwr0c4JNdI_ku9PC73n9b1gzHhLOEiWERzLwP4cxd9tVp7Fq2RFsd0TGL1by3Htrzo56uXiqMFOyI8AA3Sr5fzLWuZVQueo8Bw3OHwvQM04fV5gTRC1Wv9LU9OUvWzxaE9gSR79OQYluAvcCfE67T2OIYjXfnsMY5h6bk2gyWalzNQ1t_FL_F_ETyEtRfdD_ipmS-jK2-l85BW5nQ6vLGMzhvQ63bxF-cZRJrqMvW3qa6HEax4vd5BkP4p0S10AQ1sMpu0steQk3LN7z0ArMKPa68zfSSuBp187Hffw1g3hAa18iO0RFHV9W-mQ_S_Mn8Lk6I2eDX01FI1aNHYI6HQOEjJND3mkweLv7pY3g4914oJxCKTHZs1N-qhCXdQq0KMcPrtJ0EN0vP-ynFTlCTcEnwytxzAzQTQvlcEbCvLrJ8NpqNmi1wYYCj7Zq8rJXnRWFofkmvif8huxDCGE"
                }
                usuarioRepository = component "UsuarioRepositoryAdapter" "Implementa UsuarioRepoPort com persistência relacional SQL." "Driven Adapter / SQL" {
                    url "https://kroki.io/plantuml/svg/eNrlVdtu00AQffdXjMJLELQlRSAURaaltIDEpTSFl1JFY3uSrLrecXfXDeH2M3wKP8bYcdpt66b0mclDnJ0zM8dnz2a3nEfry1xHjjw4KtCiZwuGDUWeC_AMCXvPOWTKUuoVm8idKFMBc0gwPZlYLk22w1rK7u3VESDcFDOeKTOBMWpHQSYrFPSePQpXaIyl9nts_HvMCTpDNG5IVo077aih-kbQ2wyShRDCCQ39XBOMWWdkr2df3Mp6CWQrDRrQ4zqug2oi9bxE5gX5VKNzt8-qYa8JZdI_glfTQmt5tjJZMW4Am3UEAMO-RZ_t6nMVFbJ4WkcUNZpA55Mr0So-oIKdEkfNtzMsPNkOoIPiZDIqF4CRPUeMcAGB7xFIKCPPY0wJgl77bH2Tr-IBONRnaLtNt_4Sex_6sG85V44GZ6yyOChJSpeilU5vsq7K-uC8FX-GFU0T-AGm1Lq1djdHpT-U71CK01KjdCLj1Vil4nd7t6ZaVaewW8jrKv1cKuqHltqj40XZz6j-qs0ANykNKi805cLKrVBwDbJEBr1Ejwk62tFKCv53fRfC5Fgc8OyQd2Wun3fl4Jy_vqxX5c2vcE8uXHtZ0kumPS3JzgeHcded6uWrPIT6aDnhV5oTwzNzdBxSPAzJPQD6Smnp6S4dLvap1T88Czj-ApXBsnGwalj-l1vWqdqutkTGaVl5kNuSjswUR1N007bsYr8uZxrmN3p-bS2GTq9zVfx-oxfC8OPb1R3W1-NQkn5lA1IIliZiI8uRUEgFKhchfDEDJ1dQv_ckHiTxDmcEnxWJTYYCFUnkroJX5Pyf3wy7LmWNwvDG0YONJB5sVA3jaItMVt3KfwGe84oi"
                }
                turmaRepository = component "TurmaRepositoryAdapter" "Implementa TurmaRepoPort com persistência relacional SQL." "Driven Adapter / SQL" {
                    url "https://kroki.io/plantuml/svg/eNrtVs1u00AQvvspRuESRH9IEQhZkWkoFCoVVEjFpVTR2DsJq6x33N11Q_l7Gc48RV-MtZO4TuI07b2bg62db2Y-z3w72X3r0Lg8VYElB5YyNOjYgGZNgeMMHEPMznEKQhpKnGQd2LHUBTCFGJPxyHCuxQEr7_bosFw1hP2GgidSj2CIylLNIjIJnZdP6zs0xFy5Q9buI6YErT5q2ycjh61mVF_-IOjs1YyZJ4Qj6rsrRTBkJcisWl9vZD0HsvEBZqBn5VoFlUTKfLHPV7MnCq3dnKuEvSf0me4Ivp0WGsOTW40F4xlgr1w1gGbXUJ9e8VtG1Vm8KFcQzGoCrdPcpPiZMrbS6-mqJzBzZFqAFrLxaOAK88BU9gFOAfAzAL-k9u9DTAiqOCds3MxarCdgUV2iaZeRwinuMYRwYjiVlrqXLEVUg8e5TdD4KEeiLUUI1hmvyrpHGQJ-gc6VavQ8YCFH3E7KxzzCFmReoSz4mJy85PsEVrI4facs0LZX8Gfnq1DPwWOGZC2bdjZ_O1r_NWuC9FSu-QN6nyRX_ny2sdi4c5xp5Sv_djp_C6Ha3NyKCtrzdcNlCltQNraZU-W6UNTfQfkojwg06w9kmilKSTu7VlnbIGKf6w06jNHSgZIe_qC7B91t0N3NzFqUzsLQusjJXHVPo7a9ULVOFkPVvgoh12PNE312vlCJxSrQd0pyR_eJcFOIhjPCkxrDPyAFzMPWdqfaa7IIaROZKamxyTrT6ECVIm1EzOU0WM68wLUq_d34ll0dNNum_z1r_ApNeIPO09hfHWo01gyU7e0IWp3Wcs_DWZsQ-p-Ob_Pf2Ylu-hBCihlJnFLc5LZQksq1OBTX_4rtwDNPPNxf2eCr7lp_WQo7z6NuHPmBQvBF0iSEvj-b5KeE33hH1l3_ZXhrE1boP21N8u5uHHV3i3BRsE9aFLfH_xpIZtM="
                }
                notaRepository = component "NotaRepositoryAdapter" "Implementa NotaRepoPort com persistência relacional SQL." "Driven Adapter / SQL" {
                    url "https://kroki.io/plantuml/svg/eNrtVdtu00AQffdXjMJLUGlLikDIikxLaaFSqUoT8VKqaGxPwirrHXd3nZBy-Rk-hR9j10mabeveeGb84NXOmTPHM7PebWNR26qQkSELhkrUaFmDYkWR5RIsQ8rWcgG50JRZwSoyY6E8sIAUs_FIc6XyXZYu7Ml-bQHCfMWcp0KNYIjSUODJSwGd18_DHRpiJe0-K3uEBUGrh8r0SIthqxnVExcEna3AWTpBOKKenUmCIcuc9E3v23tVL4GsHcEC9KK2m6BaSJ0vdfkCfybRmPtz1bAPhC7TA8F3y0KteXqn0yteALZqCwCKbUN9dvxzHRWqeFVbFC1qAq0jtnhCJRvhxmm2k2NpSbcADZTj0cDF40Bfugc498P3CJwJ5dZDzAiWLMes7cLpbQ0MygnqtueJa9RTiOFYcyEMdScs8iQAo61QiosH49PKZKhdzoO8LfIYjNVugMMIzwA_QFVSNgZ-RBeSVRLbxXJ18BgiKfy5dEQ7slK81690gW306xXNM7B--3be07M55c-oftWjA419AVGUkgpS1txW8nXIU8f_Di2maGhXCof-35B_asi8ngWWJzzt856yws7a7lzOC-E2faBfhu1bHYqrPbhyLM4r0rNuP2mbc7mSVZ9Z8yaGSo0VT9XpWaisH8paA_pGWWXpMQyrdt0cNZ4GAn-ByGHJGuxe9mTQ7J-g_8nEritF6n7oQabmcV5fT6DVaV2vVLz4OITep8M7wjc2kkvxse8TCQRNIzcDmiOXOXM4dxHCF9U17gqKOy-Tbprsck7wWZDrY89BqUB3V8F7MvbPb4Y9k7FEp605aXczTbqbni2Jtknl_kr-C566hSg="
                }
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
