CREATE TABLE Societe (
    id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL
);

CREATE TABLE Utilisateur (
    id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nom VARCHAR(20) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    societe_id INTEGER NOT NULL,
    FOREIGN KEY (societe_id) REFERENCES Societe(id) ON DELETE CASCADE
);

CREATE TABLE Tache (
    id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    createur_id INTEGER NOT NULL,
    titre VARCHAR(255) NOT NULL,
    description TEXT,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_deadline TIMESTAMP,
    date_completion TIMESTAMP NULL,
    etat VARCHAR(20) CHECK (etat IN ('en attente', 'complétée')) DEFAULT 'en attente',
    FOREIGN KEY (createur_id) REFERENCES Utilisateur(id) ON DELETE CASCADE
);

CREATE TABLE Tache_Assignee (
    tache_id INTEGER NOT NULL,
    utilisateur_id INT NOT NULL,
    role VARCHAR(20) CHECK (role IN ('Responsable', 'Relecteur', 'Suiveur')),
    PRIMARY KEY (tache_id, utilisateur_id, role),
    FOREIGN KEY (tache_id) REFERENCES Tache(id) ON DELETE CASCADE,
    FOREIGN KEY (utilisateur_id) REFERENCES Utilisateur(id) ON DELETE CASCADE
);

CREATE TABLE Commentaire (
    id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    tache_id INTEGER NOT NULL,
    utilisateur_id INT NOT NULL,
    texte TEXT NOT NULL,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (tache_id) REFERENCES Tache(id) ON DELETE CASCADE,
    FOREIGN KEY (utilisateur_id) REFERENCES Utilisateur(id) ON DELETE CASCADE
);

CREATE TABLE Tache_Liaison (
    tache_id INTEGER NOT NULL,
    tache_liee_id INTEGER NOT NULL,
    PRIMARY KEY (tache_id, tache_liee_id),
    FOREIGN KEY (tache_id) REFERENCES Tache(id) ON DELETE CASCADE,
    FOREIGN KEY (tache_liee_id) REFERENCES Tache(id) ON DELETE CASCADE
);
