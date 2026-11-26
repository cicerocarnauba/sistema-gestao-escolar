interface MaterialIconProps {
  name: string;
  className?: string;
  label?: string;
}

export function MaterialIcon({ name, className = '', label }: MaterialIconProps) {
  return (
    <span
      className={`material-symbols-outlined ${className}`.trim()}
      aria-hidden={label ? undefined : true}
      aria-label={label}
    >
      {name}
    </span>
  );
}
