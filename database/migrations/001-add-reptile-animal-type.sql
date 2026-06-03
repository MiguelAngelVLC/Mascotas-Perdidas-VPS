-- Migration 001: Add REPTILE to animal_type enum
-- Run this on any existing database (VPS) before deploying the new backend.

ALTER TABLE reports
  MODIFY COLUMN animal_type
  ENUM('DOG','CAT','BIRD','REPTILE','OTHER') NOT NULL DEFAULT 'OTHER';
