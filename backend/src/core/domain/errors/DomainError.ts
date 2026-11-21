export type DomainErrorCode =
  | 'VALIDATION_ERROR'
  | 'UNAUTHORIZED'
  | 'FORBIDDEN'
  | 'NOT_FOUND'
  | 'CONFLICT'
  | 'NOT_IMPLEMENTED';

export class DomainError extends Error {
  public readonly code: DomainErrorCode;

  constructor(message: string, code: DomainErrorCode = 'VALIDATION_ERROR') {
    super(message);
    this.name = 'DomainError';
    this.code = code;
  }
}
