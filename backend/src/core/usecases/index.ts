import { DomainError } from '../domain/errors/DomainError';
import {
  CadastrarUsuarioInput,
  CadastrarUsuarioPort,
  ConsultarBoletimPort,
  ConsultarTurmasFiltro,
  ConsultarTurmasPort,
  CriarTurmaInput,
  CriarTurmaPort,
  ItemBoletimOutput,
  LancarNotaInput,
  LancarNotaPort,
  ListarUsuariosPort,
  MatriculaOutput,
  MatricularAlunoInput,
  MatricularAlunoPort,
  NotaOutput,
  TurmaResumoOutput,
  UsuarioResumoOutput,
} from '../ports/in';
import {
  AuthServicePort,
  MatriculaRepoPort,
  NotaRepoPort,
  TurmaRepoPort,
  UsuarioRepoPort,
} from '../ports/out';
import { PerfilUsuario } from '../domain/entities/Usuario';

export { AutenticarUsuarioUseCase } from './AutenticarUsuarioUseCase';
export { ValidarTokenUseCase } from './ValidarTokenUseCase';

export class CadastrarUsuarioUseCase implements CadastrarUsuarioPort {
  constructor(
    private readonly usuarioRepo: UsuarioRepoPort,
    private readonly authService: AuthServicePort,
  ) {}

  async executar(_input: CadastrarUsuarioInput): Promise<UsuarioResumoOutput> {
    void this.usuarioRepo;
    void this.authService;
    throw new DomainError('RF03 (CadastrarUsuarioUseCase) pendente de implementação (#15).', 'NOT_IMPLEMENTED');
  }
}

export class ListarUsuariosUseCase implements ListarUsuariosPort {
  constructor(private readonly usuarioRepo: UsuarioRepoPort) {}

  async executar(_filtroPerfil?: PerfilUsuario): Promise<UsuarioResumoOutput[]> {
    void this.usuarioRepo;
    throw new DomainError('RF06 (ListarUsuariosUseCase) pendente de implementação (#24).', 'NOT_IMPLEMENTED');
  }
}

export class CriarTurmaUseCase implements CriarTurmaPort {
  constructor(
    private readonly turmaRepo: TurmaRepoPort,
    private readonly usuarioRepo: UsuarioRepoPort,
  ) {}

  async executar(_input: CriarTurmaInput): Promise<TurmaResumoOutput> {
    void this.turmaRepo;
    void this.usuarioRepo;
    throw new DomainError('RF04 (CriarTurmaUseCase) pendente de implementação (#16).', 'NOT_IMPLEMENTED');
  }
}

export class ConsultarTurmasUseCase implements ConsultarTurmasPort {
  constructor(private readonly turmaRepo: TurmaRepoPort) {}

  async executar(_filtro: ConsultarTurmasFiltro): Promise<TurmaResumoOutput[]> {
    void this.turmaRepo;
    throw new DomainError('RF06/RF07/RF09 (ConsultarTurmasUseCase) pendente de implementação (#24/#25/#26).', 'NOT_IMPLEMENTED');
  }
}

export class MatricularAlunoUseCase implements MatricularAlunoPort {
  constructor(
    private readonly matriculaRepo: MatriculaRepoPort,
    private readonly turmaRepo: TurmaRepoPort,
    private readonly usuarioRepo: UsuarioRepoPort,
  ) {}

  async executar(_input: MatricularAlunoInput): Promise<MatriculaOutput> {
    void this.matriculaRepo;
    void this.turmaRepo;
    void this.usuarioRepo;
    throw new DomainError('RF05 (MatricularAlunoUseCase) pendente de implementação (#17).', 'NOT_IMPLEMENTED');
  }
}

export class LancarNotaUseCase implements LancarNotaPort {
  constructor(
    private readonly notaRepo: NotaRepoPort,
    private readonly turmaRepo: TurmaRepoPort,
    private readonly matriculaRepo: MatriculaRepoPort,
  ) {}

  async executar(_input: LancarNotaInput): Promise<NotaOutput> {
    void this.notaRepo;
    void this.turmaRepo;
    void this.matriculaRepo;
    throw new DomainError('RF08 (LancarNotaUseCase) pendente de implementação (#18).', 'NOT_IMPLEMENTED');
  }
}

export class ConsultarBoletimUseCase implements ConsultarBoletimPort {
  constructor(
    private readonly matriculaRepo: MatriculaRepoPort,
    private readonly turmaRepo: TurmaRepoPort,
    private readonly notaRepo: NotaRepoPort,
  ) {}

  async executar(_alunoId: string): Promise<ItemBoletimOutput[]> {
    void this.matriculaRepo;
    void this.turmaRepo;
    void this.notaRepo;
    throw new DomainError('RF10 (ConsultarBoletimUseCase) pendente de implementação (#19).', 'NOT_IMPLEMENTED');
  }
}
