import { NextFunction, Request, Response } from 'express';
import { DomainError, DomainErrorCode } from '../../../core/domain/errors/DomainError';

const HTTP_STATUS_BY_CODE: Record<DomainErrorCode, number> = {
  VALIDATION_ERROR: 400,
  UNAUTHORIZED: 401,
  FORBIDDEN: 403,
  NOT_FOUND: 404,
  CONFLICT: 409,
  NOT_IMPLEMENTED: 501,
};

export function errorHandler(
  err: unknown,
  _req: Request,
  res: Response,
  _next: NextFunction,
): void {
  if (err instanceof DomainError) {
    const status = HTTP_STATUS_BY_CODE[err.code] ?? 400;
    res.status(status).json({
      erro: err.code,
      mensagem: err.message,
    });
    return;
  }

  console.error('[API Error]', err);
  res.status(500).json({
    erro: 'INTERNAL_SERVER_ERROR',
    mensagem: 'Erro interno inesperado no servidor.',
  });
}
