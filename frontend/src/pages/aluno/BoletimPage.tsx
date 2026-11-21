export function BoletimPage() {
  return (
    <section>
      <header className="page-header">
        <h1>Boletim Acadêmico</h1>
        <p>Notas lançadas, média calculada e situação por disciplina.</p>
      </header>
      <div className="panel">
        <p>
          Módulo reservado para <span className="meta-code">RF10</span> (
          <span className="meta-code">GET /boletim</span>).
        </p>
      </div>
    </section>
  );
}
