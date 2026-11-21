import fs from 'node:fs';
import path from 'node:path';
import Database from 'better-sqlite3';
import { Pool } from 'pg';

export interface SqlConnection {
  readonly driver: 'sqlite' | 'postgres';
  execSchema(sql: string): Promise<void>;
}

const SCHEMA_SQL = `
CREATE TABLE IF NOT EXISTS usuarios (
  id TEXT PRIMARY KEY,
  nome TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  matricula TEXT NOT NULL UNIQUE,
  senha_hash TEXT NOT NULL,
  perfil TEXT NOT NULL CHECK (perfil IN ('ADMIN', 'PROFESSOR', 'ALUNO'))
);

CREATE TABLE IF NOT EXISTS turmas (
  id TEXT PRIMARY KEY,
  codigo TEXT NOT NULL,
  disciplina TEXT NOT NULL,
  periodo_letivo TEXT NOT NULL,
  professor_id TEXT NOT NULL REFERENCES usuarios(id),
  UNIQUE (codigo, periodo_letivo)
);

CREATE TABLE IF NOT EXISTS matriculas (
  id TEXT PRIMARY KEY,
  aluno_id TEXT NOT NULL REFERENCES usuarios(id),
  turma_id TEXT NOT NULL REFERENCES turmas(id),
  ativa INTEGER NOT NULL DEFAULT 1,
  criada_em TEXT NOT NULL,
  UNIQUE (aluno_id, turma_id)
);

CREATE TABLE IF NOT EXISTS notas (
  id TEXT PRIMARY KEY,
  aluno_id TEXT NOT NULL REFERENCES usuarios(id),
  turma_id TEXT NOT NULL REFERENCES turmas(id),
  avaliacao TEXT NOT NULL,
  valor REAL NOT NULL CHECK (valor >= 0 AND valor <= 10)
);
`;

export class DatabaseClient {
  public readonly driver: 'sqlite' | 'postgres';
  public readonly sqlite?: Database.Database;
  public readonly pgPool?: Pool;

  constructor() {
    const client = (process.env.DB_CLIENT || 'sqlite').toLowerCase();

    if (client === 'postgres') {
      this.driver = 'postgres';
      this.pgPool = new Pool({
        connectionString: process.env.DATABASE_URL,
      });
    } else {
      this.driver = 'sqlite';
      const sqlitePath = process.env.SQLITE_PATH || './data/sge.sqlite';
      const resolvedPath = path.resolve(process.cwd(), sqlitePath);
      fs.mkdirSync(path.dirname(resolvedPath), { recursive: true });
      this.sqlite = new Database(resolvedPath);
      this.sqlite.pragma('foreign_keys = ON');
    }
  }

  public async initSchema(): Promise<void> {
    if (this.driver === 'postgres' && this.pgPool) {
      await this.pgPool.query(SCHEMA_SQL);
      return;
    }
    if (this.sqlite) {
      this.sqlite.exec(SCHEMA_SQL);
    }
  }
}
