import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-footer',
  standalone: true,
  imports: [RouterLink],
  template: `
    <footer class="bg-primary-light text-gray-900 mt-8">

      <!-- Main grid -->
      <div class="max-w-7xl mx-auto px-6 py-10 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">

        <!-- Brand -->
        <div class="flex flex-col items-center text-center gap-2">
          <a routerLink="/" class="block w-full">
            <img src="assets/images/lodo2.webp" alt="Mascotas Perdidas"
                 class="w-full h-24 object-contain">
          </a>
          <p class="font-bold text-gray-900 text-base">Mascotas Perdidas</p>
          <p class="text-sm text-gray-900 leading-relaxed">
            Conectando familias con sus mascotas perdidas.
          </p>
        </div>

        <!-- Navigation -->
        <div>
          <h3 class="font-semibold text-gray-900 mb-3 text-sm uppercase tracking-wide">Navegación</h3>
          <nav class="flex flex-col gap-2 text-sm" aria-label="Navegación pie de página">
            <a routerLink="/"               class="hover:text-primary transition-colors">Inicio</a>
            <a routerLink="/perdidos"        class="hover:text-primary transition-colors">Mascotas perdidas</a>
            <a routerLink="/encontrados"     class="hover:text-primary transition-colors">Mascotas encontradas</a>
            <a routerLink="/sobre-nosotros"  class="hover:text-primary transition-colors">Sobre nosotros</a>
            <a routerLink="/contacto"        class="hover:text-primary transition-colors">Contacto</a>
          </nav>
        </div>

        <!-- Legal -->
        <div>
          <h3 class="font-semibold text-gray-900 mb-3 text-sm uppercase tracking-wide">Información Legal</h3>
          <nav class="flex flex-col gap-2 text-sm" aria-label="Información legal">
            <a routerLink="/aviso-legal"          class="hover:text-primary transition-colors">Aviso legal</a>
            <a routerLink="/politica-privacidad"  class="hover:text-primary transition-colors">Política de privacidad</a>
            <a routerLink="/politica-cookies"     class="hover:text-primary transition-colors">Política de cookies</a>
          </nav>
        </div>

        <!-- Contact -->
        <div>
          <h3 class="font-semibold text-gray-900 mb-3 text-sm uppercase tracking-wide">Contacto</h3>
          <ul class="flex flex-col gap-2 text-sm">
            <li class="flex items-center gap-2">
              <img src="assets/images/icons/telefono.png" alt="Teléfono" class="w-5 h-5 object-contain">
              <a href="tel:+34696200890" class="hover:text-primary transition-colors">696 200 890</a>
            </li>
            <li class="flex items-center gap-2">
              <img src="assets/images/icons/email.png" alt="Correo electrónico" class="w-5 h-5 object-contain">
              <a href="mailto:Miguel_m.z@hotmail.com" class="hover:text-primary transition-colors break-all">
                Miguel_m.z&#64;hotmail.com
              </a>
            </li>
          </ul>
        </div>

      </div>

      <!-- Bottom bar -->
      <div class="border-t border-gray-300 py-4 px-6 text-center text-xs text-gray-600">
        © {{ year }} Mascotas Perdidas. Todos los derechos reservados. · Creado por Miguel Ángel Morcillo Zaragoza.
      </div>

    </footer>
  `,
})
export class FooterComponent {
  year = new Date().getFullYear();
}
