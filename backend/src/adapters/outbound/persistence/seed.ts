import crypto from 'node:crypto';
import { PerfilUsuario, Usuario } from '../../../core/domain/entities/Usuario';
import { AuthServicePort, UsuarioRepoPort } from '../../../core/ports/out';

interface SeedUser {
  nome: string;
  email: string;
  matricula: string;
  senha: string;
  perfil: PerfilUsuario;
}

const USUARIOS_INICIAIS_DEV: SeedUser[] = [
  {
    nome: 'Administrador SGE',
    email: 'admin@email.com',
    matricula: 'ADM001',
    senha: 'adminadmin',
    perfil: 'ADMIN',
  },
  {
    nome: 'Prof. Carlos Mendes',
    email: 'professor@escola.edu.br',
    matricula: 'PROF001',
    senha: '123456',
    perfil: 'PROFESSOR',
  },
  {
    nome: 'Ana Beatriz Silva',
    email: 'aluno@escola.edu.br',
    matricula: '2026001',
    senha: '123456',
    perfil: 'ALUNO',
  },
];

/**
 * Popula usuários iniciais de desenvolvimento de forma idempotente:
 * apenas insere registros ausentes e nunca altera credenciais existentes.
 */
export async function garantirUsuariosIniciaisDev(
  usuarioRepo: UsuarioRepoPort,
  authService: AuthServicePort,
): Promise<void> {
  if (process.env.SEED_DEV_USERS === 'false') {
    return;
  }

  for (const item of USUARIOS_INICIAIS_DEV) {
    const existente = await usuarioRepo.buscarPorEmailOuMatricula(item.email);
    if (existente) {
      continue;
    }

    const senhaHash = await authService.gerarHashSenha(item.senha);
    const novoUsuario = new Usuario({
      id: crypto.randomUUID(),
      nome: item.nome,
      email: item.email,
      matricula: item.matricula,
      senhaHash,
      perfil: item.perfil,
    });
    await usuarioRepo.salvar(novoUsuario);
  }
}
