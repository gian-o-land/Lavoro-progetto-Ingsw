--1
CREATE OR REPLACE FUNCTION controllo_nuova_password()
RETURNS TRIGGER AS $controllo_nuova_password$
BEGIN
    -- Controllo se la nuova password è uguale alla vecchia
    IF NEW.password = OLD.password THEN
        RAISE EXCEPTION 'La nuova password non può essere uguale a quella precedente.';
    END IF;
    RETURN NEW; -- Restituisci la riga aggiornata
END;
$controllo_nuova_password$ LANGUAGE plpgsql;

-- Creazione del trigger associato alla funzione
CREATE  OR REPLACE TRIGGER controllo_nuova_password_admin 
BEFORE UPDATE OF password ON Account_amministrativo
FOR EACH ROW
EXECUTE FUNCTION controllo_nuova_password();

CREATE  OR REPLACE TRIGGER controllo_nuova_password_agente 
BEFORE UPDATE OF password ON Agente
FOR EACH ROW
EXECUTE FUNCTION controllo_nuova_password();

CREATE  OR REPLACE TRIGGER controllo_nuova_password_utente 
BEFORE UPDATE OF password ON Utente
FOR EACH ROW
EXECUTE FUNCTION controllo_nuova_password();


--2
CREATE OR REPLACE FUNCTION controllo_nuova_mail()
RETURNS TRIGGER AS $controllo_nuova_mail$
BEGIN
    -- Controllo se la nuova mail è uguale alla vecchia
    IF NEW.Email = OLD.Email THEN
        RAISE EXCEPTION 'La nuova mail non può essere uguale a quella precedente.';
    END IF;
    RETURN NEW; -- Restituisci la riga aggiornata
END;
$controllo_nuova_mail$ LANGUAGE plpgsql;

-- Creazione del trigger associato alla funzione
CREATE  OR REPLACE TRIGGER controllo_nuova_mail_agente 
BEFORE UPDATE OF Email ON Agente
FOR EACH ROW
EXECUTE FUNCTION controllo_nuova_mail();

CREATE  OR REPLACE TRIGGER controllo_nuova_mail_Utente
BEFORE UPDATE OF Email ON Utente
FOR EACH ROW
EXECUTE FUNCTION controllo_nuova_mail();


--3
CREATE OR REPLACE FUNCTION controllo_nuovo_telefono()
RETURNS TRIGGER AS $controllo_nuovo_telefono$
BEGIN
    -- Controllo se il nuovo numero di telefono è uguale alla vecchia
    IF NEW.Telefono = OLD.Telefono THEN
        RAISE EXCEPTION 'Il nuovo numero di telefono non può essere uguale al precedente.';
    END IF;
    RETURN NEW; -- Restituisci la riga aggiornata
END;
$controllo_nuovo_telefono$ LANGUAGE plpgsql;

-- Creazione del trigger associato alla funzione
CREATE  OR REPLACE TRIGGER controllo_nuovo_telefono_agente 
BEFORE UPDATE OF Telefono ON Agente
FOR EACH ROW
EXECUTE FUNCTION controllo_nuovo_telefono();

CREATE  OR REPLACE TRIGGER controllo_nuovo_telefono_Utente
BEFORE UPDATE OF Telefono ON Utente
FOR EACH ROW
EXECUTE FUNCTION controllo_nuovo_telefono();


--4
CREATE OR REPLACE FUNCTION controllo_prenotazione()
RETURNS TRIGGER AS $controllo_prenotazione$
BEGIN
	IF EXISTS (SELECT * FROM Prenotazione WHERE NEW.Id_prenotazione != Id_prenotazione AND
			  									NEW.Codice_Inserzione = Codice_Inserzione AND
			  									NEW.DataOra = DataOra AND Stato = 'Accettata') THEN
				RAISE EXCEPTION 'Non è possibile effettuare una prenotazione in quella data e ora';
	END IF;
	RETURN NEW;
END;
$controllo_prenotazione$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER controllo_prenotazione
BEFORE INSERT ON Prenotazione
FOR EACH ROW
EXECUTE FUNCTION controllo_prenotazione();