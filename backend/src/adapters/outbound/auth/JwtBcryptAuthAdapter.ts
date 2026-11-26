import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import { AuthServicePort, TokenPayload } from '../../../core/ports/out';
import { DomainError } from '../../../core/domain/errors/DomainError';

export class JwtBcryptAuthAdapter implements AuthServicePort {
  private readonly jwtSecret: string;
  private readonly jwtExpiresIn: string;
  private readonly saltRounds: number;

  constructor(saltRounds = 10) {
    this.jwtSecret = process.env.JWT_SECRET || 'sge-dev-secret-change-in-prod';
    this.jwtExpiresIn = process.env.JWT_EXPIRES_IN || '8h';
    this.saltRounds = saltRounds;
  }

  async gerarHashSenha(senhaPura: string): Promise<string> {
    return bcrypt.hash(senhaPura, this.saltRounds);
  }

  async compararSenha(senhaPura: string, senhaHash: string): Promise<boolean> {
    return bcrypt.compare(senhaPura, senhaHash);
  }

  gerarToken(payload: TokenPayload): string {
    return jwt.sign(payload, this.jwtSecret, {
      expiresIn: this.jwtExpiresIn as jwt.SignOptions['expiresIn'],
    });
  }

  verificarToken(token: string): TokenPayload {
    try {
      return jwt.verify(token, this.jwtSecret) as TokenPayload;
    } catch {
      throw new DomainError('Token inválido ou expirado.', 'UNAUTHORIZED');
    }
  }
}
