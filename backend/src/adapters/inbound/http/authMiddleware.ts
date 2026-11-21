import { NextFunction, Request, Response } from 'express';
import { PerfilUsuario } from '../../../core/domain/entities/Usuario';
import { AuthServicePort, TokenPayload } from '../../../core/ports/out';
import { DomainError } from '../../../core/domain/errors/DomainError';

declare global {
  namespace Express {
    interface Request {
      usuario?: TokenPayload;
    }
  }
}

/**
 * Base para RF02 (Autorização por perfil / RBAC — Issue #23).
 * Decodifica o token Bearer e valida os papéis permitidos na rota.
 */
export function criarAuthMiddleware(authService: AuthServicePort) {
  return {
    autenticar(req: Request, _res: Response, next: NextFunction): void {
      const header = req.headers.authorization;
      if (!header || !header.startsWith('Bearer ')) {
        next(new DomainError('Token de autenticação ausente.', 'UNAUTHORIZED'));
        return;
      }
      const token = header.slice('Bearer '.length).trim();
      try {
        req.usuario = authService.verificarToken(token);
        next();
      } catch (err) {
        next(err);
      }
    },

    exigirPerfis(...perfisPermitidos: PerfilUsuario[]) {
      return (req: Request, _res: Response, next: NextFunction): void => {
        if (!req.usuario) {
          next(new DomainError('Usuário não autenticado.', 'UNAUTHORIZED'));
          return;
        }
        if (!perfisPermitidos.includes(req.usuario.perfil)) {
          next(new DomainError('Acesso negado para o perfil atual (RF02).', 'FORBIDDEN'));
          return;
        }
        next();
      };
    },
  };
}
