import { Outlet } from 'react-router-dom';
import { Topbar } from './layout/Topbar';

export function AppLayout() {
  return (
    <div className="portal-shell">
      <Topbar />
      <main className="main-container">
        <Outlet />
      </main>
    </div>
  );
}
