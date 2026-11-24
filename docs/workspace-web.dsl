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
                    url "https://kroki.io/plantuml/svg/eNqdVdtu00AQffdXjNqXVBTaFBUhK7JoQwNU0IYmhQdA1cQ7SVZd77q767bcPgbxwIf0x5jdpMG5lCImkh3PnJk5c1n7mfNofVWoxJEHRyVa9MaCNpoSb0rwBgbGe1OAkJZyL41O3LnUAVjAAPPzkTWVFm2j2G29E6WGcGMU5krqEQxROapZRCmh-XS7rqEhVsp3jPZHWBCs9VC7Hlk5XFuN6skvBM2dmrFkQjiinv-sCIZGCbLL1v17Wd8CjeUAU9DjKMugSCTmG3C-mj1X6Nz9uSLsJSFn-kfw32mhtebqr8bAeArYiVIDaONX9Gcv_BZRdRZPoiTJtCewtlf5cZvzWKMU2TVAB-X56AxZfZbP9PA1ARapPdkh5gTsRtrLHO2pq9BK0zXWT1FBHgBdU17x0jaYS-XTZY9XQb8BKXStKaSj1hLiuPIMyWLQ78kygzHv3KXMaSn3ZdjFEKhvzkk3fLim4Lzl_Q4Zo7qLn5VBUY8epwbzLakFfgi4SBHS1a2okVFmJHXD0kUKJ3RRkfObYMmFJ1ca7WgTNF1zh4742ql0PLv1vlwaKbLVNN9IIRRdoaVFmre9mRCsd6pG7U85_8Mv8JobuBxJ2-XxSNco441rCHf14VPAT6O_RM2c7XJBr0OjpqDn_eO5iUoRiIaZCl7j21nWAI70GOcNq4JPKlqMHhdkVdRqNuXpbDlCVRj2r2dYWJhHj7I7zkcKmHPzEBonne3mxl3Oi43gVqOSAiE3tjT3eP2pkOvhc8CeXxAOe8dHM8fa1ky5zp2kWbp9YoiFw_f9SHhnI-GCcyzDAsBH3XL8Wk-bu1lrkLWNIHgn6SqFnnSeCuT3P7zgAm5-GjhwuVFoeTP3uq_uMMwV1NoaZK2tED-b5WlmrTy8xNL13SjZc_KoxuRCQFmUigpuOd78CoGFARTMNK4L29liWQEnB71-eJ5t_gQeFcZypybPJ_t7bfgGBxeVLAl2-e9ppw1vK3mN4uZHaysSuWWYPCMtwqf5N2UZkzs="
                }
                academicoController = component "AcademicoController" "POST/GET /usuarios, POST/GET /turmas e POST /matriculas para gestão acadêmica (RF03 a RF07, RF09)." "Express / Driving Adapter" {
                    url "https://kroki.io/plantuml/svg/eNqlVl1P2zAUfc-vuIIX0BilsLItqjJYRxnSPjoKe9km5Ca3xcKJg-0M9vVj0B72tF_RP7ZrN63cNm234UpR6nt8zvG910kOtGHKFKkINBrQmDPFjFSQyQwDI3MwEnrSGJlCwhXGhsss0Fc8s8AUeiy-GihZZElLClq23nbDQ-hLlsgbng2gz4RGL5LkHOpPdvwZ7LNCmLbMzBuWIqx1Waa7qHh_rRrV5V8R6rteMCdDbIBd80Ug9KVIUM1Hn690PQZKRQQlaM-NeZAz4vR6pOfFY8G0Xq3lYC-RkdJfgpfbYkrJm6VB67gE7LrhATJpKvJzaH-zKN_FvhtBUOYE1g5j2lDKY9kiMSWFQLUGTEN-Nbhg49hFPAnCtwBo8Myg6rMYocUSpo1i6lwXTHHZkcqUIDseAN5iXFD3bpCpwoRzC07s9CaE0FEy5Rqb5XzkOH4EM3qvuD0KJUYvVutzQZY7tIqLZ0TubipkPnxaINRSnKmzQqVs9ZYm0LnNuNlFCjLTdELKpXq1zDS-Wmvhfl4zo3hcCKYORZGtrtMMfk5tEp_Sc40PFV3laT2EeKYHIKzsI2-FmCo74ef7wOefFATCmUL6qOl8QlhVEQ-fTmcEwqqcehnNpTalwQ2F1yGc4nWB2myBQm3_6Zz00E_qZ8mTyKMY4JhB_y-FdeG2cw8Po3Tcx8EkU_9OUnZWVU9tb0fVDyDieds9g1oxbpiN0_bO3uZSooonSwjHR7Ms-8tZZh4bYyNm1GKW4NEKgoqnQunDI9nfAro-dtenywmrDv7Y1qSlR6yNzYCyHbPcfj_Ax6yp6c0d1htRsxe1ZILwnuNNCF3KFNLZooljquLwp4QjHUtSoFNy2DlZEJj316z1ombNikQTsXrUjO3LKlxvuBG9QMPEJWrLytNcYIqZYcNflj2RQOXPDX28KDg9oi3ZFx-17EicVlDthne2eFtQpg_dQR7-Hm37OxxdFzxHaNDtebsF7wp-y5LhXbPmbIz9BQeYJfYD7A-8iDfY"
                }
                avaliacaoController = component "AvaliacaoController" "POST/PUT /notas e GET /boletim para lançamento de notas e consulta de boletim (RF08, RF10)." "Express / Driving Adapter" {
                    url "https://kroki.io/plantuml/svg/eNqlVcFO20AQvfsrRuECaksIFRWyIgsICaWqICWhF4rQxJ6EFWuv2V0Dpe3HVD3wIfmxzjpO5CQmUHVyife9mXk7M7u7Zyxqm8XSM2TBUIoardKQqIQ8q1KwCgbKWhVDJDSFVqjEMzciccQYBhjejLTKkqilJLutdXIrMcw1RupeJCMYojRUQqJUQGN3q7xCQ8yk7ajEnmBMUOthYnqkxbBWzeqJR4LGdglMWRCOqGe_S4KhkhHpZfTgRdVTotIcoCC9z22ZlAvJ8w04XwkPJRrzcq6c9pGQM72SvFoWaq3uV4JOcUHYzq1ESJStqM---y2yyio-5OZ5RU2gtn-HUmCIqsXJtJKSdA3QQHozusIpdhXOQPjhAZtILOkhhgSfMQlRnyiLXaVtATt7A_RAYcZzu85yMuuXqMduYQN86GoVC0NNtxjkrr-8hQQszPAcoT5QkqyIn0-DMkvUceSDsZonuRy_8L24nEuSdwkqSlCK_w7kTDb4C9stscIFmcytUl7SnSpjXaB1Tbc-nNFtRsa-BU3GfZmUvam8hzsloqDsn_2X-4hsoevfI8zVb6Gtc71JtRqSMUofRzDtSwkuOlYF2UzHWA1xv3iWfUiyeMD3xpKgYlvTLRz2T-c0rYgcCROKVIoEq1A-TXwypnkvLktQTJHAeUkTwAibudmaj1fIrZq8zc1g8UxxB057_Xr3vA_1iYb1s87W7sbKGJXHxoejNgcZFCPKYRpbG6-UMmmuDzETEIhZGOFK34o-cBX4nWD6I8Kn3umJx5UIMXXPFXxLmoYfCr-xEzQHQUtFBF8F3fvQE8ZSjPyiwBFP6PiPgrYJlUTN526_e_wMsKyqWR8EzbpLEsySNYJm6O5Gf20nt-CQLMprMi6qiFNJMe8Vx08ueqSAN51afis1nLV7fXD3rLshxk_oeMp5TXpEsyvBuU1L_hPat5lICXb473mnBV8y8YDR-HeznsuY6vP2KInce_8X_vOjZA=="
                }

                # Faixas 2 e 3: Núcleo Hexagonal (Casos de Uso, Domínio e Portas)
                group "Núcleo Hexagonal (Casos de Uso, Domínio e Portas)" {
                    securityComponent = component "Security & Auth Core" "Porta AutenticarUsuarioPort; valida credenciais e perfil de acesso com a entidade Usuario." "Input Port / Use Case" "Core" {
                        url "https://kroki.io/plantuml/svg/eNq9Vs1u00AQvvspRq2EilBaUlSErMhqSBuIBE1oFE5I1cSeJKvYu2Z33T_gYRAH3oFrXozZjdM6xG0QByaRbM_37cy3M-tdHxuL2hZZGhiyYChHjVZpkEpSYFUOVsFYWasySISm2AolAzMX0hEzGGM8n2pVyKSjUh622_VWYZgZJupKyClMMDVUQZJcQPPV86qHJliktqukPcOMYGeI0gxJi8lOPWsobgmahxUwZ0E4paG9SQkmKk1Ib6Kvt6peEZXmACXphbdNkhfi8405XwWPUzRmey5Pe0vImf6S_Lgs1FpdPQo6xSXh0FuFIJWtqU_b_f5kVVW89BYEZU24dRQXWtgbeALtws6gozTtABrI59MLU4IXyNBFzBB8CYBNSEt6gjG5QSStiFGPTIFaqIHStmQ5ewZ0zVF49e6xqMKGmyN6zv8UQhholQlDrQ1Gv7BMiXzQb4G_-AJvxhoZ6qAhEFmeUsaY2aqwAcXSf065YhWj-yfHrPBcFXiZXwqet5_H6mmN959n7GOtFVwkjjFhTsItD8FYze91hWBIznAdeDzHUs1aEqvmJOuCl8XsJXWgVBnV-XNeTSJ1BfE3VUk4ZjbGttRWKlrrn6jJ1QDK0IfcAPz036KZ1YF1SkqNyphCLN17S9qK5Vo5ViollFXpJIusZFT0tk_e987ungbn_e7pcNg_v8ffjc761TAPLvL9_eih9RACHwI0pn8IUDY7hFyrpLjdHmHVkhAuMRUJQqyJl2AsUBigsqI-zIrZaESruoRlXQOebIy5O7fgk2wZPjHC5lHUGkcdlRB8FHQVwlAYy23lowXekLGLHwpOTaxS1Ny59qBXD9Rtca2DcdQ6cFmiu2zNqBW7XTLcPfIWnZDFdEbGhb3bUHDx04Xnaeb81nst7NXIDoIYjXKeYnnBVdmWYyT_F7_ilBTM6BqnSmIKX-H0cyFygiO-HXU78KEQ15gsvrcOvJqVzOCYZOI-AH4D3SSr5Q=="
                    }
                    academicoCore = component "Gestão Acadêmica Core" "Portas CadastrarUsuarioPort, ListarUsuariosPort, CriarTurmaPort, ConsultarTurmasPort e MatricularAlunoPort; entidades Usuario, Aluno, Professor, Turma e Matricula (RN03)." "Input Ports / Domain" "Core" {
                        url "https://kroki.io/plantuml/svg/eNq1V91u2zYUvvdTHLg3zrI0dYsMg2F49bxkDdAWWZ3sZhuCY-nYJiKRGkkl7dY-TLGLAQP2FH6xHVKSLdn0z7qOBmyZ5zv_P6SeG4va5mnSMmTBUIYardIglaSWVRlYBRNlrUohFpoiK5RsmTshHTCFCUZ3M61yGY9UwmyPLvyqIcwcY_Ug5AymmBiqUeJMQPfrJ_UdmmKe2Asl7WtMCdpjlGZMWkzbYdRY_EbQfVojZmwQzmhs3yUEU5XEpDep3-61ugIqzQJK0DO_NkHeEK9vwvpq9ChBY_br8rAXhKzpQPBus1Br9bCT6CwuAU_9qgGksoH4DN1nHVW34iu_Wq0yJtD-noxd_KFgGGG8-CsVEcJIaWoDGsjuZrczpqO6RSaTo95GTIXfW8BLSEt6ihHBCGM0VqO-MTlqoa6UtiXIrWOgtxTlXMIdtiy3vQ2GS7d9BD240ioVhvrl_sDL-NBa0_dSuH4oMWa7tqlIrFZXzCWSb1i4fwio-emXLYpGWqC-znWK-11aQjec8bvbNChpuE1KVrNfTRMf1rXVn1dotYjyBPUwyeX-PK3hN7Qt6Q19vvo3cnxjaISGQKRZQilJa_bVzQnkxf4byhRrvVn9c8gaDnM75wl0L9jHHgxX_xq4z1SHhXvNGgw4t7NID3XtvxdzmYxldYbSsK3KT8C63dLG6-p5Lfj_2pNP6ZjSjWb1h3zZ2U-HOPR5eq6wd61_Avbu7sj_NwGf1t04cR0T2dLFUl3DaBGzFEbxfaK2K1VKoX1KUSQhQqyi3EVJhYiG5BxfoJmHiJlvDqi6pBaDTBmTi2K7U8DqvTRRKiGUm5n0EeIIWpJxyOljSKtoNQ1qSOHITskYPorDkhpgn-4D4hqpWMyCMYqFiUSWCIlbgiRUrF6SFfdB9qyy9jKg93hFPr8W1lVRp8ZQ4XcGdVlgB3iJvkSDJN8jYRKyb7hmQtkMPJ2Hjto5CtNlRJpPBk--VyKum7_tbHv8eLDMaA8iHnBl4ZyuUu8FhE-PNfZy7BQaNwa4AxclUmoiuBfSR9MW-SgYwyOzzu1PFuTW0GXjeMYts8sxvqqV-oxvmny_gFyKSMR8TYTOm9dPnh15GYWG9hdtODkZQLvbrnVADyylDVNXYuscRQB7lXM7kJU_FZKTFWHm3oXgZ9k3_BbS654N-pPBSLGZPwp66MGYE8EDiF9XoLoLn5tIsUlcPcOryzBhy7W5fzoZ9E-dosFSYXfQj9zlu_fozK_Bd2QxmZNxkpcHAS7-dPK4qrjwrI-jAVxK513gb-WZcqOKn3zx0VXPl0UDOIybQYu_nfMG3sP5r7nICM748eZiBD_k4i0L_Ng_9QZVlrae8yByr5b_AA0PsBA="
                    }
                    avaliacaoCore = component "Avaliação e Notas Core" "Portas LancarNotaPort e ConsultarBoletimPort; entidades Nota e Boletim e regras RN01, RN02, RN04 e RN05." "Input Ports / Domain" "Core" {
                        url "https://kroki.io/plantuml/svg/eNqtVttuEzEQfc9XjMpLK5q2KRShVbRqmqYQCUJpoC9QVZPdSbC6ay-2l3L9GMQD4jv6Y9iON3WSTYpUHCmyPGfmzJzxZQ-VRqnLPGso0qCoQIlaSOCCU0OLArSAkdBa5JAySYlmgjfUFeMWmMMIk6uJFCVPuyIzbg9O3AgQ6gOm4prxCYwxUxRY0oJB6-leuEJjLDN9IrgeYE6wMUSuhiTZeKMeNWRfCVr7gbEwCeGEhvpLRjAWWUpy2Xp0Z9YVUEgTwIMeubEMcok4vpHhC-xJhkrdzeVgzwkN0z-C16eFUorrtUabsQfsuxEAuNA1-nTsbxEVZvHEjUbDawIbnU-YMbz5ffNLAMFAaFTQFZI2wEyKq8klOkCC4pJb42VijPCtAWYwrkmOMSF4gTxBab1PhdTebMdDoM-UlGbzbpqcSh0F0L5d2IIITqXImaK2XYyd64_GAkFXcGU2E8ojkZFm-WoazEou-mkESkuzncP43vfdxRyJa1WQ1ltFXVQELC8yyolrtbq8JuhS5nhGhTA8b6q5RQUYK5yHDPx0DnE_kab5LwpUU8UdGv73Wu7dCVf7XJcLKcaklJD9FKq4gdkz1plcbfUms8HN0YiAl_nIXENLCdlU5nRiNWGakKNZScqslqVZxzKl_2auds2SH5BIZlQLwlRRtqfOle-W136ucHNQUJ5b2OYS-JNgaZDJjNCe7BRl354y67TGc04Q3725zqzR190bs8rfXQSmnFKGdaIopkt76Rjb0E89a61ymFnF5KbP4lY4x31LbWsK4_iyyNgXeYLqei8vO4Pjzsve4M2r2WLn9OzVeef4duGsF674yMvXys5OvLTFIzBPNo1ojYvbhJFvGezt7LT2YPNssNfaBvO_7_4fb7kAq64CG6YqLqo0g_zmj-2BjXUw9a8wAS1OJE1wug1JzaGazXhJusg-_sx8mRgVEizsxwi8521lPgOi1kHcHsVdkRKcM7q2_VWacjQu8IyUtg9RTyXCtNPs1c5pf4VhxbvV3h3F7V3LFM8YW3E7sc9f9ODAjfiYNGYfSNnQswvSB0sXX7Pt-ouTTM8m0rAuNsFYrJbwHXofS1YQ2Onbky68LtlnTG9-tnddNlWajUPiqf2y-wvrMy68"
                    }

                    authServicePort = component "AuthServicePort" "Contrato para hash de senha (bcrypt) e emissão/validação de token JWT." "Output Port (Interface)" "Core" {
                        url "https://kroki.io/plantuml/svg/eNqNVNtu00AQffdXjNKXImhLioqQZVkNIaFF0Jq6hRekamxPnFXsXbO7bimXj0E88cBX5MfY3VzYpGnLRHK8c87MOd4d7aHSKHVbV4EiDYoalKiFBC44BVo0oAVkQmtRQ8Ek5ZoJHqgJ45ZYQ4b5pJSi5UVfVKZsa-jCY6gxFuKa8RJGWCnykKJh0H3x1M_QCNtKDwXXJ1gTdFLkKiXJRp3NrJR9Jejue2BjDGFJqb6pCEaiKkjeRl8-6HpBFNI0mJOeubhNckacXmb0PDyvUKmHtRztiNAo_Sf5flsopbi-F7SO54R9Fx6BC71hf3r2t87yXTx3EQTzPYFOr9Vjc3RXLKdESN0BVNBMyks0-Us1Ay4bg8C3AEwwrkmOMCdYq5zjNh5DSRLlESpD4GPcVvaZtBJDUFqaIXsEISRS1ExRNMvEXnUuamtf3lH8BFzKtt_ULxOiIuTxup1zMSG-3eBNJbAIwS2T2cqWzxp5RVd2oFm-KNT26ev5DVzZj8D9uaNfQVe2RrXZJjWqkVWbgMZst0MS9-IrEW_redqT6L16d3yyXCVnp8NBmp6e_cPfXpyc-m3WD3J3N161Hxp3TBPQck9c3QpnZydeWAnNAXI9_V0HRiDHxt5F8IlHytwCYfcgjrK4LwqCD4yuQ0iZ0ubjzXUBr0np6S8BA5WLCiXsQC85vgNY9RztZXG0ZwXipVA3jnI79OHWgQsjyrW9NaFAsBPtNBVO_9i1mTfIJWu0KCWO2AyzY6bMZ5dzfZNzY6Dgzcdz-A6Dzy1rCA7M68WwD-9b9gWL6c9ozwkvHAWHxAt7df8FyxbtlQ=="
                    }
                    usuarioRepoPort = component "UsuarioRepoPort" "Contrato de busca e persistência de Usuario, Aluno e Professor." "Output Port (Interface)" "Core" {
                        url "https://kroki.io/plantuml/svg/eNqVVN1O1UAQvu9TTA43GCJ4MBjTNBUkoFyo6AneqCHT7vS4Ybtb9wfw72GIdyY-xXkxZ3taUg4N6PSi7c73zXwz2Zld59H6UKvEkQdHDVr0xoI2mhJvGvAGCuO9qUFIS6WXRifuTOoIrKHA8mxuTdBi3yimrR22NkC4zyjMhdRzqFA5GnhEI2H69NHwhCoMyh8a7V9jTTCZoXYzsrKajKNm8hvBdHvgbFgQzmnmvyqCyihB9rb3-b2qe6CxHKADPW7tNqgV0uYrON_AXyp07v5cLewlIWf6R_DdstBac3GnMyruANutDQDa-JH-7MVnFTVU8aS1JOl6ApMTF9BK844ac2ysnwA6aM7mp2F5fmrZcdqwB74nwCa1J1thSbDC7PzRNsChOke73gVJe-wDSOHYmlo6ys6NFPmAUgRXouVIR2JdihSct3wbh4wuCPwAHZQa5R7UKNWb8AqZXAaFHIm0l5Us-Xbb_wuqZJy59YbLleoZM9qPEe6HT0vaz6R9YcFZsPTLO9CXPmjPQ5ACei2DU214lkbOKRY15hCmDDXXZ8acS93Q6x4qXArbU0EboEtPWozJ3IC6b-PN-DeicC8qco7v1nikDrx6WTY382tgGrU67jYBAe-uwL-YMLHEJu4x-Kgzxxskne7kWZHvG0HwXtJFCrNIqpFXDbwg5xe_DBy40ii03IC946Nxx4qWbKvIs62YIL9ONM2zMg5MurbTGifVPm5cEAhxGtqcDhd_4j-PWl_C4rcuJXIdpdGOt1-L4zFYXHFGx7fs4EuQDcEOf54c7sPbIC9RLK6yrTZfLyTZ5VbGbf8XLHwCCA=="
                    }
                    turmaRepoPort = component "TurmaRepoPort" "Contrato de busca e persistência de Turma e Matricula." "Output Port (Interface)" "Core" {
                        url "https://kroki.io/plantuml/svg/eNqVVV9vEzEMf79PYXUvRYyNDg2hU1WtTBtMYmjQwQugyXdJS7Q0PpLcxt8Pg3hD2qfoF8NJ77rreluH-3Cp_bP9s-Mke86j9eVUJ056cLJAi54sGDIy8VSAJ8jIe5qCUFbmXpFJ3LkyATiFDPPziaXSiH3S7LZxGKWBcJ9R0KUyExijdrJhEYWC3rPHTY0cY6n9IRn_GqcSOiM0biStGnfaUSP1XUJvp2EsmBBO5Mh_0xLGpIW0q9bna1nXQLIcoAI9ibIKikRivozzNey5RufW54qwlxI50z3Bd9NCa-nyTmNgXAF2ojQAhnxLf4bhdxPVZPE0SpJUPYHOaWmn-FYWdELWdwAdFOeTMx-0Z5bVZwXr4UcCLMp4aceYS1jyqqxBHoJDfYG2GwOkc9wDSOHE0lQ52b8gJQYNeFa6HC1HORJdJVJw3vIMNj1iCPgJptS61XOfhJpQN4-fOsImFDyPJOiV9OqC_iewVuGsnZJA113Bf_i0CmUOjBlL58h2i3p1dHs1twQZ6tLQMbJPXmo-jV0MinvHmXd-4d-d1qsUFsr1W7GADrlveJPCJsSNbee0cF1q6q8kfuKBmM9DY14egRJQx2po55vZZhHK5arQymCbdWnTWwHX27NsXqJ5Xcl6qlWH2kxVr1q9QnfZkBFpiaZJYflsbW0Nqq6loTrHwyJBcoOM48sVb_G4LqDdi1PlWIRHAj6avuPrOe3tDvrZgA-ThPdKXqYwCk6clxUvpPOzPwQHLieNlvkPT47aDUtc-tvZoL8dwg8WaXqDfh7uonRjNwqnND48ZiAQwmUTMzqcXYX_fIvVBcz-mlxho4qAiy12rAzTPrsKJTsev4MvpSok7PLy3eE-vCnVVxSz3_3tmLrmlOxJI8Kb-g-aQnLa"
                    }
                    notaRepoPort = component "NotaRepoPort" "Contrato de busca e persistência de Nota." "Output Port (Interface)" "Core" {
                        url "https://kroki.io/plantuml/svg/eNqVVFFvEzEMfr9fYXUvRYyNDg2h0-m0MW2wB6ZBYS-AJt_FLdFyyZHktrGxH4N4QELikV_QP4aTtizQsg33oTn7s_3ZcbzlPFrfNSpz5MFRixa9saCNpsybFryBynhvGhDSUu2l0Zk7kToAG6iwPhlb02mxYxS7rexFSRDuAwpzJvUYRqgcJRbRShg8eZhqaISd8ntG-wNsCHpD1G5IVo56y1FDeUEw2EiMLRPCMQ39J0UwMkqQXbQ-vZX1HGgsB5iBHkVZBEUiMV_F-RJ7rdC523NF2HNCznRH8M200FpzdqMxMJ4BNqIkAG38kv5sh9_fqJTF4yhZNusJ9A6Mx1fUmkNjfQ_QQXsyPmY3PLasPW5ZDZcZsEjtyY6wJkh9ZsYg98GhOkXbD-55RN2DHA6taaSj4tRIUSZg9B0qeXFnfNW5Gi3n3Bd9KXJw3vK4ph4hAnwG3Sm11PEFskvdKew389P-_wRSMrxCDrStOm12X3e2wT6G83WYVfBB_e-4b99PQ15l8S8OSqw96eQDkALmARJtQnuZ-RTDHefMu6n4PV0Tv2TeXtZXUFvJ_V5S_erUee4bSAdO6XUpvn60RwHWXwCHy0rL-mNE1tbKaYU5tGQdd5GAoDba8X7AjF1qbMPGgne6cLwr8sFmWVTljhEER5LOchgGpwZ5qcAzcn7y1cCuq41Cy3VvH-4vN6QsivWqLNZD9PJ3lkFZ1OFd5CubUTij9mGxgkAIox8TOpz8CN_8oub8J991LTEpIuCQuyJx8m3ykxybwlQ7nqLdj51sCTb5-GZvB1528hzF5EuxHlPPOWVbpEXY778ASKH-kQ=="
                    }
                }

                # Faixa 4: Driven Side (Adaptadores de Saída / Infraestrutura)
                authAdapter = component "JwtBcryptAuthAdapter" "Implementa AuthServicePort com jsonwebtoken (JWT) e bcryptjs." "Driven Adapter / Security" {
                    url "https://kroki.io/plantuml/svg/eNrtVd1u0zAUvs9THHU3Q8BGh4pQVEXrxsa2C1TogBuk6sQ5bU0dO9jOuvHzMIiLPUhfjGO3G9kWNh6AUyl1_H3nxz4_2XUera9LlTjy4KhCi95Y0EZT4k0F3kBuvDclFNKS8NLoxM2lDsQSchTzqTW1LvaNYrWNwygNhpthYRZST2GCylEDKSoJ3ZfPmjs0wVr5Q6P9GywJOiPUbkRWTjrtrJH8StDdaYAVB4RTGvkLRTAxqiB7F917MOororFsYE16HuUuKQYS_eXsr4ELhc497CvSjgjZ0z-S7w8LrTWLe8EQ8ZqwE6VB0Ma33M8g_G6zmlG8iJIk6zuBzsnC7wl7UflB7WeDAitPtgPooJpPx58XfpxHdIwMj3GFw7cEWKTm9QQFQdDl_J9JQUNj_RoP8himZNEeoWOCnuGmC89hbTEF5y3X2yNIYWhNKR31VztZQ1uYMpzE_kX5CcStYL7NXm6MItTZ7XBOzZz0ZoUXymCRQnwdrt6C-spQQ-ks1LYUV4o-PJv-mgai2o8k_sUqgLYrBllWikrS3t1ze0-BMzAiYbnn74QVwYPzitvdHes23KHy70J5OEZ1XebcZP8T8ycxTfRGzbo6b_NGJUrVBlTcBxEZxkXTU2vyt7aym85T7jgnNQLx2BSmiIdK2IRgBR7l8En3HQ_RtNvL-nm2bwqCD5IWKYyk8xwXq8Frcn75y8CBE0ah5QIYDI_bgbao-tt51t8OXrJrb92sL8LgSDd6UbJX5FHNyAWz1yWMy8tgvjAQBwR_SCynX3DhLX9aaQLX0ZSrQy8vMVQOnHw85aOuRgt8h4MvtawIerx8f7gPb2t5jqzb347Or6JKdkkX4RP4G4DyYUs="
                }
                usuarioRepository = component "UsuarioRepositoryAdapter" "Implementa UsuarioRepoPort com persistência relacional SQL." "Driven Adapter / SQL" {
                    url "https://kroki.io/plantuml/svg/eNrlVs1O20AQvvspRuGSigINFVUVRS40QIvUHyDQC0XRxJ4kq6x3ze6akP69S9VDpb5GXqyzjhMMmFDOnRzi7Hwz8_nbmd1sW4fGZYkMLDmwlKJBpw0orShwOgWnoaed0wnEwlDkhFaBHQnlgQn0MBoNjM5U3NaSw1b2cysh7BBjPRZqAH2UlkqeOBXQePmsvEJ9zKTb18p9wISg1kFlO2REv1aN6ogvBI3NkjNlQjigjptIgr6WMZm73tcPsp4DteEEBeh5bndBOZG8Xo_rlfyRRGsfrpXD3hJypX8EL6eFxujxUqdnXAA2cysBlHYV-uz4z21UmcWL3IKg0ARqpzZDI_QxpdoK7qjJToypI1MDtJCOBt1sBuiaBaKLMwh8DYBNKH7uY0RQynWojSv83lbBorxEUy-yNefYJ9CEQ6MTYal1qUUclkJ6mY3QcKaDuC7iJlhnuD_LEUUS-AYqk7Iydi9BIT9m75GDo0wiZyLlRF9E3O_mcUml8FNYT_l1hXzFEflDRezZ-Szse5B_5c0A9ykNIkklJczKLlFwDeIeF9pFhz201JaCA_53fWfCJJge6_GJ3uO6blLnwVm8Pq_78OJXeU-uu_ampDea9iIjM2mdhHV7Ieev8hTy0bLML1Mjpcfq7LxM8aRMbhXoiqLM0WMyXO9TZf_ocYnjDxAxzBOXVpXmc7linfx2VTliHWW-B3WV05IaYneIdljlne3XTU_B_N6eX1sLodao3Ra_WeiF0Dl6tzzD-npYlqTp24AEgqEBt5HRAVOIGMoXIXxWLctXULOxFbZ6YVvHBJ8EcZt0GMqS8F0Fb8i66S8NezbSEpkh7BweVDvu49Ta6IWtDV8pXFRshK3IH73Nla3cwl1yKIdkferF5OP0ty8Ra8jPVj86LHrEJ_v0p58VVsPjWWnLjKd_VCRy0jzuOcDyNO1dZCIl2OLH0_02HGXiCjm8tZHXnxMLtknF_n_EX4aAzCU="
                }
                turmaRepository = component "TurmaRepositoryAdapter" "Implementa TurmaRepoPort com persistência relacional SQL." "Driven Adapter / SQL" {
                    url "https://kroki.io/plantuml/svg/eNrtVlFv2zYQftevOLgvHtY0c4cMg2CoddOmDdAW6Zz1pS2Mk3h2iVCkQlJx07X7L8MeBgzYr_Af25G2FTmR4_S99IME3nd3n44fz_fYebS-LlXiyIOjCi16Y0EbTYk3FXgDufHelCCkpcJLoxN3JnUAlpBjcTazptbi0Ch2u3cUVwvhPqIwc6lnMEXlqGURlYTBrz-1d2iKtfJHRvvXWBL0xqjdmKyc9rpRY_mZYPCwZayYEM5o7C8VwdQoQfam9clO1mugsRxgBfo5rpugSCTmyzlfy14odG53rgh7QciZ7gi-nRZaa-a3GgPjFeBhXC2ANr6jPqPwu45qs_glriRZ1QR6p7Ut8TeqjJOsp8uRwMqT7QE6qM5mEx_ME9vYJ7gEwB8J8JKa36dYEDRxToz1K2tYP4JDdYG2HyOlS9wPkMKJNaV0NLwwUmQteF67Ai1HORZ9KVJw3rIq2x4xBHwBXSvV6XlohJyZfhEf6wj3oWKFGmFekpcX5lsCKxlu36kR6Po38O8-3IQyB8ZMyTlj-9X67Xj712wJMlK1Nq-QfYpa8f3sY9i4c5xl5Rv_frl-S6HZ3H0UDXTEdcPrFO5DPNhuTo3rRlG_JvERrwh06w9kWSkqSXu3VVl7IHLO9RQ95ujoUEmGf9fdd93t0N1Vz9qUzkbTOq_JXg5Ps747V62TDE3VPUqh1mfazPW7DxuV2KwCfaKi9vQtEa4K0XFHzLzF8E-QAtZhW7tL7XVZhHSFrJTU2GVdaXSiokg7EWs5Ta5n3uDalP5ufOOpTrpty_-eLX5BE2zQdZnz6NCisaWh7O1l0Bv0rp95ujomhPGbl7f5P3iQXZ1DCiVWJHFJcZfbRkka13ApFv-F7YSZFwznkQ3e66HjYSkdHGTDPOOGQvBW0jyFMd9N4i7BG8_J-cXfBp65wijkT4PRyXG3oZvVcD_PhvshT9bkG2TDIowI6b2DuLKn5FF9JBcCN90YF_-EBMJAnAO4NVgeRgueQBZ_sYBCEQOe1eSY7-JfXchIOdbJAbW-2vHdfHZey4rggF9_PzqEN7X8hBxpuB-prDkmj0mLMPr-D9OIrNU="
                }
                notaRepository = component "NotaRepositoryAdapter" "Implementa NotaRepoPort com persistência relacional SQL." "Driven Adapter / SQL" {
                    url "https://kroki.io/plantuml/svg/eNrtVttOGzEQfd-vGIWXVBRoqKiq1WoLDdAitQhI2heK0OzuJFjx2ovtJYRe_qXqQ6X-Bj_W8ebCAuHW504eYnnOnDmZ8dhZtw6NK3MZWHJgqUCDThtQWlHgdAFOQ6Kd0zlkwlDqhFaBHQjlgTkkmA76Rpcqa2vJYQvbldUQ9gQzPRSqDz2UlmqerBDQev2ivkM9LKXb1srtYk7Q6KCyHTKi15iP6ogLgtZqzVmwIOxTx40kQU_LjMxt79sHVU-B2jDBBPSystugSkiVL-F8NX8q0dqHc1Ww94Sc6ZHg-2WhMXp4r9MrngBWK6sBlHZz6rPhPzdRdRWvKguCSU2gsasdHlChreDjNNrIsHBkGoAWikH_mOPx2Mzcxzj2w9cA2ITidQ9TginLnjZu4vS2CBblGZqm5wkr1DMIYc_oXFiKzrTI4hoYXYlSXDwan5Q2RcM5d7KmyEKwzvABrkd4BvgGqpRybuBH5JC0lNjMp6udpxBJ4eeSiTZkqfRWtzQ5NtGvr2ieg_Pbd_MeHo0pvwfVV3V0YG5fQOSFpJyUs3eVfAmyhPk30WGCltpSMPp_Q_6pIeN65lgc6GFXbykn3KjJczkuBG_6QL-st-9qKK734NpYnJZkRlE3btpTeSWrmln7JoRSDZQeqsOjurJuXdYi0DmlpaOnMFy16_ZR08OawB8gMpiy1nZnPTme7z9Df8mE3JU84Qu9lmn-cV5aiqHRatysVDj5cQid_Q_3hC8vxzPxoe8TCQRDfT4DRgecOWUcP4TwRUWWn6CwtRZHSdzWGcFnQdzHDkMpR36r4B1Zd_lLw5ZNtUTWBht7O_Mdc9VEK0kcrfg08SxdK45Sf--GC2uVxZvkUJ6Q9byzWcbL354_01Bdr_wOG37hU77WL38aoX0RPL4gY1nu5R-Vikqxn0nLM7B1WoqCYI2Xn7bbsF-Kc-TQaKXKPRUVrJPK_B-Iv8sbxNI="
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
