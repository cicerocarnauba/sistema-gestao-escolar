import { DomainError } from '../errors/DomainError';

export type SituacaoAcademica = 'APROVADO' | 'REPROVADO' | 'EM_ANDAMENTO';

export interface NotaProps {
  id: string;
  alunoId: string;
  turmaId: string;
  avaliacao: string;
  valor: number;
}

export class Nota {
  public readonly id: string;
  public readonly alunoId: string;
  public readonly turmaId: string;
  public readonly avaliacao: string;
  private _valor: number;

  constructor(props: NotaProps) {
    Nota.validarValor(props.valor);
    if (!props.avaliacao.trim()) {
      throw new DomainError('A descrição da avaliação é obrigatória.');
    }

    this.id = props.id;
    this.alunoId = props.alunoId;
    this.turmaId = props.turmaId;
    this.avaliacao = props.avaliacao.trim();
    this._valor = props.valor;
  }

  public get valor(): number {
    return this._valor;
  }

  public atualizarValor(novoValor: number): void {
    Nota.validarValor(novoValor);
    this._valor = novoValor;
  }

  /**
   * [RN01] Intervalo Válido de Notas: deve estar entre 0,0 e 10,0.
   */
  public static validarValor(valor: number): void {
    if (Number.isNaN(valor) || valor < 0 || valor > 10) {
      throw new DomainError('A nota deve estar entre 0,0 e 10,0 (RN01).', 'VALIDATION_ERROR');
    }
  }

  /**
   * [RN05] Cálculo de Situação no Boletim:
   * - Sem notas lançadas -> EM_ANDAMENTO
   * - Média >= 7,0 -> APROVADO
   * - Média < 7,0 -> REPROVADO
   */
  public static calcularBoletim(valores: number[]): { media: number | null; situacao: SituacaoAcademica } {
    if (valores.length === 0) {
      return { media: null, situacao: 'EM_ANDAMENTO' };
    }
    const soma = valores.reduce((acc, v) => acc + v, 0);
    const media = Number((soma / valores.length).toFixed(2));
    return {
      media,
      situacao: media >= 7.0 ? 'APROVADO' : 'REPROVADO',
    };
  }
}
