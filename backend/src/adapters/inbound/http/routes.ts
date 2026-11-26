import { Router } from 'express';
import {
  AutenticarUsuarioPort,
  CadastrarUsuarioPort,
  ConsultarBoletimPort,
  ConsultarTurmasPort,
  CriarTurmaPort,
  LancarNotaPort,
  ListarUsuariosPort,
  MatricularAlunoPort,
  ValidarTokenPort,
} from '../../../core/ports/in';
import { AuthMiddleware } from './AuthMiddleware';
import { AuthController } from './AuthController';
import { PerfilUsuario } from '../../../core/domain/entities/Usuario';

export interface HttpDependencies {
  validarToken: ValidarTokenPort;
  autenticarUsuario: AutenticarUsuarioPort;
  cadastrarUsuario: CadastrarUsuarioPort;
  listarUsuarios: ListarUsuariosPort;
  criarTurma: CriarTurmaPort;
  consultarTurmas: ConsultarTurmasPort;
  matricularAluno: MatricularAlunoPort;
  lancarNota: LancarNotaPort;
  consultarBoletim: ConsultarBoletimPort;
}

export function criarRotasApi(deps: HttpDependencies): Router {
  const router = Router();
  const authMiddleware = new AuthMiddleware(deps.validarToken);
  const { autenticar, exigirPerfis } = authMiddleware;
  const authController = new AuthController(deps.autenticarUsuario);

  // RF01 — POST /auth/login
  router.post('/auth/login', authController.login);

  // RF03 & RF06 — POST /usuarios | GET /usuarios
  router.post('/usuarios', autenticar, exigirPerfis('ADMIN'), async (req, res, next) => {
    try {
      const resultado = await deps.cadastrarUsuario.executar(req.body);
      res.status(201).json(resultado);
    } catch (err) {
      next(err);
    }
  });

  router.get('/usuarios', autenticar, exigirPerfis('ADMIN'), async (req, res, next) => {
    try {
      const perfil = req.query.perfil as PerfilUsuario | undefined;
      const resultado = await deps.listarUsuarios.executar(perfil);
      res.status(200).json(resultado);
    } catch (err) {
      next(err);
    }
  });

  // RF04, RF06, RF07, RF09 — POST /turmas | GET /turmas
  router.post('/turmas', autenticar, exigirPerfis('ADMIN'), async (req, res, next) => {
    try {
      const resultado = await deps.criarTurma.executar(req.body);
      res.status(201).json(resultado);
    } catch (err) {
      next(err);
    }
  });

  router.get('/turmas', autenticar, exigirPerfis('ADMIN', 'PROFESSOR', 'ALUNO'), async (req, res, next) => {
    try {
      const resultado = await deps.consultarTurmas.executar({
        solicitanteId: req.usuario!.sub,
        perfil: req.usuario!.perfil,
      });
      res.status(200).json(resultado);
    } catch (err) {
      next(err);
    }
  });

  // RF05 — POST /matriculas
  router.post('/matriculas', autenticar, exigirPerfis('ADMIN'), async (req, res, next) => {
    try {
      const resultado = await deps.matricularAluno.executar(req.body);
      res.status(201).json(resultado);
    } catch (err) {
      next(err);
    }
  });

  // RF08 — POST /notas | PUT /notas/:id
  router.post('/notas', autenticar, exigirPerfis('PROFESSOR'), async (req, res, next) => {
    try {
      const resultado = await deps.lancarNota.executar({
        ...req.body,
        professorAutenticadoId: req.usuario!.sub,
      });
      res.status(201).json(resultado);
    } catch (err) {
      next(err);
    }
  });

  router.put('/notas/:id', autenticar, exigirPerfis('PROFESSOR'), async (req, res, next) => {
    try {
      const resultado = await deps.lancarNota.executar({
        ...req.body,
        notaId: req.params.id,
        professorAutenticadoId: req.usuario!.sub,
      });
      res.status(200).json(resultado);
    } catch (err) {
      next(err);
    }
  });

  // RF10 — GET /boletim
  router.get('/boletim', autenticar, exigirPerfis('ALUNO'), async (req, res, next) => {
    try {
      const resultado = await deps.consultarBoletim.executar(req.usuario!.sub);
      res.status(200).json(resultado);
    } catch (err) {
      next(err);
    }
  });

  return router;
}
