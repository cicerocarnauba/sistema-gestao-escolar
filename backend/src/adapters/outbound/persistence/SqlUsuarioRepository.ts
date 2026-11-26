import { UsuarioRepoPort } from '../../../core/ports/out';
import { PerfilUsuario, Usuario } from '../../../core/domain/entities/Usuario';
import { DomainError } from '../../../core/domain/errors/DomainError';
import { DatabaseClient } from './database';

interface UsuarioRow {
  id: string;
  nome: string;
  email: string;
  matricula: string;
  senha_hash: string;
  perfil: PerfilUsuario;
}

function mapRowToUsuario(row: UsuarioRow): Usuario {
  return new Usuario({
    id: row.id,
    nome: row.nome,
    email: row.email,
    matricula: row.matricula,
    senhaHash: row.senha_hash,
    perfil: row.perfil,
  });
}

export class SqlUsuarioRepository implements UsuarioRepoPort {
  constructor(private readonly db: DatabaseClient) {}

  async salvar(usuario: Usuario): Promise<void> {
    if (this.db.driver === 'postgres' && this.db.pgPool) {
      await this.db.pgPool.query(
        `INSERT INTO usuarios (id, nome, email, matricula, senha_hash, perfil)
         VALUES ($1, $2, $3, $4, $5, $6)`,
        [
          usuario.id,
          usuario.nome,
          usuario.email,
          usuario.matricula,
          usuario.senhaHash,
          usuario.perfil,
        ],
      );
      return;
    }

    if (this.db.sqlite) {
      this.db.sqlite
        .prepare(
          `INSERT INTO usuarios (id, nome, email, matricula, senha_hash, perfil)
           VALUES (?, ?, ?, ?, ?, ?)`,
        )
        .run(
          usuario.id,
          usuario.nome,
          usuario.email,
          usuario.matricula,
          usuario.senhaHash,
          usuario.perfil,
        );
    }
  }

  async buscarPorId(id: string): Promise<Usuario | null> {
    if (this.db.driver === 'postgres' && this.db.pgPool) {
      const { rows } = await this.db.pgPool.query<UsuarioRow>(
        'SELECT id, nome, email, matricula, senha_hash, perfil FROM usuarios WHERE id = $1 LIMIT 1',
        [id],
      );
      return rows[0] ? mapRowToUsuario(rows[0]) : null;
    }

    if (this.db.sqlite) {
      const row = this.db.sqlite
        .prepare(
          'SELECT id, nome, email, matricula, senha_hash, perfil FROM usuarios WHERE id = ? LIMIT 1',
        )
        .get(id) as UsuarioRow | undefined;
      return row ? mapRowToUsuario(row) : null;
    }

    return null;
  }

  async buscarPorEmailOuMatricula(identificador: string): Promise<Usuario | null> {
    const valor = identificador.trim();
    const valorLower = valor.toLowerCase();

    if (this.db.driver === 'postgres' && this.db.pgPool) {
      const { rows } = await this.db.pgPool.query<UsuarioRow>(
        `SELECT id, nome, email, matricula, senha_hash, perfil
         FROM usuarios
         WHERE LOWER(email) = $1 OR matricula = $2
         LIMIT 1`,
        [valorLower, valor],
      );
      return rows[0] ? mapRowToUsuario(rows[0]) : null;
    }

    if (this.db.sqlite) {
      const row = this.db.sqlite
        .prepare(
          `SELECT id, nome, email, matricula, senha_hash, perfil
           FROM usuarios
           WHERE LOWER(email) = ? OR matricula = ?
           LIMIT 1`,
        )
        .get(valorLower, valor) as UsuarioRow | undefined;
      return row ? mapRowToUsuario(row) : null;
    }

    return null;
  }

  async listar(_perfil?: PerfilUsuario): Promise<Usuario[]> {
    void this.db;
    throw new DomainError('SqlUsuarioRepository.listar pendente de implementação.', 'NOT_IMPLEMENTED');
  }
}
