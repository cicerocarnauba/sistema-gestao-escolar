import { NextFunction, Request, Response } from 'express';
import { PerfilUsuario } from '../../../core/domain/entities/Usuario';
import { ValidarTokenPort } from '../../../core/ports/in';
import { TokenPayload } from '../../../core/ports/out';
import { DomainError } from '../../../core/domain/errors/DomainError';

declare global {
  namespace Express {
    interface Request {
      usuario?: TokenPayload;
    }
  }
}

/**
 * Middleware de autenticação Bearer JWT e controle de acesso por perfil (RF02).
 */
export function criarAuthMiddleware(validarToken: ValidarTokenPort) {
  return {
    autenticar(req: Request, _res: Response, next: NextFunction): void {
      const header = req.headers.authorization;
      if (!header || !header.startsWith('Bearer ')) {
        next(new DomainError('Token de autenticação ausente.', 'UNAUTHORIZED'));
        return;
      }
      const token = header.slice('Bearer '.length).trim();
      try {
        req.usuario = validarToken.executar(token);
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
