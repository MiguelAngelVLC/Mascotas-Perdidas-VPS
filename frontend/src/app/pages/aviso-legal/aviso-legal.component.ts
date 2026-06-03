import { Component } from '@angular/core';

@Component({
  selector: 'app-aviso-legal',
  standalone: true,
  template: `
    <div class="px-4 sm:px-8 py-6 max-w-4xl mx-auto">
      <h1 class="section-title mb-6">Aviso Legal</h1>

      <div class="card p-6 sm:p-10 space-y-6 text-gray-700 leading-relaxed">

        <section>
          <h2 class="text-xl font-bold text-gray-900 mb-2">1. Datos identificativos del titular</h2>
          <p>
            En cumplimiento del artículo 10 de la Ley 34/2002, de 11 de julio, de Servicios de la Sociedad
            de la Información y de Comercio Electrónico (LSSI-CE), se pone a disposición del usuario la
            siguiente información:
          </p>
          <ul class="list-disc list-inside mt-2 space-y-1">
            <li><strong>Nombre:</strong> Miguel Mascotas Perdidas</li>
            <li><strong>Correo electrónico:</strong> Miguel_m.z&#64;hotmail.com</li>
            <li><strong>Teléfono:</strong> 696 200 890</li>
          </ul>
        </section>

        <section>
          <h2 class="text-xl font-bold text-gray-900 mb-2">2. Objeto y ámbito de aplicación</h2>
          <p>
            El presente Aviso Legal regula el acceso y uso del sitio web <strong>Mascotas Perdidas</strong>,
            cuya finalidad es facilitar el reencuentro entre mascotas extraviadas y sus dueños mediante la
            publicación gratuita de reportes de animales perdidos o encontrados.
          </p>
        </section>

        <section>
          <h2 class="text-xl font-bold text-gray-900 mb-2">3. Propiedad intelectual</h2>
          <p>
            Los contenidos del sitio web —incluyendo textos, imágenes, diseño gráfico, logotipos y código fuente—
            son propiedad del titular o cuentan con las licencias correspondientes. Queda prohibida su
            reproducción, distribución o modificación sin autorización expresa y por escrito.
          </p>
          <p class="mt-2">
            Las imágenes y textos publicados en los reportes de animales son responsabilidad exclusiva de los
            usuarios que los publican.
          </p>
        </section>

        <section>
          <h2 class="text-xl font-bold text-gray-900 mb-2">4. Responsabilidad</h2>
          <p>
            El titular no se hace responsable de los daños o perjuicios que pudieran derivarse del uso del
            sitio web, ni de la veracidad de la información aportada por los usuarios en los reportes.
            Asimismo, no garantiza la disponibilidad continua del servicio.
          </p>
        </section>

        <section>
          <h2 class="text-xl font-bold text-gray-900 mb-2">5. Legislación aplicable y jurisdicción</h2>
          <p>
            El presente Aviso Legal se rige por la legislación española vigente. Para la resolución de
            cualquier controversia derivada del acceso o uso del sitio web, las partes se someten
            expresamente a los Juzgados y Tribunales del domicilio del titular, con renuncia a cualquier
            otro fuero que pudiera corresponderles.
          </p>
        </section>

      </div>
    </div>
  `,
})
export class AvisoLegalComponent {}
