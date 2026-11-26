import { NextFunction, Request, Response } from 'express';
import { AutenticarUsuarioPort } from '../../../core/ports/in';
import { DomainError } from '../../../core/domain/errors/DomainError';

export interface LoginRequestDTO {
  identificador: string;
  senha: string;
}

export class AuthController {
  constructor(private readonly autenticarUsuario: AutenticarUsuarioPort) {}

  public login = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
      const body = req.body as Partial<LoginRequestDTO> | undefined;
      if (!body || typeof body.identificador !== 'string' || typeof body.senha !== 'string') {
        throw new DomainError('Informe identificador (e-mail ou matrícula) e senha.', 'VALIDATION_ERROR');
      }

      const resultado = await this.autenticarUsuario.executar({
        identificador: body.identificador,
        senha: body.senha,
      });

      res.status(200).json(resultado);
    } catch (err) {
      next(err);
    }
  };
}
