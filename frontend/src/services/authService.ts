import { RespostaLogin } from '../types';
import { requisicaoApi } from './api';

export interface LoginCredenciais {
  identificador: string;
  senha: string;
}

export function autenticarUsuario(credenciais: LoginCredenciais): Promise<RespostaLogin> {
  return requisicaoApi<RespostaLogin>('/auth/login', {
    method: 'POST',
    body: JSON.stringify(credenciais),
  });
}
