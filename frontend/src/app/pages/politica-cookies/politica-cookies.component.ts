import { Component } from '@angular/core';

@Component({
  selector: 'app-politica-cookies',
  standalone: true,
  template: `
    <div class="px-4 sm:px-8 py-6 max-w-4xl mx-auto">
      <h1 class="section-title mb-6">Política de Cookies</h1>

      <div class="card p-6 sm:p-10 space-y-6 text-gray-700 leading-relaxed">

        <section>
          <h2 class="text-xl font-bold text-gray-900 mb-2">¿Qué son las cookies?</h2>
          <p>
            Las cookies son pequeños ficheros de texto que los sitios web almacenan en el dispositivo del
            usuario al visitar una página. Permiten que el sitio recuerde tus preferencias y mejore tu
            experiencia de navegación.
          </p>
        </section>

        <section>
          <h2 class="text-xl font-bold text-gray-900 mb-2">Cookies que utilizamos</h2>
          <div class="overflow-x-auto mt-2">
            <table class="w-full text-sm border border-gray-200 rounded-lg overflow-hidden">
              <thead class="bg-primary-light text-gray-900 font-semibold">
                <tr>
                  <th class="text-left px-4 py-2">Nombre</th>
                  <th class="text-left px-4 py-2">Tipo</th>
                  <th class="text-left px-4 py-2">Duración</th>
                  <th class="text-left px-4 py-2">Finalidad</th>
                </tr>
              </thead>
              <tbody>
                @for (cookie of cookies; track cookie.name; let odd = $odd) {
                  <tr [class]="odd ? 'bg-gray-50' : 'bg-white'">
                    <td class="px-4 py-2 font-mono">{{ cookie.name }}</td>
                    <td class="px-4 py-2">{{ cookie.type }}</td>
                    <td class="px-4 py-2">{{ cookie.duration }}</td>
                    <td class="px-4 py-2">{{ cookie.purpose }}</td>
                  </tr>
                }
              </tbody>
            </table>
          </div>
        </section>

        <section>
          <h2 class="text-xl font-bold text-gray-900 mb-2">¿Cómo desactivar las cookies?</h2>
          <p>
            Puedes configurar tu navegador para rechazar todas las cookies o para que te avise cuando se
            envíe una. Ten en cuenta que algunas funcionalidades del sitio pueden verse afectadas si
            desactivas las cookies técnicas.
          </p>
          <ul class="list-disc list-inside mt-2 space-y-1">
            <li><a href="https://support.google.com/chrome/answer/95647" target="_blank" rel="noopener noreferrer" class="text-primary hover:underline">Google Chrome</a></li>
            <li><a href="https://support.mozilla.org/es/kb/habilitar-y-deshabilitar-cookies-sitios-web-rastrear-preferencias" target="_blank" rel="noopener noreferrer" class="text-primary hover:underline">Mozilla Firefox</a></li>
            <li><a href="https://support.apple.com/es-es/guide/safari/sfri11471/mac" target="_blank" rel="noopener noreferrer" class="text-primary hover:underline">Safari</a></li>
            <li><a href="https://support.microsoft.com/es-es/microsoft-edge/eliminar-las-cookies-en-microsoft-edge-63947406-40ac-c3b8-57b9-2a946a29ae09" target="_blank" rel="noopener noreferrer" class="text-primary hover:underline">Microsoft Edge</a></li>
          </ul>
        </section>

        <section>
          <h2 class="text-xl font-bold text-gray-900 mb-2">Actualizaciones de esta política</h2>
          <p>
            Podemos actualizar esta Política de Cookies para reflejar cambios en las cookies que utilizamos
            o por otros motivos operativos, legales o reglamentarios. Visita esta página periódicamente
            para mantenerte informado.
          </p>
          <p class="mt-2">
            Para cualquier consulta puedes contactarnos en
            <a href="mailto:Miguel_m.z@hotmail.com" class="text-primary hover:underline">Miguel_m.z&#64;hotmail.com</a>.
          </p>
        </section>

      </div>
    </div>
  `,
})
export class PoliticaCookiesComponent {
  cookies = [
    {
      name: 'auth_token',
      type: 'Técnica',
      duration: 'Sesión',
      purpose: 'Mantiene la sesión del usuario autenticado.',
    },
    {
      name: 'XSRF-TOKEN',
      type: 'Seguridad',
      duration: 'Sesión',
      purpose: 'Protección contra ataques CSRF.',
    },
    {
      name: 'cookie_consent',
      type: 'Preferencia',
      duration: '1 año',
      purpose: 'Guarda si el usuario aceptó el aviso de cookies.',
    },
  ];
}
