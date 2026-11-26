import { DomainError } from '../domain/errors/DomainError';
import { ValidarTokenPort } from '../ports/in';
import { AuthServicePort, TokenPayload } from '../ports/out';

export class ValidarTokenUseCase implements ValidarTokenPort {
  constructor(private readonly authService: AuthServicePort) {}

  executar(token: string): TokenPayload {
    if (!token || !token.trim()) {
      throw new DomainError('Token de autenticação ausente.', 'UNAUTHORIZED');
    }
    return this.authService.verificarToken(token.trim());
  }
}
