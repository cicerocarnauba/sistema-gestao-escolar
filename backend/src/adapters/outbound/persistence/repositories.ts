import {
  MatriculaRepoPort,
  NotaRepoPort,
  TurmaRepoPort,
} from '../../../core/ports/out';
import { Turma } from '../../../core/domain/entities/Turma';
import { Matricula } from '../../../core/domain/entities/Matricula';
import { Nota } from '../../../core/domain/entities/Nota';
import { DomainError } from '../../../core/domain/errors/DomainError';
import { DatabaseClient } from './database';

export { SqlUsuarioRepository } from './SqlUsuarioRepository';

export class SqlTurmaRepository implements TurmaRepoPort {
  constructor(private readonly db: DatabaseClient) {}

  async salvar(_turma: Turma): Promise<void> {
    void this.db;
    throw new DomainError('SqlTurmaRepository.salvar pendente de implementação.', 'NOT_IMPLEMENTED');
  }

  async buscarPorId(_id: string): Promise<Turma | null> {
    void this.db;
    throw new DomainError('SqlTurmaRepository.buscarPorId pendente de implementação.', 'NOT_IMPLEMENTED');
  }

  async buscarPorCodigo(_codigo: string, _periodoLetivo: string): Promise<Turma | null> {
    void this.db;
    throw new DomainError('SqlTurmaRepository.buscarPorCodigo pendente de implementação.', 'NOT_IMPLEMENTED');
  }

  async listarTodas(): Promise<Turma[]> {
    void this.db;
    throw new DomainError('SqlTurmaRepository.listarTodas pendente de implementação.', 'NOT_IMPLEMENTED');
  }

  async listarPorProfessor(_professorId: string): Promise<Turma[]> {
    void this.db;
    throw new DomainError('SqlTurmaRepository.listarPorProfessor pendente de implementação.', 'NOT_IMPLEMENTED');
  }

  async listarPorAlunoMatriculado(_alunoId: string): Promise<Turma[]> {
    void this.db;
    throw new DomainError('SqlTurmaRepository.listarPorAlunoMatriculado pendente de implementação.', 'NOT_IMPLEMENTED');
  }
}

export class SqlMatriculaRepository implements MatriculaRepoPort {
  constructor(private readonly db: DatabaseClient) {}

  async salvar(_matricula: Matricula): Promise<void> {
    void this.db;
    throw new DomainError('SqlMatriculaRepository.salvar pendente de implementação.', 'NOT_IMPLEMENTED');
  }

  async buscarPorAlunoETurma(_alunoId: string, _turmaId: string): Promise<Matricula | null> {
    void this.db;
    throw new DomainError('SqlMatriculaRepository.buscarPorAlunoETurma pendente de implementação.', 'NOT_IMPLEMENTED');
  }

  async listarPorTurma(_turmaId: string): Promise<Matricula[]> {
    void this.db;
    throw new DomainError('SqlMatriculaRepository.listarPorTurma pendente de implementação.', 'NOT_IMPLEMENTED');
  }

  async listarPorAluno(_alunoId: string): Promise<Matricula[]> {
    void this.db;
    throw new DomainError('SqlMatriculaRepository.listarPorAluno pendente de implementação.', 'NOT_IMPLEMENTED');
  }
}

export class SqlNotaRepository implements NotaRepoPort {
  constructor(private readonly db: DatabaseClient) {}

  async salvar(_nota: Nota): Promise<void> {
    void this.db;
    throw new DomainError('SqlNotaRepository.salvar pendente de implementação.', 'NOT_IMPLEMENTED');
  }

  async atualizar(_nota: Nota): Promise<void> {
    void this.db;
    throw new DomainError('SqlNotaRepository.atualizar pendente de implementação.', 'NOT_IMPLEMENTED');
  }

  async buscarPorId(_id: string): Promise<Nota | null> {
    void this.db;
    throw new DomainError('SqlNotaRepository.buscarPorId pendente de implementação.', 'NOT_IMPLEMENTED');
  }

  async listarPorAlunoETurma(_alunoId: string, _turmaId: string): Promise<Nota[]> {
    void this.db;
    throw new DomainError('SqlNotaRepository.listarPorAlunoETurma pendente de implementação.', 'NOT_IMPLEMENTED');
  }

  async listarPorTurma(_turmaId: string): Promise<Nota[]> {
    void this.db;
    throw new DomainError('SqlNotaRepository.listarPorTurma pendente de implementação.', 'NOT_IMPLEMENTED');
  }
}
