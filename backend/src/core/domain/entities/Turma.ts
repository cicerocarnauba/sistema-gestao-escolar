import { DomainError } from '../errors/DomainError';

export interface TurmaProps {
  id: string;
  codigo: string;
  disciplina: string;
  periodoLetivo: string;
  professorId: string;
}

export class Turma {
  public readonly id: string;
  public readonly codigo: string;
  public readonly disciplina: string;
  public readonly periodoLetivo: string;
  public readonly professorId: string;

  constructor(props: TurmaProps) {
    if (!props.codigo.trim()) {
      throw new DomainError('O código da turma é obrigatório.');
    }
    if (!props.disciplina.trim()) {
      throw new DomainError('O nome da disciplina é obrigatório.');
    }
    if (!props.periodoLetivo.trim()) {
      throw new DomainError('O período letivo é obrigatório.');
    }
    if (!props.professorId.trim()) {
      throw new DomainError('Toda turma deve possuir um professor titular vinculado.');
    }

    this.id = props.id;
    this.codigo = props.codigo.trim().toUpperCase();
    this.disciplina = props.disciplina.trim();
    this.periodoLetivo = props.periodoLetivo.trim();
    this.professorId = props.professorId;
  }

  /**
   * [RN02] Vínculo Obrigatório do Professor:
   * Apenas o professor titular da turma pode lançar ou editar notas nela.
   */
  public pertenceAoProfessor(professorId: string): boolean {
    return this.professorId === professorId;
  }
}
