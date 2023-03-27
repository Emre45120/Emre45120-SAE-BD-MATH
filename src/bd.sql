DROP TABLE IF EXISTS ITINERAIRES;
DROP TABLE IF EXISTS VOLS;
DROP TABLE IF EXISTS TERMINAUX;
DROP TABLE IF EXISTS AEROPORTS;
DROP TABLE IF EXISTS VILLES;

CREATE TABLE VOLS (
  id_vol INT PRIMARY KEY,
  compagnie VARCHAR(255),
  numero VARCHAR(255),
  date_depart DATETIME
);

CREATE TABLE AEROPORTS (
  id_aeroport INT PRIMARY KEY,
  nom_aeroport VARCHAR(255) UNIQUE
);

CREATE TABLE VILLES (
  id_ville INT PRIMARY KEY,
  nom_ville VARCHAR(255),
  pays VARCHAR(255)
);

CREATE TABLE TERMINAUX (
  id_terminal INT PRIMARY KEY,
  nom_terminal VARCHAR(255),
  id_aeroport INT,
  FOREIGN KEY (id_aeroport) REFERENCES AEROPORTS(id_aeroport)
);

CREATE TABLE ITINERAIRES (
  id_itineraire INT PRIMARY KEY,
  id_vol INT,
  id_aeroport_depart INT,
  id_aeroport_arrivee INT,
  id_terminal_depart INT,
  id_terminal_arrivee INT,
  date_arrivee_prevue DATETIME,
  FOREIGN KEY (id_vol) REFERENCES VOLS(id_vol),
  FOREIGN KEY (id_aeroport_depart) REFERENCES AEROPORTS(id_aeroport),
  FOREIGN KEY (id_aeroport_arrivee) REFERENCES AEROPORTS(id_aeroport),
  FOREIGN KEY (id_terminal_depart) REFERENCES TERMINAUX(id_terminal),
  FOREIGN KEY (id_terminal_arrivee) REFERENCES TERMINAUX(id_terminal)
);

CREATE TYPE Membre_Equipage AS OBJECT (
  nom VARCHAR2(255),
  fonction VARCHAR2(255)
);

CREATE TYPE Equipage_Tab AS TABLE OF Membre_Equipage;

CREATE TYPE Indice_Qualite AS OBJECT (
  type_indice VARCHAR2(255),
  note NUMBER(3, 1),
  poids NUMBER(3, 1)
);

ALTER TABLE VOLS
ADD (
  Equipage Equipage_Tab,
  IndicesQualite Liste_Indices_Qualite
)
NESTED TABLE Equipage STORE AS Equipage_NT;

 

