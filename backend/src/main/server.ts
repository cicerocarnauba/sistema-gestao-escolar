import 'dotenv/config';
import { criarAplicacao } from './app';

const PORT = Number(process.env.PORT || 3333);

criarAplicacao()
  .then(({ app, db }) => {
    app.listen(PORT, () => {
      console.log(`[SGE Backend] Rodando em http://localhost:${PORT} (driver: ${db.driver})`);
    });
  })
  .catch((err) => {
    console.error('[SGE Backend] Falha ao iniciar:', err);
    process.exit(1);
  });
