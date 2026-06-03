import { Component } from '@angular/core';

@Component({
  selector: 'app-politica-privacidad',
  standalone: true,
  template: `
    <div class="px-4 sm:px-8 py-6 max-w-4xl mx-auto">
      <h1 class="section-title mb-6">Política de Privacidad</h1>

      <div class="card p-6 sm:p-10 space-y-6 text-gray-700 leading-relaxed">

        <section>
          <h2 class="text-xl font-bold text-gray-900 mb-2">1. Responsable del tratamiento</h2>
          <ul class="list-disc list-inside space-y-1">
            <li><strong>Nombre:</strong> Miguel Mascotas Perdidas</li>
            <li><strong>Correo electrónico:</strong> Miguel_m.z&#64;hotmail.com</li>
            <li><strong>Teléfono:</strong> 696 200 890</li>
          </ul>
        </section>

        <section>
          <h2 class="text-xl font-bold text-gray-900 mb-2">2. Datos que recopilamos</h2>
          <p>Recopilamos los datos que el usuario nos facilita voluntariamente al:</p>
          <ul class="list-disc list-inside mt-2 space-y-1">
            <li>Crear una cuenta: nombre de usuario, correo electrónico, contraseña (almacenada cifrada), nombre completo y teléfono opcional.</li>
            <li>Publicar un reporte: nombre del animal, descripción, fotografías, datos de contacto y ubicación aproximada.</li>
            <li>Contactarnos a través del formulario de contacto.</li>
          </ul>
        </section>

        <section>
          <h2 class="text-xl font-bold text-gray-900 mb-2">3. Finalidad y base legal</h2>
          <p>
            Los datos se utilizan exclusivamente para gestionar tu cuenta, publicar y gestionar reportes
            de mascotas perdidas o encontradas, y atender consultas o solicitudes. La base legal es el
            consentimiento del usuario (art. 6.1.a RGPD) y el cumplimiento de la relación contractual
            (art. 6.1.b RGPD).
          </p>
        </section>

        <section>
          <h2 class="text-xl font-bold text-gray-900 mb-2">4. Conservación de los datos</h2>
          <p>
            Los datos se conservan mientras el usuario mantenga su cuenta activa. Tras la baja, se
            eliminarán en un plazo máximo de 30 días, salvo obligación legal de conservación.
          </p>
        </section>

        <section>
          <h2 class="text-xl font-bold text-gray-900 mb-2">5. Cesión a terceros</h2>
          <p>
            No cedemos datos personales a terceros, salvo obligación legal o cuando el propio usuario
            haya incluido datos de contacto en un reporte público (dichos datos son visibles para todos
            los visitantes del sitio).
          </p>
        </section>

        <section>
          <h2 class="text-xl font-bold text-gray-900 mb-2">6. Derechos del usuario</h2>
          <p>
            Puedes ejercer en cualquier momento tus derechos de acceso, rectificación, supresión,
            oposición, limitación del tratamiento y portabilidad enviando un correo a
            <a href="mailto:Miguel_m.z@hotmail.com" class="text-primary hover:underline">Miguel_m.z&#64;hotmail.com</a>
            con el asunto «Protección de Datos».
          </p>
          <p class="mt-2">
            También tienes derecho a presentar una reclamación ante la Agencia Española de Protección de
            Datos (<a href="https://www.aepd.es" target="_blank" rel="noopener noreferrer" class="text-primary hover:underline">www.aepd.es</a>).
          </p>
        </section>

      </div>
    </div>
  `,
})
export class PoliticaPrivacidadComponent {}
