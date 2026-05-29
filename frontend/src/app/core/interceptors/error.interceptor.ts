import { HttpInterceptorFn, HttpErrorResponse } from '@angular/common/http';
import { inject } from '@angular/core';
import { Router } from '@angular/router';
import { catchError, throwError, EMPTY } from 'rxjs';
import { AuthService } from '../services/auth.service';

function isSessionExpired(err: HttpErrorResponse, hadToken: boolean): boolean {
  if (!hadToken) return false;
  if (err.status === 401) return true;
  if (err.status === 403 && !err.error?.message) return true;
  return false;
}

export const errorInterceptor: HttpInterceptorFn = (req, next) => {
  const router = inject(Router);
  const auth   = inject(AuthService);

  return next(req).pipe(
    catchError((err: HttpErrorResponse) => {
      if (!req.url.includes('/api/auth/') && isSessionExpired(err, auth.isLoggedIn())) {
        auth.clearSession();
        router.navigate(['/login'], {
          queryParams: { returnUrl: router.url, reason: 'sessionExpired' },
        });
        return EMPTY;
      }
      return throwError(() => err);
    })
  );
};
