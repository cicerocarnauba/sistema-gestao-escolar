export type PerfilUsuario = 'ADMIN' | 'PROFESSOR' | 'ALUNO';

export type SituacaoAcademica = 'APROVADO' | 'REPROVADO' | 'EM_ANDAMENTO';

export interface UsuarioAutenticado {
  id: string;
  nome: string;
  email: string;
  matricula: string;
  perfil: PerfilUsuario;
}

export interface RespostaLogin {
  token: string;
  usuario: UsuarioAutenticado;
}
