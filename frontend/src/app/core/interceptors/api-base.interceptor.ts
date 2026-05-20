import { HttpInterceptorFn } from '@angular/common/http';
import { environment } from '../../../environments/environment';

/**
 * Antepone la URL base de la API a todas las peticiones que empiecen por /api.
 * En desarrollo (apiUrl vacío) no hace nada: el proxy de ng serve redirige al backend local.
 * En producción, redirige al host del VPS (ej. https://api.tudominio.com).
 */
export const apiBaseInterceptor: HttpInterceptorFn = (req, next) => {
  if (environment.apiUrl && req.url.startsWith('/api')) {
    req = req.clone({ url: environment.apiUrl + req.url });
  }
  return next(req);
};
