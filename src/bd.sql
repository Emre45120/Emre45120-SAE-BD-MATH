CREATE TABLE VILLES (
  id_ville NUMBER PRIMARY KEY,
  nom_ville VARCHAR2(255),
  pays VARCHAR2(255)
);

CREATE TABLE AEROPORTS (
  id_aeroport NUMBER PRIMARY KEY,
  nom_aeroport VARCHAR2(255) UNIQUE
);

CREATE TABLE TERMINAUX (
  id_terminal NUMBER PRIMARY KEY,
  nom_terminal VARCHAR2(255),
  id_aeroport NUMBER,
  FOREIGN KEY (id_aeroport) REFERENCES AEROPORTS(id_aeroport)
);

CREATE TABLE VOLS (
  id_vol NUMBER PRIMARY KEY,
  compagnie VARCHAR2(255),
  numero VARCHAR2(255),
  date_depart TIMESTAMP
);

CREATE TABLE ITINERAIRES (
  id_itineraire NUMBER PRIMARY KEY,
  id_vol NUMBER,
  id_aeroport_depart NUMBER,
  id_aeroport_arrivee NUMBER,
  id_terminal_depart NUMBER,
  id_terminal_arrivee NUMBER,
  date_arrivee_prevue TIMESTAMP,
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

CREATE TYPE Liste_Indices_Qualite AS TABLE OF Indice_Qualite;

ALTER TABLE VOLS
ADD (
  Equipage Equipage_Tab,
  IndicesQualite Liste_Indices_Qualite
)
NESTED TABLE Equipage STORE AS Equipage_NT;

ALTER TABLE VOLS
ADD (
  IndicesQualite Liste_Indices_Qualite
)
NESTED TABLE IndicesQualite STORE AS IndicesQualite_NT;


 

