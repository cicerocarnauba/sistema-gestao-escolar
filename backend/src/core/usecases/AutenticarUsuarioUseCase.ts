import { DomainError } from '../domain/errors/DomainError';
import {
  AutenticarUsuarioInput,
  AutenticarUsuarioOutput,
  AutenticarUsuarioPort,
} from '../ports/in';
import { AuthServicePort, UsuarioRepoPort } from '../ports/out';

export class AutenticarUsuarioUseCase implements AutenticarUsuarioPort {
  constructor(
    private readonly usuarioRepo: UsuarioRepoPort,
    private readonly authService: AuthServicePort,
  ) {}

  async executar(input: AutenticarUsuarioInput): Promise<AutenticarUsuarioOutput> {
    const identificador = typeof input?.identificador === 'string' ? input.identificador.trim() : '';
    const senha = typeof input?.senha === 'string' ? input.senha : '';

    if (!identificador || !senha) {
      throw new DomainError('Informe e-mail ou matrícula e senha.', 'VALIDATION_ERROR');
    }

    const usuario = await this.usuarioRepo.buscarPorEmailOuMatricula(identificador);
    if (!usuario) {
      throw new DomainError('Credenciais inválidas.', 'UNAUTHORIZED');
    }

    const senhaValida = await this.authService.compararSenha(senha, usuario.senhaHash);
    if (!senhaValida) {
      throw new DomainError('Credenciais inválidas.', 'UNAUTHORIZED');
    }

    const token = this.authService.gerarToken({
      sub: usuario.id,
      email: usuario.email,
      perfil: usuario.perfil,
    });

    return {
      token,
      usuario: {
        id: usuario.id,
        nome: usuario.nome,
        email: usuario.email,
        matricula: usuario.matricula,
        perfil: usuario.perfil,
      },
    };
  }
}
