import { MaterialIcon } from './MaterialIcon';

type AlertVariant = 'error' | 'success' | 'info';

interface AlertBannerProps {
  message: string;
  variant?: AlertVariant;
}

const ICON_BY_VARIANT: Record<AlertVariant, string> = {
  error: 'error',
  success: 'check_circle',
  info: 'info',
};

export function AlertBanner({ message, variant = 'error' }: AlertBannerProps) {
  return (
    <div className={`alert-banner alert-${variant}`} role={variant === 'error' ? 'alert' : 'status'}>
      <MaterialIcon name={ICON_BY_VARIANT[variant]} className="banner-icon" />
      <span>{message}</span>
    </div>
  );
}
