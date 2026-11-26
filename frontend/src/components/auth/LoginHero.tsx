export function LoginHero() {
  return (
    <section className="login-hero" aria-label="Identidade do Sistema de Gestão Escolar">
      <svg
        className="login-hero-waves"
        viewBox="0 0 800 900"
        preserveAspectRatio="none"
        aria-hidden="true"
      >
        <path
          d="M0 0 H430 C370 180 230 250 0 330 Z"
          fill="#1D4ED8"
          fillOpacity="0.48"
        />
        <path
          d="M800 0 H540 C480 280 760 440 500 900 H800 Z"
          fill="#0A2FA6"
          fillOpacity="0.45"
        />
        <path
          d="M0 540 C260 560 460 720 430 900 H0 Z"
          fill="#092996"
          fillOpacity="0.52"
        />
      </svg>

      <div className="login-hero-lockup">
        <div className="hero-badge-outline">SGE</div>
        <div className="hero-divider" aria-hidden="true" />
        <div className="hero-system-name">
          Sistema de
          <br />
          Gestão
          <br />
          Escolar
        </div>
      </div>
    </section>
  );
}
