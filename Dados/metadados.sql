/* Definition for the `GEN_PAIS_ID` generator :  */

CREATE GENERATOR GEN_PAIS_ID;

/* Structure for the `PAIS` table :  */

CREATE TABLE PAIS (
  ID INTEGER NOT NULL,
  NOME VARCHAR(32) NOT NULL);


ALTER TABLE PAIS ADD PRIMARY KEY (ID);