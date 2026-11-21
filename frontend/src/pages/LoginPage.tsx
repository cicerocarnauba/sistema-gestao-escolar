import { FormEvent, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { requisicaoApi } from '../services/api';
import { useAuth } from '../contexts/AuthContext';
import { RespostaLogin } from '../types';

export function LoginPage() {
  const [identificador, setIdentificador] = useState('');
  const [senha, setSenha] = useState('');
  const [erro, setErro] = useState<string | null>(null);
  const { registrarSessao, rotaInicialPorPerfil } = useAuth();
  const navigate = useNavigate();

  async function handleSubmit(e: FormEvent) {
    e.preventDefault();
    setErro(null);

    try {
      const resposta = await requisicaoApi<RespostaLogin>('/auth/login', {
        method: 'POST',
        body: JSON.stringify({ identificador, senha }),
      });
      registrarSessao(resposta.token, resposta.usuario);
      navigate(rotaInicialPorPerfil(resposta.usuario.perfil));
    } catch (err) {
      setErro(err instanceof Error ? err.message : 'Erro ao realizar login.');
    }
  }

  return (
    <div className="login-wrapper">
      <div className="login-box">
        <h1>Sistema de Gestão Escolar</h1>
        <p>Acesse com seu e-mail ou matrícula institucional.</p>

        {erro && <div className="error-banner">{erro}</div>}

        <form onSubmit={handleSubmit}>
          <div className="form-field">
            <label htmlFor="identificador">E-mail ou Matrícula</label>
            <input
              id="identificador"
              type="text"
              value={identificador}
              onChange={(e) => setIdentificador(e.target.value)}
              required
            />
          </div>

          <div className="form-field">
            <label htmlFor="senha">Senha</label>
            <input
              id="senha"
              type="password"
              value={senha}
              onChange={(e) => setSenha(e.target.value)}
              required
            />
          </div>

          <button type="submit" className="btn-primary">
            Entrar
          </button>
        </form>
      </div>
    </div>
  );
}
