--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--


--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0
-- Dumped by pg_dump version 16.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0
-- Dumped by pg_dump version 16.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

--
-- Database "taka_the_discord_bot" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0
-- Dumped by pg_dump version 16.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: taka_the_discord_bot; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE taka_the_discord_bot WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LC_COLLATE = 'C' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE taka_the_discord_bot OWNER TO postgres;

\connect taka_the_discord_bot

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: sillycommandimage; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.sillycommandimage AS (
	image character varying(256),
	associated_genders character varying(32)
);


ALTER TYPE public.sillycommandimage OWNER TO postgres;

--
-- Name: sillycommandselfimage; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.sillycommandselfimage AS (
	image character varying(256)
);


ALTER TYPE public.sillycommandselfimage OWNER TO postgres;

--
-- Name: sillycommandusage; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.sillycommandusage AS (
	user_1 bigint,
	user_2 bigint,
	usage_count integer
);


ALTER TYPE public.sillycommandusage OWNER TO postgres;

--
-- Name: sillycommandsingleuserdata; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.sillycommandsingleuserdata AS (
	images public.sillycommandimage[],
	texts text[],
	usages public.sillycommandusage[]
);


ALTER TYPE public.sillycommandsingleuserdata OWNER TO postgres;

--
-- Name: sillycommand; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.sillycommand AS (
	id_command integer,
	command_name character varying(64),
	description text,
	command_type character varying(64),
	self_images public.sillycommandselfimage[],
	self_texts text[],
	associated_genders character varying(32)[],
	single_user_data public.sillycommandsingleuserdata,
	footer_text text
);


ALTER TYPE public.sillycommand OWNER TO postgres;

--
-- Name: sillycommandtype; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.sillycommandtype AS ENUM (
    'AUTHOR_ONLY',
    'SINGLE_USER'
);


ALTER TYPE public.sillycommandtype OWNER TO postgres;

--
-- Name: delete_silly_command(integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.delete_silly_command(IN command_id integer)
    LANGUAGE sql
    AS $$
DELETE FROM silly_command_images WHERE id_silly_command = COMMAND_ID;
DELETE FROM silly_command_texts WHERE id_silly_command = COMMAND_ID;
DELETE FROM silly_command_self_action_texts WHERE id_silly_command = COMMAND_ID;
DELETE FROM silly_command_self_action_images WHERE id_silly_command = COMMAND_ID;
DELETE FROM silly_command_usage WHERE id_silly_command = COMMAND_ID;
DELETE FROM silly_commands WHERE id_silly_command = COMMAND_ID;
$$;


ALTER PROCEDURE public.delete_silly_command(IN command_id integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: silly_command_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.silly_command_images (
    id_silly_command_images integer NOT NULL,
    id_silly_command integer NOT NULL,
    image character varying(255) NOT NULL,
    gender_attribute character varying(64) DEFAULT 'ALL'::character varying NOT NULL
);


ALTER TABLE public.silly_command_images OWNER TO postgres;

--
-- Name: silly_command_self_action_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.silly_command_self_action_images (
    id_silly_command_self_action integer NOT NULL,
    id_silly_command integer NOT NULL,
    image character varying(255) NOT NULL
);


ALTER TABLE public.silly_command_self_action_images OWNER TO postgres;

--
-- Name: silly_command_self_action_texts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.silly_command_self_action_texts (
    id_silly_command_self_action_text integer NOT NULL,
    id_silly_command integer NOT NULL,
    text character varying(1024) NOT NULL
);


ALTER TABLE public.silly_command_self_action_texts OWNER TO postgres;

--
-- Name: silly_command_texts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.silly_command_texts (
    id_silly_command_text integer NOT NULL,
    id_silly_command integer NOT NULL,
    text character varying(1024) NOT NULL
);


ALTER TABLE public.silly_command_texts OWNER TO postgres;

--
-- Name: silly_commands; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.silly_commands (
    id_silly_command integer NOT NULL,
    name character varying(100) NOT NULL,
    command_type integer NOT NULL,
    description character varying(100) DEFAULT 'No description has been set'::character varying,
    gender_attributes character varying[] DEFAULT ARRAY[]::character varying[],
    footer_text text
);


ALTER TABLE public.silly_commands OWNER TO postgres;

--
-- Name: silly_command_data; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.silly_command_data AS
 SELECT silly_commands.id_silly_command,
    silly_commands.name,
    silly_commands.command_type,
    silly_commands.description,
    string_agg(DISTINCT (silly_command_texts.text)::text, 'ß'::text) AS text,
    string_agg(DISTINCT (silly_command_images.image)::text, 'ß'::text) AS image,
    string_agg(DISTINCT (silly_command_self_action_texts.text)::text, 'ß'::text) AS self_text,
    string_agg(DISTINCT (silly_command_self_action_images.image)::text, 'ß'::text) AS self_image
   FROM ((((public.silly_commands
     LEFT JOIN public.silly_command_texts ON ((silly_command_texts.id_silly_command = silly_commands.id_silly_command)))
     LEFT JOIN public.silly_command_images ON ((silly_command_images.id_silly_command = silly_commands.id_silly_command)))
     LEFT JOIN public.silly_command_self_action_texts ON ((silly_command_self_action_texts.id_silly_command = silly_commands.id_silly_command)))
     LEFT JOIN public.silly_command_self_action_images ON ((silly_command_self_action_images.id_silly_command = silly_commands.id_silly_command)))
  GROUP BY silly_commands.id_silly_command, silly_commands.name, silly_commands.command_type, silly_commands.description;


ALTER VIEW public.silly_command_data OWNER TO postgres;

--
-- Name: silly_command_images_id_silly_command_images_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.silly_command_images_id_silly_command_images_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.silly_command_images_id_silly_command_images_seq OWNER TO postgres;

--
-- Name: silly_command_images_id_silly_command_images_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.silly_command_images_id_silly_command_images_seq OWNED BY public.silly_command_images.id_silly_command_images;


--
-- Name: silly_command_new; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.silly_command_new (
    id_silly_command integer NOT NULL,
    name character varying(100) NOT NULL,
    command_type integer NOT NULL,
    description character varying(100) DEFAULT 'No description has been set'::character varying,
    gender_attributes character varying[] DEFAULT '{}'::character varying[],
    footer_text text NOT NULL
);


ALTER TABLE public.silly_command_new OWNER TO postgres;

--
-- Name: silly_command_new_id_command_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.silly_command_new_id_command_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.silly_command_new_id_command_seq OWNER TO postgres;

--
-- Name: silly_command_new_id_silly_command_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.silly_command_new_id_silly_command_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.silly_command_new_id_silly_command_seq OWNER TO postgres;

--
-- Name: silly_command_new_id_silly_command_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.silly_command_new_id_silly_command_seq OWNED BY public.silly_command_new.id_silly_command;


--
-- Name: silly_command_self_action_tex_id_silly_command_self_action__seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.silly_command_self_action_tex_id_silly_command_self_action__seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.silly_command_self_action_tex_id_silly_command_self_action__seq OWNER TO postgres;

--
-- Name: silly_command_self_action_tex_id_silly_command_self_action__seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.silly_command_self_action_tex_id_silly_command_self_action__seq OWNED BY public.silly_command_self_action_texts.id_silly_command_self_action_text;


--
-- Name: silly_command_self_actions_id_silly_command_self_action_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.silly_command_self_actions_id_silly_command_self_action_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.silly_command_self_actions_id_silly_command_self_action_seq OWNER TO postgres;

--
-- Name: silly_command_self_actions_id_silly_command_self_action_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.silly_command_self_actions_id_silly_command_self_action_seq OWNED BY public.silly_command_self_action_images.id_silly_command_self_action;


--
-- Name: silly_command_texts_id_silly_command_text_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.silly_command_texts_id_silly_command_text_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.silly_command_texts_id_silly_command_text_seq OWNER TO postgres;

--
-- Name: silly_command_texts_id_silly_command_text_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.silly_command_texts_id_silly_command_text_seq OWNED BY public.silly_command_texts.id_silly_command_text;


--
-- Name: silly_command_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.silly_command_type (
    id_silly_command_type integer NOT NULL,
    name character varying(40) NOT NULL
);


ALTER TABLE public.silly_command_type OWNER TO postgres;

--
-- Name: silly_command_type_id_silly_command_type_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.silly_command_type_id_silly_command_type_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.silly_command_type_id_silly_command_type_seq OWNER TO postgres;

--
-- Name: silly_command_type_id_silly_command_type_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.silly_command_type_id_silly_command_type_seq OWNED BY public.silly_command_type.id_silly_command_type;


--
-- Name: silly_command_usage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.silly_command_usage (
    id_silly_command_usage integer NOT NULL,
    id_silly_command integer NOT NULL,
    id_user_1 character varying(30) NOT NULL,
    id_user_2 character varying(30) NOT NULL,
    usages integer NOT NULL
);


ALTER TABLE public.silly_command_usage OWNER TO postgres;

--
-- Name: silly_command_usage_id_silly_command_usage_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.silly_command_usage_id_silly_command_usage_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.silly_command_usage_id_silly_command_usage_seq OWNER TO postgres;

--
-- Name: silly_command_usage_id_silly_command_usage_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.silly_command_usage_id_silly_command_usage_seq OWNED BY public.silly_command_usage.id_silly_command_usage;


--
-- Name: silly_commands_data_new; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.silly_commands_data_new AS
 SELECT silly_commands.id_silly_command,
    silly_commands.name,
    silly_commands.command_type,
    silly_commands.description,
    silly_commands.gender_attributes,
    silly_commands.footer_text,
    silly_command_images.id_images,
    silly_command_images.images,
    silly_command_images.preferences,
    silly_command_texts.id_texts,
    silly_command_texts.texts,
    silly_command_self_action_images.id_self_images,
    silly_command_self_action_images.self_images,
    silly_command_self_action_texts.id_self_texts,
    silly_command_self_action_texts.self_texts
   FROM ((((public.silly_commands
     LEFT JOIN ( SELECT silly_command_images_1.id_silly_command,
            array_agg(silly_command_images_1.id_silly_command_images) AS id_images,
            array_agg(silly_command_images_1.image) AS images,
            array_agg(silly_command_images_1.gender_attribute) AS preferences
           FROM public.silly_command_images silly_command_images_1
          GROUP BY silly_command_images_1.id_silly_command) silly_command_images USING (id_silly_command))
     LEFT JOIN ( SELECT silly_command_texts_1.id_silly_command,
            array_agg(silly_command_texts_1.id_silly_command_text) AS id_texts,
            array_agg(silly_command_texts_1.text) AS texts
           FROM public.silly_command_texts silly_command_texts_1
          GROUP BY silly_command_texts_1.id_silly_command) silly_command_texts USING (id_silly_command))
     LEFT JOIN ( SELECT silly_command_self_action_images_1.id_silly_command,
            array_agg(silly_command_self_action_images_1.id_silly_command_self_action) AS id_self_images,
            array_agg(silly_command_self_action_images_1.image) AS self_images
           FROM public.silly_command_self_action_images silly_command_self_action_images_1
          GROUP BY silly_command_self_action_images_1.id_silly_command) silly_command_self_action_images USING (id_silly_command))
     LEFT JOIN ( SELECT silly_command_self_action_texts_1.id_silly_command,
            array_agg(silly_command_self_action_texts_1.id_silly_command_self_action_text) AS id_self_texts,
            array_agg(silly_command_self_action_texts_1.text) AS self_texts
           FROM public.silly_command_self_action_texts silly_command_self_action_texts_1
          GROUP BY silly_command_self_action_texts_1.id_silly_command) silly_command_self_action_texts USING (id_silly_command));


ALTER VIEW public.silly_commands_data_new OWNER TO postgres;

--
-- Name: silly_commands_id_new_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.silly_commands_id_new_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.silly_commands_id_new_seq OWNER TO postgres;

--
-- Name: silly_commands_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.silly_commands_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.silly_commands_id_seq OWNER TO postgres;

--
-- Name: silly_commands_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.silly_commands_id_seq OWNED BY public.silly_commands.id_silly_command;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    verified boolean DEFAULT false NOT NULL,
    password character varying(100) NOT NULL,
    role character varying(50) DEFAULT 'user'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    password_rev uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: silly_command_images id_silly_command_images; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silly_command_images ALTER COLUMN id_silly_command_images SET DEFAULT nextval('public.silly_command_images_id_silly_command_images_seq'::regclass);


--
-- Name: silly_command_new id_silly_command; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silly_command_new ALTER COLUMN id_silly_command SET DEFAULT nextval('public.silly_command_new_id_silly_command_seq'::regclass);


--
-- Name: silly_command_self_action_images id_silly_command_self_action; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silly_command_self_action_images ALTER COLUMN id_silly_command_self_action SET DEFAULT nextval('public.silly_command_self_actions_id_silly_command_self_action_seq'::regclass);


--
-- Name: silly_command_self_action_texts id_silly_command_self_action_text; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silly_command_self_action_texts ALTER COLUMN id_silly_command_self_action_text SET DEFAULT nextval('public.silly_command_self_action_tex_id_silly_command_self_action__seq'::regclass);


--
-- Name: silly_command_texts id_silly_command_text; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silly_command_texts ALTER COLUMN id_silly_command_text SET DEFAULT nextval('public.silly_command_texts_id_silly_command_text_seq'::regclass);


--
-- Name: silly_command_type id_silly_command_type; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silly_command_type ALTER COLUMN id_silly_command_type SET DEFAULT nextval('public.silly_command_type_id_silly_command_type_seq'::regclass);


--
-- Name: silly_command_usage id_silly_command_usage; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silly_command_usage ALTER COLUMN id_silly_command_usage SET DEFAULT nextval('public.silly_command_usage_id_silly_command_usage_seq'::regclass);


--
-- Name: silly_commands id_silly_command; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silly_commands ALTER COLUMN id_silly_command SET DEFAULT nextval('public.silly_commands_id_seq'::regclass);


--
-- Data for Name: silly_command_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.silly_command_images (id_silly_command_images, id_silly_command, image, gender_attribute) FROM stdin;
111	3	./assets/fd6ac094-0159-438f-bd0e-6b8db0908260.gif	ALL
54	3	./assets/f2ee32dd-7df2-4414-9c51-9fad51f80a13.gif	ALL
92	9	./assets/edcd5b46-d5bd-4028-b160-91365c2c5c41.gif	ALL
81	8	./assets/e78ec74e-2f1c-4353-98fe-a3ac0cc5438f.jpeg	ALL
47	3	./assets/db6e8a0d-9887-4471-84d7-2e33f66a7fb3.gif	ALL
73	7	./assets/dae91665-0b51-4895-80db-b229a106f45f.gif	ALL
88	3	./assets/dab52b10-a22c-4c37-b82f-c39145b9e6a1.gif	ALL
89	9	./assets/d952e99e-c8ff-4f0e-855c-6ffc0bcf3883.gif	ALL
105	9	./assets/d3a0bd8c-1d44-489f-9a19-44b1def19ae9.gif	ALL
98	9	./assets/d4043b2a-7584-4a2e-84f8-fe2782a11031.gif	ALL
91	9	./assets/ceae2a40-4fd9-4704-aacc-ecca41801999.gif	ALL
109	9	./assets/cd17b9b4-3790-479c-bbe4-f1e3144ab306.gif	ALL
10	2	./assets/c9f6ff58-f27d-426b-ac86-64d8d306e84f.gif	ALL
50	3	./assets/c86981ee-2f72-46a1-9566-854da7a1276d.gif	ALL
57	3	./assets/c69f46c0-2eb4-4357-8e83-bc9253f2f2e6.gif	ALL
99	9	./assets/c3134b71-cca0-4bc7-bc7c-771a669f0d4b.gif	ALL
11	2	./assets/bf004ae9-1a99-4925-b024-fd568b75349c.gif	ALL
3	2	./assets/b6dc0403-b169-4e76-af32-4caa46608f31.gif	ALL
77	7	./assets/b3f4e1e8-de02-4092-9718-5cde482740df.gif	ALL
75	7	./assets/b04108df-e95b-4ff1-b9ed-223ccaa10bf3.gif	ALL
110	9	./assets/ab1f7209-6740-46af-b4c0-fdbb25b6acef.gif	ALL
68	4	./assets/aade8b3c-adca-49d9-a2af-24c90457df05.gif	ALL
79	7	./assets/99cedf5b-474f-4fd8-82ce-22b0b6888637.gif	ALL
65	4	./assets/993c0b26-213a-4196-82b2-c770e0ff4e13.gif	ALL
9	2	./assets/98d0793e-5d7f-4ba5-bb67-f24f8a86e5f7.gif	ALL
86	8	./assets/97e98dca-0790-415f-9b7b-f4503de8c662.jpeg	ALL
60	3	./assets/9271562f-37d2-4824-96d5-0f374b25f46a.gif	ALL
48	3	./assets/8edc7802-f620-4808-88a7-04b87eef4db5.gif	ALL
1	2	./assets/8cc95482-f385-457d-be65-ed608aa19112.gif	ALL
101	9	./assets/8ac44c92-4d1a-4239-b27f-4b58ea29b8e6.gif	ALL
100	9	./assets/87686561-7065-41a5-aecd-bdce50e29d70.gif	ALL
49	3	./assets/85483e16-0cd1-4a26-a7e1-8b45a3ecd4a0.gif	ALL
80	8	./assets/84ff6709-cd2d-4ca9-aed3-7864f7abd278.gif	ALL
8	2	./assets/8474ac17-9c45-4528-a583-3b99534a29af.gif	ALL
93	9	./assets/82dd8890-0c6d-4b51-a2ea-8976a3a61c6c.gif	ALL
104	9	./assets/8040e505-c704-42fd-afc4-4f8d26917fdf.gif	ALL
46	3	./assets/7e78aa9c-5ccf-484b-862d-958dbcc2dc19.gif	ALL
108	9	./assets/7bb27250-7e00-43ac-8b36-c0746cce01fe.gif	ALL
85	8	./assets/77ed7d4d-f04d-406c-a3a1-6e0ebec76a7a.gif	ALL
51	3	./assets/74bdf033-a0bc-4156-ac96-f1aae16f77c9.gif	ALL
83	8	./assets/733b6b26-8487-4939-b35d-6683a4c62aa9.gif	ALL
87	8	./assets/7138c09a-52f1-4502-998d-df408e06580c.gif	ALL
106	9	./assets/70f3952f-2549-4c70-b3ef-4528f4ad9359.gif	ALL
70	4	./assets/7012e298-0f1c-4040-a56d-fdf4c05e1054.gif	ALL
96	9	./assets/6fb14d85-cad3-4a61-87dc-06a1fdace989.gif	ALL
52	3	./assets/6a9a3af0-9ec2-4ed2-bf48-b77bb0e7c75b.gif	ALL
97	9	./assets/6a55221a-e108-496a-9d0c-648627b9bc61.gif	ALL
45	3	./assets/5e699d87-6226-43f5-8d7c-9eca3cdecab9.gif	ALL
4	2	./assets/5e518243-836d-4537-a438-9a3c79b6ac40.gif	ALL
90	9	./assets/5c877384-f2ec-4dbf-a16e-0c7aab1ed84b.gif	ALL
6	2	./assets/5c03e168-d2ce-426a-be0f-bd52a784cbbb.gif	ALL
84	8	./assets/596669ff-f3b5-4937-8b2b-3d4a9a0d9ec4.gif	ALL
55	3	./assets/50cf0e0f-777c-49ac-b5d8-df890bc2d541.gif	ALL
5	2	./assets/4e6e66e6-10b2-48d7-93cd-4879c148eae3.gif	ALL
61	3	./assets/47639540-0b91-4324-9ad5-9d5256ac1e38.gif	ALL
63	4	./assets/40e1f082-f612-44f7-b180-0c33f5503c4d.gif	ALL
59	3	./assets/3ecb8323-958c-47fa-b162-785055be69f8.gif	ALL
74	7	./assets/36114c82-2caa-4702-9148-e72c52bdde81.gif	ALL
76	7	./assets/34d5c1f3-85ba-4044-ae19-cbe15461f07a.gif	ALL
72	7	./assets/339b9fbe-0cda-4a0d-805c-16455aab4625.gif	ALL
67	4	./assets/2a3a8223-e297-4324-918d-59b92e5ef8ce.gif	ALL
58	3	./assets/2580d004-bae8-4afe-8812-d5f2ace3a15b.gif	ALL
107	9	./assets/23051fdb-263c-47d2-bca7-f427fcf4d620.gif	ALL
103	9	./assets/2268037d-c67d-4dc6-8e63-45d8a383309e.gif	ALL
62	3	./assets/215b3ae4-ef26-4c78-8562-d1c75341d1db.gif	ALL
56	3	./assets/1f420c39-191e-43a4-9301-797d83030eb2.gif	ALL
94	9	./assets/1babc69f-37c6-4d1b-a516-c517c671e604.gif	ALL
95	9	./assets/19c48307-ac01-46e3-904a-b908b2418f03.gif	ALL
78	7	./assets/18511ac4-423a-4076-8a15-48eefd2b4056.gif	ALL
66	4	./assets/1801d499-8e87-4732-909b-52ef385b59a0.gif	ALL
64	4	./assets/16c4f9b4-8bd1-448f-8fee-43e0cf7f9ede.gif	ALL
69	4	./assets/16401aa4-2d1b-483b-9c68-b1b210479ffc.gif	ALL
53	3	./assets/15473295-e762-4ddb-b55e-2917d0f45fc8.gif	ALL
82	8	./assets/138237f5-4575-479e-9ff8-46984cbc57d2.gif	ALL
7	2	./assets/0de16549-1e6b-470c-9afb-a6360218d6de.gif	ALL
44	2	./assets/0abab9d5-fa05-4026-b51b-c7d0dbca051d.gif	ALL
102	9	./assets/057c0ed1-4b77-4d90-9298-9517ab3619d0.gif	ALL
71	4	./assets/01a98a88-ba0b-4047-a1be-ea441658669f.gif	ALL
114	4	./assets/435716f8-fcc2-4922-aa4b-4937c11deb35.gif	Male x Female
115	4	./assets/677196b8-390f-4dab-83e7-87a5165cdeb7.gif	Male x Female
116	4	./assets/58158c2b-bd9e-493f-928d-cfbe1f0c107e.gif	Male x Female
117	4	./assets/c0964573-a4bd-49d5-b35e-87d81d2ebbed.gif	Male x Female
118	4	./assets/4db6e82c-b728-4348-8db1-f8a94208200f.gif	Male x Female
120	4	./assets/d246d034-e84d-4bc4-a902-077c44443ecb.gif	Male x Male
121	4	./assets/521013d9-ddbd-4231-8af1-06265cbf78d9.gif	Male x Male
122	4	./assets/6743f7df-9d12-4074-9f85-df89f7cb9e1d.gif	Male x Male
123	4	./assets/14451298-f8c5-437c-ad04-52a0be4a9292.gif	Male x Male
124	4	./assets/63b76d84-2ac1-4d59-83af-34ebe0d7c686.gif	Male x Male
125	4	./assets/6f236216-d1be-40f5-b2d1-864436a339b4.gif	Male x Male
134	4	./assets/fad7b864-1ac2-4c51-9b5f-60697f65114a.gif	ANIMALS
135	4	./assets/560d5205-e025-403a-83e2-a358675749e0.gif	ANIMALS
136	4	./assets/8e4f366f-00c4-48f0-b184-61164c143286.gif	ANIMALS
137	4	./assets/067f2afe-32f6-4df5-936b-24030b28cb18.gif	ANIMALS
138	4	./assets/2d249123-f9c4-4bcc-a6cb-d7212f0feee7.gif	ANIMALS
139	4	./assets/c377aaa5-6e8b-4e33-87cf-26489502dfcf.gif	ANIMALS
140	4	./assets/43f30e6c-1bd1-4e5e-bc04-7bd2876b4aba.jpg	ANIMALS
152	9	./assets/ec49b5a6-3f70-44dd-ae1e-0feaca51bd62.gif	Male x Male
153	9	./assets/5e415e10-6324-49eb-942b-aff271e2b355.gif	Male x Male
154	9	./assets/758112f0-4d4f-4ba4-9fe1-b03a54a991f4.gif	Male x Male
155	9	./assets/fe6cbfcd-ac44-4eb2-a7e9-94f09a96a358.gif	Male x Male
156	9	./assets/d2fb820e-d5d7-4845-9be0-7644cbadbd7a.gif	Male x Male
167	7	./assets/4edc3d1b-003f-40e0-ba20-256b905ec68a.gif	Male x Female
168	7	./assets/3023ee7a-7c8e-41d6-ae4a-bdaee1df0dde.gif	Male x Female
169	7	./assets/96b1c592-6bcf-4c10-bdfe-860e50f89c94.gif	Male x Female
170	7	./assets/439192d0-4406-4234-86e2-28c249cacf38.gif	Male x Female
171	7	./assets/76efd8e3-3317-4cca-9ad0-23aa44a56291.gif	Male x Female
172	7	./assets/3b11591b-ec80-468e-9e4c-16abd7e67d77.gif	Male x Female
173	7	./assets/98a5f8e5-4a66-4add-bb4c-0fef98aad5a7.gif	Male x Female
174	7	./assets/9f8961cb-86ed-44ff-958d-e86344855f9a.gif	Male x Female
175	7	./assets/3803cfbd-bb5d-42db-9116-5237a70d5717.gif	Male x Female
183	7	./assets/3a937815-a2f9-421e-9a95-0eaeeb7b9639.gif	Female x Female
184	7	./assets/471d52e3-66e3-462b-b183-c8fc92bb6f0b.gif	Female x Female
185	7	./assets/dd1d0659-9ae7-47e1-a4da-d29408d83cc8.gif	Female x Female
186	7	./assets/90843b7d-3692-4970-a513-364f75dc4b66.gif	Female x Female
187	7	./assets/f4752bfa-6c1c-4c67-a2ef-7aefd69a522f.gif	Female x Female
188	7	./assets/4fd1f7d6-6b5f-4054-bbf1-c65d31257e1a.gif	Female x Female
189	7	./assets/c1180a95-ba77-4caa-8cc9-2b61283d13eb.gif	Female x Female
196	3	./assets/42f9df8b-38ba-4e8f-9273-a0500a647f70.gif	Male x Female
197	3	./assets/95aa59c7-8146-49ad-b99e-887ee34a0635.gif	Male x Female
198	3	./assets/2e1579c5-b457-400f-b820-daf91aae52d8.gif	Male x Female
199	3	./assets/1c9963f8-9823-4991-9207-d5822f11365d.gif	Male x Female
200	3	./assets/8f52c1c3-0d03-4c59-8116-a27a61eb8613.gif	Male x Female
201	3	./assets/85a5801b-589d-49fe-9d7c-e3d92b86ad48.gif	Male x Female
202	3	./assets/f4cda0b1-ceb6-46b2-a509-a2dfec43ad08.gif	Male x Female
203	3	./assets/536a9b15-c36c-4707-ae2e-48a2dc7b3913.gif	Male x Female
204	3	./assets/8f244bce-8978-40f9-9936-5b2c9640e6fb.gif	Male x Female
205	3	./assets/d1054751-9c20-45b9-9a1c-c8c3ab502a5b.gif	Male x Female
206	3	./assets/e3d647ce-8a8a-45ad-97d8-77408c4100d1.gif	Male x Female
207	3	./assets/17f828b9-16a9-42c2-848b-19ed741f6283.gif	Male x Female
214	3	./assets/5443c08d-eb77-4dd1-a239-a99919c5bcf9.gif	Female x Female
215	3	./assets/4965d9e6-5687-4595-9cd8-ddce8cae0b86.gif	Female x Female
216	3	./assets/bc761b7a-f82f-45f1-b28d-d1c5647d3940.gif	Female x Female
217	3	./assets/1c24fce3-d905-4abc-a36e-c8335befa461.gif	Female x Female
218	3	./assets/06541896-ae27-4424-99de-7c333542ba9b.gif	Female x Female
219	3	./assets/d82325c8-5b96-463f-be90-dc1e814e28c2.gif	Female x Female
226	2	./assets/780813d9-c388-4c11-9d99-3af4922b0a25.gif	Male x Female
227	2	./assets/eb6048b1-8eae-4281-b84c-1bbc8c4d9ffc.gif	Male x Female
228	2	./assets/5df849a6-0241-4a85-8c36-6af040e54246.gif	Male x Female
229	2	./assets/a97c0c24-2e72-4f12-90d0-c70b434ba767.gif	Male x Female
231	2	./assets/d2d5d8f6-04e0-42a5-8b88-dc0c18e5ac28.gif	Male x Female
232	2	./assets/accc3b62-7c14-4400-a2bf-c27f04acfc7c.gif	Male x Female
233	2	./assets/1ac2285c-41e5-4a3f-bf59-e9061849fa26.gif	Male x Female
234	2	./assets/1e1136fb-be16-4171-84ae-4e9cf4073c44.gif	Male x Female
235	2	./assets/baadb486-60f7-4f5b-9656-3373546e95b0.gif	Male x Female
245	2	./assets/4d255bd7-03ba-4f85-92a2-813eea6bffef.gif	Female x Female
246	2	./assets/627cacdd-c1bd-425b-8dd7-5cec3bdb2807.gif	Female x Female
247	2	./assets/f6b3f29c-8d30-4fb7-a0da-55bdfa1a58e4.gif	Female x Female
248	2	./assets/1d1f1440-afe1-40fa-ba66-5542b6981030.gif	Female x Female
249	2	./assets/1bea1026-26e3-4943-a340-8f2a9c5b2b83.gif	Female x Female
250	2	./assets/555328bb-0986-4662-973b-bc4b51128573.gif	Female x Female
251	2	./assets/0bcfba4e-44e4-454f-bd88-6b8ef7681591.gif	Female x Female
252	2	./assets/dea6d700-5186-4f51-b564-8f3e700cd6cd.gif	Female x Female
230	2	./assets/c83fbede-a587-4482-9767-92c233042409.gif	Male x Male
126	4	./assets/7027b0c1-7fe2-4891-bc96-420a5720adaa.gif	Female x Female
127	4	./assets/c70d4bd3-04c8-4c16-9090-0b2cec2f8a49.gif	Female x Female
128	4	./assets/d9214b8f-fc02-4d3e-8701-26cc12f7ee66.gif	Female x Female
129	4	./assets/fb450fd2-058c-4d34-9369-def4130c6244.gif	Female x Female
130	4	./assets/fce88bc8-7d51-486d-b380-d0ae022e4a19.gif	Female x Female
131	4	./assets/5ea0288d-7b9f-403c-a1c7-63414a2f39c3.gif	Female x Female
132	4	./assets/7b0f3df8-4283-4447-918c-83521a3a9327.gif	Female x Female
133	4	./assets/c5da5f8a-854f-4812-b17d-6352d820acaa.gif	Female x Female
141	9	./assets/c876a9f7-41f7-4982-9934-84668a2725c4.gif	Male x Female
142	9	./assets/6b25aa69-77d8-41bd-bd7e-41b5bf1d990d.gif	Male x Female
143	9	./assets/fd091ce9-88be-4833-8cfa-363501a834f7.gif	Male x Female
144	9	./assets/7462127b-17f3-4a2e-9180-08a579db4516.gif	Male x Female
145	9	./assets/a6a2d92a-15ba-4713-9254-9c6c54383887.gif	Male x Female
146	9	./assets/5d7e53b4-c684-4be4-a73f-05244fcb2d36.gif	Male x Female
147	9	./assets/4a607bb4-342d-440e-ae78-85b3977918c3.gif	Male x Female
148	9	./assets/972d8943-0314-47a3-854d-e4f7797f1999.gif	Male x Female
149	9	./assets/6d182764-c56c-410e-8f39-8d6fa47a7947.gif	Male x Female
150	9	./assets/4aa08f3d-8477-4b3d-afa9-c82c97691cf9.gif	Male x Female
151	9	./assets/dc5b661d-fe30-45a3-a02e-fe6e0ce87f6f.gif	Male x Female
158	9	./assets/da1b476d-5612-414d-b509-6ecc526abfbb.gif	Female x Female
159	9	./assets/42d945f7-4791-4343-b42c-024d2cda8c0e.gif	Female x Female
160	9	./assets/a0b0f7f3-d5dc-4c5b-8faa-072840fd1d8c.gif	Female x Female
161	9	./assets/50dc4f34-4c35-4d44-b213-e37c3db538cd.gif	Female x Female
162	9	./assets/9526d424-3db4-4539-adf8-08a8e7450cb8.gif	Female x Female
163	9	./assets/98df1325-12a5-445a-b282-41e214de216d.gif	Female x Female
164	9	./assets/858b071f-38d7-4f49-8f73-bd2a8ee8ca9c.gif	Female x Female
165	9	./assets/bf27e93d-6b6b-4dd8-a097-4c3458bdcea3.gif	Female x Female
166	9	./assets/666d210e-3bfd-49ca-9a31-15c4ae81ff1f.gif	Female x Female
176	7	./assets/75c1a571-a2e5-4632-b290-b90f36db52e0.gif	Male x Male
177	7	./assets/94834577-2bec-42a5-996a-141bdd1661f2.gif	Male x Male
178	7	./assets/d3f2892d-32b3-42a4-9d23-584d959e80d0.gif	Male x Male
179	7	./assets/e1e47878-4d1c-4cc3-bee3-a9fb965f6241.gif	Male x Male
180	7	./assets/a6ee59ab-f7ff-4508-b75b-fa8bdf9fccd8.gif	Male x Male
181	7	./assets/fe7312a5-50c9-4e9d-ab14-60d52fca8938.gif	Male x Male
182	7	./assets/88b0bd37-4559-4a15-9ef1-e880177a2ae2.gif	Male x Male
190	3	./assets/0fa1eb28-3a99-461d-aa4c-db0c2ab6f724.gif	CATS
191	3	./assets/7f4e578b-1bed-429c-a5eb-ddd26ea857d3.gif	CATS
192	3	./assets/4d00cf32-405c-414c-bf84-881835a28311.gif	CATS
193	3	./assets/a13f5f6f-41ca-438b-b696-0509f292c079.gif	CATS
194	3	./assets/e0ce969b-2eb7-4416-86bd-08e4ece0d391.gif	CATS
195	3	./assets/28004bc5-7114-4643-9ba0-f36faaf76ee0.gif	CATS
208	3	./assets/6ebc4fe8-df7f-4aae-a756-7bf02d9a14ef.gif	Male x Male
209	3	./assets/7dc7162b-a7c3-4fea-82cb-6419562e3457.gif	Male x Male
210	3	./assets/39086d92-32bd-4337-8971-8c024a0fc306.gif	Male x Male
211	3	./assets/8b668915-2366-4d7a-ba03-ec4ceb05de7a.gif	Male x Male
212	3	./assets/b8d92cc0-c04a-4ede-87dd-a55398430a7e.gif	Male x Male
213	3	./assets/6578d94b-8e61-42a8-9f2b-13702d76cded.gif	Male x Male
220	2	./assets/8870d17f-fcd7-466b-8150-c86f9e43cada.gif	CATS
221	2	./assets/6434b12e-e995-4c28-b4d1-8a8d91d3a482.gif	CATS
222	2	./assets/ff32cb9f-df9c-46fe-bd7a-6ce8efaa6ccd.gif	CATS
223	2	./assets/979e1bee-4a9d-45aa-b191-a7b620403d74.gif	CATS
224	2	./assets/5b8efeab-3211-4331-ab22-b545c3dbd625.gif	CATS
225	2	./assets/acf4951d-66a7-4af2-94f7-951e20850138.gif	CATS
236	2	./assets/06a47cac-9fd7-4639-a8f5-cd9d36165f7f.gif	Male x Male
237	2	./assets/cc372108-3ba8-4e9b-8951-4af65ba2439c.gif	Male x Male
238	2	./assets/07f97a47-1e2d-4f70-ac50-c9493cf8f269.gif	Male x Male
239	2	./assets/9e126f0e-1f86-4e53-83ee-260e0e7f2261.gif	Male x Male
240	2	./assets/a80a5506-cc6e-45de-8d6d-495f428d7ed5.gif	Male x Male
241	2	./assets/b684a3e5-92ef-43cb-9378-d324b8eebcbc.gif	Male x Male
242	2	./assets/10e0e3f2-3329-4c77-b10b-a8d5b2644949.gif	Male x Male
243	2	./assets/b7b44994-2588-4501-99ac-fd6929e34e4d.gif	Male x Male
244	2	./assets/342751c3-2dd7-4a5d-8dff-86a8c5b0368c.gif	Male x Male
119	4	./assets/841d74cb-d92e-490a-8c39-f2fd5e96adf9.gif	Female x Female
157	9	./assets/e13588b4-3976-40c2-a144-278167e2e051.gif	Male x Female
253	2	./assets/20392466-3850-44b5-91af-96b0f8df14f7.gif	Male x Male
254	10	./assets/3e9ed022-934c-4ab3-8557-dd8d7ae30a2f.gif	ALL
\.


--
-- Data for Name: silly_command_new; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.silly_command_new (id_silly_command, name, command_type, description, gender_attributes, footer_text) FROM stdin;
\.


--
-- Data for Name: silly_command_self_action_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.silly_command_self_action_images (id_silly_command_self_action, id_silly_command, image) FROM stdin;
1	2	./assets/91a6384c-df76-4d36-8321-14a1f1c78641.gif
3	5	./assets/f069d975-7fbc-4276-9333-e0cacbaea663.gif
4	6	./assets/8440de94-493d-4df4-8037-f627b98facdb.gif
5	7	./assets/7a67aa66-5c33-44df-9e01-00a88b65f9be.gif
6	8	./assets/c952e7e4-bd51-469b-bd89-b066bcf59cc4.jpg
7	8	./assets/fe0d6512-8e50-432f-b158-dbbac54e091d.jpg
8	8	./assets/97121b0b-7f45-4660-946c-17670e998c92.jpg
9	8	./assets/0af76a0b-f976-48a6-9c96-faac980d16bd.jpg
10	8	./assets/872635ad-18ad-4a37-8efe-e75114f038ae.jpg
\.


--
-- Data for Name: silly_command_self_action_texts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.silly_command_self_action_texts (id_silly_command_self_action_text, id_silly_command, text) FROM stdin;
3	2	Aww... I'll give you a hug then!
4	3	Awww.. I'll headpat you then..
5	4	Fine, i'll cuddle you then..
6	7	Heres my hand....
\.


--
-- Data for Name: silly_command_texts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.silly_command_texts (id_silly_command_text, id_silly_command, text) FROM stdin;
5	2	{author} has hugged {user} !
6	3	{author} has given a very cute headpat to {user}!
7	3	Nyaaa! {author} has headpatted {user}!
8	4	{author} is cuddling with {user}
9	7	{author} is holding hands with {user}.. How cute.
10	7	{author} is holding {user}'s hand!
11	9	Chuu!  {author} has kissed {user}!
\.


--
-- Data for Name: silly_command_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.silly_command_type (id_silly_command_type, name) FROM stdin;
1	AUTHOR_ONLY
2	ONE_USER
\.


--
-- Data for Name: silly_command_usage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.silly_command_usage (id_silly_command_usage, id_silly_command, id_user_1, id_user_2, usages) FROM stdin;
56	4	559157780666122241	315774797994786836	3
3	2	434626996262273038	1042723285600829460	107
34	2	434626996262273038	133719582660755457	2
48	3	606296261531926533	419885892103045140	6
73	3	606296261531926533	747874005092139022	2
14	4	434626996262273038	1042723285600829460	2
15	3	188711830720479235	434626996262273038	2
35	2	141336852543045633	1042723285600829460	2
17	2	606296261531926533	269123912304951297	4
19	3	434626996262273038	270974825164439552	2
16	2	409060256413384713	269123912304951297	3
77	3	188711830720479235	127415620793794560	4
75	3	434626996262273038	188711830720479235	3
66	2	1110540052288774224	851117889192591361	4
78	3	127415620793794560	188711830720479235	4
63	7	188711830720479235	127415620793794560	26
44	2	127415620793794560	188711830720479235	70
25	2	606296261531926533	529590490094632963	2
70	2	1110540052288774224	747874005092139022	8
45	2	188711830720479235	127415620793794560	79
30	2	529590490094632963	606296261531926533	2
31	4	434626996262273038	409060256413384713	2
26	2	606296261531926533	697617953486798909	4
69	2	342730801567498240	419885892103045140	2
52	3	1110540052288774224	747874005092139022	9
87	3	1110540052288774224	409060256413384713	41
4	3	434626996262273038	1042723285600829460	10
5	3	434626996262273038	697617953486798909	2
6	3	697617953486798909	434626996262273038	2
27	2	697617953486798909	606296261531926533	3
58	3	1110540052288774224	559157780666122241	47
88	2	1110540052288774224	947749124676153345	9
53	2	342730801567498240	1042723285600829460	2
54	2	419885892103045140	606296261531926533	8
33	3	947749124676153345	606296261531926533	4
9	3	141336852543045633	434626996262273038	18
79	2	1110540052288774224	559157780666122241	46
57	3	947749124676153345	529590490094632963	2
50	3	947749124676153345	1110540052288774224	3
67	2	559157780666122241	851117889192591361	2
42	3	434626996262273038	141336852543045633	34
43	3	947749124676153345	127415620793794560	2
29	2	606296261531926533	947749124676153345	13
82	2	559157780666122241	1110540052288774224	42
62	7	434626996262273038	188711830720479235	2
24	2	606296261531926533	419885892103045140	14
55	3	397598078695374861	1110540052288774224	43
59	3	1110540052288774224	397598078695374861	46
68	2	697617953486798909	903501553112068096	2
80	4	1110540052288774224	559157780666122241	7
76	3	434626996262273038	127415620793794560	2
65	2	1110540052288774224	419885892103045140	3
51	3	1110540052288774224	947749124676153345	4
81	7	559157780666122241	1110540052288774224	4
84	3	127415620793794560	148092513419264000	2
85	2	434626996262273038	247873746709250048	2
36	2	606296261531926533	1110540052288774224	5
74	3	419885892103045140	606296261531926533	4
86	3	1110540052288774224	606296261531926533	3
28	2	947749124676153345	606296261531926533	12
89	7	1110540052288774224	747874005092139022	2
64	7	127415620793794560	188711830720479235	36
37	2	409060256413384713	1110540052288774224	52
131	3	1110540052288774224	697617953486798909	2
95	3	1110540052288774224	419885892103045140	2
96	2	559157780666122241	529590490094632963	2
175	2	231780195529523201	255515037676863490	13
94	2	409060256413384713	529590490094632963	3
97	2	559157780666122241	747874005092139022	3
133	2	697617953486798909	1110540052288774224	2
101	2	397598078695374861	747874005092139022	10
126	2	397598078695374861	533995393671757834	3
90	3	434626996262273038	342730801567498240	4
41	2	342730801567498240	324644810621190145	60
18	3	434626996262273038	606296261531926533	13
10	3	434626996262273038	409060256413384713	6
39	2	342730801567498240	606296261531926533	5
1	2	434626996262273038	409060256413384713	20
12	2	606296261531926533	409060256413384713	68
38	2	1110540052288774224	409060256413384713	161
49	3	342730801567498240	606296261531926533	19
23	2	409060256413384713	606296261531926533	16
60	2	606296261531926533	869389411324940309	13
2	2	409060256413384713	434626996262273038	20
13	2	606296261531926533	434626996262273038	49
8	3	342730801567498240	434626996262273038	18
83	3	434626996262273038	1110540052288774224	14
71	3	1110540052288774224	434626996262273038	48
61	2	869389411324940309	606296261531926533	13
47	4	127415620793794560	188711830720479235	142
91	4	434626996262273038	606296261531926533	3
46	4	188711830720479235	127415620793794560	148
21	2	434626996262273038	342730801567498240	125
22	2	434626996262273038	606296261531926533	33
32	2	434626996262273038	1110540052288774224	34
165	4	947749124676153345	1110540052288774224	3
103	2	434626996262273038	419885892103045140	3
106	3	397598078695374861	419885892103045140	2
178	4	231780195529523201	255515037676863490	72
108	2	1110540052288774224	606296261531926533	2
151	9	1102424523250356314	559157780666122241	4
159	2	559157780666122241	409060256413384713	4
163	9	1110540052288774224	397598078695374861	4
117	3	419885892103045140	409060256413384713	2
118	3	747874005092139022	1110540052288774224	2
123	2	397598078695374861	434626996262273038	11
120	2	747874005092139022	1110540052288774224	2
121	3	559157780666122241	529590490094632963	2
153	9	397598078695374861	559157780666122241	2
142	2	559157780666122241	434626996262273038	5
104	2	434626996262273038	559157780666122241	7
125	2	533995393671757834	1110540052288774224	2
127	2	533995393671757834	397598078695374861	2
128	3	947749124676153345	534057315318497281	2
129	2	947749124676153345	534057315318497281	2
130	4	947749124676153345	534057315318497281	2
135	2	606296261531926533	559157780666122241	2
173	4	255515037676863490	231780195529523201	82
136	2	559157780666122241	1102424523250356314	2
137	3	1110540052288774224	1079393784992899102	2
138	4	559157780666122241	747874005092139022	2
164	3	947749124676153345	397598078695374861	4
100	3	947749124676153345	559157780666122241	3
105	2	419885892103045140	559157780666122241	4
140	2	559157780666122241	947749124676153345	2
102	2	559157780666122241	419885892103045140	3
141	4	947749124676153345	315774797994786836	2
160	2	559157780666122241	503701658824605706	2
143	4	315774797994786836	559157780666122241	2
144	4	315774797994786836	947749124676153345	2
145	3	947749124676153345	409060256413384713	2
146	9	434626996262273038	1042723285600829460	2
147	9	533995393671757834	1042723285600829460	2
148	9	1110540052288774224	533995393671757834	2
149	9	1110540052288774224	434626996262273038	2
112	2	1102424523250356314	409060256413384713	3
154	2	1102424523250356314	1110540052288774224	2
155	2	1102424523250356314	397598078695374861	2
152	9	1110540052288774224	559157780666122241	7
107	4	419885892103045140	606296261531926533	3
109	2	1102424523250356314	1042723285600829460	3
156	2	1102424523250356314	559157780666122241	3
99	3	1110540052288774224	529590490094632963	7
161	2	409060256413384713	559157780666122241	2
162	2	559157780666122241	1042723285600829460	2
169	3	559157780666122241	947749124676153345	2
166	2	947749124676153345	533995393671757834	2
167	2	1129264220744204308	947749124676153345	2
168	2	533995393671757834	947749124676153345	2
174	9	434626996262273038	869389411324940309	2
170	2	947749124676153345	559157780666122241	2
150	9	1110540052288774224	747874005092139022	3
171	2	947749124676153345	1110540052288774224	2
158	9	559157780666122241	1110540052288774224	11
113	3	1110540052288774224	1102424523250356314	5
115	3	559157780666122241	747874005092139022	4
116	3	397598078695374861	747874005092139022	11
177	3	419885892103045140	434626996262273038	2
157	3	397598078695374861	559157780666122241	4
139	4	559157780666122241	1110540052288774224	3
98	2	559157780666122241	397598078695374861	4
134	2	397598078695374861	1110540052288774224	39
182	3	1102424523250356314	559157780666122241	2
184	2	434626996262273038	298822483060981760	2
214	3	975986642605207582	434626996262273038	1
185	2	434626996262273038	411916947773587456	2
186	3	1110540052288774224	903501553112068096	1
187	9	903501553112068096	1110540052288774224	1
223	3	434626996262273038	656313695139397642	4
189	3	903501553112068096	1110540052288774224	1
191	4	947749124676153345	747874005092139022	1
194	3	434626996262273038	851117889192591361	1
200	3	397598078695374861	665082112029884416	3
197	3	434626996262273038	533995393671757834	1
216	2	808922671060221972	665082112029884416	1
199	2	434626996262273038	255515037676863490	1
254	3	397598078695374861	997297986205925449	1
221	2	1110540052288774224	665082112029884416	2
225	3	397598078695374861	533995393671757834	5
93	2	1110540052288774224	529590490094632963	9
181	3	231780195529523201	255515037676863490	21
179	9	231780195529523201	255515037676863490	74
180	9	255515037676863490	231780195529523201	85
176	3	255515037676863490	231780195529523201	10
124	2	1110540052288774224	397598078695374861	47
122	2	1110540052288774224	533995393671757834	6
92	3	606296261531926533	434626996262273038	5
110	2	1102424523250356314	434626996262273038	4
114	3	1110540052288774224	533995393671757834	7
111	2	1110540052288774224	434626996262273038	41
219	3	665082112029884416	1110540052288774224	1
192	3	231780195529523201	127415620793794560	2
193	3	231780195529523201	188711830720479235	2
198	3	640194573033013258	1110540052288774224	3
205	3	947749124676153345	315774797994786836	1
268	2	529590490094632963	656313695139397642	2
202	2	665082112029884416	397598078695374861	2
246	2	1110540052288774224	697988114735693826	2
207	2	808922671060221972	529590490094632963	1
208	3	197559279216099329	529590490094632963	1
255	7	397598078695374861	997297986205925449	1
243	3	1110540052288774224	808922671060221972	4
222	2	397598078695374861	269123912304951297	1
211	2	665082112029884416	409060256413384713	2
256	7	1110540052288774224	559157780666122241	1
245	3	808922671060221972	1110540052288774224	3
213	9	665082112029884416	869389411324940309	1
188	2	434626996262273038	747874005092139022	3
244	3	1110540052288774224	697988114735693826	2
206	3	397598078695374861	529590490094632963	2
273	4	409060256413384713	1110540052288774224	21
226	7	397598078695374861	533995393671757834	1
227	7	1110540052288774224	397598078695374861	1
228	7	1110540052288774224	533995393671757834	1
229	7	533995393671757834	409060256413384713	1
230	7	397598078695374861	434626996262273038	1
210	2	997297986205925449	1110540052288774224	2
260	3	559157780666122241	434626996262273038	1
233	7	1110540052288774224	434626996262273038	1
261	7	231780195529523201	255515037676863490	2
236	4	397598078695374861	1110540052288774224	1
237	3	559157780666122241	656313695139397642	1
242	2	656313695139397642	1110540052288774224	12
265	2	665082112029884416	434626996262273038	1
240	3	656313695139397642	1110540052288774224	1
238	3	656313695139397642	559157780666122241	2
224	9	656313695139397642	529590490094632963	4
247	3	1110540052288774224	997297986205925449	3
250	2	656313695139397642	529590490094632963	5
253	2	665082112029884416	559157780666122241	3
215	3	397598078695374861	434626996262273038	17
252	2	559157780666122241	665082112029884416	2
257	2	1110540052288774224	997297986205925449	2
272	4	1110540052288774224	409060256413384713	27
195	9	127415620793794560	188711830720479235	35
231	7	1110540052288774224	409060256413384713	80
262	2	409060256413384713	397598078695374861	1
183	2	397598078695374861	409060256413384713	8
263	4	656313695139397642	529590490094632963	4
258	3	1110540052288774224	640194573033013258	3
251	2	397598078695374861	559157780666122241	3
266	3	434626996262273038	997297986205925449	1
264	4	529590490094632963	656313695139397642	2
267	7	255515037676863490	231780195529523201	1
232	7	409060256413384713	1110540052288774224	76
269	2	1110540052288774224	1134469197334859867	1
217	3	397598078695374861	409060256413384713	11
270	3	1134469197334859867	851117889192591361	1
271	9	255515037676863490	714627662693269635	1
212	2	397598078695374861	665082112029884416	3
235	2	434626996262273038	397598078695374861	9
218	3	559157780666122241	1110540052288774224	9
274	2	1110540052288774224	342730801567498240	1
275	2	342730801567498240	1110540052288774224	1
276	3	1110540052288774224	709143166095327262	1
277	3	640194573033013258	559157780666122241	1
323	4	255515037676863490	1042723285600829460	1
279	3	434626996262273038	747874005092139022	1
281	3	1110540052288774224	270974825164439552	1
299	9	808922671060221972	656313695139397642	1
306	9	665082112029884416	533995393671757834	1
283	3	1110540052288774224	1022487847971864606	3
284	2	342730801567498240	736301363994034206	1
285	3	255515037676863490	714627662693269635	1
282	3	270974825164439552	1110540052288774224	3
337	2	530690227853852672	342730801567498240	3
288	2	851117889192591361	1110540052288774224	1
289	2	851117889192591361	434626996262273038	1
290	3	851117889192591361	714627662693269635	1
291	3	851117889192591361	1110540052288774224	1
318	2	808922671060221972	1110540052288774224	2
287	3	851117889192591361	434626996262273038	2
280	3	434626996262273038	397598078695374861	2
293	2	808922671060221972	434626996262273038	1
294	3	808922671060221972	434626996262273038	1
324	3	270974825164439552	606296261531926533	1
190	3	1110540052288774224	665082112029884416	12
220	2	665082112029884416	1110540052288774224	5
203	2	409060256413384713	869389411324940309	4
241	2	1110540052288774224	656313695139397642	28
259	2	656313695139397642	409060256413384713	6
204	2	869389411324940309	409060256413384713	2
196	9	188711830720479235	127415620793794560	48
234	3	397598078695374861	656313695139397642	4
201	2	434626996262273038	1102424523250356314	2
310	3	397598078695374861	269123912304951297	2
297	2	1110540052288774224	269123912304951297	1
311	4	656313695139397642	269123912304951297	1
301	2	409060256413384713	747874005092139022	1
312	4	269123912304951297	656313695139397642	1
325	2	606296261531926533	270974825164439552	1
302	9	656313695139397642	269123912304951297	6
300	9	269123912304951297	656313695139397642	6
345	2	269123912304951297	606296261531926533	1
298	2	665082112029884416	640194573033013258	1
319	3	869389411324940309	606296261531926533	1
347	2	530690227853852672	1110540052288774224	1
307	3	342730801567498240	1042723285600829460	1
333	4	530690227853852672	656313695139397642	1
303	3	808922671060221972	409060256413384713	1
314	3	409060256413384713	533995393671757834	1
315	3	409060256413384713	342730801567498240	1
341	2	434626996262273038	640194573033013258	1
348	9	434626996262273038	512528327341506570	1
321	2	656313695139397642	434626996262273038	44
286	3	1134469197334859867	1110540052288774224	2
308	7	434626996262273038	1042723285600829460	1
309	3	270974825164439552	409060256413384713	1
317	3	434626996262273038	529590490094632963	1
331	3	656313695139397642	533995393671757834	1
336	2	1110540052288774224	530690227853852672	1
305	2	269123912304951297	656313695139397642	3
342	2	640194573033013258	434626996262273038	1
338	3	869389411324940309	1110540052288774224	1
339	3	869389411324940309	409060256413384713	1
343	2	269123912304951297	640194573033013258	1
296	3	1110540052288774224	269123912304951297	5
332	3	656313695139397642	530690227853852672	2
340	2	656313695139397642	559157780666122241	1
334	2	397598078695374861	530690227853852672	1
304	2	656313695139397642	269123912304951297	2
344	3	269123912304951297	606296261531926533	1
329	2	656313695139397642	530690227853852672	34
335	2	342730801567498240	530690227853852672	3
350	3	606296261531926533	869389411324940309	1
330	2	530690227853852672	656313695139397642	35
349	2	533995393671757834	559157780666122241	1
346	3	1110540052288774224	530690227853852672	1
326	2	656313695139397642	533995393671757834	25
327	2	533995393671757834	656313695139397642	22
351	10	409060256413384713	434626996262273038	1
132	3	1110540052288774224	851117889192591361	9
354	3	1180958137566646342	606296261531926533	1
209	2	434626996262273038	851117889192591361	6
355	2	606296261531926533	1180958137566646342	2
328	3	409060256413384713	656313695139397642	15
248	2	1110540052288774224	869389411324940309	19
359	3	342730801567498240	947749124676153345	2
361	2	409060256413384713	342730801567498240	1
369	2	620279341670203413	606296261531926533	1
316	2	342730801567498240	409060256413384713	2
7	3	409060256413384713	434626996262273038	10
365	2	397598078695374861	869389411324940309	1
239	3	1110540052288774224	656313695139397642	41
322	2	434626996262273038	656313695139397642	41
295	9	1110540052288774224	409060256413384713	206
360	3	434626996262273038	869389411324940309	1
249	2	869389411324940309	1110540052288774224	12
352	2	869389411324940309	434626996262273038	2
72	3	1110540052288774224	869389411324940309	16
313	3	409060256413384713	869389411324940309	11
363	4	434626996262273038	342730801567498240	1
11	3	409060256413384713	606296261531926533	50
119	3	409060256413384713	1110540052288774224	45
353	2	434626996262273038	869389411324940309	2
362	2	434626996262273038	1180958137566646342	2
364	4	342730801567498240	434626996262273038	1
366	2	869389411324940309	397598078695374861	1
172	2	255515037676863490	231780195529523201	28
40	2	606296261531926533	342730801567498240	22
292	9	409060256413384713	1110540052288774224	183
278	3	409060256413384713	397598078695374861	7
367	2	606296261531926533	656313695139397642	1
356	2	869389411324940309	656313695139397642	2
368	2	606296261531926533	620279341670203413	1
357	2	409060256413384713	656313695139397642	3
370	2	606296261531926533	997297986205925449	1
371	2	620279341670203413	997297986205925449	1
358	3	947749124676153345	342730801567498240	4
372	7	606296261531926533	434626996262273038	1
373	7	434626996262273038	606296261531926533	1
374	2	606296261531926533	282278542048493568	1
320	3	606296261531926533	409060256413384713	7
375	2	1110540052288774224	702818130593841152	1
376	2	1110540052288774224	517859660569509889	1
20	2	342730801567498240	434626996262273038	158
377	2	434626996262273038	315774797994786836	1
378	2	315774797994786836	434626996262273038	1
\.


--
-- Data for Name: silly_commands; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.silly_commands (id_silly_command, name, command_type, description, gender_attributes, footer_text) FROM stdin;
5	minny	1	the truth about minny	{}	
6	atomosu	1	the truth about how you feel about atomosu	{}	
8	cat	1	Get a cat picture???	{}	
4	cuddle	2	Cuddle with someone!	{"Male x Female","Male x Male","Female x Female",ANIMALS}	{author} has cuddled with {user} {count} times!
9	kiss	2	Kiss someone!	{"Male x Female","Male x Male","Female x Female"}	{author} has kissed {user} {count} times!
7	handholding	2	Hold hands!	{"Male x Female","Male x Male","Female x Female"}	{author} has held hands with {user} {count} times!
3	pat	2	Pat someone!	{CATS,"Male x Female","Male x Male","Female x Female"}	{author} has headpatted {user} {count} times!
2	hug	2	Send a hug to someone!	{CATS,"Male x Female","Male x Male","Female x Female"}	{author} has hugged {user} {count} times!
10	pizza	2	totally pizza someone	{}	you've been pizza'd
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, verified, password, role, created_at, updated_at, password_rev) FROM stdin;
650caddd-b045-43d5-b691-dcc749e24b3c	taka_the_discord_bot	taka_the_discord_bot@gmail.com	t	XejuB3dm5K5AdAQGCjVvweULZeHHH9zai9fMBKQt3kaaJwANrjaETmaWLBnsAm9HcPD	admin	2023-12-12 09:40:42.483969+00	2023-12-12 09:40:42.483969+00	2fce3c98-753e-430a-b11f-48c41628c187
\.


--
-- Name: silly_command_images_id_silly_command_images_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.silly_command_images_id_silly_command_images_seq', 254, true);


--
-- Name: silly_command_new_id_command_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.silly_command_new_id_command_seq', 1, true);


--
-- Name: silly_command_new_id_silly_command_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.silly_command_new_id_silly_command_seq', 1, false);


--
-- Name: silly_command_self_action_tex_id_silly_command_self_action__seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.silly_command_self_action_tex_id_silly_command_self_action__seq', 6, true);


--
-- Name: silly_command_self_actions_id_silly_command_self_action_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.silly_command_self_actions_id_silly_command_self_action_seq', 10, true);


--
-- Name: silly_command_texts_id_silly_command_text_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.silly_command_texts_id_silly_command_text_seq', 11, true);


--
-- Name: silly_command_type_id_silly_command_type_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.silly_command_type_id_silly_command_type_seq', 2, true);


--
-- Name: silly_command_usage_id_silly_command_usage_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.silly_command_usage_id_silly_command_usage_seq', 378, true);


--
-- Name: silly_commands_id_new_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.silly_commands_id_new_seq', 1, false);


--
-- Name: silly_commands_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.silly_commands_id_seq', 10, true);


--
-- Name: silly_command_images silly_command_images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silly_command_images
    ADD CONSTRAINT silly_command_images_pkey PRIMARY KEY (id_silly_command_images);


--
-- Name: silly_command_new silly_command_new_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silly_command_new
    ADD CONSTRAINT silly_command_new_pkey PRIMARY KEY (id_silly_command, name);


--
-- Name: silly_command_self_action_texts silly_command_self_action_texts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silly_command_self_action_texts
    ADD CONSTRAINT silly_command_self_action_texts_pkey PRIMARY KEY (id_silly_command_self_action_text);


--
-- Name: silly_command_self_action_images silly_command_self_actions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silly_command_self_action_images
    ADD CONSTRAINT silly_command_self_actions_pkey PRIMARY KEY (id_silly_command_self_action);


--
-- Name: silly_command_texts silly_command_texts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silly_command_texts
    ADD CONSTRAINT silly_command_texts_pkey PRIMARY KEY (id_silly_command_text);


--
-- Name: silly_command_type silly_command_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silly_command_type
    ADD CONSTRAINT silly_command_type_pkey PRIMARY KEY (id_silly_command_type, name);


--
-- Name: silly_command_usage silly_command_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silly_command_usage
    ADD CONSTRAINT silly_command_usage_pkey PRIMARY KEY (id_silly_command_usage, id_user_1, id_user_2, id_silly_command);


--
-- Name: silly_commands silly_commands_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silly_commands
    ADD CONSTRAINT silly_commands_pkey PRIMARY KEY (id_silly_command, name);


--
-- Name: silly_command_type unique_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silly_command_type
    ADD CONSTRAINT unique_id UNIQUE (id_silly_command_type);


--
-- Name: silly_command_type unique_id_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silly_command_type
    ADD CONSTRAINT unique_id_name UNIQUE (name, id_silly_command_type);


--
-- Name: silly_commands unique_silly_command; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silly_commands
    ADD CONSTRAINT unique_silly_command UNIQUE (id_silly_command, name);


--
-- Name: silly_commands unique_silly_command_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silly_commands
    ADD CONSTRAINT unique_silly_command_id UNIQUE (id_silly_command);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: unique_silly_command_id_new; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unique_silly_command_id_new ON public.silly_command_new USING btree (id_silly_command);


--
-- Name: unique_silly_command_new; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unique_silly_command_new ON public.silly_command_new USING btree (id_silly_command, name);


--
-- Name: users_email_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_email_idx ON public.users USING btree (email);


--
-- Name: silly_commands fk_id_command_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silly_commands
    ADD CONSTRAINT fk_id_command_type FOREIGN KEY (command_type) REFERENCES public.silly_command_type(id_silly_command_type) NOT VALID;


--
-- Name: silly_command_new fk_id_command_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silly_command_new
    ADD CONSTRAINT fk_id_command_type FOREIGN KEY (command_type) REFERENCES public.silly_command_type(id_silly_command_type);


--
-- Name: silly_command_self_action_images fk_id_silly_command; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silly_command_self_action_images
    ADD CONSTRAINT fk_id_silly_command FOREIGN KEY (id_silly_command) REFERENCES public.silly_commands(id_silly_command);


--
-- Name: silly_command_images fk_id_silly_command; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silly_command_images
    ADD CONSTRAINT fk_id_silly_command FOREIGN KEY (id_silly_command) REFERENCES public.silly_commands(id_silly_command);


--
-- Name: silly_command_self_action_texts fk_id_silly_command; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silly_command_self_action_texts
    ADD CONSTRAINT fk_id_silly_command FOREIGN KEY (id_silly_command) REFERENCES public.silly_commands(id_silly_command);


--
-- Name: silly_command_texts fk_id_silly_command; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silly_command_texts
    ADD CONSTRAINT fk_id_silly_command FOREIGN KEY (id_silly_command) REFERENCES public.silly_commands(id_silly_command);


--
-- Name: silly_command_usage fk_id_silly_command; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.silly_command_usage
    ADD CONSTRAINT fk_id_silly_command FOREIGN KEY (id_silly_command) REFERENCES public.silly_commands(id_silly_command);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

