import { DomainError } from '../errors/DomainError';

export type PerfilUsuario = 'ADMIN' | 'PROFESSOR' | 'ALUNO';

export interface UsuarioProps {
  id: string;
  nome: string;
  email: string;
  matricula: string;
  senhaHash: string;
  perfil: PerfilUsuario;
}

export class Usuario {
  public readonly id: string;
  public readonly nome: string;
  public readonly email: string;
  public readonly matricula: string;
  public readonly senhaHash: string;
  public readonly perfil: PerfilUsuario;

  constructor(props: UsuarioProps) {
    if (!props.nome.trim()) {
      throw new DomainError('O nome do usuário é obrigatório.');
    }
    if (!props.email.includes('@')) {
      throw new DomainError('E-mail inválido.');
    }
    if (!props.matricula.trim()) {
      throw new DomainError('A matrícula/documento é obrigatória.');
    }

    this.id = props.id;
    this.nome = props.nome.trim();
    this.email = props.email.trim().toLowerCase();
    this.matricula = props.matricula.trim();
    this.senhaHash = props.senhaHash;
    this.perfil = props.perfil;
  }
}

export class Aluno extends Usuario {
  constructor(props: Omit<UsuarioProps, 'perfil'>) {
    super({ ...props, perfil: 'ALUNO' });
  }
}

export class Professor extends Usuario {
  constructor(props: Omit<UsuarioProps, 'perfil'>) {
    super({ ...props, perfil: 'PROFESSOR' });
  }
}
