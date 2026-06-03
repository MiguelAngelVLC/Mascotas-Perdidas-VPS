import { Component, Input, Output, EventEmitter } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Report, STATUS_LABELS, ANIMAL_TYPE_LABELS, ANIMAL_TYPE_ICONS, ANIMAL_TYPE_IMG_PATHS } from '../../core/models/report.model';

@Component({
  selector: 'app-report-card',
  standalone: true,
  imports: [CommonModule],
  template: `
    <article class="card cursor-pointer hover:shadow-lg hover:-translate-y-0.5 transition-all duration-200 h-full flex flex-col"
             (click)="selected.emit(report)"
             (keydown.enter)="selected.emit(report)"
             (keydown.space)="selected.emit(report)"
             tabindex="0"
             [attr.aria-label]="'Ver detalles de ' + (report.name || 'animal sin nombre')">

      <!-- Imagen -->
      <div class="relative overflow-hidden" style="height:192px">
        <img [src]="report.primaryImageUrl || 'assets/images/no-photo.svg'"
             [alt]="report.name || 'Animal'"
             class="w-full h-full object-cover"
             loading="lazy"
             (error)="onImgError($event)">
        <span [class]="badgeClass()" class="absolute top-3 right-3 text-sm font-medium px-3 py-0.5 rounded-full shadow">
          {{ statusLabel() }}
        </span>
      </div>

      <!-- Cuerpo -->
      <div class="p-4 flex flex-col flex-1">
        <div class="flex items-start justify-between mb-1">
          <div>
            <h3 class="text-lg font-semibold text-gray-900">{{ report.name || 'Sin nombre' }}</h3>
            <p class="text-sm text-gray-500">{{ report.breed || 'Raza desconocida' }}</p>
          </div>
          @if (typeImgPath()) {
            <img [src]="typeImgPath()!" [alt]="typeLabel()" title="{{ typeLabel() }}"
                 class="w-8 h-8 object-contain">
          } @else {
            <span class="text-xl" [attr.aria-label]="typeLabel()" title="{{ typeLabel() }}">
              {{ typeIcon() }}
            </span>
          }
        </div>

        <p class="text-sm text-gray-600 line-clamp-2 mb-3 flex-1">
          {{ report.description || 'Sin descripción.' }}
        </p>

        <div class="text-xs text-gray-400 space-y-1 mb-3">
          <div class="flex items-center gap-1">
            <img src="assets/images/icons/ubicacion.png" alt="Ubicación" class="w-4 h-4 object-contain flex-shrink-0">
            <span>{{ report.locationText || report.city || '—' }}</span>
          </div>
          <div class="flex items-center gap-1">
            <img src="assets/images/icons/calendario.png" alt="Fecha" class="w-4 h-4 object-contain flex-shrink-0">
            <span>{{ report.eventDate | date:'dd/MM/yyyy' }}</span>
          </div>
        </div>

        <div class="border-t border-gray-100 pt-3">
          <p class="text-xs font-medium text-gray-500 mb-1">Contacto:</p>
          <div class="flex items-center gap-1 text-xs text-gray-600">
            <img src="assets/images/icons/usuario.png" alt="Contacto" class="w-4 h-4 object-contain flex-shrink-0">
            <span>{{ report.contactName }}</span>
          </div>
          <div class="flex items-center gap-1 text-xs text-gray-600">
            <img src="assets/images/icons/telefono2.png" alt="Teléfono" class="w-4 h-4 object-contain flex-shrink-0">
            <span>{{ report.contactPhone }}</span>
          </div>
        </div>
      </div>
    </article>
  `,
})
export class ReportCardComponent {
  @Input({ required: true }) report!: Report;
  @Output() selected = new EventEmitter<Report>();

  badgeClass(): string {
    return this.report.status === 'LOST' ? 'badge-lost' : 'badge-found';
  }
  statusLabel(): string {
    return STATUS_LABELS[this.report.status];
  }
  typeLabel(): string {
    return ANIMAL_TYPE_LABELS[this.report.animalType];
  }
  typeIcon(): string {
    return ANIMAL_TYPE_ICONS[this.report.animalType];
  }
  typeImgPath(): string | null {
    return ANIMAL_TYPE_IMG_PATHS[this.report.animalType] ?? null;
  }
  onImgError(ev: Event): void {
    (ev.target as HTMLImageElement).src = 'assets/images/no-photo.svg';
  }
}
