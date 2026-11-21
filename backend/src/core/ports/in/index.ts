import { PerfilUsuario } from '../../domain/entities/Usuario';
import { SituacaoAcademica } from '../../domain/entities/Nota';

// RF01 — Autenticação de Usuário
export interface AutenticarUsuarioInput {
  identificador: string; // e-mail ou matrícula
  senha: string;
}

export interface AutenticarUsuarioOutput {
  token: string;
  usuario: {
    id: string;
    nome: string;
    email: string;
    matricula: string;
    perfil: PerfilUsuario;
  };
}

export interface AutenticarUsuarioPort {
  executar(input: AutenticarUsuarioInput): Promise<AutenticarUsuarioOutput>;
}

// RF03 & RF06 — Cadastro e Listagem de Usuários
export interface CadastrarUsuarioInput {
  nome: string;
  email: string;
  matricula: string;
  senha: string;
  perfil: PerfilUsuario;
}

export interface UsuarioResumoOutput {
  id: string;
  nome: string;
  email: string;
  matricula: string;
  perfil: PerfilUsuario;
}

export interface CadastrarUsuarioPort {
  executar(input: CadastrarUsuarioInput): Promise<UsuarioResumoOutput>;
}

export interface ListarUsuariosPort {
  executar(filtroPerfil?: PerfilUsuario): Promise<UsuarioResumoOutput[]>;
}

// RF04, RF06, RF07, RF09 — Criação e Consulta de Turmas
export interface CriarTurmaInput {
  codigo: string;
  disciplina: string;
  periodoLetivo: string;
  professorId: string;
}

export interface TurmaResumoOutput {
  id: string;
  codigo: string;
  disciplina: string;
  periodoLetivo: string;
  professorId: string;
  professorNome?: string;
}

export interface CriarTurmaPort {
  executar(input: CriarTurmaInput): Promise<TurmaResumoOutput>;
}

export interface ConsultarTurmasFiltro {
  solicitanteId: string;
  perfil: PerfilUsuario;
}

export interface ConsultarTurmasPort {
  executar(filtro: ConsultarTurmasFiltro): Promise<TurmaResumoOutput[]>;
}

// RF05 — Matricular Aluno em Turma
export interface MatricularAlunoInput {
  alunoId: string;
  turmaId: string;
}

export interface MatriculaOutput {
  id: string;
  alunoId: string;
  turmaId: string;
  ativa: boolean;
}

export interface MatricularAlunoPort {
  executar(input: MatricularAlunoInput): Promise<MatriculaOutput>;
}

// RF08 — Lançar e Editar Notas
export interface LancarNotaInput {
  notaId?: string;
  professorAutenticadoId: string;
  turmaId: string;
  alunoId: string;
  avaliacao: string;
  valor: number;
}

export interface NotaOutput {
  id: string;
  turmaId: string;
  alunoId: string;
  avaliacao: string;
  valor: number;
}

export interface LancarNotaPort {
  executar(input: LancarNotaInput): Promise<NotaOutput>;
}

// RF10 — Visualizar Boletim Acadêmico
export interface ItemBoletimOutput {
  turmaId: string;
  codigoTurma: string;
  disciplina: string;
  periodoLetivo: string;
  notas: Array<{ id: string; avaliacao: string; valor: number }>;
  media: number | null;
  situacao: SituacaoAcademica;
}

export interface ConsultarBoletimPort {
  executar(alunoId: string): Promise<ItemBoletimOutput[]>;
}
