--
-- PostgreSQL database dump
--

\restrict I9rHeH58svpXCY3nACdU2i9miuhDNBjtm6ldcfaOh09sR8IPeS0qz2Ltpxqb04u

-- Dumped from database version 17.6
-- Dumped by pg_dump version 18.2

-- Started on 2026-03-18 16:04:31

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 871 (class 1247 OID 16502)
-- Name: d_admin; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.d_admin AS character varying(9)
	CONSTRAINT d_admin_check CHECK ((length((VALUE)::text) = 9));


ALTER DOMAIN public.d_admin OWNER TO postgres;

--
-- TOC entry 867 (class 1247 OID 16499)
-- Name: d_agente; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.d_agente AS character varying(11)
	CONSTRAINT d_agente_check CHECK ((length((VALUE)::text) = 11));


ALTER DOMAIN public.d_agente OWNER TO postgres;

--
-- TOC entry 910 (class 1247 OID 16690)
-- Name: d_arred; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.d_arred AS character varying(15)
	CONSTRAINT d_arred_check CHECK (((VALUE)::text = ANY ((ARRAY['COMPLETO'::character varying, 'PARZIALE'::character varying, 'NO'::character varying])::text[])));


ALTER DOMAIN public.d_arred OWNER TO postgres;

--
-- TOC entry 906 (class 1247 OID 16677)
-- Name: d_catinser; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.d_catinser AS character varying(15)
	CONSTRAINT d_catinser_check CHECK (((VALUE)::text = ANY ((ARRAY['VENDITA'::character varying, 'AFFITTO'::character varying])::text[])));


ALTER DOMAIN public.d_catinser OWNER TO postgres;

--
-- TOC entry 883 (class 1247 OID 16520)
-- Name: d_dim; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.d_dim AS double precision
	CONSTRAINT d_dim_check CHECK ((VALUE < (10001)::double precision));


ALTER DOMAIN public.d_dim OWNER TO postgres;

--
-- TOC entry 914 (class 1247 OID 16699)
-- Name: d_energ; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.d_energ AS character varying(10)
	CONSTRAINT d_energ_check CHECK (((VALUE)::text = ANY ((ARRAY['BASSA'::character varying, 'ALTA'::character varying, 'MEDIA'::character varying])::text[])));


ALTER DOMAIN public.d_energ OWNER TO postgres;

--
-- TOC entry 879 (class 1247 OID 16517)
-- Name: d_formato; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.d_formato AS character varying(5)
	CONSTRAINT d_formato_check CHECK ((((VALUE)::text = 'png'::text) OR ((VALUE)::text = 'jpg'::text) OR ((VALUE)::text = 'jpeg'::text)));


ALTER DOMAIN public.d_formato OWNER TO postgres;

--
-- TOC entry 918 (class 1247 OID 16708)
-- Name: d_foto; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.d_foto AS character varying(15)
	CONSTRAINT d_foto_check CHECK (((VALUE)::text = ANY ((ARRAY['PLANIMETRIA'::character varying, 'FOTO'::character varying])::text[])));


ALTER DOMAIN public.d_foto OWNER TO postgres;

--
-- TOC entry 902 (class 1247 OID 16616)
-- Name: d_inser; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.d_inser AS character varying(6)
	CONSTRAINT d_inser_check CHECK ((length((VALUE)::text) = 6));


ALTER DOMAIN public.d_inser OWNER TO postgres;

--
-- TOC entry 859 (class 1247 OID 16490)
-- Name: d_mail; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.d_mail AS character varying(255)
	CONSTRAINT d_mail_check CHECK (((VALUE)::text ~~ '%_@_%._%'::text));


ALTER DOMAIN public.d_mail OWNER TO postgres;

--
-- TOC entry 863 (class 1247 OID 16493)
-- Name: d_pren; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.d_pren AS character varying(16)
	CONSTRAINT d_pren_check CHECK (((length((VALUE)::text) = 16) AND ((VALUE)::text ~ '[0-9]{6}$'::text)));


ALTER DOMAIN public.d_pren OWNER TO postgres;

--
-- TOC entry 851 (class 1247 OID 16484)
-- Name: d_ruolo; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.d_ruolo AS character varying(20)
	CONSTRAINT d_ruolo_check CHECK ((((VALUE)::text = 'ADMIN'::text) OR ((VALUE)::text = 'SOTTOADMIN'::text)));


ALTER DOMAIN public.d_ruolo OWNER TO postgres;

--
-- TOC entry 875 (class 1247 OID 16514)
-- Name: d_stato; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.d_stato AS character varying(20)
	CONSTRAINT d_stato_check CHECK (((VALUE)::text = ANY (ARRAY['ACCETTATA'::text, 'RIFIUTATA'::text, 'ATTESA'::text])));


ALTER DOMAIN public.d_stato OWNER TO postgres;

--
-- TOC entry 855 (class 1247 OID 16487)
-- Name: d_tel; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.d_tel AS character varying(10)
	CONSTRAINT d_tel_check CHECK ((length((VALUE)::text) = 10));


ALTER DOMAIN public.d_tel OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 16525)
-- Name: account_amministrativo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_amministrativo (
    username public.d_admin NOT NULL,
    password character varying(255) NOT NULL,
    ruolo public.d_ruolo NOT NULL,
    admin_creatore public.d_admin,
    nomeagenzia character varying(20)
);


ALTER TABLE public.account_amministrativo OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16537)
-- Name: agente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agente (
    username character varying(20) NOT NULL,
    telefono character varying(10) NOT NULL,
    password character varying(255) NOT NULL,
    email public.d_mail NOT NULL,
    selectedprefix character varying(5) NOT NULL,
    admin_creatore character varying(20),
    nome character varying(20) DEFAULT ''::character varying,
    cognome character varying(20) DEFAULT ''::character varying,
    nomeagenzia character varying(20),
    CONSTRAINT chk_telefono_lunghezza CHECK ((length((telefono)::text) = 10))
);


ALTER TABLE public.agente OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16710)
-- Name: immagine; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.immagine (
    id_inserzione character varying(10),
    url character varying(150) NOT NULL,
    tipologia public.d_foto
);


ALTER TABLE public.immagine OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16550)
-- Name: inserzione; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inserzione (
    id_inserzione public.d_inser NOT NULL,
    quadratura integer NOT NULL,
    n_bagni integer NOT NULL,
    n_locali integer NOT NULL,
    piano integer NOT NULL,
    categoria public.d_catinser NOT NULL,
    balcone boolean,
    ascensore boolean,
    terrazzo boolean,
    cantina boolean,
    piscina boolean,
    cucina boolean,
    prezzo double precision NOT NULL,
    citta character varying(50) NOT NULL,
    comune character varying(50) NOT NULL,
    indirizzo character varying(50) NOT NULL,
    agente_creatore character varying(20) NOT NULL,
    latitudine double precision,
    longitudine double precision,
    arredamento public.d_arred,
    classe_energetica public.d_energ,
    descrizione character varying(500) DEFAULT ''::character varying
);


ALTER TABLE public.inserzione OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16570)
-- Name: prenotazione; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prenotazione (
    id_prenotazione public.d_pren NOT NULL,
    dataora timestamp without time zone NOT NULL,
    contenuto character varying(300) NOT NULL,
    stato public.d_stato NOT NULL,
    mailutente public.d_mail NOT NULL,
    codice_inserzione public.d_inser NOT NULL,
    usernameagente character varying(20) NOT NULL,
    data_creazione timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.prenotazione OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16562)
-- Name: utente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utente (
    email public.d_mail NOT NULL,
    selectedprefix character varying(5) NOT NULL,
    telefono public.d_tel NOT NULL,
    password character varying(255) NOT NULL,
    nome character varying(20) DEFAULT ''::character varying,
    cognome character varying(20) DEFAULT ''::character varying,
    is_google boolean DEFAULT false,
    CONSTRAINT chk_prefisso CHECK (((selectedprefix)::text = ANY ((ARRAY['+39'::character varying, '+44'::character varying, '+1'::character varying, '+49'::character varying, '+33'::character varying, '+34'::character varying])::text[])))
);


ALTER TABLE public.utente OWNER TO postgres;

--
-- TOC entry 4242 (class 2606 OID 16716)
-- Name: immagine immagine_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.immagine
    ADD CONSTRAINT immagine_pkey PRIMARY KEY (url);


--
-- TOC entry 4232 (class 2606 OID 16531)
-- Name: account_amministrativo pk_admin; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_amministrativo
    ADD CONSTRAINT pk_admin PRIMARY KEY (username);


--
-- TOC entry 4234 (class 2606 OID 16750)
-- Name: agente pk_agente; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agente
    ADD CONSTRAINT pk_agente PRIMARY KEY (username);


--
-- TOC entry 4236 (class 2606 OID 16619)
-- Name: inserzione pk_inserzione; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inserzione
    ADD CONSTRAINT pk_inserzione PRIMARY KEY (id_inserzione);


--
-- TOC entry 4240 (class 2606 OID 16576)
-- Name: prenotazione pk_prenotazione; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prenotazione
    ADD CONSTRAINT pk_prenotazione PRIMARY KEY (id_prenotazione);


--
-- TOC entry 4238 (class 2606 OID 16569)
-- Name: utente pk_utente; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utente
    ADD CONSTRAINT pk_utente PRIMARY KEY (email);


--
-- TOC entry 4245 (class 2606 OID 16751)
-- Name: inserzione fk_agente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inserzione
    ADD CONSTRAINT fk_agente FOREIGN KEY (agente_creatore) REFERENCES public.agente(username) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4246 (class 2606 OID 16756)
-- Name: prenotazione fk_agente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prenotazione
    ADD CONSTRAINT fk_agente FOREIGN KEY (usernameagente) REFERENCES public.agente(username) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4243 (class 2606 OID 16532)
-- Name: account_amministrativo fk_creatore; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_amministrativo
    ADD CONSTRAINT fk_creatore FOREIGN KEY (admin_creatore) REFERENCES public.account_amministrativo(username) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 4244 (class 2606 OID 16545)
-- Name: agente fk_creatore; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agente
    ADD CONSTRAINT fk_creatore FOREIGN KEY (admin_creatore) REFERENCES public.account_amministrativo(username) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 4247 (class 2606 OID 16636)
-- Name: prenotazione fk_inserzione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prenotazione
    ADD CONSTRAINT fk_inserzione FOREIGN KEY (codice_inserzione) REFERENCES public.inserzione(id_inserzione) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4248 (class 2606 OID 16577)
-- Name: prenotazione fk_utente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prenotazione
    ADD CONSTRAINT fk_utente FOREIGN KEY (mailutente) REFERENCES public.utente(email) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2026-03-18 16:04:36

--
-- PostgreSQL database dump complete
--

\unrestrict I9rHeH58svpXCY3nACdU2i9miuhDNBjtm6ldcfaOh09sR8IPeS0qz2Ltpxqb04u

