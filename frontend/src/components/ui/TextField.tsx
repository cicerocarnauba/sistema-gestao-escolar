import { InputHTMLAttributes, ReactNode } from 'react';
import { MaterialIcon } from './MaterialIcon';

interface TextFieldProps extends InputHTMLAttributes<HTMLInputElement> {
  id: string;
  label: string;
  icon?: string;
  action?: ReactNode;
}

export function TextField({ id, label, icon, action, ...inputProps }: TextFieldProps) {
  const labelNode = (
    <label htmlFor={id} className={icon ? 'label-with-icon' : undefined}>
      {icon && <MaterialIcon name={icon} className="field-icon" />}
      <span>{label}</span>
    </label>
  );

  return (
    <div className="form-field">
      {action ? (
        <div className="label-row">
          {labelNode}
          {action}
        </div>
      ) : (
        labelNode
      )}
      <input id={id} {...inputProps} />
    </div>
  );
}
