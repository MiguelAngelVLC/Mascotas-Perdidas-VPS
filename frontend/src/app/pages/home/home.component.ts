import { Component, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { ReportService } from '../../core/services/report.service';
import { StatsService } from '../../core/services/stats.service';
import { Report } from '../../core/models/report.model';
import { PageResponse, Stats } from '../../core/models/page.model';
import { ReportCardComponent } from '../../shared/report-card/report-card.component';
import { ReportDetailModalComponent } from '../../shared/report-detail-modal/report-detail-modal.component';
import { PaginationComponent } from '../../shared/pagination/pagination.component';
import { LoadingComponent } from '../../shared/loading/loading.component';
import { EmptyStateComponent } from '../../shared/empty-state/empty-state.component';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [
    CommonModule, RouterLink, ReportCardComponent, ReportDetailModalComponent,
    PaginationComponent, LoadingComponent, EmptyStateComponent,
  ],
  template: `
    <div class="min-h-screen">

      <!-- Hero -->
      <section class="bg-white mx-4 sm:mx-8 mt-6 rounded-2xl overflow-hidden shadow-card">
        <div class="relative bg-cover bg-center min-h-64 flex flex-col items-center justify-center text-center p-8"
             style="background: linear-gradient(rgba(255,255,255,0.3),rgba(255,255,255,0.3)),
                    url('assets/images/hero-bg.jpg') center/cover;">
          <h1 class="text-3xl sm:text-4xl font-bold text-gray-900 mb-3 drop-shadow-sm">
            Ayudemos a reunir familias
          </h1>
          <p class="text-gray-800 max-w-lg mb-6 text-base sm:text-lg">
            Conectamos animales perdidos y encontrados con sus familias.
            Cada publicación puede ser el comienzo de un feliz reencuentro.
          </p>
          <div class="flex gap-3 flex-wrap justify-center">
            <a routerLink="/reportar" class="btn-primary">Publicar Reporte</a>
            <a routerLink="/perdidos" class="btn-outline border-gray-800 text-gray-900">Ver Perdidos</a>
          </div>
        </div>
      </section>

      <!-- Estadísticas -->
      <section class="px-4 sm:px-8 py-6" aria-label="Estadísticas">
        @if (stats()) {
          <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
            <div class="bg-white rounded-2xl p-5 flex items-center gap-4 shadow-card border border-gray-200">
              <div class="w-10 h-10 bg-red-pet rounded-xl flex items-center justify-center text-xl" aria-hidden="true">🔍</div>
              <div>
                <p class="text-gray-500 text-sm">Animales Perdidos</p>
                <p class="text-2xl font-bold text-gray-900">{{ stats()!.lostCount }}</p>
              </div>
            </div>
            <div class="bg-white rounded-2xl p-5 flex items-center gap-4 shadow-card border border-gray-200">
              <div class="w-10 h-10 bg-teal rounded-xl flex items-center justify-center text-xl" aria-hidden="true">❤️</div>
              <div>
                <p class="text-gray-500 text-sm">Animales Encontrados</p>
                <p class="text-2xl font-bold text-gray-900">{{ stats()!.foundCount }}</p>
              </div>
            </div>
            <div class="bg-white rounded-2xl p-5 flex items-center gap-4 shadow-card border border-gray-200">
              <div class="w-10 h-10 bg-yellow-pet rounded-xl flex items-center justify-center text-xl" aria-hidden="true">🏷️</div>
              <div>
                <p class="text-gray-500 text-sm">Total de Reportes</p>
                <p class="text-2xl font-bold text-gray-900">{{ stats()!.totalCount }}</p>
              </div>
            </div>
          </div>
        }
      </section>

      <!-- Cómo funciona -->
      <section class="mx-4 sm:mx-8 mb-6 bg-white/20 rounded-2xl p-6 sm:p-10" aria-labelledby="como-funciona-title">
        <h2 id="como-funciona-title" class="text-3xl font-bold text-white text-center mb-8">¿Cómo funciona?</h2>
        <div class="grid grid-cols-1 sm:grid-cols-3 gap-6">
          @for (step of steps; track step.num) {
            <div class="bg-white rounded-2xl p-6 text-center shadow-card border border-gray-100">
              <div class="w-16 h-16 rounded-full flex items-center justify-center text-3xl font-bold mx-auto mb-4 border-2"
                   [style.background-color]="step.color" [style.border-color]="step.color">
                {{ step.num }}
              </div>
              <h3 class="text-lg font-semibold text-gray-700 mb-2">{{ step.title }}</h3>
              <p class="text-sm text-gray-500 leading-relaxed">{{ step.desc }}</p>
            </div>
          }
        </div>
      </section>

      <!-- Reportes recientes -->
      <section id="reportes-recientes" class="px-4 sm:px-8 pb-4">
        <div class="flex items-center justify-between mb-2">
          <h2 class="section-title">Reportes Recientes</h2>
          <div class="flex gap-2">
            <a routerLink="/perdidos"    class="btn-red text-sm">Perdidos</a>
            <a routerLink="/encontrados" class="btn-teal text-sm">Encontrados</a>
          </div>
        </div>
        <p class="text-sm text-gray-300 mb-6">Últimos reportes publicados por la comunidad</p>

        @if (loading()) {
          <app-loading />
        } @else if (loadError()) {
          <p class="text-center text-red-200 py-8" role="alert">
            No se pudieron cargar los reportes. Inténtalo de nuevo más tarde.
          </p>
        } @else if (page()?.content?.length === 0) {
          <app-empty-state
            icon="🐾"
            title="Aún no hay reportes"
            message="Sé el primero en publicar un animal perdido o encontrado."
            actionLabel="Publicar reporte"
            actionLink="/reportar" />
        } @else {
          <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 mb-6">
            @for (report of page()?.content ?? []; track report.id) {
              <app-report-card [report]="report" (selected)="selectedReport.set($event)" />
            }
          </div>
          <app-pagination
            [currentPage]="currentPage()"
            [totalPages]="page()?.totalPages ?? 0"
            [totalElements]="page()?.totalElements ?? 0"
            (pageChange)="onPageChange($event)" />
        }
      </section>

      <!-- CTA -->
      <section class="mx-4 sm:mx-8 mb-8 bg-gradient-to-b from-teal to-teal-dark rounded-2xl p-8 text-center shadow-card border border-teal-dark">
        <h2 class="text-2xl sm:text-3xl font-bold text-gray-900 mb-3">¿Necesitas ayuda?</h2>
        <p class="text-gray-800 max-w-2xl mx-auto mb-6">
          Publica la información de tu mascota perdida o de un animal que hayas encontrado.
          La comunidad está aquí para ayudarte.
        </p>
        <a routerLink="/reportar" class="btn-outline border-gray-900 text-gray-900 hover:bg-gray-900 hover:text-white">
          Crear Reporte
        </a>
      </section>
    </div>

    <app-report-detail-modal [report]="selectedReport()" (closed)="selectedReport.set(null)" />
  `,
})
export class HomeComponent implements OnInit {
  private readonly pageSize = 9;

  loading        = signal(true);
  loadError      = signal(false);
  page           = signal<PageResponse<Report> | null>(null);
  currentPage    = signal(0);
  stats          = signal<Stats | null>(null);
  selectedReport = signal<Report | null>(null);

  steps = [
    { num: '1', title: 'Reporta',  color: '#ff6b6b', desc: 'Publica información sobre el animal perdido o encontrado con fotos y detalles.' },
    { num: '2', title: 'Conecta',  color: '#4ecdc4', desc: 'La comunidad busca coincidencias entre animales perdidos y encontrados.' },
    { num: '3', title: 'Reúne',    color: '#ffe66d', desc: 'Contacta directamente y ayuda a reunir a las familias con sus mascotas.' },
  ];

  constructor(
    private reportService: ReportService,
    private statsService: StatsService
  ) {}

  ngOnInit(): void {
    this.statsService.getStats().subscribe(s => this.stats.set(s));
    this.loadReports();
  }

  onPageChange(p: number): void {
    this.currentPage.set(p);
    this.loadReports();
    document.getElementById('reportes-recientes')?.scrollIntoView({ behavior: 'smooth' });
  }

  private loadReports(): void {
    this.loading.set(true);
    this.loadError.set(false);
    this.reportService.getReports({ page: this.currentPage(), size: this.pageSize }).subscribe({
      next: p => {
        this.page.set(p);
        this.loading.set(false);
      },
      error: () => {
        this.loading.set(false);
        this.loadError.set(true);
      },
    });
  }
}
