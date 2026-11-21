import { DomainError } from '../errors/DomainError';

export interface MatriculaProps {
  id: string;
  alunoId: string;
  turmaId: string;
  ativa?: boolean;
  criadaEm?: Date;
}

export class Matricula {
  public readonly id: string;
  public readonly alunoId: string;
  public readonly turmaId: string;
  public readonly ativa: boolean;
  public readonly criadaEm: Date;

  constructor(props: MatriculaProps) {
    if (!props.alunoId.trim() || !props.turmaId.trim()) {
      throw new DomainError('Matrícula exige aluno e turma válidos.');
    }

    this.id = props.id;
    this.alunoId = props.alunoId;
    this.turmaId = props.turmaId;
    this.ativa = props.ativa ?? true;
    this.criadaEm = props.criadaEm ?? new Date();
  }
}
