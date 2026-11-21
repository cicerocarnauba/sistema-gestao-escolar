export function NotasProfessorPage() {
  return (
    <section>
      <header className="page-header">
        <h1>Lançar e Editar Notas</h1>
        <p>Registro de avaliações dos alunos matriculados nas turmas do professor.</p>
      </header>
      <div className="panel">
        <p>
          Módulo reservado para <span className="meta-code">RF08</span> (
          <span className="meta-code">POST /notas</span> ·{' '}
          <span className="meta-code">PUT /notas/:id</span>).
        </p>
      </div>
    </section>
  );
}
