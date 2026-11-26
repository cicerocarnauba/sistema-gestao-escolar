import cors from 'cors';
import express, { Express } from 'express';
import { DatabaseClient } from '../adapters/outbound/persistence/database';
import {
  SqlMatriculaRepository,
  SqlNotaRepository,
  SqlTurmaRepository,
  UsuarioRepositoryAdapter,
} from '../adapters/outbound/persistence/repositories';
import { JwtBcryptAuthAdapter } from '../adapters/outbound/auth/JwtBcryptAuthAdapter';
import {
  AutenticarUsuarioUseCase,
  CadastrarUsuarioUseCase,
  ConsultarBoletimUseCase,
  ConsultarTurmasUseCase,
  CriarTurmaUseCase,
  LancarNotaUseCase,
  ListarUsuariosUseCase,
  MatricularAlunoUseCase,
  ValidarTokenUseCase,
} from '../core/usecases';
import { garantirUsuariosIniciaisDev } from '../adapters/outbound/persistence/seed';
import { criarRotasApi } from '../adapters/inbound/http/routes';
import { errorHandler } from '../adapters/inbound/http/errorHandler';

export async function criarAplicacao(): Promise<{ app: Express; db: DatabaseClient }> {
  const db = new DatabaseClient();
  await db.initSchema();

  // Adaptadores de Saída (Driven Adapters)
  const authService = new JwtBcryptAuthAdapter();
  const usuarioRepo = new UsuarioRepositoryAdapter(db);
  const turmaRepo = new SqlTurmaRepository(db);
  const matriculaRepo = new SqlMatriculaRepository(db);
  const notaRepo = new SqlNotaRepository(db);

  await garantirUsuariosIniciaisDev(usuarioRepo, authService);

  // Casos de Uso do Núcleo (conectados apenas às Portas)
  const autenticarUsuario = new AutenticarUsuarioUseCase(usuarioRepo, authService);
  const validarToken = new ValidarTokenUseCase(authService);
  const cadastrarUsuario = new CadastrarUsuarioUseCase(usuarioRepo, authService);
  const listarUsuarios = new ListarUsuariosUseCase(usuarioRepo);
  const criarTurma = new CriarTurmaUseCase(turmaRepo, usuarioRepo);
  const consultarTurmas = new ConsultarTurmasUseCase(turmaRepo);
  const matricularAluno = new MatricularAlunoUseCase(matriculaRepo, turmaRepo, usuarioRepo);
  const lancarNota = new LancarNotaUseCase(notaRepo, turmaRepo, matriculaRepo);
  const consultarBoletim = new ConsultarBoletimUseCase(matriculaRepo, turmaRepo, notaRepo);

  // Adaptador de Entrada HTTP (Driving Adapter)
  const app = express();
  app.use(cors());
  app.use(express.json());

  app.get('/health', (_req, res) => {
    res.status(200).json({
      status: 'ok',
      servico: 'sge-backend',
      arquitetura: 'hexagonal',
      banco: db.driver,
    });
  });

  app.use(
    criarRotasApi({
      validarToken,
      autenticarUsuario,
      cadastrarUsuario,
      listarUsuarios,
      criarTurma,
      consultarTurmas,
      matricularAluno,
      lancarNota,
      consultarBoletim,
    }),
  );

  app.use(errorHandler);

  return { app, db };
}
