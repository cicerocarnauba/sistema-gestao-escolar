import { FormEvent, useState } from "react";
import { useNavigate } from "react-router-dom";
import { useAuth } from "../../contexts/AuthContext";
import { autenticarUsuario } from "../../services/authService";
import { AlertBanner } from "../ui/AlertBanner";
import { BrandMark } from "../ui/BrandMark";
import { Button } from "../ui/Button";
import { TextField } from "../ui/TextField";

export function LoginForm() {
  const [identificador, setIdentificador] = useState("");
  const [senha, setSenha] = useState("");
  const [mostrarSenha, setMostrarSenha] = useState(false);
  const [carregando, setCarregando] = useState(false);
  const [erro, setErro] = useState<string | null>(null);
  const { registrarSessao, rotaInicialPorPerfil } = useAuth();
  const navigate = useNavigate();

  async function handleSubmit(e: FormEvent) {
    e.preventDefault();
    setErro(null);

    const idLimpo = identificador.trim();
    if (!idLimpo || !senha) {
      setErro("Informe seu e-mail ou matrícula e a senha.");
      return;
    }

    setCarregando(true);
    try {
      const resposta = await autenticarUsuario({
        identificador: idLimpo,
        senha,
      });
      registrarSessao(resposta.token, resposta.usuario);
      navigate(rotaInicialPorPerfil(resposta.usuario.perfil), {
        replace: true,
      });
    } catch (err) {
      setErro(
        err instanceof Error
          ? err.message
          : "Não foi possível concluir o acesso.",
      );
    } finally {
      setCarregando(false);
    }
  }

  return (
    <section className="login-panel">
      <div className="login-form-container">
        <BrandMark label="Portal Acadêmico" size="lg" />

        <h1 className="login-title">Entrar no sistema</h1>
        {erro && <AlertBanner message={erro} variant="error" />}

        <form onSubmit={handleSubmit} noValidate>
          <TextField
            id="identificador"
            name="identificador"
            label="E-mail ou matrícula"
            icon="mail"
            type="text"
            autoComplete="username"
            placeholder="ex.: aluno@escola.edu.br ou 2026001"
            value={identificador}
            onChange={(e) => setIdentificador(e.target.value)}
            disabled={carregando}
            required
          />

          <TextField
            id="senha"
            name="senha"
            label="Senha"
            icon="lock"
            type={mostrarSenha ? "text" : "password"}
            autoComplete="current-password"
            placeholder="Digite sua senha"
            value={senha}
            onChange={(e) => setSenha(e.target.value)}
            disabled={carregando}
            required
            action={
              <button
                type="button"
                className="toggle-password"
                onClick={() => setMostrarSenha((prev) => !prev)}
                disabled={carregando}
              >
                {mostrarSenha ? "Ocultar" : "Mostrar"}
              </button>
            }
          />

          <Button
            type="submit"
            variant="primary"
            fullWidth
            className="login-submit"
            disabled={carregando}
          >
            {carregando ? "Entrando..." : "Entrar"}
          </Button>
        </form>
      </div>
    </section>
  );
}
