-- =========================
-- Ajout des champs d'authentification et d'administration
-- =========================

-- Ajout du champ d'administration pour les employés
ALTER TABLE EMPLOYE 
    ADD COLUMN ADMIN_PRIVILEGE BOOLEAN DEFAULT FALSE;

-- Ajout des champs d'authentification pour EMPLOYE
ALTER TABLE EMPLOYE
    ADD COLUMN NOM_UTILISATEUR VARCHAR(255);

ALTER TABLE EMPLOYE
    ADD COLUMN EMAIL_AUTH VARCHAR(255) UNIQUE;

ALTER TABLE EMPLOYE
    ADD COLUMN MOT_DE_PASSE VARCHAR(255) NOT NULL;

-- Ajout des champs d'authentification pour CITOYEN
ALTER TABLE CITOYEN
    ADD COLUMN NOM_UTILISATEUR VARCHAR(255);

ALTER TABLE CITOYEN
    ADD COLUMN EMAIL_AUTH VARCHAR(255) UNIQUE;

-- Ajout des champs d'authentification pour TECHNICIEN
ALTER TABLE TECHNICIEN
    ADD COLUMN NOM_UTILISATEUR VARCHAR(255);

ALTER TABLE TECHNICIEN
    ADD COLUMN EMAIL_AUTH VARCHAR(255) UNIQUE;

ALTER TABLE TECHNICIEN
    ADD COLUMN MOT_DE_PASSE VARCHAR(255) NOT NULL;

-- =========================
-- Fin de migration
-- =========================
