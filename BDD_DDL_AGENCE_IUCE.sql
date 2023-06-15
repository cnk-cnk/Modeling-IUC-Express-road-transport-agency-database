USE IUCE
GO

DROP TABLE IF EXISTS Client
CREATE TABLE Client (
identifiant_client int PRIMARY KEY, 
nom varchar(100) NOT NULL, 
pr�nom_1 varchar(100) NOT NULL, 
pr�nom_2 varchar(100), 
date_de_naissance date NOT NULL,
t�l�phone int NOT NULL, 
courriel varchar(100) NOT NULL, 
rue int NOT NULL,
adresse varchar(100) NOT NULL, 
code_postale varchar(100) NOT NULL, 
ville varchar(100) NOT NULL, 
pays varchar(100) NOT NULL
)

GO

DROP TABLE IF EXISTS Personnel
CREATE TABLE Personnel (
matricule varchar(100) PRIMARY KEY, 
nom varchar(100) NOT NULL, 
pr�nom_1 varchar(100) NOT NULL, 
pr�nom_2 varchar(100), 
date_de_naissance date NOT NULL,
t�l�phone int NOT NULL, 
courriel varchar(100) NOT NULL, 
rue int NOT NULL,
adresse varchar(100) NOT NULL, 
code_postale varchar(100) NOT NULL, 
ville varchar(100) NOT NULL, 
pays varchar(100) NOT NULL,
statut_marital varchar(100) NOT NULL, 
dipl�me_max varchar(100) NOT NULL
)

GO

DROP TABLE IF EXISTS Trajet
CREATE TABLE Trajet (
code_trajet varchar(100) PRIMARY KEY, 
lieu_d�part varchar(100) NOT NULL, 
lieu_arriv�e varchar(100) NOT NULL, 
dur�e varchar(100), 
prix money NOT NULL
)

GO

DROP TABLE IF EXISTS Facture
CREATE TABLE Facture (
num_facture varchar(100) PRIMARY KEY, 
date_facture date NOT NULL, 
date_r�glement date NOT NULL, 
identifiant_client int, 
matricule varchar(100),
CONSTRAINT FK_identifiant_client FOREIGN KEY (identifiant_client) REFERENCES
Client (identifiant_client),
CONSTRAINT FK_matricule FOREIGN KEY (matricule) REFERENCES
Personnel (matricule)
)

GO

DROP TABLE IF EXISTS Billet
CREATE TABLE Billet (
num_billet varchar(100) PRIMARY KEY, 
date_d�part date NOT NULL, 
date_arriv�e date NOT NULL, 
heure_d�part time NOT NULL,
num_v�hicule varchar(100) NOT NULL,
num_place varchar(100) NOT NULL,
num_facture varchar(100), 
code_trajet varchar(100),
CONSTRAINT FK_num_facture FOREIGN KEY (num_facture) REFERENCES
Facture (num_facture),
CONSTRAINT FK_code_trajet FOREIGN KEY (code_trajet) REFERENCES
Trajet (code_trajet)
)

GO

DROP TABLE IF EXISTS Fonction
CREATE TABLE Fonction (
code_fonction varchar(100) PRIMARY KEY, 
nom_fonction varchar(100) NOT NULL, 
grade varchar(100) NOT NULL
)

GO

DROP TABLE IF EXISTS Site
CREATE TABLE Site (
code_site varchar(100) PRIMARY KEY, 
lieu_site varchar(100) NOT NULL, 
)

GO

DROP TABLE IF EXISTS Occuper
CREATE TABLE Occuper (
date_d�but_occupation date NOT NULL, 
code_fonction varchar(100),
matricule varchar(100),
PRIMARY KEY (matricule, date_d�but_occupation),
CONSTRAINT FK_matricule2 FOREIGN KEY (matricule) REFERENCES
Personnel (matricule),
CONSTRAINT FK_code_fonction FOREIGN KEY (code_fonction) REFERENCES
Fonction (code_fonction),
)

GO

DROP TABLE IF EXISTS Affecter
CREATE TABLE Affecter (
date_d�but_affectation date NOT NULL, 
date_fin_affectation date NOT NULL, 
code_site varchar(100),
matricule varchar(100),
PRIMARY KEY (matricule, date_d�but_affectation),
CONSTRAINT FK_matricule3 FOREIGN KEY (matricule) REFERENCES
Personnel (matricule),
CONSTRAINT FK_code_site FOREIGN KEY (code_site) REFERENCES
Site (code_site),
)

GO

DROP TABLE IF EXISTS Contrat
CREATE TABLE Contrat (
code_contrat varchar(100) PRIMARY KEY, 
libell�_contrat varchar(100) NOT NULL, 
)

GO

DROP TABLE IF EXISTS Attacher
CREATE TABLE Attacher (
date_d�but_contrat date NOT NULL, 
date_fin_contrat date,
num_contrat varchar(100) NOT NULL,
jour_cong�_acquis int NOT NULL,
code_contrat varchar(100),
matricule varchar(100),
PRIMARY KEY (matricule, date_d�but_contrat),
CONSTRAINT FK_matricule4 FOREIGN KEY (matricule) REFERENCES
Personnel (matricule),
CONSTRAINT FK_code_contrat FOREIGN KEY (code_contrat) REFERENCES
Contrat (code_contrat)
)

GO

DROP TABLE IF EXISTS Demande
CREATE TABLE Demande (
num_demande int PRIMARY KEY, 
date_cr�ation date NOT NULL,
statut int NOT NULL,
sanction int NOT NULL,
commentaire_demandeur varchar(max),
commentaire_valideur varchar(max),
matricule  varchar(100),
CONSTRAINT FK_matricule5 FOREIGN KEY (matricule) REFERENCES
Personnel (matricule)
)

GO

DROP TABLE IF EXISTS Cong�s_Absences
CREATE TABLE Cong�s_Absences (
code_cong_abs varchar(100) PRIMARY KEY, 
libell� varchar(100) NOT NULL, 
)

GO

DROP TABLE IF EXISTS Lier
CREATE TABLE Lier (
date_heure_d�but datetime NOT NULL,
date_heure_fin datetime NOT NULL, 
num_demande int,
code_cong_abs varchar(100),
PRIMARY KEY (num_demande, date_heure_d�but),
CONSTRAINT FK_num_demande FOREIGN KEY (num_demande) REFERENCES
Demande (num_demande),
CONSTRAINT FK_code_cong_abs FOREIGN KEY (code_cong_abs) REFERENCES
Cong�s_Absences (code_cong_abs)
)