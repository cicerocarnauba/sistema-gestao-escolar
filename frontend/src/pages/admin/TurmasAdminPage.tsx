export function TurmasAdminPage() {
  return (
    <section>
      <header className="page-header">
        <h1>Turmas</h1>
        <p>Criação e gerenciamento administrativo de turmas e disciplinas.</p>
      </header>
      <div className="panel">
        <p>
          Módulo reservado para <span className="meta-code">RF04</span> e{' '}
          <span className="meta-code">RF06</span> (<span className="meta-code">POST /turmas</span> ·{' '}
          <span className="meta-code">GET /turmas</span>).
        </p>
      </div>
    </section>
  );
}
