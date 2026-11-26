import { ButtonHTMLAttributes, ReactNode } from 'react';
import { MaterialIcon } from './MaterialIcon';

type ButtonVariant = 'primary' | 'secondary' | 'ghost';

interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: ButtonVariant;
  icon?: string;
  fullWidth?: boolean;
  children: ReactNode;
}

export function Button({
  variant = 'primary',
  icon,
  fullWidth = false,
  className = '',
  children,
  ...props
}: ButtonProps) {
  const classes = [
    `btn-${variant}`,
    icon ? 'btn-with-icon' : '',
    fullWidth ? 'btn-full' : '',
    className,
  ]
    .filter(Boolean)
    .join(' ');

  return (
    <button className={classes} {...props}>
      {icon && <MaterialIcon name={icon} className="nav-icon" />}
      <span>{children}</span>
    </button>
  );
}
