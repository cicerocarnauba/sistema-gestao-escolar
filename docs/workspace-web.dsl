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
                    url "https://kroki.io/plantuml/svg/eNqdVdtuEzEQfd-vGLUvqYCUFBWhVbQiDQ0XQRuaFB6Ah8l6klj12lvb2xvwMYgHPqQ_xthNw-ZSiphI2azn-MyZi53nzqP1VaESRx4clWjRGwvaaEq8KcEbGBnvTQFCWsq9NDpxJ1IHYAEjzE8m1lRadI3ibZu9aDWEm6Iw51JPYIzKUc0jSgmtZ4_rKzTGSvme0f4AC4KNAWo3ICvHG-tRA3lF0NqpOUsWhBMa-EtFMDZKkF317t2r-hZoLBPMQE-irYKikBhvxPFq_lyhc_fHirBXhBzpH8F_l4XWmvO_OoPiGWAnWg2gjV9Tn074LKPqKp5GS5JZTWDDTaiJpWyiwNKTdU2pR4GxOfW-bGLlpxvwNQE2qdk_xpygU3nSXuZoj12FVpq-sX6GCvYA6ILyiie2wUIqn67ueB3WtyCFvjWFdNReQRxWniFZJP2erCqY8sCdyZxWYp-FQQxEQ3NCuuHDdwrOWx7uEDEu9_FSGRR19tiyyNzlulujFNka8SPAZYmQri9FTYwyE6kblk5TOKLTipx_CJZceHOl0Y4egqYLrtABf_cqHQ9uvS5nRopsvcx3UghF52hpWeZtbW4E1itVk_Ynnf_RF3QtNFxOpO1ze6RrlPHBOYSn-vQl4Gfsr1CzZrua0NtQqBnoxfBwoaNSBKGhp4Jn-LaXNYAjPcVFxzrym4yW2eOArGOt5l2e9ZYZqsLw_nqEpYFpNrM7zkcKmHPxEBpHvcetrbs2LxeCS41KCoTc2NLcs-tPhpwPnwPeeYXwZnB4MN9Ym5qZ1oWTNA-3Rwyx8ObjMAre2Uo44ZwvCc4BPuu24zs9be1m7VHWNYLgg6TzFAbSeSqQL394yQlc_zSw73Kj0PJkdvqv73AsJNTeHmXt7cCfzeO0snYebrB0czda9oI8qim5QCiLUlHBJcfrX4FYGIjXWRwX9rPH8gIc7Q-G4X0--TfwuGAsV-rm_Wiv04VvsH9ayZJgl38e97rwvpIXKK5_tLejkFuFyXPSIvwv_wYbopGP"
                }
                academicoController = component "AcademicoController" "POST/GET /usuarios, POST/GET /turmas e POST /matriculas para gestão acadêmica (RF03 a RF07, RF09)." "Express / Driving Adapter" {
                    url "https://kroki.io/plantuml/svg/eNqlVsty0zAU3fsr7rSbdihJ05ICnoxpCU3pDI_QtGyAhWLfpJrakivJtLw-psOCFV-RH-NKcTJK4iRAlRmPIx2dc3TvleRDbZgyRZYGGg1ozJliRioQUmBgZA5GQl8aIzNIuMLYcCkCfcWFBWbQZ_HVUMlCJG2Z0rTNjmseQl-yRN5wMYQBSzV6I0nOofFk1-_BAStS05HCvGEZwkaPCd1DxQcb1age_4rQ2PMGczLEhtgzX1KEgUwTVIujz9e6ngClIoIStO_aIsgZcXp90vPG45RpvV7LwV4iI6W_BK-2xZSSNysHreMSsOeaBxDSVMTnyP7mUb6LA9eCoIwJbOgh1ljOayxhuUGla1z0LWPt0pi8xmJabsZjuQHfAqDGBYEGLEZo0wxtFFMXumCKy65UpgTZ9gDwFuOCqnaLzBQmXJhwaru3IYSukhnX2Cr7I8fxI5jTe8XtFigxernagKdGyS7N4ukzIncvFTIfPi0RaivO1HmhMrZ-SVPowmJc7zIFKTTtjHKqXi8zi6_WWrqe18woHhcpU0dpIdbnaQ6_oDYdn9FzBQ9Hk3ohy5SFNEXlaT2EeK4GIKysI29GOpN2wi_Wgc8_TQiEc4n0UbPxhLAqIx4-m40IhFUx9SKaS21Kg1sKr0M4w-sCtdkBhdr-0znpoR_Uz5InkUcxxAmD_l8K68It5x4exuG4j4NppP6dpKysqpqq1aLqA4h43vbOoV5MCmbrrLO7v72SqOJkCeHkeJ7lYDXL3LExMWLGJWYJHq0hqDgVSh8eycEO0POxez5dTVi18Se2piU9Zm1uBxTtmK4A-m6Aj6Kl6cYOG82o1Y_aMkF4z_EmhB5FCmlvUccJZXH0U8KxjiUp0C456p4uGVj016r3o1bdikRTsUbUiu0lFW42XYteoGHpJWrLyrM8xQyFYaNflj2R4G4s-mhRcHZMS7IXHpXsWJxmUO5GdzZ5O1CGD91GHv0eL_s7HF8XPEdo0utFpw3vCn7LktFdq-5sTPwFhygS--H1B4-INEg="
                }
                avaliacaoController = component "AvaliacaoController" "POST/PUT /notas e GET /boletim para lançamento de notas e consulta de boletim (RF08, RF10)." "Express / Driving Adapter" {
                    url "https://kroki.io/plantuml/svg/eNqlVc1OGzEQvu9TjMIF1DYhVFRoFa2A8NNUFVASeqEcJruTYOG1F9sLlLYPU_XAg_BiHW820SYsgaqTS9bzzTefPePxtnVoXJ7KwJIDSxkadNqA0ooCpzNwGobaOZ1CIgzFTmgV2CuhPDCFIcZXY6NzlXS15LCVg8IqCHuJib4VagwjlJYqniQT0N5ar67QCHPpDrRyR5gSNPqobJ-MGDXqUX1xT9DeqDgzFoRj6rvvkmCkZULmqXf3RdVToDZMUILeF_YUVAgp8g05X8UfS7T25VwF7CMhZ3oleLksNEbfLnV6xSVgo7AKQGlXcz47_reIqqr4UFgQlGcCDTumJmaiiQlmjoxtCjX0jM1L57Im3qAUGKNuwI8A2IRi0Ahjgs-oYjRH2uGJNq50e3sDdEdxzv26yjJyF1agPb-wBiGcGJ0KSx2_GBWhv4KFBF2tLPcPml0tyYn0-TQoc6V7SQjWGe7gKn8Ze34xl6SoDuxMN8eZnNFSkqnwvwM5kw3hwnYrqHhBJmPrlFd0Z9o6T7Rq6DqEU7rOybq3YMj6L5txNFX3cKNFElXj8_8KH5Mrdf07w9z5LZR1rjaZ0SOyVpteAtO6VNxlxepcLjcp1ru4XtzDIag8HfK8eCKo3NZ0C3uD4zlNS5gTYWORSaGwzsu3CO0s7_lFxZVSInBe0sRhhct9b83zlXLrOq_ZjBbvFFfguD9onZwNoDXRsHp6sL61tpSj9tqEcLjPJMOyRZmmvb72SimT4oaQMgCBGMWzYmlsTR34FPh9YPg9wqf-8VHAJxHzxOFnCr6pjuUHImxvRp1h1NUJwVdBtyH0hXWUIr8kcMgd-vhHw76NtUTD927npPeM46mqTmsYdVo-STRL1o46sZ-J4cpmYdEeOZSXZD2rSDNJKe8VHx88e6KhGJD8Rho43e8PwM9XPyEeH9DjtI-a1IhmI8GHTY_8J-xf5yIj2OS_Zwdd-JKLO0wef3dahYypvmCbVOLf-b8oUZ_J"
                }

                # Faixas 2 e 3: Núcleo Hexagonal (Casos de Uso, Domínio e Portas)
                group "Núcleo Hexagonal (Casos de Uso, Domínio e Portas)" {
                    securityComponent = component "Security & Auth Core" "Porta AutenticarUsuarioPort; valida credenciais e perfil de acesso com a entidade Usuario." "Input Port / Use Case" "Core" {
                        url "https://kroki.io/plantuml/svg/eNq9Vc1u00AQvvspRqmEilBSUlSErMhqSBsaCZpQK5y4jO1Jsqq9a3bX9Ad4GMSBd-CaF2O8cVqHuA3iwCSS7ZlvZ7752d1jY1HbIks9QxYM5ajRKg1SSfKsysEqiJS1KoNEaIqtUNIzl0KWwAwijC_nWhUyGaiUl-0NndQQZoGJuhJyDjNMDdUsSS6g--p5XUMzLFI7VNKeY0bQClGakLSYtZpRobgl6B7WjDkTwjmF9iYlmKk0Ib1tfb2T9RqoNDuoQC-cbIMcERcv4ng1e5yiMbtjOdgZIUf6S_DjtFBrdfWosWRcAQ6d1ABS2Yb69Mvfn6g6i5dOPK-qCbTMnDqYi06sNHUMxYUW9qYFXzxgEdKSnmFM0C8sSSti1FNToBZqorStUKU8A7rmxTyk-xy7sP72ilGpfwo-TLTKhKHeFmJcWIYEzuk3zz1cHbd9TQ0N0BCILE8pY5vZybANxUp_QbliFtP7rxJZw2FhFzzNnwXn7fJYf23g_nPGztdGwUVSImaMSbizPhirefvWAIbkAjcNj8dYsdkIYtUlySbnVTFHSZNRqoya9DlPk0jLgriXOiWMGI2xrbhVjDb6JxpitYEydC63DC79MzSLJmMTk4qjMqYQK_X-CrZGla2MlEoJZZ06ySKrEDW-_ZN3o_O7r8nFeHgahuOLe_vb6fm47ubBIe90gofmwQc-6ymif3BQNduHXKukuN3tYd0SHz5jKhKEWBOPYCxQGKCqos7NGtluB-u6-FVdPU42xry8nuCj7Bm-GPzuUdCLgoFKCD4IuvIhFMZyW_kGgTdk7PKHglMTqxQ1d64_GTUbwurwgiduz8KAT7TeQRT0DsoowV20btCLy8PQ3ztyEpyQxXRBpnR7d6Dg8mfpntPMedc7LqzVyAqCGI0qNcXqgeuyrdZI_i9_xSkpWNA1zpXEFL7C6adC5ARH_DodDuB9Ia4xWX7vHTg2a5reMcmkvOd_A5-6oso="
                    }
                    academicoCore = component "Gestão Acadêmica Core" "Portas CadastrarUsuarioPort, ListarUsuariosPort, CriarTurmaPort, ConsultarTurmasPort e MatricularAlunoPort; entidades Usuario, Aluno, Professor, Turma e Matricula (RN03)." "Input Ports / Domain" "Core" {
                        url "https://kroki.io/plantuml/svg/eNq1V19v2zYQf_enOLgvzrIkdYsMg2F49bxkDdAWWZ30ZdvDWTrbRCVSI6mk3doPU-xhQIF-Cn-xHinJlmz6z7qOBmz57nf_70jqibGobZ4mLUMWDGWo0SoNUklqWZWBVTBR1qoUYqEpskLJlnktpAOmMMHo9UyrXMYjlbDYg0u_aggzx1jdCzmDKSaGapw4E9D9_mGdQlPME3uppH2BKUF7jNKMSYtpO4waiz8Juo9qzIwdwhmN7duEYKqSmPQm98e9XldApVlBCXrs1ybIO-LtTdhejR8laMx-Wx72lJAtHQje7RZqre53Mp3HJeCRXzWAVDaQn6H7rKPqXnznV6tV5gTaZkanmInTSGl-iDi6VESqDX-1gJeQlvQUI4IRxmisRn1rctRCXSttS5Bbx0BvKMq5STtsO7e9DYErRz6CHlxrlQpD_ZI-8Dret9bsPROu40uM2W5tKhKr1TVLieQHVu4fAmZ-_X2LoZEWqG9yneL-kJbQjWA8dZsFJQ0PQilq9ptp4sO2tsbzHK0WUZ6gHia53F-nNfyGtSW_Yc_390aNbw2N0BCINEsoJWnNvr45gbygv6RMsdXb1T-HrOEwt3PeY-4Ex9iD4epfA_eV-rAIr9mDgeB2Numhof33Zi6LsezOUBm2dfkJWEctfbypnteS_68j-ZKJKcNodn8olp3zdEhAX2fmCn_X5ifg7-6J_H8L8GXTjRM3MZEtQyzNNZwWMWthFN8YalSpUgrRKUWRhBixinKXJRViGpJzfIpmHmJmfjigmpJaDjJlTC4KcqeA1WdpolRCKDcr6TPEGbQk41DQx5BW2Wo61NDCmZ2SMXzYhjU1wL7cB-Q1UrGYBXMUCxOJLBEStyRJqFg9IyvuguJZ5e1VwO7xin1xI6zrok5NoMLvTOqywQ6IEn2LBll-RsIs5NhwzYVyGHh3Hjpu5yjMlxFpPhk8-06JuO7-trPt9HSwrGgPIt7gysY5W5XeKwifHmvi5bZTWNzYwB24aJHSEsGdkD6btqhHIRjeMuvS_mRBHg1dDo4X3LJ3OcHntVaf8V2S7xeQSxGJmK-I0Hn54uHjI6-jsND-pg0nJwNod9u1CeiBpbTh6kptXaJIYK8KbgeyiqdCcrEizNzbDvwm-4bfM3rd80F_MhgpdvOVoPsejLkQvAHxCwn8zC2x-FvBhYkUu8TdM7y-CjMqypDvxIuPfClGzrOm_tlk0D9zhgZLg91BP3LX696Dc78GP5HFZE7GaV4eBLj4x-njruLGsz6PBnCpnanA38oL5UYVP_nig-ueb4sBcBi3By0-ueANvIOLP3KREZzz4-3lCH7JxRtW-KF_5h2qPG094Y3IvTx-BuAmo4o="
                    }
                    avaliacaoCore = component "Avaliação e Notas Core" "Portas LancarNotaPort e ConsultarBoletimPort; entidades Nota e Boletim e regras RN01, RN02, RN04 e RN05." "Input Ports / Domain" "Core" {
                        url "https://kroki.io/plantuml/svg/eNqtVlFv2zYQfvevOCQvCRY7cbYUhWAIcR1nM7C6WZzmpQ2Ks3R2iUqkRlJNt7Y_pujD0N-RP9YjLTm0rTgFOhowBN539919dyJ1aixqW-ZZy5AFQwVqtEqDVJJaVhVgFUyVtSqHVGhKrFCyZd4J6YA5TDF5N9eqlOlAZey2e-5XgDBvMVW3Qs5hhpmhwJIWArpPj8IdmmGZ2XMl7Rhzgp0JSjMhLWY7zaiJ-JegexwYC04I5zSx_2QEM5WlpDetzx7NugYqzQEq0K9-bYJ8Ip5vynyBPcnQmMe5POwPQmb6QfD2tFBrdbvV6DKuAMd-BQCpbIM-ffdbR4VZPPGr1ao0gR0zpw4WopMozQ_vMROYoNqBjy3gJaQlPcOE4E-UCeqxsnihtK3Mbv0C9IGSksdzj1lLGwXQkdvYhwgutMqFoZ7bjL3r59YawUBJw-OC-pnKyIr8YRrMSqlGaQTGah7YMH7l--pmhcQ3I0jrpaEBGgKRFxnlJK15uLw22FLneEmFYp6r-tmhAgzrXEPG1eMK4udEWuS_LlBDFY9o-L_X8tOd8LWvdLnQakbGKD1KoY4bmCvGJpOvrdnEY83DH4Es8ykfNBsJuVRWdBINYdqQI-8kZdbI0m5iWdB_5MPbiuQzJFqwakGYOsrBwrn23a-0XymcXxTU1w62twF-r0QaZLIkdO9zinrk3jLntMVzRZCqeyud2aKvGxmzrPzVTWDKKRXYJIoRtnRHDdsm1WPF2qgcZk4xvVdlcS-c576ndjWFcaqyiO3rPEF1w-dv-uOz_vPh-OrFcrN_cfniun92v3E5DHeqyJvHSqcTb4x4BHwp05S2uPghjKqWwVGn0z2CvcvxUfcA-P_Y__-27wM8dBS4MHVxUa0Z5HffXA9crJOFf40JaHGuaY6LMSSzgmq34w3pIne9C_72YBUSLNznBryWPcMXfdQ9iXvTeKBSgmtBt66_xlKO7AK_k7F3XxUMTaK4nTyr_YvRAwZ_Gd3953bJp-kOOE29w2ncO3RM8ZKxG_cSd8FFuyd-xWdkMXtLxoVeHpBVsHT9NjtoPjiJezbXzLreBLY4LeETDP8uRUHgHl-eD-CvUnzA9O5L79BnU6fZOiWZum-376j0Ikc="
                    }

                    authServicePort = component "AuthServicePort" "Contrato para hash de senha (bcrypt) e emissão/validação de token JWT." "Output Port (Interface)" "Core" {
                        url "https://kroki.io/plantuml/svg/eNqNVE1T1EAQvedXdC0XLCW4WFhWKpViRVawFCIBvXjpJL1himQ6zkxA_PgxlicP_or9Y87M7mIWFrBTlWTmve73MtOZHW1Qma6pA00GNLWo0LACyZICwy0YhpyN4QZKoagwgmWgz4V0xAZyLM4rxZ0sd7m2aWtjHz2GPsOSL4WsYIK1ph5StgKGL572Z2iCXW3GLM0hNgSDDKXOSInJYDUrE18Jhls9sLWGsKLMXNUEE65LUrfRlw-6XhBZ2QJz0jMft0neiNfLrV4PL2rU-mEtT9sntEr_Sb7fFirFl_eCzvGcsOWjR5BsVqzPyF03WX0Xz30EwXxNYKArCrEVYcGKwpaV0SF3JtRUdEqYqwF8C8CGkIbUBAuCUWfO7F5fiIJSS5_jLh5DRQrVPmpLkGe4rt097RRGoI2yvfUIIkgVN0JTPJtJetkFN861uiP5CfgpV35VvZy5JpTJTTsnfE5yvcWrmrGMwA_T2cilzwr1ki5cH4tikWjcva_XL-DTfgT-4Xd8CV1aGt3lq9SoQVGvAlq73B5J_UtfiWTXzKd7EqNX7w4Or0fp8dF4L8uOjv_hb08Pj_plbm5kGCbL9iPrThgCul4Tn7fE2dhIFlYiu4HSTH83gRUosHVHEHySsbY_fzTcTuI82eWS4IOgywgyoY39eHtKwGvSZvqLYU8XXKOCDRilB3cAy57jzTyJN51Aci00TOLC9Xq0tu3DikrjDksoEVyDe02N0z9ubPsNCiVaw5XCiZhhrs20_exqrm_nfBtoePPxBL7D3udOtATb9vV0vAvvO_EFy-nPeNMLLxwFOyRLd2L_BU4S6cI="
                    }
                    usuarioRepoPort = component "UsuarioRepoPort" "Contrato de busca e persistência de Usuario, Aluno e Professor." "Output Port (Interface)" "Core" {
                        url "https://kroki.io/plantuml/svg/eNqVVM1u00AQvvspRumlqCIlRUUoikxL1UIPQCEqF-AwWY_Dqusdsz9N-XuYihsST5EXY9aJK7e1WhgfYu9838w3k53Z8wFdiJXJPAXwVKPDwA4sW8oC1xAYZhwCV1BoRypotpk_0zYBK5ihOps7jrY4YCO0jaPGOgj_GQteaDuHEo2njqeoNYyePuqeUInRhCO24TVWBIMpWj8lp8tBP2qqvxGMdjrOWgThnKbhqyEo2RTkbnuf36u6BbKTAGvQ48ZugxohTb6Z5Ov4lUHv78_VwF4SSqZ_BN8tC53jxZ3OpHgN2GmsA7Acevqzn56bqK6KJ41l2bonMPBzGmKth4odDWt2wQ85hmH0EZ3mAXzPQEzbQK5ERXC6cryjmk8EvfYn2wKP5hzd5po7brEPYAwnjivtaXLOusg7lFn0Cp1EOi42dTEGH5zcwS5jHQR-gI3G9HIPK9TmTXyFQlbRoEQiG3Spldxp939BjU6TtllLudo8E0bz0sP98GlF-5k1PziTLKjC6p9vS--05yHoAlotnVPLMkE955SK6nMUrGIl9XGfc6UbWt1dhSth-yZaBroIZIs-mVtQtW28Hv9aFOlFSd7LjeqPtAbfvCzDYX4FHCetXrpNQCAbK8onZkJUWKftBR_txMveGI9288ksP-CC4L2mxRimiVShLBh4QT4sfzEcesUGnTRg_-S433FDy2R7lk-2U4L8KtEon6g0JuON3cYkqQ1pz0KBkGajyelx-Sd9y4C1JSx_W6VR6lBsvey8BidjsLyUjF5u2eGXqGuCXXk9PTqAt1FfYLG8nGw3-Voh2Z60Mu34v8Z6_YA="
                    }
                    turmaRepoPort = component "TurmaRepoPort" "Contrato de busca e persistência de Turma e Matricula." "Output Port (Interface)" "Core" {
                        url "https://kroki.io/plantuml/svg/eNqVVc1uEzEQvu9TjNpLECUloCK0iqKGqoVKgAopXIDDZD0JVh3PYntbfh8GcUPqU-TFGDs_3TTbpkwO68x8M_PNeGzv-4AuVBOTeQrgqUSHgR1YtpQFLiEwDDkEnoDSjoqg2Wb-TNsInMAQi7Ox48qqAzbitn2UpIbwn1HxhbZjGKHxVLOoUkPn6cO6hkZYmXDENrzGCcHWAK0fkNOjrWbUQH8n6DyqGUshhGMahG-GYMRGkVu3PtvIegFkJwHmoMdJ1kGJSMo3lHw1e2HQ-825EuwFoWS6I_h2WugcX9xqjIzngEdJagDLoaE__fi7jqqzeJIky-Y9gS0_pjaWul2wo3bJLvg2V6EdKjfBLfiRgYi2gdwIC4LTqH5LJZ8Icm6Nch88mnN0reSXz3D3IIcTxxPtqXvOWvVq8GHlC3QS5Vi1tMrBByezV_dIIeAn2MqYRs8DVnrMrSJ9FhF2oJQ5ZMUvKehz_p_ARsczdsoKfWsN_-HTOlQ4CGZE3rNrlYvV8c3V3BCkbyrLr1B8isrIKWxhVNw5zqzzS__WZLHKYancvBVLaF_6htcp7EDa2GZOS9eVpv7K0icdhNk81OblAWgFi1g17WwzmyxK-0KXRltssq5seiPgantWzSs0ryrZTHXeoSbTvFeNXrG7YhgyG0Jbp7B6ttrt3rxreazOy7AQkDTIerlU8QaPqwKavSRVgWV8HOCj7Xq5lvPOXq877MlhIniv6SKHQXSSvKJ4Tj5M_zAc-oINOuHfPzluNqxw6e4Oe93dGL63TNPpdYt4B-Xbe0kkpQ3xEQOFEC-elNHj9DL-l9trUcD0ry001qqIuNRiL8o47dPLWLKX8Tv8UumSYE-W744O4E2lv6Ka_u7uptQLTtk-WRXf0n_1G29A"
                    }
                    notaRepoPort = component "NotaRepoPort" "Contrato de busca e persistência de Nota." "Output Port (Interface)" "Core" {
                        url "https://kroki.io/plantuml/svg/eNqVVMFuFDEMvc9XWNvLIsqULSpCo9GopWqhB6rCQi_AwZPxLlEzyZBk2tLSj0EckJA48gX7YzjpLg10aYv3sJn42X52bG86j9b3rcoceXDUoUVvLGijKfOmA2-gNt6bFhppSXhpdOaOpA7AFmoUR1Nret1sG8VmK7tREoT7gI05kXoKE1SOEk3TSRg9eZje0AR75XeN9vvYEgzGqN2YrJwMlqPG8oxgtJ4oOyaEUxr7T4pgYlRD9rr26a2sF0Bj2cEc9CjKdVAkEuPVHC_RC4XO3R4rwp4TcqQ7gm-mhdaakxuVgfEcsB4lAWjjl9RnK_z-RqUsHkfJsnlNYOCmlGMnc2Es5Z2x3uWm9zkb4gDOM2CR2pOdoCDY59tX1JkDxs2VQe6DQ3WMdhisioi6BwUcWNNKR-WxkU2VgNH3qOTZnfF17wRajrnXDGVTgPOW-zS1CB7gM-heqaWGL5BNRK9w2C5Oe__jSMkwfuxoS_Xa7LzubYtDDOcrN6vgw_W__b59f-nyIot_sUNi7kklH4BsYOEguU1oL1MfY3jcgnm3NQ_SFfFz5u2luABhJdd7Sfarl8YL20A6cEqfS_Hzoz0MsOE1cHisNK0_WiTPq8sMC-jIOq4iAYEw2vFiwIxNBHZhVcE7XTpeEsVooyrrats0BIeSTgoYB6MWeZvAM3J-9tXAjhNGoeW8tw72litSFuVaXZVrwXv1O8qoKkUYiGJlIwpH1D5sVGgQwhTEgA5nP8I3j9KC_-y7FhKTJAIOuSoSZ99mP8mxKnS14y7a-djLjmCDj292t-FlL0-xmX0p12LoBadsk3QTFvsvWnv7bg=="
                    }
                }

                # Faixa 4: Driven Side (Adaptadores de Saída / Infraestrutura)
                authAdapter = component "JwtBcryptAuthAdapter" "Implementa AuthServicePort com jsonwebtoken (JWT) e bcryptjs." "Driven Adapter / Security" {
                    url "https://kroki.io/plantuml/svg/eNrtVc1u00AQvvspRumlCEhJURGyLKtpaWl7QIEUuHAZ25Nkqb1jdtdNw8_DIA59kLwYs5u0uK1peQAmkmPv983M553Z8a51aFxTlZElB5ZqNOjYgGZNkeMaHEPGznEFhTKUO8U6smdKe2IFGeZnU8ONLva5FLeNw2Athp1hwXOlpzDB0lILKWoFg5fP2is0waZ0h6zdG6wIemPUdkxGTXrdrLH6SjDYboG1CMIpjd2iJJhwWZC5i-49qPqKyEYCrEnPg90lBSEhXyb5WnheorUP5wq0I0LJ9I_k-2WhMTy_F_SK14TtYC2CZtexP0P_u81qq3gRLIrWewI9O6U-1qqPBdaOjO1z4zIfso-Nm_XgWwRiSgs2wZxgKKtS6nOV04iNW-PeHsOUDJojtELQM9y0_jpqDMZgnZHWegQxjAxXylKyWklb3jlXXrT5i_MTCEs-fFe8jLkk1OltOad8RnqzxkXJWMQQHkerJ---CtRyOvdtrPIrR-ev7XztAMHtRxT-QsHhZO72crOond-m4WpLQVV1SRVpZ-_Zvafwee7GlBs53ndkBfDgopaTbY91F26xdO982ayguqkyOU__C_OnMG30Rs_aJuvKRhWqsguo5RwEZBRu2pk6i9_vpzeTxyB6lEYgmZA5F-GlIgmRi4NMbfikEyvzMh7spEmW7nNB8EHRPIaxsk50iRu8JuuWvxgObM4lGmmA4ei4G-hSlWxlabLls6TX2QZpkvsZEW_sBEtfkcNyRtaHvW5hXF768AVDGBjyzTBS_lwab_nTKPZcS1PpDr28RN85cPLxVF41CxLgOxx8aVRNsCO37w_34W2jLlB8k62Q_EpVtEu68F-738ZGWKg="
                }
                usuarioRepository = component "UsuarioRepositoryAdapter" "Implementa UsuarioRepoPort com persistência relacional SQL." "Driven Adapter / SQL" {
                    url "https://kroki.io/plantuml/svg/eNrlVs1u00AQvvspRuklCJoSUBGKIkMpLVTip20KF6jQ2J4kq6533N110_L3LogDEq_RF2PWcVq3NS09MznE3vlm5vO3M2s_dR6tL3MdOfLgqECLni0YNhR5LsAzJOw955ApS6lXbCJ3oEwA5pBgejCxXJpsnbWELW1W1kC4KWY8U2YCY9SOGp6sUNB_fL-5QmMstd9k499gTtAZoXEjsmrcaUeN1GeC_oOGsxBCOKGRP9EEY9YZ2aveZzeyXgDZSoIa9LCyq6CKSFUvkXoNf6rRuZtrVbCXhFLpH8HX00JreXatMzCuAQ8qawAM-xZ91sLvMqrJ4lFlUVRrAh03oR4WqocZFp6s63Hpk5CyV8idcp5MSr3SlWgVd-BLBGLKCHSMKcG7uWOXCt5m62t_sLvgUB-h7daxgwX2Dgxg23KuHA2PWGVxIyQpXYpWMm1lXZUNwHkrLdmMqJPAVzCl1q2xGzkq_bZ8jRKclholExmvxiqVFre3S6pVGLyuaDFW-olEVBctsR_252Hfouqv2v-mOk7JuJ6szVUGlReacmHlrlFwGbJECj1Hjwk6WtdKAv53fefC5Fjs8myPN6SuP-nKrJw9vqyH8PquuSfnXXtR0gtNe1iSPRnuxV13qBePcg-qaXLCrzQHhmfmw36T4l6T3F2gY0pLT7fJcL5Prf3DswbH76AyWCRurBqWo7hlncJ2tTkyTsvQg9zmdGSm-GmKbtrmne_XRU_N_K89v7wcQ6ffuSz-oNYLYbTz6voMvV7clGQQ2oAUgqWJtJHlSCikApV3H3w0QydvnUF_NR4m8TpnBO8VSZuMwpmWo7ye4AU5f_qTYcOlrFEYwtr2Vrvjb5yGK0k8XAmV4rOK_XiYhtN2sLRaWfycPOopuZD6bPLx9FcokTFUR28YHRE9lZP39EeYFVEj4OtT-PS3SVVFWsa9AjiZpo3DUhUEq3L5bnMddkp1jBI-XKnqL4hFT8lk4dPhDxCwxlA="
                }
                turmaRepository = component "TurmaRepositoryAdapter" "Implementa TurmaRepoPort com persistência relacional SQL." "Driven Adapter / SQL" {
                    url "https://kroki.io/plantuml/svg/eNrtVs1uGzcQvu9TDJSLisZylcJBsBA2UZy4NZAUTuX04hrG7HKkEOaSa5Jrxc3PuxQ9FAiQp9CLZUj9eGWvLOce6rArzjczH2eGs_PMebS-LlXiyIOjCi16Y0EbTYk3FXgDufHelCCkpcJLoxN3LnUAlpBjcT6xptZi3yhWe3AQVwPh3qEwU6knMEblqCERlYT-k1-aOzTGWvkDo_0fWBJ0RqjdiKwcd9pRI_kPQf9RQ1gxIZzQyF8pgrFRguxt6fOtrJdAY9nAAvRrXLdBkUj0l7O_hrxQ6Nx2XxH2OyF7uif4blporZneKQyMF4BHcTUA2viW-AzD7yaqyeJxXEmyiAl03IR6WMkeCqw8Wdcztc-DyV7F_6TzpAvq-dqW2IEPCfCSmoFjLAiOw_afVJkjY_1CGtbP4FBdou1GvXSO-wlSOLKmlI4Gl0aKrAHPa1egZSuHoitFCs5bLsWmRjQBH0HXSrVq7hshJ6ZbxMfSwkPgU0gjzCvy8tJ8j2Elw5U7NgJd9xb-5PQ2lDkwZkzOGdutlm-Hm0-zwchQ1dq8RtYpasWXsoth49525pFf6XfL5VsKq83tqVhBhxw3vEnhIcTEtnNaqa4F9VMSH_FeXNeNk9zErobz2gNZVopK0t5trKwdEDn7eoEec3S0ryTDf9Tdj7rbUnfXPWu9dNaa1kVN9mpwnHXdhWpkMnRS9zSFWp9rM9Unp2uRWI8Cvaei9vQ9Fq4D0XJHzLTB8DNIAUuzjd157bVJhHSFrJTU2CZd1OiZikXailiW09lNz2tcV6G_H9-Y1bN2WUzwBhmGmmCBrsuc54UGjQ0NZWcng06_czPn6SJNCKM3r-7S7_Wy6zykUGJFEucUt6mthWSlGi7F7GvYTph5wXCe0-BvPXA8IaX9vWyQZ9xQCP6SNE1hFL6_3CV44zdyfvafgZeuMAr5aDA8OmwXtLMa7ObZYDf4yVb--tmgCHNB-mAvruwFeVTvyAXDq26Ms_-DA2EgDgncGixPoAXPCLN_uYBCEAN-MS_MvuhCRsoxTg6ocWrHd_PlRS0rgj1-fXuwD29q-R7Z0mA3UllyTJ6RFmHe_QbNfaff"
                }
                notaRepository = component "NotaRepositoryAdapter" "Implementa NotaRepoPort com persistência relacional SQL." "Driven Adapter / SQL" {
                    url "https://kroki.io/plantuml/svg/eNrtVttOGzEQfd-vGIWXVC2hoaKqVtGWNECL1CIgaV8oqmZ3J8HCay-2lxB6-ZeqD5X6G_mxjje3BcKtzzUPMZ4zZ05mPONsWofGFZkMLDmwlKNBpw0orShwOgenIdbO6QxSYShxQqvAngrlgRnEmJwOjC5U2tGS3VZ2ylVB2BNM9VCoAfRRWqpY0lxA89Xz6gn1sZBuRyu3hxlBrYvKdsmIfm05qisuCZrrFWPOgnBAXTeSBH0tUzI3rW_uVT0DasMEU9CLct0ElULKeDHHq9gTidbeH6uEvSPkSA8E3y0LjdHDO41e8RSwXq4KQGm3JD9t_3cdVVXxslxBMM0J1OyAGpiLBqaYOzK2oQsXe8pGzv8J60gl1GAerMHXAHgJxbg-JgR7fHpIud7Xxk2Nfj0Fi_IcTd17hSXqCYSwb3QmLLXOtUijChhdgVJcPhgfFzZBwzF307pIQ7DO8LWtengG-AaqkHKp4wdkl6SQWM9mu93HEEnhu5GJ2rJQertXmAzr6PcLmmfg_PHtvEfHE8rvQflRXph5Rq3g5h61JzUBkeWSMlLO3pbyVUhj5t9ChzFa6kjB6P8F-aeCTPKZYX6ohz29rZxwozp34yQRfOgd_bZavkVTXK3BlbY4K8iMWr2obs_kQlbZqfZ1CIU6VXqojo6rynpVWU-BLigpHD2GYVGum1dNDysCf4BIYcZaOZ3X5Mty-zn60RJyVbKYx3gl0vLrvLoaQa1Zu56pcPrlELoH7-9wbzSiufjQ14kEgqEB3wGjA46cMI6fP_isWpYfnrC5EbXiqKNTgk-CuI5dP9Yy5BcK3pJ1418atm2iJbI2aO_vLjcsVdNai6PWmg8TzcM1o1bip224slGuaIscyhOynnfeyzj-7flTDeXo5dfX8Lue8OQd_zRC-yR4_HQKj_-oRJSKfU9a7oHts0LkBBu8_bjTgYNCXCC7ttbK2DNRwSap1P9s-AvhsMBT"
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
