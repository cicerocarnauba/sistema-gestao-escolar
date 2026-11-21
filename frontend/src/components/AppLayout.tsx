import { NavLink, Outlet, useNavigate } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';
import { PerfilUsuario } from '../types';

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
  { rotulo: 'Turmas Matriculadas', caminho: '/aluno/turmas', perfis: ['ALUNO'] },
  { rotulo: 'Boletim Acadêmico', caminho: '/aluno/boletim', perfis: ['ALUNO'] },
];

export function AppLayout() {
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
    <div className="app-shell">
      <aside className="sidebar">
        <div className="sidebar-brand">
          <span className="brand-code">SGE</span>
          <span className="brand-name">Gestão Escolar</span>
        </div>

        <nav className="sidebar-nav" aria-label="Menu do perfil">
          {itensVisiveis.map((item) => (
            <NavLink
              key={item.caminho}
              to={item.caminho}
              className={({ isActive }) =>
                isActive ? 'nav-item nav-item-active' : 'nav-item'
              }
            >
              {item.rotulo}
            </NavLink>
          ))}
        </nav>

        {usuario && (
          <div className="sidebar-footer">
            <div className="user-meta">
              <strong>{usuario.nome}</strong>
              <span className="badge-role">{usuario.perfil}</span>
            </div>
            <button type="button" className="btn-secondary" onClick={handleLogout}>
              Sair
            </button>
          </div>
        )}
      </aside>

      <main className="main-area">
        <Outlet />
      </main>
    </div>
  );
}
