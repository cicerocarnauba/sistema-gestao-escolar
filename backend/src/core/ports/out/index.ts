import { PerfilUsuario, Usuario } from '../../domain/entities/Usuario';
import { Turma } from '../../domain/entities/Turma';
import { Matricula } from '../../domain/entities/Matricula';
import { Nota } from '../../domain/entities/Nota';

export interface TokenPayload {
  sub: string;
  email: string;
  perfil: PerfilUsuario;
}

export interface AuthServicePort {
  gerarHashSenha(senhaPura: string): Promise<string>;
  compararSenha(senhaPura: string, senhaHash: string): Promise<boolean>;
  gerarToken(payload: TokenPayload): string;
  verificarToken(token: string): TokenPayload;
}

export interface UsuarioRepoPort {
  salvar(usuario: Usuario): Promise<void>;
  buscarPorId(id: string): Promise<Usuario | null>;
  buscarPorEmailOuMatricula(identificador: string): Promise<Usuario | null>;
  listar(perfil?: PerfilUsuario): Promise<Usuario[]>;
}

export interface TurmaRepoPort {
  salvar(turma: Turma): Promise<void>;
  buscarPorId(id: string): Promise<Turma | null>;
  buscarPorCodigo(codigo: string, periodoLetivo: string): Promise<Turma | null>;
  listarTodas(): Promise<Turma[]>;
  listarPorProfessor(professorId: string): Promise<Turma[]>;
  listarPorAlunoMatriculado(alunoId: string): Promise<Turma[]>;
}

export interface MatriculaRepoPort {
  salvar(matricula: Matricula): Promise<void>;
  buscarPorAlunoETurma(alunoId: string, turmaId: string): Promise<Matricula | null>;
  listarPorTurma(turmaId: string): Promise<Matricula[]>;
  listarPorAluno(alunoId: string): Promise<Matricula[]>;
}

export interface NotaRepoPort {
  salvar(nota: Nota): Promise<void>;
  atualizar(nota: Nota): Promise<void>;
  buscarPorId(id: string): Promise<Nota | null>;
  listarPorAlunoETurma(alunoId: string, turmaId: string): Promise<Nota[]>;
  listarPorTurma(turmaId: string): Promise<Nota[]>;
}
