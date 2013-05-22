--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.5
-- Dumped by pg_dump version 9.1.5
-- Started on 2013-03-18 10:27:21

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = transaction, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 208 (class 1259 OID 49441)
-- Dependencies: 3383 3384 3385 3386 3387 3388 3389 10
-- Name: transaction; Type: TABLE; Schema: transaction; Owner: postgres; Tablespace: 
--

CREATE TABLE transaction (
    id character varying(40) NOT NULL,
    from_service_id character varying(40),
    status_code character varying(20) DEFAULT 'pending'::character varying NOT NULL,
    approval_datetime timestamp without time zone,
    bulk_generate_first_part boolean DEFAULT false NOT NULL,
    is_bulk_operation boolean DEFAULT false NOT NULL,
    rowidentifier character varying(40) DEFAULT public.uuid_generate_v1() NOT NULL,
    rowversion integer DEFAULT 0 NOT NULL,
    change_action character(1) DEFAULT 'i'::bpchar NOT NULL,
    change_user character varying(50),
    change_time timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE transaction.transaction OWNER TO postgres;

--
-- TOC entry 3406 (class 0 OID 0)
-- Dependencies: 208
-- Name: TABLE transaction; Type: COMMENT; Schema: transaction; Owner: postgres
--

COMMENT ON TABLE transaction IS 'Changes in the system come by transactions. A transaction is initiated (optionally) by a service. By introducing the concept of transaction it can be traced how the changes in the administrative schema came. Also by approving the transaction we can approve changes or by rejecting a transaction we can remove the pending changes that came with it and restore the previous state of the administrative schema.';


--
-- TOC entry 3401 (class 0 OID 49441)
-- Dependencies: 208 3402
-- Data for Name: transaction; Type: TABLE DATA; Schema: transaction; Owner: postgres
--

COPY transaction (id, from_service_id, status_code, approval_datetime, bulk_generate_first_part, is_bulk_operation, rowidentifier, rowversion, change_action, change_user, change_time) FROM stdin;
cadastre-transaction	\N	approved	2013-03-18 09:45:26.165	f	f	cc1f3724-8f9f-11e2-831e-6b51c1532276	1	i	test-id	2013-03-18 09:45:26.165
adm-transaction	\N	approved	2013-03-18 09:49:06.907	f	f	4fb38bb2-8fa0-11e2-9545-d31d30bdd274	1	i	test	2013-03-18 09:49:06.907
\.


--
-- TOC entry 3392 (class 2606 OID 49454)
-- Dependencies: 208 208 3403
-- Name: transaction_from_service_id_unique; Type: CONSTRAINT; Schema: transaction; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY transaction
    ADD CONSTRAINT transaction_from_service_id_unique UNIQUE (from_service_id);


--
-- TOC entry 3395 (class 2606 OID 49452)
-- Dependencies: 208 208 3403
-- Name: transaction_pkey; Type: CONSTRAINT; Schema: transaction; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (id);


--
-- TOC entry 3390 (class 1259 OID 50918)
-- Dependencies: 208 3403
-- Name: transaction_from_service_id_fk6_ind; Type: INDEX; Schema: transaction; Owner: postgres; Tablespace: 
--

CREATE INDEX transaction_from_service_id_fk6_ind ON transaction USING btree (from_service_id);


--
-- TOC entry 3393 (class 1259 OID 49455)
-- Dependencies: 208 3403
-- Name: transaction_index_on_rowidentifier; Type: INDEX; Schema: transaction; Owner: postgres; Tablespace: 
--

CREATE INDEX transaction_index_on_rowidentifier ON transaction USING btree (rowidentifier);


--
-- TOC entry 3396 (class 1259 OID 51044)
-- Dependencies: 208 3403
-- Name: transaction_status_code_fk27_ind; Type: INDEX; Schema: transaction; Owner: postgres; Tablespace: 
--

CREATE INDEX transaction_status_code_fk27_ind ON transaction USING btree (status_code);


--
-- TOC entry 3399 (class 2620 OID 49456)
-- Dependencies: 208 1161 3403
-- Name: __track_changes; Type: TRIGGER; Schema: transaction; Owner: postgres
--

CREATE TRIGGER __track_changes BEFORE INSERT OR UPDATE ON transaction FOR EACH ROW EXECUTE PROCEDURE public.f_for_trg_track_changes();


--
-- TOC entry 3400 (class 2620 OID 49462)
-- Dependencies: 208 1162 3403
-- Name: __track_history; Type: TRIGGER; Schema: transaction; Owner: postgres
--

CREATE TRIGGER __track_history AFTER DELETE OR UPDATE ON transaction FOR EACH ROW EXECUTE PROCEDURE public.f_for_trg_track_history();


--
-- TOC entry 3397 (class 2606 OID 50913)
-- Dependencies: 208 210 3403
-- Name: transaction_from_service_id_fk6; Type: FK CONSTRAINT; Schema: transaction; Owner: postgres
--

ALTER TABLE ONLY transaction
    ADD CONSTRAINT transaction_from_service_id_fk6 FOREIGN KEY (from_service_id) REFERENCES application.service(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3398 (class 2606 OID 51039)
-- Dependencies: 233 208 3403
-- Name: transaction_status_code_fk27; Type: FK CONSTRAINT; Schema: transaction; Owner: postgres
--

ALTER TABLE ONLY transaction
    ADD CONSTRAINT transaction_status_code_fk27 FOREIGN KEY (status_code) REFERENCES transaction_status_type(code) ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2013-03-18 10:27:23

--
-- PostgreSQL database dump complete
--

