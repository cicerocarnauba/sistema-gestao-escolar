const API_BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:3333';
const TOKEN_STORAGE_KEY = 'sge_token';

export class ApiError extends Error {
  public readonly status: number;
  public readonly codigo: string;

  constructor(status: number, codigo: string, mensagem: string) {
    super(mensagem);
    this.name = 'ApiError';
    this.status = status;
    this.codigo = codigo;
  }
}

export function obterTokenSalvo(): string | null {
  return localStorage.getItem(TOKEN_STORAGE_KEY);
}

export function salvarToken(token: string): void {
  localStorage.setItem(TOKEN_STORAGE_KEY, token);
}

export function removerToken(): void {
  localStorage.removeItem(TOKEN_STORAGE_KEY);
}

export async function requisicaoApi<T>(
  caminho: string,
  opcoes: RequestInit = {},
): Promise<T> {
  const token = obterTokenSalvo();
  const headers = new Headers(opcoes.headers);

  if (!headers.has('Content-Type') && opcoes.body) {
    headers.set('Content-Type', 'application/json');
  }
  if (token) {
    headers.set('Authorization', `Bearer ${token}`);
  }

  const resposta = await fetch(`${API_BASE_URL}${caminho}`, {
    ...opcoes,
    headers,
  });

  const dados = await resposta.json().catch(() => ({}));

  if (!resposta.ok) {
    throw new ApiError(
      resposta.status,
      dados.erro || 'HTTP_ERROR',
      dados.mensagem || 'Falha ao comunicar com a API.',
    );
  }

  return dados as T;
}
