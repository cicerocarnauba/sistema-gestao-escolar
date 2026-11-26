import { Navigate } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';
import { LoginForm } from '../components/auth/LoginForm';
import { LoginHero } from '../components/auth/LoginHero';

export function LoginPage() {
  const { autenticado, usuario, rotaInicialPorPerfil } = useAuth();

  if (autenticado && usuario) {
    return <Navigate to={rotaInicialPorPerfil(usuario.perfil)} replace />;
  }

  return (
    <div className="login-split">
      <LoginHero />
      <LoginForm />
    </div>
  );
}
