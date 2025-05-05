CREATE DOMAIN d_pass AS VARCHAR(30)
CHECK (
    LENGTH(VALUE) > 8 AND
    VALUE ~ '[A-Z]' AND
    VALUE ~ '[a-z]' AND
    VALUE ~ '[0-9]' AND
    VALUE ~ '[^A-Za-z0-9]'
);

Create domain d_ruolo AS VARCHAR(20)
CHECK (VALUE = 'Admin' OR VALUE = 'Sottoadmin');

Create domain d_tel AS VARCHAR(10)
CHECK (LENGTH(VALUE) = 10);

CREATE DOMAIN d_mail AS VARCHAR(255)
CHECK (POSITION('@' IN VALUE) > 0 AND POSITION('.' IN VALUE) > POSITION('@' IN VALUE));

CREATE DOMAIN d_pren AS VARCHAR(16)
CHECK (
    LENGTH(VALUE) = 16 AND
    VALUE ~ '[0-9]{6}$'
);

CREATE DOMAIN d_inser AS VARCHAR(14)
CHECK (
    LENGTH(VALUE) = 14 AND
    VALUE ~ '[0-9]{4}$'
);

Create domain d_agente AS VARCHAR(11)
CHECK (LENGTH(VALUE) = 11);

Create domain d_admin AS VARCHAR(9)
CHECK (LENGTH(VALUE) = 9);

Create domain d_catInser AS VARCHAR(10)
CHECK (VALUE = 'Vendita' OR VALUE = 'Affitto');

Create domain d_arred AS VARCHAR(20)
CHECK (VALUE = 'Completo' OR VALUE = 'Parziale' OR VALUE = 'No');

Create domain d_energ AS VARCHAR(20)
CHECK (VALUE = 'Alta' OR VALUE = 'Media' OR VALUE = 'Bassa' OR VALUE = 'Tutte');

Create domain d_stato AS VARCHAR(20)
CHECK (VALUE = 'Accettata' OR VALUE = 'Rifiutata' OR VALUE = 'Attesa');

Create domain d_formato AS VARCHAR(5)
CHECK (VALUE = 'png' OR VALUE = 'jpg' OR VALUE = 'jpeg');

Create domain d_dim AS FLOAT
CHECK (VALUE < 10001);

Create domain d_foto AS VARCHAR(20)
CHECK (VALUE = 'Planimetria' OR VALUE = 'Foto');