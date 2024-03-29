CREATE DATABASE navigation WITH TEMPLATE = template0 ENCODING = 'UTF8' OWNED BY postgres;

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;;

SET search_path = public, pg_catalog;
SET default_tablespace = '';
SET default_with_oids = false;

CREATE TABLE navigation (
    node_id BIGINT NOT NULL,
    neighbors JSONB NOT NULL,
    PRIMARY KEY (node_id)
);
