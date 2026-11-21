import { BrowserRouter, Navigate, Route, Routes } from 'react-router-dom';
import { AuthProvider } from './contexts/AuthContext';
import { ProtectedRoute } from './components/ProtectedRoute';
import { AppLayout } from './components/AppLayout';
import { LoginPage } from './pages/LoginPage';
import { UsuariosPage } from './pages/admin/UsuariosPage';
import { TurmasAdminPage } from './pages/admin/TurmasAdminPage';
import { MatriculasPage } from './pages/admin/MatriculasPage';
import { TurmasProfessorPage } from './pages/professor/TurmasProfessorPage';
import { NotasProfessorPage } from './pages/professor/NotasProfessorPage';
import { TurmasAlunoPage } from './pages/aluno/TurmasAlunoPage';
import { BoletimPage } from './pages/aluno/BoletimPage';

export function App() {
  return (
    <AuthProvider>
      <BrowserRouter>
        <Routes>
          <Route path="/login" element={<LoginPage />} />

          <Route element={<ProtectedRoute />}>
            <Route element={<AppLayout />}>
              {/* Rotas do Administrador */}
              <Route element={<ProtectedRoute perfisPermitidos={['ADMIN']} />}>
                <Route path="/admin/usuarios" element={<UsuariosPage />} />
                <Route path="/admin/turmas" element={<TurmasAdminPage />} />
                <Route path="/admin/matriculas" element={<MatriculasPage />} />
              </Route>

              {/* Rotas do Professor */}
              <Route element={<ProtectedRoute perfisPermitidos={['PROFESSOR']} />}>
                <Route path="/professor/turmas" element={<TurmasProfessorPage />} />
                <Route path="/professor/notas" element={<NotasProfessorPage />} />
              </Route>

              {/* Rotas do Aluno */}
              <Route element={<ProtectedRoute perfisPermitidos={['ALUNO']} />}>
                <Route path="/aluno/turmas" element={<TurmasAlunoPage />} />
                <Route path="/aluno/boletim" element={<BoletimPage />} />
              </Route>
            </Route>
          </Route>

          <Route path="*" element={<Navigate to="/login" replace />} />
        </Routes>
      </BrowserRouter>
    </AuthProvider>
  );
}
