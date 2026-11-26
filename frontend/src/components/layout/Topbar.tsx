import { NavLink, useNavigate } from 'react-router-dom';
import { useAuth } from '../../contexts/AuthContext';
import { PerfilUsuario } from '../../types';
import { BrandMark } from '../ui/BrandMark';
import { Button } from '../ui/Button';

interface ItemMenu {
  rotulo: string;
  caminho: string;
  perfis: PerfilUsuario[];
}

const ITENS_MENU: ItemMenu[] = [
  { rotulo: 'Usuários', caminho: '/admin/usuarios', perfis: ['ADMIN'] },
  { rotulo: 'Turmas', caminho: '/admin/turmas', perfis: ['ADMIN'] },
  { rotulo: 'Matrículas', caminho: '/admin/matriculas', perfis: ['ADMIN'] },
  { rotulo: 'Minhas Turmas', caminho: '/professor/turmas', perfis: ['PROFESSOR'] },
  { rotulo: 'Lançar Notas', caminho: '/professor/notas', perfis: ['PROFESSOR'] },
  { rotulo: 'Minhas Turmas', caminho: '/aluno/turmas', perfis: ['ALUNO'] },
  { rotulo: 'Boletim', caminho: '/aluno/boletim', perfis: ['ALUNO'] },
];

export function Topbar() {
  const { usuario, encerrarSessao } = useAuth();
  const navigate = useNavigate();

  const itensVisiveis = ITENS_MENU.filter(
    (item) => usuario && item.perfis.includes(usuario.perfil),
  );

  function handleLogout() {
    encerrarSessao();
    navigate('/login');
  }

  return (
    <header className="topbar">
      <div className="topbar-inner">
        <div className="topbar-left">
          <BrandMark label="Gestão Escolar" size="sm" />

          <nav className="topbar-nav" aria-label="Navegação principal">
            {itensVisiveis.map((item) => (
              <NavLink
                key={item.caminho}
                to={item.caminho}
                className={({ isActive }) =>
                  isActive ? 'nav-link nav-link-active' : 'nav-link'
                }
              >
                {item.rotulo}
              </NavLink>
            ))}
          </nav>
        </div>

        {usuario && (
          <div className="topbar-user">
            <span className="user-name">{usuario.nome}</span>
            <Button
              type="button"
              variant="ghost"
              icon="logout"
              onClick={handleLogout}
            >
              Sair
            </Button>
          </div>
        )}
      </div>
    </header>
  );
}
