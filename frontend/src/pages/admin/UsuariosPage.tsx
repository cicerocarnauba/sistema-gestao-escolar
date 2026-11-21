export function UsuariosPage() {
  return (
    <section>
      <header className="page-header">
        <h1>Usuários</h1>
        <p>Cadastro e listagem de alunos e professores pelo Administrador.</p>
      </header>
      <div className="panel">
        <p>
          Módulo reservado para <span className="meta-code">RF03</span> e{' '}
          <span className="meta-code">RF06</span> (<span className="meta-code">POST /usuarios</span> ·{' '}
          <span className="meta-code">GET /usuarios</span>).
        </p>
      </div>
    </section>
  );
}
