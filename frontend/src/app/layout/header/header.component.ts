import { Component, inject } from '@angular/core';
import { RouterLink } from '@angular/router';
import { CommonModule } from '@angular/common';
import { AuthService } from '../../core/services/auth.service';

@Component({
  selector: 'app-header',
  standalone: true,
  imports: [RouterLink, CommonModule],
  template: `
    <header class="bg-white shadow-sm px-4 sm:px-8 py-3">
      <div class="max-w-7xl mx-auto flex items-center gap-4">

        <a routerLink="/" class="shrink-0 no-underline">
          <img src="assets/images/logo.webp"
               alt="Mascotas Perdidas"
               class="w-40 h-24 rounded-xl object-contain" />
        </a>

        <div class="flex-1 flex justify-center items-center hidden sm:flex min-w-0">
          <img src="assets/images/Rotulo.webp"
               alt="Mascotas Perdidas"
               class="max-h-24 w-auto object-contain" />
        </div>

        <div class="shrink-0 flex items-center gap-2">
          @if (auth.isLoggedIn()) {
            <a routerLink="/reportar"
               class="btn-teal text-sm hidden sm:inline-flex items-center gap-1">
              <span>+ Publicar</span>
            </a>
            <a routerLink="/perfil"
               class="flex items-center gap-2 bg-gray-100 hover:bg-gray-200 rounded-full px-3 py-1.5 transition-colors"
               [attr.aria-label]="'Perfil de ' + auth.user()?.fullName">
              <img src="assets/images/icons/Usuario2.png" alt="Avatar de usuario"
                   class="w-8 h-8 rounded-full object-cover">
              <span class="text-gray-900 text-sm font-medium hidden md:block">{{ auth.user()?.fullName }}</span>
            </a>
            <button (click)="auth.logout()"
                    class="text-gray-500 hover:text-gray-800 text-sm font-medium transition-colors"
                    aria-label="Cerrar sesión">
              Salir
            </button>
          } @else {
            <a routerLink="/login"
               class="text-gray-600 hover:text-gray-900 text-sm font-medium transition-colors">
              Iniciar sesión
            </a>
            <a routerLink="/registro"
               class="btn-primary text-sm">
              Registrarse
            </a>
          }
        </div>
      </div>
    </header>
  `,
})
export class HeaderComponent {
  auth = inject(AuthService);

  initial(): string {
    return (this.auth.user()?.fullName ?? '?').charAt(0).toUpperCase();
  }
}
