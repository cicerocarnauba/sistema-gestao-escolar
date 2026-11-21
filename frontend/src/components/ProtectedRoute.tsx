import { Navigate, Outlet } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';
import { PerfilUsuario } from '../types';

interface ProtectedRouteProps {
  perfisPermitidos?: PerfilUsuario[];
}

export function ProtectedRoute({ perfisPermitidos }: ProtectedRouteProps) {
  const { usuario, autenticado, rotaInicialPorPerfil } = useAuth();

  if (!autenticado || !usuario) {
    return <Navigate to="/login" replace />;
  }

  if (perfisPermitidos && !perfisPermitidos.includes(usuario.perfil)) {
    return <Navigate to={rotaInicialPorPerfil(usuario.perfil)} replace />;
  }

  return <Outlet />;
}
