import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import { AuthServicePort, TokenPayload } from '../../../core/ports/out';
import { DomainError } from '../../../core/domain/errors/DomainError';

export class JwtAuthService implements AuthServicePort {
  private readonly secret: string;
  private readonly expiresIn: string;

  constructor() {
    this.secret = process.env.JWT_SECRET || 'sge-dev-secret-change-in-prod';
    this.expiresIn = process.env.JWT_EXPIRES_IN || '8h';
  }

  async gerarHashSenha(senhaPura: string): Promise<string> {
    return bcrypt.hash(senhaPura, 10);
  }

  async compararSenha(senhaPura: string, senhaHash: string): Promise<boolean> {
    return bcrypt.compare(senhaPura, senhaHash);
  }

  gerarToken(payload: TokenPayload): string {
    return jwt.sign(payload, this.secret, {
      expiresIn: this.expiresIn as jwt.SignOptions['expiresIn'],
    });
  }

  verificarToken(token: string): TokenPayload {
    try {
      return jwt.verify(token, this.secret) as TokenPayload;
    } catch {
      throw new DomainError('Token inválido ou expirado.', 'UNAUTHORIZED');
    }
  }
}
