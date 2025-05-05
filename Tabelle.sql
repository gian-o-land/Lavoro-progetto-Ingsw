Create table Account_amministrativo(
	Username d_admin NOT NULL,
	Password d_pass NOT NULL,
	Ruolo d_ruolo NOT NULL,
	Admin_creatore d_admin,
	NomeAgenzia VARCHAR(20),
	CONSTRAINT Pk_admin PRIMARY KEY(Username),
	CONSTRAINT Fk_Creatore FOREIGN KEY(Creatore) REFERENCES Account_amministrativo(Username)
	ON DELETE SET NULL ON UPDATE CASCADE
);

Create table Agente(
	Username d_agente NOT NULL,
	Telefono d_tel NOT NULL,
	Password d_pass NOT  NULL,
	Email d_mail NOT NULL,
	Admin_creatore VARCHAR(20),
	CONSTRAINT Pk_agente PRIMARY KEY(Username),
	CONSTRAINT Fk_Creatore FOREIGN KEY(Creatore) REFERENCES Account_amministrativo(Username)
	ON DELETE SET NULL ON UPDATE CASCADE
);

Create table Inserzione(
	Id_inserzione d_inser NOT NULL,
	Quadratura INTEGER NOT NULL,
	N_Bagni INTEGER NOT NULL,
	N_Locali INTEGER NOT NULL,
	Piano INTEGER NOT NULL,
	Categoria d_catInser NOT NULL,
	Arredamento d_arred NOT NULL,
	Balcone BOOLEAN,
	Ascensore BOOLEAN,
	Terrazzo BOOLEAN,
	Cantina BOOLEAN,
	Piscina BOOLEAN,
	Cucina BOOLEAN,
	Prezzo FLOAT NOT NULL,
	Classe_energetica d_energ NOT NULL,
	Citta VARCHAR(50) NOT NULL,
	Comune VARCHAR(50) NOT NULL,
	Indirizzo VARCHAR(50) NOT NULL,
	Agente_creatore VARCHAR(20) NOT NULL,
	CONSTRAINT Pk_Inserzione PRIMARY KEY(Id_inserzione),
	CONSTRAINT Fk_agente FOREIGN KEY(Agente_creatore) REFERENCES Agente(Username)
	ON DELETE CASCADE ON UPDATE CASCADE
);

Create table Utente(
	Email d_mail NOT NULL,
	Telefono d_tel NOT NULL,
	Password d_pass NOT NULL,
	NomeCognome VARCHAR(50) NOT NULL,
	CONSTRAINT Pk_Utente PRIMARY KEY(Email)
);

Create table Prenotazione(
	Id_Prenotazione d_pren NOT NULL, 
	DataOra TIMESTAMP NOT NULL,
	Contenuto VARCHAR(300) NOT NULL,
	Stato d_stato NOT NULL,
	MailUtente d_mail NOT NULL,
	Codice_Inserzione d_inser NOT NULL,
	UsernameAgente VARCHAR(20) NOT NULL,
	CONSTRAINT Pk_Prenotazione PRIMARY KEY(Id_Prenotazione),
	CONSTRAINT Fk_Utente FOREIGN KEY(MailUtente) REFERENCES Utente(Email)
	ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT Fk_Inserzione FOREIGN KEY(Codice_Inserzione) REFERENCES Inserzione(Id_inserzione)
	ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT Fk_Agente FOREIGN KEY(UsernameAgente) REFERENCES Agente(Username)
	ON DELETE CASCADE ON UPDATE CASCADE
);

Create table Immagine(
	NomeFile VARCHAR(30) NOT NULL, 
	Formato d_formato NOT NULL,
	Dimensione d_dim NOT NULL,
	Categoria d_foto NOT NULL,
	Codice_Inserzione d_inser NOT NULL,
	CONSTRAINT Pk_foto PRIMARY KEY(NomeFile),
	CONSTRAINT Fk_Inserzione FOREIGN KEY(Codice_Inserzione) REFERENCES Inserzione(Id_inserzione)
	ON DELETE CASCADE ON UPDATE CASCADE
);
