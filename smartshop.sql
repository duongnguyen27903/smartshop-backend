--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

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
-- Name: profile_gender_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.profile_gender_enum AS ENUM (
    'male',
    'female',
    'unknown'
);


ALTER TYPE public.profile_gender_enum OWNER TO postgres;

--
-- Name: profiles_gender_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.profiles_gender_enum AS ENUM (
    'male',
    'female',
    'unknown'
);


ALTER TYPE public.profiles_gender_enum OWNER TO postgres;

--
-- Name: transaction_histories_action_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.transaction_histories_action_enum AS ENUM (
    'deposit',
    'buy',
    'sell'
);


ALTER TYPE public.transaction_histories_action_enum OWNER TO postgres;

--
-- Name: users_role_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.users_role_enum AS ENUM (
    'admin',
    'user'
);


ALTER TYPE public.users_role_enum OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts (
    id integer NOT NULL,
    account_number character varying(12) NOT NULL,
    account_balance bigint DEFAULT '0'::bigint NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "userId" uuid NOT NULL,
    CONSTRAINT "CHK_54553455689b6efe16f04268d5" CHECK ((length(TRIM(BOTH FROM account_number)) = 12))
);


ALTER TABLE public.accounts OWNER TO postgres;

--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_id_seq OWNER TO postgres;

--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_id_seq OWNED BY public.accounts.id;


--
-- Name: bills; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bills (
    id integer NOT NULL,
    amount integer NOT NULL,
    cost bigint NOT NULL,
    billing_date timestamp without time zone DEFAULT now() NOT NULL,
    "productId" integer NOT NULL,
    account_number character varying(12) NOT NULL
);


ALTER TABLE public.bills OWNER TO postgres;

--
-- Name: bills_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bills_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bills_id_seq OWNER TO postgres;

--
-- Name: bills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bills_id_seq OWNED BY public.bills.id;


--
-- Name: brands; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.brands (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    "typeId" integer NOT NULL
);


ALTER TABLE public.brands OWNER TO postgres;

--
-- Name: brands_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.brands_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.brands_id_seq OWNER TO postgres;

--
-- Name: brands_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.brands_id_seq OWNED BY public.brands.id;


--
-- Name: car_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.car_types (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.car_types OWNER TO postgres;

--
-- Name: car_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.car_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.car_types_id_seq OWNER TO postgres;

--
-- Name: car_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.car_types_id_seq OWNED BY public.car_types.id;


--
-- Name: carts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carts (
    id integer NOT NULL,
    amount integer NOT NULL,
    "userId" uuid NOT NULL,
    "productId" integer NOT NULL
);


ALTER TABLE public.carts OWNER TO postgres;

--
-- Name: carts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.carts ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.carts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    description character varying NOT NULL,
    price integer NOT NULL,
    name character varying NOT NULL,
    quantity integer NOT NULL,
    "userId" uuid NOT NULL,
    "brandId" integer NOT NULL,
    image json
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profiles (
    id integer NOT NULL,
    first_name character varying(20),
    last_name character varying(20),
    birthday character varying(30),
    gender public.profiles_gender_enum,
    address character varying(100),
    "userId" uuid NOT NULL
);


ALTER TABLE public.profiles OWNER TO postgres;

--
-- Name: profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.profiles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profiles_id_seq OWNER TO postgres;

--
-- Name: profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.profiles_id_seq OWNED BY public.profiles.id;


--
-- Name: transaction_histories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transaction_histories (
    id integer NOT NULL,
    action public.transaction_histories_action_enum NOT NULL,
    note character varying(100),
    "timeAt" timestamp without time zone DEFAULT now() NOT NULL,
    amount bigint NOT NULL,
    account_number character varying(12) NOT NULL,
    "from" character varying(12),
    "billId" integer,
    CONSTRAINT "CHK_6b4c5b784af6bda1e5fb468b3a" CHECK ((((action = ANY (ARRAY['buy'::public.transaction_histories_action_enum, 'sell'::public.transaction_histories_action_enum])) AND ("billId" IS NOT NULL) AND ("from" IS NOT NULL)) OR ((action = 'deposit'::public.transaction_histories_action_enum) AND ("billId" IS NULL) AND ("from" IS NULL) AND (amount > 0)))),
    CONSTRAINT "CHK_b567a84c4ae0bf13bcd6d51e2e" CHECK (((account_number)::text <> ("from")::text))
);


ALTER TABLE public.transaction_histories OWNER TO postgres;

--
-- Name: transaction_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transaction_histories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transaction_histories_id_seq OWNER TO postgres;

--
-- Name: transaction_histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transaction_histories_id_seq OWNED BY public.transaction_histories.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "isBanned" boolean DEFAULT false NOT NULL,
    role public.users_role_enum DEFAULT 'user'::public.users_role_enum NOT NULL,
    "createAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updateAt" timestamp without time zone DEFAULT now() NOT NULL,
    email character varying(50) NOT NULL,
    password character varying(30) NOT NULL,
    username character varying(20) NOT NULL,
    phone_number character varying(30)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: accounts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts ALTER COLUMN id SET DEFAULT nextval('public.accounts_id_seq'::regclass);


--
-- Name: bills id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bills ALTER COLUMN id SET DEFAULT nextval('public.bills_id_seq'::regclass);


--
-- Name: brands id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands ALTER COLUMN id SET DEFAULT nextval('public.brands_id_seq'::regclass);


--
-- Name: car_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car_types ALTER COLUMN id SET DEFAULT nextval('public.car_types_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: profiles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles ALTER COLUMN id SET DEFAULT nextval('public.profiles_id_seq'::regclass);


--
-- Name: transaction_histories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_histories ALTER COLUMN id SET DEFAULT nextval('public.transaction_histories_id_seq'::regclass);


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts (id, account_number, account_balance, "isActive", "userId") FROM stdin;
7	024586739863	0	t	75e95ace-1f8e-4579-8273-41bae6d49195
4	024432910977	4894820	t	8b260762-9039-4ee0-b28e-052bd987ce85
6	024033762563	120	t	2eca0c07-0714-4fb2-b0d5-638679be3a70
3	012572048761	207301180	t	7a6b21e6-1add-4514-988b-8ec62f765bc0
1	012345678912	113114913	t	42f14c9c-944a-4c08-82bd-bfc4df28ff17
\.


--
-- Data for Name: bills; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bills (id, amount, cost, billing_date, "productId", account_number) FROM stdin;
3	1	100000	2024-04-15 05:33:29.402986	1	012572048761
4	1	100000	2024-04-15 05:38:38.463828	1	012572048761
13	1	200000	2024-04-15 21:03:25.273282	1	012572048761
14	1	200000	2024-04-15 21:03:54.106563	1	012572048761
15	1	200000	2024-04-15 21:04:31.306518	1	012572048761
16	1	200000	2024-04-15 21:04:34.024175	1	012572048761
17	1	200000	2024-04-15 21:04:34.919787	1	012572048761
18	1	200000	2024-04-15 21:04:35.686867	1	012572048761
19	1	249865	2024-04-15 21:40:38.591659	1	012572048761
20	1	249865	2024-04-15 21:41:36.718711	1	012572048761
21	1	45000	2024-04-16 00:27:56.135132	665	012572048761
22	3	135000	2024-04-16 00:28:05.196666	665	012572048761
23	1	5600000	2024-04-16 00:28:28.811859	2	012572048761
24	1	200000	2024-04-16 00:55:24.709162	1	012572048761
25	1	200000	2024-04-16 00:58:25.112219	1	012572048761
26	1	200000	2024-04-16 00:59:57.940502	1	012572048761
27	1	200000	2024-04-16 01:00:52.028836	1	012572048761
28	1	200000	2024-04-16 01:02:32.274704	1	012572048761
29	1	200000	2024-04-16 01:07:35.428592	1	012572048761
30	1	5600000	2024-04-16 01:17:05.488627	2	024432910977
31	1	5600000	2024-04-16 01:22:24.730203	2	024432910977
32	1	5600000	2024-04-16 01:27:07.926055	2	012572048761
33	1	5600000	2024-04-16 01:29:03.470771	2	012572048761
34	1	5600000	2024-04-16 01:32:02.88684	2	012572048761
35	1	2190000	2024-04-16 21:56:16.754076	604	012572048761
36	4	67644	2024-04-17 16:42:28.474789	164	012572048761
37	4	67644	2024-04-17 16:42:42.751716	164	012572048761
38	3	159885	2024-04-17 16:43:11.907723	106	012572048761
39	3	112470	2024-04-17 16:43:31.859982	423	012572048761
40	4	13600000	2024-04-17 16:43:53.411987	603	012572048761
41	5	36162600	2024-04-17 16:44:30.964158	25	012572048761
42	3	1301295	2024-04-18 04:18:43.463025	12	012572048761
43	1	433765	2024-04-18 04:18:56.78162	12	012572048761
44	10	810000	2024-08-01 19:29:23.498	664	012572048761
45	8	329880	2024-08-01 19:30:22.644747	410	012572048761
\.


--
-- Data for Name: brands; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.brands (id, name, "typeId") FROM stdin;
1	Tesla	7
2	Toyota	4
3	Ford	4
4	Honda	4
5	BMW	9
6	Subaru	4
7	Hyundai	4
8	Audi	9
9	Jeep	1
10	Porsche	4
11	Dodge	4
12	Ferrari	4
13	Jaguar	9
14	Lamborghini	4
15	Maserati	9
16	Bentley	4
17	Chrysler	4
18	Chevrolet Corvette	4
19	Cadillac	9
20	Mazda	4
21	Ford Mustang	4
22	Nissan	4
23	Alfa Romeo	9
24	Bugatti	9
25	Buick	4
26	Lexus	9
27	Rolls-Royce	4
28	Acura	9
29	Aston Martin	4
30	Chevrolet	4
31	Kia	4
32	Mercedes-Benz	9
33	Volkswagen	4
34	Volvo	9
35	McLaren	4
36	Mitsubishi	4
37	GMC	3
38	Infiniti	9
39	Lincoln	9
40	Peugeot	4
41	Pontiac	9
42	Saab	2
43	Genesis	9
44	Suzuki	4
45	Citroën	4
46	Fiat	4
47	Lotus	4
48	Mini	4
49	Peterbilt	3
50	Saturn	4
51	BMW M	2
52	General Motors	2
53	Kenworth	3
54	KTM	4
55	Land Rover	1
56	Maybach	4
57	Mercury	4
58	Oldsmobile	9
59	Renault	4
60	Dodge Viper	4
61	Koenigsegg	9
62	Mack	3
63	Scion	2
64	Škoda	4
65	Daewoo	4
66	Daimler	2
67	Opel	4
68	Datsun	3
69	Holden	4
70	Smart	4
71	Alpine	4
72	DS	9
73	Navistar	2
74	Nissan Nismo	2
75	Pagani	2
76	Rover	2
77	Vauxhall	4
78	Ariel	2
79	Isuzu	3
80	Paccar	2
81	Tata	2
82	Abarth	2
83	Hummer	1
84	SEAT	4
85	Karma	7
86	Lucid	7
87	Saleen	2
88	Studebaker	4
89	Western Star	3
90	Mercedes-AMG	2
91	Hennessey	2
92	Audi Sport	2
93	Dacia	4
94	Daihatsu	2
95	Fisker	7
96	Geo	4
97	Hino	3
98	Scania	3
99	Sterling	3
100	Packard	4
101	Great Wall	2
102	Eicher	3
103	International	3
104	IH	2
105	RAM	3
106	ABT	4
107	BYD	4
109	VinFast	7
\.


--
-- Data for Name: car_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.car_types (id, name) FROM stdin;
1	SUV
2	Sedan
3	Truck
5	Van
6	Hybrid
7	Electric Car
8	Hatchback
11	Sports Car
12	Convertible
4	Super Car
10	Luxury SUV Car
9	Luxury Car
\.


--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carts (id, amount, "userId", "productId") FROM stdin;
13	7	8a8499d5-dd1a-44f4-b6e3-b060d59e29c2	12
17	7	2eca0c07-0714-4fb2-b0d5-638679be3a70	1
29	8	7a6b21e6-1add-4514-988b-8ec62f765bc0	24
37	4	7a6b21e6-1add-4514-988b-8ec62f765bc0	604
38	2	7a6b21e6-1add-4514-988b-8ec62f765bc0	665
40	2	7a6b21e6-1add-4514-988b-8ec62f765bc0	10
45	1	7a6b21e6-1add-4514-988b-8ec62f765bc0	3
49	1	7a6b21e6-1add-4514-988b-8ec62f765bc0	4
50	2	8b260762-9039-4ee0-b28e-052bd987ce85	166
56	1	8b260762-9039-4ee0-b28e-052bd987ce85	2
42	1	7a6b21e6-1add-4514-988b-8ec62f765bc0	2
60	1	7a6b21e6-1add-4514-988b-8ec62f765bc0	508
12	1	7a6b21e6-1add-4514-988b-8ec62f765bc0	12
41	1	7a6b21e6-1add-4514-988b-8ec62f765bc0	6
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, description, price, name, quantity, "userId", "brandId", image) FROM stdin;
12	The 812GTS delivers the quintessential Ferrari experience, blending a naturally aspirated V-12 engine with a thoroughly modern chassis and exotic styling.	433765	2024 Ferrari 812	36	42f14c9c-944a-4c08-82bd-bfc4df28ff17	12	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-ferrari-812-gts-101-64caae4038b21.jpeg?crop=0.547xw:0.548xh;0.127xw,0.342xh&resize=700:*"}
664	Newcomer VinFast has ambitious plans to bring its brand to the North American electric-vehicle market, and those plans include the 2024 VF9 three-row SUV. 	81000	2024 VinFast VF9	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	109	{"img" : "https://hips.hearstapps.com/hmg-prod/images/vinfast-vf9-1-1-641daa6412e63.jpg?crop=1.00xw:0.848xh;0,0.142xh&resize=700:*"}
4	There's no mistaking the 657-hp 2024 Lamborghini Urus for anything other than the high-performance exotic SUV it is.	241843	2024 Lamborghini Urus	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	14	{"img":"https://hips.hearstapps.com/hmg-prod/images/2023-lamborghini-urus-performante-0476-644a6d5d75484.jpg?crop=0.663xw:0.560xh;0.131xw,0.281xh&resize=700:*"}
410	The aggressively styled 2024 Lexus IS is more of a sports sedan than its brand stablemates but still less hard-edged than its German rivals.	41235	2024 Lexus IS	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	26	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2021-lexus-is-500-f-sport-performance-286-1631033786.jpg?crop=0.510xw:0.432xh;0.337xw,0.502xh&resize=700:*"}
22	The F430 coupe and droptop Spider are fabulous cars, but the harder-core Scuderia models (the 430 Scuderia and 430 Scuderia Spider 16M) are even better.	6227394	2010 Ferrari F430	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	12	{"img" : "https://hips.hearstapps.com/hmg-prod/images/430-scuderia-1557779588.jpg?crop=1.00xw:0.921xh;0,0.0550xh&resize=700:*"}
23	The FF continues Ferrari’s tradition of offering at least one curious—often plus-sized—four-seater in its lineup.	7828235	2016 Ferrari FF	36	42f14c9c-944a-4c08-82bd-bfc4df28ff17	12	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2012-ferrari-ff-photo-394052-s-986x603-1557780060.jpg?crop=1.00xw:0.921xh;0,0.0550xh&resize=700:*"}
57	While other four-doors are sober and serene, the sexy Rapide is flat-out berserk.	241825	2019 Aston Martin Rapide	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	29	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2019-aston-martin-rapide-amr-101-1528815870.jpg?crop=1.00xw:0.927xh;0,0.0733xh&resize=700:*"}
79	The 2024 Audi S5 Sportback is a stylish and solid performer but it doesn't add as much joy to the drive as its top competitors. 	58595	2024 Audi S5 Sportback	33	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-audi-s5-sportback-104-649de3e15f440.jpg?crop=0.629xw:0.533xh;0.148xw,0.350xh&resize=700:*"}
99	The Audi Q6 e-tron is an upcoming electric SUV that will slot between the Q4 and Q8 e-tron, and it features a 456-hp dual-motor powertrain with all-wheel drive.	66000	2025 Audi Q6 e-tron	38	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-audi-q6-e-tron-163-65e5e30a26625.jpg?crop=0.670xw:0.565xh;0.0529xw,0.221xh&resize=700:*"}
161	With its sweeping roofline and muscular stance, the Gran Coupe disguises a pair of rear doors while retaining the sporty façade of the two-door on which it is based.	6182188	2019 BMW 6-series Gran Coupe	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2015-bmw-6-series-gran-coupe-mmp-1-1557251015.jpg?crop=0.891xw:0.819xh;0.0609xw,0.0916xh&resize=700:*"}
422	A trademark filed earlier this year foiled the surprise reveal of the 2026 Lexus TZ, which we speculate will be an all-electric SUV with three rows of seating. 	60000	2026 Lexus TZ	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	26	{"img" : "https://hips.hearstapps.com/hmg-prod/images/20211214-bev-36-1639491043.jpg?crop=1.00xw:0.846xh;0,0.125xh&resize=700:*"}
599	Not to be confused with the full-size NV, the 2021 Nissan NV200 is a compact cargo van intended for light-duty projects and aimed at budget-conscious buyers.	24805	2021 Nissan NV200	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	22	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2021-nissan-nv200-mmp-1-1610569961.jpg?crop=0.861xw:0.883xh;0.0561xw,0.0643xh&resize=700:*"}
657	The all-electric GMC Hummer EV SUV will have a smaller impact on carbon emissions than its infamous gas-powered predecessors, and a big impact on EVs. 	79995	2024 GMC Hummer EV SUV	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	37	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-gmc-hummer-ev-suv-302-6419ae6383a10.jpg?crop=0.761xw:0.642xh;0.194xw,0.190xh&resize=700:*"}
186	Although the 2025 Cadillac CT5 serves as the basis for the savage CT5-V Blackwing, entry-level models lack the driving zeal we love in the performance version. 	40000	2025 Cadillac CT5	32	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-cadillac-ct5-front-three-quarters-6500b97f73e1a.jpg?crop=0.751xw:0.751xh;0.103xw,0.249xh&resize=700:*"}
187	Cadillac is alone in building a rear-wheel-drive sports sedan with a V-8 engine and a manual transmission, and that's why the epic CT5-V Blackwing is so special.	96000	2025 Cadillac CT5-V Blackwing	37	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-ct5-v-ct5-v-blackwing-driving-65b00eeba728f.jpg?crop=0.643xw:0.546xh;0.293xw,0.202xh&resize=700:*"}
188	The reigning Cadillac of Cadillacs (until the Celestiq appears), the Escalade isn't just a prestige item, it's also an exceedingly well-executed large SUV.	83890	2024 Cadillac Escalade / Escalade ESV	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-cadillac-escalade-v-series-103-64f700d5f34cf.jpg?crop=0.660xw:0.557xh;0.293xw,0.357xh&resize=700:*"}
189	The all-new 2025 Cadillac Escalade IQ EV promises to serve as a rolling all-electric nightclub for the rich and famous—one with 750 horsepower.	99000	2025 Cadillac Escalade IQ	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-cadillac-escalade-iq-exterior-104-64d24e1030049.jpg?crop=0.822xw:1.00xh;0.155xw,0&resize=700:*"}
190	Cadillac's first entrant into the luxury EV SUV market is the Lyriq, which offers sharp styling, a modern cabin, and a driving range of up to 308 miles per charge. 	58590	2024 Cadillac Lyriq	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-cadillac-lyriq-luxury-awd-103-6463cff2277d1.jpg?crop=0.609xw:0.513xh;0.139xw,0.446xh&resize=700:*"}
191	The 2025 Optiq will serve as Cadillac’s new entry-level EV, and we expect this compact SUV to share its platform and powertrains with the Chevy Equinox EV. 	45000	2025 Cadillac Optiq	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-cadillac-optiq-front-three-quarters-6553c5de6d050.jpg?crop=0.681xw:0.510xh;0.293xw,0.275xh&resize=700:*"}
699	With an elegant design, an opulent cabin, and a practical body, the V90 Cross Country shows that SUVs aren’t the sole answer to the family car question. 	60995	2024 Volvo V90 Cross Country	39	42f14c9c-944a-4c08-82bd-bfc4df28ff17	34	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-volvo-v90-cross-country-102-64935e992ce4d.jpg?crop=0.505xw:0.425xh;0.287xw,0.357xh&resize=700:*"}
718	The beautifully designed and undeniably Scandinavian 2021 Volvo V90 is the vehicle of choice for upscale but quirky families looking to avoid SUV monotony.	52895	2021 Volvo V90	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	34	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2021-volov-v90-wagon-mmp-1-1626438735.jpg?crop=0.763xw:0.843xh;0.111xw,0.0440xh&resize=700:*"}
7	Arguably the godfather of supercars, the Lamborghini Countach returns with a retro design, an 802-hp hybrid powertrain—and it's already sold out. 	2640000	2022 Lamborghini Countach	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	14	{"img":"https://hips.hearstapps.com/hmg-prod/images/lamborghini-countach-lpi-800-4-111-1628616858.jpg?crop=1.00xw:1.00xh;0,0&resize=700:*"}
2	The Lamborghini Veneno is a limited production high performance sports car manufactured by Italian automobile manufacturer Lamborghini. Based on the Lamborghini Aventador, the Veneno was developed to celebrate Lamborghini's 50th anniversary.	5600000	2014 Lamborghini Veneno	18	42f14c9c-944a-4c08-82bd-bfc4df28ff17	14	{"img":"https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Geneva_MotorShow_2013_-_Lamborghini_Veneno_1.jpg/1280px-Geneva_MotorShow_2013_-_Lamborghini_Veneno_1.jpg"}
604	Eye-catching from every angle, the $2.19 million Pagani Utopia packs 851 horsepower and looks that demand attention from crowds no matter where it might be parked. 	2190000	2023 Pagani Utopia	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	75	{"img" : "https://hips.hearstapps.com/hmg-prod/images/pagani-utopia-101-1662854771.jpg?crop=0.959xw:0.809xh;0.0244xw,0.191xh&resize=700:*"}
192	Cadillac's forthcoming onslaught of electric SUVs will include the mid-size three-row Vistiq, which is expected to debut as a 2026 model. 	65000	2026 Cadillac Vistiq	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/images/my24-cadillac-vistiq-ap1-9599-102724-bg-vertical-65788a83a98fc.jpg?crop=0.795xw:0.634xh;0.111xw,0.261xh&resize=700:*"}
193	The 2024 Cadillac XT4 looks rich on the outside and seems a good value on paper, but it falls short of its luxury mission.	39090	2024 Cadillac XT4	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-cadillac-xt4-awd-sport-489-65c0f18fe125e.jpg?crop=0.700xw:0.590xh;0.272xw,0.336xh&resize=700:*"}
194	Despite its distinctive styling, ample cargo room and spacious interior, the aging XT5 lacks the cohesiveness of the luxury compact SUV segment leaders.	45290	2024 Cadillac XT5	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-cadillac-xt5-sport-102-1582774966.jpg?crop=0.720xw:0.609xh;0.119xw,0.308xh&resize=700:*"}
195	While spacious and handsomely styled, the Cadillac XT6 SUV feels like a placeholder as the automaker goes all-in on EVs.	50190	2024 Cadillac XT6	35	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-cadillac-xt6-103-64877ab38e275.jpg?crop=0.553xw:0.477xh;0.183xw,0.332xh&resize=700:*"}
196	Cadillac's new flagship is the ultra-expensive, hand-built Celestiq EV sedan, which blends dramatic styling elements from the brand’s heritage with a high-tech cabin.	340000	2024 Cadillac Celestiq	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-cadillac-celestiq-front-three-quarters-1666032837.jpg?crop=0.689xw:0.561xh;0.121xw,0.295xh&resize=700:*"}
197	The all-new 2025 Cadillac Escalade IQ EV promises to serve as a rolling all-electric nightclub for the rich and famous—one with 750 horsepower.	99000	2025 Cadillac Escalade IQ	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-cadillac-escalade-iq-exterior-104-64d24e1030049.jpg?crop=0.822xw:1.00xh;0.155xw,0&resize=700:*"}
198	Cadillac's first entrant into the luxury EV SUV market is the Lyriq, which offers sharp styling, a modern cabin, and a driving range of up to 308 miles per charge. 	58590	2024 Cadillac Lyriq	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-cadillac-lyriq-luxury-awd-103-6463cff2277d1.jpg?crop=0.609xw:0.513xh;0.139xw,0.446xh&resize=700:*"}
199	The 2025 Optiq will serve as Cadillac’s new entry-level EV, and we expect this compact SUV to share its platform and powertrains with the Chevy Equinox EV. 	45000	2025 Cadillac Optiq	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-cadillac-optiq-front-three-quarters-6553c5de6d050.jpg?crop=0.681xw:0.510xh;0.293xw,0.275xh&resize=700:*"}
200	Cadillac's forthcoming onslaught of electric SUVs will include the mid-size three-row Vistiq, which is expected to debut as a 2026 model. 	65000	2026 Cadillac Vistiq	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/images/my24-cadillac-vistiq-ap1-9599-102724-bg-vertical-65788a83a98fc.jpg?crop=0.795xw:0.634xh;0.111xw,0.261xh&resize=700:*"}
201	Combining impressive performance and distinctive styling in a tidy package, the ATS continues to challenge the best from Europe and Japan.	8696864	2019 Cadillac ATS	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2017-cadillac-ats-performance-1545072808.jpg?crop=1.00xw:0.929xh;0,0.0209xh&resize=700:*"}
202	The ATS-V is Cadillac’s athletic, muscle-bound contender, eager to represent the home team in the fight against other performance rides like the BMW M3 and M4.	5098989	2019 Cadillac ATS-V	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2016-cadillac-ats-v-sedan-1545072632.jpg?crop=1.00xw:0.932xh;0,0.0366xh&resize=700:*"}
203	With some affordable models and a beautiful exterior design, the 2020 Cadillac CT6 is a striking and engaging sedan, but it leaves high-end luxury at the door.	59990	2020 Cadillac CT6	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-cadillac-ct6-v-3-front-quarter-1564851658.jpg?crop=0.814xw:0.689xh;0.142xw,0.154xh&resize=700:*"}
204	In a field of luxury sports sedans that are directed more toward the posh end of that spectrum, the 2019 Cadillac CTS is a breath of fresh air for driving enthusiasts.	47990	2019 Cadillac CTS	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2017-cadillac-cts-rwd-v6-1545072218.jpg?crop=1.00xw:0.929xh;0,0.0654xh&resize=700:*"}
205	Now this is our kind of Cadillac: It’s got a supercharged 640-hp 6.	89290	2019 Cadillac CTS-V	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/images/3-2018-cadillac-cts-v-jameslipman-slide2-1527109001.jpg?crop=1.00xw:0.929xh;0,0.0602xh&resize=700:*"}
206	The DTS is conceived to please owners who prioritize posh living-room comfort.	486181	2011 Cadillac DTS	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/10q1/339566/2010-cadillac-dts-photo-344749-s-986x603.jpg?crop=1.00xw:0.919xh;0,0.0707xh&resize=700:*"}
207	It’s astonishing to look at, beautifully crafted inside and out, and the first electric-hybrid Cadillac since…ever.	907590	2016 Cadillac ELR	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/images/6-2014-cadillac-elr-coupe-plug-in-hybrid-tested-review-car-and-driver-photo-560433-s-original-1526410986.jpg?crop=1.00xw:0.924xh;0,0.0709xh&resize=700:*"}
208	The EXT is the strange union of the Escalade SUV and the Chevrolet Avalanche pickup, which means it has the fold-down Midgate that allows added cargo flexibility.	3013529	2013 Cadillac Escalade EXT	40	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/wp-content/uploads/2015/04/2002-Cadillac-Escalade-EXT-1011.jpg?crop=1.00xw:0.924xh;0,0.0394xh&resize=700:*"}
209	Cadillac’s SRX is an avant-garde alternative in a segment founded by the more unadventurous Lexus RX350.	3739451	2016 Cadillac SRX	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/09q3/286131/2010-cadillac-srx4-photo-286141-s-986x603.jpg?crop=1.00xw:0.929xh;0,0.0393xh&resize=700:*"}
210	The STS can hold its own on a challenging road, with a 302-hp V-6 and six-speed automatic transmission and either rear- or all-wheel drive.	1043926	2011 Cadillac STS	33	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/107033/2008-cadillac-sts-photo-109031-s-986x603.jpg?crop=1.00xw:0.927xh;0,0.0733xh&resize=700:*"}
211	The XLR is based on the Chevrolet Corvette, featuring a 320-hp V-8 under the hood, a folding hardtop, and offering back-road manners and performance on par with top European GT convertibles.	87055	2009 Cadillac XLR	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/images/cadillac-xlr-1539710940.jpg?crop=1.00xw:0.919xh;0,0.0419xh&resize=700:*"}
212	Large luxury has always been the name of the game for Cadillac, but its not-quite-a-flagship XTS sedan proves that the company is no longer at the head of the pack for land yachts.	47890	2019 Cadillac XTS	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2018-cadillac-xts-v-sport-awd-1545071127.jpg?crop=1.00xw:0.924xh;0,0.0759xh&resize=700:*"}
213	The 2024 Chevy Camaro is the bookend for the six generation of the pony car, which has been largely unchanged since it debuted for the 2016 model year. 	32495	2024 Chevrolet Camaro	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-chevrolet-camaro-ss-collectors-edition-1-647e1933c6c20.jpg?crop=0.827xw:0.853xh;0.0946xw,0.129xh&resize=700:*"}
214	The 650-hp 2024 Chevrolet Camaro ZL1 marks an end to eight years of the ultimate muscle car. 	75395	2024 Chevrolet Camaro ZL1	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-chevrolet-camaro-zl1-collectors-edition-647e05de95705.jpg?crop=1.00xw:0.844xh;0,0.0709xh&resize=700:*"}
215	With thrilling performance, an affordable price tag, and flashy styling, the 2024 Chevy Corvette honors the nameplate's legacy of being America's supercar.	69995	2024 Chevrolet Corvette	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-chevrolet-corvette-stingray-200-64ee087379290.jpg?crop=0.749xw:0.562xh;0.192xw,0.243xh&resize=700:*"}
216	With supercar performance and a hybrid powertrain, the 2024 Chevrolet Corvette E-Ray honors the nameplate's decades-old iconic status in a contemporary way.	106595	2024 Chevrolet Corvette E-Ray	34	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-chevrolet-crovette-e-ray-003-65242d5b1be6a.jpg?crop=0.616xw:0.231xh;0.236xw,0.575xh&resize=700:*"}
217	An all-electric variant of the iconic Corvette sports car has been confirmed, and it’s expected to debut in 2024 as a 2025 model. 	150000	2025 Chevrolet Corvette EV	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/screen-shot-2022-04-25-at-9-04-53-am-1650892119.png?crop=0.912xw:0.975xh;0.0147xw,0.0248xh&resize=700:*"}
164	Blending a tasteful yet aggressive design with extraordinary performance, the BMW M6 is a sexy beast indeed. 	16911	2018 BMW M6	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/51/2013-bmw-m6-coupe-inline2-photo-514051-s-original.jpg?crop=1.00xw:0.924xh;0,0.0761xh&resize=700:*"}
218	The 670-hp mid-engine Chevrolet Corvette Z06 is a screamer built for the track that also harbors enough comfort for daily use.	114395	2024 Chevrolet Corvette Z06	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-lightning-lap-chevrolet-corvette-z06-mu-101-1675450314.jpg?crop=0.667xw:0.563xh;0.0641xw,0.313xh&resize=700:*"}
219	The new ZR1 model will be the pinnacle of non-electrified Corvettes, adding turbochargers to the roaring Z06's V-8  to create a true Ferrari challenger.	150000	2025 Chevrolet Corvette ZR1	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/chevrolet-corvette-zr1-002-copy-65259f61eedc2.jpg?crop=1.00xw:0.844xh;0,0.0733xh&resize=700:*"}
220	For those seeking a new Chevy sedan, the 2024 Malibu is the only option, but it exists in a segment full of more impressive alternatives.	26195	2024 Chevrolet Malibu	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2019-chevrolet-malibu-rs-124-1568289291.jpg?crop=0.800xw:0.734xh;0.0537xw,0.197xh&resize=700:*"}
221	The Blazer is neither luxurious nor a good value, but it's a spacious mid-size SUV that looks sporty and handles better than many of its competitors.	36795	2024 Chevrolet Blazer	39	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-chevrolet-blazer-awd-rs-286-6419bec64014d.jpg?crop=0.746xw:0.629xh;0.208xw,0.346xh&resize=700:*"}
222	The 2024 Chevy Blazer EV is an electric alternative to the gas-powered, mid-size SUV of the same name, with an all-new exterior and interior.	50195	2024 Chevrolet Blazer EV	39	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-chevrolet-blazer-ev-rs-103-65786c1f9e795.jpg?crop=1.00xw:0.846xh;0,0.0721xh&resize=700:*"}
223	Chevrolet is reportedly readying two- and four-door versions of a Camaro SUV, which is something we expect to see enter production in the next few years.	50000	2025 Chevrolet Camaro SUV	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/camaroev-watermark-copy-1670949420.jpg?crop=0.790xw:0.751xh;0.101xw,0.168xh&resize=700:*"}
224	The next vehicle to wear the Corvette name could well be an SUV—but don't worry, the sports car will carry on while a crossover and a sedan join the lineup. 	60000	2025 Chevrolet Corvette SUV	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/cdb050123-25cars-100-64344cd2efc64.jpg?crop=0.785xw:0.736xh;0.109xw,0.166xh&resize=700:*"}
225	The 2025 Equinox has been redesigned and restyled to look more like Chevy's more rugged SUVs, but it retains the old model's underpowered turbo four.	30000	2025 Chevrolet Equinox	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-chevrolet-equinox-rs-exterior-2-65ae0237b3e10.jpg?crop=0.652xw:0.622xh;0.292xw,0.253xh&resize=700:*"}
226	Chevy's on a roll electrifying its future lineup, and the 2024 Equinox EV will be the electric offering in the brand's compact SUV portfolio.	43295	2024 Chevrolet Equinox EV	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-chevrolet-equinox-ev-104-1662585429.jpg?crop=0.906xw:0.765xh;0.0423xw,0.169xh&resize=700:*"}
227	The full-size 2025 Chevrolet Suburban is built to handle big families , big loads, and towing needs that range from horse trailers to large RVs. 	62000	2025 Chevrolet Suburban	40	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-chevrolet-suburban-108-656506c302e3e.jpg?crop=0.702xw:0.591xh;0.194xw,0.264xh&resize=700:*"}
228	The 2025 Tahoe SUV is a mammoth three-row SUV with room for eight, a truck-based chassis, powerful engines, impressive towing capability, and refined handling. 	59000	2025 Chevrolet Tahoe	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-chevrolet-tahoe-102-65650874ea106.jpg?crop=0.710xw:0.601xh;0.179xw,0.197xh&resize=700:*"}
229	The 2024 Chevrolet Trailblazer subcompact crossover is refreshed with a sharper look and better standard equipment.	24395	2024 Chevrolet TrailBlazer	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-chevrolet-trailblazer-rs-awd-155-658096004ce7b.jpg?crop=0.655xw:0.552xh;0.293xw,0.384xh&resize=700:*"}
230	2024 marks a new generation for the Traverse SUV, and this time around Chevrolet is filling it with competitive technology and giving it a more rugged look.	39495	2024 Chevrolet Traverse	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/my24-chevy-traverse-rs-ap3-8893-64b2e4a728950.jpg?crop=0.766xw:0.645xh;0,0.206xh&resize=700:*"}
231	The 2024 Chevy Trax returns as a larger crossover with an affordable starting price and a strong offering of standard safety features.	21495	2024 Chevrolet Trax	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-chevrolet-trax-active-vs-2023-jeep-compass-sport-4x4-133-651d911e8ebf5.jpg?crop=0.598xw:0.505xh;0.207xw,0.317xh&resize=700:*"}
232	The 2024 Chevrolet Colorado is coming to a sandbox near you with an all-new ZR2 Bison off-road model that offers 35-inch tires and a lot of attitude. 	31095	2024 Chevrolet Colorado	37	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/chevrolet-colorado-zr2-fd-109-64400268b33af.jpg?crop=0.546xw:0.460xh;0.223xw,0.448xh&resize=700:*"}
233	For the work week that gets to 40 hours three days early, the 2024 Chevrolet Silverado 1500 offers the power and towing pull to get it all done.	37445	2024 Chevrolet Silverado 1500	39	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-chevrolet-silverado-1500-high-country-102-642dbddbe725d.jpg?crop=0.788xw:0.666xh;0.171xw,0.212xh&resize=700:*"}
234	Sprinkled with off-road goodies, the 2024 Chevrolet Silverado 1500 ZR2 is a good way to throw mud.  	71895	2024 Chevrolet Silverado 1500 ZR2	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-chevrolet-silverado-1500-zr2-101-643583a4b6edc.jpg?crop=0.635xw:0.536xh;0.0785xw,0.188xh&resize=700:*"}
235	Like a ten-pound hammer, the Chevy Silverado HD has the muscle to get big jobs done; but unlike that hammer, the truck also seats six and has an available diesel.	47000	2025 Chevrolet Silverado 2500HD / 3500HD	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-chevrolet-silverado-2500hd-zr2-bison-101-651ad757e4deb.jpg?crop=0.761xw:0.644xh;0.133xw,0.204xh&resize=700:*"}
236	Jumping into the electric pickup truck arena, Chevrolet announced it will launch an electric version of its Silverado light-duty truck for 2024. 	74800	2024 Chevrolet Silverado EV	34	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-chevrolet-silverado-ev-104-649360d0cd4ea.jpg?crop=0.811xw:0.685xh;0.0785xw,0.192xh&resize=700:*"}
237	Nearly three decades in, the Chevrolet Express continues to deliver the goods as a basic but rugged taskmaster with little regard for luxury or technology. 	42595	2024 Chevrolet Express	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-chevrolet-express-van-101-65777c320c834.jpg?crop=1.00xw:0.707xh;0,0.271xh&resize=700:*"}
238	The 2024 Chevy Blazer EV is an electric alternative to the gas-powered, mid-size SUV of the same name, with an all-new exterior and interior.	50195	2024 Chevrolet Blazer EV	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-chevrolet-blazer-ev-rs-103-65786c1f9e795.jpg?crop=1.00xw:0.846xh;0,0.0721xh&resize=700:*"}
381	The competition for the best electric vehicle is about to get dirtier with Jeep's upcoming Recon EV mid-size SUV. 	60000	2024 Jeep Recon EV	36	42f14c9c-944a-4c08-82bd-bfc4df28ff17	9	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-jeep-recon-101-1662583242.jpg?crop=1.00xw:0.861xh;0,0.139xh&resize=700:*"}
239	Chevrolet is reportedly readying two- and four-door versions of a Camaro SUV, which is something we expect to see enter production in the next few years.	50000	2025 Chevrolet Camaro SUV	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/camaroev-watermark-copy-1670949420.jpg?crop=0.790xw:0.751xh;0.101xw,0.168xh&resize=700:*"}
240	An all-electric variant of the iconic Corvette sports car has been confirmed, and it’s expected to debut in 2024 as a 2025 model. 	150000	2025 Chevrolet Corvette EV	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/screen-shot-2022-04-25-at-9-04-53-am-1650892119.png?crop=0.912xw:0.975xh;0.0147xw,0.0248xh&resize=700:*"}
241	Chevy's on a roll electrifying its future lineup, and the 2024 Equinox EV will be the electric offering in the brand's compact SUV portfolio.	43295	2024 Chevrolet Equinox EV	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-chevrolet-equinox-ev-104-1662585429.jpg?crop=0.906xw:0.765xh;0.0423xw,0.169xh&resize=700:*"}
242	Jumping into the electric pickup truck arena, Chevrolet announced it will launch an electric version of its Silverado light-duty truck for 2024. 	74800	2024 Chevrolet Silverado EV	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-chevrolet-silverado-ev-104-649360d0cd4ea.jpg?crop=0.811xw:0.685xh;0.0785xw,0.192xh&resize=700:*"}
243	For a monster truck, the Avalanche drives pretty well, with good steering and brake-pedal feel.	6674797	2013 Chevrolet Avalanche	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/107033/2008-chevrolet-avalanche-photo-109032-s-986x603.jpg?crop=1.00xw:0.924xh;0,0.0236xh&resize=700:*"}
244	Built in Korea by Daewoo, the Aveo is basic transportation, and its attractive pricing includes lots of standard features.	9538895	2011 Chevrolet Aveo	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/248626/2009-chevrolet-aveo-lt-photo-248650-s-986x603.jpg?crop=0.963xw:0.885xh;0.0224xw,0.115xh&resize=700:*"}
245	Chevrolet’s 2023 Bolt EUV (Electric Utility Vehicle) offers a more spacious cabin than the Bolt hatchback as well as all-important SUV-like looks. 	28795	2023 Chevrolet Bolt EUV	38	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-chevrolet-bolt-euv-redline-edition-001-1654115619.jpg?crop=0.752xw:0.564xh;0.0472xw,0.213xh&resize=700:*"}
246	A fix for the battery and a massive price cut makes Chevrolet’s stubby little EV a much more attractive choice. 	27495	2023 Chevrolet Bolt EV	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-chevrolet-bolt-ev-101-1613168160.jpg?crop=0.857xw:0.724xh;0.0261xw,0.125xh&resize=700:*"}
247	The legendary Z/28 returns but forget the 80s: This one takes its inspiration from the original Z/28 of 1967.	9755028	2015 Chevrolet Camaro Z/28	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/14q1/581480/2014-chevrolet-camaro-z-28-photo-582581-s-986x603.jpg?crop=1.00xw:0.916xh;0,0.0838xh&resize=700:*"}
248	Lurking behind the bow tie on the grille is a Nissan NV200, but that’s not all bad.	5806411	2018 Chevrolet City Express	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/14q3/618844/2015-chevrolet-city-express-photo-623989-s-986x603.jpg?crop=1.00xw:0.921xh;0,0.0785xh&resize=700:*"}
249	2010 Cobalts are responsive and predictable, but lack pizzazz.	1656003	2010 Chevrolet Cobalt	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/107033/2008-chevrolet-cobalt-photo-109034-s-986x603.jpg?crop=1.00xw:0.921xh;0,0.0785xh&resize=700:*"}
250	Getting mentioned in the compact-car segment is no easy feat, but the Chevrolet Cruze is doing its best.	18870	2019 Chevrolet Cruze	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2019-chevrolet-cruze-and-cruzehatch-003-1561051831.jpg?crop=0.787xw:0.789xh;0.107xw,0.211xh&resize=700:*"}
251	A smooth-riding wagonette, the HHR (for Heritage High Roof) is an example of retro design that both looks good and works well in utilitarian terms: the boxy shape makes it roomy inside.	3513193	2011 Chevrolet HHR	34	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2009-chevrolet-hhr-ss-photo-251187-s-986x603-1558024674.jpg?crop=1.00xw:0.924xh;0,0.0759xh&resize=700:*"}
252	Since the nameplate's introduction way back in 1958, the Impala has offered large-car spaciousness at an affordable price, and this current generation is no different.	28895	2019 Chevrolet Impala	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2018-chevrolet-impala-1544730311.jpg?crop=1.00xw:0.924xh;0,0.0759xh&resize=700:*"}
253	The 2020 Chevy Sonic is basic transportation with a turbocharged engine and promises of driving excitement in an affordable package.	17595	2020 Chevrolet Sonic	35	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-chevrolet-sonic-mmp-1-1573491922.jpg?crop=0.873xw:0.882xh;0.00801xw,0.118xh&resize=700:*"}
3	Lamborghini combines a high-revving V-12 engine with three electric motors to create the 1001-hp 2024 Revuelto plug-in hybrid. 	608358	2024 Lamborghini Revuelto	32	42f14c9c-944a-4c08-82bd-bfc4df28ff17	14	{"img":"https://hips.hearstapps.com/hmg-prod/images/2024-lamborghini-revuelto-front-three-quarters-102-6421b7db0d727.jpg?crop=0.907xw:0.768xh;0.0668xw,0.164xh&resize=700:*"}
5	Lamborghini's first electric vehicle is previewed by the high-riding Lanzador concept car, which features two doors, four seats, and over 1341 horsepower. 	300000	2028 Lamborghini Lanzador	39	42f14c9c-944a-4c08-82bd-bfc4df28ff17	14	{"img":"https://hips.hearstapps.com/hmg-prod/images/lamborghini-lanzador-concept27-64df95cf7c0ec.jpg?crop=0.598xw:0.505xh;0.213xw,0.284xh&resize=700:*"}
6	The Lamborghini Aventador is one of the most exotic-looking cars in the world, and its final form roars into the sunset in limited numbers with a 769-hp V-12.	507353	2022 Lamborghini Aventador	34	42f14c9c-944a-4c08-82bd-bfc4df28ff17	14	{"img":"https://hips.hearstapps.com/hmg-prod/images/2022-lamborghini-aventador-109-1625607587.jpg?crop=0.750xw:0.632xh;0.183xw,0.233xh&resize=700:*"}
9	From the mellifluous sound of its V-12 engine to the much-copied scissor doors, the Murciélago is the archetypal Italian exotic.	362400	2009 Lamborghini Murcielago	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	14	{"img":"https://hips.hearstapps.com/hmg-prod/images/2007-lamborghini-murcielago-lp640-photo-56379-s-986x603-1558023590.jpg?crop=1.00xw:0.921xh;0,0.0602xh&resize=700:*"}
10	Packing an 808-hp hybrid V-12 powertrain that's powered by a supercapacitor, the Lamborghini Sián is a technically and visually outrageous hypercar.	3000000	2021 Lamborghini Sián	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	14	{"img":"https://hips.hearstapps.com/hmg-prod/images/2021-lamborghini-sian-121-1614969494.jpg?crop=0.724xw:0.611xh;0.248xw,0.317xh&resize=700:*"}
11	With fantastic dynamics and a musical soundtrack, Ferrari figures out the formula to make a hybrid V-6 that's faithful to its sacred performance philosophy. 	342205	2024 Ferrari 296	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	12	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-ferrari-296gtb-110-65df9932dfff5.jpg?crop=0.572xw:0.482xh;0.162xw,0.475xh&resize=700:*"}
13	Packing a 829-hp V-12, the Ferrari Daytona SP3 combines retro-inspired design with an ear-searing powertrain to create a piece of hypercar art. 	2226935	2024 Ferrari Daytona SP3	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	12	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-ferrari-daytona-sp3-102-1659298018.jpg?crop=0.699xw:0.589xh;0.151xw,0.284xh&resize=700:*"}
29	With updated looks, available all-wheel drive, and up to 355 horsepower, the 2024 Acura TLX is a bona fide sports sedan.	46195	2024 Acura TLX	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	28	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-acura-tlx-101-65a15c7815909.jpg?crop=0.559xw:0.471xh;0.170xw,0.368xh&resize=700:*"}
14	The 2024 Ferrari F8 blends world-class performance, exotic drop-top styling, and a thread of familial DNA in a surprisingly manageable supercar package.	330000	2024 Ferrari F8 Tributo / Spider	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	12	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-ferrari-f8-spyder-103-1593551679.jpg?crop=0.699xw:0.592xh;0.129xw,0.208xh&resize=700:*"}
15	The 2024 Ferrari Roma lets it all hang out this year with a new convertible Spider body style, adding to an already thrilling formula.  	247308	2024 Ferrari Roma	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	12	{"img" : "https://hips.hearstapps.com/hmg-prod/images/ferrari-roma-spider-2-64137a910bf1c.jpg?crop=0.660xw:0.489xh;0.171xw,0.278xh&resize=700:*"}
16	The term “plug-in hybrid" something dorky but practical. Surprise: The Ferrari SF90 packs a paradigm-shifting powertrain with up to 1016 horsepower. 	528764	2024 Ferrari SF90 Stradale	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	12	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-ferrari-sf90-xx-stradale-122-654a66978f827.jpg?crop=0.623xw:0.622xh;0.221xw,0.244xh&resize=700:*"}
17	Purists may be shocked by Ferrari's first SUV, the 2024 Purosangue, but there's no need to fear because it stays true to the brand's sporting ethos.	398350	2024 Ferrari Purosangue	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	12	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-ferrari-purosangue25-63ff822948d30.jpg?crop=0.715xw:0.603xh;0.123xw,0.288xh&resize=700:*"}
18	A treat for the senses, the 2020 Ferrari 488 Pista is a masterpiece of stunning design and thrilling performance. 	331000	2020 Ferrari 488 Pista	39	42f14c9c-944a-4c08-82bd-bfc4df28ff17	12	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2019-ferrari-488-pista-125-1528476287.jpg?crop=0.653xw:0.596xh;0.241xw,0.404xh&resize=700:*"}
19	Ferrari's most expensive offering, the front-engine 599 features aluminum construction, a thrilling V-12, and a driving experience that makes the price tag seem like a bargain.	5234532	2012 Ferrari 599GTB Fiorano	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	12	{"img" : "https://hips.hearstapps.com/hmg-prod/images/ferrari-fiorano-1557778248.jpg?crop=1.00xw:0.921xh;0,0.0785xh&resize=700:*"}
20	The California T is Ferrari’s return to forced induction, but where the last turbo Ferrari was the beastly F40, the T is far tamer.	2045634	2017 Ferrari California T	37	42f14c9c-944a-4c08-82bd-bfc4df28ff17	12	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2017-ferrari-california-t-101-1557779071.jpg?crop=1.00xw:0.924xh;0,0.0761xh&resize=700:*"}
8	Soon to be replaced by the Huracán, this baby bull still turns heads.	250000	2014 Lamborghini Gallardo	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	14	{"img":"https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/07q1/267362/2007-lamborghini-gallardo-superleggera-photo-246014-s-original.jpg?crop=1.00xw:0.924xh;0,0.0394xh&resize=700:*"}
1	The 2024 Huracán excels at everything important except being subtle, which makes it an ideal supercar and the perfect Lamborghini.	249865	2024 Lamborghini Huracán	12	42f14c9c-944a-4c08-82bd-bfc4df28ff17	14	{"img":"https://hips.hearstapps.com/hmg-prod/images/2023-lamborghini-huracan-sterrato127-6467c8f12dcce.jpg?crop=0.739xw:0.624xh;0.0977xw,0.351xh&resize=700:*"}
24	With a choice of powertrains, optional all-wheel drive, and enough room for four, the GTC4Lusso is a Ferrari you can drive every day of the year. 	263750	2020 Ferrari GTC4Lusso	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	12	{"img" : "https://hips.hearstapps.com/hmg-prod/images/170304-car-gtc4lusso-australia-1590010625.jpg?crop=0.795xw:0.672xh;0.122xw,0.188xh&resize=700:*"}
285	While the Dart is uniquely styled, it is otherwise a rather disappointing offering.	9067642	2016 Dodge Dart	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	11	{"img" : "https://hips.hearstapps.com/hmg-prod/images/dodge-dart-1557776035.jpg?crop=1.00xw:0.924xh;0,0.0759xh&resize=700:*"}
26	The Portofino M is a relatively obtainable, drop-top Ferrari that pumps out 612 horsepower and 561 pound-feet of torque, and is both capable and comfortable. 	250052	2023 Ferrari Portofino	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	12	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2021-ferrari-portofino-m-117-1621623712.jpg?crop=0.806xw:0.680xh;0.0505xw,0.291xh&resize=700:*"}
27	The 2024 Integra is Acura's entrant to the entry-luxury compact car segment, but it shares too much with the Honda Civic to take on more premium rivals.	32995	2024 Acura Integra	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	28	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-acura-integra-a-spec-266-1655932857.jpg?crop=0.585xw:0.492xh;0.340xw,0.489xh&resize=700:*"}
21	Sure, it costs more than a house, but the metal-melting aria from that incredibly operatic engine is priceless.	493750	2016 Ferrari F12berlinetta	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	12	{"img" : "https://hips.hearstapps.com/hmg-prod/images/f12-berlinetta-1557779302.jpg?crop=1.00xw:0.924xh;0,0.0759xh&resize=700:*"}
30	With a handsome face and three rows of seats, the 2024 Acura MDX offers family-friendly transit in a premium wrapper—but it's not as luxe as its rivals.	51500	2024 Acura MDX	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	28	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-acura-mdx-type-s-comparison-101-1661794292.jpg?crop=0.694xw:0.587xh;0.166xw,0.259xh&resize=700:*"}
31	The 2024 Acura RDX lacks the performance and prestige of other compact-luxury SUVs, but it packs personality and attractive pricing.	45700	2024 Acura RDX	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	28	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-acura-rdx-sh-awd-a-spec-advance-492-1659479444.jpg?crop=0.668xw:0.561xh;0.282xw,0.439xh&resize=700:*"}
28	Combining impressive performance with tasteful styling and entry-level luxury appointments the Integra Type S is a welcome return to form for the Acura brand. 	52999	2024 Acura Integra Type S	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	28	{"img" : "https://hips.hearstapps.com/hmg-prod/images/dsc05984-649d90d2c4d47.jpg?crop=0.648xw:0.553xh;0.256xw,0.386xh&resize=700:*"}
33	Acura's first shot at an electric SUV will be the 2024 ZDX, which will utilize battery technology from General Motors.	65745	2024 Acura ZDX	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	28	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-acura-zdx-104-64dcee8c7e29e.jpg?crop=0.587xw:0.495xh;0.191xw,0.245xh&resize=700:*"}
32	Acura's first shot at an electric SUV will be the 2024 ZDX, which will utilize battery technology from General Motors.	65745	2024 Acura ZDX	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	28	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-acura-zdx-104-64dcee8c7e29e.jpg?crop=0.587xw:0.495xh;0.191xw,0.245xh&resize=700:*"}
35	If the idea of a supercar that you can drive daily is intriguing, the 2022 Acura NSX makes a great option and offers enough comfort and practicality for the task.	171495	2022 Acura NSX	33	42f14c9c-944a-4c08-82bd-bfc4df28ff17	28	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-acura-nsx-type-s-1-1628792637.jpg?crop=0.897xw:0.765xh;0.00481xw,0.0680xh&resize=700:*"}
36	The RL sits atop Acura’s sedan lineup and is smooth, quiet, and posh, with many high-tech features.	64000	2012 Acura RL	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	28	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/04q4/267353/acura-rl-photo-9212-s-original.jpg?crop=1.00xw:0.921xh;0,0.0787xh&resize=700:*"}
34	If the thought of parking a Honda Civic in your driveway is just too lowbrow for you, consider its country club-raised cousin, the 2022 Acura ILX.	28395	2022 Acura ILX	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	28	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2021-acura-ilx-a-spec-054-source-1627596231.jpg?crop=1.00xw:0.846xh;0,0.0865xh&resize=700:*"}
38	Acura’s Ohio-built mid-size sedan may not be beautiful, but it does bring a lot of luxury and technology for the money.	78085	2014 Acura TL	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	28	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2012-acura-tl-sh-awd-photo-403044-s-986x603-1557780552.jpg?crop=1.00xw:0.923xh;0,0.0661xh&resize=700:*"}
39	With the small ILX sedan introduced for 2013, Acura’s TSX is no longer the baby of the family.	52472	2014 Acura TSX	36	42f14c9c-944a-4c08-82bd-bfc4df28ff17	28	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/243496/2009-acura-tsx-photo-243505-s-986x603.jpg?crop=1.00xw:0.849xh;0,0.125xh&resize=700:*"}
37	With innumerable standard features and an NSX-derived hybrid system, the RLX is a really nice car as long as its luxury shortcomings are accepted.	55925	2020 Acura RLX	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	28	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-acura-rlx-mmp-1-1570640451.jpg?crop=0.906xw:0.763xh;0.0945xw,0.237xh&resize=700:*"}
42	Italy may be best known for pasta, but it's the country's cars, such as the Alfa Romeo Giulia Quadrifoglio, that live rent-free in the minds of car enthusiasts.	81855	2024 Alfa Romeo Giulia Quadrifoglio	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	23	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-alfa-romeo-giulia-quadrifoglio-100th-anniversario-116-643962c48c32c.jpg?crop=0.498xw:0.421xh;0,0.474xh&resize=700:*"}
25	Above sports cars, there are exotic sports cars—and then there’s the LaFerrari.	7232520	2015 Ferrari LaFerrari	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	12	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2015-ferrari-laferrari-106-1557780467.jpg?crop=1.00xw:0.927xh;0,0.0471xh&resize=700:*"}
46	Despite its shoddy interior and fussy convertible top, the Alfa Romeo 4C is one of only a handful of modern, affordable cars that make every trip feel truly special.	68745	2020 Alfa Romeo 4C	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	23	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-alfa-romeo-4c-103-1607964762.jpg?crop=0.809xw:0.680xh;0.112xw,0.320xh&resize=700:*"}
40	With the limited production 33 Stradale, Alfa Romeo is back in the sports car game with a million-dollar entry that's powered either by gas or electricity.	1000000	2025 Alfa Romeo 33 Stradale	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	23	{"img" : "https://hips.hearstapps.com/hmg-prod/images/alfa-romeo-33-stradale-1-64ef1d3779ef4.jpg?crop=0.875xw:0.879xh;0,0.0867xh&resize=700:*"}
41	Few sports sedans can match the 2024 Alfa Romeo Giulia when it comes to joyful road manners, and as a bonus, it wears a stunning wardrobe of Italian couture. 	44935	2024 Alfa Romeo Giulia	40	42f14c9c-944a-4c08-82bd-bfc4df28ff17	23	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-alfa-romeo-giulia-108-6400fe6bc909a.jpeg?crop=0.754xw:0.638xh;0.153xw,0.254xh&resize=700:*"}
48	A powerful V-8, cushy ride, and stop-you-in-your-tracks styling should make the DB12 an honorable replacement for the outgoing DB11 grand tourer. 	248086	2024 Aston Martin DB12	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	29	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-aston-martin-db12-125-64933aa0a739d.jpg?crop=0.909xw:0.767xh;0.0401xw,0.233xh&resize=700:*"}
295	The tiny 500 goes from pipsqueak to badass as the hot-rod Abarth, the heart of which is a raucous 160-hp turbocharged four-cylinder.	24730	2019 Fiat 500 / 500C Abarth	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	46	{"img" : "https://hips.hearstapps.com/hmg-prod/images/ft019-013fhn2n0ltfe3cl0l6domjo8p3icdj-1557781640.jpg?crop=1.00xw:0.846xh;0,0.154xh&resize=700:*"}
43	The 2024 Alfa Romeo Stelvio gets updated with new headlights backed by LED matrix tech, new taillights, and a new reconfigurable digital gauge cluster. 	47545	2024 Alfa Romeo Stelvio	38	42f14c9c-944a-4c08-82bd-bfc4df28ff17	23	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-alfa-romeo-stelvio-102-jpeg-63ffa98aa7813.jpeg?crop=0.689xw:0.582xh;0.132xw,0.289xh&resize=700:*"}
44	The 2024 Alfa Romeo Stelvio Quadrifoglio takes everything you hate about crossovers and replaces it with 505 horsepower and supreme driving characteristics. 	94965	2024 Alfa Romeo Stelvio Quadrifoglio	34	42f14c9c-944a-4c08-82bd-bfc4df28ff17	23	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-alfa-romeo-stelvio-quadrifoglio-100th-anniversario-121-643863117ff03.jpg?crop=0.723xw:0.611xh;0.163xw,0.215xh&resize=700:*"}
45	With seductive Italian styling and a 285-hp plug-in-hybrid powertrain, the 2024 Alfa Romeo Tonale looks like a compelling subcompact luxury crossover.	45440	2024 Alfa Romeo Tonale	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	23	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-alfa-romeo-tonale-eawd-466-6525bc1cc29f7.jpg?crop=0.630xw:0.530xh;0.107xw,0.403xh&resize=700:*"}
55	With a 715-hp V-12, the 2023 Aston Martin DBS is so quick that passersby will have no time to appreciate its sculpted sheetmetal as it speeds into the distance.	333686	2023 Aston Martin DBS	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	29	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-aston-martin-dbs-101-1673450308.jpg?crop=0.896xw:0.753xh;0.104xw,0.161xh&resize=700:*"}
47	Leading Alfa Romeo’s charge back into the United States‚ to be followed by more mainstream models by 2010‚ is the achingly gorgeous 8C.	52372	2010 Alfa Romeo 8C	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	23	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2010-alfa-romeo-8c-spider-photo-292205-s-986x603-1529610236.jpg?crop=1.00xw:0.926xh;0,0.0743xh&resize=700:*"}
58	The 2019 Aston Martin Vanquish is one of the loveliest things on four wheels and the British brand's grandest grand tourer.	723783	2019 Aston Martin Vanquish	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	29	{"img" : "https://hips.hearstapps.com/hmg-prod/images/6-2017-aston-martin-vanquish-s-man-slide7-1527109001.jpg?crop=0.840xw:0.772xh;0.133xw,0.228xh&resize=700:*"}
49	Aston Martin makes the move to a mid-engine layout with the forthcoming Valhalla hypercar, which will combine futuristic styling and ultra-high performance.	800000	2024 Aston Martin Valhalla	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	29	{"img" : "https://hips.hearstapps.com/hmg-prod/images/aston-martin-valhalla-101-1626200852.jpg?crop=1.00xw:0.847xh;0,0.153xh&resize=700:*"}
50	A genuine automotive unicorn, the Aston Martin Valkyrie hypercar abandons rational thought in the pursuit of speed and passion. 	3500000	2024 Aston Martin Valkyrie	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	29	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-aston-martin-valkyrie-65b420df1e593.jpg?crop=1.00xw:0.846xh;0,0.0409xh&resize=700:*"}
51	Featuring a twin-turbo V-8, revised interior and exterior styling, and updated tech, the 2025 Vantage eases into the future without forgetting its past. 	190000	2025 Aston Martin Vantage	35	42f14c9c-944a-4c08-82bd-bfc4df28ff17	29	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-aston-martin-vantage-exterior-am-101-65c282659e11c.jpg?crop=0.559xw:0.557xh;0.183xw,0.233xh&resize=700:*"}
52	The 2024 Aston Martin DBX is a six-figure SUV that's more practical than its sports-car siblings but delivers the same high-end pedigree.	200086	2024 Aston Martin DBX	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	29	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-aston-martin-dbx-707-112-1662975223.jpg?crop=0.627xw:0.528xh;0.181xw,0.340xh&resize=700:*"}
53	The 2023 Aston Martin DB11 is race car lined with leather that delivers vicious performance in a package that's luxuriously comfortable.	220086	2023 Aston Martin DB11	34	42f14c9c-944a-4c08-82bd-bfc4df28ff17	29	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-aston-martin-db11-amr-106-1589946284.jpg?crop=0.840xw:0.709xh;0.0865xw,0.214xh&resize=700:*"}
54	The voluptuous and alluring DB9 GT is sure to get any driver’s pulse racing, especially after hearing its trademark growl from under the hood.	157246	2016 Aston Martin DB9 GT	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	29	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/wp-content/uploads/2016/02/2016-Aston-Martin-DB9-GT-111-876x535.jpg?crop=1.00xw:0.919xh;0,0.0812xh&resize=700:*"}
60	With the compact A3 sedan, Audi attempts to imbue the smallest car in its lineup with a premium feel—and mostly succeeds.	37000	2025 Audi A3	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-audi-a3-sedan-front-in-motion-65ef2c4d03100.jpg?crop=0.454xw:0.328xh;0.401xw,0.375xh&resize=700:*"}
56	Limited to 77 units worldwide and sporting a carbon monocoque chassis, a 7.	145667	2011 Aston Martin One-77	34	42f14c9c-944a-4c08-82bd-bfc4df28ff17	29	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/wp-content/uploads/2011/11/Aston-Martin-One-77-1280-782-626x382.jpg?crop=1.00xw:0.921xh;0,0.0787xh&resize=700:*"}
59	Following a subtle nose job for the DB9 in 2011, a newly shaped coupe based on the same underpinnings arrives on the scene this year.	432572	2012 Aston Martin Virage	40	42f14c9c-944a-4c08-82bd-bfc4df28ff17	29	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/11q1/391467/2012-aston-martin-virage-photo-392300-s-986x603.jpg?crop=1.00xw:0.927xh;0,0.0733xh&resize=700:*"}
62	Venturing off-road in a luxury station wagon might seem a silly endeavor, but the 2024 Audi A4 Allroad is designed to traverse grassy knolls and dirt paths. 	48695	2024 Audi A4 Allroad Quattro	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-audi-a4-allroad-quattro-102-64adbc48cd15e.jpg?crop=0.764xw:0.645xh;0.0472xw,0.203xh&resize=700:*"}
61	The A4 combines a satisfying driving experience, standard all-wheel drive, and a stout build in an understated yet elegant premium sedan.	42995	2024 Audi A4	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-audi-a4-103-64aefe768be8e.jpg?crop=0.474xw:0.401xh;0.269xw,0.313xh&resize=700:*"}
64	The A5 Sportback is as easy and fun to drive as the A5 coupe, and also offers junior A7 style, more room for people and luggage, and better fuel economy.	47295	2024 Audi A5 Sportback	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-audi-a5-sportback-102-64c921ec101a6.jpg?crop=0.832xw:0.702xh;0.0928xw,0.210xh&resize=700:*"}
63	A punchy engine, an agile suspension, and fine steering make the A5 easy to drive, while fetching lines and plenty of cargo room make it a compelling coupe.	49495	2024 Audi A5	35	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-audi-a5-101-64bacb64baa2d.jpg?crop=0.678xw:0.676xh;0.252xw,0.324xh&resize=700:*"}
66	The A6 Allroad is a luxury wagon dressed in hiking gear, with extra ground clearance and rugged styling cues that imbue it with it a ready-for-anything look.	70395	2024 Audi A6 Allroad	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-audi-a6-allroad-vs-beaver-island-204-1596464859.jpg?crop=0.479xw:0.406xh;0.362xw,0.491xh&resize=700:*"}
65	The 2024 A6 is the quintessential Audi luxury sedan, featuring a cabin stuffed with technology that's expertly put together using premium materials.	59195	2024 Audi A6	36	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-audi-a6-109-64761a1aaf416.jpg?crop=0.558xw:0.471xh;0.181xw,0.300xh&resize=700:*"}
69	The Audi A8 luxury sedan flies just below the style radar without skimping on comfort, performance or amenities.  	91995	2024 Audi A8	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-audi-a8-102-64b6b2b1ae524.jpg?crop=0.712xw:0.600xh;0.152xw,0.288xh&resize=700:*"}
67	Audi continues its electric-vehicle assault with the A6 e-tron sedan, which is aimed  directly at the Tesla Model S. 	80000	2025 Audi A6 e-tron	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/audi-a6-e-tron-concept-113-1618585274.jpg?crop=0.735xw:0.553xh;0.0489xw,0.323xh&resize=700:*"}
68	Audi's sleek, upscale and hatchback-practical A7 four-door sedan receives some minor equipment and design tweaks for the 2024 model year. 	73095	2024 Audi A7	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-audi-a7-103-64761bd3d4f80.jpg?crop=0.599xw:0.449xh;0.103xw,0.293xh&resize=700:*"}
70	Audi's take on the Porsche Taycan delivers thrilling performance but comes with a lofty price.	107995	2024 Audi e-tron GT	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-audi-rs-e-tron-gt-101-649dc205d9a24.jpg?crop=0.586xw:0.496xh;0.207xw,0.315xh&resize=700:*"}
77	The S4’s classy cabin and performance-oriented powertrain are wrapped in a handsome but subtle design, making the S4 a comfortable and capable sleeper. 	55595	2024 Audi S4	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-audi-s4-119-1583467050.jpg?crop=0.949xw:0.803xh;0.0513xw,0.0721xh&resize=700:*"}
71	The 2024 Audi RS3 is the sassiest version of the brand's smallest sedan, with a 401-hp turbo five-cylinder and a drift-capable all-wheel-drive system. 	63395	2024 Audi RS3	37	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-audi-rs3-101-64a59d674e821.jpg?crop=0.563xw:0.476xh;0.228xw,0.401xh&resize=700:*"}
72	With a shapely two-door body, powerful launch acceleration, and livable ride quality, the Audi RS5 is a compelling choice among supercoupes. 	80695	2024 Audi RS5	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-audi-rs-5-coupe-101-1664913723.jpg?crop=0.575xw:0.484xh;0.107xw,0.369xh&resize=700:*"}
73	Subtly muscular styling makes the RS5 Sportback a high-performance car that's relatively low-key, but it's a lively performer and more versatile than a sedan. 	80995	2024 Audi RS5 Sportback	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-audi-rs5-sportback-101-64ad735ff3ac8.jpg?crop=0.601xw:0.507xh;0.249xw,0.410xh&resize=700:*"}
74	With muscle-car power, sports-car handling, and room for five, the Audi RS6 Avant is multitalented station wagon that exists in a class of one.	127000	2025 Audi RS6 Avant	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-audi-rs6-avant-gt-motion-103-65bbc522aae10.jpg?crop=0.540xw:0.457xh;0.135xw,0.356xh&resize=700:*"}
75	Packing a manic 621 horsepower, the 2024 Audi RS7 can keep its passengers laughing all the way to traffic court and back. 	130195	2024 Audi RS7	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-audi-rs7-performance-motion-front-2-1669663936.jpg?crop=0.729xw:0.615xh;0.255xw,0.300xh&resize=700:*"}
76	The Audi S3 takes the inherent goodness of the standard A3 and ramps up the performance just enough to transform it into a highly civilized sports sedan. 	49000	2025 Audi S3	37	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/35061-a236884large-65cb9b4ca0cc6.jpg?crop=0.607xw:0.514xh;0.239xw,0.197xh&resize=700:*"}
80	The 2024 S6 takes Audi’s mid-size, mild-mannered A6 sedan and wakes it up with a zingy 444-hp twin-turbo V-6 engine and sportier suspension.	76595	2024 Audi S6	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-audi-s6-104-64761a1c5fd38.jpg?crop=0.598xw:0.456xh;0.359xw,0.403xh&resize=700:*"}
78	The 2024 Audi S5 coupe and convertible are sportier versions of the standard A5 but they lack the gusto to challenge the top competitors in their class.	58595	2024 Audi S5	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-audi-s5-101-649dda9e9a6a8.jpg?crop=0.808xw:0.682xh;0.0863xw,0.269xh&resize=700:*"}
82	Few cars blend luxury and performance quite like the 2023 Audi S8, which pumps up the humble A8's pace with a 563-hp twin-turbo V-8. 	124495	2024 Audi S8	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-audi-s8-fd-112-1649645153.jpg?crop=1.00xw:0.844xh;0,0.156xh&resize=700:*"}
81	The 2024 Audi S7 throws it down with a 444-hp twin-turbo V-6, all-wheel drive, and subtle looks that disguise its performance intentions.	86395	2024 Audi S7	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-audi-s7-sportback-101-64761c4dc0d77.jpg?crop=0.673xw:0.549xh;0.232xw,0.247xh&resize=700:*"}
86	The Audi Q6 e-tron is an upcoming electric SUV that will slot between the Q4 and Q8 e-tron, and it features a 456-hp dual-motor powertrain with all-wheel drive.	66000	2025 Audi Q6 e-tron	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-audi-q6-e-tron-163-65e5e30a26625.jpg?crop=0.670xw:0.565xh;0.0529xw,0.221xh&resize=700:*"}
83	The 2024 Audi Q3 brings the familial styling and ambiance of its larger stablemates at a comparably affordable price—but it lacks the zeal of its siblings.	38595	2024 Audi Q3	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-audi-q3-premium-45-119-64b19da0646ad.jpg?crop=0.697xw:0.587xh;0.161xw,0.301xh&resize=700:*"}
84	The 2024 Q4 e-tron democratizes Audi's electric offerings with a more approachable starting price and enough luxury to put it in contention with popular rivals.	50995	2024 Audi Q4 e-tron	38	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-audi-q4-sportback-e-tron-103-1664420054.jpg?crop=0.580xw:0.489xh;0.148xw,0.362xh&resize=700:*"}
85	Solid, comfortable, and well equipped, the Audi Q5 is a versatile and  rational vehicle, not an emotional one.	46495	2024 Audi Q5	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-audi-q5-prestige-103-64b04c303ecdb.jpg?crop=0.896xw:0.754xh;0.0619xw,0.185xh&resize=700:*"}
87	Audi's 2025 Q7 SUV takes the A6's sedan's combination of poise, luxury, and tech and implants it into a taller, three-row package.	61695	2025 Audi Q7	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-audi-q7-exterior-motion-101-65b912b91d9ca.jpg?crop=0.614xw:0.522xh;0.0497xw,0.322xh&resize=700:*"}
89	The Q8 e-tron is a stealth EV SUV, but Audi loyalists switching to electric propulsion will like that its vibe aligns with that of the brand's other offerings. 	75595	2024 Audi Q8 e-tron	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-audi-q8-sportback-s-line-e-tron-prestige-387-64b97354d78ca.jpg?crop=0.712xw:0.600xh;0.269xw,0.400xh&resize=700:*"}
88	A subtle makeover gives the 2024 Audi Q8 a freshened-up look, but it's largely the same comfy two-row luxury SUV as before.	74895	2024 Audi Q8	37	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-audi-q8-exterior-static-103-64f0ba52d994a.jpg?crop=0.923xw:0.751xh;0.0505xw,0.238xh&resize=700:*"}
90	Audi reserves the RS badge for its highest-performance vehicles, and the 2024 RS Q8 is the ultimate version of its top SUV model, the Q8.	126995	2024 Audi RS Q8	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2021-audi-rs-q8-235-1629827850.jpg?crop=0.686xw:0.576xh;0.169xw,0.424xh&resize=700:*"}
91	Well-equipped in any trim, the SQ5 offers a reasonable performance upgrade while never losing sight of balanced overall comfort. 	58895	2024 Audi SQ5	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-audi-sq5-ultra-blue-metallic-111-64b0459272050.jpg?crop=1.00xw:0.846xh;0,0.154xh&resize=700:*"}
97	Audi's take on the Porsche Taycan delivers thrilling performance but comes with a lofty price.	107995	2024 Audi e-tron GT	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-audi-rs-e-tron-gt-101-649dc205d9a24.jpg?crop=0.586xw:0.496xh;0.207xw,0.315xh&resize=700:*"}
92	Coming to a public charger near you sometime in 2024, the all-electric 2025 Audi SQ6 e-tron SUV packs all-wheel drive and as much as 509 horsepower. 	72000	2025 Audi SQ6 e-tron	33	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-audi-sq6-e-tron-149-65e5e3cc45475.jpg?crop=0.754xw:0.637xh;0.0187xw,0.184xh&resize=700:*"}
93	With big V-8 power, agile handling, and a plush three-row interior, the Audi SQ7 is an SUV that can do it all. 	92590	2025 Audi SQ7	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-audi-sq7-exterior-motion-101-65b912e0d6b3c.jpg?crop=0.814xw:0.688xh;0.0128xw,0.161xh&resize=700:*"}
94	With 500 horsepower and a suspension tuned for handling, the 2024 Audi SQ8's performance is a big step above the standard model.	97795	2024 Audi SQ8	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-audi-sq8-tfsi-119-64f0bd00b6742.jpg?crop=0.500xw:0.423xh;0.319xw,0.311xh&resize=700:*"}
95	The SQ8 e-tron boasts a 496-hp EV propulsion system and a snazzy cabin stocked with all the luxury goodies you'd expect in a high-end Audi. 	90995	2024 Audi SQ8 e-tron	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-audi-sq8-e-tron-101-6557be421ef65.jpg?crop=0.631xw:0.534xh;0.269xw,0.315xh&resize=700:*"}
96	Audi continues its electric-vehicle assault with the A6 e-tron sedan, which is aimed  directly at the Tesla Model S. 	80000	2025 Audi A6 e-tron	38	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/audi-a6-e-tron-concept-113-1618585274.jpg?crop=0.735xw:0.553xh;0.0489xw,0.323xh&resize=700:*"}
98	The 2024 Q4 e-tron democratizes Audi's electric offerings with a more approachable starting price and enough luxury to put it in contention with popular rivals.	50995	2024 Audi Q4 e-tron	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-audi-q4-sportback-e-tron-103-1664420054.jpg?crop=0.580xw:0.489xh;0.148xw,0.362xh&resize=700:*"}
139	Coming to a BMW showroom is the 2026 iX3, an electric sister ship to the next-generation gas-powered X3 SUV wearing the brand's future design language.	60000	2026 BMW iX3	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2026-bmw-ix3-101-65fc1b83a6809.jpg?crop=0.405xw:0.306xh;0.385xw,0.291xh&resize=700:*"}
100	The Q8 e-tron is a stealth EV SUV, but Audi loyalists switching to electric propulsion will like that its vibe aligns with that of the brand's other offerings. 	75595	2024 Audi Q8 e-tron	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-audi-q8-sportback-s-line-e-tron-prestige-387-64b97354d78ca.jpg?crop=0.712xw:0.600xh;0.269xw,0.400xh&resize=700:*"}
101	Coming to a public charger near you sometime in 2024, the all-electric 2025 Audi SQ6 e-tron SUV packs all-wheel drive and as much as 509 horsepower. 	72000	2025 Audi SQ6 e-tron	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-audi-sq6-e-tron-149-65e5e3cc45475.jpg?crop=0.754xw:0.637xh;0.0187xw,0.184xh&resize=700:*"}
102	The SQ8 e-tron boasts a 496-hp EV propulsion system and a snazzy cabin stocked with all the luxury goodies you'd expect in a high-end Audi. 	90995	2024 Audi SQ8 e-tron	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-audi-sq8-e-tron-101-6557be421ef65.jpg?crop=0.631xw:0.534xh;0.269xw,0.315xh&resize=700:*"}
103	A pleasing blend of hybrid and hatchback, the A3 e-tron gives you Audi cachet and power, plus an EPA-rated 83–86 MPGe.	7578756	2018 Audi A3 Sportback e-tron	34	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2016-audi-a3-e-tron-sportback-1545146537.jpg?crop=1.00xw:0.924xh;0,0.0761xh&resize=700:*"}
104	Audi's R8 supercar boasts a howling V-10 engine just behind its snug two-seat cabin, shares a chassis with the Lamborghini Huracán, and is on its way out.	161395	2023 Audi R8	32	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-audi-r8-gt-front-three-quarters-motion-3-1664827965.jpg?crop=0.684xw:0.577xh;0.0321xw,0.281xh&resize=700:*"}
105	The RS4 is an ultra-high-performance version of the small A4 that trades nimbleness for all-wheel-drive capability.	69785	2008 Audi RS4	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/182698/2008-audi-rs4-photo-182702-s-986x603.jpg?crop=1.00xw:0.927xh;0,0.0733xh&resize=700:*"}
107	Parked alongside killer sports cars like the Chevrolet Corvette and the Porsche 718 Cayman, the 2022 Audi TT RS looks appropriately aggressive and expensive. 	74295	2022 Audi TT RS	36	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-audi-tt-rs-mmp-1-1638998586.jpg?crop=1.00xw:0.754xh;0,0.103xh&resize=700:*"}
108	We can think of few better cars in which to tackle a long drive than the 2024 Bentley Continental GT—the choice between coupe or convertible is the hard part.	245425	2024 Bentley Continental GT	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	16	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-bentley-continental-gt-convertible-101-644bd404dcb7e.jpg?crop=0.752xw:0.635xh;0.216xw,0.276xh&resize=700:*"}
109	Whether behind the wheel of the 2024 Bentley Flying Spur or snuggled into one of its passenger seats, you're treated to an ultra-luxurious experience.	217625	2024 Bentley Flying Spur	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	16	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-bentley-flying-spur-644bddfb89ff4.jpg?crop=0.595xw:0.457xh;0.155xw,0.343xh&resize=700:*"}
110	If your two-car garage already has a Bentley Continental GT nestled into one of the bays, why not fill the other with a matching Bentayga SUV?	205925	2024 Bentley Bentayga	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	16	{"img" : "https://hips.hearstapps.com/hmg-prod/images/bentayga-ewb-mulliner-11-64dfb327ec8cb.jpg?crop=0.633xw:0.534xh;0.229xw,0.216xh&resize=700:*"}
111	A prestige sedan in the grand tradition, the Arnage is a sumptuous conveyance that ignores contemporary concerns such as mpg and price.	227585	2009 Bentley Arnage	39	42f14c9c-944a-4c08-82bd-bfc4df28ff17	16	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/228286/2009-bentley-arnage-final-series-photo-228294-s-986x603.jpg?crop=1.00xw:0.924xh;0,0.0759xh&resize=700:*"}
112	Bigger than life, the Azure is an ultraexclusive convertible.	4776114	2010 Bentley Azure	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	16	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/239743/2010-bentley-azure-t-photo-239760-s-986x603.jpg?crop=1.00xw:0.921xh;0,0.0785xh&resize=700:*"}
113	Named after an old racetrack in jolly old England, the Brooklands is a coupe version of the Azure convertible.	5055338	2010 Bentley Brooklands	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	16	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/216165/2009-bentley-brooklands-photo-216172-s-986x603.jpg?crop=1.00xw:0.921xh;0,0.0785xh&resize=700:*"}
114	If you’re interested in some very special numbers, here are a few big ones: 633 hp and 620 lb-ft of torque.	269625	2012 Bentley Continental GT Speed	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	16	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/wp-content/uploads/2015/06/2016-Bentley-Continental-GT-Speed-101.jpg?crop=1.00xw:0.924xh;0,0.0761xh&resize=700:*"}
115	The Mulsanne rewards those with means with its positively palatial cabin and an aristocratic pedigree that commands unrivaled prestige.	316525	2020 Bentley Mulsanne	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	16	{"img" : "https://hips.hearstapps.com/hmg-prod/images/mulsanne-extended-wheelbase-rose-gold-over-magnetic-04-jpg-1578934767.jpg?crop=0.736xw:0.621xh;0.182xw,0.379xh&resize=700:*"}
116	High-speed luxury motoring has a name and it's Bentley Mulsanne Speed, a car that offers old-school opulence and muscle-car hustle.	345025	2020 Bentley Mulsanne Speed	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	16	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-bentley-mulsanne-speed-mmp-1-1588796031.jpg?crop=0.923xw:0.785xh;0.0505xw,0.161xh&resize=700:*"}
117	The 2-series may not be the prettiest sports car, but punchy powertrains and nimble handing provide plenty of fun behind the wheel.	39795	2024 BMW 2-series	34	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-bmw-m20i-04-1641420758.jpg?crop=0.712xw:0.601xh;0.138xw,0.260xh&resize=700:*"}
118	The 2024 BMW 2-series Gran Coupe is an engaging sedan at an affordable price, but it falls short of the balance we expect from a modern BMW.	39395	2024 BMW 2-series Gran Coupe	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-bmw-228i-xdrive-gran-coupe-418-1585753115.jpg?crop=0.765xw:0.645xh;0,0.355xh&resize=700:*"}
119	The 3-series remains the sports sedan standard, combining an athletic chassis and luxurious cabin with an array of powerful and sophisticated powertrains.	45495	2024 BMW 3-series	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-bmw-m340i-xdrive-350-640f4198a073d.jpg?crop=0.696xw:0.585xh;0.184xw,0.388xh&resize=700:*"}
120	With two satisfying powertrains and European furnishings, the 2025 BMW 4-Series coupe and convertible blend luxury and performance in a fun, stylish package. 	51695	2025 BMW 4-series	38	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-bmw-m440i-coupe-front-three-quarters-65b931d35bf39.jpg?crop=0.728xw:0.615xh;0.176xw,0.197xh&resize=700:*"}
121	The considerably capable BMW 4-series Gran Coupe is well equipped and offers the aesthetic allure of a sporty two-door with the practicality of a sedan. 	49295	2024 BMW 4-series Gran Coupe	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-bmw-m440i-xdrive-gran-coupe-534-1658867021.jpg?crop=0.644xw:0.547xh;0.0994xw,0.439xh&resize=700:*"}
122	The 5-series has long served as BMW's middle-child sedan, offering a just-right size for buyers who can't fit a 7-series into their parking spot or their budget.	59000	2025 BMW 5-series	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-bmw-530i-xdrive-112-65808a4a155e9.jpg?crop=0.598xw:0.507xh;0.183xw,0.346xh&resize=700:*"}
123	BMW’s flagship sedan brings the sauce with strong performance and new technology features for 2025, enhanced by superb cabin amenities and quiet comfort.	98000	2025 BMW 7-series	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-bmw-760i-xdrive-104-64c806a1395ab.jpg?crop=0.627xw:0.529xh;0.139xw,0.421xh&resize=700:*"}
124	With its elegantly styled coupe and convertible models, the 2024 BMW 8-series lineup mixes grand proportions with luxurious appointments.	90395	2024 BMW 8-series	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-bmw-8-series-03-1643213321.jpg?crop=0.813xw:0.685xh;0.109xw,0.183xh&resize=700:*"}
125	Based on the 8-series coupe, the 2024 BMW 8-series Gran Coupe preserves the two-door's playful handling and roofline and adds the practicality of four doors. 	91795	2024 BMW 8-series Gran Coupe	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-bmw-8-series-gran-coupe-101-64872c9715e27.jpg?crop=0.832xw:0.702xh;0.0962xw,0.250xh&resize=700:*"}
126	The “Neue Klasse” 2026 BMW i3 sedan is an all-new electric sibling to the archetypal 3-series sport sedan—and a different direction for the brand's EVs. 	50000	2026 BMW i3	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/bmw-vision-neue-klasse-concept26-64e39f4e792eb.jpg?crop=0.670xw:0.567xh;0.269xw,0.387xh&resize=700:*"}
127	 The 2024 BMW i4 M50's intense performance warms our hearts to an all-electric future but the xDrive40's 307-mile driving range is worth celebrating too.  	53195	2024 BMW i4	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-bmw-i4-edrive40-104-1659059092.jpg?crop=0.650xw:0.551xh;0.166xw,0.325xh&resize=700:*"}
128	BMW's newest electric executive express is the mid-size 2025 i5 sedan, which fills the gap between the i4 and the extra-premium i7 in the automaker's EV lineup.	68000	2025 BMW i5	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-bmw-i5-edrive40-exterior-102-646d1892c851d.jpg?crop=1.00xw:0.846xh;0,0.154xh&resize=700:*"}
129	Packed to the gills with both tech and luxury features, the 2024 BMW i7 is an EV flagship for those who insist on having every electronic choice at their fingertips.	106695	2024 BMW i7	40	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-bmw-i7-m70-119-643d69e564b2a.jpg?crop=0.609xw:0.514xh;0.298xw,0.385xh&resize=700:*"}
130	BMW's hybrid halo car is expected to get a second chance as the company prepares a hotter replacement in the form of the 2026 i8 M.	160000	2026 BMW i8 M	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/bmw-vision-m-next-2-1561402880.jpg?crop=0.869xw:0.731xh;0.0657xw,0.216xh&resize=700:*"}
131	Though it shares its bones with the regular BMW 2-series, the 2024 M2 takes that car's already impressive performance and turns the heat way up.	64195	2024 BMW M2	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-bmw-m2-122-64bfdbf216fd2.jpg?crop=0.638xw:0.537xh;0.104xw,0.309xh&resize=700:*"}
132	The 2024 BMW M3 lineup is even crazier this year, with a new, lighter, 543-hp CS model that improves its already mind-blowing performance. 	76995	2024 BMW M3	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-bmw-m3-110-1674509061.jpg?crop=0.760xw:0.642xh;0.0641xw,0.243xh&resize=700:*"}
133	With an intoxicating twin-turbo inline-six and a razor-sharp chassis, the BMW M4 is a muscle-bound brute in search of its soft side. 	80095	2025 BMW M4	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-bmw-m4-coupe-front-three-quarters-motion-65b935ea5dde6.jpg?crop=0.888xw:0.752xh;0.0881xw,0.0865xh&resize=700:*"}
134	The next-generation M5 evolves into a plug-in-hybrid asphalt eater with a rumored 735 horsepower with the possibility of offering a Touring station wagon model.	120000	2025 BMW M5	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-bmw-m5-sedan-rendering-1676575610.jpg?crop=0.818xw:0.723xh;0.135xw,0.277xh&resize=700:*"}
135	The BMW M8 lives at the intersection where feral acceleration and tame handling meet grand touring luxury and a relatively friendly price. 	140795	2024 BMW M8	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-bmw-m8-102-649c413018299.jpeg?crop=0.873xw:0.736xh;0.0472xw,0.235xh&resize=700:*"}
136	617 horsepower, four doors, and an acceleration force so strong, you'd think the 2024 BMW M8 Gran Coupe was partially responsible for Earth's rotation. 	140795	2024 BMW M8 Gran Coupe	36	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-bmw-m8-competition-gran-coupe-102-1617900094.jpg?crop=0.784xw:0.663xh;0.167xw,0.202xh&resize=700:*"}
137	As the fun-loving drop-top companion to the Toyota Supra, the 2025 BMW Z4 brings similar performance but with a sun-worshipping twist.	55045	2025 BMW Z4	35	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-bmw-z4-102-65b9899370945.jpg?crop=1.00xw:0.378xh;0,0.324xh&resize=700:*"}
138	One of the best electric SUVs can be found in BMW's showroom right now in the 2025 iX, which offers up to 324 miles per charge and up to 610 horsepower.	88245	2025 BMW iX	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-bmw-ix-m60-108-1653422436.jpg?crop=0.825xw:0.695xh;0.119xw,0.0745xh&resize=700:*"}
140	BMW's entry-level SUV, the X1, has been a favorite of ours for some time thanks to its agile handling, eager nature, and practical shape. 	41495	2024 BMW X1	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-bmw-x1-front-three-quarters-101-649b105d0d18e.jpeg?crop=0.774xw:0.655xh;0.226xw,0.286xh&resize=700:*"}
141	Celebrating its second generation with more space and horsepower than before, the new 2024 BMW X2 sprinkles style onto the subcompact SUV segment.	42995	2024 BMW X2	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-bmw-x2-exterior-101-65200b104cbb5.jpg?crop=0.860xw:0.726xh;0.0554xw,0.264xh&resize=700:*"}
142	The 2024 BMW X3 SUV edges in on the 3-series sports sedan's territory with a satisfying blend of refinement and driver engagement.	47895	2024 BMW X3	37	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-bmw-x3-101-64e782a68ab3d.jpg?crop=0.945xw:0.809xh;0,0.156xh&resize=700:*"}
143	The 2024 BMW X3 M's few faults pale in comparison to the raucous driving that enthusiasts will love, without losing its inherent practicality.	76495	2024 BMW X3 M	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-bmw-x3-m-competition-152-6491b6f486656.jpg?crop=1.00xw:0.848xh;0,0.152xh&resize=700:*"}
144	The X4 serves as a stylish alternative to the more practical X3 crossover, combining sporty performance with a sleek fastback design that eats into cargo room.	55995	2024 BMW X4	37	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-bmw-x4-m40i-101-1623176654.jpg?crop=0.630xw:0.533xh;0.296xw,0.330xh&resize=700:*"}
145	The 2024 BMW X4 M lives up to its coupe-like styling with performance and handling that are nearly as good as the vaunted M4 sports car.	80095	2024 BMW X4 M	37	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-bmw-x4-m-competition-754-edit-1652284055.jpg?crop=0.634xw:0.539xh;0.0961xw,0.446xh&resize=700:*"}
146	It's not as much fun as a Porsche Cayenne nor as smooth-riding as a Genesis GV80 but the 2025 BMW X5 mid-size luxury SUV blends traits from both.   	66695	2025 BMW X5	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-bmw-x5-m60i-102-6602d48787fb7.jpg?crop=0.772xw:0.651xh;0.0897xw,0.171xh&resize=700:*"}
147	The 2024 X5 M Competition is an ultra-high-performance SUV that uses the same twin-turbo V-8 as BMW’s most powerful sedan, the M5.	123295	2024 BMW X5 M	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/p90495467-1677001973.jpg?crop=0.728xw:0.614xh;0.228xw,0.289xh&resize=700:*"}
148	With a balanced chassis, a pair of hearty engines, and a cozy interior, the BMW X6 trades off some utility and cargo space for a stylish, sloping roofline.	75495	2025 BMW X6	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-bmw-x6-112-1675791922.jpg?crop=0.804xw:0.678xh;0.0897xw,0.175xh&resize=700:*"}
149	BMW has enhanced the white-hot X6 M SUV for the 2024 model year with a new hybrid system, making the Competition pack standard, and giving it a visual refresh. 	128195	2024 BMW X6 M	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/p90495559-1677001917.jpg?crop=0.826xw:0.697xh;0.137xw,0.271xh&resize=700:*"}
150	With three eager powertrains, a luxurious interior, and unexpectedly agile handling, the X7 channels the traditional BMW spirit into a full-size SUV package.	84495	2025 BMW X7	32	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-bmw-x7-101-65d51e47938f4.jpg?crop=0.893xw:0.752xh;0.0240xw,0.233xh&resize=700:*"}
151	The 2025 BMW XM plug-in hybrid pairs plush furnishings with gobs of power and decent all-electric range, but it's an SUV at odds with itself.	162000	2025 BMW XM	35	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-bmw-xm-120-64947a0333e73.jpg?crop=0.777xw:0.654xh;0.171xw,0.322xh&resize=700:*"}
152	The “Neue Klasse” 2026 BMW i3 sedan is an all-new electric sibling to the archetypal 3-series sport sedan—and a different direction for the brand's EVs. 	50000	2026 BMW i3	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/bmw-vision-neue-klasse-concept26-64e39f4e792eb.jpg?crop=0.670xw:0.567xh;0.269xw,0.387xh&resize=700:*"}
153	 The 2024 BMW i4 M50's intense performance warms our hearts to an all-electric future but the xDrive40's 307-mile driving range is worth celebrating too.  	53195	2024 BMW i4	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-bmw-i4-edrive40-104-1659059092.jpg?crop=0.650xw:0.551xh;0.166xw,0.325xh&resize=700:*"}
154	BMW's newest electric executive express is the mid-size 2025 i5 sedan, which fills the gap between the i4 and the extra-premium i7 in the automaker's EV lineup.	68000	2025 BMW i5	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-bmw-i5-edrive40-exterior-102-646d1892c851d.jpg?crop=1.00xw:0.846xh;0,0.154xh&resize=700:*"}
155	Packed to the gills with both tech and luxury features, the 2024 BMW i7 is an EV flagship for those who insist on having every electronic choice at their fingertips.	106695	2024 BMW i7	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-bmw-i7-m70-119-643d69e564b2a.jpg?crop=0.609xw:0.514xh;0.298xw,0.385xh&resize=700:*"}
156	One of the best electric SUVs can be found in BMW's showroom right now in the 2025 iX, which offers up to 324 miles per charge and up to 610 horsepower.	88245	2025 BMW iX	39	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-bmw-ix-m60-108-1653422436.jpg?crop=0.825xw:0.695xh;0.119xw,0.0745xh&resize=700:*"}
157	Coming to a BMW showroom is the 2026 iX3, an electric sister ship to the next-generation gas-powered X3 SUV wearing the brand's future design language.	60000	2026 BMW iX3	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2026-bmw-ix3-101-65fc1b83a6809.jpg?crop=0.405xw:0.306xh;0.385xw,0.291xh&resize=700:*"}
158	The basic 128i is quick and relatively affordable.	2245438	2013 BMW 1-series	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2012-bmw-1-series-mmp-1565029829.jpg?crop=0.965xw:0.815xh;0.0353xw,0.185xh&resize=700:*"}
159	BMW's only wagon for the states comes in the form of the competent, practical, and stylish 3-series Sports Wagon.	1147849	2019 BMW 3-series Wagon	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/p90180536-highres-the-new-bmw-3-series-1557855349.jpg?crop=1.00xw:0.846xh;0,0.154xh&resize=700:*"}
160	The 6-series is BMW’s largest convertible offering, embodying the spirit of elegant, open-top grand touring in a most modern fashion.	87695	2018 BMW 6-series	39	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2016-bmw-650i-coupe-1545079701.jpg?crop=1.00xw:0.927xh;0,0.0733xh&resize=700:*"}
162	If you’re in the market for a luxury car but want something distinctive, BMW has you covered with the 6-series Gran Turismo.	1894990	2019 BMW 6-series Gran Turismo	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/4-2018-bmw-640i-gran-turismo-103-1523649101-lipman-1528922175.jpg?crop=1.00xw:0.937xh;0,0.0236xh&resize=700:*"}
163	The 2020 BMW i8 boasts outside-the-box styling and a plug-in powertrain that saves fuel, but it lacks the performance of more exotic sports cars.	148495	2020 BMW i8	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-bmwi8-mmp-1-1573836896.jpg?crop=0.897xw:0.756xh;0,0.244xh&resize=700:*"}
165	We think the “M” in M6 stands for more; here, BMW’s four-door “coupe” comes in a performance version with a sport-tuned chassis and a 560-hp twin-turbo.	122195	2019 BMW M6 Gran Coupe	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	5	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2015-bmw-m6-gran-coupe-mmp-1-1557257253.jpg?crop=1.00xw:0.927xh;0,0.0341xh&resize=700:*"}
166	The Bugatti Chiron takes the brand's heritage as well as its predecessor's performance and melds them together into one stunningly capable machine.	3300000	2022 Bugatti Chiron	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	24	{"img" : "https://hips.hearstapps.com/hmg-prod/images/bugatti-sur-mesure-chiron-pur-sport-106-1639069047.jpg?crop=0.766xw:0.647xh;0.234xw,0.353xh&resize=700:*"}
167	With 1500 horsepower, a 236-mph top speed, and a claimed 2.4-second time to 62 mph, the Bugatti Divo is the definition of a numbers car.  	5800000	2020 Bugatti Divo	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	24	{"img" : "https://hips.hearstapps.com/hmg-prod/images/14bugatti-divo-99leadgallery-1535035005.jpg?crop=0.941xw:0.864xh;0.0423xw,0.136xh&resize=700:*"}
168	Perhaps the greatest supercar ever, the Veyron 16.	7570930	2014 Bugatti Veyron	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	24	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/wp-content/uploads/2012/02/2013-Bugatti-Veyron-Grand-Sport-Vitesse-placement-626x382.jpg?crop=1.00xw:0.926xh;0,0.0743xh&resize=700:*"}
169	Buick's first all-electric SUV will be the Electra E5, which uses GM's Ultium battery platform and wears Buick's next-generation exterior design language. 	50000	2025 Buick Electra E5	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	25	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-buick-electra-e5-101-1671483918.jpg?crop=0.668xw:0.720xh;0.213xw,0.252xh&resize=700:*"}
170	Buick's family-friendly Enclave three-row SUV is said to be getting a full redesign for the 2025 model year, and design sketches allude to an edgy new look. 	46000	2025 Buick Enclave	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	25	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-buick-enclave-sketch-101-65b296f52fa69.jpg?crop=0.942xw:1.00xh;0.0577xw,0&resize=700:*"}
171	Relaxed, quiet, and attractively priced, the 2024 Encore GX is what we expect a junior Buick SUV to be—but its luxury ambitions aren't borne out in practice.	26895	2024 Buick Encore GX	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	25	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-buick-encore-gx-avenir-436-648092fb7c429.jpg?crop=0.657xw:0.554xh;0.280xw,0.446xh&resize=700:*"}
172	Buick isn't a brand that immediately springs to mind when it comes to luxury, but its 2024 Envision does its best to impersonate popular compact luxury SUVs.	37295	2024 Buick Envision	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	25	{"img" : "https://hips.hearstapps.com/hmg-prod/images/24my-buick-envision-exterior-64876ab0701c6.jpg?crop=0.813xw:0.685xh;0.187xw,0.205xh&resize=700:*"}
173	Buick's latest offering—the 2024 Envista—is set to take on subcompact SUV competitors with a sleek, coupe-like design and value-oriented pricing.	23495	2024 Buick Envista	32	42f14c9c-944a-4c08-82bd-bfc4df28ff17	25	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-buick-envista-avenir-fwd-105-edit-65427769278f9.jpg?crop=0.571xw:0.403xh;0.353xw,0.512xh&resize=700:*"}
174	Buick's first all-electric SUV will be the Electra E5, which uses GM's Ultium battery platform and wears Buick's next-generation exterior design language. 	50000	2025 Buick Electra E5	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	25	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-buick-electra-e5-101-1671483918.jpg?crop=0.668xw:0.720xh;0.213xw,0.252xh&resize=700:*"}
175	Buick knows that sometimes it's more fun to drop your top—hence the Cascada.	9237263	2019 Buick Cascada	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	25	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2016-buick-cascada-premium-1545074413.jpg?crop=1.00xw:0.932xh;0,0.0288xh&resize=700:*"}
176	Do not confuse the Encore with the newer and ever-so-slightly larger Encore GX; the standard 2022 Encore serves as the entry point to GM's semi-luxury SUV brand. 	26415	2022 Buick Encore	38	42f14c9c-944a-4c08-82bd-bfc4df28ff17	25	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-buick-encore-010-1628283636.jpg?crop=0.788xw:0.666xh;0.00641xw,0.264xh&resize=700:*"}
177	Old-school Buick luxury isn't evident in every vehicle bearing the tri-shield badge, but, for better or worse, the 2019 Buick LaCrosse has it in abundance.	30495	2019 Buick LaCrosse	34	42f14c9c-944a-4c08-82bd-bfc4df28ff17	25	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2018-buick-lacrosse-fwd-107-1531147783.jpg?crop=0.915xw:0.840xh;0.0353xw,0.160xh&resize=700:*"}
178	The front-drive Lucerne shares its platform with the Cadillac DTS and is a traditional American luxury sedan.	1639441	2011 Buick Lucerne	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	25	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/107663/2008-buick-lucerne-super-photo-121183-s-986x603.jpg?crop=1.00xw:0.919xh;0,0.0812xh&resize=700:*"}
179	Despite its comfy cabin and sleek styling, the Regal Sportback lacks the luxuriousness and sportiness its image suggests.	26295	2020 Buick Regal	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	25	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-buick-regal-sportback-mmp-1-1579126585.jpg?crop=0.834xw:0.832xh;0.114xw,0.168xh&resize=700:*"}
180	Despite its above-average driving dynamics and potent V-6 engine, the 2020 Buick Regal GS can't recreate the excitement found on the legendary GS models of old.	39995	2020 Buick Regal GS	34	42f14c9c-944a-4c08-82bd-bfc4df28ff17	25	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-buick-regal-gs-mmp-1-1579126115.jpg?crop=0.888xw:0.884xh;0.0700xw,0.116xh&resize=700:*"}
181	The 2020 Buick Regal TourX is worth consideration if you're looking for a mid-size wagon with a quiet cabin and loads of cargo space. 	30295	2020 Buick Regal TourX	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	25	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-buick-regal-tourx-mmp-1-1579126815.jpg?crop=0.878xw:0.878xh;0.0993xw,0.122xh&resize=700:*"}
182	Take Buick’s serene, smooth-riding luxury and distill it into a compact size, and you get the Verano.	3052994	2017 Buick Verano	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	25	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/wp-content/uploads/2012/08/2013-Buick-Verano-Turbo-626x382.jpg?crop=1.00xw:0.921xh;0,0.0315xh&resize=700:*"}
183	Cadillac's new flagship is the ultra-expensive, hand-built Celestiq EV sedan, which blends dramatic styling elements from the brand’s heritage with a high-tech cabin.	340000	2024 Cadillac Celestiq	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-cadillac-celestiq-front-three-quarters-1666032837.jpg?crop=0.689xw:0.561xh;0.121xw,0.295xh&resize=700:*"}
184	Edgy looks and pert handling make the 2024 CT4 an entertaining opener to the Cadillac lineup, and the CT4-V with the big turbo-four is where the party starts.	35990	2024 Cadillac CT4	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-cadillac-ct4-350t-rwd-104-65bd26c431d5b.jpg?crop=0.692xw:0.584xh;0.127xw,0.245xh&resize=700:*"}
185	With 472 ponies under the hood, the 2024 Cadillac CT4-V Blackwing is no pain and all joy in the world's automotive rodeo.	62890	2024 Cadillac CT4-V Blackwing	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	19	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-cadillac-ct4-v-blackwing-100-646e310f59709.jpg?crop=0.697xw:0.589xh;0.293xw,0.235xh&resize=700:*"}
254	The Chevy Spark is one of the smallest and least expensive subcompact hatches on the road, but thankfully it doesn't feel like it's from the bargain basement.	14595	2022 Chevrolet Spark	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-chevrolet-spark-mmp-1-1638552174.jpg?crop=0.994xw:0.843xh;0.00481xw,0.0628xh&resize=700:*"}
255	The Spark EV dials in some much needed fun by improving just about everything wrong with its gas-powered counterpart.	8493874	2016 Chevrolet Spark EV	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/14q1/573693/2014-chevrolet-spark-ev-photo-575143-s-986x603.jpg?crop=1.00xw:0.924xh;0,0.0131xh&resize=700:*"}
256	The Chevrolet SS is a rare large sedan with neck-snapping acceleration and an available manual transmission, making it the ideal sleeper.	6214581	2017 Chevrolet SS	32	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/672263/2017-chevrolet-ss-in-depth-model-review-car-and-driver-photo-701558-s-original.jpg?crop=0.712xw:0.657xh;0.164xw,0.128xh&resize=700:*"}
257	The Chevrolet Volt remains one of the best plug-in hybrids on the market, with impressive all-electric range and everyday practicality.	34395	2019 Chevrolet Volt	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	30	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2017-chevrolet-volt-premier-102-1551822035.jpg?crop=1.00xw:0.932xh;0,0.0576xh&resize=700:*"}
258	The Chrysler 300 sedan continues its long production run reinvigorated for the 2023 model year with the re-introduction of the 300C performance model. 	37740	2023 Chrysler 300	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	17	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-chrysler-300c-platinum-367-6494817562ef9.jpg?crop=0.623xw:0.525xh;0.216xw,0.434xh&resize=700:*"}
259	The wild Halcyon Concept previews the Chrysler brand's future, and—spoiler alert—it includes advanced tech and swoopy styling. 	60000	2028 Chrysler Halcyon	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	17	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2028-chrysler-halcyon-exterior-65ca884e7a5b7.jpg?crop=0.526xw:0.446xh;0.309xw,0.331xh&resize=700:*"}
260	Chrysler will likely launch an EV crossover in the near future called the Airflow, which will compete with models such as the Ford Mustang Mach-E. 	50000	2025 Chrysler Airflow	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	17	{"img" : "https://hips.hearstapps.com/hmg-prod/images/cn021-012chc94tscqm4f1m6qhpmd3qndnrru-1641391847.jpg?crop=1.00xw:1.00xh;0,0&resize=700:*"}
261	There for you when life broods three rows of pure chaos, the 2024 Chrysler Pacifica is the rational answer to a family's many and varied transportation needs.	40995	2024 Chrysler Pacifica	35	42f14c9c-944a-4c08-82bd-bfc4df28ff17	17	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-chrysler-pacifica-103-64c163bd834cd.jpg?crop=0.849xw:0.716xh;0.0700xw,0.220xh&resize=700:*"}
262	For those who didn't get the memo, the Dodge Caravan is officially dead, leaving the 2022 Voyager as the only choice for a budget minivan from Chrysler.	33610	2022 Chrysler Voyager	32	42f14c9c-944a-4c08-82bd-bfc4df28ff17	17	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-chrysler-voyager-mmp-1-1633445515.jpg?crop=1.00xw:0.994xh;0,0.00565xh&resize=700:*"}
263	Chrysler will likely launch an EV crossover in the near future called the Airflow, which will compete with models such as the Ford Mustang Mach-E. 	50000	2025 Chrysler Airflow	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	17	{"img" : "https://hips.hearstapps.com/hmg-prod/images/cn021-012chc94tscqm4f1m6qhpmd3qndnrru-1641391847.jpg?crop=1.00xw:1.00xh;0,0&resize=700:*"}
264	The wild Halcyon Concept previews the Chrysler brand's future, and—spoiler alert—it includes advanced tech and swoopy styling. 	60000	2028 Chrysler Halcyon	35	42f14c9c-944a-4c08-82bd-bfc4df28ff17	17	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2028-chrysler-halcyon-exterior-65ca884e7a5b7.jpg?crop=0.526xw:0.446xh;0.309xw,0.331xh&resize=700:*"}
265	Not the worst but not the best might be an accurate—if less than dazzling—description of the 200.	1295770	2017 Chrysler 200	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	17	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/wp-content/uploads/2016/08/2016-Chrysler-200-V-6-102.jpg?crop=1.00xw:0.846xh;0,0.154xh&resize=700:*"}
266	The 300 SRT follows an old-school recipe: SRT stuffed a big Hemi engine into a Chrysler 300 sedan—specifically a 470-hp, 6.	863433	2014 Chrysler 300 SRT	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	17	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/11q3/416729/2012-chrysler-300-srt8-photo-416975-s-986x603.jpg?crop=1.00xw:0.921xh;0,0.0785xh&resize=700:*"}
267	The Aspen rides and handles well for such a large, body-on-frame SUV.	35580	2009 Chrysler Aspen	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	17	{"img" : "https://hips.hearstapps.com/hmg-prod/images/chrysler-aspen-hybrid-1539702071.jpg?crop=1.00xw:0.921xh;0,0.0367xh&resize=700:*"}
268	The once-chic design is showing its age, but this compact five-door hatchback remains a versatile vehicle for its size.	8247408	2010 Chrysler PT Cruiser	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	17	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/199333/2008-chrysler-pt-cruiser-sunset-boulevard-edition-photo-199476-s-986x603.jpg?crop=1.00xw:0.916xh;0,0.0838xh&resize=700:*"}
269	The Sebring aims at the Honda Accord and Toyota Camry with a four-cylinder and two V-6s, a six-speed auto, and features such as a 20-gig hard drive for storing music.	6307689	2010 Chrysler Sebring	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	17	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/06q4/8898/2007-chrysler-sebring-photo-203735-s-original.jpg?crop=1.00xw:0.921xh;0,0.0787xh&resize=700:*"}
270	Whether it’s shuttling kids, hauling stuff or providing comfort and space to spread out on road trips, the Town & Country faithfully performs its duties well.	30990	2016 Chrysler Town & Country	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	17	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2014-chrysler-town-country-30th-anniversary-edition-203-1558025761.jpg?crop=1.00xw:0.924xh;0,0.0761xh&resize=700:*"}
271	The all-new 2025 Dodge Charger blends muscle-car design cues from the 1960s with a twin-turbo inline-six and the latest infotainment and driver-assistance tech.	40000	2025 Dodge Charger	36	42f14c9c-944a-4c08-82bd-bfc4df28ff17	11	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-dodge-charger-ice-65e63ab20155c.jpg?crop=0.837xw:0.643xh;0.0561xw,0.184xh&resize=700:*"}
272	The Dodge Charger Daytona EV coupe returns for 2025 accompanied by a new four-door sedan sibling, rounding out the muscle car's offerings.	50000	2025 Dodge Charger Daytona EV	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	11	{"img" : "https://hips.hearstapps.com/hmg-prod/images/dg024-040ch-65e74fca875ec.jpg?crop=1.00xw:1.00xh;0,0&resize=700:*"}
273	The 2024 Durango makes up for its fuel-thirsty engines and disappointing third row with impressive towing figures and braggadocio styling.	43265	2024 Dodge Durango	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	11	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-dodge-durango-102-64f1b07abf619.jpg?crop=0.822xw:0.695xh;0.137xw,0.234xh&resize=700:*"}
274	The Durango SRT 392 stands tall, unapologetically bringing massive V-8 power, macho looks, and a surprising utility to the family SUV class.	76590	2024 Dodge Durango SRT 392	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	11	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-dodge-durango-srt-392-101-64f1b54d744bd.jpg?crop=0.695xw:0.589xh;0.0847xw,0.252xh&resize=700:*"}
275	Blending a comically powerful supercharged V-8 with SUV utility, the 2024 Dodge Durango SRT Hellcat delivers both thrills and an unexpected level of comfort.	103590	2024 Dodge Durango SRT Hellcat	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	11	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-dodge-durango-srt-hellcat-103-64f1b2db9abb0.jpg?crop=0.762xw:0.645xh;0.0603xw,0.249xh&resize=700:*"}
276	While it may not have the V-8 muscle of the Dodge Durango, the 2024 Hornet SUV has plenty of sting for its compact size.	32995	2024 Dodge Hornet	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	11	{"img" : "https://hips.hearstapps.com/hmg-prod/images/dg023-013hn-6415b9a54054c.jpg?crop=0.630xw:0.531xh;0.125xw,0.303xh&resize=700:*"}
277	Dodge's first hybrid is the Hornet SUV, which offers some of the driving fun the brand is known for—but its price tag writes a check its powertrain can't cash. 	42995	2024 Dodge Hornet Hybrid	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	11	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-dodge-hornet-hybrid-101-65aa99ca06087.jpg?crop=0.707xw:0.599xh;0.129xw,0.311xh&resize=700:*"}
278	The Dodge Charger Daytona EV coupe returns for 2025 accompanied by a new four-door sedan sibling, rounding out the muscle car's offerings.	50000	2025 Dodge Charger Daytona EV	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	11	{"img" : "https://hips.hearstapps.com/hmg-prod/images/dg024-040ch-65e74fca875ec.jpg?crop=1.00xw:1.00xh;0,0&resize=700:*"}
279	Despite a thorough update in 2011, the Avenger has become less competitive as it nears the end of its life cycle—2014 was its last year in production.	4568242	2014 Dodge Avenger	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	11	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/11q1/392364/2011-dodge-avenger-heat-photo-392381-s-986x603.jpg?crop=1.00xw:0.921xh;0,0.0785xh&resize=700:*"}
280	There’s a five-speed manual and a continuously variable automatic transmission (CVT), which you should avoid if possible.	190383	2012 Dodge Caliber	34	42f14c9c-944a-4c08-82bd-bfc4df28ff17	11	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/06q2/267359/2007-dodge-caliber-photo-8989-s-original.jpg?crop=1.00xw:0.924xh;0,0.0761xh&resize=700:*"}
281	The 2023 Dodge Challenger is a blast from the past, with an old-school vibe that recalls the hot pony cars of the 1960s. 	34395	2023 Dodge Challenger	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	11	{"img" : "https://hips.hearstapps.com/hmg-prod/images/dg020-105cl-1574257068.jpg?crop=1.00xw:0.846xh;0,0.154xh&resize=700:*"}
282	The 2023 Dodge Challenger SRT Hellcat Redeye Widebody Jailbreak is an 807-hp run-on sentence that can fill a parking lot with smoke with one simple trick. 	71895	2023 Dodge Challenger SRT / SRT Hellcat	33	42f14c9c-944a-4c08-82bd-bfc4df28ff17	11	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2019-dodge-challenger-srt-hellcat-redeye-comparison-104-1581425446.jpg?crop=0.658xw:0.555xh;0.0896xw,0.293xh&resize=700:*"}
283	Coming to a drag strip near you, the 2023 Dodge Challenger SRT Demon 170 has up to 1025 horsepower and a propensity to pop wheelies.	100361	2023 Dodge Challenger SRT Demon	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	11	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-dodge-challenger-srt-demon-1701-6414d438e4a8a.jpg?crop=0.522xw:0.442xh;0.463xw,0.373xh&resize=700:*"}
284	If you’re lusting for the ultimate V-8 muscle car but need a sedan with room for the kids, the outrageous 2023 Dodge Charger SRT Hellcat is your ride.	86365	2023 Dodge Charger SRT	35	42f14c9c-944a-4c08-82bd-bfc4df28ff17	11	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2021-dodge-charger-srt-hellcat-redeye-103-1593634315.jpg?crop=0.811xw:0.685xh;0.103xw,0.147xh&resize=700:*"}
296	Despite vast cargo space, great visibility, and standard Apple CarPlay/Android Auto integration, the 500L is awkward to drive, awkward to behold, and impossible to love.	23995	2020 Fiat 500L	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	46	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-fiat-500l-mmp-1-1574184270.jpg?crop=1.00xw:0.864xh;0,0.129xh&resize=700:*"}
286	With its cheap cost of entry and handy fold-flat second and third row seats, the Grand Caravan is good enough for a vacation rental but not much more.	29025	2020 Dodge Grand Caravan	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	11	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-dodge-grand-caravan-mmp-1-1568059900.jpg?crop=0.678xw:0.762xh;0.322xw,0.173xh&resize=700:*"}
287	With lots of cabin space and an unbeatable price, the Dodge Journey is practical for families on a budget but is ultimately disappointing.	25170	2020 Dodge Journey	32	42f14c9c-944a-4c08-82bd-bfc4df28ff17	11	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-dodge-journey-mmp-1-1567701405.jpg?crop=0.759xw:0.641xh;0.137xw,0.271xh&resize=700:*"}
288	This is the wagon version of the 10Best-winning rear-drive Chrysler 300, and it oozes with swagger.	24120	2008 Dodge Magnum	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	11	{"img" : "https://hips.hearstapps.com/hmg-prod/images/d2006-107high-1557777224.jpg?crop=1.00xw:0.846xh;0,0.154xh&resize=700:*"}
289	The Nitro is a compact sport-utility with typical in-your-face Dodge styling.	7496863	2011 Dodge Nitro	32	42f14c9c-944a-4c08-82bd-bfc4df28ff17	11	{"img" : "https://hips.hearstapps.com/hmg-prod/images/dg012-001nt-1557777426.jpg?crop=1.00xw:0.779xh;0,0.221xh&resize=700:*"}
290	While fifth-generation Viper ended production in 2017, we thought an all-new model would debut in 2020, but the iconic nameplate is dead until further notice.	92990	2017 Dodge Viper	35	42f14c9c-944a-4c08-82bd-bfc4df28ff17	11	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2017-dodge-viper-1557777646.jpg?crop=1.00xw:0.924xh;0,0.0759xh&resize=700:*"}
291	Fiat's retro-cute 500 is coming back to North American roads in 2024 and this time will be offered exclusively with an electric powertrain. 	34095	2024 Fiat 500e	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	46	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-fiat-500e-inspired-by-beauty-exterior-103-65ef1b29a743f.jpg?crop=0.607xw:0.512xh;0.168xw,0.320xh&resize=700:*"}
292	Fiat's retro-cute 500 is coming back to North American roads in 2024 and this time will be offered exclusively with an electric powertrain. 	34095	2024 Fiat 500e	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	46	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-fiat-500e-inspired-by-beauty-exterior-103-65ef1b29a743f.jpg?crop=0.607xw:0.512xh;0.168xw,0.320xh&resize=700:*"}
293	The 124 Spider features a quieter cabin with a nicer interior and more trunk space than the Mazda Miata upon which it's based.	26885	2020 Fiat 124 Spider	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	46	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-fiat-124-mmp-1-1567620436.jpg?crop=0.798xw:0.675xh;0.189xw,0.242xh&resize=700:*"}
294	Say goodbye to boring with this adorable scoop of Italian gelato—the Fiat 500 is ready to brighten up your garage.	5309509	2019 Fiat 500	35	42f14c9c-944a-4c08-82bd-bfc4df28ff17	46	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2018-fiat-500-101-1557781050.jpg?crop=1.00xw:0.924xh;0,0.0759xh&resize=700:*"}
298	Electric vehicles with funky styling and innovative features are on their way from the reborn Fisker brand, and the 2026 Rōnin is set to be the halo car for the lineup.	385000	2026 Fisker Rōnin	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	95	{"img" : "https://hips.hearstapps.com/hmg-prod/images/20230806-ronin-silver-0608823-hm-153800-8192x5464-capklv-copy-64d67f5d601b4.jpg?crop=0.643xw:0.542xh;0.152xw,0.300xh&resize=700:*"}
297	Italians know fashion, and the 2023 Fiat 500X isn't short on style, even if it's essentially a Jeep Renegade without the off-road capability.	31840	2023 Fiat 500X	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	46	{"img" : "https://hips.hearstapps.com/hmg-prod/images/ft023-022fh-6571230980434.jpg?crop=0.894xw:0.712xh;0.0593xw,0.113xh&resize=700:*"}
302	The cheapest version,the EcoStandard, costs $103,000.	7046410	2013 Fisker Karma	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	95	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2012-fisker-karma-photo-386759-s-986x603-1557782266.jpg?crop=1.00xw:0.921xh;0,0.0785xh&resize=700:*"}
299	The 2024 Ocean a handsome SUV in the vein of the Range Rover Evoque and boasts some unique features—but its maker is under a financial cloud. 	41437	2024 Fisker Ocean	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	95	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-fisker-ocean-101-6509f4984104e.jpeg?crop=1.00xw:0.753xh;0,0.217xh&resize=700:*"}
300	Fledgling electric vehicle brand Fisker plans to democratize electric vehicles with the 2026 Pear, which will slot in below the Ocean SUV when it hits the market.	30000	2026 Fisker Pear	34	42f14c9c-944a-4c08-82bd-bfc4df28ff17	95	{"img" : "https://hips.hearstapps.com/hmg-prod/images/20230805-pear-blue-lights-on-060823-hm-204100-yt4mds-copy-64f0a8ae6fff0.jpg?crop=0.635xw:0.534xh;0.179xw,0.380xh&resize=700:*"}
301	The latest entrant to the burgeoning electric pickup truck segment is the 2025 Fisker Alaska, which rides on the same platform as the company's Ocean SUV.	45400	2025 Fisker Alaska	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	95	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-fisker-alaska-119-64de42623adc5.jpg?crop=0.625xw:0.528xh;0.200xw,0.350xh&resize=700:*"}
308	The 2024 Ford Expedition has a huge interior and high towing capacity, but the three-row SUV is limited by inaccurate steering and low-rent cabin materials.	57520	2024 Ford Expedition / Expedition Max	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-ford-expedition-stealth-performance-package-106-1632151771.jpg?crop=0.777xw:0.656xh;0.147xw,0.293xh&resize=700:*"}
303	The 2024 Ford Bronco continues to bring significant competition to Jeep and we're happy to watch them roll in the mud.	41525	2024 Ford Bronco	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2021-ford-bronco-23l-black-diamond-123-1627680376.jpg?crop=0.708xw:0.599xh;0.138xw,0.334xh&resize=700:*"}
304	If you're lusting for an SUV with extreme levels of performance, the 2024 Ford Bronco Raptor is an off-road predator with surprising versatility.	91930	2024 Ford Bronco Raptor	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-ford-bronco-raptor-493-1660609093.jpg?crop=0.566xw:0.477xh;0.221xw,0.312xh&resize=700:*"}
305	With similar styling cues and legit off-road chops, the Ford Bronco Sport gives people a taste of the bigger Bronco in a more accessible way. 	32825	2024 Ford Bronco Sport	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/fford-bronco-sport-free-wheeling-01-64c0342d89568.jpg?crop=0.832xw:0.721xh;0.0798xw,0.173xh&resize=700:*"}
306	While the Edge is comfortable, spacious, and offers a sporty ST model, the aging crossover struggles to stand out in a highly competitive segment.	39960	2024 Ford Edge	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-ford-edge-102-64ca62f95741e.jpg?crop=0.666xw:0.567xh;0.181xw,0.266xh&resize=700:*"}
307	The 2024 Escape looks good and offers a wide range of engines in a package that does the job adequately—but not nearly as well as the compact-SUV class’s best. 	30990	2024 Ford Escape	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-ford-escape-phev-110-64bfd22e1daec.jpg?crop=0.721xw:0.611xh;0.199xw,0.352xh&resize=700:*"}
313	Refreshed for 2024 with new looks and equipment, the high-performance Ford F-150 Raptor is NASCAR-meets-rally crazy. 	80325	2024 Ford F-150 Raptor	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-ford-f-150-raptor-08-64ff719e63c9b.jpg?crop=0.448xw:0.503xh;0.371xw,0.403xh&resize=700:*"}
309	The long-running Ford Explorer SUV wears a handsome exterior and offers powerful powertrains but lacks the overall refinement of the competition. 	41220	2025 Ford Explorer	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-ford-explorer-st-110-65ba6d640cbb3.jpg?crop=0.893xw:0.818xh;0.0897xw,0.130xh&resize=700:*"}
310	The Ford Mustang Mach-E is a Mustang in name only, but it is a first-rate electric SUV, a solid Tesla competitor—and its high-performance version is quick.	45390	2024 Ford Mustang Mach-E	37	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-ford-mustang-mach-e-rally-1-64f87f1882d10.jpg?crop=0.662xw:0.556xh;0.188xw,0.314xh&resize=700:*"}
311	When you think “pickup truck” it's the Ford F-150 that likely comes to mind,  and the 2024 model has evolved, with thoughtful tech and turbo engines.	38765	2024 Ford F-150	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-ford-f-150-platinum-exterior-103-64ff73e10c68e.jpg?crop=0.953xw:1.00xh;0.0407xw,0&resize=700:*"}
312	If not for its LED unibrow, it would be tough to tell the all-electric 2024 Ford F-150 Lightning pickup from the rest of its gas-powered full-size family. 	57090	2024 Ford F-150 Lightning	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-ford-f-150-lightning-tested-simari-101-1656624432.jpg?crop=0.674xw:0.570xh;0.151xw,0.364xh&resize=700:*"}
314	The 2024 Ford Maverick is a compact workhorse that earns its place next to the Ranger and F-150 with impressive payload capacity and stout tow capability.	25410	2024 Ford Maverick	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-ford-maverick-13-1633385592.jpg?crop=0.737xw:0.738xh;0.171xw,0.179xh&resize=700:*"}
316	With bulging bodywork and off-road-ready hardware, the Ford Ranger Raptor downsizes the badass style and rip-roaring thrills of the larger F-150 Raptor.	57065	2024 Ford Ranger Raptor	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/all-new-ford-ranger-raptor-02-65fc670613947.jpg?crop=0.590xw:0.747xh;0.101xw,0.162xh&resize=700:*"}
315	Ford's Ranger has received a total re-do for 2024 that arms it with the ammunition it needs to fight harder in the intensifying mid-size pickup truck wars. 	34265	2024 Ford Ranger	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-ford-ranger-108-65f83f89bcd53.jpg?crop=0.750xw:0.632xh;0.146xw,0.325xh&resize=700:*"}
317	The 2024 Ford Super Duty is one of the most versatile heavy-duty trucks, with commercial-grade capability and the ability to conquer most other tasks.	46965	2024 Ford Super Duty	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-ford-f250-super-duty-295-659c08fa8fe2c.jpg?crop=0.607xw:0.511xh;0.287xw,0.372xh&resize=700:*"}
318	The legendary pony car continues for a seventh generation as a coupe and convertible with powertrains ranging from a turbo-four to a snarling V-8. 	32515	2024 Ford Mustang	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-ford-mustang-gt-111-64e6608fce997.jpg?crop=0.639xw:0.538xh;0.00801xw,0.375xh&resize=700:*"}
319	Leave the fire suit at home; the 2025 Ford Mustang GTD brings race-car antics to normal roadways with giant fenders, a massive wing, and over 800 horsepower.	300000	2025 Ford Mustang GTD	33	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/ford-mustang-gtd-227-64de23ed5788d.jpg?crop=0.710xw:0.599xh;0.213xw,0.401xh&resize=700:*"}
320	Ford isn't horsing around with the upcoming 2026 Ford Mustang Raptor, which mixes mud and muscle car with over 700 horsepower. Yes, it's crazy. 	90000	2026 Ford Mustang Raptor / Raptor R	33	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2026-ford-mustang-raptor-watermark-101-6434644271434.jpg?crop=1.00xw:0.832xh;0,0.118xh&resize=700:*"}
321	The 2024 Ford E-Transit van offers all the versatility and cargo space of a traditional van with a zero-emission electric powertrain.	48590	2024 Ford E-Transit	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-ford-e-transit-111-1605139107.jpg?crop=0.651xw:0.661xh;0.256xw,0.278xh&resize=700:*"}
322	The Transit enhances the box-on-wheels blueprint with numerous configurations, decent driving dynamics, and technology to provide a superior van experience. 	48985	2024 Ford Transit	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-ford-transit-103-657771e9c6f6b.jpg?crop=1.00xw:0.847xh;0,0.0647xh&resize=700:*"}
323	The 2024 Ford E-Transit van offers all the versatility and cargo space of a traditional van with a zero-emission electric powertrain.	48590	2024 Ford E-Transit	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-ford-e-transit-111-1605139107.jpg?crop=0.651xw:0.661xh;0.256xw,0.278xh&resize=700:*"}
324	If not for its LED unibrow, it would be tough to tell the all-electric 2024 Ford F-150 Lightning pickup from the rest of its gas-powered full-size family. 	57090	2024 Ford F-150 Lightning	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-ford-f-150-lightning-tested-simari-101-1656624432.jpg?crop=0.674xw:0.570xh;0.151xw,0.364xh&resize=700:*"}
325	The Ford Mustang Mach-E is a Mustang in name only, but it is a first-rate electric SUV, a solid Tesla competitor—and its high-performance version is quick.	45390	2024 Ford Mustang Mach-E	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-ford-mustang-mach-e-rally-1-64f87f1882d10.jpg?crop=0.662xw:0.556xh;0.188xw,0.314xh&resize=700:*"}
326	While comfortable and competent, the C-Max's high EPA-estimated fuel-economy numbers are basically fantasy.	24995	2018 Ford C-Max	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2017-ford-c-max-hybrid-104-1557782688.jpg?crop=1.00xw:0.923xh;0,0.0767xh&resize=700:*"}
327	Apart from a notable tow rating and standard all-wheel drive, the Ford EcoSport is a flawed subcompact SUV that's not long for this world.	23335	2022 Ford EcoSport	34	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2018-ford-ecosport-mmp-1-1637615492.jpg?crop=1.00xw:0.957xh;0,0.0435xh&resize=700:*"}
328	Though the Fiesta might be small, it is still mighty fierce.	4053216	2019 Ford Fiesta	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2017-ford-fiesta-1557785069.jpg?crop=1.00xw:0.924xh;0,0.0759xh&resize=700:*"}
329	The Fiesta ST isn't as badass as the die-hard Ford Focus RS, but that makes it all the more lovable, er, fun.	22315	2019 Ford Fiesta ST	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2017-ford-fiesta-st-114-1-1557785159.jpg?crop=1.00xw:0.924xh;0,0.0759xh&resize=700:*"}
330	The funky 2019 Flex is Ford's answer to those seeking a modern version of the old-school station wagon.	6298601	2019 Ford Flex	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2016-ford-flex-ecoboost-awd-1-1557785294.jpg?crop=0.787xw:0.723xh;0.192xw,0.165xh&resize=700:*"}
331	The Focus ceased production in 2018, but as a used car it's a great value either as a hatchback or a sedan.	18825	2018 Ford Focus	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2017-ford-focus-1557785498.jpg?crop=1.00xw:0.924xh;0,0.0759xh&resize=700:*"}
332	In the great American pursuit of crossovers, the venerable Focus grows in height, sprouts rugged exterior features, and dons a new name: Focus Active.	1111036	2020 Ford Focus Active	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-ford-focus-euro-spec-116-1524758546.jpg?crop=0.629xw:0.577xh;0.171xw,0.221xh&resize=700:*"}
333	You might miss the exhaust note, but otherwise the Focus Electric is very similar to its gasoline-powered sibling.	3898482	2018 Ford Focus Electric	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2016-ford-focus-bev-101-1-1557785727.jpg?crop=1.00xw:0.924xh;0,0.0759xh&resize=700:*"}
334	All good things must come to an end: The fantastic Ford Focus RS enters its final year of production packed with performance paraphernalia and ready to desecrate a racetrack near you.	743509	2018 Ford Focus RS	40	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2016-ford-focus-rs-101-1557785824.jpg?crop=0.748xw:0.688xh;0.128xw,0.207xh&resize=700:*"}
335	The Focus ST satisfies performance fanatics who can't afford the track-ready Focus RS or want more power and practicality than the terrific albeit tiny Ford Fiesta ST.	1981322	2018 Ford Focus ST	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2015-ford-focus-st-170-1557785906.jpg?crop=1.00xw:0.924xh;0,0.0761xh&resize=700:*"}
336	With a plethora of turbocharged and hybrid powertrains, the 2020 Ford Fusion offers buyers lots to choose from but lacks a point of view.	24365	2020 Ford Fusion	32	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-ford-fusion-mmp-1-1568742907.jpeg?crop=0.643xw:0.541xh;0.316xw,0.429xh&resize=700:*"}
337	Ford is giving its GT supercar a proper send-off with track-focused enhancements, including at least 800 horsepower, a reworked body, and more. 	1700000	2023 Ford GT	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-ford-gt-mk-iv-02-1670543667.jpg?crop=0.700xw:0.699xh;0.237xw,0.142xh&resize=700:*"}
338	The 2020 Ford Mustang Shelby GT350 is a powerful, high-strung muscle car designed to rock race tracks while still being at home on the street.	61635	2020 Ford Mustang Shelby GT350 / GT350R	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-ford-mustang-shelby-gt350r-101-1565613876.jpg?crop=0.811xw:0.747xh;0.0798xw,0.186xh&resize=700:*"}
339	Despite performance numbers that rival exotic sports cars, the Ford Mustang Shelby GT500 is easy to live with, making it equal parts pony car and thrill ride. 	80795	2022 Ford Mustang Shelby GT500	37	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-ford-mustang-shelby-gt500-02-1636734552.jpg?crop=1.00xw:0.891xh;0,0.0759xh&resize=700:*"}
340	Once a household name, the Ford Taurus is now destined for the great scrap-heap in the sky as 2019 will be its last year on sale.	6150925	2019 Ford Taurus	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/wp-content/uploads/2016/05/2016-Ford-Taurus-Limited-110.jpg?crop=0.779xw:0.715xh;0,0.285xh&resize=700:*"}
341	The nicely packaged Freestyle became the Taurus X for 2008 and received a bolder front-end sheetmetal, an available power liftgate, and one-touch folding second-row seats.	29095	2009 Ford Taurus X	32	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2008-ford-taurus-x-limited-photo-36520-s-986x603-1557787014.jpg?crop=1.00xw:0.921xh;0,0.0785xh&resize=700:*"}
342	The Ford Transit Connect city van is a four-wheeled Swiss army knife, a versatile tool that can be configured to suit the needs of a wide swath of customers.	35485	2023 Ford Transit Connect	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	3	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/wp-content/uploads/2018/03/2019-Ford-Transit-Connect-102.jpg?crop=0.842xw:0.774xh;0.114xw,0.226xh&resize=700:*"}
343	The 2024 Genesis Electrified G80 is virtually indistinguishable from the regular G80—which is fine by us, as we find its styling handsome and its cabin lovely.	75625	2024 Genesis Electrified G80	39	42f14c9c-944a-4c08-82bd-bfc4df28ff17	43	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-genesis-electrified-g80-406-1657742429.jpg?crop=0.679xw:0.571xh;0.0961xw,0.429xh&resize=700:*"}
344	The Genesis G70 is almost the total entry-luxury sedan package, with dynamic looks, a fine cabin, potent power and handling, and value pricing. 	42750	2024 Genesis G70	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	43	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-genesis-g70-115-65bbd8d756cc4.jpg?crop=0.617xw:0.522xh;0.106xw,0.325xh&resize=700:*"}
345	Gentle luxury is the 2025 Genesis G80’s mission, and it delivers with a controlled ride and a sumptuous cabin that give it a budget-Bentley vibe.	56000	2025 Genesis G80	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	43	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-genesis-g80-red-silver-657afe3f9a3a0.jpg?crop=0.756xw:0.755xh;0.115xw,0.245xh&resize=700:*"}
346	No longer the upstart, the 2024 Genesis G90 brings a host of features and an opulent interior at a price point that undercuts the top European offerings. 	90450	2024 Genesis G90	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	43	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-genesis-g90-3-5t-e-sc-5748-1671564719.jpg?crop=0.560xw:0.474xh;0.225xw,0.372xh&resize=700:*"}
347	Genesis attempts to push into the luxury stratosphere with the all-electric 2025 GT90 coupe and convertible, which could have more than 500 horsepower. 	115000	2025 Genesis GT90	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	43	{"img" : "https://hips.hearstapps.com/hmg-prod/images/genesis-gt90-concept-6446aab5a1166.jpg?crop=0.831xw:0.894xh;0.164xw,0.0156xh&resize=700:*"}
348	Based on the gasoline-powered GV70 SUV, the 2024 Electrified GV70 looks just as fabulous but swaps in two electric motors making a combined 483 horsepower.	67800	2024 Genesis Electrified GV70	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	43	{"img" : "https://hips.hearstapps.com/hmg-prod/images/genesis-electrified-gv70-128-645bb7e73e64c.jpg?crop=0.695xw:0.587xh;0.107xw,0.301xh&resize=700:*"}
349	The Genesis GV60 stands out for its style, premium interior, and fast-charging capability, but lacks the range and interior space of some less pricey competitors.	53350	2024 Genesis GV60	37	42f14c9c-944a-4c08-82bd-bfc4df28ff17	43	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-genesis-gv60-810-1657247825.jpg?crop=0.713xw:0.602xh;0.0896xw,0.383xh&resize=700:*"}
350	Genesis's unique take on luxury is evident in each of its offerings, particularly so in the 2024 GV70 SUV, which mixes style and substance in a beautiful way. 	46500	2024 Genesis GV70	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	43	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-genesis-gv70-3p5t-awd-sport-prestige-101-1632147132.jpg?crop=0.868xw:0.732xh;0.0814xw,0.237xh&resize=700:*"}
351	The 2025 Genesis GV80 gets an updated powertrain as part of its mid-cycle refresh, and a host of new equipment that sweetens this already lavish offering.	59000	2025 Genesis GV80	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	43	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-genesis-gv80-front-65143f0e033ab.jpg?crop=1.00xw:0.798xh;0,0.115xh&resize=700:*"}
352	Genesis is getting into the fastback SUV business with the upcoming GV80 Coupe, which sports an aggressive look and a two-row interior.	70000	2025 Genesis GV80 Coupe	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	43	{"img" : "https://hips.hearstapps.com/hmg-prod/images/650950-65143d08a6f8f.jpg?crop=0.696xw:0.557xh;0.231xw,0.312xh&resize=700:*"}
353	We expect the 2026 Genesis GV90 SUV to combine an electrified powertrain with the heavenly ride and stately manner of the gas-powered G90 Sedan. 	100000	2026 Genesis GV90	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	43	{"img" : "https://hips.hearstapps.com/hmg-prod/images/hero1-neolun-concept-fq-pr-6602127a707c7.jpg?crop=0.829xw:0.827xh;0.106xw,0.0824xh&resize=700:*"}
354	The 2024 Genesis Electrified G80 is virtually indistinguishable from the regular G80—which is fine by us, as we find its styling handsome and its cabin lovely.	75625	2024 Genesis Electrified G80	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	43	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-genesis-electrified-g80-406-1657742429.jpg?crop=0.679xw:0.571xh;0.0961xw,0.429xh&resize=700:*"}
355	Based on the gasoline-powered GV70 SUV, the 2024 Electrified GV70 looks just as fabulous but swaps in two electric motors making a combined 483 horsepower.	67800	2024 Genesis Electrified GV70	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	43	{"img" : "https://hips.hearstapps.com/hmg-prod/images/genesis-electrified-gv70-128-645bb7e73e64c.jpg?crop=0.695xw:0.587xh;0.107xw,0.301xh&resize=700:*"}
356	Genesis attempts to push into the luxury stratosphere with the all-electric 2025 GT90 coupe and convertible, which could have more than 500 horsepower. 	115000	2025 Genesis GT90	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	43	{"img" : "https://hips.hearstapps.com/hmg-prod/images/genesis-gt90-concept-6446aab5a1166.jpg?crop=0.831xw:0.894xh;0.164xw,0.0156xh&resize=700:*"}
580	The Nissan Sentra may not be the most engaging drive on the planet, but this little sedan is packed with value. 	22030	2024 Nissan Sentra	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	22	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-nissan-sentra-e-15-6488668a6dde1.jpg?crop=0.667xw:0.563xh;0.117xw,0.438xh&resize=700:*"}
357	The Genesis GV60 stands out for its style, premium interior, and fast-charging capability, but lacks the range and interior space of some less pricey competitors.	53350	2024 Genesis GV60	32	42f14c9c-944a-4c08-82bd-bfc4df28ff17	43	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-genesis-gv60-810-1657247825.jpg?crop=0.713xw:0.602xh;0.0896xw,0.383xh&resize=700:*"}
358	We expect the 2026 Genesis GV90 SUV to combine an electrified powertrain with the heavenly ride and stately manner of the gas-powered G90 Sedan. 	100000	2026 Genesis GV90	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	43	{"img" : "https://hips.hearstapps.com/hmg-prod/images/hero1-neolun-concept-fq-pr-6602127a707c7.jpg?crop=0.829xw:0.827xh;0.106xw,0.0824xh&resize=700:*"}
359	The 2024 F-type offers everything you'd expect from a Jaguar sports car: beautiful design, a sonorous V-8 engine, and plenty of driving character.	79175	2024 Jaguar F-type	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	13	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-jaguar-f-type-101-1673467226.jpg?crop=1.00xw:1.00xh;0,0&resize=700:*"}
360	The 2024 Jaguar XF combines the plushness of a big car with lithe handling and plenty of style, but compared to cutting-edge rivals it's clearly showing its age.	51075	2024 Jaguar XF	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	13	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-jaguar-xf-p300-r-dynamic-101-64e8cdd02fc9a.jpg?crop=0.775xw:0.658xh;0.0879xw,0.203xh&resize=700:*"}
361	The 2024 E-Pace subcompact luxury SUV is Jaguar's most affordable offering, and it offers high-end curb appeal, playful driving dynamics, and a serene cabin. 	50675	2024 Jaguar E-Pace	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	13	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-jaguar-e-pace-102-64e8f1be7159c.jpg?crop=0.482xw:0.411xh;0.309xw,0.274xh&resize=700:*"}
362	The 2024 Jaguar F-Pace’s styling might remind you of the F-type sports car’s, and this SUV has athletic road manners to match.	58275	2024 Jaguar F-Pace	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	13	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2021-jaguar-f-pace-s-p400-500-1630522636.jpg?crop=0.679xw:0.576xh;0.124xw,0.388xh&resize=700:*"}
363	Beautiful and brash, the F-Pace SVR is an uncommon performance SUV with a heroic V-8 engine that's soon to be out of production.	93175	2024 Jaguar F-Pace SVR	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	13	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2021-jaguar-f-pace-svr-102-1650986318.jpg?crop=0.873xw:0.738xh;0.127xw,0.198xh&resize=700:*"}
364	The I-Pace checks enough tech boxes on the spec sheet but it's the Jaguar of EVs, more alluring for its character and driving dynamics than its technology. 	73275	2024 Jaguar I-Pace	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	13	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-jaguar-i-pace-101-jpg-64ee3452bd2cb.jpg?crop=0.720xw:0.609xh;0.0993xw,0.301xh&resize=700:*"}
365	The I-Pace checks enough tech boxes on the spec sheet but it's the Jaguar of EVs, more alluring for its character and driving dynamics than its technology. 	73275	2024 Jaguar I-Pace	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	13	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-jaguar-i-pace-101-jpg-64ee3452bd2cb.jpg?crop=0.720xw:0.609xh;0.0993xw,0.301xh&resize=700:*"}
366	With handsome looks, athletic driving moves, and a solid warranty, the XE is a competitive small luxury sedan.	40950	2020 Jaguar XE	35	42f14c9c-944a-4c08-82bd-bfc4df28ff17	13	{"img" : "https://hips.hearstapps.com/hmg-prod/images/jag-xe-r-dynamic-s-p250-caesium-blue-056-jpg-1555965011.jpg?crop=0.743xw:0.628xh;0.0603xw,0.269xh&resize=700:*"}
367	Jaguar's rarified branding spreads into a rarely spied station wagon and creates the sophisticated 2020 XF Sportbrake.	66300	2020 Jaguar XF Sportbrake	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	13	{"img" : "https://hips.hearstapps.com/hmg-prod/images/jaguarxfsportbrakelocationexterior14061707-1563472234.jpg?crop=0.707xw:0.697xh;0.0537xw,0.229xh&resize=700:*"}
368	As the only Brit in a segment ruled by Germans, the Jaguar XJ has a lot on its shoulders—a weight it bears remarkably well.	86025	2019 Jaguar XJ	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	13	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2016-jaguar-xjl-portfolio-1-1557860785.jpg?crop=1.00xw:0.924xh;0,0.0759xh&resize=700:*"}
369	The Jaguar XJR575 is a luxury sedan with huge power that trades blows with the best bigs from Audi, BMW, and Mercedes-Benz.	1991456	2019 Jaguar XJR575	32	42f14c9c-944a-4c08-82bd-bfc4df28ff17	13	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2018-jaguar-xjr575-99leadgallery-1538661617.jpg?crop=1.00xw:0.924xh;0,0.0759xh&resize=700:*"}
370	With swooping lines and traditional British styling, the XK is the quintessential grand touring car in the Jaguar range.	6437769	2015 Jaguar XK	40	42f14c9c-944a-4c08-82bd-bfc4df28ff17	13	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2011-jaguar-xk-coupe-european-spec-photo-362787-s-986x603-1557861289.jpg?crop=1.00xw:0.921xh;0,0.0785xh&resize=700:*"}
371	With track-tuned suspensions, the XKR and XKR-S deliver brutal performance.	8329151	2015 Jaguar XKR / XKR-S	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	13	{"img" : "https://hips.hearstapps.com/hmg-prod/images/uji8807edit-resize-1024x683-1557861145.jpg?crop=1.00xw:0.847xh;0,0.0576xh&resize=700:*"}
372	The 2024 Jeep Compass packs 200 horsepower and all-wheel drive, and it will go almost anywhere you point it. 	27495	2024 Jeep Compass	32	42f14c9c-944a-4c08-82bd-bfc4df28ff17	9	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-jeep-compass-latitude-4x4-203-647e28b5f027a.jpg?crop=0.687xw:0.580xh;0.230xw,0.405xh&resize=700:*"}
373	The refreshed 2024 Jeep Gladiator takes what makes the four-door Wrangler great and adds a pickup-truck bed to it.  	41085	2024 Jeep Gladiator	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	9	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-jeep-gladiator-mojave-x-101-6500b274f172a.jpg?crop=0.927xw:0.782xh;0.0277xw,0.218xh&resize=700:*"}
374	The 2024 Grand Cherokee is a multifaceted SUV situated at the intersection of machismo and elegance, with some trims remaining simple and others going upscale.	39830	2024 Jeep Grand Cherokee	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	9	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-jeep-grand-cherokee-4xe-overland-4x4-712-1676571488.jpg?crop=0.612xw:0.516xh;0.293xw,0.453xh&resize=700:*"}
375	Whether it's stripped down or dressed to the nines, the 2024 Jeep Grand Cherokee L is a handsome family support vehicle that's built to go to basically anywhere.	41830	2024 Jeep Grand Cherokee L	36	42f14c9c-944a-4c08-82bd-bfc4df28ff17	9	{"img" : "https://hips.hearstapps.com/hmg-prod/images/jp024-203gc-64dbda5ef38b0.jpg?crop=0.704xw:0.594xh;0.0978xw,0.267xh&resize=700:*"}
376	Jeep goes big in the realm of large luxury SUVs, reviving a classic nameplate for a traditionally engineered offering.	93945	2024 Jeep Grand Wagoneer	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	9	{"img" : "https://hips.hearstapps.com/hmg-prod/images/ws023-030gw-1649706648.jpg?crop=0.862xw:0.726xh;0.138xw,0.208xh&resize=700:*"}
377	The competition for the best electric vehicle is about to get dirtier with Jeep's upcoming Recon EV mid-size SUV. 	60000	2024 Jeep Recon EV	33	42f14c9c-944a-4c08-82bd-bfc4df28ff17	9	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-jeep-recon-101-1662583242.jpg?crop=1.00xw:0.861xh;0,0.139xh&resize=700:*"}
378	The 2024 Wagoneer is the largest Jeep SUV and while it offers more space and capability than deluxe European rivals, it falls short of being truly luxurious.	64945	2024 Jeep Wagoneer	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	9	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-jeep-wagoneer-454-1635910407.jpg?crop=0.681xw:0.576xh;0.112xw,0.381xh&resize=700:*"}
379	The 2025 Jeep Wagoneer S is an upcoming electric SUV that’s expected to offer competitive efficiency and next-level performance. 	80000	2025 Jeep Wagoneer S	38	42f14c9c-944a-4c08-82bd-bfc4df28ff17	9	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-jeep-wagoneer-s-front-65b94c574eb74.jpg?crop=1.00xw:0.846xh;0,0&resize=700:*"}
380	The 2024 Wrangler can dress for either the mall or the mountains, but each one is imbued with Jeep's promise of adventure.	33890	2024 Jeep Wrangler	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	9	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-jeep-wrangler-4xe-rubicon-x-504-65b27d09dc3b6.jpg?crop=0.513xw:0.432xh;0.248xw,0.353xh&resize=700:*"}
382	The 2025 Jeep Wagoneer S is an upcoming electric SUV that’s expected to offer competitive efficiency and next-level performance. 	80000	2025 Jeep Wagoneer S	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	9	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-jeep-wagoneer-s-front-65b94c574eb74.jpg?crop=1.00xw:0.846xh;0,0&resize=700:*"}
383	Compact crossovers aren’t typically associated with off-road trails or towing, but the 2023 Jeep Cherokee can do a lot its newer competitors wouldn’t dare attempt.	39290	2023 Jeep Cherokee	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	9	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-jeep-cherokee-101-1673472136.jpeg?crop=0.792xw:0.728xh;0.0176xw,0.217xh&resize=700:*"}
384	The biggest Jeep isn't as refined as many of its car-based competitors, but it's adept off-road, seats up to seven, and will tow a heavy load with the optional Hemi V-8.	1663197	2010 Jeep Commander	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	9	{"img" : "https://hips.hearstapps.com/hmg-prod/images/jp010-002co-1557861623.jpg?crop=1.00xw:0.781xh;0,0.219xh&resize=700:*"}
385	The 2021 Jeep Grand Cherokee SRT is an exercise in overkill, but its sports-car-rivaling grip and roaring Hemi make it a performance powerhouse.	72865	2021 Jeep Grand Cherokee SRT	40	42f14c9c-944a-4c08-82bd-bfc4df28ff17	9	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2021-jee-grand-cherokee-srt-mmp-1-1598932182.jpg?crop=0.840xw:0.837xh;0.104xw,0.163xh&resize=700:*"}
386	With a raucous 707-hp Hellcat motor, the Jeep Grand Cherokee Trackhawk is great at outrunning sports cars and expediting family road trips.	91665	2021 Jeep Grand Cherokee Trackhawk	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	9	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2021-jeep-grand-cherokee-trackhawk-mmp-1-1598932691.jpg?crop=0.913xw:0.772xh;0.0240xw,0.132xh&resize=700:*"}
387	If you want some serious off-road ability in a small SUV, look no further.	5149345	2012 Jeep Liberty	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	9	{"img" : "https://hips.hearstapps.com/hmg-prod/images/jp012-008lb-1557862460.jpg?crop=1.00xw:0.934xh;0,0.0663xh&resize=700:*"}
388	Those seeking an affordable off-roader should check out the Patriot.	9352879	2017 Jeep Patriot	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	9	{"img" : "https://hips.hearstapps.com/hmg-prod/images/jp017-007pams468cr48ourta6saj42926rh5-1557862558.jpg?crop=1.00xw:0.844xh;0,0.156xh&resize=700:*"}
389	The aging Jeep Renegade offers a roomy cabin and strong off-roading potential in a subcompact package, but at a price premium versus its competitors.	29445	2023 Jeep Renegade	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	9	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-jeep-renegade-high-altitude-1665506942.jpg?crop=1.00xw:0.871xh;0,0.111xh&resize=700:*"}
390	With its abundant power, innovative amenities, and futuristic design, the Koenigsegg Jesko is a hypercar that's nothing less than iconic. 	3000000	2021 Koenigsegg Jesko	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	61	{"img" : "https://hips.hearstapps.com/hmg-prod/images/koenigsegg-jesko-101-1551799580.jpg?crop=1.00xw:0.929xh;0,0.0288xh&resize=700:*"}
391	Koenigsegg’s cutting edge hybrid technology and innovative engineering shine through in the highly exclusive and high-powered 2020 Regera. 	1900000	2020 Koenigsegg Regera	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	61	{"img" : "https://hips.hearstapps.com/hmg-prod/images/koenigsegg-regera-mmp-1-1591115837.jpg?crop=0.779xw:0.660xh;0.0945xw,0.230xh&resize=700:*"}
392	The Land Rover Defender is Britain's answer to America's rough-and-tumble Jeeps, but it offers more comfort to go along with its go-anywhere capability.	57875	2024 Land Rover Defender	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	55	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-land-rover-defender-130-outbound-496-65c673e95126e.jpg?crop=0.694xw:0.585xh;0.207xw,0.329xh&resize=700:*"}
393	Land Rover knows we can't get enough of the Defender, so it's gearing up to introduce the smaller, subcompact Defender Sport.	40000	2027 Land Rover Defender Sport	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	55	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-land-rover-defender-80-rendering-1586540091.jpg?crop=0.691xw:0.594xh;0.157xw,0.271xh&resize=700:*"}
394	Think of it as the overlander for wealthy families: the 2024 Discovery continues Land Rover's legacy of off-road capability but wraps it in a modern package.	61375	2024 Land Rover Discovery	37	42f14c9c-944a-4c08-82bd-bfc4df28ff17	55	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2021-land-rover-discovery-r-dynamic-s-03-1641867239.jpg?crop=1.00xw:0.849xh;0,0.107xh&resize=700:*"}
395	It isn't a Land Rover without some off-road capability, so the 2024 Discovery Sport comes with off-road features inherited from elsewhere in the brand's lineup.	50075	2024 Land Rover Discovery Sport	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	55	{"img" : "https://hips.hearstapps.com/hmg-prod/images/ds-24my-static-dynamic-hse-140623-02-6489cb87d0cbc.jpg?crop=0.774xw:0.774xh;0.0977xw,0.226xh&resize=700:*"}
396	What attracts elites to the Range Rover isn't its off-road ability, but rather its opulent cabin and the A-list status that it's developed over the years.	108875	2024 Land Rover Range Rover	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	55	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-range-rover-se-lwb-470-1665593876.jpg?crop=0.735xw:0.620xh;0.205xw,0.363xh&resize=700:*"}
397	Land Rover’s new-for-2024 Range Rover EV brings silent electric propulsion to the company’s flagship luxury SUV lineup. 	120000	2025 Land Rover Range Rover EV	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	55	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-range-rover-se-p400-lwb-103-1650304550.jpg?crop=0.619xw:0.522xh;0.202xw,0.363xh&resize=700:*"}
398	The 2024 Range Rover Evoque is the fashionista of the subcompact-SUV class, and it’s guaranteed to turn heads, but its practical attributes don't measure up. 	51075	2024 Land Rover Range Rover Evoque	37	42f14c9c-944a-4c08-82bd-bfc4df28ff17	55	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-land-rover-range-rover-evoque-phev-103-65380161233a7.jpg?crop=0.929xw:0.357xh;0.0433xw,0.429xh&resize=700:*"}
399	The 2024 Land Rover Range Rover Sport perpetuates the nameplate's luxurious pedigree, features modern tech, and wears a chic look.	85075	2024 Land Rover Range Rover Sport	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	55	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-range-rover-sport-101-1652153925.jpg?crop=0.627xw:0.531xh;0.243xw,0.284xh&resize=700:*"}
400	The 2024 Land Rover Range Rover Sport SV unleashes 626 horsepower from its twin-turbo V-8, and it does so wearing giant carbon fiber wheels. 	181775	2024 Land Rover Range Rover Sport SV	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	55	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-land-rover-range-rover-sport-sv-152-65ce30417b478.jpg?crop=0.814xw:0.688xh;0.186xw,0.0577xh&resize=700:*"}
401	As a fashion accessory, the 2024 Range Rover Velar is hard to beat, but its mild road manners don't match its suave looks and may result in driver disappointment.	62775	2024 Land Rover Range Rover Velar	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	55	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-land-rover-range-rover-velar-phev-120-653806b698424.jpg?crop=0.644xw:0.642xh;0.157xw,0.168xh&resize=700:*"}
402	Land Rover knows we can't get enough of the Defender, so it's gearing up to introduce the smaller, subcompact Defender Sport.	40000	2027 Land Rover Defender Sport	39	42f14c9c-944a-4c08-82bd-bfc4df28ff17	55	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-land-rover-defender-80-rendering-1586540091.jpg?crop=0.691xw:0.594xh;0.157xw,0.271xh&resize=700:*"}
403	Land Rover’s new-for-2024 Range Rover EV brings silent electric propulsion to the company’s flagship luxury SUV lineup. 	120000	2025 Land Rover Range Rover EV	39	42f14c9c-944a-4c08-82bd-bfc4df28ff17	55	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-range-rover-se-p400-lwb-103-1650304550.jpg?crop=0.619xw:0.522xh;0.202xw,0.363xh&resize=700:*"}
404	If you truly need a vehicle that can conquer both the mall’s parking lot and the great outdoors, the LR2 is your ute.	5443972	2015 Land Rover LR2	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	55	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/65776/2008-land-rover-lr2-se-photo-66694-s-986x603.jpg?crop=1.00xw:0.919xh;0,0.0812xh&resize=700:*"}
405	The LR3 has a classically simple and clean Rover look, and it hews to tradition with body-on-frame construction and a tough, fully independent suspension.	46750	2009 Land Rover LR3	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	55	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/05q1/267354/land-rover-lr3-hse-photo-5323-s-original.jpg?crop=1.00xw:0.927xh;0,0.0551xh&resize=700:*"}
406	The safari-ready LR4 is the automotive equivalent of Bear Grylls, albeit with James Bond’s wardrobe.	5757272	2016 Land Rover LR4	35	42f14c9c-944a-4c08-82bd-bfc4df28ff17	55	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/269974/2010-land-rover-lr4-european-spec-photo-270006-s-986x603.jpg?crop=1.00xw:0.849xh;0,0.125xh&resize=700:*"}
407	The stylish and luxurious Range Rover is, at the same time, capable of handling off-road treks and sparking around-town envy.	8653867	2017 Land Rover Range Rover Supercharged	33	42f14c9c-944a-4c08-82bd-bfc4df28ff17	55	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/672263/2017-land-rover-range-rover-in-depth-model-review-car-and-driver-photo-699301-s-original.jpg?crop=0.665xw:0.613xh;0.114xw,0.178xh&resize=700:*"}
408	Offering a smooth driving experience, lots of safety features, and a plush interior, the Lexus ES out as the reasonably priced mid-size luxury sedan. 	43190	2024 Lexus ES	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	26	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-lexus-es250-awd-luxury-102-649f37e4787c4.jpg?crop=0.708xw:0.598xh;0.238xw,0.290xh&resize=700:*"}
409	Before the world even knows its name, the Lexus Electrified Sport teases exciting performance like the famed V-10-powered LFA.	100000	2025 Lexus EV Supercar	38	42f14c9c-944a-4c08-82bd-bfc4df28ff17	26	{"img" : "https://hips.hearstapps.com/hmg-prod/images/20211214-bev-13-1639491072.jpg?crop=0.939xw:1.00xh;0.0321xw,0&resize=700:*"}
411	Snazzy and sumptuous, the 2024 Lexus LC is a grand-touring two-door with the looks of an exotic sports car and the comfort of a flagship luxury car.	99800	2024 Lexus LC	33	42f14c9c-944a-4c08-82bd-bfc4df28ff17	26	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-lexus-lc-004-6463a5b41d024.jpg?crop=0.857xw:0.855xh;0.0733xw,0.133xh&resize=700:*"}
412	The flagship of its sedan lineup, the 2024 Lexus LS blends a deluxe cabin with a smooth ride but lacks the depth and personality that makes its rivals appealing.	80685	2024 Lexus LS	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	26	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-lexus-ls500-102-654a97d5840da.jpg?crop=0.655xw:0.553xh;0.160xw,0.293xh&resize=700:*"}
413	The 2024 Lexus RC is showing its age, but its racy shape, plush interior, and reasonable price go a long way to make up for its mid-pack performance.	45920	2024 Lexus RC	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	26	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-lexus-rc-350-f-sport-awd-589-edit-1646327634.jpg?crop=0.603xw:0.507xh;0.318xw,0.493xh&resize=700:*"}
414	The RC F offers a delightfully willing V-8 and a well-finished interior, but its aging platform is heavy and it falls behind the pack dynamically.  	68295	2024 Lexus RC F	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	26	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-lexus-rc-f-101-654a8cc111087.jpg?crop=0.603xw:0.463xh;0,0.307xh&resize=700:*"}
415	After 13 years on the market without a major redesign, the Lexus GX has relaunched for 2024 with an entirely new platform, powertrain, and presence.	64250	2024 Lexus GX	37	42f14c9c-944a-4c08-82bd-bfc4df28ff17	26	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-lexus-gx-550-premium-188-65f2fd266825d.jpg?crop=0.737xw:0.621xh;0.205xw,0.288xh&resize=700:*"}
416	Big, beefy, and off-road capable, the 2024 Lexus LX600 is less trucklike than its predecessor but is missing some of the features of its luxury-SUV competitors.	93915	2024 Lexus LX	38	42f14c9c-944a-4c08-82bd-bfc4df28ff17	26	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-lexus-lx600-ultra-luxury-104-1647449664.jpg?crop=0.554xw:0.469xh;0.200xw,0.308xh&resize=700:*"}
417	Although the 2024 Lexus NX is more than just a dressed-up Toyota RAV4—the vehicle it’s based on—it doesn’t satisfy in the same ways its European rivals do. 	40605	2024 Lexus NX	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	26	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-lexus-nx350-exterior-109-641b4ca787aca.jpg?crop=0.757xw:0.671xh;0.0537xw,0.249xh&resize=700:*"}
418	Despite a complete overhaul last year, the Lexus RX SUV retains soft-riding road manners that seem tailor-made for its faithful buyers.	49950	2024 Lexus RX	39	42f14c9c-944a-4c08-82bd-bfc4df28ff17	26	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-lexus-rx-450h-luxury-101-65c63914cc85d.jpg?crop=0.601xw:0.507xh;0.202xw,0.337xh&resize=700:*"}
419	The Lexus RZ300e and RZ450e deliver a luxurious experience like any other model in the lineup, but they don't offer as much driving range as other EV SUVs.	55150	2024 Lexus RZ	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	26	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-lexus-rz-450e-premium-288-6440420ddeaba.jpg?crop=0.665xw:0.561xh;0.293xw,0.396xh&resize=700:*"}
420	Lexus's most family-friendly three-row SUV has touched down in America, and this luxury version of the Toyota Grand Highlander goes by the name TX.	55050	2024 Lexus TX	36	42f14c9c-944a-4c08-82bd-bfc4df28ff17	26	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-lexus-tx-350-125-657083c6ccbd1.jpg?crop=0.764xw:0.645xh;0.207xw,0.326xh&resize=700:*"}
421	With more space inside and a third row of seats, the 2024 Lexus TX Hybrid provides buyers with a Lexus SUV that's far roomier for passengers than the two-row RX.	69350	2024 Lexus TX Hybrid	33	42f14c9c-944a-4c08-82bd-bfc4df28ff17	26	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-lexus-tx-500h-f-sport-awd-270-65806c132a532.jpg?crop=0.808xw:0.683xh;0.192xw,0.317xh&resize=700:*"}
424	Before the world even knows its name, the Lexus Electrified Sport teases exciting performance like the famed V-10-powered LFA.	100000	2025 Lexus EV Supercar	35	42f14c9c-944a-4c08-82bd-bfc4df28ff17	26	{"img" : "https://hips.hearstapps.com/hmg-prod/images/20211214-bev-13-1639491072.jpg?crop=0.939xw:1.00xh;0.0321xw,0&resize=700:*"}
425	The Lexus RZ300e and RZ450e deliver a luxurious experience like any other model in the lineup, but they don't offer as much driving range as other EV SUVs.	55150	2024 Lexus RZ	35	42f14c9c-944a-4c08-82bd-bfc4df28ff17	26	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-lexus-rz-450e-premium-288-6440420ddeaba.jpg?crop=0.665xw:0.561xh;0.293xw,0.396xh&resize=700:*"}
426	A trademark filed earlier this year foiled the surprise reveal of the 2026 Lexus TZ, which we speculate will be an all-electric SUV with three rows of seating. 	60000	2026 Lexus TZ	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	26	{"img" : "https://hips.hearstapps.com/hmg-prod/images/20211214-bev-36-1639491043.jpg?crop=1.00xw:0.846xh;0,0.125xh&resize=700:*"}
427	If you’re into the relentless pursuit of fuel efficiency—but you can’t take the doorstop style of the Toyota Prius—the CT200h may be what you seek.	4950872	2017 Lexus CT	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	26	{"img" : "https://hips.hearstapps.com/hmg-prod/images/0319140551302014-lexus-ct-200h-010-1550088693.jpg?crop=1.00xw:0.849xh;0,0.0337xh&resize=700:*"}
428	With its large trunk and smooth handling, the 2020 Lexus GS offers ample utility and comfort.	52090	2020 Lexus GS	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	26	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-lexus-gs-mmp-1-1574354422.jpg?crop=0.972xw:0.817xh;0.0277xw,0.183xh&resize=700:*"}
429	The last car in this class utilizing a naturally aspirated V-8, the luxurious GS F firmly plants Lexus in the battle for performance sports sedan superiority.	86035	2020 Lexus GS F	39	42f14c9c-944a-4c08-82bd-bfc4df28ff17	26	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-lexus-gs-f-mmp-1-1580498320.jpg?crop=0.777xw:0.924xh;0.114xw,0.0759xh&resize=700:*"}
430	The first hybrid-only luxury car, the HS250h is a compact five-seater using the powertrain from the Camry hybrid.	4359402	2012 Lexus HS	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	26	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/wp-content/uploads/2009/07/2010-Lexus-HS250h1-626x382.jpg?crop=0.998xw:0.924xh;0,0.0761xh&resize=700:*"}
431	Lexus’s answer to the BMW M3 sedan, the IS F, arrives in 2014 with only minor trim changes, even as lesser IS sedan models received a redesign.	1196380	2014 Lexus IS F	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	26	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/11q2/402049/2011-lexus-is-f-photo-402059-s-986x603.jpg?crop=0.947xw:0.869xh;0.0272xw,0.131xh&resize=700:*"}
432	If you’ve ever wondered what it would be like if Toyota took on Ferrari, the LFA is your answer.	7891017	2012 Lexus LFA	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	26	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/10q1/326075/2012-lexus-lfa-photo-326201-s-986x603.jpg?crop=1.00xw:0.924xh;0,0.0681xh&resize=700:*"}
433	Dating to 2002, this luxury convertible was once highly original and avant garde but is now aged and selling in low numbers.	2419539	2010 Lexus SC	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	26	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/03q4/3082/2004-lexus-sc430-photo-3586-s-original.jpg?crop=1.00xw:0.921xh;0,0.0787xh&resize=700:*"}
434	With a tranquil cabin and a soft-riding suspension, the 2025 Aviator follows a similar blueprint as the famed luxury sedans from Lincoln's heyday.	59890	2025 Lincoln Aviator	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	39	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-lincoln-aviator-black-label-exterior-101-65bd660745721.jpg?crop=0.833xw:0.660xh;0.0497xw,0.340xh&resize=700:*"}
435	Hidden behind the luxury façade of the 2024 Lincoln Corsair lurks a humble Ford Escape, but a thick veneer of premium materials masks its middle-class origins.	40385	2024 Lincoln Corsair	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	39	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-lincoln-corsair-327-6436c9b36da43.jpg?crop=0.718xw:0.605xh;0.0586xw,0.395xh&resize=700:*"}
436	The new Nautilus SUV enters its second generation with major changes, including an even more luxurious cabin and a 48.0-inch wide infotainment display.	52010	2024 Lincoln Nautilus	32	42f14c9c-944a-4c08-82bd-bfc4df28ff17	39	{"img" : "https://hips.hearstapps.com/hmg-prod/images/img-1550-65f363761f0d0.jpg?crop=0.994xw:0.746xh;0.00321xw,0.135xh&resize=700:*"}
437	Lincoln's mid-size Nautilus crossover lineup gains a 310-hp hybrid variant along with its elegant redesign for the 2024 model year. 	53510	2024 Lincoln Nautilus Hybrid	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	39	{"img" : "https://hips.hearstapps.com/hmg-prod/images/img-1586-jpg-65f3644c06f00.jpg?crop=0.864xw:0.647xh;0.0497xw,0.209xh&resize=700:*"}
438	The 2024 Navigator is getting on in years but still delivers an outsized, palace-on-wheels luxury SUV experience and apartment-size interior space.	85260	2024 Lincoln Navigator / Navigator L	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	39	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-lincoln-navigator-black-label-129-1629153170.jpg?crop=0.638xw:0.638xh;0.191xw,0.282xh&resize=700:*"}
439	The next step in Lincoln's modernization plan, the slinky Star Concept electric SUV should launch by 2025 and usher in several other Lincoln EVs.	70000	2025 Lincoln Star	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	39	{"img" : "https://hips.hearstapps.com/hmg-prod/images/lincoln-star-concept-102-1650471258.jpg?crop=0.770xw:0.866xh;0.164xw,0.0586xh&resize=700:*"}
440	The next step in Lincoln's modernization plan, the slinky Star Concept electric SUV should launch by 2025 and usher in several other Lincoln EVs.	70000	2025 Lincoln Star	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	39	{"img" : "https://hips.hearstapps.com/hmg-prod/images/lincoln-star-concept-102-1650471258.jpg?crop=0.770xw:0.866xh;0.164xw,0.0586xh&resize=700:*"}
441	Going head-to-head with the leaders of the luxury-sedan segment only serves to highlight the Continental's missteps, but it still looks good and pampers passengers.	47300	2020 Lincoln Continental	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	39	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-lincoln-continental-mmp-1-1569960302.jpeg?crop=0.855xw:0.720xh;0.0863xw,0.222xh&resize=700:*"}
442	The MKC is based on the Ford Escape, but few will mistake it—with its elegant sheetmetal, nicer cabin, and distinctive grille—for its mainstream sibling.	1458962	2019 Lincoln MKC	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	39	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2019-lincoln-mkc-mmp-1544820856.jpg?crop=1.00xw:0.926xh;0,0.0741xh&resize=700:*"}
443	Based on the Ford Taurus, the MKS is the luxury car you’re likely to be upgraded to the next time you are at Hertz.	9680826	2016 Lincoln MKS	32	42f14c9c-944a-4c08-82bd-bfc4df28ff17	39	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/204739/2009-lincoln-mks-photo-204749-s-986x603.jpg?crop=1.00xw:0.919xh;0,0.0812xh&resize=700:*"}
444	Stylistically divergent from the Ford Flex with which it shares a platform, the MKT is equally spacious and comfortable.	2464813	2019 Lincoln MKT	40	42f14c9c-944a-4c08-82bd-bfc4df28ff17	39	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/wp-content/uploads/2011/02/2011-Lincoln-MKT-placement1-626x382.jpg?crop=0.910xw:0.837xh;0.0673xw,0.163xh&resize=700:*"}
445	The MKX's comfort-oriented ride and quiet, plush interior will appeal to Lincoln devotees in the market for a five-passenger luxury SUV.	8500112	2018 Lincoln MKX	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	39	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/wp-content/uploads/2015/08/2016-Lincoln-MKX-102.jpg?crop=1.00xw:0.918xh;0,0.0824xh&resize=700:*"}
446	With a terrific twin-turbo V-6 option and an eminently comfy interior, the MKZ IS a quick and serene cruiser that has some unrefined quirks.	37745	2020 Lincoln MKZ	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	39	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-lincoln-mkz-mmp-1-1580762762.jpg?crop=0.866xw:0.794xh;0.0847xw,0.206xh&resize=700:*"}
447	A traditional rear-wheel-drive, V-8–powered, six-passenger, full-size sedan, the Town Car is a favorite of livery drivers and retirees because of its space and creamy ride.	941035	2011 Lincoln Town Car	38	42f14c9c-944a-4c08-82bd-bfc4df28ff17	39	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/10q2/352890/2008-lincoln-town-car-photo-352914-s-986x603.jpg?crop=1.00xw:0.919xh;0,0.0812xh&resize=700:*"}
448	Lotus is branching out to the luxury electric-car segment with the 2025 Emeya, which will wear a slinky exterior design and should offer exciting performance.	100000	2025 Lotus Emeya	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	47	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-lotus-emeya-front-three-quarters-white-64fa1b590b663.jpg?crop=0.678xw:0.509xh;0.128xw,0.233xh&resize=700:*"}
449	The Lotus Emira is a pretty sports car and the company's final nameplate with an internal combustion engine before the iconic brand goes entirely electric. 	77100	2024 Lotus Emira	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	47	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-lotus-emira-118-654bb25960b1b.jpg?crop=0.630xw:0.531xh;0.271xw,0.452xh&resize=700:*"}
450	With four electric motors making nearly 2000 horsepower, the Evija pushes the boundaries of modern hypercar performance and takes Lotus to new heights.	2300000	2024 Lotus Evija	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	47	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-lotus-evija-103-64bec851eed33.jpg?crop=0.721xw:0.603xh;0.191xw,0.102xh&resize=700:*"}
451	The 2028 Lotus Type 135 is an upcoming electric sports car that will usher in the British brand’s next generation of performance. 	80000	2028 Lotus Type 135	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	47	{"img" : "https://hips.hearstapps.com/hmg-prod/images/lotus-type-135-6440043bb2a3b.jpg?crop=0.787xw:0.666xh;0.135xw,0.175xh&resize=700:*"}
452	An electric SUV isn't what anyone would expect from Lotus, but the Eletre promises to be powerful and eye-catching with a price tag to match. 	115000	2024 Lotus Eletre	34	42f14c9c-944a-4c08-82bd-bfc4df28ff17	47	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-lotus-eletre-104-64a6c63df290a.jpg?crop=0.497xw:0.338xh;0.151xw,0.194xh&resize=700:*"}
453	An electric SUV isn't what anyone would expect from Lotus, but the Eletre promises to be powerful and eye-catching with a price tag to match. 	115000	2024 Lotus Eletre	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	47	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-lotus-eletre-104-64a6c63df290a.jpg?crop=0.497xw:0.338xh;0.151xw,0.194xh&resize=700:*"}
454	Lotus is branching out to the luxury electric-car segment with the 2025 Emeya, which will wear a slinky exterior design and should offer exciting performance.	100000	2025 Lotus Emeya	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	47	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-lotus-emeya-front-three-quarters-white-64fa1b590b663.jpg?crop=0.678xw:0.509xh;0.128xw,0.233xh&resize=700:*"}
455	With four electric motors making nearly 2000 horsepower, the Evija pushes the boundaries of modern hypercar performance and takes Lotus to new heights.	2300000	2024 Lotus Evija	37	42f14c9c-944a-4c08-82bd-bfc4df28ff17	47	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-lotus-evija-103-64bec851eed33.jpg?crop=0.721xw:0.603xh;0.191xw,0.102xh&resize=700:*"}
456	The 2028 Lotus Type 135 is an upcoming electric sports car that will usher in the British brand’s next generation of performance. 	80000	2028 Lotus Type 135	36	42f14c9c-944a-4c08-82bd-bfc4df28ff17	47	{"img" : "https://hips.hearstapps.com/hmg-prod/images/lotus-type-135-6440043bb2a3b.jpg?crop=0.787xw:0.666xh;0.135xw,0.175xh&resize=700:*"}
457	The Elise is a pure-driving roadster not for the faint of heart.	7949159	2011 Lotus Elise	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	47	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/199258/2008-lotus-elise-sc-220-photo-199300-s-986x603.jpg?crop=1.00xw:0.919xh;0,0.0812xh&resize=700:*"}
458	The Lotus Evora GT is a raw mid-engine sports car that triggers a driver's emotions with its supercharged V-6, lightweight composition, and lively controls.	99150	2021 Lotus Evora GT	40	42f14c9c-944a-4c08-82bd-bfc4df28ff17	47	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2021-lotus-evora-gt-mmp-1-1606234124.jpg?crop=1.00xw:0.851xh;0,0.108xh&resize=700:*"}
459	The Exige is a track-ready missile that share its chassis and interior with the Elise.	151319	2011 Lotus Exige	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	47	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/09q4/316878/2010-lotus-exige-s-260-sport-photo-316983-s-986x603.jpg?crop=1.00xw:0.919xh;0,0.0812xh&resize=700:*"}
460	With brawny twin-turbo powertrains and swoon-worthy styling, the 2024 Maserati Ghibli is a sports sedan with an overwhelmingly Italian flavor.	110995	2024 Maserati Ghibli	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	15	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-maserati-ghibli-ultima-101-64f8ca592013e.jpg?crop=0.651xw:0.586xh;0.166xw,0.247xh&resize=700:*"}
461	The Maserati GranCabrio takes the svelte style and ripping performance of the GranTurismo coupe and adds a convertible top for an alfresco motoring experience. 	204995	2024 Maserati GranCabrio	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	15	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-maserati-grancabrio-front-three-quarters-2-65de3d32984db.jpg?crop=1.00xw:0.942xh;0,0.0396xh&resize=700:*"}
462	Maserati's all-new sports coupe looks only mildly changed on the outside but its familiar shape hides a new platform and a new, powerful engine that makes it even more exciting to drive.	159995	2024 Maserati GranTurismo	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	15	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-maserati-granturismo-modena-7-1676302719.jpg?crop=0.527xw:0.527xh;0.280xw,0.444xh&resize=700:*"}
463	Maserati's first step into the electric sports car segment is the GranTurismo Folgore which boasts 818 horsepower, an eye-catching design, and a massive price tag.	215000	2024 Maserati GranTurismo Folgore	40	42f14c9c-944a-4c08-82bd-bfc4df28ff17	15	{"img" : "https://hips.hearstapps.com/hmg-prod/images/maserati-granturismo-folgore-copper-glance-2-1676294753.jpg?crop=0.813xw:0.683xh;0.0785xw,0.149xh&resize=700:*"}
464	The 2024 Maserati MC20 blends a high-tech turbo V-6 with carbon fiber construction in a decidedly Italian package that’s as exciting to look as it is to drive. 	242995	2024 Maserati MC20	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	15	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-maserati-mc20-cielo-spyder-28-1666275747.jpg?crop=0.583xw:0.493xh;0.124xw,0.434xh&resize=700:*"}
465	The seventh-generation Maserati Quattroporte sedan arriving for 2028 promises sharp new looks, the latest propulsion technology, and a more refined cabin. 	7083960	2028 Maserati Quattroporte	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	15	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-maserati-quattroporte1-copy-642b18bf3d8d2.jpg?crop=0.819xw:1.00xh;0.151xw,0&resize=700:*"}
466	The 2024 Maserati Grecale is handsomely styled and nicely outfitted with desirable features, but its key rivals offer a more cohesive driving experience. 	69995	2024 Maserati Grecale	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	15	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-maserati-grecale-103-1649184060.jpg?crop=0.638xw:0.540xh;0.213xw,0.357xh&resize=700:*"}
467	Maserati's electrification plans are coming into focus and include the 2025 Grecale Folgore, the EV version of the compact Grecale SUV. 	100000	2025 Maserati Grecale Folgore	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	15	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-maserati-grecale-folgore-ev-118-65f32aaf7287d.jpg?crop=0.633xw:0.534xh;0.106xw,0.286xh&resize=700:*"}
468	A potent powertrain, a designer appearance, and a well-tailored cabin give the 2024 Maserati Grecale Trofeo authentic Italian flavor. 	109495	2024 Maserati Grecale Trofeo	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	15	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-maserati-grecale-trofeo-corse-101-64f8cc554f047.jpg?crop=0.738xw:0.621xh;0.169xw,0.183xh&resize=700:*"}
469	Italy’s cultural influence reaches all over the world through iconic cuisine, exquisite fashion, and, of course, exotic cars such as the 2024 Maserati Levante.	103495	2024 Maserati Levante	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	15	{"img" : "https://hips.hearstapps.com/hmg-prod/images/maserati-levante-ultima-front-three-quarters-64ba89c904135.jpg?crop=0.866xw:0.855xh;0.0570xw,0.131xh&resize=700:*"}
470	Maserati's first step into the electric sports car segment is the GranTurismo Folgore which boasts 818 horsepower, an eye-catching design, and a massive price tag.	215000	2024 Maserati GranTurismo Folgore	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	15	{"img" : "https://hips.hearstapps.com/hmg-prod/images/maserati-granturismo-folgore-copper-glance-2-1676294753.jpg?crop=0.813xw:0.683xh;0.0785xw,0.149xh&resize=700:*"}
471	Maserati's electrification plans are coming into focus and include the 2025 Grecale Folgore, the EV version of the compact Grecale SUV. 	100000	2025 Maserati Grecale Folgore	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	15	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-maserati-grecale-folgore-ev-118-65f32aaf7287d.jpg?crop=0.633xw:0.534xh;0.106xw,0.286xh&resize=700:*"}
472	A 740-hp twin-turbo V-8 plays the chorus behind the 2024 McLaren 750S supercar, which carries the torch from the recently discontinued 720S. 	308195	2024 McLaren 750S	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	35	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mclaren-750s-coupe-113-6446d568075b5.jpg?crop=0.788xw:0.665xh;0.0798xw,0.237xh&resize=700:*"}
473	With a new Spider version and several mild updates, the 2025 Artura is poised to defend its title as the makers most affordable McLaren supercar.	256308	2025 McLaren Artura	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	35	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-mclaren-artura-spider-mmp-102-jpg-65dd244300333.jpg?crop=0.668xw:0.566xh;0.101xw,0.386xh&resize=700:*"}
474	The 2025 McLaren GTS may bear initials that stand for "grand tourer," but this isn't a typical high-speed cruiser. 	240000	2025 McLaren GT / GTS	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	35	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-mclaren-gts-action-101-6596fa2b97171.jpg?crop=0.619xw:0.618xh;0.285xw,0.205xh&resize=700:*"}
475	The McLaren 12C may not look as exotic as a Ferrari 458, and unless you’re a racing fan, the McLaren name may not mean much, but the 12C is nonetheless a bona fide supercar.	3081633	2014 McLaren 12C	38	42f14c9c-944a-4c08-82bd-bfc4df28ff17	35	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/14q1/567120/2014-mclaren-12c-coupe-photo-567129-s-986x603.jpg?crop=0.974xw:0.895xh;0.0256xw,0.105xh&resize=700:*"}
476	The 2020 McLaren 570S may be an affordable alternative to true supercars, but it pulls heartstrings and spikes heart rates alongside the most sought-after exotics.	195000	2020 McLaren 570S / 570GT	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	35	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-mclaren-570s-mmp-1-1575324044.jpg?crop=0.739xw:0.623xh;0,0.377xh&resize=700:*"}
483	The P1 is a superhero among supercars: supermodel shapely, heroically powerful, stratospherically expensive, and - here's the one drawback - unavailable.	7819004	2014 McLaren P1	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	35	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2014-mclaren-p1-1111-charlie-magee-1531410060.jpg?crop=0.962xw:0.882xh;0,0.118xh&resize=700:*"}
478	The 650S may look like a face-lifted 12C, but there’s a lot more to it: The revised styling pays tribute to the P1 hybrid, the body tub is lighter, and about 25 percent of the parts are new.	8349440	2016 McLaren 650S	36	42f14c9c-944a-4c08-82bd-bfc4df28ff17	35	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/577110/2015-mclaren-650s-photo-577137-s-986x603.jpg?crop=0.875xw:0.804xh;0.00160xw,0.196xh&resize=700:*"}
479	The striking design of the McLaren 720S matches its next-level performance, which is saying something since it can rocket to 120 mph in under 7 seconds.	310500	2023 McLaren 720S	39	42f14c9c-944a-4c08-82bd-bfc4df28ff17	35	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2019-mclaren-720s-spider-508-1565493374.jpg?crop=0.629xw:0.577xh;0.303xw,0.402xh&resize=700:*"}
480	This hugely powerful and hard-core supercar is focused on performance above all, even though it’s now only available as a droptop Spider model.	382500	2022 McLaren 765LT	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	35	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-mclaren-765lt-spider-115-1652724748.jpg?crop=0.795xw:0.671xh;0.0913xw,0.0986xh&resize=700:*"}
481	The Elva ditches its windshield to deliver a purer driving experience, and the company will make just 399 examples of this dazzling speedster.	1695000	2021 McLaren Elva	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	35	{"img" : "https://hips.hearstapps.com/hmg-prod/images/mclaren-elva-101-1573589515.jpg?crop=1.00xw:0.924xh;0,0.0759xh&resize=700:*"}
482	Want to make that smug jerk at the country club with the Ferrari 458 shut up? Buy one of these.	3698171	2012 McLaren MP4-12C	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	35	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/10q1/331226/2011-mclaren-mp4-12c-photo-331261-s-986x603.jpg?crop=0.997xw:0.919xh;0.00321xw,0.0812xh&resize=700:*"}
488	Hot-blooded performance and angry styling are hallmarks of the Mercedes-AMG brand, and the 2024 CLA-class offers plenty of both in a compact package.	56100	2024 Mercedes-AMG CLA-class	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-amg-cla-coupe-101-1674062194.jpg?crop=0.790xw:0.445xh;0.104xw,0.277xh&resize=700:*"}
484	Swift and thunderous, the Senna is a hypercar built to run circles—quite literally—around its competition at the track.	1000000	2020 McLaren Senna	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	35	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2018-mclaren-senna-ll-103-1570476637.jpg?crop=0.651xw:0.596xh;0.308xw,0.404xh&resize=700:*"}
485	Rare, stylized, and exotic, the 2020 McLaren Speedtail sets the pace for all other hypercars. 	2100000	2020 McLaren Speedtail	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	35	{"img" : "https://hips.hearstapps.com/hmg-prod/images/mclaren-speedtail-newlead-1540507641.jpg?crop=1.00xw:0.923xh;0,0.0771xh&resize=700:*"}
486	The masterminds at Mercedes-AMG have been set loose on the C-class and have created the C43 sports sedan, powered by a 402-hp turbo four-cylinder powertrain.	62000	2024 Mercedes-AMG C43	33	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-mercedes-amg-c43-sedan-drive-106-1656425569.jpg?crop=0.726xw:0.615xh;0.256xw,0.341xh&resize=700:*"}
487	The Mercedes-AMG C63 has returned for 2024 having swapped its twin-turbo V-8 for a turbo four-cylinder hybrid setup with 671 hp and technology cribbed from F1.	100000	2024 Mercedes-AMG C63	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-mercedes-amg-c63-s-e-performance-114-65d79698b0e26.jpg?crop=0.591xw:0.499xh;0.397xw,0.422xh&resize=700:*"}
491	Though it’s fast and full of electronic gizmos, the 2024 Mercedes-AMG EQE53 can’t replicate the thrills of the gas-powered E63 despite costing around the same. 	109000	2024 Mercedes-AMG EQE	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-mercedes-amg-eqe-390-6452793b1503d.jpg?crop=0.580xw:0.489xh;0.199xw,0.472xh&resize=700:*"}
489	The new-for-2024 Mercedes-AMG CLE53 coupe is the standard CLE-class's more athletic twin, as proven by its 443 horsepower and sportier handling. 	85000	2024 Mercedes-AMG CLE53 Coupe	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-amg-cle53-coupe-exterior-108-656f5c1081c7b.jpg?crop=0.547xw:0.466xh;0.236xw,0.337xh&resize=700:*"}
490	The Mercedes-AMG E53 performance sedan returns for 2025 with a potent plug-in hybrid powertrain and a revised suspension baked into the classic E-class blueprint.	84000	2025 Mercedes-AMG E53	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/24c0084-008-65ede55955d3e.jpg?crop=0.744xw:0.744xh;0.170xw,0.222xh&resize=700:*"}
492	The Mercedes-AMG EQS53 pours on the power and performance we expect from AMG and marries it with the luxury we'd expect in an S-class. 	148700	2024 Mercedes-AMG EQS	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-mercedes-amg-eqs-544-1657821224.jpg?crop=0.669xw:0.566xh;0.314xw,0.432xh&resize=700:*"}
493	The AMG GT sedan combines punchy powertrains, dramatic styling, and a well-appointed cabin to create an impressive luxury missile for the road. 	100100	2024 Mercedes-AMG GT 4-Door	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-amg-gt-4-door-coupe-101-652d62264a28d.jpg?crop=1.00xw:0.752xh;0,0.150xh&resize=700:*"}
495	Focusing its plug-in hybrid powertrain for power instead of range, the 2024 Mercedes-AMG S63 is a most comfortable way to experience 791 horsepower.   	190000	2024 Mercedes-AMG S63	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/22c0377-013-1670273650.jpg?crop=0.758xw:0.639xh;0.0753xw,0.325xh&resize=700:*"}
494	The all-new 2024 Mercedes-AMG GT Coupe is a bigger and better grand tourer, with a roomier cabin and all-wheel drive balancing its scintillating turbo-V-8.	136050	2024 Mercedes-AMG GT Coupe	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-amg-gt-131-654bc96f8591b.jpg?crop=0.498xw:0.421xh;0.263xw,0.245xh&resize=700:*"}
497	The 2024 Mercedes-AMG EQE SUV is the first high-power fully electric SUV with a three-pointed star on its nose, and it packs up to 677 horsepower. 	110450	2024 Mercedes-AMG EQE SUV	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-amg-eqe-suv-131-65256efc10a85.jpg?crop=0.582xw:0.490xh;0.114xw,0.269xh&resize=700:*"}
496	A rolling embodiment of the good life, the Mercedes SL convertible offers luxury and performance but, most of all, prestige.	111000	2024 Mercedes-AMG SL-Class	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-mercedes-amg-sl-43-roadster-474-659d747ff1871.jpg?crop=0.566xw:0.477xh;0.244xw,0.379xh&resize=700:*"}
498	The 2025 Mercedes-AMG G63 is luxurious, quick, and capable off-road, three traits that when combined turn a once crude military vehicle into a modern treasure.	190000	2025 Mercedes-AMG G63	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-mercedes-amg-g63-exterior-102-6601c60516ddc.jpg?crop=0.753xw:0.635xh;0.125xw,0.245xh&resize=700:*"}
505	Though it’s fast and full of electronic gizmos, the 2024 Mercedes-AMG EQE53 can’t replicate the thrills of the gas-powered E63 despite costing around the same. 	109000	2024 Mercedes-AMG EQE	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-mercedes-amg-eqe-390-6452793b1503d.jpg?crop=0.580xw:0.489xh;0.199xw,0.472xh&resize=700:*"}
499	The feisty AMG GLA35 crossover sees the addition of hybrid-assist technology for the 2024 model year along with refreshed styling and newly available options.	57600	2024 Mercedes-AMG GLA-class	33	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-amg-gla-101-64130f2036bf4.jpg?crop=0.782xw:0.660xh;0.124xw,0.271xh&resize=700:*"}
500	The wizards at AMG have stuffed 302 horsepower in the 2024 Mercedes-AMG GLB35 along with a snappy eight-speed dual-clutch automatic, and the result is a hoot. 	60200	2024 Mercedes-AMG GLB35	38	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-amg-glb-101-64130f6cad884.jpg?crop=0.748xw:0.631xh;0.0928xw,0.191xh&resize=700:*"}
501	This compact rocket from Stuttgart runs a downsized turbo four, but the mad scientists at AMG have tuned it up with EV assistance to make up to 671 horsepower.	70000	2025 Mercedes-AMG GLC-Class	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-amg-glc-63-s-e-performance-140-6527fe7d8dd84.jpg?crop=0.713xw:0.601xh;0.163xw,0.373xh&resize=700:*"}
502	The 2025 Mercedes-AMG GLC63 Coupe returns to the lineup this year packing 671 horsepower, joining the tamer 416-hp GLC43 Coupe.	72000	2025 Mercedes-AMG GLC-Class Coupe	32	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-mercedes-amg-glc63-s-e-performance-coupe-105-6512df31276db.jpg?crop=0.559xw:0.473xh;0.256xw,0.395xh&resize=700:*"}
503	Included along with the 2024 Mercedes-AMG GLE-class's cushy interior and raw performance is the mid-size luxury SUV's impressive trailering capability.	87900	2024 Mercedes-AMG GLE-class	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-amg-gle53-478-6481df35777ea.jpg?crop=0.604xw:0.508xh;0.319xw,0.458xh&resize=700:*"}
504	There’s a tiny niche at the intersection of three-row crossovers, luxury cars, and muscle trucks, which is where the 2024 GLS63 sits, rumbling threateningly. 	147000	2024 Mercedes-AMG GLS63 4Matic	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-amg-gls63-103-642b777fa7be3.jpg?crop=0.800xw:0.678xh;0.106xw,0.118xh&resize=700:*"}
507	The Mercedes-AMG EQS53 pours on the power and performance we expect from AMG and marries it with the luxury we'd expect in an S-class. 	148700	2024 Mercedes-AMG EQS	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-mercedes-amg-eqs-544-1657821224.jpg?crop=0.669xw:0.566xh;0.314xw,0.432xh&resize=700:*"}
506	The 2024 Mercedes-AMG EQE SUV is the first high-power fully electric SUV with a three-pointed star on its nose, and it packs up to 677 horsepower. 	110450	2024 Mercedes-AMG EQE SUV	40	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-amg-eqe-suv-131-65256efc10a85.jpg?crop=0.582xw:0.490xh;0.114xw,0.269xh&resize=700:*"}
510	Whenever you add the letters AMG to a Mercedes model, you are sure to get breathtaking performance, and the CLS63 AMG is no exception.	3778663	2018 Mercedes-AMG CLS63 S 4Matic	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2013-cls63-amg-3-source-1557856819.jpg?crop=0.998xw:0.794xh;0,0.101xh&resize=700:*"}
508	Aside from a ride that can be harsh and a cabin that can be noisy, the Mercedes-AMG A35 compact sedan is snazzy, sporty, and not too pricey.	46900	2021 Mercedes-AMG A35 / A45	34	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-mercedes-amg-a35-sedan-105-1553617759.jpg?crop=0.907xw:0.764xh;0.0465xw,0.151xh&resize=700:*"}
509	Along with seamless technology and a sophisticated cabin, the CLS53 has more muscle than the standard CLS and swoopier styling than the AMG E53 sedan.	82600	2021 Mercedes-AMG CLS53 4Matic	39	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2021-mercedes-amg-cls53-mmp-1-1591824641.jpg?crop=0.702xw:0.591xh;0.205xw,0.269xh&resize=700:*"}
515	The latest Mercedes-Benz C-class is a lot like a miniature S-class, with similar looks and tech features, only in a smaller package that’s sportier to drive.	48100	2024 Mercedes-Benz C-class	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-mercedes-benz-c300-4matic-sedan-112-1655383531.jpg?crop=0.780xw:0.658xh;0.119xw,0.298xh&resize=700:*"}
511	The 2023 Mercedes-AMG E6 S is the last chapter for ICE-exclusive variants of the high-performance marque, and its twin-turbo V8 is an honorable way to go out. 	113950	2023 Mercedes-AMG E63 S 4Matic	35	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-mercedes-amg-e63-s-4matic-103-1671563913.jpg?crop=0.554xw:0.467xh;0.274xw,0.396xh&resize=700:*"}
512	The 2023 Mercedes-AMG E63 S Wagon offers the same supercar performance and luxury appointments as the E63 S sedan, but with more room for your track-day tires. 	122250	2023 Mercedes-AMG E63 S Wagon	32	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2021-mercedes-amg-e63-s-4matic-wagon-102-1592409363.jpg?crop=0.741xw:0.626xh;0.223xw,0.374xh&resize=700:*"}
513	The top-flight GL63 AMG is built for those who crave performance, luxury, and exclusivity—you know, the good things in life.	411550	2016 Mercedes-AMG GL63	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2013-gl63-5-source-1557857408.jpg?crop=1.00xw:0.889xh;0,0.111xh&resize=700:*"}
514	Although the SLC43 is dated in certain respects, it impresses with its sharp handling and appealing design. 	65645	2020 Mercedes-AMG SLC43	40	42f14c9c-944a-4c08-82bd-bfc4df28ff17	90	{"img" : "https://hips.hearstapps.com/hmg-prod/images/mercedes-amg-slc43-roadster-41-source-1578338364.jpg?crop=0.824xw:0.692xh;0.0537xw,0.308xh&resize=700:*"}
518	Available in both coupe and convertible forms, the new CLE-class bridges the gap between the C-class and E-class coupes and looks better than both in the process.	57650	2024 Mercedes-Benz CLE-class	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-benz-cle-300-coupe-123-64ef8532d9840.jpg?crop=0.588xw:0.495xh;0.122xw,0.490xh&resize=700:*"}
516	Mercedes-Benz has given the handsome CLA-class a light refresh for the 2024 model year, including a mild-hybrid system and subtle styling tweaks. 	44350	2024 Mercedes-Benz CLA-class	38	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-benz-cla-coupe-101-1674062332.jpg?crop=0.763xw:0.448xh;0.147xw,0.313xh&resize=700:*"}
517	Mercedes-Benz's next entry-level CLA-class will include an all-electric model previewed by the stunning Concept CLA show car. 	55000	2026 Mercedes-Benz CLA-Class EV	37	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/img-1027-64f3b28ae3f87.jpeg?crop=0.935xw:0.939xh;0,0&resize=700:*"}
521	Despite a spacious interior and impressive real-world range, the 2024 Mercedes-Benz EQE sedan doesn’t feel like it belongs to the brand.	76050	2024 Mercedes-Benz EQE	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-mercedes-benz-eqe-350-131-1649789876.jpg?crop=0.674xw:0.675xh;0.305xw,0.264xh&resize=700:*"}
519	Mercedes-Benz ushers in the next-generation E-Class for the 2024 model year, and it features new looks and underpinnings.	63350	2024 Mercedes-Benz E-class	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-benz-e-class-exterior-105-6446a2cb7003d.jpg?crop=0.758xw:0.638xh;0.103xw,0.319xh&resize=700:*"}
578	The electric 2024 Nissan Leaf hatchback doesn't have much driving range, but it's among the most affordable EVs you can buy.	29280	2024 Nissan Leaf	40	42f14c9c-944a-4c08-82bd-bfc4df28ff17	22	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-nissan-leaf-9-1200x800-1649785072.jpg?crop=0.736xw:0.620xh;0.0817xw,0.303xh&resize=700:*"}
520	The 2024 Mercedes-Benz E-Class wagon has a somewhat small cult following, yet it gets an entirely new look and a wider cabin, plus a small bump in horsepower. 	75000	2024 Mercedes-Benz E-class Wagon	39	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-benz-e-class-103-64f2208293e41.jpg?crop=0.751xw:0.632xh;0.164xw,0.310xh&resize=700:*"}
523	The 2024 Mercedes-Benz S-class is the quintessential luxury sedan, and it continues to offer all-day comfort, cutting-edge tech, and powerful powertrains.	118450	2024 Mercedes-Benz S-class	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-mercedes-benz-s500-4matic-109-1642184016.jpg?crop=0.647xw:0.548xh;0.116xw,0.313xh&resize=700:*"}
522	The Mercedes-Benz EQS EV abounds with luxury and enough tech to rival NASA but is more alluring for its technology than its character or driving dynamics. 	105550	2024 Mercedes-Benz EQS	33	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-benz-eqs-101-650df40bc7927.jpg?crop=0.635xw:0.535xh;0.104xw,0.430xh&resize=700:*"}
524	The 2024 Mercedes-Benz EQB's appeal is that it's so similar to its gas-burning counterpart that it little effort for drivers to transition to the EV lifestyle.	54200	2024 Mercedes-Benz EQB	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-benz-eqb-115-64e65142310f6.jpg?crop=0.658xw:0.658xh;0.184xw,0.191xh&resize=700:*"}
526	Mercedes is future-proofing the iconic G-class by creating the EQG, keeping the off-road chops but replacing the V-8 engine with electric motors and batteries. 	150000	2025 Mercedes-Benz EQG	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/21c0550-001-1630936200.jpg?crop=1.00xw:0.903xh;0,0.0513xh&resize=700:*"}
525	The 2024 Mercedes-Benz EQE SUV's smooth, rounded appearance doesn't look like other crossovers, but it's no less of a luxury vehicle.	79650	2024 Mercedes-Benz EQE SUV	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-mercedes-benz-eqe-suv-107-1665782652.jpg?crop=0.642xw:0.541xh;0.121xw,0.268xh&resize=700:*"}
527	From its posh cabin to its strong performance, the 2024 Mercedes-Benz EQS offers all of the deliverables you’d expect of an S-class SUV—except a need for gas. 	105550	2024 Mercedes-Benz EQS SUV	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-mercedes-benz-eqs-580-108-651f105066ea4.jpg?crop=0.853xw:0.719xh;0.0946xw,0.173xh&resize=700:*"}
528	The Mercedes-Benz G-Wagen long ago transcended its military roots to become a celebrated token of wealth, and its G550 descendant has been refreshed for 2025. 	150000	2025 Mercedes-Benz G-class	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-mercedes-benz-g550-exterior-101-6602bc5e12338.jpg?crop=0.832xw:0.702xh;0.139xw,0.0986xh&resize=700:*"}
529	Mercedes-Benz has revitalized the GLA-class subcompact crossover for 2024 with a new face, a new booty, an updated interior, and hybrid technology. 	43000	2024 Mercedes-Benz GLA-class	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-benz-gla-103-64130fa2909a4.jpg?crop=0.782xw:0.660xh;0.122xw,0.186xh&resize=700:*"}
532	The 2024 GLC-class takes everything we like about the Mercedes-Benz C-class sedan—including posh digs and high-tech features—and wraps it in an SUV body. 	48600	2024 Mercedes-Benz GLC-class	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-mercedes-benz-glc-class-plug-in-hybrid-105-1654031645.jpg?crop=0.689xw:0.584xh;0.122xw,0.332xh&resize=700:*"}
530	The 2024 Mercedes-Benz GLB-class makes the most out of its subcompact size with a wide cabin and no shortage of traditional Mercedes luxury.    	45800	2024 Mercedes-Benz GLB-class	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-benz-glb-103-64130fe3c2d7b.jpg?crop=0.950xw:0.802xh;0.0505xw,0.134xh&resize=700:*"}
531	The 2024 Mercedes-Benz GLC Coupe puts a sporty twist on the GLC-Class SUV but is packed with just as much luxury and additional standard features.	58150	2024 Mercedes-Benz GLC Coupe	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-benz-glc-coupe12-640f848fd86dc.jpg?crop=0.679xw:0.573xh;0.148xw,0.346xh&resize=700:*"}
539	The 2024 Mercedes-Benz EQB's appeal is that it's so similar to its gas-burning counterpart that it little effort for drivers to transition to the EV lifestyle.	54200	2024 Mercedes-Benz EQB	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-benz-eqb-115-64e65142310f6.jpg?crop=0.658xw:0.658xh;0.184xw,0.191xh&resize=700:*"}
533	Mercedes-Benz's latest plug-in hybrid is the 2025 GLC350e SUV, which boasts an estimated 70 miles of EV driving range. 	55000	2025 Mercedes-Benz GLC-Class Hybrid	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-mercedes-benz-glc350e-104-65fb428b1bb43.jpg?crop=1.00xw:0.850xh;0,0.150xh&resize=700:*"}
534	For brand-conscious buyers, the 2024 Mercedes-Benz GLE-class is an SUV with designer credentials, but it does little to differentiate itself from its rivals.	63800	2024 Mercedes-Benz GLE-class	38	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-benz-gle-101-1675179423.jpg?crop=0.796xw:0.448xh;0.124xw,0.290xh&resize=700:*"}
535	With three rows of seats, the 2024 GLS-class allows the whole family to experience Mercedes-level luxury while rewarding its driver with surprising agility.	88150	2024 Mercedes-Benz GLS-class	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-benz-gls-class-101-642b77729761e.jpg?crop=0.938xw:0.791xh;0.0337xw,0.0505xh&resize=700:*"}
536	Move over Ford E-Transit, Mercedes-Benz has entered the electric van segment with the 2024 eSprinter, which should offeraround 230 miles of driving per charge.	74181	2024 Mercedes-Benz eSprinter	36	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-benz-esprinter-143-65bd4dacd7978.jpg?crop=0.654xw:0.549xh;0.144xw,0.233xh&resize=700:*"}
537	The Mercedes-Benz Sprinter van’s price premium over rivals pays for additional refinement, configurability, and tech options.  	52195	2024 Mercedes-Benz Sprinter	36	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-mercedes-benz-sprinter-210-1668724421.jpg?crop=0.938xw:0.791xh;0,0.127xh&resize=700:*"}
538	Mercedes-Benz's next entry-level CLA-class will include an all-electric model previewed by the stunning Concept CLA show car. 	55000	2026 Mercedes-Benz CLA-Class EV	38	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/img-1027-64f3b28ae3f87.jpeg?crop=0.935xw:0.939xh;0,0&resize=700:*"}
543	The Mercedes-Benz EQS EV abounds with luxury and enough tech to rival NASA but is more alluring for its technology than its character or driving dynamics. 	105550	2024 Mercedes-Benz EQS	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-benz-eqs-101-650df40bc7927.jpg?crop=0.635xw:0.535xh;0.104xw,0.430xh&resize=700:*"}
540	Despite a spacious interior and impressive real-world range, the 2024 Mercedes-Benz EQE sedan doesn’t feel like it belongs to the brand.	76050	2024 Mercedes-Benz EQE	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-mercedes-benz-eqe-350-131-1649789876.jpg?crop=0.674xw:0.675xh;0.305xw,0.264xh&resize=700:*"}
541	The 2024 Mercedes-Benz EQE SUV's smooth, rounded appearance doesn't look like other crossovers, but it's no less of a luxury vehicle.	79650	2024 Mercedes-Benz EQE SUV	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-mercedes-benz-eqe-suv-107-1665782652.jpg?crop=0.642xw:0.541xh;0.121xw,0.268xh&resize=700:*"}
542	Mercedes is future-proofing the iconic G-class by creating the EQG, keeping the off-road chops but replacing the V-8 engine with electric motors and batteries. 	150000	2025 Mercedes-Benz EQG	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/21c0550-001-1630936200.jpg?crop=1.00xw:0.903xh;0,0.0513xh&resize=700:*"}
544	From its posh cabin to its strong performance, the 2024 Mercedes-Benz EQS offers all of the deliverables you’d expect of an S-class SUV—except a need for gas. 	105550	2024 Mercedes-Benz EQS SUV	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-mercedes-benz-eqs-580-108-651f105066ea4.jpg?crop=0.853xw:0.719xh;0.0946xw,0.173xh&resize=700:*"}
545	Move over Ford E-Transit, Mercedes-Benz has entered the electric van segment with the 2024 eSprinter, which should offeraround 230 miles of driving per charge.	74181	2024 Mercedes-Benz eSprinter	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-benz-esprinter-143-65bd4dacd7978.jpg?crop=0.654xw:0.549xh;0.144xw,0.233xh&resize=700:*"}
548	The C63 AMG coupe is the final place of refuge for Benz’s 451-hp, naturally aspirated 6.	9011056	2014 Mercedes-Benz C63 AMG	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/10q1/337554/2009-mercedes-benz-c63-amg-photo-337576-s-986x603.jpg?crop=0.998xw:0.921xh;0,0.0628xh&resize=700:*"}
546	Distilling a luxury brand's ethos down to an affordable entry-level sedan is a task wrought with compromise, but the Mercedes-Benz A-class pulls it off. 	35000	2022 Mercedes-Benz A-class	38	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2019-mercedes-benz-a220-4matic-mmp-1-1638557009.jpg?crop=1.00xw:0.846xh;0,0.0505xh&resize=700:*"}
547	The B-class puts some juice into the legendary three-pointed star, making for a truly electrifying experience.	9292789	2017 Mercedes-Benz B-class Electric Drive	36	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/13q1/509414/2014-mercedes-benz-b-class-electric-drive-photo-509419-s-986x603.jpg?crop=0.902xw:0.827xh;0.00160xw,0.173xh&resize=700:*"}
554	Crazy expensive, hugely powerful, and anachronistic in looks, this is not for the shy.	2933596	2015 Mercedes-Benz G63 / G65 AMG	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/wp-content/uploads/2012/04/2013-Mercedes-Benz-G63-AMG-Placement-626x382.jpg?crop=0.994xw:0.916xh;0.00641xw,0.0840xh&resize=700:*"}
549	Proud, indomitable, utterly stable and intimidating, Benz’s big coupes should come with a Swiss bank account and diplomatic immunity.	5304593	2014 Mercedes-Benz CL-class	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/10q4/368263/2011-mercedes-benz-cl550-4matic-mercedes-benz-cl-class-test-car-and-driver-photo-378877-s-original.jpg?crop=0.990xw:0.913xh;0.00962xw,0.0866xh&resize=700:*"}
550	They’re more like road-bound private jets than two-door coupes: big, thundering on the outside (but quiet inside), and relentless.	9606734	2014 Mercedes-Benz CL63 / CL65 AMG	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/13q3/528438/2013-mercedes-benz-cl65-amg-photo-540038-s-986x603.jpg?crop=0.660xw:0.607xh;0.311xw,0.380xh&resize=700:*"}
551	The CLK-class offers style, comfort, speed, and a decent rear seat but at a price that exceeds that of rivals.	48975	2009 Mercedes-Benz CLK-class	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/02q3/267342/2003-mercedes-benz-clk-class-photo-9900-s-original.jpg?crop=0.995xw:0.919xh;0.00321xw,0.0419xh&resize=700:*"}
552	The Mercedes-Benz CLS-Class is a form-first art piece that just so happens to provide the practicality of a chic four-door sedan. 	77650	2023 Mercedes-Benz CLS-class	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-mercedes-benz-cls-109-1617703653.jpg?crop=0.932xw:0.787xh;0.0554xw,0.213xh&resize=700:*"}
553	Based on the last-generation Mercedes-Benz B-class, the hydrogen-powered F-cell is an electric mini-minivan fueled by compressed hydrogen.	6620465	2013 Mercedes-Benz F-cell	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/mercedes-benz-f-cell-photo-466565-s-986x603-1621529545.jpeg?crop=1.00xw:1.00xh;0,0&resize=700:*"}
558	If a compact city van with a Mercedes three-pointed star on the grille is something you must have, this year is your last chance to own one. 	41495	2023 Mercedes-Benz Metris	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2021-mercedes-benz-metris-weekender-102-1610119462.jpg?crop=0.655xw:0.553xh;0.210xw,0.262xh&resize=700:*"}
555	As the hot-rod crossover version of the CLA45, the GLA45 AMG adds hatchback convenience to already-crazy performance.	778992	2016 Mercedes-Benz GLA45 AMG	33	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/14q1/562853/2015-mercedes-benz-gla45-amg-photo-562855-s-986x603.jpg?crop=0.947xw:0.869xh;0.0465xw,0.131xh&resize=700:*"}
556	To keep it fresh in a crowded segment, the GLK receives a face lift, an upgraded interior, and a more powerful V-6 with fuel-saving stop-start technology.	38825	2015 Mercedes-Benz GLK-class	32	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/51/2013-mercedes-benz-glk-class-inline-2-photo-460241-s-original.jpg?crop=0.997xw:0.921xh;0.00160xw,0.0709xh&resize=700:*"}
557	There’s much to like about the M-class—the first-rate cabin, modern tech, and towing ability—but those seeking something sporty should keep looking.	6514313	2015 Mercedes-Benz M-class	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/05q2/267355/2006-mercedes-benz-m-class-photo-9120-s-original.jpg?crop=0.992xw:0.913xh;0.00801xw,0.0866xh&resize=700:*"}
560	The R-class is a luxurious, if slightly weird, way to move up to seven people.	7218185	2012 Mercedes-Benz R-class	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/05q3/267356/mercedes-benz-r-class-photo-9081-s-original.jpg?crop=1.00xw:0.921xh;0,0.0787xh&resize=700:*"}
559	At about twice the cost of a base ML350, the ML63 AMG requires a big outlay to enjoy its prodigious power and exclusivity.	4785584	2015 Mercedes-Benz ML63 AMG	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/12q1/438933/2012-mercedes-benz-ml63-amg-photo-438961-s-986x603.jpg?crop=0.998xw:0.921xh;0.00160xw,0.0445xh&resize=700:*"}
561	Behold these Teutonic chariots that mix sumptuous luxury with earth-shaking power.	6295306	2015 Mercedes-Benz S63 / S65 AMG	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/10q2/352282/2010-mercedes-benz-s63-amg-photo-352385-s-986x603.jpg?crop=0.995xw:0.919xh;0,0.0602xh&resize=700:*"}
564	With two seats, a luxurious interior, and a standard retractable hardtop, the SLK is like a scaled-down SL-class for around half the price.	3975082	2016 Mercedes-Benz SLK-class	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2014-mercedes-benz-slk250-401-1557933315.jpg?crop=0.816xw:0.749xh;0.0272xw,0.251xh&resize=700:*"}
562	With potent powertrains and terrific ride and handling, the elegant yet sporty Mercedes-Benz SL-class has aged but still has sparkling curb appeal.	91995	2020 Mercedes-Benz SL-class	40	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-mercedes-benz-sl-class-mmp-1-1574793555.jpg?crop=0.938xw:0.816xh;0,0.0720xh&resize=700:*"}
563	Other luxury roadsters offer more room, but the 2020 Mercedes-Benz SLC-class looks great and is fun to drive. 	50945	2020 Mercedes-Benz SLC-class	38	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/slc-1557931546.jpg?crop=0.866xw:0.710xh;0.0928xw,0.290xh&resize=700:*"}
566	Originally sold as a coupe, the SLR is now available only as a roadster.	500750	2009 Mercedes-Benz SLR-class	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/229102/2007-mercedes-benz-slr-mclaren-722-s-photo-229126-s-986x603.jpg?crop=0.923xw:0.848xh;0.0160xw,0.152xh&resize=700:*"}
565	Underneath the SLK55’s long, handsome hood dwells a hand-built 5.	2541919	2015 Mercedes-Benz SLK55 AMG	35	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2013-slk55-25-source-1557934978.jpg?crop=1.00xw:0.780xh;0,0.162xh&resize=700:*"}
628	The 2019 Porsche 911 GT2 RS currently sits atop the performance hierarchy of the storied 911 nameplate.	294450	2019 Porsche 911 GT2 RS	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	10	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/wp-content/uploads/2017/06/2018-Porsche-911-GT2-RS-102.jpg?crop=1.00xw:0.921xh;0,0.0341xh&resize=700:*"}
567	The SLS AMG GT is an incredibly fast and rare supercar that harkens back to the Gullwings of yore.	9494451	2015 Mercedes-Benz SLS AMG	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	32	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2014-mercedes-benz-sls-amg-black-series-photo-504146-s-986x603-1557935241.jpg?crop=0.840xw:0.772xh;0.0705xw,0.228xh&resize=700:*"}
568	The 2024 Maybach S-class offers the world's wealthiest a place to rest their weary heads on the commute between their rooftop helipad and their Hamptons estate.	199450	2024 Mercedes-Maybach S-Class	33	42f14c9c-944a-4c08-82bd-bfc4df28ff17	56	{"img" : "https://hips.hearstapps.com/hmg-prod/images/23c0184-002-646cbd4d9fce4.jpg?crop=1.00xw:0.798xh;0,0.132xh&resize=700:*"}
569	Mercedes will likely give its SL-class convertible the Maybach treatment, which means high-end luxury crafted with the finest materials. 	175000	2025 Mercedes-Maybach SL-Class	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	56	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-mercedes-maybach-sl-class-101-1676496202.jpg?crop=0.881xw:0.786xh;0.0962xw,0.214xh&resize=700:*"}
570	Waiting for an ultra-luxury EV before making the switch from gas to electricity? Get your checkbook ready because the 2024 Mercedes-Maybach EQS680 SUV is here.	181050	2024 Mercedes-Maybach EQS SUV	39	42f14c9c-944a-4c08-82bd-bfc4df28ff17	56	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-maybach-eqs680-101-643d3507c2518.jpg?crop=0.915xw:0.343xh;0.0847xw,0.407xh&resize=700:*"}
571	Vehicles wearing the Maybach badge, such as the 2024 Mercedes-Maybach GLS600, offer the utmost in luxury and a transportation experience as rich as caviar.	175500	2024 Mercedes-Maybach GLS-class	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	56	{"img" : "https://hips.hearstapps.com/hmg-prod/images/23c0120-003-642ec7a9c47e0.jpg?crop=1.00xw:0.798xh;0,0.0522xh&resize=700:*"}
572	Waiting for an ultra-luxury EV before making the switch from gas to electricity? Get your checkbook ready because the 2024 Mercedes-Maybach EQS680 SUV is here.	181050	2024 Mercedes-Maybach EQS SUV	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	56	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-mercedes-maybach-eqs680-101-643d3507c2518.jpg?crop=0.915xw:0.343xh;0.0847xw,0.407xh&resize=700:*"}
573	Rolls-Royce and Bentley are the traditional ultra-luxury marques, but look far enough back into history and the Maybach name pops up.	379050	2012 Mercedes-Maybach 57	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	56	{"img" : "https://hips.hearstapps.com/hmg-prod/images/maybach-57-img-132-1200x800-1558022536.jpg?crop=1.00xw:0.844xh;0,0.156xh&resize=700:*"}
574	Smooth, quiet, and very fast, this huge luxury sedan seems to defy physics with its road-going capabilities.	5196238	2012 Mercedes-Maybach 62	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	56	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2003-maybach-62-sedan-1539698987.jpg?crop=0.981xw:0.901xh;0,0.0995xh&resize=700:*"}
575	Looking very much like the answer to an unasked question, Maybach offers this very expensive, very limited edition of its 62 sedan.	8193750	2012 Mercedes-Maybach Landaulet	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	56	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/167575/maybach-landaulet-photo-168595-s-986x603.jpg?crop=1.00xw:0.921xh;0,0.0785xh&resize=700:*"}
576	The Altima isn’t out to impress, but its success comes from hitting the targets important to young families: affordability, roominess, frugality, and comfort.	27140	2024 Nissan Altima	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	22	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-nissan-altima-sl-awd-163-6580987a4ce0f.jpg?crop=0.700xw:0.590xh;0.253xw,0.386xh&resize=700:*"}
577	The Nissan GT-R has been tweaked (yet again) for 2024 and sees the return of the T-spec trim level as well as a pair of iconic heritage paint colors.	122985	2024 Nissan GT-R	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	22	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-nissan-gt-r-119-1673621285.jpg?crop=0.673xw:0.673xh;0,0.113xh&resize=700:*"}
579	After the gas-powered Nissan Maxima ends production, its name will adorn a new electric sedan that'll likely be inspired by the 2019 IMs concept.	44000	2026 Nissan Maxima	34	42f14c9c-944a-4c08-82bd-bfc4df28ff17	22	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-nissan-maxima-101-6440035e59aa2.jpg?crop=1.00xw:0.954xh;0,0&resize=700:*"}
581	With decent driving dynamics and a fuel-efficient engine, the 2024 Nissan Versa sedan is a handsome and competent daily driver.	17530	2024 Nissan Versa	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	22	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-nissan-versa-103-6509c73352bac.jpg?crop=0.822xw:0.309xh;0.0537xw,0.655xh&resize=700:*"}
582	The 2024 Nissan Z sports is an homage to the icons that have come before it, but this time it’s stacked with a 400-horsepower powertrain.	43450	2024 Nissan Z	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	22	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-nissan-z-nismo-116-64c8117a866f8.jpg?crop=0.768xw:0.649xh;0.0561xw,0.267xh&resize=700:*"}
583	The newest kid on the block at Nissan, the electric 2024 Ariya, has striking looks, an estimated 304 miles of max driving range, and plenty of passenger space.	40980	2024 Nissan Ariya	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	22	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-nissan-ariya-empower-297-1669827758.jpg?crop=0.651xw:0.549xh;0.282xw,0.415xh&resize=700:*"}
584	The 2024 Nissan Armada’s body-on-frame construction and brawny V-8 provide ample utility, towing power, and passenger room—and a robust thirst for fuel. 	57730	2024 Nissan Armada	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	22	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-nissan-armada-102-650c6314e0cd7.jpg?crop=0.547xw:0.460xh;0.182xw,0.262xh&resize=700:*"}
585	The Kicks gets a fully modern glow-up and moves closer to traditional crossover-SUV territory with the addition of all-wheel drive and increased ride height. 	23000	2025 Nissan Kicks	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	22	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-nissan-kicks-front-three-quarters-studio-65fd949f6d47a.jpg?crop=0.909xw:0.778xh;0.0913xw,0.134xh&resize=700:*"}
586	Nissan's two-row mid-size crossover is in for a comprehensive makeover for the 2025 model year, with updated styling and a gas-powered engine.	37000	2025 Nissan Murano	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	22	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-nissan-murano-spied-front-64fb1a7fa3fa4.jpg?crop=1.00xw:0.846xh;0,0.122xh&resize=700:*"}
587	With a spacious cabin that has room for up to eight people, the 2024 Nissan Pathfinder is ready for family transportation duty.	37470	2024 Nissan Pathfinder	36	42f14c9c-944a-4c08-82bd-bfc4df28ff17	22	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-nissan-pathfinder-platinum-awd-237-1637092220.jpg?crop=0.704xw:0.592xh;0.0801xw,0.357xh&resize=700:*"}
588	The 2024 Nissan Rogue has a smooth-riding demeanor and a nicely appointed interior, but other compact SUVs are more compelling.	29810	2024 Nissan Rogue	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	22	{"img" : "https://hips.hearstapps.com/hmg-prod/images/my24-nissan-rogue-0064-652d3f2fbc97a.jpg?crop=0.760xw:0.639xh;0.154xw,0.262xh&resize=700:*"}
589	Tough looks, modern amenities, and plenty of options make the 2024 Nissan Frontier a truck worth considering. 	31540	2024 Nissan Frontier	37	42f14c9c-944a-4c08-82bd-bfc4df28ff17	22	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-nissan-frontier-114-65031bc46fc48.jpg?crop=0.734xw:0.619xh;0,0.161xh&resize=700:*"}
590	The end is near for the 2024 Nissan Titan full-size pickup that's offered a comfy cabin and a strong 400-hp V-8 powertrain.	48050	2024 Nissan Titan	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	22	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-nissan-titan-101-64cd25ee80f43.jpg?crop=0.884xw:0.748xh;0.0879xw,0.110xh&resize=700:*"}
591	The 2024 Nissan Titan rides better than heavy-duty trucks but is less capable than some half-ton models, so it draws little interest in no-man's land.	54210	2024 Nissan Titan XD	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	22	{"img" : "https://hips.hearstapps.com/hmg-prod/images/24-titan-1-64dbe781f281f.jpg?crop=0.587xw:0.542xh;0.165xw,0.208xh&resize=700:*"}
592	The newest kid on the block at Nissan, the electric 2024 Ariya, has striking looks, an estimated 304 miles of max driving range, and plenty of passenger space.	40980	2024 Nissan Ariya	33	42f14c9c-944a-4c08-82bd-bfc4df28ff17	22	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-nissan-ariya-empower-297-1669827758.jpg?crop=0.651xw:0.549xh;0.282xw,0.415xh&resize=700:*"}
593	The electric 2024 Nissan Leaf hatchback doesn't have much driving range, but it's among the most affordable EVs you can buy.	29280	2024 Nissan Leaf	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	22	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-nissan-leaf-9-1200x800-1649785072.jpg?crop=0.736xw:0.620xh;0.0817xw,0.303xh&resize=700:*"}
594	After the gas-powered Nissan Maxima ends production, its name will adorn a new electric sedan that'll likely be inspired by the 2019 IMs concept.	44000	2026 Nissan Maxima	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	22	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-nissan-maxima-101-6440035e59aa2.jpg?crop=1.00xw:0.954xh;0,0&resize=700:*"}
595	Whimsical styling sets the Cube apart from its boxy competitors, but unfortunately, that’s about all it has going for it.	1983254	2014 Nissan Cube	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	22	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2010-nissan-cube-s-photo-263683-s-986x603-1557851294.jpg?crop=1.00xw:0.921xh;0,0.0785xh&resize=700:*"}
596	The Juke puts the FUN in funky, making it perfect for those who want a spry and speedy little runabout that also stands out in traffic.	4720554	2017 Nissan Juke	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	22	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2015-nissan-juke-sl-101-1557851642.jpg?crop=0.933xw:0.861xh;0.0337xw,0.139xh&resize=700:*"}
597	If you’re looking to turn up the insanity on the standard and already-cheeky Juke, there’s the NISMO and NISMO RS.	77787	2017 Nissan Juke NISMO / NISMO RS	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	22	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2014-nissan-juke-nismo-rs-photo-678718-s-986x603-1557851745.jpg?crop=0.752xw:0.691xh;0.248xw,0.181xh&resize=700:*"}
598	One of the largest commercial vans on the market, the 2021 Nissan NV is a traditional full-size rear-wheel-drive van designed to meet the needs of businesses.	32135	2021 Nissan NV1500 / 2500 / 3500	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	22	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2021-nissan-nv-mmp-1-1606171075.jpg?crop=0.829xw:0.710xh;0.0849xw,0.127xh&resize=700:*"}
600	Slightly larger than most of the mini SUVs it competes with, the 2022 Nissan Rogue Sport will still take up less space in your garage than the larger Rogue.	26255	2022 Nissan Rogue Sport	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	22	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-nissan-rogue-sport-1630609852.jpg?crop=0.853xw:0.719xh;0.0577xw,0.166xh&resize=700:*"}
601	At Nissan, the word NISMO means add performance, and the Sentra NISMO follows that recipe - just barely.	6416495	2019 Nissan Sentra NISMO	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	22	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2017-nissan-sentra-nismo-1557854624.jpg?crop=1.00xw:0.924xh;0,0.0761xh&resize=700:*"}
602	The 2019 Nissan Versa Note is among the most affordable vehicles sold in America, even though it's not the most appealing.	16545	2019 Nissan Versa Note	37	42f14c9c-944a-4c08-82bd-bfc4df28ff17	22	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2015-nissan-versa-note-sr-mmp-1-1557254081.jpg?crop=1.00xw:0.927xh;0,0.0735xh&resize=700:*"}
605	The 2024 718 Boxster is Porsche's entry-level car, but its brilliant handling and powerful engines make it anything but a diluted version of the hallowed 911.	72050	2024 Porsche 718 Boxster	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	10	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-porsche-718-boxster-101-1674591861.jpg?crop=0.663xw:0.604xh;0.0657xw,0.277xh&resize=700:*"}
606	Few cars offer the same purity of mission as the 2024 Cayman: Its mid-engine setup and expertly tuned chassis give it a driving demeanor that's truly addictive. 	69950	2024 Porsche 718 Cayman	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	10	{"img" : "https://hips.hearstapps.com/hmg-prod/images/718-style-edition-18-1667334774.jpg?crop=0.704xw:0.594xh;0.192xw,0.125xh&resize=700:*"}
607	The upcoming 2025 Porsche 718 EV will serve as the eventual all-electric replacement for the fuel-burning 718 Cayman and Boxster sports cars. 	78000	2025 Porsche 718 EV	34	42f14c9c-944a-4c08-82bd-bfc4df28ff17	10	{"img" : "https://hips.hearstapps.com/hmg-prod/images/porsche-e-cayman-6410b6b983924.jpg?crop=0.915xw:0.823xh;0.0847xw,0.174xh&resize=700:*"}
608	A master of subtle reinvention, the 2025 Porsche 911 promises more power and its first-ever hybrid powertrains.	117000	2025 Porsche 911	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	10	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-porsche-911-spied-front-658200b0a3a5d.jpg?crop=1.00xw:0.846xh;0,0.0793xh&resize=700:*"}
609	Simply put, the 911 GT3 and GT3 RS are utterly transcendent sports cars, blending everything we love about the standard 911 with otherworldly performance.	184550	2024 Porsche 911 GT3 / GT3 RS	36	42f14c9c-944a-4c08-82bd-bfc4df28ff17	10	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-porsche-911-st-exterior-112-64c929acc5b31.jpg?crop=0.640xw:0.541xh;0.0684xw,0.210xh&resize=700:*"}
610	The 911 Turbo looks like other 911s, but its ballistic performance and eye-watering price puts it the same stratosphere as Ferraris and Lamborghinis.	198850	2024 Porsche 911 Turbo / Turbo S	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	10	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2021-porsche-911-turbo-s-pdk-296-1608061360.jpg?crop=0.623xw:0.525xh;0.317xw,0.434xh&resize=700:*"}
611	More horsepower, new standard features, and fresh styling give the 2024 Porsche Panamera a more luxurious vibe, but it's still the fun-to-drive sedan we know and love.	101550	2024 Porsche Panamera	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	10	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-porsche-panamera-118-65f05ae681051.jpg?crop=0.550xw:0.463xh;0.0865xw,0.365xh&resize=700:*"}
612	The Porsche Panamera Turbo luxury sedan boasts V-8 power and loads of charisma, and it's redesigned for 2025 with a powerful plug-in-hybrid powertrain.	192995	2025 Porsche Panamera Turbo / Turbo S	37	42f14c9c-944a-4c08-82bd-bfc4df28ff17	10	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-porsche-panamera-turbo-e-hybrid-104-65f05925881bd.jpg?crop=0.697xw:0.588xh;0.0449xw,0.259xh&resize=700:*"}
613	The 2025 Taycan EV drives like a Porsche, and improvements to its battery and charging speed mean you can drive even farther between charges. 	101395	2025 Porsche Taycan	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	10	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-porsche-taycan-exterior-101-65c12d3599cc7.jpg?crop=0.777xw:0.583xh;0.123xw,0.254xh&resize=700:*"}
614	With blistering acceleration, deft handling, and a long-roof body style, the Taycan Cross Turismo is an EV supercar with side order of cargo space.	113095	2025 Porsche Taycan Cross Turismo	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	10	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-porsche-taycan-4s-sport-turismo-exterior-103-65c12e49779d3.jpg?crop=0.720xw:0.541xh;0.160xw,0.216xh&resize=700:*"}
615	People love SUVs for their useful space and comfy cabins, but the 2024 Porsche Cayenne also offers performance aligned with that of its sports car stablemates.	80850	2024 Porsche Cayenne	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	10	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-porsche-cayenne-118-65ea08e5872e8.jpg?crop=0.700xw:0.591xh;0.165xw,0.296xh&resize=700:*"}
616	The refreshed 2024 Porsche Cayenne Coupe gains horsepower, subtle updates to its looks, and an interior featuring wall-to-wall infotainment screens. 	85950	2024 Porsche Cayenne Coupe	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	10	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-porsche-cayenne-coupe-101-643eaefc8014b.jpg?crop=0.588xw:0.495xh;0.210xw,0.210xh&resize=700:*"}
617	The 650 horsepower contained within the 2024 Porsche Cayenne Coupe Turbo GT is spicy, but the 729-hp Turbo E-Hybrid is even wilder.	153050	2024 Porsche Cayenne Coupe Turbo / Turbo GT	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	10	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-porsche-cayenne-turbo-gt-037-0k2a3582-645e5db1df07c.jpg?crop=0.740xw:0.625xh;0.120xw,0.276xh&resize=700:*"}
618	Porsche is taking its Cayenne SUV electric for 2026 with the launch of the Cayenne EV which will eventually replace the model's gas-powered variants. 	80000	2026 Porsche Cayenne EV	39	42f14c9c-944a-4c08-82bd-bfc4df28ff17	10	{"img" : "https://hips.hearstapps.com/hmg-prod/images/porsche-e-cayenne-coupe-640f2f1373dac.jpg?crop=0.915xw:0.794xh;0,0.206xh&resize=700:*"}
603	Boasting shapely sheetmetal and a meticulously crafted cabin, the 2020 Pagani Huayra is a hypercar like no other.	3400000	2020 Pagani Huayra	32	42f14c9c-944a-4c08-82bd-bfc4df28ff17	75	{"img" : "https://hips.hearstapps.com/hmg-prod/images/pagani-huayra-bc-roadster-121-1564501509.jpg?crop=0.746xw:0.686xh;0.135xw,0.263xh&resize=700:*"}
619	Already one of the quickest SUVs we've ever tested, the 2024 Porsche Cayenne Turbo E-Hybrid now comes with 729 horsepower and more battery than before.	148550	2024 Porsche Cayenne Turbo	33	42f14c9c-944a-4c08-82bd-bfc4df28ff17	10	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-porsche-cayenne-turbo-e-hybrid-103-64ecf8a8a14c7.jpg?crop=0.673xw:0.568xh;0.269xw,0.271xh&resize=700:*"}
620	Most SUVs can't get out of their own way on curvy roads, but where the 2024 Porsche Macan is concerned, zig-zagging is playtime—and good luck catching up. 	62550	2024 Porsche Macan	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	10	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-porsche-macan-s-102-6514924138123.jpg?crop=0.749xw:0.631xh;0.208xw,0.330xh&resize=700:*"}
621	Porsche has transformed its bestseller, the Macan crossover, into an EV SUV, promising close to 300 miles of range, athletic handling, and rapid acceleration. 	80450	2024 Porsche Macan EV	33	42f14c9c-944a-4c08-82bd-bfc4df28ff17	10	{"img" : "https://hips.hearstapps.com/hmg-prod/images/macan-turbo-004-low-65b1cd2523e8c.jpg?crop=0.843xw:0.632xh;0.139xw,0.254xh&resize=700:*"}
622	Porsche's performance SUV expertise culminates in the sports-car-esque 2024 Macan GTS, making it one of the most exciting crossovers to drive.	88450	2024 Porsche Macan GTS	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	10	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-porsche-macan-gts-101-6509f94941301.jpg?crop=0.738xw:0.623xh;0.186xw,0.249xh&resize=700:*"}
623	The upcoming 2025 Porsche 718 EV will serve as the eventual all-electric replacement for the fuel-burning 718 Cayman and Boxster sports cars. 	78000	2025 Porsche 718 EV	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	10	{"img" : "https://hips.hearstapps.com/hmg-prod/images/porsche-e-cayman-6410b6b983924.jpg?crop=0.915xw:0.823xh;0.0847xw,0.174xh&resize=700:*"}
624	Porsche is taking its Cayenne SUV electric for 2026 with the launch of the Cayenne EV which will eventually replace the model's gas-powered variants. 	80000	2026 Porsche Cayenne EV	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	10	{"img" : "https://hips.hearstapps.com/hmg-prod/images/porsche-e-cayenne-coupe-640f2f1373dac.jpg?crop=0.915xw:0.794xh;0,0.206xh&resize=700:*"}
625	Porsche has transformed its bestseller, the Macan crossover, into an EV SUV, promising close to 300 miles of range, athletic handling, and rapid acceleration. 	80450	2024 Porsche Macan EV	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	10	{"img" : "https://hips.hearstapps.com/hmg-prod/images/macan-turbo-004-low-65b1cd2523e8c.jpg?crop=0.843xw:0.632xh;0.139xw,0.254xh&resize=700:*"}
626	The 2025 Taycan EV drives like a Porsche, and improvements to its battery and charging speed mean you can drive even farther between charges. 	101395	2025 Porsche Taycan	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	10	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-porsche-taycan-exterior-101-65c12d3599cc7.jpg?crop=0.777xw:0.583xh;0.123xw,0.254xh&resize=700:*"}
627	With blistering acceleration, deft handling, and a long-roof body style, the Taycan Cross Turismo is an EV supercar with side order of cargo space.	113095	2025 Porsche Taycan Cross Turismo	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	10	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-porsche-taycan-4s-sport-turismo-exterior-103-65c12e49779d3.jpg?crop=0.720xw:0.541xh;0.160xw,0.216xh&resize=700:*"}
630	With a thrilling twin-turbo V-6 and a clairvoyant chassis, the Porsche Macan Turbo delivers a transcendent driving experience unlike any other crossover.	85950	2021 Porsche Macan Turbo	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	10	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2021-porsche-macan-turbo-mmp-1-1605284123.jpg?crop=1.00xw:0.849xh;0,0.0889xh&resize=700:*"}
629	It took Porsche years to develop a worthy successor to the vaunted Carrera GT supercar, but at last, the 918 is here, and it’s a plug-in hybrid!	1470628	2015 Porsche 918	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	10	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/13q3/535605/2015-porsche-918-spyder-photo-536898-s-986x603.jpg?crop=0.862xw:0.793xh;0.138xw,0.207xh&resize=700:*"}
631	The Porsche Panamera Sport Turismo packs German-bred performance and luxury into wagon proportions, and offers an array of powertrains plus plentiful options.	104650	2023 Porsche Panamera Sport Turismo	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	10	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-porsche-panamera-sport-turismo-e-hybrid-103-1673277927.jpg?crop=0.583xw:0.493xh;0.332xw,0.387xh&resize=700:*"}
632	Whether you're old money or nouveau riche, there's no better way to flaunt it than in a Rolls-Royce Ghost.	354750	2024 Rolls-Royce Ghost	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	27	{"img" : "https://hips.hearstapps.com/hmg-prod/images/p90508471-highres-rolls-royce-ghost-ex-copy-64dbcad7a198e.jpg?crop=0.622xw:0.437xh;0.160xw,0.415xh&resize=700:*"}
634	Rolls-Royce is rolling into the EV market with the 2024 Spectre coupe, which offers colossal power, an ultra-luxe cabin, and 260 miles of range. 	422750	2024 Rolls-Royce Spectre	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	27	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-rolls-royce-spectre-122-649dd25e96ff7.jpg?crop=0.574xw:0.486xh;0.263xw,0.325xh&resize=700:*"}
633	Offering the ultimate in luxurious lifestyle driving, the Rolls-Royce Phantom continues to boldly float down the road.  	505750	2024 Rolls-Royce Phantom	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	27	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-rolls-royce-phantom-102-64bad70ba7661.jpg?crop=0.637xw:0.644xh;0.248xw,0.236xh&resize=700:*"}
636	Rolls-Royce is rolling into the EV market with the 2024 Spectre coupe, which offers colossal power, an ultra-luxe cabin, and 260 miles of range. 	422750	2024 Rolls-Royce Spectre	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	27	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-rolls-royce-spectre-122-649dd25e96ff7.jpg?crop=0.574xw:0.486xh;0.263xw,0.325xh&resize=700:*"}
635	Silent, effortlessly powerful, and velvety smooth, the posh Rolls-Royce Cullinan SUV plies the roads with blue-blooded imperiousness. 	391750	2024 Rolls-Royce Cullinan	40	42f14c9c-944a-4c08-82bd-bfc4df28ff17	27	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-rolls-royce-cullinan-black-badge-blue-shadow-101-64809ab949271.jpg?crop=0.819xw:0.818xh;0.138xw,0.182xh&resize=700:*"}
637	Like the rest of the lineup, the 2021 Rolls-Royce Dawn provides an opulent cabin—but with an alfresco twist that makes it perfect for wealthy sun worshippers.	359250	2021 Rolls-Royce Dawn	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	27	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2021-rolls-royce-dawn-mmp-1-1608324097.jpg?crop=1.00xw:0.714xh;0,0.124xh&resize=700:*"}
642	Expected to make its return to the lineup for the 2026 model year, the new Tesla Roadster picks up where the old model left off.	200000	2026 Tesla Roadster	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	1	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/wp-content/uploads/2017/11/Tesla-Roadster-103.jpg?crop=0.792xw:0.733xh;0.136xw,0.225xh&resize=700:*"}
638	For those who desire sybaritic luxury and a spirited driving experience in the same ultra-pricey motorcar, the 2019 Rolls-Royce Ghost Series II is your answer.	4154021	2019 Rolls-Royce Ghost Series II	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	27	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2015-rolls-royce-series-ii-mmp-1-1556749597.jpg?crop=0.971xw:0.890xh;0.0224xw,0.110xh&resize=700:*"}
639	The 2021 Rolls-Royce Wraith coupe exudes all the gravitas and refinement you'd expect from the British automaker, and it does so at a price that ensures exclusivity.	343350	2021 Rolls-Royce Wraith	36	42f14c9c-944a-4c08-82bd-bfc4df28ff17	27	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2021-rolls-royce-wraith-mmp-1-1606926586.jpg?crop=0.787xw:0.663xh;0.0881xw,0.250xh&resize=700:*"}
640	Say what you will about Tesla and its leader, Elon Musk, but the Model 3 EV sedan changed the rules of the EV game, and it gets important updates this year. 	40630	2024 Tesla Model 3	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	1	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-tesla-model-3-european-model-3-64f21a71e3c45.png?crop=0.721xw:0.865xh;0.117xw,0.00346xh&resize=700:*"}
641	While the 2024 Tesla Model S has fallen behind newer rivals with more luxury features, it remains a compelling choice for its long driving range.	76630	2024 Tesla Model S	31	42f14c9c-944a-4c08-82bd-bfc4df28ff17	1	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-tesla-model-s-107-6572200e43fa1.jpg?crop=0.586xw:0.496xh;0.204xw,0.271xh&resize=700:*"}
644	While it’s more popular with buyers than the Model 3 sedan on which it’s based, the 2024 Tesla Model Y is an altogether less satisfying offering.	44630	2024 Tesla Model Y	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	1	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-tesla-model-y-long-range-101-1592842279.jpg?crop=0.590xw:0.499xh;0.319xw,0.364xh&resize=700:*"}
643	The 2024 Model X has viciously quick acceleration and impressive range but lacks the posh interior and build quality that should be standard for the price.	81630	2024 Tesla Model X	40	42f14c9c-944a-4c08-82bd-bfc4df28ff17	1	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-tesla-model-x-123-656e3825810bc.jpg?crop=0.479xw:0.433xh;0.261xw,0.297xh&resize=700:*"}
647	The all-electric GMC Hummer EV SUV will have a smaller impact on carbon emissions than its infamous gas-powered predecessors, and a big impact on EVs. 	79995	2024 GMC Hummer EV SUV	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	37	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-gmc-hummer-ev-suv-302-6419ae6383a10.jpg?crop=0.761xw:0.642xh;0.194xw,0.190xh&resize=700:*"}
645	The Tesla Cybertruck looks like it was dropped off by an alien race, but it has the capabilities to challenge all of the top-selling pickup trucks.	81895	2024 Tesla Cybertruck	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	1	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-tesla-cybertruck-115-65e8945de87ba.jpg?crop=0.684xw:0.576xh;0.106xw,0.391xh&resize=700:*"}
646	A fresh chassis shakes things up, in a good way, for the next-gen 2024 GMC Acadia, which has 328 horsepower, available all-wheel drive, and three rows of seats.	43995	2024 GMC Acadia	34	42f14c9c-944a-4c08-82bd-bfc4df28ff17	37	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-gmc-acadia-113-64ff2ddcac924.jpg?crop=0.735xw:0.481xh;0,0.422xh&resize=700:*"}
649	The 2024 GMC Yukon and Yukon XL comfortably seat up to eight passengers and they also have the capability to tow the party boat close behind. 	60195	2024 GMC Yukon / Yukon XL	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	37	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-gmc-yukon-at4-102-654d2f3b1dc59.jpg?crop=0.946xw:0.797xh;0.00977xw,0.105xh&resize=700:*"}
648	Despite a roomy cabin, a modern look, and decent standard tech, the 2024 GMC Terrain's middling build quality and subpar materials hold it back from competitors.	30095	2024 GMC Terrain	39	42f14c9c-944a-4c08-82bd-bfc4df28ff17	37	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-gmc-terrain-elevation-front-1624628471.jpg?crop=0.656xw:0.658xh;0.160xw,0.293xh&resize=700:*"}
652	The 2024 GMC Sierra 1500 looks as sharp as a drywall knife, with enough powertrain and cab configurations to finish the rest of the house after the mud dries. 	38345	2024 GMC Sierra 1500	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	37	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-gmc-sierra-1500-denali-ultimate-101-1652106391.jpg?crop=0.853xw:0.721xh;0.0244xw,0.164xh&resize=700:*"}
650	The 2024 GMC Canyon lineup gains an even wilder off-road AT4X AEV Edition trim that makes good on its small package-big power promise.	37595	2024 GMC Canyon	21	42f14c9c-944a-4c08-82bd-bfc4df28ff17	37	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-gmc-canyon-at4x-aev-001-653277c4420f7.jpeg?crop=0.728xw:0.615xh;0.135xw,0.240xh&resize=700:*"}
651	With heart-racing acceleration and humongous proportions, the 2024 GMC Hummer EV pickup truck will astound some people and offend others.	98845	2024 GMC Hummer EV Pickup	38	42f14c9c-944a-4c08-82bd-bfc4df28ff17	37	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-gmc-hummer-ev-edition-1-pickup-122-1657891660.jpg?crop=1.00xw:0.847xh;0,0.132xh&resize=700:*"}
653	The ultimate GMC pickup has an available Duramax turbo-diesel powertrain that gives the 2024 GMC Sierra HD up to 22,500 pounds of conventional towing. 	47395	2024 GMC Sierra 2500HD / 3500 HD	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	37	{"img" : "https://hips.hearstapps.com/hmg-prod/images/my24-gmc-sierra-hd-at4-gmca6553-v2-1665023844.jpg?crop=0.697xw:0.523xh;0.244xw,0.312xh&resize=700:*"}
697	The S90 looks the part of a luxury sedan both inside and out, but it has some quirks and is not quite as refined as its design suggests.	59495	2024 Volvo S90	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	34	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-volvo-s90-102-649314d6859dc.jpg?crop=0.384xw:0.398xh;0.419xw,0.425xh&resize=700:*"}
654	GMC enters the electric-truck ring with the Sierra EV pickup, which will launch for 2024 with the 754-hp, $100,000-plus Denali Edition 1 model.	108695	2024 GMC Sierra EV	40	42f14c9c-944a-4c08-82bd-bfc4df28ff17	37	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-sierra-ev-denali-edition-1-01-1666286777.jpg?crop=0.468xw:0.480xh;0.133xw,0.360xh&resize=700:*"}
655	A time-tested apparatus for hauling tools, packages, and people, the GMC Savana van is the segment’s towing champ and longest running model. 	42595	2024 GMC Savana	40	42f14c9c-944a-4c08-82bd-bfc4df28ff17	37	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-gmc-savana-65788564ebf27.jpg?crop=0.699xw:0.691xh;0.301xw,0.129xh&resize=700:*"}
656	With heart-racing acceleration and humongous proportions, the 2024 GMC Hummer EV pickup truck will astound some people and offend others.	98845	2024 GMC Hummer EV Pickup	35	42f14c9c-944a-4c08-82bd-bfc4df28ff17	37	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-gmc-hummer-ev-edition-1-pickup-122-1657891660.jpg?crop=1.00xw:0.847xh;0,0.132xh&resize=700:*"}
658	GMC enters the electric-truck ring with the Sierra EV pickup, which will launch for 2024 with the 754-hp, $100,000-plus Denali Edition 1 model.	108695	2024 GMC Sierra EV	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	37	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-sierra-ev-denali-edition-1-01-1666286777.jpg?crop=0.468xw:0.480xh;0.133xw,0.360xh&resize=700:*"}
661	The 2024 VinFast VF6 is an affordable compact battery-electric SUV with a front-drive single-motor powertrain.  	30000	2024 VinFast VF6	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	109	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-vinfast-vf6-103-1669660034.jpg?crop=0.920xw:0.920xh;0.0785xw,0.0541xh&resize=700:*"}
659	No matter which flavor of GM's mid-size SUV you choose—GMC Envoy or Chevrolet TrailBlazer—the truck is basically the same.	31370	2009 GMC Envoy	39	42f14c9c-944a-4c08-82bd-bfc4df28ff17	37	{"img" : "https://hips.hearstapps.com/hmg-prod/images/x09gm-en001-1557843579.jpg?crop=1.00xw:0.848xh;0,0.152xh&resize=700:*"}
660	VinFast is targeting the low end of the electric car market with the sub-$20,000 VF3, which wears a rugged look to disguise its status as a small hatchback. 	20000	2026 VinFast VF3	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	109	{"img" : "https://hips.hearstapps.com/hmg-prod/images/photo-2-659ebfe96d6ad.jpg?crop=0.651xw:0.550xh;0,0.406xh&resize=700:*"}
668	The 2025 Golf R continues its mission of bringing the heat to the hot-hatch segment without compromising its trademark practical compact four-door format.	48000	2025 Volkswagen Golf R	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/images/db2024al00026-large-65b7d14becca5.jpeg?crop=0.952xw:0.803xh;0.0449xw,0.197xh&resize=700:*"}
662	The VinFast VF7 electric crossover is set to enter the market for the 2024 model year, slotting between the smaller VF6 and larger VF8. 	37000	2024 VinFast VF7	35	42f14c9c-944a-4c08-82bd-bfc4df28ff17	109	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-vinfast-vf7-101-1669828168.jpg?crop=0.928xw:0.931xh;0,0.0347xh&resize=700:*"}
663	The 2024 VinFast VF8 is quick, and a new battery vastly improves range, but its interior quality leaves it still feeling like a half-baked first try.	47200	2024 VinFast VF8	35	42f14c9c-944a-4c08-82bd-bfc4df28ff17	109	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-vinfast-vf8-8311-64638b6f4efeb.jpg?crop=0.651xw:0.550xh;0.182xw,0.347xh&resize=700:*"}
666	The Volkswagen Arteon is a great sedan with lots of space but despite its charm, VW has decided to discontinue its full-size entry after the 2024 model year.	49225	2024 Volkswagen Arteon	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-volkswagen-arteon-sel-r-line-102-1654208285.jpg?crop=0.526xw:0.445xh;0.296xw,0.315xh&resize=700:*"}
667	VW’s hot hatchback is getting notable tech and styling updates for 2025, but we’re sad about it losing the available manual transmission.	34000	2025 Volkswagen Golf GTI	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-volkswagen-golf-gti-exterior-107-65b00ecf4496e.jpg?crop=0.692xw:0.583xh;0.153xw,0.217xh&resize=700:*"}
670	The 2024 Volkswagen Jett excels as a compact, fuel-efficient sedan with a smooth ride, but thrill seekers will want to step up to the GLI.	22660	2024 Volkswagen Jetta	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-volkswagen-jetta-sport-1-5t-manual-34-6410731d8206e.jpg?crop=0.747xw:0.630xh;0.103xw,0.267xh&resize=700:*"}
669	Volkswagen's expanding ID family of EVs is growing to include the ID.7 sedan, a Passat-sized four-door with sleek, aerodynamic lines.	50000	2025 Volkswagen ID.7	35	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-volkswagen-id-7-155-654d08d72fbd3.jpg?crop=0.736xw:0.620xh;0.139xw,0.137xh&resize=700:*"}
672	With lots of space and a handsome new face, the three-row 2024 Volkswagen Atlas is refreshed with new hair and makeup. 	39420	2024 Volkswagen Atlas	25	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-volkswagen-atlas-141-64de23deaa818.jpg?crop=0.790xw:0.666xh;0.114xw,0.200xh&resize=700:*"}
671	Handy moves and 228 horsepower mixed with impressive highway fuel economy make the 2024 Jetta GLI as fun to drive as it is smart to own.	29310	2024 Volkswagen Jetta GLI	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-volkswagen-jetta-gli-40th-anniversary-edition-116-64be8dad122a5.jpg?crop=0.889xw:0.757xh;0.0391xw,0.125xh&resize=700:*"}
673	Volkswagen has given the Atlas Cross Sport a major refresh for the 2024 model year, which includes a new engine, revised interior, and tweaked exterior. 	38410	2024 Volkswagen Atlas Cross Sport	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-volkswagen-atlas-cross-sport-119-1675887590.jpg?crop=0.619xw:0.523xh;0.130xw,0.369xh&resize=700:*"}
674	The all-electric 2024 Volkswagen ID.4 has an accessible starting price and up to 275 miles of driving range—plus the space rear passengers love in an SUV.	41160	2024 Volkswagen ID.4	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-volkswagen-id-4-123-65df79e9e1b08.jpg?crop=0.527xw:0.445xh;0.247xw,0.327xh&resize=700:*"}
709	Volvo's next-generation lineup of electric vehicles will be bookended on one side by the flagship EX90 SUV and on the other by this much smaller EX30 crossover.	36245	2025 Volvo EX30	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	34	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-volvo-ex30-119-65426351615ff.jpg?crop=0.723xw:0.609xh;0.194xw,0.314xh&resize=700:*"}
675	If the ID.4 is too small for your family, VW's three-row ID.8 SUV will provide extra space as well as an all-electric powertrain with decent driving range.	45000	2026 Volkswagen ID.8	40	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/images/db2021au00294-large-1618704633.jpg?crop=0.870xw:0.734xh;0.0513xw,0.175xh&resize=700:*"}
676	With room for both people and cargo, as well as some solid fuel efficiency, the VW Taos makes the most of its small stature.	25420	2024 Volkswagen Taos	23	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-volkswagen-taos-101-64e660d305c89.jpg?crop=0.849xw:0.716xh;0.124xw,0.222xh&resize=700:*"}
677	The new VW Tiguan's arrival is so close you can almost smell it, but we know little about the compact SUV beyond it offering a plug-in-hybrid for the first time.	29000	2025 Volkswagen Tiguan	32	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/images/vwvwvwv23au01072-large-6509a6990708a.jpg?crop=0.740xw:0.625xh;0.0128xw,0.375xh&resize=700:*"}
678	The 2025 Volkswagen ID.Buzz represents the modern revival of the brand's beloved Microbus and will be one of the first electric vans on the market.	50000	2025 Volkswagen ID.Buzz	34	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-volkswagen-id-buzz-exterior-114-647a018868d87.jpeg?crop=0.787xw:0.665xh;0.116xw,0.205xh&resize=700:*"}
714	The S40 is one of those cars that might not get an enthusiast's pulse racing but is well worth considering.	650912	2011 Volvo S40	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	34	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/52489/volvo-s40-photo-57804-s-986x603.jpg?crop=1.00xw:0.919xh;0,0.0812xh&resize=700:*"}
680	Volkswagen's expanding ID family of EVs is growing to include the ID.7 sedan, a Passat-sized four-door with sleek, aerodynamic lines.	50000	2025 Volkswagen ID.7	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-volkswagen-id-7-155-654d08d72fbd3.jpg?crop=0.736xw:0.620xh;0.139xw,0.137xh&resize=700:*"}
719	The XC70 blurs the line between utility and luxury, with a dash of all-weather confidence and an outdoorsy image.	8027264	2016 Volvo XC70	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	34	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/575454/2014-volvo-xc70-awd-photo-575468-s-986x603.jpg?crop=1.00xw:0.849xh;0,0.125xh&resize=700:*"}
683	Its shape is among the most distinctive on the road; happily, the Beetle, offered as a coupe or a convertible, is as fun to drive as it looks.	21790	2019 Volkswagen Beetle	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2019-volkswagen-beetle-1661279648.jpg?crop=0.725xw:0.611xh;0.236xw,0.340xh&resize=700:*"}
684	Volkswagen’s top-of-the-line CC is an appealing—albeit aging—family sedan.	35340	2017 Volkswagen CC	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/wp-content/uploads/2012/05/2013-Volkswagen-CC-R-Line-01-626x382.jpg?crop=1.00xw:0.927xh;0,0.0709xh&resize=700:*"}
685	With all the sprightliness and most of the practicality of the regular Golf, the 2019 VW e-Golf is Volkswagen's electric car, and provides all-electric motoring in a handsome little package.	32790	2019 Volkswagen e-Golf	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-volksawagen-e-golf-mmp-1-1569525691.jpg?crop=1.00xw:0.849xh;0,0.0791xh&resize=700:*"}
687	With capacious cargo space and splendid driving manners, the Volkswagen Golf is a great compact hatchback, but it lives in the shadow of the hot GTI.	24190	2021 Volkswagen Golf	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2021-volkswagen-golf-mmp-1-1604508183.jpg?crop=0.814xw:0.688xh;0.175xw,0.255xh&resize=700:*"}
688	Just when you thought station wagons had all but disappeared, they have found a way to stay relevant: by mimicking crossovers.	27790	2019 Volkswagen Golf Alltrack	32	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2018-volkswagen-golf-alltrack-tsi-4motion-leadgallery-1544212342.jpg?crop=1.00xw:0.934xh;0,0.0661xh&resize=700:*"}
689	We've been singing the praises of the Volkswagen Golf for a decade.	22790	2019 Volkswagen Golf SportWagen	39	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2017-volkkswagen-golf-sportwagen-mmp-1555358938.jpg?crop=0.878xw:0.804xh;0.00160xw,0.196xh&resize=700:*"}
690	The Beetle’s roly-poly retro shape is built upon the bones of the previous-generation Golf.	9503962	2010 Volkswagen New Beetle	36	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/09q4/313813/2005-volkswagen-new-beetle-convertible-photo-314850-s-986x603.jpg?crop=1.00xw:0.921xh;0,0&resize=700:*"}
691	Apart from its notable refinement and popular features, the Volkswagen Passat mostly fails to stand out compared with other family sedans.	25000	2022 Volkswagen Passat	33	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-vw-passat-limited-edition-106-1626728438.jpg?crop=0.747xw:0.630xh;0.109xw,0.370xh&resize=700:*"}
692	The Rabbit replaced the aged Golf in 2007 and is basically a hatchback Jetta.	17000	2009 Volkswagen Rabbit	35	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/08q4/267373/2010-volkswagen-golf-rabbit-photo-242333-s-original.jpg?crop=1.00xw:0.921xh;0,0&resize=700:*"}
693	The company that credits itself with inventing the minivan turns to Chrysler to stay in the game.	5584677	2012 Volkswagen Routan	37	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/wp-content/uploads/2012/12/large_2010-routan-exterior1-l1-626x392.jpg?crop=1.00xw:0.898xh;0,0.102xh&resize=700:*"}
695	A new addition to the Volvo EV lineup, the 2026 ES90 promises all the brand's distinctive attributes in a mid-size sedan with an expected 300-plus-mile range. 	65000	2026 Volvo ES90	35	42f14c9c-944a-4c08-82bd-bfc4df28ff17	34	{"img" : "https://hips.hearstapps.com/hmg-prod/images/318849-volvo-ex30-cloud-blue-exterior-65a03c4b84744.jpg?crop=0.923xw:0.780xh;0,0.188xh&resize=700:*"}
700	The 2025 Volvo EC40 EV is a renamed version of the former C40 Recharge EV, and it carries on with only minimal changes. 	55000	2025 Volvo EC40	35	42f14c9c-944a-4c08-82bd-bfc4df28ff17	34	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-volvo-ec40-exterior-103-65d4db59299cb.jpg?crop=0.455xw:0.385xh;0.301xw,0.401xh&resize=700:*"}
701	Volvo's next-generation lineup of electric vehicles will be bookended on one side by the flagship EX90 SUV and on the other by this much smaller EX30 crossover.	36245	2025 Volvo EX30	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	34	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-volvo-ex30-119-65426351615ff.jpg?crop=0.723xw:0.609xh;0.194xw,0.314xh&resize=700:*"}
702	Filling the same spot in Volvo’s lineup as the former XC40 Recharge, the new 2025 EX40 offers the same practical yet upscale EV SUV personality with a new name.	54000	2025 Volvo EX40	33	42f14c9c-944a-4c08-82bd-bfc4df28ff17	34	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-volvo-ex40-exterior-108-65d4db673d6a3.jpg?crop=0.404xw:0.455xh;0.335xw,0.494xh&resize=700:*"}
703	Volvo’s new electric EX90 flagship SUV is coming for 2025 and it’s said to be the launch pad for the Swedish brand’s next-generation safety tech.	77990	2025 Volvo EX90	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	34	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-volvo-ex90-109-1667925362.jpg?crop=0.498xw:0.374xh;0.271xw,0.342xh&resize=700:*"}
704	The 2024 Volvo XC40 delivers huge practicality, a premium cabin, nice standard tech, and Volvo’s reputation for safety, all in a lively Swedish design.	41795	2024 Volvo XC40	34	42f14c9c-944a-4c08-82bd-bfc4df28ff17	34	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-volvo-xc40-b5-awd-ultimate-281-1669995831.jpg?crop=0.616xw:0.520xh;0.148xw,0.456xh&resize=700:*"}
705	Volvo blends its unique take on luxury with agreeable engine options and a serene cabin experience in the 2024 XC60 SUV. 	48195	2024 Volvo XC60	36	42f14c9c-944a-4c08-82bd-bfc4df28ff17	34	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2022-volvo-xc60-t8-e-awd-polestar-490-1654263965.jpg?crop=0.661xw:0.559xh;0.103xw,0.388xh&resize=700:*"}
706	The 2024 Volvo XC90 is aging gracefully, and it remains one of our favorite three-row mid-size luxury SUVs. 	57895	2024 Volvo XC90	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	34	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-volvo-xc90-101-649311ffdc60b.jpg?crop=0.536xw:0.401xh;0.292xw,0.382xh&resize=700:*"}
665	The electric VF Wild pickup truck gives us a glimpse at upstart VinFast's ambitions for success in North America—if it makes it to production. 	45000	2026 VinFast VF Wild	32	42f14c9c-944a-4c08-82bd-bfc4df28ff17	109	{"img" : "https://hips.hearstapps.com/hmg-prod/images/vinfast-debut-2-659dc0ea37071.jpg?crop=0.522xw:0.442xh;0.0893xw,0.398xh&resize=700:*"}
708	A new addition to the Volvo EV lineup, the 2026 ES90 promises all the brand's distinctive attributes in a mid-size sedan with an expected 300-plus-mile range. 	65000	2026 Volvo ES90	34	42f14c9c-944a-4c08-82bd-bfc4df28ff17	34	{"img" : "https://hips.hearstapps.com/hmg-prod/images/318849-volvo-ex30-cloud-blue-exterior-65a03c4b84744.jpg?crop=0.923xw:0.780xh;0,0.188xh&resize=700:*"}
710	Filling the same spot in Volvo’s lineup as the former XC40 Recharge, the new 2025 EX40 offers the same practical yet upscale EV SUV personality with a new name.	54000	2025 Volvo EX40	35	42f14c9c-944a-4c08-82bd-bfc4df28ff17	34	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-volvo-ex40-exterior-108-65d4db673d6a3.jpg?crop=0.404xw:0.455xh;0.335xw,0.494xh&resize=700:*"}
711	Volvo’s new electric EX90 flagship SUV is coming for 2025 and it’s said to be the launch pad for the Swedish brand’s next-generation safety tech.	77990	2025 Volvo EX90	36	42f14c9c-944a-4c08-82bd-bfc4df28ff17	34	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-volvo-ex90-109-1667925362.jpg?crop=0.498xw:0.374xh;0.271xw,0.342xh&resize=700:*"}
712	The C30 might be the best-looking vehicle to emerge from Gothenburg since, well, ever.	3281024	2013 Volvo C30	40	42f14c9c-944a-4c08-82bd-bfc4df28ff17	34	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/10q1/320812/2010-volvo-c30-european-spec-photo-320878-s-986x603.jpg?crop=0.981xw:0.901xh;0.0192xw,0.0995xh&resize=700:*"}
713	The C70 is a stylish four-place convertible with a folding metal roof that enables it to be year-round transportation in harsher climates.	4649478	2013 Volvo C70	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	34	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/216822/2009-volvo-c70-photo-216858-s-986x603.jpg?crop=1.00xw:0.919xh;0,0.0812xh&resize=700:*"}
715	Hardly thrilling to behold, the S80 is a stoic Swedish sedan that assures you with a safe and comforting presence.	6765826	2016 Volvo S80	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	34	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/181716/2008-volvo-s80-photo-181771-s-986x603.jpg?crop=1.00xw:0.919xh;0,0.0340xh&resize=700:*"}
716	Based on the S40 sedan, the V50 looks great, drives nicely, has standard safety features such as stability control, and has a roomy cargo area.	3109173	2011 Volvo V50	33	42f14c9c-944a-4c08-82bd-bfc4df28ff17	34	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/04q3/267352/volvo-v50-t5-awd-photo-5403-s-original.jpg?crop=1.00xw:0.921xh;0,0.0787xh&resize=700:*"}
717	Volvo’s big and stylish V70 wagon rides upon the same architecture as the S80 sedan.	4036970	2010 Volvo V70	32	42f14c9c-944a-4c08-82bd-bfc4df28ff17	34	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/wp-content/uploads/2016/02/6407_Volvo-V70-XC-1.jpg?crop=0.870xw:0.801xh;0.0337xw,0.199xh&resize=700:*"}
106	The TT is stylish, fun to drive, and has an inviting interior, even if its performance doesn’t match that of its top sports-car competition.	53295	2023 Audi TT / TTS	24	42f14c9c-944a-4c08-82bd-bfc4df28ff17	8	{"img" : "https://hips.hearstapps.com/hmg-prod/images/medium-12072-audittroadsterfinaleditioncelebratesalegacyoftheoriginalaudidesignicon-6543fdc836177.jpg?crop=0.734xw:0.619xh;0.113xw,0.296xh&resize=700:*"}
423	Although it’s more of a small premium hatchback than a real SUV, the Lexus UX300h is refined and packs plenty of luxury into its diminutive package. 	37490	2025 Lexus UX	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	26	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-lexus-uxh-fsport-001-65835bc060ab4.jpg?crop=0.702xw:0.682xh;0.101xw,0.279xh&resize=700:*"}
477	If you worship at the altar of speed, there's a car built just for you: the 600LT Spider.  	259000	2020 McLaren 600LT	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	35	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2020-mclaren-600lt-spider-ll-203-1570626802.jpg?crop=0.609xw:0.513xh;0.0945xw,0.323xh&resize=700:*"}
679	The all-electric 2024 Volkswagen ID.4 has an accessible starting price and up to 275 miles of driving range—plus the space rear passengers love in an SUV.	41160	2024 Volkswagen ID.4	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2024-volkswagen-id-4-123-65df79e9e1b08.jpg?crop=0.527xw:0.445xh;0.247xw,0.327xh&resize=700:*"}
681	If the ID.4 is too small for your family, VW's three-row ID.8 SUV will provide extra space as well as an all-electric powertrain with decent driving range.	45000	2026 Volkswagen ID.8	30	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/images/db2021au00294-large-1618704633.jpg?crop=0.870xw:0.734xh;0.0513xw,0.175xh&resize=700:*"}
682	The 2025 Volkswagen ID.Buzz represents the modern revival of the brand's beloved Microbus and will be one of the first electric vans on the market.	50000	2025 Volkswagen ID.Buzz	29	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-volkswagen-id-buzz-exterior-114-647a018868d87.jpeg?crop=0.787xw:0.665xh;0.116xw,0.205xh&resize=700:*"}
686	The Eos is a clever little combo: Its folding hardtop makes it a closed coupe, an open-air convertible, and the roof has a sliding sunroof, too.	1322990	2016 Volkswagen Eos	27	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/368299/2012-volkswagen-eos-20-tsi-european-spec-photo-368302-s-986x603.jpg?crop=0.966xw:0.885xh;0,0.115xh&resize=700:*"}
694	The Touareg is attractive, comfortable, and has good road manners, but competitors offer more for less money.	525629	2017 Volkswagen Touareg	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	33	{"img" : "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/images/media/672263/2017-volkswagen-touareg-in-depth-model-review-car-and-driver-photo-677902-s-original.jpg?crop=0.740xw:0.681xh;0.106xw,0.152xh&resize=700:*"}
696	The 2024 Volvo S60 succeeds as a comfortable, stylish sedan but falls short as a driver's car, which isn't a dealbreaker for folks who prefer the former.	43645	2024 Volvo S60	26	42f14c9c-944a-4c08-82bd-bfc4df28ff17	34	{"img" : "https://hips.hearstapps.com/hmg-prod/images/294035-s60-recharge-t8-thunder-grey-1647010632.jpg?crop=0.482xw:0.362xh;0.264xw,0.408xh&resize=700:*"}
698	The V60 station wagon offers an attractive alternative to a luxury SUV, providing unique style and a pleasant driving demeanor without sacrificing practicality.	51495	2024 Volvo V60 / V60 Cross Country	28	42f14c9c-944a-4c08-82bd-bfc4df28ff17	34	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2023-volvo-v60-cross-country-b5-awd-293-1667314391.jpg?crop=0.697xw:0.588xh;0.277xw,0.378xh&resize=700:*"}
707	The 2025 Volvo EC40 EV is a renamed version of the former C40 Recharge EV, and it carries on with only minimal changes. 	55000	2025 Volvo EC40	22	42f14c9c-944a-4c08-82bd-bfc4df28ff17	34	{"img" : "https://hips.hearstapps.com/hmg-prod/images/2025-volvo-ec40-exterior-103-65d4db59299cb.jpg?crop=0.455xw:0.385xh;0.301xw,0.401xh&resize=700:*"}
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profiles (id, first_name, last_name, birthday, gender, address, "userId") FROM stdin;
1	Nichole	Rice	\N	male	Ghana	8a8499d5-dd1a-44f4-b6e3-b060d59e29c2
2	Ervin	Rempel	\N	male	Gabon	117b3c84-afd1-413f-9a5a-31d98e555832
4	Asa	O'Connell	\N	male	Pakistan	8319d411-d31d-46f0-af23-4acf2dfc7b97
5	Cordia	Stroman	\N	male	Macedonia	2754613c-42f2-4cd7-94bd-2b095d268ec3
6	Tressie	Bernier	\N	female	Guatemala	7796e8d7-5708-4ed9-997b-b1f6f8e19655
7	Hassan	Cole	\N	male	China	eead8e1e-fa42-4134-9f2c-fd962eacee03
8	Abe	Dickinson	\N	female	Virgin Islands, British	2803284a-d4ef-46d7-aeb8-399d78ac42b6
9	Rogers	Cormier	\N	male	Christmas Island	624cde74-ac92-48d7-a83c-d91f1ea9cec0
11	Dariana	Lowe	\N	female	Brunei Darussalam	dc5cd101-cb4e-46e0-ba34-aad8e33bbd0e
12	Autumn	Murazik	\N	male	Bouvet Island (Bouvetoya)	8e403c42-1c46-44e7-a319-3a0909e1810f
13	Judy	MacGyver	\N	male	Virgin Islands, U.S.	8dd7438b-573d-4fc5-bdb4-abb536eed8c3
14	Modesta	Schmitt	\N	female	Dominican Republic	4069d8cd-edcb-46d5-95b0-57d4d5d7e72a
15	Hobart	Parker	\N	male	Bulgaria	169dcc58-9c4e-4504-ab8a-cbcac604614a
16	Reba	Smith	\N	female	Micronesia	d73097ff-6783-41a1-a47d-d62909e70c6e
17	Enrique	Schamberger	\N	female	Tunisia	04a0d2b3-f6f0-4262-acd1-32129bd38ad4
18	Brionna	Marks	\N	female	Sao Tome and Principe	60d7b2d1-8a45-43c6-baa3-3c9339d4eb09
19	Merritt	Nader	\N	male	Australia	0e5b24ea-2797-4a44-8ebb-1dd4739706cc
20	Julius	Boyer	\N	male	Chad	9a999534-9f07-4edd-bfab-d99d5e56d961
3	Jennie	Welch	\N	male	United States of America	5c60ac11-f8dd-44bf-8ad5-30f2d11290b0
10	Jack	Sparrow	\N	male	Saint Kitts and Nevis	3f15c9af-ebae-4b5c-99d3-747d4c27888e
23	Jack	Sparrow	\N	male	Monstadt	75e95ace-1f8e-4579-8273-41bae6d49195
26	Nguyen	Duong	\N	male	Ha Noi	42f14c9c-944a-4c08-82bd-bfc4df28ff17
29	Lawrence	Eula	\N	female	Monstadt	8b260762-9039-4ee0-b28e-052bd987ce85
22	Tran	Mai	2003-06-16	female	BacGiang,VietNam	7a6b21e6-1add-4514-988b-8ec62f765bc0
21	Nguyen	Duong	2003-09-27	male	VietNam	2eca0c07-0714-4fb2-b0d5-638679be3a70
\.


--
-- Data for Name: transaction_histories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transaction_histories (id, action, note, "timeAt", amount, account_number, "from", "billId") FROM stdin;
10	buy	\N	2024-04-15 05:38:38.463828	-100000	012572048761	012345678912	4
11	sell	\N	2024-04-15 05:38:38.463828	100000	012345678912	012572048761	4
28	buy	\N	2024-04-15 21:03:25.273282	-200000	012572048761	012345678912	13
29	sell	\N	2024-04-15 21:03:25.273282	200000	012345678912	012572048761	13
30	buy	\N	2024-04-15 21:03:54.106563	-200000	012572048761	012345678912	14
31	sell	\N	2024-04-15 21:03:54.106563	200000	012345678912	012572048761	14
32	buy	\N	2024-04-15 21:04:31.306518	-200000	012572048761	012345678912	15
33	sell	\N	2024-04-15 21:04:31.306518	200000	012345678912	012572048761	15
34	buy	\N	2024-04-15 21:04:34.024175	-200000	012572048761	012345678912	16
35	sell	\N	2024-04-15 21:04:34.024175	200000	012345678912	012572048761	16
36	buy	\N	2024-04-15 21:04:34.919787	-200000	012572048761	012345678912	17
37	sell	\N	2024-04-15 21:04:34.919787	200000	012345678912	012572048761	17
38	buy	\N	2024-04-15 21:04:35.686867	-200000	012572048761	012345678912	18
39	sell	\N	2024-04-15 21:04:35.686867	200000	012345678912	012572048761	18
40	buy	\N	2024-04-15 21:40:38.591659	-249865	012572048761	012345678912	19
41	sell	\N	2024-04-15 21:40:38.591659	249865	012345678912	012572048761	19
42	buy	\N	2024-04-15 21:41:36.718711	-249865	012572048761	012345678912	20
43	sell	\N	2024-04-15 21:41:36.718711	249865	012345678912	012572048761	20
44	buy	\N	2024-04-16 00:27:56.135132	-45000	012572048761	012345678912	21
45	sell	\N	2024-04-16 00:27:56.135132	45000	012345678912	012572048761	21
46	buy	\N	2024-04-16 00:28:05.196666	-135000	012572048761	012345678912	22
47	sell	\N	2024-04-16 00:28:05.196666	135000	012345678912	012572048761	22
48	buy	\N	2024-04-16 00:28:28.811859	-5600000	012572048761	012345678912	23
49	sell	\N	2024-04-16 00:28:28.811859	5600000	012345678912	012572048761	23
50	buy	Buy 1 "2024 Lamborghini Huracán" from 'DuongAuto' 	2024-04-16 01:07:35.428592	-200000	012572048761	012345678912	29
51	sell	Sell 1 "2024 Lamborghini Huracán" to 'user' 	2024-04-16 01:07:35.428592	200000	012345678912	012572048761	29
52	buy	\N	2024-04-16 01:17:05.488627	-5600000	024432910977	012345678912	30
53	sell	\N	2024-04-16 01:17:05.488627	5600000	012345678912	024432910977	30
54	buy	\N	2024-04-16 01:22:24.730203	-5600000	024432910977	012345678912	31
55	sell	\N	2024-04-16 01:22:24.730203	5600000	012345678912	024432910977	31
56	buy	Buy 1 "2024 Lamborghini Huracán" from 'DuongAuto' 	2024-04-16 01:27:07.926055	-5600000	012572048761	012345678912	32
57	sell	Sell 1 "2024 Lamborghini Huracán" to 'user' 	2024-04-16 01:27:07.926055	5600000	012345678912	012572048761	32
58	buy	Buy 1 "2024 Lamborghini Huracán" from 'DuongAuto' 	2024-04-16 01:29:03.470771	-5600000	012572048761	012345678912	33
59	sell	Sell 1 "2024 Lamborghini Huracán" to 'user' 	2024-04-16 01:29:03.470771	5600000	012345678912	012572048761	33
60	buy	Buy 1 "2014 Lamborghini Veneno" from 'DuongAuto' 	2024-04-16 01:32:02.88684	-5600000	012572048761	012345678912	34
61	sell	Sell 1 "2014 Lamborghini Veneno" to 'user' 	2024-04-16 01:32:02.88684	5600000	012345678912	012572048761	34
62	buy	Buy 1 "2023 Pagani Utopia" from 'DuongAuto' 	2024-04-16 21:56:16.754076	-2190000	012572048761	012345678912	35
63	sell	Sell 1 "2023 Pagani Utopia" to 'user' 	2024-04-16 21:56:16.754076	2190000	012345678912	012572048761	35
64	deposit	Deposit $1 to your account	2024-04-17 02:07:09.481997	1	012572048761	\N	\N
65	deposit	Deposit $1 to your account	2024-04-17 02:07:17.743315	1	012572048761	\N	\N
66	buy	Buy 4 "2018 BMW M6" from 'DuongAuto' 	2024-04-17 16:42:28.474789	-67644	012572048761	012345678912	36
67	sell	Sell 4 "2018 BMW M6" to 'user' 	2024-04-17 16:42:28.474789	67644	012345678912	012572048761	36
68	buy	Buy 4 "2018 BMW M6" from 'DuongAuto' 	2024-04-17 16:42:42.751716	-67644	012572048761	012345678912	37
69	sell	Sell 4 "2018 BMW M6" to 'user' 	2024-04-17 16:42:42.751716	67644	012345678912	012572048761	37
70	buy	Buy 3 "2023 Audi TT / TTS" from 'DuongAuto' 	2024-04-17 16:43:11.907723	-159885	012572048761	012345678912	38
71	sell	Sell 3 "2023 Audi TT / TTS" to 'user' 	2024-04-17 16:43:11.907723	159885	012345678912	012572048761	38
72	buy	Buy 3 "2025 Lexus UX" from 'DuongAuto' 	2024-04-17 16:43:31.859982	-112470	012572048761	012345678912	39
73	sell	Sell 3 "2025 Lexus UX" to 'user' 	2024-04-17 16:43:31.859982	112470	012345678912	012572048761	39
74	buy	Buy 4 "2020 Pagani Huayra" from 'DuongAuto' 	2024-04-17 16:43:53.411987	-13600000	012572048761	012345678912	40
75	sell	Sell 4 "2020 Pagani Huayra" to 'user' 	2024-04-17 16:43:53.411987	13600000	012345678912	012572048761	40
76	buy	Buy 5 "2015 Ferrari LaFerrari" from 'DuongAuto' 	2024-04-17 16:44:30.964158	-36162600	012572048761	012345678912	41
77	sell	Sell 5 "2015 Ferrari LaFerrari" to 'user' 	2024-04-17 16:44:30.964158	36162600	012345678912	012572048761	41
78	deposit	Deposit $1 to your account	2024-04-17 19:44:11.718234	10	012572048761	\N	\N
79	deposit	Deposit $1 to your account	2024-04-17 21:13:37.087351	41234	012572048761	\N	\N
80	deposit	Deposit $1 to your account	2024-04-17 21:13:37.187139	41234	012572048761	\N	\N
81	deposit	Deposit $1 to your account	2024-04-17 21:17:54.44927	53245	012572048761	\N	\N
82	deposit	Deposit $1 to your account	2024-04-17 21:56:36.343668	3432	012572048761	\N	\N
83	deposit	Deposit $1 to your account	2024-04-17 22:04:24.777857	3432	012572048761	\N	\N
84	deposit	Deposit $1 to your account	2024-04-17 22:05:49.285967	3432	012572048761	\N	\N
85	deposit	Deposit $1 to your account	2024-04-17 22:06:41.181811	41234	012572048761	\N	\N
86	deposit	Deposit $1 to your account	2024-04-17 22:07:52.564853	41234	012572048761	\N	\N
87	deposit	Deposit $1 to your account	2024-04-17 22:08:17.088057	41234	012572048761	\N	\N
88	deposit	Deposit $1 to your account	2024-04-17 22:08:35.402489	41234	012572048761	\N	\N
89	deposit	Deposit $1 to your account	2024-04-17 22:25:17.554697	5245	012572048761	\N	\N
90	deposit	Deposit $1 to your account	2024-04-17 22:28:49.923941	31	012572048761	\N	\N
91	deposit	Deposit $1 to your account	2024-04-17 22:29:03.341234	31	012572048761	\N	\N
92	deposit	Deposit $1 to your account	2024-04-17 22:29:33.093403	52345	012572048761	\N	\N
93	deposit	Deposit $1 to your account	2024-04-17 22:29:58.342874	52345	012572048761	\N	\N
94	deposit	Deposit $1 to your account	2024-04-17 22:31:08.84588	52345	012572048761	\N	\N
95	deposit	Deposit $1 to your account	2024-04-17 22:32:38.086588	52345	012572048761	\N	\N
96	deposit	Deposit $1 to your account	2024-04-17 22:32:55.376564	3	012572048761	\N	\N
97	deposit	Deposit $1 to your account	2024-04-17 22:35:21.073036	3	012572048761	\N	\N
98	deposit	Deposit $1 to your account	2024-04-17 22:42:14.243437	3	012572048761	\N	\N
99	deposit	Deposit $1 to your account	2024-04-17 22:42:32.054863	3	012572048761	\N	\N
100	deposit	Deposit $1 to your account	2024-04-17 22:43:52.279472	3	012572048761	\N	\N
101	deposit	Deposit $1 to your account	2024-04-17 22:44:14.503291	3	012572048761	\N	\N
102	deposit	Deposit $1 to your account	2024-04-17 22:44:50.71164	1	012572048761	\N	\N
103	deposit	Deposit $1 to your account	2024-04-17 22:45:13.335168	1	012572048761	\N	\N
104	deposit	Deposit $1 to your account	2024-04-17 22:45:30.902979	1	012572048761	\N	\N
105	deposit	Deposit $1 to your account	2024-04-17 22:45:37.522192	1	012572048761	\N	\N
106	deposit	Deposit $1 to your account	2024-04-17 22:45:38.429542	1	012572048761	\N	\N
107	deposit	Deposit $1 to your account	2024-04-17 22:45:39.149537	1	012572048761	\N	\N
108	deposit	Deposit $1 to your account	2024-04-17 22:45:39.734045	1	012572048761	\N	\N
109	deposit	Deposit $1 to your account	2024-04-17 22:45:40.141567	1	012572048761	\N	\N
110	deposit	Deposit $1 to your account	2024-04-17 22:45:40.588417	1	012572048761	\N	\N
111	deposit	Deposit $1 to your account	2024-04-17 22:45:40.748478	1	012572048761	\N	\N
112	deposit	Deposit $1 to your account	2024-04-17 22:45:42.790958	141234	012572048761	\N	\N
113	deposit	Deposit $1 to your account	2024-04-17 22:45:49.655307	4123423	012572048761	\N	\N
114	deposit	Deposit $1 to your account	2024-04-17 22:46:12.886634	10000	012572048761	\N	\N
115	deposit	Deposit $1 to your account	2024-04-17 22:46:15.509617	1000000	012572048761	\N	\N
116	deposit	Deposit $1 to your account	2024-04-17 22:46:16.967153	1000000	012572048761	\N	\N
117	deposit	Deposit $1 to your account	2024-04-17 22:46:17.275943	1000000	012572048761	\N	\N
118	deposit	Deposit $1 to your account	2024-04-17 22:46:17.660807	1000000	012572048761	\N	\N
119	deposit	Deposit $1 to your account	2024-04-17 22:46:17.828977	1000000	012572048761	\N	\N
120	deposit	Deposit $1 to your account	2024-04-17 22:46:17.988647	1000000	012572048761	\N	\N
121	deposit	Deposit $1 to your account	2024-04-17 22:46:18.148369	1000000	012572048761	\N	\N
122	deposit	Deposit $1 to your account	2024-04-17 22:46:18.324033	1000000	012572048761	\N	\N
123	deposit	Deposit $1 to your account	2024-04-17 22:46:18.492204	1000000	012572048761	\N	\N
124	deposit	Deposit $1 to your account	2024-04-17 22:46:27.98253	10000000	012572048761	\N	\N
125	deposit	Deposit $1 to your account	2024-04-17 22:46:28.452574	10000000	012572048761	\N	\N
126	deposit	Deposit $1 to your account	2024-04-17 22:46:28.660841	10000000	012572048761	\N	\N
127	deposit	Deposit $1 to your account	2024-04-17 22:46:28.92435	10000000	012572048761	\N	\N
128	deposit	Deposit $1 to your account	2024-04-17 22:46:29.164129	10000000	012572048761	\N	\N
129	deposit	Deposit $1 to your account	2024-04-17 22:46:29.356074	10000000	012572048761	\N	\N
130	deposit	Deposit $1 to your account	2024-04-17 22:46:29.764263	10000000	012572048761	\N	\N
131	deposit	Deposit $1 to your account	2024-04-17 22:46:29.947718	10000000	012572048761	\N	\N
132	deposit	Deposit $1 to your account	2024-04-17 22:46:30.123999	10000000	012572048761	\N	\N
133	deposit	Deposit $1 to your account	2024-04-17 22:46:30.34861	10000000	012572048761	\N	\N
134	deposit	Deposit $1 to your account	2024-04-17 22:46:30.557002	10000000	012572048761	\N	\N
135	deposit	Deposit $1 to your account	2024-04-17 22:46:30.747647	10000000	012572048761	\N	\N
136	deposit	Deposit $1 to your account	2024-04-17 22:46:30.932929	10000000	012572048761	\N	\N
137	deposit	Deposit $1 to your account	2024-04-17 22:46:31.141105	10000000	012572048761	\N	\N
138	deposit	Deposit $1 to your account	2024-04-17 22:46:31.579237	10000000	012572048761	\N	\N
139	deposit	Deposit $1 to your account	2024-04-18 02:50:38.702366	12	012572048761	\N	\N
140	deposit	Deposit $1 to your account	2024-04-18 02:51:14.705401	12	012572048761	\N	\N
141	deposit	Deposit $1 to your account	2024-04-18 02:51:20.345824	1	012572048761	\N	\N
142	deposit	Deposit $$1 to your account	2024-04-18 03:38:01.091815	12	012572048761	\N	\N
143	deposit	Deposit 12 to your account	2024-04-18 04:16:46.674894	12	012572048761	\N	\N
144	deposit	Deposit 12 to your account	2024-04-18 04:16:54.684422	12	012572048761	\N	\N
145	deposit	Deposit 5 to your account	2024-04-18 04:16:59.116231	5	012572048761	\N	\N
146	deposit	Deposit 20 to your account	2024-04-18 04:17:14.907265	20	012572048761	\N	\N
147	deposit	Deposit $40 to your account	2024-04-18 04:17:46.596089	40	012572048761	\N	\N
148	buy	Buy 3 "2024 Ferrari 812" from 'DuongAuto' 	2024-04-18 04:18:43.463025	-1301295	012572048761	012345678912	42
149	sell	Sell 3 "2024 Ferrari 812" to 'user' 	2024-04-18 04:18:43.463025	1301295	012345678912	012572048761	42
150	buy	Buy 1 "2024 Ferrari 812" from 'DuongAuto' 	2024-04-18 04:18:56.78162	-433765	012572048761	012345678912	43
151	sell	Sell 1 "2024 Ferrari 812" to 'user' 	2024-04-18 04:18:56.78162	433765	012345678912	012572048761	43
152	deposit	Deposit $12 to your account	2024-04-18 04:24:07.458463	12	012572048761	\N	\N
153	deposit	Deposit $22 to your account	2024-04-18 04:24:12.072602	22	012572048761	\N	\N
154	deposit	Deposit $1 to your account	2024-04-18 16:07:54.494037	1	012572048761	\N	\N
155	deposit	Deposit $10 to your account	2024-04-18 16:08:28.645936	10	012572048761	\N	\N
156	deposit	Deposit $10000000 to your account	2024-04-18 16:08:44.038014	10000000	012572048761	\N	\N
157	deposit	Deposit $120 to your account	2024-06-18 17:41:03.396377	120	024033762563	\N	\N
158	deposit	Deposit $5 to your account	2024-08-01 18:42:08.512002	5	012572048761	\N	\N
159	buy	Buy 10 "2024 VinFast VF9" from 'DuongAuto' 	2024-08-01 19:29:23.498	-810000	012572048761	012345678912	44
160	sell	Sell 10 "2024 VinFast VF9" to 'user' 	2024-08-01 19:29:23.498	810000	012345678912	012572048761	44
161	buy	Buy 8 "2024 Lexus IS" from 'DuongAuto' 	2024-08-01 19:30:22.644747	-329880	012572048761	012345678912	45
162	sell	Sell 8 "2024 Lexus IS" to 'user' 	2024-08-01 19:30:22.644747	329880	012345678912	012572048761	45
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, "isBanned", role, "createAt", "updateAt", email, password, username, phone_number) FROM stdin;
8a8499d5-dd1a-44f4-b6e3-b060d59e29c2	f	user	2024-03-20 19:33:40.968242	2024-03-20 19:33:40.968242	Lavon.Streich@gmail.com	Health	Sunny_McClure	\N
117b3c84-afd1-413f-9a5a-31d98e555832	f	user	2024-03-20 19:33:40.968242	2024-03-20 19:33:40.968242	Kattie_Waelchi@hotmail.com	World	Vladimir_Labadie	\N
5c60ac11-f8dd-44bf-8ad5-30f2d11290b0	f	user	2024-03-20 19:33:40.968242	2024-03-20 19:33:40.968242	Hayden.Murphy83@gmail.com	Lithuania	Robert75	\N
8319d411-d31d-46f0-af23-4acf2dfc7b97	f	user	2024-03-20 19:33:40.968242	2024-03-20 19:33:40.968242	Taurean.Marquardt@hotmail.com	Gender	Elfrieda.Roberts60	\N
2754613c-42f2-4cd7-94bd-2b095d268ec3	f	user	2024-03-20 19:33:40.968242	2024-03-20 19:33:40.968242	Cassie26@hotmail.com	Kip	Jed_Gleichner9	\N
7796e8d7-5708-4ed9-997b-b1f6f8e19655	f	user	2024-03-20 19:33:40.968242	2024-03-20 19:33:40.968242	Ayden_OConner@hotmail.com	tan	Kenya24	\N
eead8e1e-fa42-4134-9f2c-fd962eacee03	f	user	2024-03-20 19:33:40.968242	2024-03-20 19:33:40.968242	Grover2@hotmail.com	concerning	Kamron.Ryan78	\N
2803284a-d4ef-46d7-aeb8-399d78ac42b6	f	user	2024-03-20 19:33:40.968242	2024-03-20 19:33:40.968242	Edmund.Dickinson@hotmail.com	loosely	Elliott.Leuschke	\N
624cde74-ac92-48d7-a83c-d91f1ea9cec0	f	user	2024-03-20 19:33:40.968242	2024-03-20 19:33:40.968242	Julianne.Powlowski83@yahoo.com	protocol	Jerry_Goyette	\N
3f15c9af-ebae-4b5c-99d3-747d4c27888e	f	user	2024-03-20 19:33:40.968242	2024-03-20 19:33:40.968242	Reggie8@hotmail.com	snoopy	Vivienne_OReilly39	\N
dc5cd101-cb4e-46e0-ba34-aad8e33bbd0e	f	user	2024-03-20 19:33:40.968242	2024-03-20 19:33:40.968242	Filomena77@gmail.com	Brand	Jamey_Legros37	\N
8e403c42-1c46-44e7-a319-3a0909e1810f	f	user	2024-03-20 19:33:40.968242	2024-03-20 19:33:40.968242	Yasmeen_Gerhold@gmail.com	override	Hank_Beier34	\N
8dd7438b-573d-4fc5-bdb4-abb536eed8c3	f	user	2024-03-20 19:33:40.968242	2024-03-20 19:33:40.968242	Greta.Gottlieb@hotmail.com	Smart	Tre.Parker	\N
4069d8cd-edcb-46d5-95b0-57d4d5d7e72a	f	user	2024-03-20 19:33:40.968242	2024-03-20 19:33:40.968242	Ebba.Swaniawski84@hotmail.com	indexing	Stanton77	\N
169dcc58-9c4e-4504-ab8a-cbcac604614a	f	user	2024-03-20 19:33:40.968242	2024-03-20 19:33:40.968242	Isaac.Simonis@gmail.com	Synergistic	Dorian.Breitenberg	\N
d73097ff-6783-41a1-a47d-d62909e70c6e	f	user	2024-03-20 19:33:40.968242	2024-03-20 19:33:40.968242	Duncan_Hand35@hotmail.com	Polarised	Rosie62	\N
04a0d2b3-f6f0-4262-acd1-32129bd38ad4	f	user	2024-03-20 19:33:40.968242	2024-03-20 19:33:40.968242	Marques70@hotmail.com	circuit	Rogers_Thiel42	\N
60d7b2d1-8a45-43c6-baa3-3c9339d4eb09	f	user	2024-03-20 19:33:40.968242	2024-03-20 19:33:40.968242	Jeanette53@hotmail.com	synergize	Ethan.McLaughlin	\N
0e5b24ea-2797-4a44-8ebb-1dd4739706cc	f	user	2024-03-20 19:33:40.968242	2024-03-20 19:33:40.968242	Wilford4@yahoo.com	Northwest	Thurman_Bergstrom7	\N
9a999534-9f07-4edd-bfab-d99d5e56d961	f	user	2024-03-20 19:33:40.968242	2024-03-20 19:33:40.968242	Katrina_Morissette@yahoo.com	Smart	Sharon76	\N
7a6b21e6-1add-4514-988b-8ec62f765bc0	f	user	2024-03-20 20:16:33.415725	2024-03-20 20:16:33.415725	user@gmail.com	123456	user	\N
42f14c9c-944a-4c08-82bd-bfc4df28ff17	f	user	2024-03-25 17:00:17.087531	2024-03-25 17:00:17.087531	duongnt@duongauto.com	123456	DuongAuto	\N
75e95ace-1f8e-4579-8273-41bae6d49195	f	user	2024-03-28 16:38:44.161025	2024-03-28 16:38:44.161025	Diluc@gmail.com	123456	Diluc	\N
8b260762-9039-4ee0-b28e-052bd987ce85	f	user	2024-03-31 14:37:12.792788	2024-03-31 14:37:12.792788	eula@gmail.com	123456	Eula	\N
2eca0c07-0714-4fb2-b0d5-638679be3a70	f	admin	2024-03-20 20:16:33.415725	2024-03-20 20:16:33.415725	admin@gmail.com	123456	admin1	\N
\.


--
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_id_seq', 11, true);


--
-- Name: bills_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bills_id_seq', 45, true);


--
-- Name: brands_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.brands_id_seq', 109, true);


--
-- Name: car_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.car_types_id_seq', 12, true);


--
-- Name: carts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carts_id_seq', 64, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 719, true);


--
-- Name: profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.profiles_id_seq', 48, true);


--
-- Name: transaction_histories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transaction_histories_id_seq', 162, true);


--
-- Name: products PK_0806c755e0aca124e67c0cf6d7d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT "PK_0806c755e0aca124e67c0cf6d7d" PRIMARY KEY (id);


--
-- Name: transaction_histories PK_20a6530a95a39f16f2fc90efdfc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_histories
    ADD CONSTRAINT "PK_20a6530a95a39f16f2fc90efdfc" PRIMARY KEY (id);


--
-- Name: car_types PK_4cf27897f7f3a780e07b83e2706; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car_types
    ADD CONSTRAINT "PK_4cf27897f7f3a780e07b83e2706" PRIMARY KEY (id);


--
-- Name: accounts PK_5a7a02c20412299d198e097a8fe; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT "PK_5a7a02c20412299d198e097a8fe" PRIMARY KEY (id);


--
-- Name: profiles PK_8e520eb4da7dc01d0e190447c8e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT "PK_8e520eb4da7dc01d0e190447c8e" PRIMARY KEY (id);


--
-- Name: users PK_a3ffb1c0c8416b9fc6f907b7433; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "PK_a3ffb1c0c8416b9fc6f907b7433" PRIMARY KEY (id);


--
-- Name: bills PK_a56215dfcb525755ec832cc80b7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bills
    ADD CONSTRAINT "PK_a56215dfcb525755ec832cc80b7" PRIMARY KEY (id);


--
-- Name: brands PK_b0c437120b624da1034a81fc561; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT "PK_b0c437120b624da1034a81fc561" PRIMARY KEY (id);


--
-- Name: carts PK_b5f695a59f5ebb50af3c8160816; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT "PK_b5f695a59f5ebb50af3c8160816" PRIMARY KEY (id);


--
-- Name: profiles REL_315ecd98bd1a42dcf2ec4e2e98; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT "REL_315ecd98bd1a42dcf2ec4e2e98" UNIQUE ("userId");


--
-- Name: accounts REL_3aa23c0a6d107393e8b40e3e2a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT "REL_3aa23c0a6d107393e8b40e3e2a" UNIQUE ("userId");


--
-- Name: car_types UQ_921d6253a98ecfc574485ecb3db; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.car_types
    ADD CONSTRAINT "UQ_921d6253a98ecfc574485ecb3db" UNIQUE (name);


--
-- Name: brands UQ_96db6bbbaa6f23cad26871339b6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT "UQ_96db6bbbaa6f23cad26871339b6" UNIQUE (name);


--
-- Name: users UQ_97672ac88f789774dd47f7c8be3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "UQ_97672ac88f789774dd47f7c8be3" UNIQUE (email);


--
-- Name: carts UQ_c3421549445302391be9ca7ed84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT "UQ_c3421549445302391be9ca7ed84" UNIQUE ("userId", "productId");


--
-- Name: users UQ_fe0bb3f6520ee0469504521e710; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "UQ_fe0bb3f6520ee0469504521e710" UNIQUE (username);


--
-- Name: accounts UQ_ffd1ae96513bfb2c6eada0f7d31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT "UQ_ffd1ae96513bfb2c6eada0f7d31" UNIQUE (account_number);


--
-- Name: transaction_histories FK_12662ad63435f3be9670f4f613f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_histories
    ADD CONSTRAINT "FK_12662ad63435f3be9670f4f613f" FOREIGN KEY (account_number) REFERENCES public.accounts(account_number) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: transaction_histories FK_2293ec5bdb6ed4c66c8107e454a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_histories
    ADD CONSTRAINT "FK_2293ec5bdb6ed4c66c8107e454a" FOREIGN KEY ("from") REFERENCES public.accounts(account_number) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: profiles FK_315ecd98bd1a42dcf2ec4e2e985; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT "FK_315ecd98bd1a42dcf2ec4e2e985" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: accounts FK_3aa23c0a6d107393e8b40e3e2a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT "FK_3aa23c0a6d107393e8b40e3e2a6" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: carts FK_69828a178f152f157dcf2f70a89; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT "FK_69828a178f152f157dcf2f70a89" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: brands FK_7a129ae1a9d3db7cf42291f0bf0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT "FK_7a129ae1a9d3db7cf42291f0bf0" FOREIGN KEY ("typeId") REFERENCES public.car_types(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: products FK_99d90c2a483d79f3b627fb1d5e9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT "FK_99d90c2a483d79f3b627fb1d5e9" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: carts FK_9c77aaa5bc26f66159661ffd808; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT "FK_9c77aaa5bc26f66159661ffd808" FOREIGN KEY ("productId") REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: bills FK_b1d3336be990ea8b4cf37a928a7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bills
    ADD CONSTRAINT "FK_b1d3336be990ea8b4cf37a928a7" FOREIGN KEY (account_number) REFERENCES public.accounts(account_number) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: bills FK_dbb9d75cb5ea386e5efa122ea43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bills
    ADD CONSTRAINT "FK_dbb9d75cb5ea386e5efa122ea43" FOREIGN KEY ("productId") REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: transaction_histories FK_e92be11eeddb8b4d7c5a5163284; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_histories
    ADD CONSTRAINT "FK_e92be11eeddb8b4d7c5a5163284" FOREIGN KEY ("billId") REFERENCES public.bills(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: products FK_ea86d0c514c4ecbb5694cbf57df; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT "FK_ea86d0c514c4ecbb5694cbf57df" FOREIGN KEY ("brandId") REFERENCES public.brands(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

