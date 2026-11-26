interface BrandMarkProps {
  label?: string;
  size?: 'sm' | 'lg';
}

export function BrandMark({ label = 'Gestão Escolar', size = 'sm' }: BrandMarkProps) {
  return (
    <div className={size === 'lg' ? 'login-brand' : 'brand-lockup'}>
      <span className={size === 'lg' ? 'brand-mark-lg' : 'brand-mark'} aria-hidden="true">
        SGE
      </span>
      <span className={size === 'lg' ? 'login-brand-label' : 'brand-title'}>
        {label}
      </span>
    </div>
  );
}
