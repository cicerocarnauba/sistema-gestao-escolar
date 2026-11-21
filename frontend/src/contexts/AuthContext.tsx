import React, { createContext, useContext, useMemo, useState } from 'react';
import { PerfilUsuario, UsuarioAutenticado } from '../types';
import { removerToken, salvarToken } from '../services/api';

const USER_STORAGE_KEY = 'sge_usuario';

interface AuthContextValue {
  usuario: UsuarioAutenticado | null;
  autenticado: boolean;
  registrarSessao: (token: string, usuario: UsuarioAutenticado) => void;
  encerrarSessao: () => void;
  rotaInicialPorPerfil: (perfil: PerfilUsuario) => string;
}

const AuthContext = createContext<AuthContextValue | undefined>(undefined);

export function rotaInicialPorPerfil(perfil: PerfilUsuario): string {
  switch (perfil) {
    case 'ADMIN':
      return '/admin/turmas';
    case 'PROFESSOR':
      return '/professor/turmas';
    case 'ALUNO':
      return '/aluno/boletim';
  }
}

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [usuario, setUsuario] = useState<UsuarioAutenticado | null>(() => {
    const salvo = localStorage.getItem(USER_STORAGE_KEY);
    if (!salvo) return null;
    try {
      return JSON.parse(salvo) as UsuarioAutenticado;
    } catch {
      return null;
    }
  });

  const valor = useMemo<AuthContextValue>(
    () => ({
      usuario,
      autenticado: Boolean(usuario),
      registrarSessao(token: string, novoUsuario: UsuarioAutenticado) {
        salvarToken(token);
        localStorage.setItem(USER_STORAGE_KEY, JSON.stringify(novoUsuario));
        setUsuario(novoUsuario);
      },
      encerrarSessao() {
        removerToken();
        localStorage.removeItem(USER_STORAGE_KEY);
        setUsuario(null);
      },
      rotaInicialPorPerfil,
    }),
    [usuario],
  );

  return <AuthContext.Provider value={valor}>{children}</AuthContext.Provider>;
}

export function useAuth(): AuthContextValue {
  const ctx = useContext(AuthContext);
  if (!ctx) {
    throw new Error('useAuth deve ser utilizado dentro de um AuthProvider.');
  }
  return ctx;
}
