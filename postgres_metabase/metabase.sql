--
-- PostgreSQL database dump
--

-- Dumped from database version 10.0
-- Dumped by pg_dump version 10.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: activity; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE activity (
    id integer NOT NULL,
    topic character varying(32) NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    user_id integer,
    model character varying(16),
    model_id integer,
    database_id integer,
    table_id integer,
    custom_id character varying(48),
    details character varying NOT NULL
);


ALTER TABLE activity OWNER TO quero_cultura;

--
-- Name: activity_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE activity_id_seq OWNER TO quero_cultura;

--
-- Name: activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE activity_id_seq OWNED BY activity.id;


--
-- Name: card_label; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE card_label (
    id integer NOT NULL,
    card_id integer NOT NULL,
    label_id integer NOT NULL
);


ALTER TABLE card_label OWNER TO quero_cultura;

--
-- Name: card_label_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE card_label_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE card_label_id_seq OWNER TO quero_cultura;

--
-- Name: card_label_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE card_label_id_seq OWNED BY card_label.id;


--
-- Name: collection; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE collection (
    id integer NOT NULL,
    name text NOT NULL,
    slug character varying(254) NOT NULL,
    description text,
    color character(7) NOT NULL,
    archived boolean DEFAULT false NOT NULL
);


ALTER TABLE collection OWNER TO quero_cultura;

--
-- Name: TABLE collection; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON TABLE collection IS 'Collections are an optional way to organize Cards and handle permissions for them.';


--
-- Name: COLUMN collection.name; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN collection.name IS 'The unique, user-facing name of this Collection.';


--
-- Name: COLUMN collection.slug; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN collection.slug IS 'URL-friendly, sluggified, indexed version of name.';


--
-- Name: COLUMN collection.description; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN collection.description IS 'Optional description for this Collection.';


--
-- Name: COLUMN collection.color; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN collection.color IS 'Seven-character hex color for this Collection, including the preceding hash sign.';


--
-- Name: COLUMN collection.archived; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN collection.archived IS 'Whether this Collection has been archived and should be hidden from users.';


--
-- Name: collection_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE collection_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE collection_id_seq OWNER TO quero_cultura;

--
-- Name: collection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE collection_id_seq OWNED BY collection.id;


--
-- Name: collection_revision; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE collection_revision (
    id integer NOT NULL,
    before text NOT NULL,
    after text NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    remark text
);


ALTER TABLE collection_revision OWNER TO quero_cultura;

--
-- Name: TABLE collection_revision; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON TABLE collection_revision IS 'Used to keep track of changes made to collections.';


--
-- Name: COLUMN collection_revision.before; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN collection_revision.before IS 'Serialized JSON of the collections graph before the changes.';


--
-- Name: COLUMN collection_revision.after; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN collection_revision.after IS 'Serialized JSON of the collections graph after the changes.';


--
-- Name: COLUMN collection_revision.user_id; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN collection_revision.user_id IS 'The ID of the admin who made this set of changes.';


--
-- Name: COLUMN collection_revision.created_at; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN collection_revision.created_at IS 'The timestamp of when these changes were made.';


--
-- Name: COLUMN collection_revision.remark; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN collection_revision.remark IS 'Optional remarks explaining why these changes were made.';


--
-- Name: collection_revision_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE collection_revision_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE collection_revision_id_seq OWNER TO quero_cultura;

--
-- Name: collection_revision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE collection_revision_id_seq OWNED BY collection_revision.id;


--
-- Name: core_session; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE core_session (
    id character varying(254) NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE core_session OWNER TO quero_cultura;

--
-- Name: core_user; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE core_user (
    id integer NOT NULL,
    email character varying(254) NOT NULL,
    first_name character varying(254) NOT NULL,
    last_name character varying(254) NOT NULL,
    password character varying(254) NOT NULL,
    password_salt character varying(254) DEFAULT 'default'::character varying NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    is_active boolean NOT NULL,
    reset_token character varying(254),
    reset_triggered bigint,
    is_qbnewb boolean DEFAULT true NOT NULL,
    google_auth boolean DEFAULT false NOT NULL,
    ldap_auth boolean DEFAULT false NOT NULL
);


ALTER TABLE core_user OWNER TO quero_cultura;

--
-- Name: core_user_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE core_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE core_user_id_seq OWNER TO quero_cultura;

--
-- Name: core_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE core_user_id_seq OWNED BY core_user.id;


--
-- Name: dashboard_favorite; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE dashboard_favorite (
    id integer NOT NULL,
    user_id integer NOT NULL,
    dashboard_id integer NOT NULL
);


ALTER TABLE dashboard_favorite OWNER TO quero_cultura;

--
-- Name: TABLE dashboard_favorite; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON TABLE dashboard_favorite IS 'Presence of a row here indicates a given User has favorited a given Dashboard.';


--
-- Name: COLUMN dashboard_favorite.user_id; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN dashboard_favorite.user_id IS 'ID of the User who favorited the Dashboard.';


--
-- Name: COLUMN dashboard_favorite.dashboard_id; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN dashboard_favorite.dashboard_id IS 'ID of the Dashboard favorited by the User.';


--
-- Name: dashboard_favorite_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE dashboard_favorite_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dashboard_favorite_id_seq OWNER TO quero_cultura;

--
-- Name: dashboard_favorite_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE dashboard_favorite_id_seq OWNED BY dashboard_favorite.id;


--
-- Name: dashboardcard_series; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE dashboardcard_series (
    id integer NOT NULL,
    dashboardcard_id integer NOT NULL,
    card_id integer NOT NULL,
    "position" integer NOT NULL
);


ALTER TABLE dashboardcard_series OWNER TO quero_cultura;

--
-- Name: dashboardcard_series_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE dashboardcard_series_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dashboardcard_series_id_seq OWNER TO quero_cultura;

--
-- Name: dashboardcard_series_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE dashboardcard_series_id_seq OWNED BY dashboardcard_series.id;


--
-- Name: data_migrations; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE data_migrations (
    id character varying(254) NOT NULL,
    "timestamp" timestamp without time zone NOT NULL
);


ALTER TABLE data_migrations OWNER TO quero_cultura;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE databasechangelog OWNER TO quero_cultura;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE databasechangeloglock OWNER TO quero_cultura;

--
-- Name: dependency; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE dependency (
    id integer NOT NULL,
    model character varying(32) NOT NULL,
    model_id integer NOT NULL,
    dependent_on_model character varying(32) NOT NULL,
    dependent_on_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE dependency OWNER TO quero_cultura;

--
-- Name: dependency_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE dependency_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dependency_id_seq OWNER TO quero_cultura;

--
-- Name: dependency_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE dependency_id_seq OWNED BY dependency.id;


--
-- Name: dimension; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE dimension (
    id integer NOT NULL,
    field_id integer NOT NULL,
    name character varying(254) NOT NULL,
    type character varying(254) NOT NULL,
    human_readable_field_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE dimension OWNER TO quero_cultura;

--
-- Name: TABLE dimension; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON TABLE dimension IS 'Stores references to alternate views of existing fields, such as remapping an integer to a description, like an enum';


--
-- Name: COLUMN dimension.field_id; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN dimension.field_id IS 'ID of the field this dimension row applies to';


--
-- Name: COLUMN dimension.name; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN dimension.name IS 'Short description used as the display name of this new column';


--
-- Name: COLUMN dimension.type; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN dimension.type IS 'Either internal for a user defined remapping or external for a foreign key based remapping';


--
-- Name: COLUMN dimension.human_readable_field_id; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN dimension.human_readable_field_id IS 'Only used with external type remappings. Indicates which field on the FK related table to use for display';


--
-- Name: COLUMN dimension.created_at; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN dimension.created_at IS 'The timestamp of when the dimension was created.';


--
-- Name: COLUMN dimension.updated_at; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN dimension.updated_at IS 'The timestamp of when these dimension was last updated.';


--
-- Name: dimension_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE dimension_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dimension_id_seq OWNER TO quero_cultura;

--
-- Name: dimension_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE dimension_id_seq OWNED BY dimension.id;


--
-- Name: label; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE label (
    id integer NOT NULL,
    name character varying(254) NOT NULL,
    slug character varying(254) NOT NULL,
    icon character varying(128)
);


ALTER TABLE label OWNER TO quero_cultura;

--
-- Name: label_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE label_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE label_id_seq OWNER TO quero_cultura;

--
-- Name: label_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE label_id_seq OWNED BY label.id;


--
-- Name: metabase_database; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE metabase_database (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(254) NOT NULL,
    description text,
    details text,
    engine character varying(254) NOT NULL,
    is_sample boolean DEFAULT false NOT NULL,
    is_full_sync boolean DEFAULT true NOT NULL,
    points_of_interest text,
    caveats text,
    metadata_sync_schedule character varying(254) DEFAULT '0 50 * * * ? *'::character varying NOT NULL,
    cache_field_values_schedule character varying(254) DEFAULT '0 50 0 * * ? *'::character varying NOT NULL,
    timezone character varying(254),
    is_on_demand boolean DEFAULT false NOT NULL
);


ALTER TABLE metabase_database OWNER TO quero_cultura;

--
-- Name: COLUMN metabase_database.metadata_sync_schedule; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN metabase_database.metadata_sync_schedule IS 'The cron schedule string for when this database should undergo the metadata sync process (and analysis for new fields).';


--
-- Name: COLUMN metabase_database.cache_field_values_schedule; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN metabase_database.cache_field_values_schedule IS 'The cron schedule string for when FieldValues for eligible Fields should be updated.';


--
-- Name: COLUMN metabase_database.timezone; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN metabase_database.timezone IS 'Timezone identifier for the database, set by the sync process';


--
-- Name: COLUMN metabase_database.is_on_demand; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN metabase_database.is_on_demand IS 'Whether we should do On-Demand caching of FieldValues for this DB. This means FieldValues are updated when their Field is used in a Dashboard or Card param.';


--
-- Name: metabase_database_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE metabase_database_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE metabase_database_id_seq OWNER TO quero_cultura;

--
-- Name: metabase_database_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE metabase_database_id_seq OWNED BY metabase_database.id;


--
-- Name: metabase_field; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE metabase_field (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(254) NOT NULL,
    base_type character varying(255) NOT NULL,
    special_type character varying(255),
    active boolean DEFAULT true NOT NULL,
    description text,
    preview_display boolean DEFAULT true NOT NULL,
    "position" integer DEFAULT 0 NOT NULL,
    table_id integer NOT NULL,
    parent_id integer,
    display_name character varying(254),
    visibility_type character varying(32) DEFAULT 'normal'::character varying NOT NULL,
    fk_target_field_id integer,
    raw_column_id integer,
    last_analyzed timestamp with time zone,
    points_of_interest text,
    caveats text,
    fingerprint text,
    fingerprint_version integer DEFAULT 0 NOT NULL
);


ALTER TABLE metabase_field OWNER TO quero_cultura;

--
-- Name: COLUMN metabase_field.fingerprint; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN metabase_field.fingerprint IS 'Serialized JSON containing non-identifying information about this Field, such as min, max, and percent JSON. Used for classification.';


--
-- Name: COLUMN metabase_field.fingerprint_version; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN metabase_field.fingerprint_version IS 'The version of the fingerprint for this Field. Used so we can keep track of which Fields need to be analyzed again when new things are added to fingerprints.';


--
-- Name: metabase_field_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE metabase_field_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE metabase_field_id_seq OWNER TO quero_cultura;

--
-- Name: metabase_field_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE metabase_field_id_seq OWNED BY metabase_field.id;


--
-- Name: metabase_fieldvalues; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE metabase_fieldvalues (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    "values" text,
    human_readable_values text,
    field_id integer NOT NULL
);


ALTER TABLE metabase_fieldvalues OWNER TO quero_cultura;

--
-- Name: metabase_fieldvalues_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE metabase_fieldvalues_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE metabase_fieldvalues_id_seq OWNER TO quero_cultura;

--
-- Name: metabase_fieldvalues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE metabase_fieldvalues_id_seq OWNED BY metabase_fieldvalues.id;


--
-- Name: metabase_table; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE metabase_table (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(254) NOT NULL,
    rows bigint,
    description text,
    entity_name character varying(254),
    entity_type character varying(254),
    active boolean NOT NULL,
    db_id integer NOT NULL,
    display_name character varying(254),
    visibility_type character varying(254),
    schema character varying(254),
    raw_table_id integer,
    points_of_interest text,
    caveats text,
    show_in_getting_started boolean DEFAULT false NOT NULL
);


ALTER TABLE metabase_table OWNER TO quero_cultura;

--
-- Name: metabase_table_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE metabase_table_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE metabase_table_id_seq OWNER TO quero_cultura;

--
-- Name: metabase_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE metabase_table_id_seq OWNED BY metabase_table.id;


--
-- Name: metric; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE metric (
    id integer NOT NULL,
    table_id integer NOT NULL,
    creator_id integer NOT NULL,
    name character varying(254) NOT NULL,
    description text,
    is_active boolean DEFAULT true NOT NULL,
    definition text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    points_of_interest text,
    caveats text,
    how_is_this_calculated text,
    show_in_getting_started boolean DEFAULT false NOT NULL
);


ALTER TABLE metric OWNER TO quero_cultura;

--
-- Name: metric_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE metric_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE metric_id_seq OWNER TO quero_cultura;

--
-- Name: metric_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE metric_id_seq OWNED BY metric.id;


--
-- Name: metric_important_field; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE metric_important_field (
    id integer NOT NULL,
    metric_id integer NOT NULL,
    field_id integer NOT NULL
);


ALTER TABLE metric_important_field OWNER TO quero_cultura;

--
-- Name: metric_important_field_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE metric_important_field_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE metric_important_field_id_seq OWNER TO quero_cultura;

--
-- Name: metric_important_field_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE metric_important_field_id_seq OWNED BY metric_important_field.id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE permissions (
    id integer NOT NULL,
    object character varying(254) NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE permissions OWNER TO quero_cultura;

--
-- Name: permissions_group; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE permissions_group (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE permissions_group OWNER TO quero_cultura;

--
-- Name: permissions_group_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE permissions_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE permissions_group_id_seq OWNER TO quero_cultura;

--
-- Name: permissions_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE permissions_group_id_seq OWNED BY permissions_group.id;


--
-- Name: permissions_group_membership; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE permissions_group_membership (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE permissions_group_membership OWNER TO quero_cultura;

--
-- Name: permissions_group_membership_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE permissions_group_membership_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE permissions_group_membership_id_seq OWNER TO quero_cultura;

--
-- Name: permissions_group_membership_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE permissions_group_membership_id_seq OWNED BY permissions_group_membership.id;


--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE permissions_id_seq OWNER TO quero_cultura;

--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE permissions_id_seq OWNED BY permissions.id;


--
-- Name: permissions_revision; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE permissions_revision (
    id integer NOT NULL,
    before text NOT NULL,
    after text NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    remark text
);


ALTER TABLE permissions_revision OWNER TO quero_cultura;

--
-- Name: TABLE permissions_revision; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON TABLE permissions_revision IS 'Used to keep track of changes made to permissions.';


--
-- Name: COLUMN permissions_revision.before; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN permissions_revision.before IS 'Serialized JSON of the permissions before the changes.';


--
-- Name: COLUMN permissions_revision.after; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN permissions_revision.after IS 'Serialized JSON of the permissions after the changes.';


--
-- Name: COLUMN permissions_revision.user_id; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN permissions_revision.user_id IS 'The ID of the admin who made this set of changes.';


--
-- Name: COLUMN permissions_revision.created_at; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN permissions_revision.created_at IS 'The timestamp of when these changes were made.';


--
-- Name: COLUMN permissions_revision.remark; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN permissions_revision.remark IS 'Optional remarks explaining why these changes were made.';


--
-- Name: permissions_revision_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE permissions_revision_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE permissions_revision_id_seq OWNER TO quero_cultura;

--
-- Name: permissions_revision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE permissions_revision_id_seq OWNED BY permissions_revision.id;


--
-- Name: pulse; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE pulse (
    id integer NOT NULL,
    creator_id integer NOT NULL,
    name character varying(254) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    skip_if_empty boolean DEFAULT false NOT NULL
);


ALTER TABLE pulse OWNER TO quero_cultura;

--
-- Name: COLUMN pulse.skip_if_empty; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN pulse.skip_if_empty IS 'Skip a scheduled Pulse if none of its questions have any results';


--
-- Name: pulse_card; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE pulse_card (
    id integer NOT NULL,
    pulse_id integer NOT NULL,
    card_id integer NOT NULL,
    "position" integer NOT NULL
);


ALTER TABLE pulse_card OWNER TO quero_cultura;

--
-- Name: pulse_card_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE pulse_card_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pulse_card_id_seq OWNER TO quero_cultura;

--
-- Name: pulse_card_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE pulse_card_id_seq OWNED BY pulse_card.id;


--
-- Name: pulse_channel; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE pulse_channel (
    id integer NOT NULL,
    pulse_id integer NOT NULL,
    channel_type character varying(32) NOT NULL,
    details text NOT NULL,
    schedule_type character varying(32) NOT NULL,
    schedule_hour integer,
    schedule_day character varying(64),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    schedule_frame character varying(32),
    enabled boolean DEFAULT true NOT NULL
);


ALTER TABLE pulse_channel OWNER TO quero_cultura;

--
-- Name: pulse_channel_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE pulse_channel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pulse_channel_id_seq OWNER TO quero_cultura;

--
-- Name: pulse_channel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE pulse_channel_id_seq OWNED BY pulse_channel.id;


--
-- Name: pulse_channel_recipient; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE pulse_channel_recipient (
    id integer NOT NULL,
    pulse_channel_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE pulse_channel_recipient OWNER TO quero_cultura;

--
-- Name: pulse_channel_recipient_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE pulse_channel_recipient_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pulse_channel_recipient_id_seq OWNER TO quero_cultura;

--
-- Name: pulse_channel_recipient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE pulse_channel_recipient_id_seq OWNED BY pulse_channel_recipient.id;


--
-- Name: pulse_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE pulse_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pulse_id_seq OWNER TO quero_cultura;

--
-- Name: pulse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE pulse_id_seq OWNED BY pulse.id;


--
-- Name: query; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE query (
    query_hash bytea NOT NULL,
    average_execution_time integer NOT NULL
);


ALTER TABLE query OWNER TO quero_cultura;

--
-- Name: TABLE query; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON TABLE query IS 'Information (such as average execution time) for different queries that have been previously ran.';


--
-- Name: COLUMN query.query_hash; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN query.query_hash IS 'The hash of the query dictionary. (This is a 256-bit SHA3 hash of the query dict.)';


--
-- Name: COLUMN query.average_execution_time; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN query.average_execution_time IS 'Average execution time for the query, round to nearest number of milliseconds. This is updated as a rolling average.';


--
-- Name: query_cache; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE query_cache (
    query_hash bytea NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    results bytea NOT NULL
);


ALTER TABLE query_cache OWNER TO quero_cultura;

--
-- Name: TABLE query_cache; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON TABLE query_cache IS 'Cached results of queries are stored here when using the DB-based query cache.';


--
-- Name: COLUMN query_cache.query_hash; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN query_cache.query_hash IS 'The hash of the query dictionary. (This is a 256-bit SHA3 hash of the query dict).';


--
-- Name: COLUMN query_cache.updated_at; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN query_cache.updated_at IS 'The timestamp of when these query results were last refreshed.';


--
-- Name: COLUMN query_cache.results; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN query_cache.results IS 'Cached, compressed results of running the query with the given hash.';


--
-- Name: query_execution; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE query_execution (
    id integer NOT NULL,
    hash bytea NOT NULL,
    started_at timestamp without time zone NOT NULL,
    running_time integer NOT NULL,
    result_rows integer NOT NULL,
    native boolean NOT NULL,
    context character varying(32),
    error text,
    executor_id integer,
    card_id integer,
    dashboard_id integer,
    pulse_id integer
);


ALTER TABLE query_execution OWNER TO quero_cultura;

--
-- Name: TABLE query_execution; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON TABLE query_execution IS 'A log of executed queries, used for calculating historic execution times, auditing, and other purposes.';


--
-- Name: COLUMN query_execution.hash; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN query_execution.hash IS 'The hash of the query dictionary. This is a 256-bit SHA3 hash of the query.';


--
-- Name: COLUMN query_execution.started_at; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN query_execution.started_at IS 'Timestamp of when this query started running.';


--
-- Name: COLUMN query_execution.running_time; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN query_execution.running_time IS 'The time, in milliseconds, this query took to complete.';


--
-- Name: COLUMN query_execution.result_rows; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN query_execution.result_rows IS 'Number of rows in the query results.';


--
-- Name: COLUMN query_execution.native; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN query_execution.native IS 'Whether the query was a native query, as opposed to an MBQL one (e.g., created with the GUI).';


--
-- Name: COLUMN query_execution.context; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN query_execution.context IS 'Short string specifying how this query was executed, e.g. in a Dashboard or Pulse.';


--
-- Name: COLUMN query_execution.error; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN query_execution.error IS 'Error message returned by failed query, if any.';


--
-- Name: COLUMN query_execution.executor_id; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN query_execution.executor_id IS 'The ID of the User who triggered this query execution, if any.';


--
-- Name: COLUMN query_execution.card_id; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN query_execution.card_id IS 'The ID of the Card (Question) associated with this query execution, if any.';


--
-- Name: COLUMN query_execution.dashboard_id; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN query_execution.dashboard_id IS 'The ID of the Dashboard associated with this query execution, if any.';


--
-- Name: COLUMN query_execution.pulse_id; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN query_execution.pulse_id IS 'The ID of the Pulse associated with this query execution, if any.';


--
-- Name: query_execution_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE query_execution_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE query_execution_id_seq OWNER TO quero_cultura;

--
-- Name: query_execution_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE query_execution_id_seq OWNED BY query_execution.id;


--
-- Name: raw_column; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE raw_column (
    id integer NOT NULL,
    raw_table_id integer NOT NULL,
    active boolean NOT NULL,
    name character varying(255) NOT NULL,
    column_type character varying(128),
    is_pk boolean NOT NULL,
    fk_target_column_id integer,
    details text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE raw_column OWNER TO quero_cultura;

--
-- Name: raw_column_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE raw_column_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE raw_column_id_seq OWNER TO quero_cultura;

--
-- Name: raw_column_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE raw_column_id_seq OWNED BY raw_column.id;


--
-- Name: raw_table; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE raw_table (
    id integer NOT NULL,
    database_id integer NOT NULL,
    active boolean NOT NULL,
    schema character varying(255),
    name character varying(255) NOT NULL,
    details text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE raw_table OWNER TO quero_cultura;

--
-- Name: raw_table_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE raw_table_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE raw_table_id_seq OWNER TO quero_cultura;

--
-- Name: raw_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE raw_table_id_seq OWNED BY raw_table.id;


--
-- Name: report_card; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE report_card (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(254) NOT NULL,
    description text,
    display character varying(254) NOT NULL,
    dataset_query text NOT NULL,
    visualization_settings text NOT NULL,
    creator_id integer NOT NULL,
    database_id integer,
    table_id integer,
    query_type character varying(16),
    archived boolean DEFAULT false NOT NULL,
    collection_id integer,
    public_uuid character(36),
    made_public_by_id integer,
    enable_embedding boolean DEFAULT false NOT NULL,
    embedding_params text,
    cache_ttl integer,
    result_metadata text
);


ALTER TABLE report_card OWNER TO quero_cultura;

--
-- Name: COLUMN report_card.collection_id; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN report_card.collection_id IS 'Optional ID of Collection this Card belongs to.';


--
-- Name: COLUMN report_card.public_uuid; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN report_card.public_uuid IS 'Unique UUID used to in publically-accessible links to this Card.';


--
-- Name: COLUMN report_card.made_public_by_id; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN report_card.made_public_by_id IS 'The ID of the User who first publically shared this Card.';


--
-- Name: COLUMN report_card.enable_embedding; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN report_card.enable_embedding IS 'Is this Card allowed to be embedded in different websites (using a signed JWT)?';


--
-- Name: COLUMN report_card.embedding_params; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN report_card.embedding_params IS 'Serialized JSON containing information about required parameters that must be supplied when embedding this Card.';


--
-- Name: COLUMN report_card.cache_ttl; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN report_card.cache_ttl IS 'The maximum time, in seconds, to return cached results for this Card rather than running a new query.';


--
-- Name: COLUMN report_card.result_metadata; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN report_card.result_metadata IS 'Serialized JSON containing metadata about the result columns from running the query.';


--
-- Name: report_card_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE report_card_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE report_card_id_seq OWNER TO quero_cultura;

--
-- Name: report_card_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE report_card_id_seq OWNED BY report_card.id;


--
-- Name: report_cardfavorite; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE report_cardfavorite (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    card_id integer NOT NULL,
    owner_id integer NOT NULL
);


ALTER TABLE report_cardfavorite OWNER TO quero_cultura;

--
-- Name: report_cardfavorite_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE report_cardfavorite_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE report_cardfavorite_id_seq OWNER TO quero_cultura;

--
-- Name: report_cardfavorite_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE report_cardfavorite_id_seq OWNED BY report_cardfavorite.id;


--
-- Name: report_dashboard; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE report_dashboard (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(254) NOT NULL,
    description text,
    creator_id integer NOT NULL,
    parameters text NOT NULL,
    points_of_interest text,
    caveats text,
    show_in_getting_started boolean DEFAULT false NOT NULL,
    public_uuid character(36),
    made_public_by_id integer,
    enable_embedding boolean DEFAULT false NOT NULL,
    embedding_params text,
    archived boolean DEFAULT false NOT NULL,
    "position" integer
);


ALTER TABLE report_dashboard OWNER TO quero_cultura;

--
-- Name: COLUMN report_dashboard.public_uuid; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN report_dashboard.public_uuid IS 'Unique UUID used to in publically-accessible links to this Dashboard.';


--
-- Name: COLUMN report_dashboard.made_public_by_id; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN report_dashboard.made_public_by_id IS 'The ID of the User who first publically shared this Dashboard.';


--
-- Name: COLUMN report_dashboard.enable_embedding; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN report_dashboard.enable_embedding IS 'Is this Dashboard allowed to be embedded in different websites (using a signed JWT)?';


--
-- Name: COLUMN report_dashboard.embedding_params; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN report_dashboard.embedding_params IS 'Serialized JSON containing information about required parameters that must be supplied when embedding this Dashboard.';


--
-- Name: COLUMN report_dashboard.archived; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN report_dashboard.archived IS 'Is this Dashboard archived (effectively treated as deleted?)';


--
-- Name: COLUMN report_dashboard."position"; Type: COMMENT; Schema: public; Owner: quero_cultura
--

COMMENT ON COLUMN report_dashboard."position" IS 'The position this Dashboard should appear in the Dashboards list, lower-numbered positions appearing before higher numbered ones.';


--
-- Name: report_dashboard_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE report_dashboard_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE report_dashboard_id_seq OWNER TO quero_cultura;

--
-- Name: report_dashboard_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE report_dashboard_id_seq OWNED BY report_dashboard.id;


--
-- Name: report_dashboardcard; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE report_dashboardcard (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    "sizeX" integer NOT NULL,
    "sizeY" integer NOT NULL,
    "row" integer DEFAULT 0 NOT NULL,
    col integer DEFAULT 0 NOT NULL,
    card_id integer NOT NULL,
    dashboard_id integer NOT NULL,
    parameter_mappings text NOT NULL,
    visualization_settings text NOT NULL
);


ALTER TABLE report_dashboardcard OWNER TO quero_cultura;

--
-- Name: report_dashboardcard_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE report_dashboardcard_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE report_dashboardcard_id_seq OWNER TO quero_cultura;

--
-- Name: report_dashboardcard_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE report_dashboardcard_id_seq OWNED BY report_dashboardcard.id;


--
-- Name: revision; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE revision (
    id integer NOT NULL,
    model character varying(16) NOT NULL,
    model_id integer NOT NULL,
    user_id integer NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    object character varying NOT NULL,
    is_reversion boolean DEFAULT false NOT NULL,
    is_creation boolean DEFAULT false NOT NULL,
    message text
);


ALTER TABLE revision OWNER TO quero_cultura;

--
-- Name: revision_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE revision_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE revision_id_seq OWNER TO quero_cultura;

--
-- Name: revision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE revision_id_seq OWNED BY revision.id;


--
-- Name: segment; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE segment (
    id integer NOT NULL,
    table_id integer NOT NULL,
    creator_id integer NOT NULL,
    name character varying(254) NOT NULL,
    description text,
    is_active boolean DEFAULT true NOT NULL,
    definition text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    points_of_interest text,
    caveats text,
    show_in_getting_started boolean DEFAULT false NOT NULL
);


ALTER TABLE segment OWNER TO quero_cultura;

--
-- Name: segment_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE segment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE segment_id_seq OWNER TO quero_cultura;

--
-- Name: segment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE segment_id_seq OWNED BY segment.id;


--
-- Name: setting; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE setting (
    key character varying(254) NOT NULL,
    value text NOT NULL
);


ALTER TABLE setting OWNER TO quero_cultura;

--
-- Name: view_log; Type: TABLE; Schema: public; Owner: quero_cultura
--

CREATE TABLE view_log (
    id integer NOT NULL,
    user_id integer,
    model character varying(16) NOT NULL,
    model_id integer NOT NULL,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE view_log OWNER TO quero_cultura;

--
-- Name: view_log_id_seq; Type: SEQUENCE; Schema: public; Owner: quero_cultura
--

CREATE SEQUENCE view_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE view_log_id_seq OWNER TO quero_cultura;

--
-- Name: view_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: quero_cultura
--

ALTER SEQUENCE view_log_id_seq OWNED BY view_log.id;


--
-- Name: activity id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY activity ALTER COLUMN id SET DEFAULT nextval('activity_id_seq'::regclass);


--
-- Name: card_label id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY card_label ALTER COLUMN id SET DEFAULT nextval('card_label_id_seq'::regclass);


--
-- Name: collection id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY collection ALTER COLUMN id SET DEFAULT nextval('collection_id_seq'::regclass);


--
-- Name: collection_revision id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY collection_revision ALTER COLUMN id SET DEFAULT nextval('collection_revision_id_seq'::regclass);


--
-- Name: core_user id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY core_user ALTER COLUMN id SET DEFAULT nextval('core_user_id_seq'::regclass);


--
-- Name: dashboard_favorite id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY dashboard_favorite ALTER COLUMN id SET DEFAULT nextval('dashboard_favorite_id_seq'::regclass);


--
-- Name: dashboardcard_series id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY dashboardcard_series ALTER COLUMN id SET DEFAULT nextval('dashboardcard_series_id_seq'::regclass);


--
-- Name: dependency id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY dependency ALTER COLUMN id SET DEFAULT nextval('dependency_id_seq'::regclass);


--
-- Name: dimension id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY dimension ALTER COLUMN id SET DEFAULT nextval('dimension_id_seq'::regclass);


--
-- Name: label id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY label ALTER COLUMN id SET DEFAULT nextval('label_id_seq'::regclass);


--
-- Name: metabase_database id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY metabase_database ALTER COLUMN id SET DEFAULT nextval('metabase_database_id_seq'::regclass);


--
-- Name: metabase_field id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY metabase_field ALTER COLUMN id SET DEFAULT nextval('metabase_field_id_seq'::regclass);


--
-- Name: metabase_fieldvalues id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY metabase_fieldvalues ALTER COLUMN id SET DEFAULT nextval('metabase_fieldvalues_id_seq'::regclass);


--
-- Name: metabase_table id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY metabase_table ALTER COLUMN id SET DEFAULT nextval('metabase_table_id_seq'::regclass);


--
-- Name: metric id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY metric ALTER COLUMN id SET DEFAULT nextval('metric_id_seq'::regclass);


--
-- Name: metric_important_field id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY metric_important_field ALTER COLUMN id SET DEFAULT nextval('metric_important_field_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY permissions ALTER COLUMN id SET DEFAULT nextval('permissions_id_seq'::regclass);


--
-- Name: permissions_group id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY permissions_group ALTER COLUMN id SET DEFAULT nextval('permissions_group_id_seq'::regclass);


--
-- Name: permissions_group_membership id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY permissions_group_membership ALTER COLUMN id SET DEFAULT nextval('permissions_group_membership_id_seq'::regclass);


--
-- Name: permissions_revision id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY permissions_revision ALTER COLUMN id SET DEFAULT nextval('permissions_revision_id_seq'::regclass);


--
-- Name: pulse id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY pulse ALTER COLUMN id SET DEFAULT nextval('pulse_id_seq'::regclass);


--
-- Name: pulse_card id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY pulse_card ALTER COLUMN id SET DEFAULT nextval('pulse_card_id_seq'::regclass);


--
-- Name: pulse_channel id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY pulse_channel ALTER COLUMN id SET DEFAULT nextval('pulse_channel_id_seq'::regclass);


--
-- Name: pulse_channel_recipient id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY pulse_channel_recipient ALTER COLUMN id SET DEFAULT nextval('pulse_channel_recipient_id_seq'::regclass);


--
-- Name: query_execution id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY query_execution ALTER COLUMN id SET DEFAULT nextval('query_execution_id_seq'::regclass);


--
-- Name: raw_column id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY raw_column ALTER COLUMN id SET DEFAULT nextval('raw_column_id_seq'::regclass);


--
-- Name: raw_table id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY raw_table ALTER COLUMN id SET DEFAULT nextval('raw_table_id_seq'::regclass);


--
-- Name: report_card id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY report_card ALTER COLUMN id SET DEFAULT nextval('report_card_id_seq'::regclass);


--
-- Name: report_cardfavorite id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY report_cardfavorite ALTER COLUMN id SET DEFAULT nextval('report_cardfavorite_id_seq'::regclass);


--
-- Name: report_dashboard id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY report_dashboard ALTER COLUMN id SET DEFAULT nextval('report_dashboard_id_seq'::regclass);


--
-- Name: report_dashboardcard id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY report_dashboardcard ALTER COLUMN id SET DEFAULT nextval('report_dashboardcard_id_seq'::regclass);


--
-- Name: revision id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY revision ALTER COLUMN id SET DEFAULT nextval('revision_id_seq'::regclass);


--
-- Name: segment id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY segment ALTER COLUMN id SET DEFAULT nextval('segment_id_seq'::regclass);


--
-- Name: view_log id; Type: DEFAULT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY view_log ALTER COLUMN id SET DEFAULT nextval('view_log_id_seq'::regclass);


--
-- Data for Name: activity; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY activity (id, topic, "timestamp", user_id, model, model_id, database_id, table_id, custom_id, details) FROM stdin;
1	install	2017-11-11 23:01:35.374+00	\N	install	\N	\N	\N	\N	{}
2	user-joined	2017-11-11 23:03:22.285+00	1	user	1	\N	\N	\N	{}
3	card-create	2017-11-11 23:04:00.275+00	1	card	1	1	1	\N	{"name":"Products","description":null}
4	dashboard-create	2017-11-11 23:04:31.495+00	1	dashboard	1	\N	\N	\N	{"description":null,"name":"Cleber Loko"}
5	dashboard-add-cards	2017-11-11 23:04:35.937+00	1	dashboard	1	\N	\N	\N	{"description":null,"name":"Cleber Loko","dashcards":[{"name":"Products","description":null,"id":1,"card_id":1}]}
6	card-update	2017-11-12 03:31:56.424+00	1	card	1	1	1	\N	{"name":"Products","description":null}
7	card-update	2017-11-12 03:31:56.477+00	1	card	1	1	1	\N	{"name":"Products","description":null}
8	card-create	2017-11-12 21:42:36.931+00	1	card	2	2	6	\N	{"name":"Per Occupation Areas, Count, Grouped by Instance and Occupation Area","description":null}
9	dashboard-add-cards	2017-11-12 21:43:03.011+00	1	dashboard	1	\N	\N	\N	{"description":null,"name":"Cleber Loko","dashcards":[{"name":"Per Occupation Areas, Count, Grouped by Instance and Occupation Area","description":null,"id":2,"card_id":2}]}
10	card-update	2017-11-12 21:43:12.349+00	1	card	2	2	6	\N	{"name":"Per Occupation Areas, Count, Grouped by Instance and Occupation Area","description":null}
11	card-update	2017-11-12 21:43:12.451+00	1	card	2	2	6	\N	{"name":"Per Occupation Areas, Count, Grouped by Instance and Occupation Area","description":null}
12	card-create	2017-11-12 23:01:23.222+00	1	card	3	2	6	\N	{"name":"Per Occupation Areas, Count, Grouped by Date (month)","description":null}
13	dashboard-remove-cards	2017-11-12 23:01:55.287+00	1	dashboard	1	\N	\N	\N	{"description":null,"name":"Space Indicators","dashcards":[{"name":"Products","description":null,"id":1,"card_id":1}]}
14	dashboard-add-cards	2017-11-12 23:01:55.36+00	1	dashboard	1	\N	\N	\N	{"description":null,"name":"Space Indicators","dashcards":[{"name":"Per Occupation Areas, Count, Grouped by Date (month)","description":null,"id":3,"card_id":3}]}
15	card-update	2017-11-12 23:02:45.119+00	1	card	3	2	6	\N	{"name":"Per Occupation Areas, Count, Grouped by Date (month)","description":null}
16	card-create	2017-11-12 23:05:39.119+00	1	card	4	2	6	\N	{"name":"Per Occupation Areas, Cumulative count, Grouped by Date (month)","description":null}
17	dashboard-add-cards	2017-11-12 23:05:46.674+00	1	dashboard	1	\N	\N	\N	{"description":null,"name":"Space Indicators","dashcards":[{"name":"Per Occupation Areas, Cumulative count, Grouped by Date (month)","description":null,"id":4,"card_id":4}]}
18	card-create	2017-11-12 23:07:07.822+00	1	card	5	2	6	\N	{"name":"Per Occupation Areas, Cumulative count, Grouped by Date (month) and Instance","description":null}
19	card-create	2017-11-12 23:08:52.59+00	1	card	6	2	6	\N	{"name":"Per Occupation Areas, Cumulative count, Grouped by Date (month) and Instance","description":null}
20	dashboard-add-cards	2017-11-12 23:09:04.053+00	1	dashboard	1	\N	\N	\N	{"description":null,"name":"Space Indicators","dashcards":[{"name":"Per Occupation Areas, Cumulative count, Grouped by Date (month) and Instance","description":null,"id":5,"card_id":6}]}
21	card-update	2017-11-12 23:39:41.16+00	1	card	2	2	12	\N	{"name":"Per Occupation Areas, Count, Grouped by Instance and Occupation Area","description":null}
22	card-update	2017-11-12 23:40:19.04+00	1	card	3	2	12	\N	{"name":"Per Occupation Areas, Count, Grouped by Date (month)","description":null}
23	card-update	2017-11-12 23:40:49.776+00	1	card	3	2	12	\N	{"name":"Per Occupation Areas, Count, Grouped by Date (month)","description":null}
24	card-update	2017-11-12 23:41:52.335+00	1	card	4	2	12	\N	{"name":"Per Occupation Areas, Cumulative count, Grouped by Date (month)","description":null}
25	card-update	2017-11-12 23:42:45.241+00	1	card	6	2	12	\N	{"name":"Per Occupation Areas, Cumulative count, Grouped by Date (month) and Instance","description":null}
26	card-create	2017-11-12 23:51:12.968+00	1	card	7	2	12	\N	{"name":"Space Data, Count, Grouped by Instance and Space Type","description":null}
27	dashboard-add-cards	2017-11-12 23:52:25.536+00	1	dashboard	1	\N	\N	\N	{"description":null,"name":"Space Indicators","dashcards":[{"name":"Space Data, Count, Grouped by Instance and Space Type","description":null,"id":6,"card_id":7}]}
28	card-update	2017-11-13 00:05:31.238+00	1	card	2	2	12	\N	{"name":"Áreas de Atuação por Instância","description":null}
29	card-update	2017-11-13 00:07:04.804+00	1	card	4	2	12	\N	{"name":"Crescimento cumulativo mensal","description":null}
30	card-update	2017-11-13 00:07:30.46+00	1	card	6	2	12	\N	{"name":"Crescimento Cumulativo Mensal por Instância","description":null}
31	card-update	2017-11-13 00:08:11.172+00	1	card	3	2	12	\N	{"name":"Quantidade de Registros por Mês","description":null}
32	card-update	2017-11-13 00:09:00.331+00	1	card	7	2	12	\N	{"name":"Quantidade por Tipo por Instância","description":null}
33	card-update	2017-11-13 00:09:16.478+00	1	card	7	2	12	\N	{"name":"Tipos por Instância","description":null}
34	card-update	2017-11-13 00:10:07.483+00	1	card	4	2	12	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
35	card-update	2017-11-13 00:12:06.591+00	1	card	2	2	12	\N	{"name":"Áreas de Atuação por Instância","description":null}
\.


--
-- Data for Name: card_label; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY card_label (id, card_id, label_id) FROM stdin;
\.


--
-- Data for Name: collection; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY collection (id, name, slug, description, color, archived) FROM stdin;
\.


--
-- Data for Name: collection_revision; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY collection_revision (id, before, after, user_id, created_at, remark) FROM stdin;
\.


--
-- Data for Name: core_session; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY core_session (id, user_id, created_at) FROM stdin;
39730784-10a8-4c6a-b16d-59311e6dde9b	1	2017-11-11 23:03:22.271+00
16fb091b-8f9d-4823-b9e7-d1ee7a33da28	1	2017-11-12 03:19:55.526+00
\.


--
-- Data for Name: core_user; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY core_user (id, email, first_name, last_name, password, password_salt, date_joined, last_login, is_superuser, is_active, reset_token, reset_triggered, is_qbnewb, google_auth, ldap_auth) FROM stdin;
1	querocultura61@gmail.com	Quero	Cultura	$2a$10$mucdErrPR1pnf39krDT6Zu6TcEbtqE3SLNMEUsVJoHOxWJBzeXf9m	8c9df11c-9bd9-49fd-b830-8b8e90b802cb	2017-11-11 23:03:21.9+00	2017-11-12 03:19:55.625+00	t	t	\N	\N	f	f	f
\.


--
-- Data for Name: dashboard_favorite; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY dashboard_favorite (id, user_id, dashboard_id) FROM stdin;
\.


--
-- Data for Name: dashboardcard_series; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY dashboardcard_series (id, dashboardcard_id, card_id, "position") FROM stdin;
\.


--
-- Data for Name: data_migrations; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY data_migrations (id, "timestamp") FROM stdin;
set-card-database-and-table-ids	2017-11-11 23:01:34.43
set-mongodb-databases-ssl-false	2017-11-11 23:01:34.456
set-default-schemas	2017-11-11 23:01:34.508
set-admin-email	2017-11-11 23:01:34.561
remove-database-sync-activity-entries	2017-11-11 23:01:34.578
update-dashboards-to-new-grid	2017-11-11 23:01:34.597
migrate-field-visibility-type	2017-11-11 23:01:34.611
add-users-to-default-permissions-groups	2017-11-11 23:01:34.687
add-admin-group-root-entry	2017-11-11 23:01:34.73
add-databases-to-magic-permissions-groups	2017-11-11 23:01:34.767
migrate-field-types	2017-11-11 23:01:34.982
fix-invalid-field-types	2017-11-11 23:01:35.007
copy-site-url-setting-and-remove-trailing-slashes	2017-11-11 23:01:35.015
migrate-query-executions	2017-11-11 23:01:35.032
drop-old-query-execution-table	2017-11-11 23:01:35.058
ensure-protocol-specified-in-site-url	2017-11-11 23:01:35.076
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
11	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	10	EXECUTED	7:c7ef8b4f4dcb3528f9282b51aea5bb2a	sql		\N	3.5.3	\N	\N	0441238708
39	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	38	EXECUTED	7:a63ada256c44684d2649b8f3c28a3023	addColumn tableName=core_user		\N	3.5.3	\N	\N	0441238708
4	cammsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	3	EXECUTED	7:1ed887e91a846f4d6cbe84d1efd126c4	createTable tableName=setting		\N	3.5.3	\N	\N	0441238708
10	cammsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	9	EXECUTED	7:ec4f8eecc37fdc8c22440490de3a13f0	createTable tableName=revision; createIndex indexName=idx_revision_model_model_id, tableName=revision		\N	3.5.3	\N	\N	0441238708
12	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	11	EXECUTED	7:f78e18f669d7c9e6d06c63ea9929391f	addColumn tableName=report_card		\N	3.5.3	\N	\N	0441238708
13	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	12	EXECUTED	7:20a2ef1765573854864909ec2e7de766	createTable tableName=activity; createIndex indexName=idx_activity_timestamp, tableName=activity; createIndex indexName=idx_activity_user_id, tableName=activity; createIndex indexName=idx_activity_custom_id, tableName=activity		\N	3.5.3	\N	\N	0441238708
14	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	13	EXECUTED	7:6614fcaca4e41d003ce26de5cbc882f7	createTable tableName=view_log; createIndex indexName=idx_view_log_user_id, tableName=view_log; createIndex indexName=idx_view_log_timestamp, tableName=view_log		\N	3.5.3	\N	\N	0441238708
15	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	14	EXECUTED	7:50c72a51651af76928c06f21c9e04f97	addColumn tableName=revision		\N	3.5.3	\N	\N	0441238708
16	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	15	EXECUTED	7:a398a37dd953a0e82633d12658c6ac8f	dropNotNullConstraint columnName=last_login, tableName=core_user		\N	3.5.3	\N	\N	0441238708
17	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	16	EXECUTED	7:5401ec35a5bd1275f93a7cac1ddd7591	addColumn tableName=metabase_database; sql		\N	3.5.3	\N	\N	0441238708
18	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	17	EXECUTED	7:329d897d44ba9893fdafc9ce7e876d73	createTable tableName=data_migrations; createIndex indexName=idx_data_migrations_id, tableName=data_migrations		\N	3.5.3	\N	\N	0441238708
19	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	18	EXECUTED	7:e8fa976811e4d58d42a45804affa1d07	addColumn tableName=metabase_table		\N	3.5.3	\N	\N	0441238708
20	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	19	EXECUTED	7:9c5fedbd888307edf521a6a547f96f99	createTable tableName=pulse; createIndex indexName=idx_pulse_creator_id, tableName=pulse; createTable tableName=pulse_card; createIndex indexName=idx_pulse_card_pulse_id, tableName=pulse_card; createIndex indexName=idx_pulse_card_card_id, tableNam...		\N	3.5.3	\N	\N	0441238708
21	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	20	EXECUTED	7:c23c71d8a11b3f38aaf5bf98acf51e6f	createTable tableName=segment; createIndex indexName=idx_segment_creator_id, tableName=segment; createIndex indexName=idx_segment_table_id, tableName=segment		\N	3.5.3	\N	\N	0441238708
22	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	21	EXECUTED	7:cb6776ec86ab0ad9e74806a5460b9085	addColumn tableName=revision		\N	3.5.3	\N	\N	0441238708
23	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	22	EXECUTED	7:43b9662bd798db391d4bbb7d4615bf0d	modifyDataType columnName=rows, tableName=metabase_table		\N	3.5.3	\N	\N	0441238708
24	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	23	EXECUTED	7:69c2cad167fd7cec9e8c920d9ccab86e	createTable tableName=dependency; createIndex indexName=idx_dependency_model, tableName=dependency; createIndex indexName=idx_dependency_model_id, tableName=dependency; createIndex indexName=idx_dependency_dependent_on_model, tableName=dependency;...		\N	3.5.3	\N	\N	0441238708
25	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	24	EXECUTED	7:327941d9ac9414f493471b746a812fa4	createTable tableName=metric; createIndex indexName=idx_metric_creator_id, tableName=metric; createIndex indexName=idx_metric_table_id, tableName=metric		\N	3.5.3	\N	\N	0441238708
26	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	25	EXECUTED	7:ac7f40d2a3fbf3fea7936aa79bb1532b	addColumn tableName=metabase_database; sql		\N	3.5.3	\N	\N	0441238708
27	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	26	EXECUTED	7:e3a52bd649da7940246e4236b204714b	createTable tableName=dashboardcard_series; createIndex indexName=idx_dashboardcard_series_dashboardcard_id, tableName=dashboardcard_series; createIndex indexName=idx_dashboardcard_series_card_id, tableName=dashboardcard_series		\N	3.5.3	\N	\N	0441238708
28	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	27	EXECUTED	7:335e7e6b32dcbeb392150b3c3db2d5eb	addColumn tableName=core_user		\N	3.5.3	\N	\N	0441238708
29	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	28	EXECUTED	7:7b0bb8fcb7de2aa29ce57b32baf9ff31	addColumn tableName=pulse_channel		\N	3.5.3	\N	\N	0441238708
30	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	29	EXECUTED	7:7b5245de5d964eedb5cd6fdf5afdb6fd	addColumn tableName=metabase_field; addNotNullConstraint columnName=visibility_type, tableName=metabase_field		\N	3.5.3	\N	\N	0441238708
31	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	30	EXECUTED	7:347281cdb65a285b03aeaf77cb28e618	addColumn tableName=metabase_field		\N	3.5.3	\N	\N	0441238708
57	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	56	EXECUTED	7:5d51b16e22be3c81a27d3b5b345a8270	addColumn tableName=report_card	Added 0.25.0	\N	3.5.3	\N	\N	0441238708
59	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	58	EXECUTED	7:583e67af40cae19cab645bbd703558ef	addColumn tableName=metabase_field	Added 0.26.0	\N	3.5.3	\N	\N	0441238708
32	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	31	EXECUTED	7:ff40b5fbe06dc5221d0b9223992ece25	createTable tableName=label; createIndex indexName=idx_label_slug, tableName=label; createTable tableName=card_label; addUniqueConstraint constraintName=unique_card_label_card_id_label_id, tableName=card_label; createIndex indexName=idx_card_label...		\N	3.5.3	\N	\N	0441238708
32	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	32	EXECUTED	7:af1dea42abdc7cd058b5f744602d7a22	createTable tableName=raw_table; createIndex indexName=idx_rawtable_database_id, tableName=raw_table; addUniqueConstraint constraintName=uniq_raw_table_db_schema_name, tableName=raw_table; createTable tableName=raw_column; createIndex indexName=id...		\N	3.5.3	\N	\N	0441238708
34	tlrobinson	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	33	EXECUTED	7:e65d70b4c914cfdf5b3ef9927565e899	addColumn tableName=pulse_channel		\N	3.5.3	\N	\N	0441238708
35	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	34	EXECUTED	7:ab80b6b8e6dfc3fa3e8fa5954e3a8ec4	modifyDataType columnName=value, tableName=setting		\N	3.5.3	\N	\N	0441238708
36	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	35	EXECUTED	7:de534c871471b400d70ee29122f23847	addColumn tableName=report_dashboard; addNotNullConstraint columnName=parameters, tableName=report_dashboard; addColumn tableName=report_dashboardcard; addNotNullConstraint columnName=parameter_mappings, tableName=report_dashboardcard		\N	3.5.3	\N	\N	0441238708
37	tlrobinson	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	36	EXECUTED	7:487dd1fa57af0f25edf3265ed9899588	addColumn tableName=query_queryexecution; addNotNullConstraint columnName=query_hash, tableName=query_queryexecution; createIndex indexName=idx_query_queryexecution_query_hash, tableName=query_queryexecution; createIndex indexName=idx_query_querye...		\N	3.5.3	\N	\N	0441238708
38	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	37	EXECUTED	7:5e32fa14a0c34b99027e25901b7e3255	addColumn tableName=metabase_database; addColumn tableName=metabase_table; addColumn tableName=metabase_field; addColumn tableName=report_dashboard; addColumn tableName=metric; addColumn tableName=segment; addColumn tableName=metabase_database; ad...		\N	3.5.3	\N	\N	0441238708
40	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	39	EXECUTED	7:0ba56822308957969bf5ad5ea8ee6707	createTable tableName=permissions_group; createIndex indexName=idx_permissions_group_name, tableName=permissions_group; createTable tableName=permissions_group_membership; addUniqueConstraint constraintName=unique_permissions_group_membership_user...		\N	3.5.3	\N	\N	0441238708
41	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	40	EXECUTED	7:e1aa5b70f61426b29d74d38936e560de	dropColumn columnName=field_type, tableName=metabase_field; addDefaultValue columnName=active, tableName=metabase_field; addDefaultValue columnName=preview_display, tableName=metabase_field; addDefaultValue columnName=position, tableName=metabase_...		\N	3.5.3	\N	\N	0441238708
42	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	41	EXECUTED	7:779407e2ea3b8d89092fc9f72e29fdaa	dropForeignKeyConstraint baseTableName=query_queryexecution, constraintName=fk_queryexecution_ref_query_id; dropColumn columnName=query_id, tableName=query_queryexecution; dropColumn columnName=is_staff, tableName=core_user; dropColumn columnName=...		\N	3.5.3	\N	\N	0441238708
43	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	42	EXECUTED	7:dbc18c8ca697fc335869f0ed0eb5f4cb	createTable tableName=permissions_revision		\N	3.5.3	\N	\N	0441238708
44	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	43	EXECUTED	7:1d09a61933bbc5a01b0ddef7bd1b1336	dropColumn columnName=public_perms, tableName=report_card; dropColumn columnName=public_perms, tableName=report_dashboard; dropColumn columnName=public_perms, tableName=pulse		\N	3.5.3	\N	\N	0441238708
45	tlrobinson	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	44	EXECUTED	7:9198081e3329df7903d9016804ef0cf0	addColumn tableName=report_dashboardcard; addNotNullConstraint columnName=visualization_settings, tableName=report_dashboardcard		\N	3.5.3	\N	\N	0441238708
46	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	45	EXECUTED	7:aab12e940225b458986e15cf53d5d816	addNotNullConstraint columnName=row, tableName=report_dashboardcard; addNotNullConstraint columnName=col, tableName=report_dashboardcard; addDefaultValue columnName=row, tableName=report_dashboardcard; addDefaultValue columnName=col, tableName=rep...		\N	3.5.3	\N	\N	0441238708
47	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	46	EXECUTED	7:381e18d5008269e299f12c9726163675	createTable tableName=collection; createIndex indexName=idx_collection_slug, tableName=collection; addColumn tableName=report_card; createIndex indexName=idx_card_collection_id, tableName=report_card		\N	3.5.3	\N	\N	0441238708
48	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	47	EXECUTED	7:b8957fda76bab207f99ced39353df1da	createTable tableName=collection_revision		\N	3.5.3	\N	\N	0441238708
49	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	48	EXECUTED	7:bb653dc1919f366bb81f3356a4cbfa6c	addColumn tableName=report_card; createIndex indexName=idx_card_public_uuid, tableName=report_card; addColumn tableName=report_dashboard; createIndex indexName=idx_dashboard_public_uuid, tableName=report_dashboard; dropNotNullConstraint columnName...		\N	3.5.3	\N	\N	0441238708
50	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	49	EXECUTED	7:6a45ed802c2f724731835bfaa97c57c9	addColumn tableName=report_card; addColumn tableName=report_dashboard		\N	3.5.3	\N	\N	0441238708
1	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	1	EXECUTED	7:4760863947b982cf4783d8a8e02dc4ea	createTable tableName=core_organization; createTable tableName=core_user; createTable tableName=core_userorgperm; addUniqueConstraint constraintName=idx_unique_user_id_organization_id, tableName=core_userorgperm; createIndex indexName=idx_userorgp...		\N	3.5.3	\N	\N	0441238708
2	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	2	EXECUTED	7:816381628d3155232ae439826bfc3992	createTable tableName=core_session		\N	3.5.3	\N	\N	0441238708
5	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	4	EXECUTED	7:593149128c8f3a7e1f37a483bc67a924	addColumn tableName=core_organization		\N	3.5.3	\N	\N	0441238708
6	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	5	EXECUTED	7:d24f2f950306f150d87c4208520661d5	dropNotNullConstraint columnName=organization_id, tableName=metabase_database; dropForeignKeyConstraint baseTableName=metabase_database, constraintName=fk_database_ref_organization_id; dropNotNullConstraint columnName=organization_id, tableName=re...		\N	3.5.3	\N	\N	0441238708
7	cammsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	6	EXECUTED	7:baec0ec600ccc9bdadc176c1c4b29b77	addColumn tableName=metabase_field		\N	3.5.3	\N	\N	0441238708
8	tlrobinson	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	7	EXECUTED	7:ea2727c7ce666178cff436549f81ddbd	addColumn tableName=metabase_table; addColumn tableName=metabase_field		\N	3.5.3	\N	\N	0441238708
9	tlrobinson	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	8	EXECUTED	7:c05cf8a25248b38e281e8e85de4275a2	addColumn tableName=metabase_table		\N	3.5.3	\N	\N	0441238708
51	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	50	EXECUTED	7:2b28e18d04212a1cbd82eb7888ae4af3	createTable tableName=query_execution; createIndex indexName=idx_query_execution_started_at, tableName=query_execution; createIndex indexName=idx_query_execution_query_hash_started_at, tableName=query_execution		\N	3.5.3	\N	\N	0441238708
52	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	51	EXECUTED	7:fbe1b7114f1d4f346543e3c22e28bde3	createTable tableName=query_cache; createIndex indexName=idx_query_cache_updated_at, tableName=query_cache; addColumn tableName=report_card		\N	3.5.3	\N	\N	0441238708
53	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	52	EXECUTED	7:cc7ef026c3375d31df5f03036bb7e850	createTable tableName=query		\N	3.5.3	\N	\N	0441238708
54	tlrobinson	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	53	EXECUTED	7:0857800db71a4757e7202aad4eaed48d	addColumn tableName=pulse		\N	3.5.3	\N	\N	0441238708
55	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	54	EXECUTED	7:e169c9d0a5220127b97630e95717c033	addColumn tableName=report_dashboard; createTable tableName=dashboard_favorite; addUniqueConstraint constraintName=unique_dashboard_favorite_user_id_dashboard_id, tableName=dashboard_favorite; createIndex indexName=idx_dashboard_favorite_user_id, ...		\N	3.5.3	\N	\N	0441238708
56	wwwiiilll	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	55	EXECUTED	7:d72f90ad1c2911d60b943445a2cb7ee1	addColumn tableName=core_user	Added 0.25.0	\N	3.5.3	\N	\N	0441238708
58	senior	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	57	EXECUTED	7:a12d6057fa571739e5327316558a117f	createTable tableName=dimension; addUniqueConstraint constraintName=unique_dimension_field_id_name, tableName=dimension; createIndex indexName=idx_dimension_field_id, tableName=dimension	Added 0.25.0	\N	3.5.3	\N	\N	0441238708
60	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	59	EXECUTED	7:888069f3cbfb80ac05a734c980ac5885	addColumn tableName=metabase_database	Added 0.26.0	\N	3.5.3	\N	\N	0441238708
61	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	60	EXECUTED	7:070febe9fb610d73dc7bf69086f50a1d	addColumn tableName=metabase_field	Added 0.26.0	\N	3.5.3	\N	\N	0441238708
62	senior	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	61	EXECUTED	7:db49b2acae484cf753c67e0858e4b17f	addColumn tableName=metabase_database	Added 0.26.0	\N	3.5.3	\N	\N	0441238708
63	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	62	EXECUTED	7:fd58f763ac416881865080b693ce9aab	addColumn tableName=metabase_database	Added 0.26.0	\N	3.5.3	\N	\N	0441238708
64	senior	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	63	EXECUTED	7:1da13bf2e4248f9b47587f657c204dc3	dropForeignKeyConstraint baseTableName=raw_table, constraintName=fk_rawtable_ref_database	Added 0.26.0	\N	3.5.3	\N	\N	0441238708
66	senior	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	64	EXECUTED	7:76d06b44a544105c2a613603b8bdf25f	sql; sql	Added 0.26.0	\N	3.5.3	\N	\N	0441238708
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- Data for Name: dependency; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY dependency (id, model, model_id, dependent_on_model, dependent_on_id, created_at) FROM stdin;
\.


--
-- Data for Name: dimension; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY dimension (id, field_id, name, type, human_readable_field_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: label; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY label (id, name, slug, icon) FROM stdin;
\.


--
-- Data for Name: metabase_database; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY metabase_database (id, created_at, updated_at, name, description, details, engine, is_sample, is_full_sync, points_of_interest, caveats, metadata_sync_schedule, cache_field_values_schedule, timezone, is_on_demand) FROM stdin;
2	2017-11-12 21:38:36.634+00	2017-11-12 21:38:36.634+00	quero-cultura	\N	{"host":"mongo","port":27017,"dbname":"quero-cultura","tunnel-port":22,"ssl":false}	mongo	f	t	\N	\N	0 50 * * * ? *	0 50 0 * * ? *	\N	f
1	2017-11-11 23:01:35.379+00	2017-11-12 23:58:41.207+00	Sample Dataset	\N	{"db":"zip:/app/metabase.jar!/sample-dataset.db;USER=GUEST;PASSWORD=guest"}	h2	t	t	\N	\N	0 50 * * * ? *	0 50 0 * * ? *	UTC	f
\.


--
-- Data for Name: metabase_field; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version) FROM stdin;
6	2017-11-11 23:01:36.346+00	2017-11-11 23:01:38.801+00	CREATED_AT	type/DateTime	\N	t	The day and time a review was written by a user.	t	0	4	\N	Created At	normal	\N	\N	2017-11-11 23:01:39.147+00	\N	\N	{"global":{"distinct-count":432}}	1
34	2017-11-11 23:01:37.241+00	2017-11-11 23:01:42.027+00	CREATED_AT	type/DateTime	\N	t	The date the product was added to our catalog.	t	0	1	\N	Created At	normal	\N	\N	2017-11-11 23:01:42.254+00	\N	\N	{"global":{"distinct-count":179}}	1
26	2017-11-11 23:01:36.943+00	2017-11-11 23:01:41.722+00	CREATED_AT	type/DateTime	\N	t	The date and time an order was submitted.	t	0	2	\N	Created At	normal	\N	\N	2017-11-11 23:01:41.944+00	\N	\N	{"global":{"distinct-count":703}}	1
33	2017-11-11 23:01:37.231+00	2017-11-11 23:01:42.033+00	ID	type/BigInteger	type/PK	t	The numerical product number. Only used internally. All external communication should use the title or EAN.	t	0	1	\N	ID	normal	\N	\N	2017-11-11 23:01:42.254+00	\N	\N	{"global":{"distinct-count":200},"type":{"type/Number":{"min":1,"max":200,"avg":100.5}}}	1
32	2017-11-11 23:01:37.22+00	2017-11-11 23:01:42.18+00	EAN	type/Text	type/Category	t	The international article number. A 13 digit number uniquely identifying the product.	t	0	1	\N	Ean	normal	\N	\N	2017-11-11 23:01:42.254+00	\N	\N	{"global":{"distinct-count":200},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":13.0}}}	1
25	2017-11-11 23:01:36.931+00	2017-11-11 23:01:41.788+00	ID	type/BigInteger	type/PK	t	This is a unique ID for the product. It is also called the “Invoice number” or “Confirmation number” in customer facing emails and screens.	t	0	2	\N	ID	normal	\N	\N	2017-11-11 23:01:41.944+00	\N	\N	{"global":{"distinct-count":10000},"type":{"type/Number":{"min":1,"max":10000,"avg":5000.5}}}	1
24	2017-11-11 23:01:36.922+00	2017-11-11 23:01:41.822+00	TOTAL	type/Float	\N	t	The total billed amount.	t	0	2	\N	Total	normal	\N	\N	2017-11-11 23:01:41.944+00	\N	\N	{"global":{"distinct-count":2601},"type":{"type/Number":{"min":12.02,"max":106.82000000000001,"avg":61.055213999999594}}}	1
5	2017-11-11 23:01:36.334+00	2017-11-11 23:01:38.82+00	ID	type/BigInteger	type/PK	t	A unique internal identifier for the review. Should not be used externally.	t	0	4	\N	ID	normal	\N	\N	2017-11-11 23:01:39.147+00	\N	\N	{"global":{"distinct-count":1078},"type":{"type/Number":{"min":1,"max":1078,"avg":539.5}}}	1
4	2017-11-11 23:01:36.323+00	2017-11-11 23:01:38.835+00	PRODUCT_ID	type/Integer	type/FK	t	The product the review was for	t	0	4	\N	Product ID	normal	33	\N	2017-11-11 23:01:39.147+00	\N	\N	{"global":{"distinct-count":177},"type":{"type/Number":{"min":1,"max":200,"avg":102.46753246753246}}}	1
23	2017-11-11 23:01:36.911+00	2017-11-11 23:01:41.848+00	PRODUCT_ID	type/Integer	type/FK	t	The product ID. This is an internal identifier for the product, NOT the SKU.	t	0	2	\N	Product ID	normal	33	\N	2017-11-11 23:01:41.944+00	\N	\N	{"global":{"distinct-count":200},"type":{"type/Number":{"min":1,"max":200,"avg":101.2259}}}	1
19	2017-11-11 23:01:36.71+00	2017-11-11 23:01:40.13+00	CREATED_AT	type/DateTime	\N	t	The date the user record was created. Also referred to as the user’s "join date"	t	0	3	\N	Created At	normal	\N	\N	2017-11-11 23:01:41.036+00	\N	\N	{"global":{"distinct-count":709}}	1
18	2017-11-11 23:01:36.7+00	2017-11-11 23:01:40.962+00	LONGITUDE	type/Float	type/Longitude	t	This is the longitude of the user on sign-up. It might be updated in the future to the last seen location.	t	0	3	\N	Longitude	normal	\N	\N	2017-11-11 23:01:41.036+00	\N	\N	{"global":{"distinct-count":2500},"type":{"type/Number":{"min":-179.30480334715446,"max":179.73650520575882,"avg":-3.4080871128541554}}}	1
31	2017-11-11 23:01:37.209+00	2017-11-11 23:01:42.188+00	RATING	type/Float	type/Category	t	The average rating users have given the product. This ranges from 1 - 5	t	0	1	\N	Rating	normal	\N	\N	2017-11-11 23:01:42.254+00	\N	\N	{"global":{"distinct-count":25},"type":{"type/Number":{"min":0.0,"max":5.0,"avg":3.446}}}	1
22	2017-11-11 23:01:36.9+00	2017-11-11 23:01:41.874+00	TAX	type/Float	\N	t	This is the amount of local and federal taxes that are collected on the purchase. Note that other governmental fees on some products are not included here, but instead are accounted for in the subtotal.	t	0	2	\N	Tax	normal	\N	\N	2017-11-11 23:01:41.944+00	\N	\N	{"global":{"distinct-count":629},"type":{"type/Number":{"min":0.0,"max":7.45,"avg":2.4415579999999966}}}	1
21	2017-11-11 23:01:36.888+00	2017-11-11 23:01:41.937+00	SUBTOTAL	type/Float	type/Category	t	The raw, pre-tax cost of the order. Note that this might be different in the future from the product price due to promotions, credits, etc.	t	0	2	\N	Subtotal	normal	\N	\N	2017-11-11 23:01:41.944+00	\N	\N	{"global":{"distinct-count":199},"type":{"type/Number":{"min":12.02,"max":99.37,"avg":58.6136559999989}}}	1
20	2017-11-11 23:01:36.87+00	2017-11-11 23:01:41.925+00	USER_ID	type/Integer	type/FK	t	The id of the user who made this order. Note that in some cases where an order was created on behalf of a customer who phoned the order in, this might be the employee who handled the request.	t	0	2	\N	User ID	normal	14	\N	2017-11-11 23:01:41.944+00	\N	\N	{"global":{"distinct-count":955},"type":{"type/Number":{"min":2,"max":1423,"avg":703.9771}}}	1
3	2017-11-11 23:01:36.304+00	2017-11-11 23:01:39.118+00	RATING	type/Integer	type/Category	t	The rating (on a scale of 1-5) the user left.	t	0	4	\N	Rating	normal	\N	\N	2017-11-11 23:01:39.147+00	\N	\N	{"global":{"distinct-count":5},"type":{"type/Number":{"min":1,"max":5,"avg":3.937847866419295}}}	1
2	2017-11-11 23:01:36.29+00	2017-11-11 23:01:39.133+00	BODY	type/Text	type/Description	t	The review the user left. Limited to 2000 characters.	f	0	4	\N	Body	normal	\N	\N	2017-11-11 23:01:39.147+00	\N	\N	{"global":{"distinct-count":1078},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":179.51669758812616}}}	1
1	2017-11-11 23:01:36.276+00	2017-11-11 23:01:39.063+00	REVIEWER	type/Text	\N	t	The user who left the review	t	0	4	\N	Reviewer	normal	\N	\N	2017-11-11 23:01:39.147+00	\N	\N	{"global":{"distinct-count":1030},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":9.742115027829314}}}	1
30	2017-11-11 23:01:37.195+00	2017-11-11 23:01:42.205+00	CATEGORY	type/Text	type/Category	t	The type of product, valid values include: Doohicky, Gadget, Gizmo and Widget	t	0	1	\N	Category	normal	\N	\N	2017-11-11 23:01:42.254+00	\N	\N	{"global":{"distinct-count":4},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":6.58}}}	1
29	2017-11-11 23:01:37.169+00	2017-11-11 23:01:42.222+00	PRICE	type/Float	type/Category	t	The list price of the product. Note that this is not always the price the product sold for due to discounts, promotions, etc.	t	0	1	\N	Price	normal	\N	\N	2017-11-11 23:01:42.254+00	\N	\N	{"global":{"distinct-count":199},"type":{"type/Number":{"min":12.02,"max":99.37,"avg":58.86635000000002}}}	1
28	2017-11-11 23:01:37.148+00	2017-11-11 23:01:42.233+00	TITLE	type/Text	type/Category	t	The name of the product as it should be displayed to customers.	t	0	1	\N	Title	normal	\N	\N	2017-11-11 23:01:42.254+00	\N	\N	{"global":{"distinct-count":200},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":21.68}}}	1
27	2017-11-11 23:01:37.125+00	2017-11-11 23:01:42.244+00	VENDOR	type/Text	type/Category	t	The source of the product.	t	0	1	\N	Vendor	normal	\N	\N	2017-11-11 23:01:42.254+00	\N	\N	{"global":{"distinct-count":200},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":20.21}}}	1
10	2017-11-11 23:01:36.52+00	2017-11-11 23:01:41.016+00	LATITUDE	type/Float	type/Latitude	t	This is the latitude of the user on sign-up. It might be updated in the future to the last seen location.	t	0	3	\N	Latitude	normal	\N	\N	2017-11-11 23:01:41.036+00	\N	\N	{"global":{"distinct-count":2500},"type":{"type/Number":{"min":-89.96310010740648,"max":89.98241873383432,"avg":1.522487391742865}}}	1
7	2017-11-11 23:01:36.448+00	2017-11-11 23:01:40.949+00	CITY	type/Text	type/City	t	The city of the account’s billing address	t	0	3	\N	City	normal	\N	\N	2017-11-11 23:01:41.036+00	\N	\N	{"global":{"distinct-count":2466},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":12.0392}}}	1
17	2017-11-11 23:01:36.688+00	2017-11-11 23:01:40.973+00	STATE	type/Text	type/State	t	The state or province of the account’s billing address	t	0	3	\N	State	normal	\N	\N	2017-11-11 23:01:41.036+00	\N	\N	{"global":{"distinct-count":62},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":2.0}}}	1
16	2017-11-11 23:01:36.67+00	2017-11-11 23:01:40.397+00	PASSWORD	type/Text	\N	t	This is the salted password of the user. It should not be visible	t	0	3	\N	Password	normal	\N	\N	2017-11-11 23:01:41.036+00	\N	\N	{"global":{"distinct-count":2500},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}	1
15	2017-11-11 23:01:36.656+00	2017-11-11 23:01:40.993+00	NAME	type/Text	type/Name	t	The name of the user who owns an account	t	0	3	\N	Name	normal	\N	\N	2017-11-11 23:01:41.036+00	\N	\N	{"global":{"distinct-count":2498},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":13.5328}}}	1
14	2017-11-11 23:01:36.636+00	2017-11-11 23:01:40.507+00	ID	type/BigInteger	type/PK	t	A unique identifier given to each user.	t	0	3	\N	ID	normal	\N	\N	2017-11-11 23:01:41.036+00	\N	\N	{"global":{"distinct-count":2500},"type":{"type/Number":{"min":1,"max":2500,"avg":1250.5}}}	1
13	2017-11-11 23:01:36.618+00	2017-11-11 23:01:41.005+00	EMAIL	type/Text	type/Email	t	The contact email for the account.	t	0	3	\N	Email	normal	\N	\N	2017-11-11 23:01:41.036+00	\N	\N	{"global":{"distinct-count":2500},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":1.0,"average-length":24.2184}}}	1
12	2017-11-11 23:01:36.587+00	2017-11-11 23:01:40.693+00	ZIP	type/Text	type/ZipCode	t	The postal code of the account’s billing address	t	0	3	\N	Zip	normal	\N	\N	2017-11-11 23:01:41.036+00	\N	\N	{"global":{"distinct-count":2469},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.0}}}	1
11	2017-11-11 23:01:36.554+00	2017-11-11 23:01:40.753+00	ADDRESS	type/Text	\N	t	The street address of the account’s billing address	t	0	3	\N	Address	normal	\N	\N	2017-11-11 23:01:41.036+00	\N	\N	{"global":{"distinct-count":2500},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":17.996}}}	1
9	2017-11-11 23:01:36.497+00	2017-11-11 23:01:41.029+00	SOURCE	type/Text	type/Category	t	The channel through which we acquired this user. Valid values include: Affiliate, Facebook, Google, Organic and Twitter	t	0	3	\N	Source	normal	\N	\N	2017-11-11 23:01:41.036+00	\N	\N	{"global":{"distinct-count":5},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.3856}}}	1
8	2017-11-11 23:01:36.471+00	2017-11-11 23:01:40.851+00	BIRTH_DATE	type/Date	\N	t	The date of birth of the user	t	0	3	\N	Birth Date	normal	\N	\N	2017-11-11 23:01:41.036+00	\N	\N	{"global":{"distinct-count":2300}}	1
269	2017-11-12 21:38:40.532+00	2017-11-12 23:50:02.694+00	Mostra	type/Integer	\N	t	\N	t	0	5	242	Most Ra	normal	\N	\N	\N	\N	\N	\N	0
267	2017-11-12 21:38:40.51+00	2017-11-12 23:50:02.705+00	Exposição	type/Integer	\N	t	\N	t	0	5	242	Exposição	normal	\N	\N	\N	\N	\N	\N	0
88	2017-11-12 21:38:38.119+00	2017-11-12 23:50:00.891+00	10	type/Integer	\N	t	\N	t	0	5	84	10	normal	\N	\N	\N	\N	\N	\N	0
64	2017-11-12 21:38:37.77+00	2017-11-12 23:50:02.273+00	11	type/Integer	\N	t	\N	t	0	5	62	11	normal	\N	\N	\N	\N	\N	\N	0
65	2017-11-12 21:38:37.801+00	2017-11-12 23:50:02.284+00	08	type/Integer	\N	t	\N	t	0	5	62	08	normal	\N	\N	\N	\N	\N	\N	0
66	2017-11-12 21:38:37.82+00	2017-11-12 23:50:02.295+00	07	type/Integer	\N	t	\N	t	0	5	62	07	normal	\N	\N	\N	\N	\N	\N	0
67	2017-11-12 21:38:37.832+00	2017-11-12 23:50:02.306+00	10	type/Integer	\N	t	\N	t	0	5	62	10	normal	\N	\N	\N	\N	\N	\N	0
68	2017-11-12 21:38:37.842+00	2017-11-12 23:50:02.317+00	12	type/Integer	\N	t	\N	t	0	5	62	12	normal	\N	\N	\N	\N	\N	\N	0
268	2017-11-12 21:38:40.521+00	2017-11-12 23:50:02.677+00	Pesquisa	type/Integer	\N	t	\N	t	0	5	242	Pes Quis A	normal	\N	\N	\N	\N	\N	\N	0
38	2017-11-12 21:38:37.333+00	2017-11-12 23:50:01.812+00	09	type/Integer	\N	t	\N	t	0	5	37	09	normal	\N	\N	\N	\N	\N	\N	0
39	2017-11-12 21:38:37.344+00	2017-11-12 23:50:01.831+00	06	type/Integer	\N	t	\N	t	0	5	37	06	normal	\N	\N	\N	\N	\N	\N	0
40	2017-11-12 21:38:37.354+00	2017-11-12 23:50:01.842+00	03	type/Integer	\N	t	\N	t	0	5	37	03	normal	\N	\N	\N	\N	\N	\N	0
41	2017-11-12 21:38:37.378+00	2017-11-12 23:50:01.852+00	11	type/Integer	\N	t	\N	t	0	5	37	11	normal	\N	\N	\N	\N	\N	\N	0
42	2017-11-12 21:38:37.403+00	2017-11-12 23:50:01.863+00	05	type/Integer	\N	t	\N	t	0	5	37	05	normal	\N	\N	\N	\N	\N	\N	0
43	2017-11-12 21:38:37.435+00	2017-11-12 23:50:01.875+00	08	type/Integer	\N	t	\N	t	0	5	37	08	normal	\N	\N	\N	\N	\N	\N	0
44	2017-11-12 21:38:37.456+00	2017-11-12 23:50:01.885+00	07	type/Integer	\N	t	\N	t	0	5	37	07	normal	\N	\N	\N	\N	\N	\N	0
45	2017-11-12 21:38:37.467+00	2017-11-12 23:50:01.897+00	10	type/Integer	\N	t	\N	t	0	5	37	10	normal	\N	\N	\N	\N	\N	\N	0
46	2017-11-12 21:38:37.49+00	2017-11-12 23:50:01.908+00	12	type/Integer	\N	t	\N	t	0	5	37	12	normal	\N	\N	\N	\N	\N	\N	0
47	2017-11-12 21:38:37.5+00	2017-11-12 23:50:01.918+00	04	type/Integer	\N	t	\N	t	0	5	37	04	normal	\N	\N	\N	\N	\N	\N	0
48	2017-11-12 21:38:37.51+00	2017-11-12 23:50:01.929+00	01	type/Integer	\N	t	\N	t	0	5	37	01	normal	\N	\N	\N	\N	\N	\N	0
49	2017-11-12 21:38:37.521+00	2017-11-12 23:50:01.941+00	02	type/Integer	\N	t	\N	t	0	5	37	02	normal	\N	\N	\N	\N	\N	\N	0
70	2017-11-12 21:38:37.865+00	2017-11-12 23:50:01.952+00	2016	type/Dictionary	\N	t	\N	t	0	5	36	2016	normal	\N	\N	\N	\N	\N	\N	0
71	2017-11-12 21:38:37.875+00	2017-11-12 23:50:01.964+00	09	type/Integer	\N	t	\N	t	0	5	70	09	normal	\N	\N	\N	\N	\N	\N	0
72	2017-11-12 21:38:37.887+00	2017-11-12 23:50:01.974+00	06	type/Integer	\N	t	\N	t	0	5	70	06	normal	\N	\N	\N	\N	\N	\N	0
73	2017-11-12 21:38:37.898+00	2017-11-12 23:50:01.996+00	03	type/Integer	\N	t	\N	t	0	5	70	03	normal	\N	\N	\N	\N	\N	\N	0
74	2017-11-12 21:38:37.908+00	2017-11-12 23:50:02.007+00	11	type/Integer	\N	t	\N	t	0	5	70	11	normal	\N	\N	\N	\N	\N	\N	0
75	2017-11-12 21:38:37.936+00	2017-11-12 23:50:02.018+00	05	type/Integer	\N	t	\N	t	0	5	70	05	normal	\N	\N	\N	\N	\N	\N	0
77	2017-11-12 21:38:37.964+00	2017-11-12 23:50:02.029+00	07	type/Integer	\N	t	\N	t	0	5	70	07	normal	\N	\N	\N	\N	\N	\N	0
78	2017-11-12 21:38:37.975+00	2017-11-12 23:50:02.04+00	10	type/Integer	\N	t	\N	t	0	5	70	10	normal	\N	\N	\N	\N	\N	\N	0
79	2017-11-12 21:38:37.985+00	2017-11-12 23:50:02.051+00	12	type/Integer	\N	t	\N	t	0	5	70	12	normal	\N	\N	\N	\N	\N	\N	0
80	2017-11-12 21:38:37.997+00	2017-11-12 23:50:02.062+00	04	type/Integer	\N	t	\N	t	0	5	70	04	normal	\N	\N	\N	\N	\N	\N	0
81	2017-11-12 21:38:38.009+00	2017-11-12 23:50:02.074+00	01	type/Integer	\N	t	\N	t	0	5	70	01	normal	\N	\N	\N	\N	\N	\N	0
82	2017-11-12 21:38:38.052+00	2017-11-12 23:50:02.085+00	02	type/Integer	\N	t	\N	t	0	5	70	02	normal	\N	\N	\N	\N	\N	\N	0
52	2017-11-12 21:38:37.577+00	2017-11-12 23:50:02.124+00	06	type/Integer	\N	t	\N	t	0	5	50	06	normal	\N	\N	\N	\N	\N	\N	0
53	2017-11-12 21:38:37.594+00	2017-11-12 23:50:02.14+00	03	type/Integer	\N	t	\N	t	0	5	50	03	normal	\N	\N	\N	\N	\N	\N	0
54	2017-11-12 21:38:37.613+00	2017-11-12 23:50:02.152+00	11	type/Integer	\N	t	\N	t	0	5	50	11	normal	\N	\N	\N	\N	\N	\N	0
56	2017-11-12 21:38:37.655+00	2017-11-12 23:50:02.162+00	08	type/Integer	\N	t	\N	t	0	5	50	08	normal	\N	\N	\N	\N	\N	\N	0
57	2017-11-12 21:38:37.668+00	2017-11-12 23:50:02.174+00	07	type/Integer	\N	t	\N	t	0	5	50	07	normal	\N	\N	\N	\N	\N	\N	0
58	2017-11-12 21:38:37.687+00	2017-11-12 23:50:02.184+00	10	type/Integer	\N	t	\N	t	0	5	50	10	normal	\N	\N	\N	\N	\N	\N	0
59	2017-11-12 21:38:37.698+00	2017-11-12 23:50:02.195+00	04	type/Integer	\N	t	\N	t	0	5	50	04	normal	\N	\N	\N	\N	\N	\N	0
60	2017-11-12 21:38:37.71+00	2017-11-12 23:50:02.212+00	01	type/Integer	\N	t	\N	t	0	5	50	01	normal	\N	\N	\N	\N	\N	\N	0
51	2017-11-12 21:38:37.554+00	2017-11-12 23:50:02.228+00	09	type/Integer	\N	t	\N	t	0	5	50	09	normal	\N	\N	\N	\N	\N	\N	0
63	2017-11-12 21:38:37.753+00	2017-11-12 23:50:02.263+00	09	type/Integer	\N	t	\N	t	0	5	62	09	normal	\N	\N	\N	\N	\N	\N	0
37	2017-11-12 21:38:37.317+00	2017-11-12 23:50:08.75+00	2015	type/Dictionary	\N	t	\N	t	0	5	36	2015	normal	\N	\N	2017-11-12 23:50:08.883+00	\N	\N	{"global":{"distinct-count":2}}	1
271	2017-11-12 21:38:44.707+00	2017-11-12 22:54:47.753+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	6	\N	ID	normal	\N	\N	2017-11-12 21:38:58.302+00	\N	\N	{"global":{"distinct-count":10000}}	1
275	2017-11-12 21:38:44.828+00	2017-11-12 23:50:09.015+00	2014	type/Dictionary	\N	t	\N	t	0	7	274	2014	normal	\N	\N	2017-11-12 23:50:09.134+00	\N	\N	{"global":{"distinct-count":3}}	1
260	2017-11-12 21:38:40.432+00	2017-11-12 23:50:02.727+00	Edital	type/Integer	\N	t	\N	t	0	5	242	Edit Al	normal	\N	\N	\N	\N	\N	\N	0
244	2017-11-12 21:38:40.167+00	2017-11-12 23:50:02.739+00	Festa Popular	type/Integer	\N	t	\N	t	0	5	242	Festa Popular	normal	\N	\N	\N	\N	\N	\N	0
246	2017-11-12 21:38:40.208+00	2017-11-12 23:50:02.75+00	Conferência Pública Estadual	type/Integer	\N	t	\N	t	0	5	242	Conferência Pública Esta Dual	normal	\N	\N	\N	\N	\N	\N	0
247	2017-11-12 21:38:40.225+00	2017-11-12 23:50:02.76+00	Conferência Pública Municipal	type/Integer	\N	t	\N	t	0	5	242	Conferência Pública Municipal	normal	\N	\N	\N	\N	\N	\N	0
248	2017-11-12 21:38:40.237+00	2017-11-12 23:50:02.772+00	Palestra	type/Integer	\N	t	\N	t	0	5	242	Palestra	normal	\N	\N	\N	\N	\N	\N	0
249	2017-11-12 21:38:40.245+00	2017-11-12 23:50:02.783+00	Curso	type/Integer	\N	t	\N	t	0	5	242	Cur So	normal	\N	\N	\N	\N	\N	\N	0
250	2017-11-12 21:38:40.255+00	2017-11-12 23:50:02.794+00	Inscrições	type/Integer	\N	t	\N	t	0	5	242	Inscrições	normal	\N	\N	\N	\N	\N	\N	0
251	2017-11-12 21:38:40.277+00	2017-11-12 23:50:02.805+00	Parada e Desfile Festivo	type/Integer	\N	t	\N	t	0	5	242	Parada E Des File Fest Ivo	normal	\N	\N	\N	\N	\N	\N	0
252	2017-11-12 21:38:40.288+00	2017-11-12 23:50:02.816+00	Exibição	type/Integer	\N	t	\N	t	0	5	242	Exibição	normal	\N	\N	\N	\N	\N	\N	0
255	2017-11-12 21:38:40.321+00	2017-11-12 23:50:02.904+00	Feira	type/Integer	\N	t	\N	t	0	5	242	Feira	normal	\N	\N	\N	\N	\N	\N	0
193	2017-11-12 21:38:39.562+00	2017-11-12 23:50:03.076+00	Festa Popular	type/Integer	\N	t	\N	t	0	5	192	Festa Popular	normal	\N	\N	\N	\N	\N	\N	0
297	2017-11-12 21:38:45.094+00	2017-11-12 23:50:03.47+00	2015	type/Dictionary	\N	t	\N	t	0	7	274	2015	normal	\N	\N	\N	\N	\N	\N	0
93	2017-11-12 21:38:38.174+00	2017-11-12 23:50:00.719+00	06	type/Integer	\N	t	\N	t	0	5	91	06	normal	\N	\N	\N	\N	\N	\N	0
102	2017-11-12 21:38:38.288+00	2017-11-12 23:50:00.734+00	02	type/Integer	\N	t	\N	t	0	5	91	02	normal	\N	\N	\N	\N	\N	\N	0
115	2017-11-12 21:38:38.507+00	2017-11-12 23:50:00.845+00	2014	type/Dictionary	\N	t	\N	t	0	5	83	2014	normal	\N	\N	\N	\N	\N	\N	0
116	2017-11-12 21:38:38.517+00	2017-11-12 23:50:00.858+00	10	type/Integer	\N	t	\N	t	0	5	115	10	normal	\N	\N	\N	\N	\N	\N	0
84	2017-11-12 21:38:38.075+00	2017-11-12 23:50:00.878+00	2015	type/Dictionary	\N	t	\N	t	0	5	83	2015	normal	\N	\N	\N	\N	\N	\N	0
90	2017-11-12 21:38:38.141+00	2017-11-12 23:50:00.9+00	01	type/Integer	\N	t	\N	t	0	5	84	01	normal	\N	\N	\N	\N	\N	\N	0
110	2017-11-12 21:38:38.42+00	2017-11-12 23:50:00.969+00	07	type/Integer	\N	t	\N	t	0	5	103	07	normal	\N	\N	\N	\N	\N	\N	0
111	2017-11-12 21:38:38.441+00	2017-11-12 23:50:00.977+00	10	type/Integer	\N	t	\N	t	0	5	103	10	normal	\N	\N	\N	\N	\N	\N	0
112	2017-11-12 21:38:38.452+00	2017-11-12 23:50:00.989+00	12	type/Integer	\N	t	\N	t	0	5	103	12	normal	\N	\N	\N	\N	\N	\N	0
113	2017-11-12 21:38:38.463+00	2017-11-12 23:50:01+00	04	type/Integer	\N	t	\N	t	0	5	103	04	normal	\N	\N	\N	\N	\N	\N	0
114	2017-11-12 21:38:38.486+00	2017-11-12 23:50:01.011+00	02	type/Integer	\N	t	\N	t	0	5	103	02	normal	\N	\N	\N	\N	\N	\N	0
104	2017-11-12 21:38:38.344+00	2017-11-12 23:50:01.022+00	09	type/Integer	\N	t	\N	t	0	5	103	09	normal	\N	\N	\N	\N	\N	\N	0
105	2017-11-12 21:38:38.363+00	2017-11-12 23:50:01.033+00	06	type/Integer	\N	t	\N	t	0	5	103	06	normal	\N	\N	\N	\N	\N	\N	0
106	2017-11-12 21:38:38.375+00	2017-11-12 23:50:01.044+00	03	type/Integer	\N	t	\N	t	0	5	103	03	normal	\N	\N	\N	\N	\N	\N	0
107	2017-11-12 21:38:38.385+00	2017-11-12 23:50:01.055+00	11	type/Integer	\N	t	\N	t	0	5	103	11	normal	\N	\N	\N	\N	\N	\N	0
108	2017-11-12 21:38:38.396+00	2017-11-12 23:50:01.066+00	05	type/Integer	\N	t	\N	t	0	5	103	05	normal	\N	\N	\N	\N	\N	\N	0
109	2017-11-12 21:38:38.407+00	2017-11-12 23:50:01.077+00	08	type/Integer	\N	t	\N	t	0	5	103	08	normal	\N	\N	\N	\N	\N	\N	0
118	2017-11-12 21:38:38.539+00	2017-11-12 23:50:01.102+00	2015	type/Dictionary	\N	t	\N	t	0	5	117	2015	normal	\N	\N	\N	\N	\N	\N	0
124	2017-11-12 21:38:38.638+00	2017-11-12 23:50:01.119+00	08	type/Integer	\N	t	\N	t	0	5	118	08	normal	\N	\N	\N	\N	\N	\N	0
125	2017-11-12 21:38:38.653+00	2017-11-12 23:50:01.133+00	07	type/Integer	\N	t	\N	t	0	5	118	07	normal	\N	\N	\N	\N	\N	\N	0
126	2017-11-12 21:38:38.673+00	2017-11-12 23:50:01.144+00	10	type/Integer	\N	t	\N	t	0	5	118	10	normal	\N	\N	\N	\N	\N	\N	0
127	2017-11-12 21:38:38.683+00	2017-11-12 23:50:01.155+00	04	type/Integer	\N	t	\N	t	0	5	118	04	normal	\N	\N	\N	\N	\N	\N	0
128	2017-11-12 21:38:38.704+00	2017-11-12 23:50:01.166+00	01	type/Integer	\N	t	\N	t	0	5	118	01	normal	\N	\N	\N	\N	\N	\N	0
129	2017-11-12 21:38:38.72+00	2017-11-12 23:50:01.177+00	02	type/Integer	\N	t	\N	t	0	5	118	02	normal	\N	\N	\N	\N	\N	\N	0
120	2017-11-12 21:38:38.584+00	2017-11-12 23:50:01.188+00	06	type/Integer	\N	t	\N	t	0	5	118	06	normal	\N	\N	\N	\N	\N	\N	0
121	2017-11-12 21:38:38.599+00	2017-11-12 23:50:01.199+00	03	type/Integer	\N	t	\N	t	0	5	118	03	normal	\N	\N	\N	\N	\N	\N	0
123	2017-11-12 21:38:38.628+00	2017-11-12 23:50:01.21+00	05	type/Integer	\N	t	\N	t	0	5	118	05	normal	\N	\N	\N	\N	\N	\N	0
130	2017-11-12 21:38:38.739+00	2017-11-12 23:50:01.243+00	2014	type/Dictionary	\N	t	\N	t	0	5	117	2014	normal	\N	\N	\N	\N	\N	\N	0
132	2017-11-12 21:38:38.761+00	2017-11-12 23:50:01.277+00	06	type/Integer	\N	t	\N	t	0	5	130	06	normal	\N	\N	\N	\N	\N	\N	0
133	2017-11-12 21:38:38.773+00	2017-11-12 23:50:01.288+00	03	type/Integer	\N	t	\N	t	0	5	130	03	normal	\N	\N	\N	\N	\N	\N	0
134	2017-11-12 21:38:38.782+00	2017-11-12 23:50:01.299+00	11	type/Integer	\N	t	\N	t	0	5	130	11	normal	\N	\N	\N	\N	\N	\N	0
135	2017-11-12 21:38:38.794+00	2017-11-12 23:50:01.31+00	05	type/Integer	\N	t	\N	t	0	5	130	05	normal	\N	\N	\N	\N	\N	\N	0
136	2017-11-12 21:38:38.805+00	2017-11-12 23:50:01.321+00	08	type/Integer	\N	t	\N	t	0	5	130	08	normal	\N	\N	\N	\N	\N	\N	0
176	2017-11-12 21:38:39.341+00	2017-11-12 23:50:01.554+00	02	type/Integer	\N	t	\N	t	0	5	164	02	normal	\N	\N	\N	\N	\N	\N	0
69	2017-11-12 21:38:37.853+00	2017-11-12 23:50:02.328+00	04	type/Integer	\N	t	\N	t	0	5	62	04	normal	\N	\N	\N	\N	\N	\N	0
227	2017-11-12 21:38:39.97+00	2017-11-12 23:50:02.39+00	Festival	type/Integer	\N	t	\N	t	0	5	217	Festival	normal	\N	\N	\N	\N	\N	\N	0
259	2017-11-12 21:38:40.421+00	2017-11-12 23:50:02.716+00	Oficina	type/Integer	\N	t	\N	t	0	5	242	Oficina	normal	\N	\N	\N	\N	\N	\N	0
287	2017-11-12 21:38:44.966+00	2017-11-12 23:50:03.636+00	02	type/Integer	\N	t	\N	t	0	7	275	02	normal	\N	\N	\N	\N	\N	\N	0
286	2017-11-12 21:38:44.95+00	2017-11-12 23:50:03.646+00	01	type/Integer	\N	t	\N	t	0	7	275	01	normal	\N	\N	\N	\N	\N	\N	0
285	2017-11-12 21:38:44.941+00	2017-11-12 23:50:03.657+00	04	type/Integer	\N	t	\N	t	0	7	275	04	normal	\N	\N	\N	\N	\N	\N	0
284	2017-11-12 21:38:44.928+00	2017-11-12 23:50:03.668+00	12	type/Integer	\N	t	\N	t	0	7	275	12	normal	\N	\N	\N	\N	\N	\N	0
283	2017-11-12 21:38:44.918+00	2017-11-12 23:50:03.679+00	10	type/Integer	\N	t	\N	t	0	7	275	10	normal	\N	\N	\N	\N	\N	\N	0
282	2017-11-12 21:38:44.906+00	2017-11-12 23:50:03.69+00	07	type/Integer	\N	t	\N	t	0	7	275	07	normal	\N	\N	\N	\N	\N	\N	0
281	2017-11-12 21:38:44.895+00	2017-11-12 23:50:03.702+00	08	type/Integer	\N	t	\N	t	0	7	275	08	normal	\N	\N	\N	\N	\N	\N	0
280	2017-11-12 21:38:44.883+00	2017-11-12 23:50:03.713+00	05	type/Integer	\N	t	\N	t	0	7	275	05	normal	\N	\N	\N	\N	\N	\N	0
279	2017-11-12 21:38:44.872+00	2017-11-12 23:50:03.724+00	11	type/Integer	\N	t	\N	t	0	7	275	11	normal	\N	\N	\N	\N	\N	\N	0
278	2017-11-12 21:38:44.862+00	2017-11-12 23:50:03.735+00	03	type/Integer	\N	t	\N	t	0	7	275	03	normal	\N	\N	\N	\N	\N	\N	0
277	2017-11-12 21:38:44.85+00	2017-11-12 23:50:03.746+00	06	type/Integer	\N	t	\N	t	0	7	275	06	normal	\N	\N	\N	\N	\N	\N	0
276	2017-11-12 21:38:44.839+00	2017-11-12 23:50:03.757+00	09	type/Integer	\N	t	\N	t	0	7	275	09	normal	\N	\N	\N	\N	\N	\N	0
83	2017-11-12 21:38:38.065+00	2017-11-12 23:50:00.693+00	mapaculturacegovbr	type/Dictionary	\N	t	\N	t	0	5	35	Map A Cultura Ce Gov Br	normal	\N	\N	2017-11-12 21:38:54.891+00	\N	\N	{"global":{"distinct-count":2}}	1
91	2017-11-12 21:38:38.153+00	2017-11-12 23:50:00.703+00	2017	type/Dictionary	\N	t	\N	t	0	5	83	2017	normal	\N	\N	\N	\N	\N	\N	0
199	2017-11-12 21:38:39.634+00	2017-11-12 23:50:03.104+00	Exibição	type/Integer	\N	t	\N	t	0	5	192	Exibição	normal	\N	\N	\N	\N	\N	\N	0
200	2017-11-12 21:38:39.646+00	2017-11-12 23:50:03.115+00	Ciclo	type/Integer	\N	t	\N	t	0	5	192	Ci Clo	normal	\N	\N	\N	\N	\N	\N	0
201	2017-11-12 21:38:39.67+00	2017-11-12 23:50:03.126+00	Reunião	type/Integer	\N	t	\N	t	0	5	192	Reunião	normal	\N	\N	\N	\N	\N	\N	0
202	2017-11-12 21:38:39.679+00	2017-11-12 23:50:03.137+00	Festival	type/Integer	\N	t	\N	t	0	5	192	Festival	normal	\N	\N	\N	\N	\N	\N	0
203	2017-11-12 21:38:39.69+00	2017-11-12 23:50:03.148+00	Feira	type/Integer	\N	t	\N	t	0	5	192	Feira	normal	\N	\N	\N	\N	\N	\N	0
204	2017-11-12 21:38:39.701+00	2017-11-12 23:50:03.159+00	Jornada	type/Integer	\N	t	\N	t	0	5	192	Jorn Ada	normal	\N	\N	\N	\N	\N	\N	0
205	2017-11-12 21:38:39.713+00	2017-11-12 23:50:03.17+00	Intercâmbio Cultural	type/Integer	\N	t	\N	t	0	5	192	Intercâmbio Cultural	normal	\N	\N	\N	\N	\N	\N	0
206	2017-11-12 21:38:39.726+00	2017-11-12 23:50:03.192+00	Seminário	type/Integer	\N	t	\N	t	0	5	192	Seminário	normal	\N	\N	\N	\N	\N	\N	0
207	2017-11-12 21:38:39.735+00	2017-11-12 23:50:03.203+00	Oficina	type/Integer	\N	t	\N	t	0	5	192	Oficina	normal	\N	\N	\N	\N	\N	\N	0
208	2017-11-12 21:38:39.746+00	2017-11-12 23:50:03.214+00	Edital	type/Integer	\N	t	\N	t	0	5	192	Edit Al	normal	\N	\N	\N	\N	\N	\N	0
209	2017-11-12 21:38:39.757+00	2017-11-12 23:50:03.225+00	Encontro	type/Integer	\N	t	\N	t	0	5	192	Enc On Tro	normal	\N	\N	\N	\N	\N	\N	0
197	2017-11-12 21:38:39.613+00	2017-11-12 23:50:03.236+00	Curso	type/Integer	\N	t	\N	t	0	5	192	Cur So	normal	\N	\N	\N	\N	\N	\N	0
179	2017-11-12 21:38:39.393+00	2017-11-12 23:50:00.501+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	5	\N	ID	normal	\N	\N	\N	\N	\N	\N	0
254	2017-11-12 21:38:40.31+00	2017-11-12 23:50:02.927+00	Festival	type/Integer	\N	t	\N	t	0	5	242	Festival	normal	\N	\N	\N	\N	\N	\N	0
264	2017-11-12 21:38:40.477+00	2017-11-12 23:50:02.938+00	Programa	type/Integer	\N	t	\N	t	0	5	242	Program A	normal	\N	\N	\N	\N	\N	\N	0
256	2017-11-12 21:38:40.367+00	2017-11-12 23:50:02.948+00	Jornada	type/Integer	\N	t	\N	t	0	5	242	Jorn Ada	normal	\N	\N	\N	\N	\N	\N	0
180	2017-11-12 21:38:39.405+00	2017-11-12 23:50:00.534+00	_total_project	type/Integer	\N	t	\N	t	0	5	\N	Total Project	normal	\N	\N	\N	\N	\N	\N	0
177	2017-11-12 21:38:39.359+00	2017-11-12 23:50:00.545+00	_cls	type/Text	\N	t	\N	t	0	5	\N	Cls	normal	\N	\N	\N	\N	\N	\N	0
119	2017-11-12 21:38:38.552+00	2017-11-12 23:50:01.221+00	09	type/Integer	\N	t	\N	t	0	5	118	09	normal	\N	\N	\N	\N	\N	\N	0
137	2017-11-12 21:38:38.83+00	2017-11-12 23:50:01.332+00	07	type/Integer	\N	t	\N	t	0	5	130	07	normal	\N	\N	\N	\N	\N	\N	0
138	2017-11-12 21:38:38.839+00	2017-11-12 23:50:01.343+00	10	type/Integer	\N	t	\N	t	0	5	130	10	normal	\N	\N	\N	\N	\N	\N	0
139	2017-11-12 21:38:38.851+00	2017-11-12 23:50:01.354+00	12	type/Integer	\N	t	\N	t	0	5	130	12	normal	\N	\N	\N	\N	\N	\N	0
140	2017-11-12 21:38:38.86+00	2017-11-12 23:50:01.365+00	04	type/Integer	\N	t	\N	t	0	5	130	04	normal	\N	\N	\N	\N	\N	\N	0
141	2017-11-12 21:38:38.873+00	2017-11-12 23:50:01.376+00	01	type/Integer	\N	t	\N	t	0	5	130	01	normal	\N	\N	\N	\N	\N	\N	0
142	2017-11-12 21:38:38.888+00	2017-11-12 23:50:01.388+00	02	type/Integer	\N	t	\N	t	0	5	130	02	normal	\N	\N	\N	\N	\N	\N	0
152	2017-11-12 21:38:39.004+00	2017-11-12 23:50:01.399+00	2017	type/Dictionary	\N	t	\N	t	0	5	117	2017	normal	\N	\N	\N	\N	\N	\N	0
153	2017-11-12 21:38:39.015+00	2017-11-12 23:50:01.415+00	09	type/Integer	\N	t	\N	t	0	5	152	09	normal	\N	\N	\N	\N	\N	\N	0
154	2017-11-12 21:38:39.026+00	2017-11-12 23:50:01.432+00	06	type/Integer	\N	t	\N	t	0	5	152	06	normal	\N	\N	\N	\N	\N	\N	0
155	2017-11-12 21:38:39.037+00	2017-11-12 23:50:01.443+00	03	type/Integer	\N	t	\N	t	0	5	152	03	normal	\N	\N	\N	\N	\N	\N	0
156	2017-11-12 21:38:39.053+00	2017-11-12 23:50:01.454+00	11	type/Integer	\N	t	\N	t	0	5	152	11	normal	\N	\N	\N	\N	\N	\N	0
157	2017-11-12 21:38:39.071+00	2017-11-12 23:50:01.465+00	05	type/Integer	\N	t	\N	t	0	5	152	05	normal	\N	\N	\N	\N	\N	\N	0
158	2017-11-12 21:38:39.081+00	2017-11-12 23:50:01.476+00	08	type/Integer	\N	t	\N	t	0	5	152	08	normal	\N	\N	\N	\N	\N	\N	0
159	2017-11-12 21:38:39.094+00	2017-11-12 23:50:01.487+00	07	type/Integer	\N	t	\N	t	0	5	152	07	normal	\N	\N	\N	\N	\N	\N	0
160	2017-11-12 21:38:39.116+00	2017-11-12 23:50:01.498+00	10	type/Integer	\N	t	\N	t	0	5	152	10	normal	\N	\N	\N	\N	\N	\N	0
161	2017-11-12 21:38:39.128+00	2017-11-12 23:50:01.509+00	04	type/Integer	\N	t	\N	t	0	5	152	04	normal	\N	\N	\N	\N	\N	\N	0
162	2017-11-12 21:38:39.138+00	2017-11-12 23:50:01.52+00	01	type/Integer	\N	t	\N	t	0	5	152	01	normal	\N	\N	\N	\N	\N	\N	0
163	2017-11-12 21:38:39.149+00	2017-11-12 23:50:01.531+00	02	type/Integer	\N	t	\N	t	0	5	152	02	normal	\N	\N	\N	\N	\N	\N	0
164	2017-11-12 21:38:39.159+00	2017-11-12 23:50:01.542+00	2016	type/Dictionary	\N	t	\N	t	0	5	117	2016	normal	\N	\N	\N	\N	\N	\N	0
165	2017-11-12 21:38:39.17+00	2017-11-12 23:50:01.564+00	09	type/Integer	\N	t	\N	t	0	5	164	09	normal	\N	\N	\N	\N	\N	\N	0
166	2017-11-12 21:38:39.188+00	2017-11-12 23:50:01.575+00	06	type/Integer	\N	t	\N	t	0	5	164	06	normal	\N	\N	\N	\N	\N	\N	0
167	2017-11-12 21:38:39.21+00	2017-11-12 23:50:01.586+00	03	type/Integer	\N	t	\N	t	0	5	164	03	normal	\N	\N	\N	\N	\N	\N	0
169	2017-11-12 21:38:39.251+00	2017-11-12 23:50:01.597+00	05	type/Integer	\N	t	\N	t	0	5	164	05	normal	\N	\N	\N	\N	\N	\N	0
170	2017-11-12 21:38:39.271+00	2017-11-12 23:50:01.609+00	08	type/Integer	\N	t	\N	t	0	5	164	08	normal	\N	\N	\N	\N	\N	\N	0
171	2017-11-12 21:38:39.281+00	2017-11-12 23:50:01.62+00	07	type/Integer	\N	t	\N	t	0	5	164	07	normal	\N	\N	\N	\N	\N	\N	0
172	2017-11-12 21:38:39.292+00	2017-11-12 23:50:01.631+00	10	type/Integer	\N	t	\N	t	0	5	164	10	normal	\N	\N	\N	\N	\N	\N	0
173	2017-11-12 21:38:39.304+00	2017-11-12 23:50:01.642+00	12	type/Integer	\N	t	\N	t	0	5	164	12	normal	\N	\N	\N	\N	\N	\N	0
174	2017-11-12 21:38:39.315+00	2017-11-12 23:50:01.653+00	04	type/Integer	\N	t	\N	t	0	5	164	04	normal	\N	\N	\N	\N	\N	\N	0
175	2017-11-12 21:38:39.325+00	2017-11-12 23:50:01.664+00	01	type/Integer	\N	t	\N	t	0	5	164	01	normal	\N	\N	\N	\N	\N	\N	0
143	2017-11-12 21:38:38.905+00	2017-11-12 23:50:01.686+00	2013	type/Dictionary	\N	t	\N	t	0	5	117	2013	normal	\N	\N	\N	\N	\N	\N	0
144	2017-11-12 21:38:38.915+00	2017-11-12 23:50:01.7+00	09	type/Integer	\N	t	\N	t	0	5	143	09	normal	\N	\N	\N	\N	\N	\N	0
145	2017-11-12 21:38:38.927+00	2017-11-12 23:50:01.709+00	06	type/Integer	\N	t	\N	t	0	5	143	06	normal	\N	\N	\N	\N	\N	\N	0
146	2017-11-12 21:38:38.938+00	2017-11-12 23:50:01.719+00	11	type/Integer	\N	t	\N	t	0	5	143	11	normal	\N	\N	\N	\N	\N	\N	0
147	2017-11-12 21:38:38.949+00	2017-11-12 23:50:01.73+00	05	type/Integer	\N	t	\N	t	0	5	143	05	normal	\N	\N	\N	\N	\N	\N	0
148	2017-11-12 21:38:38.96+00	2017-11-12 23:50:01.742+00	08	type/Integer	\N	t	\N	t	0	5	143	08	normal	\N	\N	\N	\N	\N	\N	0
150	2017-11-12 21:38:38.983+00	2017-11-12 23:50:01.753+00	10	type/Integer	\N	t	\N	t	0	5	143	10	normal	\N	\N	\N	\N	\N	\N	0
151	2017-11-12 21:38:38.995+00	2017-11-12 23:50:01.764+00	12	type/Integer	\N	t	\N	t	0	5	143	12	normal	\N	\N	\N	\N	\N	\N	0
149	2017-11-12 21:38:38.972+00	2017-11-12 23:50:01.775+00	07	type/Integer	\N	t	\N	t	0	5	143	07	normal	\N	\N	\N	\N	\N	\N	0
243	2017-11-12 21:38:40.156+00	2017-11-12 23:50:02.915+00	Festa Religiosa	type/Integer	\N	t	\N	t	0	5	242	Festa Religiosa	normal	\N	\N	\N	\N	\N	\N	0
183	2017-11-12 21:38:39.438+00	2017-11-12 23:50:00.592+00	True	type/Integer	\N	t	\N	t	0	5	182	True	normal	\N	\N	\N	\N	\N	\N	0
184	2017-11-12 21:38:39.448+00	2017-11-12 23:50:00.601+00	False	type/Integer	\N	t	\N	t	0	5	182	False	normal	\N	\N	\N	\N	\N	\N	0
188	2017-11-12 21:38:39.493+00	2017-11-12 23:50:00.612+00	mapaculturacegovbr	type/Dictionary	\N	t	\N	t	0	5	181	Map A Cultura Ce Gov Br	normal	\N	\N	\N	\N	\N	\N	0
189	2017-11-12 21:38:39.504+00	2017-11-12 23:50:00.625+00	True	type/Integer	\N	t	\N	t	0	5	188	True	normal	\N	\N	\N	\N	\N	\N	0
190	2017-11-12 21:38:39.515+00	2017-11-12 23:50:00.634+00	False	type/Integer	\N	t	\N	t	0	5	188	False	normal	\N	\N	\N	\N	\N	\N	0
186	2017-11-12 21:38:39.47+00	2017-11-12 23:50:00.659+00	True	type/Integer	\N	t	\N	t	0	5	185	True	normal	\N	\N	\N	\N	\N	\N	0
187	2017-11-12 21:38:39.481+00	2017-11-12 23:50:00.667+00	False	type/Integer	\N	t	\N	t	0	5	185	False	normal	\N	\N	\N	\N	\N	\N	0
103	2017-11-12 21:38:38.31+00	2017-11-12 23:50:00.955+00	2016	type/Dictionary	\N	t	\N	t	0	5	83	2016	normal	\N	\N	\N	\N	\N	\N	0
198	2017-11-12 21:38:39.624+00	2017-11-12 23:50:03.093+00	Inscrições	type/Integer	\N	t	\N	t	0	5	192	Inscrições	normal	\N	\N	\N	\N	\N	\N	0
182	2017-11-12 21:38:39.427+00	2017-11-12 23:50:00.571+00	mapasculturagovbr	type/Dictionary	\N	t	\N	t	0	5	181	Map As Cultura Gov Br	normal	\N	\N	\N	\N	\N	\N	0
212	2017-11-12 21:38:39.79+00	2017-11-12 23:50:03.259+00	Programa	type/Integer	\N	t	\N	t	0	5	192	Program A	normal	\N	\N	\N	\N	\N	\N	0
213	2017-11-12 21:38:39.801+00	2017-11-12 23:50:03.271+00	Fórum	type/Integer	\N	t	\N	t	0	5	192	Fórum	normal	\N	\N	\N	\N	\N	\N	0
214	2017-11-12 21:38:39.812+00	2017-11-12 23:50:03.292+00	Sarau	type/Integer	\N	t	\N	t	0	5	192	Sara U	normal	\N	\N	\N	\N	\N	\N	0
195	2017-11-12 21:38:39.591+00	2017-11-12 23:50:03.303+00	Palestra	type/Integer	\N	t	\N	t	0	5	192	Palestra	normal	\N	\N	\N	\N	\N	\N	0
210	2017-11-12 21:38:39.768+00	2017-11-12 23:50:03.325+00	Simpósio	type/Integer	\N	t	\N	t	0	5	192	Simpósio	normal	\N	\N	\N	\N	\N	\N	0
303	2017-11-12 21:38:45.194+00	2017-11-12 23:50:03.484+00	08	type/Integer	\N	t	\N	t	0	7	297	08	normal	\N	\N	\N	\N	\N	\N	0
231	2017-11-12 21:38:40.012+00	2017-11-12 23:50:02.417+00	Seminário	type/Integer	\N	t	\N	t	0	5	217	Seminário	normal	\N	\N	\N	\N	\N	\N	0
232	2017-11-12 21:38:40.023+00	2017-11-12 23:50:02.428+00	Oficina	type/Integer	\N	t	\N	t	0	5	217	Oficina	normal	\N	\N	\N	\N	\N	\N	0
233	2017-11-12 21:38:40.035+00	2017-11-12 23:50:02.439+00	Edital	type/Integer	\N	t	\N	t	0	5	217	Edit Al	normal	\N	\N	\N	\N	\N	\N	0
235	2017-11-12 21:38:40.056+00	2017-11-12 23:50:02.45+00	Encontro	type/Integer	\N	t	\N	t	0	5	217	Enc On Tro	normal	\N	\N	\N	\N	\N	\N	0
237	2017-11-12 21:38:40.078+00	2017-11-12 23:50:02.461+00	Programa	type/Integer	\N	t	\N	t	0	5	217	Program A	normal	\N	\N	\N	\N	\N	\N	0
238	2017-11-12 21:38:40.089+00	2017-11-12 23:50:02.473+00	Fórum	type/Integer	\N	t	\N	t	0	5	217	Fórum	normal	\N	\N	\N	\N	\N	\N	0
239	2017-11-12 21:38:40.101+00	2017-11-12 23:50:02.484+00	Sarau	type/Integer	\N	t	\N	t	0	5	217	Sara U	normal	\N	\N	\N	\N	\N	\N	0
240	2017-11-12 21:38:40.124+00	2017-11-12 23:50:02.495+00	Exposição	type/Integer	\N	t	\N	t	0	5	217	Exposição	normal	\N	\N	\N	\N	\N	\N	0
241	2017-11-12 21:38:40.133+00	2017-11-12 23:50:02.506+00	Mostra	type/Integer	\N	t	\N	t	0	5	217	Most Ra	normal	\N	\N	\N	\N	\N	\N	0
236	2017-11-12 21:38:40.067+00	2017-11-12 23:50:02.517+00	Concurso	type/Integer	\N	t	\N	t	0	5	217	Concur So	normal	\N	\N	\N	\N	\N	\N	0
218	2017-11-12 21:38:39.858+00	2017-11-12 23:50:02.528+00	Festa Religiosa	type/Integer	\N	t	\N	t	0	5	217	Festa Religiosa	normal	\N	\N	\N	\N	\N	\N	0
219	2017-11-12 21:38:39.868+00	2017-11-12 23:50:02.539+00	Festa Popular	type/Integer	\N	t	\N	t	0	5	217	Festa Popular	normal	\N	\N	\N	\N	\N	\N	0
221	2017-11-12 21:38:39.891+00	2017-11-12 23:50:02.55+00	Conferência Pública Municipal	type/Integer	\N	t	\N	t	0	5	217	Conferência Pública Municipal	normal	\N	\N	\N	\N	\N	\N	0
222	2017-11-12 21:38:39.901+00	2017-11-12 23:50:02.561+00	Palestra	type/Integer	\N	t	\N	t	0	5	217	Palestra	normal	\N	\N	\N	\N	\N	\N	0
223	2017-11-12 21:38:39.912+00	2017-11-12 23:50:02.572+00	Curso	type/Integer	\N	t	\N	t	0	5	217	Cur So	normal	\N	\N	\N	\N	\N	\N	0
224	2017-11-12 21:38:39.923+00	2017-11-12 23:50:02.583+00	Inscrições	type/Integer	\N	t	\N	t	0	5	217	Inscrições	normal	\N	\N	\N	\N	\N	\N	0
225	2017-11-12 21:38:39.935+00	2017-11-12 23:50:02.594+00	Exibição	type/Integer	\N	t	\N	t	0	5	217	Exibição	normal	\N	\N	\N	\N	\N	\N	0
226	2017-11-12 21:38:39.956+00	2017-11-12 23:50:02.605+00	Ciclo	type/Integer	\N	t	\N	t	0	5	217	Ci Clo	normal	\N	\N	\N	\N	\N	\N	0
228	2017-11-12 21:38:39.979+00	2017-11-12 23:50:02.616+00	Feira	type/Integer	\N	t	\N	t	0	5	217	Feira	normal	\N	\N	\N	\N	\N	\N	0
211	2017-11-12 21:38:39.78+00	2017-11-12 23:50:03.248+00	Concurso	type/Integer	\N	t	\N	t	0	5	192	Concur So	normal	\N	\N	\N	\N	\N	\N	0
273	2017-11-12 21:38:44.789+00	2017-11-12 23:50:03.44+00	_create_date	type/Text	\N	t	\N	t	0	7	\N	Create Date	normal	\N	\N	\N	\N	\N	\N	0
262	2017-11-12 21:38:40.454+00	2017-11-12 23:50:02.959+00	Encontro	type/Integer	\N	t	\N	t	0	5	242	Enc On Tro	normal	\N	\N	\N	\N	\N	\N	0
309	2017-11-12 21:38:45.315+00	2017-11-12 23:50:03.502+00	02	type/Integer	\N	t	\N	t	0	7	297	02	normal	\N	\N	\N	\N	\N	\N	0
307	2017-11-12 21:38:45.26+00	2017-11-12 23:50:03.513+00	04	type/Integer	\N	t	\N	t	0	7	297	04	normal	\N	\N	\N	\N	\N	\N	0
306	2017-11-12 21:38:45.249+00	2017-11-12 23:50:03.524+00	12	type/Integer	\N	t	\N	t	0	7	297	12	normal	\N	\N	\N	\N	\N	\N	0
305	2017-11-12 21:38:45.237+00	2017-11-12 23:50:03.535+00	10	type/Integer	\N	t	\N	t	0	7	297	10	normal	\N	\N	\N	\N	\N	\N	0
304	2017-11-12 21:38:45.216+00	2017-11-12 23:50:03.546+00	07	type/Integer	\N	t	\N	t	0	7	297	07	normal	\N	\N	\N	\N	\N	\N	0
301	2017-11-12 21:38:45.171+00	2017-11-12 23:50:03.557+00	11	type/Integer	\N	t	\N	t	0	7	297	11	normal	\N	\N	\N	\N	\N	\N	0
302	2017-11-12 21:38:45.184+00	2017-11-12 23:50:03.568+00	05	type/Integer	\N	t	\N	t	0	7	297	05	normal	\N	\N	\N	\N	\N	\N	0
300	2017-11-12 21:38:45.16+00	2017-11-12 23:50:03.579+00	03	type/Integer	\N	t	\N	t	0	7	297	03	normal	\N	\N	\N	\N	\N	\N	0
299	2017-11-12 21:38:45.122+00	2017-11-12 23:50:03.59+00	06	type/Integer	\N	t	\N	t	0	7	297	06	normal	\N	\N	\N	\N	\N	\N	0
298	2017-11-12 21:38:45.104+00	2017-11-12 23:50:03.601+00	09	type/Integer	\N	t	\N	t	0	7	297	09	normal	\N	\N	\N	\N	\N	\N	0
288	2017-11-12 21:38:44.983+00	2017-11-12 23:50:03.768+00	2013	type/Dictionary	\N	t	\N	t	0	7	274	2013	normal	\N	\N	\N	\N	\N	\N	0
296	2017-11-12 21:38:45.082+00	2017-11-12 23:50:03.782+00	12	type/Integer	\N	t	\N	t	0	7	288	12	normal	\N	\N	\N	\N	\N	\N	0
295	2017-11-12 21:38:45.071+00	2017-11-12 23:50:03.79+00	10	type/Integer	\N	t	\N	t	0	7	288	10	normal	\N	\N	\N	\N	\N	\N	0
294	2017-11-12 21:38:45.061+00	2017-11-12 23:50:03.801+00	07	type/Integer	\N	t	\N	t	0	7	288	07	normal	\N	\N	\N	\N	\N	\N	0
293	2017-11-12 21:38:45.05+00	2017-11-12 23:50:03.812+00	08	type/Integer	\N	t	\N	t	0	7	288	08	normal	\N	\N	\N	\N	\N	\N	0
292	2017-11-12 21:38:45.028+00	2017-11-12 23:50:03.823+00	05	type/Integer	\N	t	\N	t	0	7	288	05	normal	\N	\N	\N	\N	\N	\N	0
291	2017-11-12 21:38:45.017+00	2017-11-12 23:50:03.834+00	11	type/Integer	\N	t	\N	t	0	7	288	11	normal	\N	\N	\N	\N	\N	\N	0
290	2017-11-12 21:38:45.006+00	2017-11-12 23:50:03.845+00	06	type/Integer	\N	t	\N	t	0	7	288	06	normal	\N	\N	\N	\N	\N	\N	0
289	2017-11-12 21:38:44.994+00	2017-11-12 23:50:03.856+00	09	type/Integer	\N	t	\N	t	0	7	288	09	normal	\N	\N	\N	\N	\N	\N	0
310	2017-11-12 21:38:45.327+00	2017-11-12 23:50:03.868+00	2017	type/Dictionary	\N	t	\N	t	0	7	274	2017	normal	\N	\N	\N	\N	\N	\N	0
318	2017-11-12 21:38:45.415+00	2017-11-12 23:50:03.883+00	10	type/Integer	\N	t	\N	t	0	7	310	10	normal	\N	\N	\N	\N	\N	\N	0
317	2017-11-12 21:38:45.403+00	2017-11-12 23:50:03.89+00	07	type/Integer	\N	t	\N	t	0	7	310	07	normal	\N	\N	\N	\N	\N	\N	0
316	2017-11-12 21:38:45.393+00	2017-11-12 23:50:03.901+00	08	type/Integer	\N	t	\N	t	0	7	310	08	normal	\N	\N	\N	\N	\N	\N	0
315	2017-11-12 21:38:45.382+00	2017-11-12 23:50:03.912+00	05	type/Integer	\N	t	\N	t	0	7	310	05	normal	\N	\N	\N	\N	\N	\N	0
314	2017-11-12 21:38:45.371+00	2017-11-12 23:50:03.924+00	11	type/Integer	\N	t	\N	t	0	7	310	11	normal	\N	\N	\N	\N	\N	\N	0
313	2017-11-12 21:38:45.36+00	2017-11-12 23:50:03.934+00	03	type/Integer	\N	t	\N	t	0	7	310	03	normal	\N	\N	\N	\N	\N	\N	0
312	2017-11-12 21:38:45.349+00	2017-11-12 23:50:03.945+00	06	type/Integer	\N	t	\N	t	0	7	310	06	normal	\N	\N	\N	\N	\N	\N	0
319	2017-11-12 21:38:45.426+00	2017-11-12 23:50:03.956+00	04	type/Integer	\N	t	\N	t	0	7	310	04	normal	\N	\N	\N	\N	\N	\N	0
311	2017-11-12 21:38:45.338+00	2017-11-12 23:50:03.967+00	09	type/Integer	\N	t	\N	t	0	7	310	09	normal	\N	\N	\N	\N	\N	\N	0
321	2017-11-12 21:38:45.512+00	2017-11-12 23:50:03.978+00	02	type/Integer	\N	t	\N	t	0	7	310	02	normal	\N	\N	\N	\N	\N	\N	0
320	2017-11-12 21:38:45.448+00	2017-11-12 23:50:03.989+00	01	type/Integer	\N	t	\N	t	0	7	310	01	normal	\N	\N	\N	\N	\N	\N	0
362	2017-11-12 21:38:47.176+00	2017-11-12 23:50:04.544+00	arte digital	type/Integer	\N	t	\N	t	0	8	337	Arte Digital	normal	\N	\N	\N	\N	\N	\N	0
361	2017-11-12 21:38:47.165+00	2017-11-12 23:50:04.554+00	Circo	type/Integer	\N	t	\N	t	0	8	337	Circo	normal	\N	\N	\N	\N	\N	\N	0
357	2017-11-12 21:38:47.098+00	2017-11-12 23:50:09.652+00	museu	type/Integer	type/Category	t	\N	t	0	8	337	Muse U	normal	\N	\N	2017-11-12 23:50:09.691+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":27718,"avg":18478.666666666668}}}	1
99	2017-11-12 21:38:38.253+00	2017-11-12 23:50:00.745+00	10	type/Integer	\N	t	\N	t	0	5	91	10	normal	\N	\N	\N	\N	\N	\N	0
230	2017-11-12 21:38:40.001+00	2017-11-12 23:50:02.406+00	Intercâmbio Cultural	type/Integer	\N	t	\N	t	0	5	217	Intercâmbio Cultural	normal	\N	\N	\N	\N	\N	\N	0
331	2017-11-12 21:38:45.708+00	2017-11-12 23:50:04.022+00	12	type/Integer	\N	t	\N	t	0	7	322	12	normal	\N	\N	\N	\N	\N	\N	0
330	2017-11-12 21:38:45.692+00	2017-11-12 23:50:04.033+00	10	type/Integer	\N	t	\N	t	0	7	322	10	normal	\N	\N	\N	\N	\N	\N	0
328	2017-11-12 21:38:45.648+00	2017-11-12 23:50:04.044+00	08	type/Integer	\N	t	\N	t	0	7	322	08	normal	\N	\N	\N	\N	\N	\N	0
327	2017-11-12 21:38:45.636+00	2017-11-12 23:50:04.055+00	05	type/Integer	\N	t	\N	t	0	7	322	05	normal	\N	\N	\N	\N	\N	\N	0
334	2017-11-12 21:38:45.76+00	2017-11-12 23:50:04.067+00	02	type/Integer	\N	t	\N	t	0	7	322	02	normal	\N	\N	\N	\N	\N	\N	0
333	2017-11-12 21:38:45.748+00	2017-11-12 23:50:04.078+00	01	type/Integer	\N	t	\N	t	0	7	322	01	normal	\N	\N	\N	\N	\N	\N	0
329	2017-11-12 21:38:45.67+00	2017-11-12 23:50:04.089+00	07	type/Integer	\N	t	\N	t	0	7	322	07	normal	\N	\N	\N	\N	\N	\N	0
326	2017-11-12 21:38:45.625+00	2017-11-12 23:50:04.1+00	11	type/Integer	\N	t	\N	t	0	7	322	11	normal	\N	\N	\N	\N	\N	\N	0
325	2017-11-12 21:38:45.615+00	2017-11-12 23:50:04.111+00	03	type/Integer	\N	t	\N	t	0	7	322	03	normal	\N	\N	\N	\N	\N	\N	0
324	2017-11-12 21:38:45.603+00	2017-11-12 23:50:04.124+00	06	type/Integer	\N	t	\N	t	0	7	322	06	normal	\N	\N	\N	\N	\N	\N	0
323	2017-11-12 21:38:45.581+00	2017-11-12 23:50:04.133+00	09	type/Integer	\N	t	\N	t	0	7	322	09	normal	\N	\N	\N	\N	\N	\N	0
476	2017-11-12 21:38:49.023+00	2017-11-12 23:50:09.547+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	8	\N	ID	normal	\N	\N	2017-11-12 23:50:09.691+00	\N	\N	{"global":{"distinct-count":3}}	1
475	2017-11-12 21:38:49.015+00	2017-11-12 23:50:04.454+00	_total_individual_agent	type/Integer	\N	t	\N	t	0	8	\N	Total Individual Agent	normal	\N	\N	\N	\N	\N	\N	0
472	2017-11-12 21:38:48.973+00	2017-11-12 23:50:04.488+00	_total_collective_agent	type/Integer	\N	t	\N	t	0	8	\N	Total Collective Agent	normal	\N	\N	\N	\N	\N	\N	0
336	2017-11-12 21:38:46.613+00	2017-11-12 23:50:04.502+00	_total_agents	type/Integer	\N	t	\N	t	0	8	\N	Total Agents	normal	\N	\N	\N	\N	\N	\N	0
352	2017-11-12 21:38:46.949+00	2017-11-12 23:50:04.576+00	cultura digital	type/Integer	\N	t	\N	t	0	8	337	Cultura Digital	normal	\N	\N	\N	\N	\N	\N	0
351	2017-11-12 21:38:46.899+00	2017-11-12 23:50:04.587+00	livro	type/Integer	\N	t	\N	t	0	8	337	Liv Ro	normal	\N	\N	\N	\N	\N	\N	0
350	2017-11-12 21:38:46.878+00	2017-11-12 23:50:04.598+00	patrimônio imaterial	type/Integer	\N	t	\N	t	0	8	337	Patrimônio I Material	normal	\N	\N	\N	\N	\N	\N	0
349	2017-11-12 21:38:46.866+00	2017-11-12 23:50:04.61+00	comunicação	type/Integer	\N	t	\N	t	0	8	337	Comunicação	normal	\N	\N	\N	\N	\N	\N	0
348	2017-11-12 21:38:46.833+00	2017-11-12 23:50:04.62+00	gestão cultural	type/Integer	\N	t	\N	t	0	8	337	Gestão Cultural	normal	\N	\N	\N	\N	\N	\N	0
347	2017-11-12 21:38:46.811+00	2017-11-12 23:50:04.631+00	artes visuais	type/Integer	\N	t	\N	t	0	8	337	Artes Vi Sua Is	normal	\N	\N	\N	\N	\N	\N	0
346	2017-11-12 21:38:46.799+00	2017-11-12 23:50:04.642+00	cultura indígena	type/Integer	\N	t	\N	t	0	8	337	Cultura Indígena	normal	\N	\N	\N	\N	\N	\N	0
345	2017-11-12 21:38:46.778+00	2017-11-12 23:50:04.654+00	circo	type/Integer	\N	t	\N	t	0	8	337	Circo	normal	\N	\N	\N	\N	\N	\N	0
344	2017-11-12 21:38:46.738+00	2017-11-12 23:50:04.665+00	Esporte	type/Integer	\N	t	\N	t	0	8	337	Esporte	normal	\N	\N	\N	\N	\N	\N	0
343	2017-11-12 21:38:46.711+00	2017-11-12 23:50:04.676+00	cultura lgbt	type/Integer	\N	t	\N	t	0	8	337	Cultura Lgbt	normal	\N	\N	\N	\N	\N	\N	0
342	2017-11-12 21:38:46.7+00	2017-11-12 23:50:04.687+00	Cultura Digital	type/Integer	\N	t	\N	t	0	8	337	Cultura Digital	normal	\N	\N	\N	\N	\N	\N	0
340	2017-11-12 21:38:46.666+00	2017-11-12 23:50:04.698+00	Moda	type/Integer	\N	t	\N	t	0	8	337	Moda	normal	\N	\N	\N	\N	\N	\N	0
339	2017-11-12 21:38:46.656+00	2017-11-12 23:50:04.709+00	cultura popular	type/Integer	\N	t	\N	t	0	8	337	Cultura Popular	normal	\N	\N	\N	\N	\N	\N	0
436	2017-11-12 21:38:48.515+00	2017-11-12 23:50:04.72+00	Arqueologia	type/Integer	\N	t	\N	t	0	8	337	Ar Que O Logia	normal	\N	\N	\N	\N	\N	\N	0
432	2017-11-12 21:38:48.448+00	2017-11-12 23:50:04.731+00	agroecologia	type/Integer	\N	t	\N	t	0	8	337	A Gro Eco Logia	normal	\N	\N	\N	\N	\N	\N	0
431	2017-11-12 21:38:48.438+00	2017-11-12 23:50:04.742+00	Fotografia	type/Integer	\N	t	\N	t	0	8	337	Fotogr A Fia	normal	\N	\N	\N	\N	\N	\N	0
428	2017-11-12 21:38:48.403+00	2017-11-12 23:50:04.754+00	dança e canto coral	type/Integer	\N	t	\N	t	0	8	337	Dança E Can To Coral	normal	\N	\N	\N	\N	\N	\N	0
427	2017-11-12 21:38:48.393+00	2017-11-12 23:50:04.764+00	Carnaval	type/Integer	\N	t	\N	t	0	8	337	Carnaval	normal	\N	\N	\N	\N	\N	\N	0
420	2017-11-12 21:38:48.263+00	2017-11-12 23:50:04.776+00	Rádio	type/Integer	\N	t	\N	t	0	8	337	Rádio	normal	\N	\N	\N	\N	\N	\N	0
419	2017-11-12 21:38:48.241+00	2017-11-12 23:50:04.787+00	televisão	type/Integer	\N	t	\N	t	0	8	337	Televisão	normal	\N	\N	\N	\N	\N	\N	0
418	2017-11-12 21:38:48.217+00	2017-11-12 23:50:04.798+00	Jornalismo	type/Integer	\N	t	\N	t	0	8	337	Jorn Al Is Mo	normal	\N	\N	\N	\N	\N	\N	0
417	2017-11-12 21:38:48.205+00	2017-11-12 23:50:04.809+00	Antropologia	type/Integer	\N	t	\N	t	0	8	337	An Tro Polo Gia	normal	\N	\N	\N	\N	\N	\N	0
416	2017-11-12 21:38:48.196+00	2017-11-12 23:50:04.82+00	dança	type/Integer	\N	t	\N	t	0	8	337	Dança	normal	\N	\N	\N	\N	\N	\N	0
414	2017-11-12 21:38:48.172+00	2017-11-12 23:50:04.831+00	Música	type/Integer	\N	t	\N	t	0	8	337	Música	normal	\N	\N	\N	\N	\N	\N	0
413	2017-11-12 21:38:48.152+00	2017-11-12 23:50:04.842+00	literatura	type/Integer	\N	t	\N	t	0	8	337	Literatura	normal	\N	\N	\N	\N	\N	\N	0
412	2017-11-12 21:38:48.131+00	2017-11-12 23:50:04.853+00	agentes	type/Integer	\N	t	\N	t	0	8	337	Agent Es	normal	\N	\N	\N	\N	\N	\N	0
411	2017-11-12 21:38:48.11+00	2017-11-12 23:50:04.864+00	Comunicação	type/Integer	\N	t	\N	t	0	8	337	Comunicação	normal	\N	\N	\N	\N	\N	\N	0
410	2017-11-12 21:38:48.085+00	2017-11-12 23:50:04.875+00	cultura negra	type/Integer	\N	t	\N	t	0	8	337	Cultura Negra	normal	\N	\N	\N	\N	\N	\N	0
409	2017-11-12 21:38:48.055+00	2017-11-12 23:50:04.886+00	Patrimônio Material	type/Integer	\N	t	\N	t	0	8	337	Patrimônio Material	normal	\N	\N	\N	\N	\N	\N	0
408	2017-11-12 21:38:48+00	2017-11-12 23:50:04.897+00	jogos eletrônicos	type/Integer	\N	t	\N	t	0	8	337	Jog Os Eletrônicos	normal	\N	\N	\N	\N	\N	\N	0
471	2017-11-12 21:38:48.949+00	2017-11-12 23:50:04.908+00	Dança	type/Integer	\N	t	\N	t	0	8	337	Dança	normal	\N	\N	\N	\N	\N	\N	0
470	2017-11-12 21:38:48.928+00	2017-11-12 23:50:04.919+00	Artes Visuais	type/Integer	\N	t	\N	t	0	8	337	Artes Vi Sua Is	normal	\N	\N	\N	\N	\N	\N	0
468	2017-11-12 21:38:48.902+00	2017-11-12 23:50:04.93+00	cultura cigana	type/Integer	\N	t	\N	t	0	8	337	Cultura Cig An A	normal	\N	\N	\N	\N	\N	\N	0
467	2017-11-12 21:38:48.891+00	2017-11-12 23:50:04.941+00	arqueologia	type/Integer	\N	t	\N	t	0	8	337	Ar Que O Logia	normal	\N	\N	\N	\N	\N	\N	0
466	2017-11-12 21:38:48.881+00	2017-11-12 23:50:04.953+00	Orquestra	type/Integer	\N	t	\N	t	0	8	337	Or Quest Ra	normal	\N	\N	\N	\N	\N	\N	0
465	2017-11-12 21:38:48.869+00	2017-11-12 23:50:04.964+00	teatro estudantil	type/Integer	\N	t	\N	t	0	8	337	Teatro Est Ud An Til	normal	\N	\N	\N	\N	\N	\N	0
464	2017-11-12 21:38:48.858+00	2017-11-12 23:50:04.975+00	Outros	type/Integer	\N	t	\N	t	0	8	337	Out Ros	normal	\N	\N	\N	\N	\N	\N	0
463	2017-11-12 21:38:48.847+00	2017-11-12 23:50:04.986+00	Pesquisa	type/Integer	\N	t	\N	t	0	8	337	Pes Quis A	normal	\N	\N	\N	\N	\N	\N	0
462	2017-11-12 21:38:48.835+00	2017-11-12 23:50:04.997+00	patrimônio material	type/Integer	\N	t	\N	t	0	8	337	Patrimônio Material	normal	\N	\N	\N	\N	\N	\N	0
461	2017-11-12 21:38:48.824+00	2017-11-12 23:50:05.008+00	audiovisual	type/Integer	\N	t	\N	t	0	8	337	Audiovisual	normal	\N	\N	\N	\N	\N	\N	0
459	2017-11-12 21:38:48.797+00	2017-11-12 23:50:05.019+00	artesanato	type/Integer	\N	t	\N	t	0	8	337	Artes An A To	normal	\N	\N	\N	\N	\N	\N	0
458	2017-11-12 21:38:48.781+00	2017-11-12 23:50:05.03+00	arquivo	type/Integer	\N	t	\N	t	0	8	337	Ar Qui Vo	normal	\N	\N	\N	\N	\N	\N	0
217	2017-11-12 21:38:39.846+00	2017-11-12 23:50:02.367+00	mapaculturacegovbr	type/Dictionary	\N	t	\N	t	0	5	191	Map A Cultura Ce Gov Br	normal	\N	\N	\N	\N	\N	\N	0
332	2017-11-12 21:38:45.727+00	2017-11-12 23:50:04.013+00	04	type/Integer	\N	t	\N	t	0	7	322	04	normal	\N	\N	\N	\N	\N	\N	0
441	2017-11-12 21:38:48.582+00	2017-11-12 23:50:05.074+00	fabricação de obras de arte	type/Integer	\N	t	\N	t	0	8	337	Fabricação De Obras De Arte	normal	\N	\N	\N	\N	\N	\N	0
354	2017-11-12 21:38:47.043+00	2017-11-12 23:50:05.086+00	Cinema	type/Integer	\N	t	\N	t	0	8	337	Cinema	normal	\N	\N	\N	\N	\N	\N	0
437	2017-11-12 21:38:48.539+00	2017-11-12 23:50:05.103+00	Literatura	type/Integer	\N	t	\N	t	0	8	337	Literatura	normal	\N	\N	\N	\N	\N	\N	0
439	2017-11-12 21:38:48.559+00	2017-11-12 23:50:05.119+00	rádio	type/Integer	\N	t	\N	t	0	8	337	Rádio	normal	\N	\N	\N	\N	\N	\N	0
433	2017-11-12 21:38:48.46+00	2017-11-12 23:50:05.13+00	Arquitetura-Urbanismo	type/Integer	\N	t	\N	t	0	8	337	Ar Quite Tura Urbanism O	normal	\N	\N	\N	\N	\N	\N	0
430	2017-11-12 21:38:48.427+00	2017-11-12 23:50:05.141+00	Sociologia	type/Integer	\N	t	\N	t	0	8	337	Socio Logia	normal	\N	\N	\N	\N	\N	\N	0
429	2017-11-12 21:38:48.415+00	2017-11-12 23:50:05.152+00	turismo	type/Integer	\N	t	\N	t	0	8	337	Turismo	normal	\N	\N	\N	\N	\N	\N	0
426	2017-11-12 21:38:48.382+00	2017-11-12 23:50:05.163+00	Gestor Publico de Cultura	type/Integer	\N	t	\N	t	0	8	337	Ge Stor Public O De Cultura	normal	\N	\N	\N	\N	\N	\N	0
425	2017-11-12 21:38:48.361+00	2017-11-12 23:50:05.174+00	esporte	type/Integer	\N	t	\N	t	0	8	337	Esporte	normal	\N	\N	\N	\N	\N	\N	0
424	2017-11-12 21:38:48.339+00	2017-11-12 23:50:05.185+00	Turismo	type/Integer	\N	t	\N	t	0	8	337	Turismo	normal	\N	\N	\N	\N	\N	\N	0
423	2017-11-12 21:38:48.318+00	2017-11-12 23:50:05.196+00	danca	type/Integer	\N	t	\N	t	0	8	337	Dan Ca	normal	\N	\N	\N	\N	\N	\N	0
407	2017-11-12 21:38:47.974+00	2017-11-12 23:50:05.207+00	Direito Autoral	type/Integer	\N	t	\N	t	0	8	337	Dire I To Aut Oral	normal	\N	\N	\N	\N	\N	\N	0
406	2017-11-12 21:38:47.962+00	2017-11-12 23:50:05.218+00	leitura	type/Integer	\N	t	\N	t	0	8	337	Lei Tura	normal	\N	\N	\N	\N	\N	\N	0
405	2017-11-12 21:38:47.95+00	2017-11-12 23:50:05.23+00	Audiovisual	type/Integer	\N	t	\N	t	0	8	337	Audiovisual	normal	\N	\N	\N	\N	\N	\N	0
404	2017-11-12 21:38:47.939+00	2017-11-12 23:50:05.241+00	intercâmbio cultural	type/Integer	\N	t	\N	t	0	8	337	Intercâmbio Cultural	normal	\N	\N	\N	\N	\N	\N	0
403	2017-11-12 21:38:47.928+00	2017-11-12 23:50:05.252+00	Jogos Eletrônicos	type/Integer	\N	t	\N	t	0	8	337	Jog Os Eletrônicos	normal	\N	\N	\N	\N	\N	\N	0
402	2017-11-12 21:38:47.896+00	2017-11-12 23:50:05.263+00	Cultura Cigana	type/Integer	\N	t	\N	t	0	8	337	Cultura Cig An A	normal	\N	\N	\N	\N	\N	\N	0
401	2017-11-12 21:38:47.806+00	2017-11-12 23:50:05.274+00	economia criativa	type/Integer	\N	t	\N	t	0	8	337	Eco No Mia Cri At Iva	normal	\N	\N	\N	\N	\N	\N	0
400	2017-11-12 21:38:47.795+00	2017-11-12 23:50:05.285+00	exposições	type/Integer	\N	t	\N	t	0	8	337	Exposições	normal	\N	\N	\N	\N	\N	\N	0
399	2017-11-12 21:38:47.784+00	2017-11-12 23:50:05.296+00	Cultura LGBT	type/Integer	\N	t	\N	t	0	8	337	Cultura Lgbt	normal	\N	\N	\N	\N	\N	\N	0
398	2017-11-12 21:38:47.762+00	2017-11-12 23:50:05.307+00	Novas Mídias	type/Integer	\N	t	\N	t	0	8	337	Novas Mídias	normal	\N	\N	\N	\N	\N	\N	0
397	2017-11-12 21:38:47.739+00	2017-11-12 23:50:05.318+00	marchetaria	type/Integer	\N	t	\N	t	0	8	337	March Et Aria	normal	\N	\N	\N	\N	\N	\N	0
396	2017-11-12 21:38:47.717+00	2017-11-12 23:50:05.329+00	filosofia	type/Integer	\N	t	\N	t	0	8	337	Filo Sofia	normal	\N	\N	\N	\N	\N	\N	0
395	2017-11-12 21:38:47.706+00	2017-11-12 23:50:05.34+00	Saúde	type/Integer	\N	t	\N	t	0	8	337	Saúde	normal	\N	\N	\N	\N	\N	\N	0
394	2017-11-12 21:38:47.696+00	2017-11-12 23:50:05.351+00	Teatro	type/Integer	\N	t	\N	t	0	8	337	Teatro	normal	\N	\N	\N	\N	\N	\N	0
393	2017-11-12 21:38:47.686+00	2017-11-12 23:50:05.363+00	Filosofia	type/Integer	\N	t	\N	t	0	8	337	Filo Sofia	normal	\N	\N	\N	\N	\N	\N	0
392	2017-11-12 21:38:47.661+00	2017-11-12 23:50:05.373+00	Livro	type/Integer	\N	t	\N	t	0	8	337	Liv Ro	normal	\N	\N	\N	\N	\N	\N	0
391	2017-11-12 21:38:47.64+00	2017-11-12 23:50:05.395+00	Museu	type/Integer	\N	t	\N	t	0	8	337	Muse U	normal	\N	\N	\N	\N	\N	\N	0
389	2017-11-12 21:38:47.6+00	2017-11-12 23:50:05.406+00	Cultura Popular	type/Integer	\N	t	\N	t	0	8	337	Cultura Popular	normal	\N	\N	\N	\N	\N	\N	0
388	2017-11-12 21:38:47.577+00	2017-11-12 23:50:05.417+00	jornalismo	type/Integer	\N	t	\N	t	0	8	337	Jorn Al Is Mo	normal	\N	\N	\N	\N	\N	\N	0
387	2017-11-12 21:38:47.564+00	2017-11-12 23:50:05.428+00	literatura infantil	type/Integer	\N	t	\N	t	0	8	337	Literatura Infant Il	normal	\N	\N	\N	\N	\N	\N	0
386	2017-11-12 21:38:47.541+00	2017-11-12 23:50:05.439+00	direito autoral	type/Integer	\N	t	\N	t	0	8	337	Dire I To Aut Oral	normal	\N	\N	\N	\N	\N	\N	0
385	2017-11-12 21:38:47.533+00	2017-11-12 23:50:05.45+00	Leitura	type/Integer	\N	t	\N	t	0	8	337	Lei Tura	normal	\N	\N	\N	\N	\N	\N	0
384	2017-11-12 21:38:47.521+00	2017-11-12 23:50:05.461+00	pesquisa	type/Integer	\N	t	\N	t	0	8	337	Pes Quis A	normal	\N	\N	\N	\N	\N	\N	0
383	2017-11-12 21:38:47.498+00	2017-11-12 23:50:05.473+00	Banda	type/Integer	\N	t	\N	t	0	8	337	Band A	normal	\N	\N	\N	\N	\N	\N	0
382	2017-11-12 21:38:47.486+00	2017-11-12 23:50:05.484+00	Arte de Rua	type/Integer	\N	t	\N	t	0	8	337	Arte De Rua	normal	\N	\N	\N	\N	\N	\N	0
381	2017-11-12 21:38:47.463+00	2017-11-12 23:50:05.495+00	Gastronomia	type/Integer	\N	t	\N	t	0	8	337	Gas Trono Mia	normal	\N	\N	\N	\N	\N	\N	0
380	2017-11-12 21:38:47.453+00	2017-11-12 23:50:05.506+00	cultura estrangeira (imigrantes)	type/Integer	\N	t	\N	t	0	8	337	Cultura Estrange Ira (imigrantes)	normal	\N	\N	\N	\N	\N	\N	0
379	2017-11-12 21:38:47.441+00	2017-11-12 23:50:05.517+00	Meio Ambiente	type/Integer	\N	t	\N	t	0	8	337	Mei O Am Bien Te	normal	\N	\N	\N	\N	\N	\N	0
378	2017-11-12 21:38:47.431+00	2017-11-12 23:50:05.528+00	Arte Digital	type/Integer	\N	t	\N	t	0	8	337	Arte Digital	normal	\N	\N	\N	\N	\N	\N	0
447	2017-11-12 21:38:48.659+00	2017-11-12 23:50:05.539+00	Capoeira	type/Integer	\N	t	\N	t	0	8	337	Capoeira	normal	\N	\N	\N	\N	\N	\N	0
446	2017-11-12 21:38:48.648+00	2017-11-12 23:50:05.55+00	educação	type/Integer	\N	t	\N	t	0	8	337	Educação	normal	\N	\N	\N	\N	\N	\N	0
445	2017-11-12 21:38:48.636+00	2017-11-12 23:50:05.561+00	arte terapia	type/Integer	\N	t	\N	t	0	8	337	Arte Ter Apia	normal	\N	\N	\N	\N	\N	\N	0
444	2017-11-12 21:38:48.615+00	2017-11-12 23:50:05.572+00	Cultura Negra	type/Integer	\N	t	\N	t	0	8	337	Cultura Negra	normal	\N	\N	\N	\N	\N	\N	0
443	2017-11-12 21:38:48.604+00	2017-11-12 23:50:05.583+00	design	type/Integer	\N	t	\N	t	0	8	337	Design	normal	\N	\N	\N	\N	\N	\N	0
377	2017-11-12 21:38:47.364+00	2017-11-12 23:50:05.594+00	Ciência Política	type/Integer	\N	t	\N	t	0	8	337	Ciência Política	normal	\N	\N	\N	\N	\N	\N	0
376	2017-11-12 21:38:47.343+00	2017-11-12 23:50:05.605+00	Artesanato	type/Integer	\N	t	\N	t	0	8	337	Artes An A To	normal	\N	\N	\N	\N	\N	\N	0
375	2017-11-12 21:38:47.33+00	2017-11-12 23:50:05.616+00	Televisão	type/Integer	\N	t	\N	t	0	8	337	Televisão	normal	\N	\N	\N	\N	\N	\N	0
374	2017-11-12 21:38:47.319+00	2017-11-12 23:50:05.627+00	Biblioteca	type/Integer	\N	t	\N	t	0	8	337	Bib Li Otec A	normal	\N	\N	\N	\N	\N	\N	0
373	2017-11-12 21:38:47.308+00	2017-11-12 23:50:05.639+00	Educação	type/Integer	\N	t	\N	t	0	8	337	Educação	normal	\N	\N	\N	\N	\N	\N	0
372	2017-11-12 21:38:47.298+00	2017-11-12 23:50:05.65+00	turismo de base comunitária	type/Integer	\N	t	\N	t	0	8	337	Turismo De Base Comunitária	normal	\N	\N	\N	\N	\N	\N	0
371	2017-11-12 21:38:47.285+00	2017-11-12 23:50:05.661+00	Produção Cultural	type/Integer	\N	t	\N	t	0	8	337	Produção Cultural	normal	\N	\N	\N	\N	\N	\N	0
370	2017-11-12 21:38:47.275+00	2017-11-12 23:50:05.672+00	fotografia	type/Integer	\N	t	\N	t	0	8	337	Fotogr A Fia	normal	\N	\N	\N	\N	\N	\N	0
369	2017-11-12 21:38:47.264+00	2017-11-12 23:50:05.683+00	Gestão Cultural	type/Integer	\N	t	\N	t	0	8	337	Gestão Cultural	normal	\N	\N	\N	\N	\N	\N	0
368	2017-11-12 21:38:47.252+00	2017-11-12 23:50:05.694+00	teatro	type/Integer	\N	t	\N	t	0	8	337	Teatro	normal	\N	\N	\N	\N	\N	\N	0
367	2017-11-12 21:38:47.233+00	2017-11-12 23:50:05.705+00	acervos museológicos	type/Integer	\N	t	\N	t	0	8	337	Acer Vos Museológicos	normal	\N	\N	\N	\N	\N	\N	0
442	2017-11-12 21:38:48.594+00	2017-11-12 23:50:05.716+00	intercambio cultural	type/Integer	\N	t	\N	t	0	8	337	Inter Cambio Cultural	normal	\N	\N	\N	\N	\N	\N	0
355	2017-11-12 21:38:47.065+00	2017-11-12 23:50:05.052+00	Arquivo	type/Integer	\N	t	\N	t	0	8	337	Ar Qui Vo	normal	\N	\N	\N	\N	\N	\N	0
495	2017-11-12 22:49:23.957+00	2017-11-12 22:54:47.742+00	_date	type/DateTime	\N	t	\N	t	0	6	\N	Date	normal	\N	\N	2017-11-12 22:50:11.107+00	\N	\N	{"global":{"distinct-count":327}}	1
272	2017-11-12 21:38:44.719+00	2017-11-12 22:54:47.764+00	_instance	type/Text	type/Category	t	\N	t	0	6	\N	Instance	normal	\N	\N	2017-11-12 21:38:58.302+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":17.0}}}	1
270	2017-11-12 21:38:44.683+00	2017-11-12 22:54:47.775+00	_occupation_area	type/Text	type/Category	t	\N	t	0	6	\N	Occupation Area	normal	\N	\N	2017-11-12 21:38:58.302+00	\N	\N	{"global":{"distinct-count":59},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":8.5765}}}	1
258	2017-11-12 21:38:40.411+00	2017-11-12 23:50:02.97+00	Seminário	type/Integer	\N	t	\N	t	0	5	242	Seminário	normal	\N	\N	\N	\N	\N	\N	0
257	2017-11-12 21:38:40.39+00	2017-11-12 23:50:02.981+00	Intercâmbio Cultural	type/Integer	\N	t	\N	t	0	5	242	Intercâmbio Cultural	normal	\N	\N	\N	\N	\N	\N	0
335	2017-11-12 21:38:45.77+00	2017-11-12 23:50:03.446+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	7	\N	ID	normal	\N	\N	2017-11-12 21:38:59.409+00	\N	\N	{"global":{"distinct-count":3}}	1
308	2017-11-12 21:38:45.271+00	2017-11-12 23:50:03.612+00	01	type/Integer	type/Category	t	\N	t	0	7	297	01	normal	\N	\N	2017-11-12 21:38:59.409+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":315,"avg":210.0}}}	1
94	2017-11-12 21:38:38.187+00	2017-11-12 23:50:00.767+00	03	type/Integer	\N	t	\N	t	0	5	91	03	normal	\N	\N	\N	\N	\N	\N	0
95	2017-11-12 21:38:38.197+00	2017-11-12 23:50:00.778+00	11	type/Integer	\N	t	\N	t	0	5	91	11	normal	\N	\N	\N	\N	\N	\N	0
96	2017-11-12 21:38:38.209+00	2017-11-12 23:50:00.789+00	05	type/Integer	\N	t	\N	t	0	5	91	05	normal	\N	\N	\N	\N	\N	\N	0
97	2017-11-12 21:38:38.23+00	2017-11-12 23:50:00.802+00	08	type/Integer	\N	t	\N	t	0	5	91	08	normal	\N	\N	\N	\N	\N	\N	0
98	2017-11-12 21:38:38.241+00	2017-11-12 23:50:00.812+00	07	type/Integer	\N	t	\N	t	0	5	91	07	normal	\N	\N	\N	\N	\N	\N	0
234	2017-11-12 21:38:40.045+00	2017-11-12 23:50:02.627+00	Parada e Desfile de Ações Afirmativas	type/Integer	\N	t	\N	t	0	5	217	Parada E Des File De Ações A Firm At Iv As	normal	\N	\N	\N	\N	\N	\N	0
35	2017-11-12 21:38:37.273+00	2017-11-12 23:50:00.678+00	_total_project_registered_per_mounth_per_year	type/Dictionary	\N	t	\N	t	0	5	\N	Total Project Registered Per Mou Nth Per Year	normal	\N	\N	2017-11-12 21:38:54.891+00	\N	\N	{"global":{"distinct-count":2}}	1
242	2017-11-12 21:38:40.146+00	2017-11-12 23:50:02.66+00	mapasculturagovbr	type/Dictionary	\N	t	\N	t	0	5	191	Map As Cultura Gov Br	normal	\N	\N	\N	\N	\N	\N	0
365	2017-11-12 21:38:47.208+00	2017-11-12 23:50:05.727+00	Opera	type/Integer	\N	t	\N	t	0	8	337	Opera	normal	\N	\N	\N	\N	\N	\N	0
364	2017-11-12 21:38:47.197+00	2017-11-12 23:50:05.738+00	Cultura Indígena	type/Integer	\N	t	\N	t	0	8	337	Cultura Indígena	normal	\N	\N	\N	\N	\N	\N	0
322	2017-11-12 21:38:45.539+00	2017-11-12 23:50:04+00	2016	type/Dictionary	\N	t	\N	t	0	7	274	2016	normal	\N	\N	\N	\N	\N	\N	0
363	2017-11-12 21:38:47.186+00	2017-11-12 23:50:05.749+00	antropologia	type/Integer	\N	t	\N	t	0	8	337	An Tro Polo Gia	normal	\N	\N	\N	\N	\N	\N	0
451	2017-11-12 21:38:48.702+00	2017-11-12 23:50:05.76+00	cinema	type/Integer	\N	t	\N	t	0	8	337	Cinema	normal	\N	\N	\N	\N	\N	\N	0
450	2017-11-12 21:38:48.692+00	2017-11-12 23:50:05.772+00	ponto de memória	type/Integer	\N	t	\N	t	0	8	337	Pon To De Memória	normal	\N	\N	\N	\N	\N	\N	0
449	2017-11-12 21:38:48.682+00	2017-11-12 23:50:05.783+00	arte de rua	type/Integer	\N	t	\N	t	0	8	337	Arte De Rua	normal	\N	\N	\N	\N	\N	\N	0
448	2017-11-12 21:38:48.669+00	2017-11-12 23:50:05.794+00	arquitetura-urbanismo	type/Integer	\N	t	\N	t	0	8	337	Ar Quite Tura Urbanism O	normal	\N	\N	\N	\N	\N	\N	0
366	2017-11-12 21:38:47.219+00	2017-11-12 23:50:05.805+00	Cultura Estrangeira (imigrantes)	type/Integer	\N	t	\N	t	0	8	337	Cultura Estrange Ira (imigrantes)	normal	\N	\N	\N	\N	\N	\N	0
359	2017-11-12 21:38:47.133+00	2017-11-12 23:50:05.816+00	Mídias Sociais	type/Integer	\N	t	\N	t	0	8	337	Mídias Soci A Is	normal	\N	\N	\N	\N	\N	\N	0
456	2017-11-12 21:38:48.759+00	2017-11-12 23:50:05.827+00	saúde	type/Integer	\N	t	\N	t	0	8	337	Saúde	normal	\N	\N	\N	\N	\N	\N	0
455	2017-11-12 21:38:48.748+00	2017-11-12 23:50:05.838+00	sociologia	type/Integer	\N	t	\N	t	0	8	337	Socio Logia	normal	\N	\N	\N	\N	\N	\N	0
454	2017-11-12 21:38:48.736+00	2017-11-12 23:50:05.849+00	história	type/Integer	\N	t	\N	t	0	8	337	História	normal	\N	\N	\N	\N	\N	\N	0
453	2017-11-12 21:38:48.724+00	2017-11-12 23:50:05.86+00	moda	type/Integer	\N	t	\N	t	0	8	337	Moda	normal	\N	\N	\N	\N	\N	\N	0
415	2017-11-12 21:38:48.184+00	2017-11-12 23:50:05.871+00	fortalecimento de cultura de rede local	type/Integer	\N	t	\N	t	0	8	337	For Tale Ci Men To De Cultura De Rede Local	normal	\N	\N	\N	\N	\N	\N	0
390	2017-11-12 21:38:47.622+00	2017-11-12 23:50:05.882+00	mídias sociais	type/Integer	\N	t	\N	t	0	8	337	Mídias Soci A Is	normal	\N	\N	\N	\N	\N	\N	0
434	2017-11-12 21:38:48.481+00	2017-11-12 23:50:05.893+00	História	type/Integer	type/Category	t	\N	t	0	8	337	História	normal	\N	\N	2017-11-12 21:39:00.594+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":38745,"avg":25830.0}}}	1
338	2017-11-12 21:38:46.645+00	2017-11-12 23:50:05.904+00	gastronomia	type/Integer	\N	t	\N	t	0	8	337	Gas Trono Mia	normal	\N	\N	\N	\N	\N	\N	0
478	2017-11-12 21:38:50.778+00	2017-11-12 23:50:06.098+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	9	\N	ID	normal	\N	\N	2017-11-12 21:39:00.716+00	\N	\N	{"global":{"distinct-count":2}}	1
482	2017-11-12 21:38:50.852+00	2017-11-12 23:50:06.163+00	_total_public_libraries	type/Integer	type/Category	t	\N	t	0	10	\N	Total Public Libraries	normal	\N	\N	2017-11-12 22:50:12.544+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}	1
489	2017-11-12 21:38:50.941+00	2017-11-12 23:50:06.17+00	_libraries_registered_monthly	type/Dictionary	\N	t	\N	t	0	10	\N	Libraries Registered Monthly	normal	\N	\N	2017-11-12 21:39:01.856+00	\N	\N	{"global":{"distinct-count":4}}	1
490	2017-11-12 21:38:50.951+00	2017-11-12 23:50:06.184+00	julho	type/Integer	\N	t	\N	t	0	10	489	Jul Ho	normal	\N	\N	\N	\N	\N	\N	0
484	2017-11-12 21:38:50.885+00	2017-11-12 23:50:06.194+00	_cls	type/Text	type/Category	t	\N	t	0	10	\N	Cls	normal	\N	\N	2017-11-12 21:39:01.856+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":14.0}}}	1
485	2017-11-12 21:38:50.896+00	2017-11-12 23:50:06.204+00	_total_libraries	type/Integer	type/Category	t	\N	t	0	10	\N	Total Libraries	normal	\N	\N	2017-11-12 21:39:01.856+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}	1
480	2017-11-12 21:38:50.83+00	2017-11-12 23:50:06.215+00	_total_libraries_type_sphere	type/Dictionary	\N	t	\N	t	0	10	\N	Total Libraries Type Sphere	normal	\N	\N	2017-11-12 22:50:12.544+00	\N	\N	{"global":{"distinct-count":1}}	1
491	2017-11-12 21:38:50.963+00	2017-11-12 23:50:06.237+00	_amount_areas	type/Integer	\N	t	\N	t	0	10	\N	Amount Areas	normal	\N	\N	\N	\N	\N	\N	0
487	2017-11-12 21:38:50.918+00	2017-11-12 23:50:06.248+00	_libraries_registered_yearly	type/Dictionary	\N	t	\N	t	0	10	\N	Libraries Registered Yearly	normal	\N	\N	2017-11-12 21:39:01.856+00	\N	\N	{"global":{"distinct-count":4}}	1
488	2017-11-12 21:38:50.929+00	2017-11-12 23:50:06.261+00	2010	type/Integer	type/Category	t	\N	t	0	10	487	2010	normal	\N	\N	2017-11-12 21:39:01.856+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}	1
486	2017-11-12 21:38:50.907+00	2017-11-12 23:50:06.27+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	10	\N	ID	normal	\N	\N	2017-11-12 21:39:01.856+00	\N	\N	{"global":{"distinct-count":1}}	1
493	2017-11-12 21:38:50.984+00	2017-11-12 23:50:06.293+00	Leitura	type/Integer	\N	t	\N	t	0	10	492	Lei Tura	normal	\N	\N	\N	\N	\N	\N	0
181	2017-11-12 21:38:39.417+00	2017-11-12 23:50:00.557+00	_total_project_that_accept_online_transitions	type/Dictionary	\N	t	\N	t	0	5	\N	Total Project That Accept Online Transitions	normal	\N	\N	\N	\N	\N	\N	0
92	2017-11-12 21:38:38.163+00	2017-11-12 23:50:00.756+00	09	type/Integer	\N	t	\N	t	0	5	91	09	normal	\N	\N	\N	\N	\N	\N	0
494	2017-11-12 22:49:23.922+00	2017-11-12 22:54:47.709+00	_name	type/Text	\N	t	\N	t	0	6	\N	Name	normal	\N	\N	2017-11-12 22:50:11.107+00	\N	\N	{"global":{"distinct-count":4825},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":32.5611}}}	1
191	2017-11-12 21:38:39.527+00	2017-11-12 23:50:02.351+00	_total_project_per_type	type/Dictionary	\N	t	\N	t	0	5	\N	Total Project Per Type	normal	\N	\N	\N	\N	\N	\N	0
265	2017-11-12 21:38:40.488+00	2017-11-12 23:50:03.004+00	Fórum	type/Integer	\N	t	\N	t	0	5	242	Fórum	normal	\N	\N	\N	\N	\N	\N	0
196	2017-11-12 21:38:39.604+00	2017-11-12 23:50:03.336+00	Convenção	type/Integer	\N	t	\N	t	0	5	192	Convenção	normal	\N	\N	\N	\N	\N	\N	0
101	2017-11-12 21:38:38.273+00	2017-11-12 23:50:00.834+00	01	type/Integer	\N	t	\N	t	0	5	91	01	normal	\N	\N	\N	\N	\N	\N	0
85	2017-11-12 21:38:38.085+00	2017-11-12 23:50:00.922+00	09	type/Integer	\N	t	\N	t	0	5	84	09	normal	\N	\N	\N	\N	\N	\N	0
86	2017-11-12 21:38:38.1+00	2017-11-12 23:50:00.933+00	03	type/Integer	\N	t	\N	t	0	5	84	03	normal	\N	\N	\N	\N	\N	\N	0
87	2017-11-12 21:38:38.107+00	2017-11-12 23:50:00.944+00	05	type/Integer	\N	t	\N	t	0	5	84	05	normal	\N	\N	\N	\N	\N	\N	0
117	2017-11-12 21:38:38.53+00	2017-11-12 23:50:01.088+00	mapasculturagovbr	type/Dictionary	\N	t	\N	t	0	5	35	Map As Cultura Gov Br	normal	\N	\N	\N	\N	\N	\N	0
168	2017-11-12 21:38:39.231+00	2017-11-12 23:50:01.675+00	11	type/Integer	\N	t	\N	t	0	5	164	11	normal	\N	\N	\N	\N	\N	\N	0
36	2017-11-12 21:38:37.295+00	2017-11-12 23:50:01.786+00	spculturaprefeituraspgovbr	type/Dictionary	\N	t	\N	t	0	5	35	Sp Cultura Pre Fei Tura Sp Gov Br	normal	\N	\N	\N	\N	\N	\N	0
76	2017-11-12 21:38:37.953+00	2017-11-12 23:50:02.097+00	08	type/Integer	\N	t	\N	t	0	5	70	08	normal	\N	\N	\N	\N	\N	\N	0
50	2017-11-12 21:38:37.538+00	2017-11-12 23:50:02.107+00	2017	type/Dictionary	\N	t	\N	t	0	5	36	2017	normal	\N	\N	2017-11-12 22:50:09.997+00	\N	\N	{"global":{"distinct-count":2}}	1
178	2017-11-12 21:38:39.374+00	2017-11-12 23:50:02.34+00	_create_date	type/Text	\N	t	\N	t	0	5	\N	Create Date	normal	\N	\N	\N	\N	\N	\N	0
100	2017-11-12 21:38:38.264+00	2017-11-12 23:50:00.822+00	04	type/Integer	\N	t	\N	t	0	5	91	04	normal	\N	\N	\N	\N	\N	\N	0
220	2017-11-12 21:38:39.88+00	2017-11-12 23:50:02.638+00	Conferência Pública Nacional	type/Integer	\N	t	\N	t	0	5	217	Conferência Pública Nacional	normal	\N	\N	\N	\N	\N	\N	0
337	2017-11-12 21:38:46.635+00	2017-11-12 23:50:04.521+00	_total_agents_area_oreration	type/Dictionary	\N	t	\N	t	0	8	\N	Total Agents Area Ore Ration	normal	\N	\N	\N	\N	\N	\N	0
469	2017-11-12 21:38:48.914+00	2017-11-12 23:50:05.926+00	artistas agentes culturais	type/Integer	\N	t	\N	t	0	8	337	Artist As Agent Es Cultura Is	normal	\N	\N	\N	\N	\N	\N	0
452	2017-11-12 21:38:48.715+00	2017-11-12 23:50:05.938+00	Coral	type/Integer	\N	t	\N	t	0	8	337	Coral	normal	\N	\N	\N	\N	\N	\N	0
435	2017-11-12 21:38:48.493+00	2017-11-12 23:50:05.949+00	mostras culturais	type/Integer	type/Category	t	\N	t	0	8	337	Most Ras Cultura Is	normal	\N	\N	2017-11-12 21:39:00.594+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":11028,"avg":7352.0}}}	1
356	2017-11-12 21:38:47.08+00	2017-11-12 23:50:05.96+00	Patrimônio Imaterial	type/Integer	type/Category	t	\N	t	0	8	337	Patrimônio I Material	normal	\N	\N	2017-11-12 22:50:12.266+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":11028,"avg":7352.0}}}	1
353	2017-11-12 21:38:47.022+00	2017-11-12 23:50:05.971+00	produção cultural	type/Integer	type/Category	t	\N	t	0	8	337	Produção Cultural	normal	\N	\N	2017-11-12 22:50:12.266+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":38746,"avg":25830.666666666668}}}	1
341	2017-11-12 21:38:46.68+00	2017-11-12 23:50:05.982+00	novas mídias	type/Integer	\N	t	\N	t	0	8	337	Novas Mídias	normal	\N	\N	\N	\N	\N	\N	0
492	2017-11-12 21:38:50.973+00	2017-11-12 23:50:06.281+00	_libraries_per_activity	type/Dictionary	\N	t	\N	t	0	10	\N	Libraries Per Activity	normal	\N	\N	2017-11-12 21:39:01.856+00	\N	\N	{"global":{"distinct-count":1}}	1
483	2017-11-12 21:38:50.868+00	2017-11-12 23:50:06.303+00	_total_private_libraries	type/Integer	type/Category	t	\N	t	0	10	\N	Total Private Libraries	normal	\N	\N	2017-11-12 22:50:12.544+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}	1
479	2017-11-12 21:38:50.824+00	2017-11-12 23:50:06.314+00	_create_date	type/DateTime	\N	t	\N	t	0	10	\N	Create Date	normal	\N	\N	2017-11-12 22:50:12.544+00	\N	\N	{"global":{"distinct-count":1}}	1
185	2017-11-12 21:38:39.46+00	2017-11-12 23:50:00.645+00	spculturaprefeituraspgovbr	type/Dictionary	\N	t	\N	t	0	5	181	Sp Cultura Pre Fei Tura Sp Gov Br	normal	\N	\N	\N	\N	\N	\N	0
89	2017-11-12 21:38:38.129+00	2017-11-12 23:50:00.911+00	04	type/Integer	\N	t	\N	t	0	5	84	04	normal	\N	\N	\N	\N	\N	\N	0
55	2017-11-12 21:38:37.634+00	2017-11-12 23:50:02.24+00	05	type/Integer	type/Category	t	\N	t	0	5	50	05	normal	\N	\N	2017-11-12 22:50:09.997+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":3257,"avg":1628.5}}}	1
229	2017-11-12 21:38:39.989+00	2017-11-12 23:50:02.649+00	Jornada	type/Integer	\N	t	\N	t	0	5	217	Jorn Ada	normal	\N	\N	\N	\N	\N	\N	0
253	2017-11-12 21:38:40.299+00	2017-11-12 23:50:02.993+00	Ciclo	type/Integer	\N	t	\N	t	0	5	242	Ci Clo	normal	\N	\N	\N	\N	\N	\N	0
266	2017-11-12 21:38:40.499+00	2017-11-12 23:50:03.015+00	Sarau	type/Integer	\N	t	\N	t	0	5	242	Sara U	normal	\N	\N	\N	\N	\N	\N	0
245	2017-11-12 21:38:40.185+00	2017-11-12 23:50:03.026+00	Parada e Desfile Cívico	type/Integer	\N	t	\N	t	0	5	242	Parada E Des File Cívico	normal	\N	\N	\N	\N	\N	\N	0
261	2017-11-12 21:38:40.444+00	2017-11-12 23:50:03.037+00	Parada e Desfile de Ações Afirmativas	type/Integer	\N	t	\N	t	0	5	242	Parada E Des File De Ações A Firm At Iv As	normal	\N	\N	\N	\N	\N	\N	0
263	2017-11-12 21:38:40.465+00	2017-11-12 23:50:03.048+00	Concurso	type/Integer	type/Category	t	\N	t	0	5	242	Concur So	normal	\N	\N	2017-11-12 21:38:54.891+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":3257,"avg":1628.5}}}	1
192	2017-11-12 21:38:39.544+00	2017-11-12 23:50:03.059+00	spculturaprefeituraspgovbr	type/Dictionary	\N	t	\N	t	0	5	191	Sp Cultura Pre Fei Tura Sp Gov Br	normal	\N	\N	\N	\N	\N	\N	0
194	2017-11-12 21:38:39.581+00	2017-11-12 23:50:03.347+00	Conferência Pública Estadual	type/Integer	\N	t	\N	t	0	5	192	Conferência Pública Esta Dual	normal	\N	\N	\N	\N	\N	\N	0
215	2017-11-12 21:38:39.823+00	2017-11-12 23:50:03.358+00	Exposição	type/Integer	type/Category	t	\N	t	0	5	192	Exposição	normal	\N	\N	2017-11-12 21:38:54.891+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":39,"avg":19.5}}}	1
216	2017-11-12 21:38:39.834+00	2017-11-12 23:50:03.369+00	Mostra	type/Integer	\N	t	\N	t	0	5	192	Most Ra	normal	\N	\N	\N	\N	\N	\N	0
274	2017-11-12 21:38:44.808+00	2017-11-12 23:50:03.457+00	_total_agents_registered_month	type/Dictionary	\N	t	\N	t	0	7	\N	Total Agents Registered Month	normal	\N	\N	2017-11-12 21:38:59.409+00	\N	\N	{"global":{"distinct-count":2}}	1
358	2017-11-12 21:38:47.111+00	2017-11-12 23:50:05.915+00	culturas urbanas	type/Integer	\N	t	\N	t	0	8	337	Cult Ur As Urban As	normal	\N	\N	\N	\N	\N	\N	0
460	2017-11-12 21:38:48.814+00	2017-11-12 23:50:05.993+00	demais atividades correlatas a cultura popular	type/Integer	\N	t	\N	t	0	8	337	Dem A Is At I Vida Des Corre Lat As A Cultura Popular	normal	\N	\N	\N	\N	\N	\N	0
457	2017-11-12 21:38:48.77+00	2017-11-12 23:50:06.005+00	festas calendarizadas populares	type/Integer	\N	t	\N	t	0	8	337	Fest As Calendar Iz Adas Popular Es	normal	\N	\N	\N	\N	\N	\N	0
421	2017-11-12 21:38:48.283+00	2017-11-12 23:50:06.027+00	Economia Criativa	type/Integer	\N	t	\N	t	0	8	337	Eco No Mia Cri At Iva	normal	\N	\N	\N	\N	\N	\N	0
422	2017-11-12 21:38:48.295+00	2017-11-12 23:50:06.048+00	meio ambiente	type/Integer	\N	t	\N	t	0	8	337	Mei O Am Bien Te	normal	\N	\N	\N	\N	\N	\N	0
477	2017-11-12 21:38:50.763+00	2017-11-12 23:50:06.126+00	_create_date	type/Text	type/Category	t	\N	t	0	9	\N	Create Date	normal	\N	\N	2017-11-12 21:39:00.716+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":26.0}}}	1
440	2017-11-12 21:38:48.57+00	2017-11-12 23:50:06.059+00	permacultura e cultura hacker	type/Integer	\N	t	\N	t	0	8	337	Perm A Cultura E Cultura Hacker	normal	\N	\N	\N	\N	\N	\N	0
497	2017-11-12 23:36:13.427+00	2017-11-12 23:50:11.885+00	_occupation_area	type/Text	type/Category	t	\N	t	0	12	\N	Occupation Area	normal	\N	\N	2017-11-12 23:50:11.918+00	\N	\N	{"global":{"distinct-count":59},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":8.5765}}}	1
501	2017-11-12 23:36:13.529+00	2017-11-12 23:50:10.929+00	_date	type/DateTime	\N	t	\N	t	0	12	\N	Date	normal	\N	\N	2017-11-12 23:50:11.918+00	\N	\N	{"global":{"distinct-count":327}}	1
500	2017-11-12 23:36:13.515+00	2017-11-12 23:50:11.896+00	_instance	type/Text	type/Category	t	\N	t	0	12	\N	Instance	normal	\N	\N	2017-11-12 23:50:11.918+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":17.0}}}	1
122	2017-11-12 21:38:38.617+00	2017-11-12 23:50:01.232+00	11	type/Integer	type/Category	t	\N	t	0	5	118	11	normal	\N	\N	2017-11-12 22:50:09.997+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":39,"avg":19.5}}}	1
62	2017-11-12 21:38:37.744+00	2017-11-12 23:50:02.25+00	2014	type/Dictionary	\N	t	\N	t	0	5	36	2014	normal	\N	\N	2017-11-12 22:50:09.997+00	\N	\N	{"global":{"distinct-count":3}}	1
360	2017-11-12 21:38:47.155+00	2017-11-12 23:50:06.07+00	música	type/Integer	type/Category	t	\N	t	0	8	337	Música	normal	\N	\N	2017-11-12 22:50:12.266+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":27718,"avg":18478.666666666668}}}	1
438	2017-11-12 21:38:48.549+00	2017-11-12 23:50:06.081+00	Design	type/Integer	type/Category	t	\N	t	0	8	337	Design	normal	\N	\N	2017-11-12 21:39:00.594+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":27717,"avg":18478.0}}}	1
61	2017-11-12 21:38:37.723+00	2017-11-12 23:50:08.852+00	02	type/Integer	type/Category	t	\N	t	0	5	50	02	normal	\N	\N	2017-11-12 23:50:08.883+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":3258,"avg":1629.0}}}	1
131	2017-11-12 21:38:38.75+00	2017-11-12 23:50:08.872+00	09	type/Integer	type/Category	t	\N	t	0	5	130	09	normal	\N	\N	2017-11-12 23:50:08.883+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":39,"avg":19.5}}}	1
474	2017-11-12 21:38:49.002+00	2017-11-12 23:50:09.672+00	_create_date	type/Text	type/Category	t	\N	t	0	8	\N	Create Date	normal	\N	\N	2017-11-12 23:50:09.691+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":3.6666666666666665}}}	1
473	2017-11-12 21:38:48.991+00	2017-11-12 23:50:09.683+00	_cls	type/Text	type/Category	t	\N	t	0	8	\N	Cls	normal	\N	\N	2017-11-12 23:50:09.691+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":3.6666666666666665}}}	1
481	2017-11-12 21:38:50.841+00	2017-11-12 23:50:09.849+00	Municipal	type/Integer	type/Category	t	\N	t	0	10	480	Municipal	normal	\N	\N	2017-11-12 23:50:09.857+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}	1
499	2017-11-12 23:36:13.485+00	2017-11-12 23:50:11.224+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	12	\N	ID	normal	\N	\N	2017-11-12 23:50:11.918+00	\N	\N	{"global":{"distinct-count":10000}}	1
498	2017-11-12 23:36:13.463+00	2017-11-12 23:50:11.906+00	_space_type	type/Text	type/Category	t	\N	t	0	12	\N	Space Type	normal	\N	\N	2017-11-12 23:50:11.918+00	\N	\N	{"global":{"distinct-count":70},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":17.4366}}}	1
496	2017-11-12 23:36:13.344+00	2017-11-12 23:50:11.846+00	_name	type/Text	\N	t	\N	t	0	12	\N	Name	normal	\N	\N	2017-11-12 23:50:11.918+00	\N	\N	{"global":{"distinct-count":4825},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":32.5611}}}	1
\.


--
-- Data for Name: metabase_fieldvalues; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) FROM stdin;
1	2017-11-11 23:01:42.314+00	2017-11-11 23:01:42.314+00	[1,2,3,4,5]	\N	3
2	2017-11-11 23:01:42.346+00	2017-11-11 23:01:42.346+00	["Affiliate","Facebook","Google","Organic","Twitter"]	\N	9
3	2017-11-11 23:01:42.431+00	2017-11-11 23:01:42.431+00	["AA","AE","AK","AL","AP","AR","AS","AZ","CA","CO","CT","DC","DE","FL","FM","GA","GU","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MH","MI","MN","MO","MP","MS","MT","NC","ND","NE","NH","NJ","NM","NV","NY","OH","OK","OR","PA","PR","PW","RI","SC","SD","TN","TX","UT","VA","VI","VT","WA","WI","WV","WY"]	\N	17
4	2017-11-11 23:01:43.166+00	2017-11-11 23:01:43.166+00	[12.02,12.65,12.98,13.0,13.45,14.4,14.43,14.54,14.8,15.22,15.97,16.67,16.88,17.19,17.54,17.96,17.97,18.1,18.12,18.58,18.61,18.990000000000002,19.57,21.11,21.240000000000002,23.61,23.71,25.78,26.21,27.33,27.73,28.41,28.69,29.26,29.29,29.78,29.85,29.88,29.94,29.96,30.36,31.03,32.82,33.03,34.3,34.71,35.010000000000005,36.6,36.65,37.57,38.09,38.11,38.83,38.879999999999995,39.18,39.760000000000005,40.4,41.120000000000005,42.36,42.9,43.730000000000004,43.980000000000004,45.31,45.41,45.59,45.73,46.25,46.36,46.54,46.62,47.0,47.05,47.9,47.96,48.06,49.32,49.91,50.93,51.29,51.88,53.46,53.92,54.54,54.8,54.96,55.02,55.13,55.17,55.29,55.66,56.17,56.58,57.73,57.91,58.25,58.6,59.54,59.63,60.25,60.71,60.82,60.97,61.35,61.91,62.49,62.54,62.61,62.8,63.11,63.29,63.5,64.03999999999999,64.2,64.4,65.0,65.44,65.81,67.19,67.21000000000001,68.18,68.64,68.69,69.3,69.43,71.03,71.05,72.31,72.69,72.85,73.22999999999999,73.58,73.75,74.22999999999999,74.31,75.11,75.47,76.24,77.02,77.96,78.39,78.47,79.34,79.97,80.0,80.12,80.64,80.86,81.18,81.48,81.65,82.08,82.46,83.16,83.68,85.34,85.7,86.52,86.93,86.96,87.1,87.27,87.54,88.06,88.42,88.79,88.95,89.27,89.62,89.75,90.99,91.19,91.24,91.33,92.01,92.18,92.19,92.76,93.03,93.25,93.41,93.64,93.68,93.74,93.94,94.35,94.44,94.74,95.25,95.44,95.66,95.76,95.77,95.87,96.36,97.69,98.61,98.8,98.87,99.37]	\N	21
5	2017-11-11 23:01:43.195+00	2017-11-11 23:01:43.195+00	["Abbott, Kunde and McClure","Abernathy-Franecki","Abshire-McCullough","Adams-O'Keefe","Adrienne Moen Inc","Agustin Quitzon Inc","Aida Morar and Sons","Alexis Haley and Sons","Alfonzo Ritchie and Sons","Altenwerth, Rodriguez and Hermann","Annabell Ledner and Sons","Athena Ankunding and Sons","Aufderhar-Dietrich","Bahringer-Lubowitz","Bartell, Windler and Bernier","Bartell-Kuphal","Bayer, Halvorson and Brown","Bayer-Rosenbaum","Beahan, Daugherty and Kihn","Beatty, Bahringer and Gleichner","Beatty, Barrows and Spencer","Bechtelar, DuBuque and Jaskolski","Berge, Turcotte and Brown","Berneice Cole and Sons","Billie Collins Group","Blaze Mertz and Sons","Bode-Mueller","Bonnie Hettinger Inc","Boyle, Sporer and Reilly","Bridie Little DVM and Sons","Brown, Leffler and Lang","Buckridge, Barrows and Conroy","Buckridge, Turner and Jenkins","Carter, Kub and Bins","Carter, Schmidt and Batz","Casper Leannon DDS and Sons","Christiansen-Feil","Collier, O'Reilly and Mayert","Conn-Fisher","Conroy, Bergnaum and Steuber","Cordell Harris Group","Cristian Lockman Group","Cydney Will Group","Dach, Predovic and Towne","Daniel, Sawayn and Koepp","Davis-Mraz","Dickens, Gulgowski and Braun","Dickens-Ortiz","Dietrich-Upton","Dr. Carmel Willms Group","Einar Hoeger Group","Eldridge Rodriguez Inc","Ernser-Haley","Eugene Vandervort IV LLC","Fadel-Friesen","Fadel-Veum","Fahey-Williamson","Feeney, Bogan and Mann","Feeney-Wolf","Flavie Christiansen Group","Friesen, Glover and Morissette","Goldner-West","Gottlieb-Kunde","Grady-Heller","Grady-O'Conner","Griffin Shanahan and Sons","Hackett-Bahringer","Haley-Feest","Heaney, Kemmer and Wolf","Herbert Boehm Inc","Hermann, Roob and Cole","Hermiston, Steuber and Schulist","Hickle, Schiller and Hodkiewicz","Hilda Gulgowski LLC","Homenick, Macejkovic and Kessler","Homenick-Kshlerin","Howell, Christiansen and Beatty","Huels-Powlowski","Hyatt-Schaefer","Jacques Ullrich and Sons","Jaime Pollich and Sons","Jarod Auer LLC","Jarvis Tremblay Inc","Joan Bartoletti Group","Joana Osinski and Sons","Joey Collier LLC","Johnston, Bashirian and Bartell","Judd Gutmann III and Sons","June Quitzon Group","June Renner Inc","Kaleb Pagac Group","Kassulke-Toy","Kaylah Grimes Inc","Keegan Dach Group","Keeling, Rau and Osinski","Keith Dickinson Inc","Kemmer, Spencer and Kautzer","Kenyon Cummings LLC","Kihn, Kerluke and Carroll","Koch-Turcotte","Koepp, Mraz and Gibson","Koepp-Hamill","Koss-Willms","Kris-Ritchie","Kuhn-Kuvalis","Kunde-Sanford","Kutch-Tromp","Kuvalis-Renner","Lang, Murazik and Paucek","Lavada Kessler Group","Leannon-Kuphal","Lemke-Schaden","Lina Hodkiewicz and Sons","Littel, Fay and Reinger","Lorenzo Mante Inc","Lowe, Marks and Gleichner","Macejkovic, Crooks and Hagenes","Maddison Corkery and Sons","Madilyn Ratke LLC","Mallie Funk Group","Marc Beier Group","Marquardt-Schultz","Matilda Breitenberg LLC","Mayer, Stark and Langworth","Mayert, Schaden and Stokes","McClure, Williamson and Rosenbaum","McKenzie-Rodriguez","McLaughlin-Bruen","Mekhi Bosco LLC","Miss Charles Lemke LLC","Mitchell, Kuphal and Russel","Mohammad Altenwerth Group","Moore, Hessel and Ziemann","Ms. Bennie Schuppe LLC","Ms. Jaime Wyman LLC","Ms. Monroe Crooks LLC","Muriel Halvorson Inc","Nicolas-Reinger","Nitzsche, Hermiston and Raynor","Nitzsche-Schaden","Nolan, Bahringer and Pacocha","Nolan, Heller and Miller","O'Hara-Ferry","O'Kon, Kautzer and Goyette","Oberbrunner-Labadie","Okuneva, Legros and Schmeler","Osinski, Marquardt and Roberts","Osinski-Mueller","Pacocha, Lynch and Bosco","Pauline Rath LLC","Prince Leffler Group","Prosacco-Lemke","Quinten Koepp and Sons","Randal Gerlach Group","Rau-Armstrong","Robel, Friesen and Blick","Roberts, Morissette and Price","Rocio Gusikowski and Sons","Rohan-Rogahn","Romaguera-Corkery","Runolfsson-Gutmann","Runte-Douglas","Ruth Osinski LLC","Rutherford-Langworth","Ryan, Douglas and Denesik","Schiller, Cartwright and Klocko","Schiller-Lemke","Senger, Konopelski and Jones","Sipes-Sanford","Stan Bradtke LLC","Stehr, Mayert and Wiza","Stoltenberg-Schroeder","Stroman, Abernathy and Pfannerstill","Strosin-Bartoletti","Swift-Streich","Sydni Smitham PhD Inc","Tatum West LLC","Tina Emard Group","Tommie Runte LLC","Toni Gerlach Group","Torp, Kub and Hessel","Torp-Collier","Torphy-Mayer","Tremblay-Price","Vella Wiegand and Sons","Vicenta Kuhn Group","Virgil Stehr and Sons","Walter, Kerluke and Ullrich","Ward Kihn Group","Weissnat-Swaniawski","White, Nolan and Lockman","Wilber Will Group","Windler-Hansen","Winston Nienow LLC","Wuckert-Gerlach","Xzavier Windler Group","Yadira Leffler LLC","Zachariah Krajcik Group","Ziemann, Schaden and Marvin","Zula Heathcote and Sons"]	\N	27
6	2017-11-11 23:01:43.225+00	2017-11-11 23:01:43.225+00	["Aerodynamic Concrete Bag","Aerodynamic Copper Coat","Aerodynamic Copper Hat","Aerodynamic Copper Knife","Aerodynamic Cotton Shoes","Aerodynamic Marble Bottle","Aerodynamic Paper Keyboard","Aerodynamic Paper Wallet","Aerodynamic Plastic Clock","Aerodynamic Plastic Coat","Awesome Concrete Coat","Awesome Concrete Keyboard","Awesome Concrete Shirt","Awesome Copper Keyboard","Awesome Granite Coat","Awesome Granite Watch","Awesome Leather Computer","Awesome Marble Shoes","Awesome Marble Wallet","Awesome Paper Chair","Awesome Paper Clock","Awesome Paper Computer","Awesome Plastic Table","Awesome Rubber Bench","Awesome Silk Chair","Awesome Silk Coat","Awesome Steel Bottle","Awesome Wooden Shirt","Durable Linen Car","Durable Marble Computer","Durable Marble Pants","Durable Paper Keyboard","Durable Silk Car","Durable Wooden Car","Durable Wooden Lamp","Durable Wool Bottle","Durable Wool Chair","Enormous Bronze Toucan","Enormous Copper Plate","Enormous Iron Hat","Enormous Marble Shoes","Enormous Paper Car","Enormous Paper Knife","Enormous Paper Pants","Enormous Paper Shirt","Enormous Rubber Toucan","Enormous Steel Hat","Enormous Wooden Clock","Ergonomic Bronze Chair","Ergonomic Cotton Chair","Ergonomic Leather Pants","Ergonomic Marble Shirt","Ergonomic Plastic Bottle","Ergonomic Silk Watch","Ergonomic Steel Hat","Ergonomic Steel Table","Ergonomic Wool Lamp","Fantastic Bronze Lamp","Fantastic Concrete Lamp","Fantastic Concrete Table","Fantastic Copper Coat","Fantastic Cotton Keyboard","Fantastic Granite Coat","Fantastic Leather Table","Fantastic Marble Clock","Fantastic Marble Watch","Fantastic Plastic Bag","Fantastic Plastic Hat","Fantastic Plastic Shirt","Fantastic Silk Computer","Fantastic Steel Chair","Fantastic Wooden Gloves","Fantastic Wool Coat","Fantastic Wool Pants","Gorgeous Granite Keyboard","Gorgeous Granite Shoes","Gorgeous Rubber Hat","Gorgeous Wool Clock","Heavy-Duty Aluminum Knife","Heavy-Duty Aluminum Pants","Heavy-Duty Bronze Coat","Heavy-Duty Concrete Coat","Heavy-Duty Concrete Pants","Heavy-Duty Concrete Plate","Heavy-Duty Cotton Gloves","Heavy-Duty Iron Computer","Heavy-Duty Linen Pants","Heavy-Duty Plastic Bench","Heavy-Duty Plastic Gloves","Heavy-Duty Plastic Lamp","Heavy-Duty Wooden Chair","Heavy-Duty Wool Chair","Incredible Copper Bag","Incredible Copper Shirt","Incredible Copper Toucan","Incredible Cotton Gloves","Incredible Cotton Hat","Incredible Leather Coat","Incredible Marble Chair","Incredible Paper Computer","Incredible Paper Shirt","Incredible Rubber Table","Incredible Silk Lamp","Intelligent Aluminum Hat","Intelligent Aluminum Keyboard","Intelligent Copper Coat","Intelligent Cotton Bottle","Intelligent Cotton Shirt","Intelligent Linen Bottle","Intelligent Linen Coat","Intelligent Linen Pants","Intelligent Marble Car","Intelligent Steel Watch","Intelligent Wooden Lamp","Intelligent Wool Bench","Lightweight Bronze Knife","Lightweight Concrete Gloves","Lightweight Concrete Pants","Lightweight Copper Lamp","Lightweight Cotton Toucan","Lightweight Cotton Watch","Lightweight Linen Bench","Lightweight Marble Plate","Lightweight Rubber Toucan","Lightweight Steel Shoes","Mediocre Aluminum Car","Mediocre Bronze Bag","Mediocre Concrete Coat","Mediocre Concrete Keyboard","Mediocre Copper Clock","Mediocre Cotton Toucan","Mediocre Granite Shirt","Mediocre Iron Computer","Mediocre Iron Pants","Mediocre Marble Gloves","Mediocre Paper Keyboard","Mediocre Paper Knife","Mediocre Rubber Keyboard","Mediocre Steel Plate","Mediocre Wooden Bench","Practical Bronze Bottle","Practical Concrete Chair","Practical Concrete Coat","Practical Cotton Pants","Practical Linen Pants","Practical Marble Wallet","Practical Paper Bag","Practical Paper Coat","Practical Plastic Bottle","Practical Steel Bench","Practical Wooden Hat","Rustic Aluminum Bag","Rustic Aluminum Chair","Rustic Concrete Wallet","Rustic Concrete Watch","Rustic Copper Toucan","Rustic Granite Car","Rustic Iron Shoes","Rustic Paper Shirt","Rustic Silk Car","Rustic Steel Car","Rustic Wool Chair","Sleek Aluminum Gloves","Sleek Concrete Wallet","Sleek Iron Watch","Sleek Marble Table","Sleek Paper Bag","Sleek Plastic Coat","Sleek Rubber Hat","Sleek Rubber Wallet","Sleek Silk Hat","Sleek Steel Shirt","Sleek Wooden Shoes","Small Aluminum Clock","Small Concrete Pants","Small Copper Keyboard","Small Cotton Car","Small Leather Gloves","Small Leather Hat","Small Plastic Chair","Small Silk Clock","Synergistic Aluminum Coat","Synergistic Concrete Bottle","Synergistic Copper Bag","Synergistic Copper Computer","Synergistic Copper Knife","Synergistic Cotton Shoes","Synergistic Iron Computer","Synergistic Iron Plate","Synergistic Iron Table","Synergistic Leather Clock","Synergistic Leather Pants","Synergistic Leather Wallet","Synergistic Linen Gloves","Synergistic Marble Hat","Synergistic Marble Shoes","Synergistic Silk Coat","Synergistic Steel Computer","Synergistic Steel Keyboard","Synergistic Wooden Lamp"]	\N	28
7	2017-11-11 23:01:43.259+00	2017-11-11 23:01:43.259+00	[12.02,12.65,12.98,13.0,13.45,14.4,14.43,14.54,14.8,15.22,15.97,16.67,16.88,17.19,17.54,17.96,17.97,18.1,18.12,18.58,18.61,18.990000000000002,19.57,21.11,21.240000000000002,23.61,23.71,25.78,26.21,27.33,27.73,28.41,28.69,29.26,29.29,29.78,29.85,29.88,29.94,29.96,30.36,31.03,32.82,33.03,34.3,34.71,35.010000000000005,36.6,36.65,37.57,38.09,38.11,38.83,38.879999999999995,39.18,39.760000000000005,40.4,41.120000000000005,42.36,42.9,43.730000000000004,43.980000000000004,45.31,45.41,45.59,45.73,46.25,46.36,46.54,46.62,47.0,47.05,47.9,47.96,48.06,49.32,49.91,50.93,51.29,51.88,53.46,53.92,54.54,54.8,54.96,55.02,55.13,55.17,55.29,55.66,56.17,56.58,57.73,57.91,58.25,58.6,59.54,59.63,60.25,60.71,60.82,60.97,61.35,61.91,62.49,62.54,62.61,62.8,63.11,63.29,63.5,64.03999999999999,64.2,64.4,65.0,65.44,65.81,67.19,67.21000000000001,68.18,68.64,68.69,69.3,69.43,71.03,71.05,72.31,72.69,72.85,73.22999999999999,73.58,73.75,74.22999999999999,74.31,75.11,75.47,76.24,77.02,77.96,78.39,78.47,79.34,79.97,80.0,80.12,80.64,80.86,81.18,81.48,81.65,82.08,82.46,83.16,83.68,85.34,85.7,86.52,86.93,86.96,87.1,87.27,87.54,88.06,88.42,88.79,88.95,89.27,89.62,89.75,90.99,91.19,91.24,91.33,92.01,92.18,92.19,92.76,93.03,93.25,93.41,93.64,93.68,93.74,93.94,94.35,94.44,94.74,95.25,95.44,95.66,95.76,95.77,95.87,96.36,97.69,98.61,98.8,98.87,99.37]	\N	29
8	2017-11-11 23:01:43.291+00	2017-11-11 23:01:43.291+00	["Doohickey","Gadget","Gizmo","Widget"]	\N	30
9	2017-11-11 23:01:43.331+00	2017-11-11 23:01:43.331+00	["0081263418030","0150683335231","0185239502034","0201347937275","0208207181403","0261974470934","0450593824499","0462846675833","0527261609570","0599883657895","0613296792285","0733287944865","0743987954842","0819745416164","0876255689785","0913720145312","0914229448829","1003173925643","1019598007222","1027777413634","1108567994349","1130947253647","1244736031993","1283395751521","1390366619206","1430186044113","1432802681733","1440735016973","1476104734285","1587142162937","1606740630591","1625425260151","1633218970514","1724284499464","1726795662825","1801026003964","1858184158340","1926887866333","2046664571119","2057424007489","2077282258748","2078106782913","2094363929205","2149381484639","2240077906975","2244826857204","2353853855005","2498152357239","2514922888960","2515274618588","2560332097560","2572094119954","2589747445674","2624945894432","2722019668757","2762672356424","2803335755588","2913743729092","2935247201768","2938033762689","2989936456588","3059222939183","3080781792902","3089929364803","3118334524745","3200135109389","3226678873266","3235479371581","3261385634984","3334764533373","3343127930445","3358070674483","3411407056403","3454624707208","3534388962058","3542819341242","3648864003163","3689142177381","3689672959099","3701504839383","3714557062974","3728047817418","3780136305084","3829311382424","3879742526744","3933689939163","3934004122079","3939437705387","3971521899824","3985833737323","4015556386184","4068318015259","4131152317015","4193289449342","4221553469045","4228217525154","4656703199495","4703222961314","4748913930057","4891613299983","4898647510879","4899493515094","4909109126467","4950171429048","5205082703671","5258491206899","5267238529757","5284917631228","5318562718130","5351002838395","5426687059523","5477175520780","5523940493770","5615006385836","5686832827784","5741186110910","5771112616247","5772852431015","5988420267898","6009160326535","6073632260665","6120458312488","6171497601507","6173170156274","6180054790554","6196503111474","6197636796361","6199259041538","6227613464966","6403110696998","6413207051487","6416824409785","6453078636222","6456767967256","6705506344002","6880216006874","7139294454916","7287446823025","7452422313108","7482157209087","7542360044001","7639801548881","7895844498426","7922730966865","7924545660075","7944141819189","8083383752461","8151634708342","8183558709174","8187466015068","8271546277054","8277895988566","8284816768404","8288794103141","8356442660435","8437963733140","8515444130906","8520696853923","8522018181233","8535456864408","8546422079474","8633897297219","8636387954272","8648285961313","8789307982104","8839114765732","8852364185334","8873422508094","9042170508406","9085480422239","9097818301512","9140419880815","9162000550143","9169266143164","9181839646919","9213325070110","9228871749700","9238743606192","9300114400941","9346173882120","9364786294048","9390500817217","9425958763660","9543175947875","9549614545398","9584501019200","9589254266420","9620256814131","9622708968997","9623793944125","9681148795440","9779352889014","9796200542563","9872987974978","9889273603689","9927952606641","9965384839763","9978918957338","9991430183467","9999986852738"]	\N	32
10	2017-11-11 23:01:43.354+00	2017-11-11 23:01:43.354+00	[0.0,1.0,1.6,2.2,2.7,2.8,3.0,3.1,3.2,3.3,3.4,3.5,3.6,3.7,3.8,3.9,4.0,4.1,4.2,4.3,4.4,4.5,4.6,4.7,5.0]	\N	31
30	2017-11-12 23:37:26.742+00	2017-11-12 23:37:26.742+00	[null,null]	\N	215
31	2017-11-12 23:37:26.787+00	2017-11-12 23:37:26.787+00	[null,null]	\N	263
32	2017-11-12 23:37:26.842+00	2017-11-12 23:37:26.842+00	[null,null]	\N	122
33	2017-11-12 23:37:26.891+00	2017-11-12 23:37:26.891+00	[null,null]	\N	55
34	2017-11-12 23:37:27.002+00	2017-11-12 23:37:27.002+00	[0,315]	\N	308
35	2017-11-12 23:37:27.044+00	2017-11-12 23:37:27.044+00	[null,null]	\N	360
36	2017-11-12 23:37:27.116+00	2017-11-12 23:37:27.116+00	[null,null]	\N	438
37	2017-11-12 23:37:27.298+00	2017-11-12 23:37:27.298+00	[null,null]	\N	434
38	2017-11-12 23:37:27.383+00	2017-11-12 23:37:27.383+00	[null,null]	\N	435
39	2017-11-12 23:37:27.45+00	2017-11-12 23:37:27.45+00	[null,null]	\N	356
40	2017-11-12 23:37:27.527+00	2017-11-12 23:37:27.527+00	[null,null]	\N	353
41	2017-11-12 23:37:27.559+00	2017-11-12 23:37:27.559+00	["2012-01-01 00:00:00.000000","2017-11-12 23:34:13.098176","2017-11-12 23:36:27.994717","2017-11-12 23:37:01.059414"]	\N	477
42	2017-11-12 23:37:27.594+00	2017-11-12 23:37:27.594+00	[null,0]	\N	482
43	2017-11-12 23:37:27.629+00	2017-11-12 23:37:27.629+00	["PercentLibraries.PercentLibrariesTypeSphere","PercentLibraries.PercentLibraryPerAreaOfActivity","PercentLibraries.PercentPublicOrPrivateLibrary","PercentLibraries.QuantityOfRegisteredlibraries"]	\N	484
44	2017-11-12 23:37:27.653+00	2017-11-12 23:37:27.653+00	[0]	\N	485
45	2017-11-12 23:37:27.699+00	2017-11-12 23:37:27.699+00	[null,null]	\N	488
46	2017-11-12 23:37:27.73+00	2017-11-12 23:37:27.73+00	[null,0]	\N	483
\.


--
-- Data for Name: metabase_table; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) FROM stdin;
4	2017-11-11 23:01:36.235+00	2017-11-11 23:01:38.161+00	REVIEWS	1078	These are reviews our customers have left on products. Note that these are not tied to orders so it is possible people have reviewed products they did not purchase from us.	\N	\N	t	1	Reviews	\N	PUBLIC	\N	\N	\N	f
3	2017-11-11 23:01:36.223+00	2017-11-11 23:01:39.181+00	PEOPLE	2500	This is a user account. Note that employees and customer support staff will have accounts.	\N	\N	t	1	People	\N	PUBLIC	\N	\N	\N	f
2	2017-11-11 23:01:36.206+00	2017-11-11 23:01:41.078+00	ORDERS	17624	This is a confirmed order for a product from a user.	\N	\N	t	1	Orders	\N	PUBLIC	\N	\N	\N	f
1	2017-11-11 23:01:36.184+00	2017-11-11 23:01:41.968+00	PRODUCTS	200	This is our product catalog. It includes all products ever sold by the Sample Company.	\N	\N	t	1	Products	\N	PUBLIC	\N	\N	\N	f
6	2017-11-12 21:38:37.039+00	2017-11-12 22:50:10.042+00	per_occupation_area	30074	\N	\N	\N	f	2	Per Occupation Area	\N	\N	\N	\N	\N	f
13	2017-11-12 23:37:27.205+00	2017-11-12 23:37:27.205+00	percent_museums	\N	\N	\N	\N	t	2	Percent Museums	\N	\N	\N	\N	\N	f
5	2017-11-12 21:38:37.009+00	2017-11-12 23:50:07.581+00	percent_projects	6	\N	\N	\N	t	2	Percent Projects	\N	\N	\N	\N	\N	f
7	2017-11-12 21:38:37.093+00	2017-11-12 23:50:08.902+00	amount_agents_registered_per_month	3	\N	\N	\N	t	2	Amount Agents Registered Per Month	\N	\N	\N	\N	\N	f
8	2017-11-12 21:38:37.113+00	2017-11-12 23:50:09.163+00	percent_agents	6	\N	\N	\N	t	2	Percent Agents	\N	\N	\N	\N	\N	f
9	2017-11-12 21:38:37.126+00	2017-11-12 23:50:09.73+00	last_update_date	4	\N	\N	\N	t	2	Last Update Date	\N	\N	\N	\N	\N	f
10	2017-11-12 21:38:37.145+00	2017-11-12 23:50:09.787+00	percent_libraries	4	\N	\N	\N	t	2	Percent Libraries	\N	\N	\N	\N	\N	f
12	2017-11-12 23:34:53.741+00	2017-11-12 23:50:09.934+00	space_data	30074	\N	\N	\N	t	2	Space Data	\N	\N	\N	\N	\N	f
11	2017-11-12 21:38:37.155+00	2017-11-12 23:50:11.943+00	percent_event	6	\N	\N	\N	t	2	Percent Event	\N	\N	\N	\N	\N	f
\.


--
-- Data for Name: metric; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY metric (id, table_id, creator_id, name, description, is_active, definition, created_at, updated_at, points_of_interest, caveats, how_is_this_calculated, show_in_getting_started) FROM stdin;
\.


--
-- Data for Name: metric_important_field; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY metric_important_field (id, metric_id, field_id) FROM stdin;
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY permissions (id, object, group_id) FROM stdin;
1	/	2
2	/db/1/	1
3	/db/1/	3
4	/db/2/	1
5	/db/2/	3
\.


--
-- Data for Name: permissions_group; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY permissions_group (id, name) FROM stdin;
1	All Users
2	Administrators
3	MetaBot
\.


--
-- Data for Name: permissions_group_membership; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY permissions_group_membership (id, user_id, group_id) FROM stdin;
1	1	1
2	1	2
\.


--
-- Data for Name: permissions_revision; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY permissions_revision (id, before, after, user_id, created_at, remark) FROM stdin;
\.


--
-- Data for Name: pulse; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY pulse (id, creator_id, name, created_at, updated_at, skip_if_empty) FROM stdin;
\.


--
-- Data for Name: pulse_card; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY pulse_card (id, pulse_id, card_id, "position") FROM stdin;
\.


--
-- Data for Name: pulse_channel; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY pulse_channel (id, pulse_id, channel_type, details, schedule_type, schedule_hour, schedule_day, created_at, updated_at, schedule_frame, enabled) FROM stdin;
\.


--
-- Data for Name: pulse_channel_recipient; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY pulse_channel_recipient (id, pulse_channel_id, user_id) FROM stdin;
\.


--
-- Data for Name: query; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY query (query_hash, average_execution_time) FROM stdin;
\\x84881d6eed23f92773c544bc295953c6b410bdc2dc65cf8c4887c2d971504eb0	516
\\x76e3f6861b438289d4efe86bff7d75e281ffbb526fc5cf54a5638ee0e55fb3de	181
\\x0c480ddd387c202f81aa41f565e8f0ead01c888346a902b21bc58fa404811443	240
\\x0bcaaa171f5fc700467dabe355bfa55ee83099a0d38713c6eade37fd81d8514c	610
\\x96297fb5aabe8bf3b5b104b3752f4cfff759c03e2d952b47ad83c6d4fa81f5aa	85
\\xb1c5f6928fade2408e504d0c2fd65252134ab116f86cfe0c2de3378c55415358	153
\\xac6e9a2315fb7fc03901a5391da9ecb2c09381cbdbf887e1b00c4828390c4669	599
\\xc71d5697a0a286492485414de79a0e2b33b9769bf32b201f27ffdb3965bffc39	162
\\x1952eeb9cffeb4f6fa80e763f00b376d93655f00afff8a78550a2c550984247d	421
\\xd802fcb890d2a1f9c80453440931fae77acc21ceaf5a1c5cfeb982ca3dd674fb	181
\\xc8a70e7b5f24e721ab4a6769834fb2e82e2dd2aaaa1ff7fbd5584f7d47fad6ba	165
\\xc1a274c75a0bb7c0c62baa536b8bcf2c410f97b3c3d43c94e367b2f24d92bcf4	323
\\x52c4a8898e894a6f42b9886c9c9f08f7c9b63e49746e8f6943fd830451c540e0	208
\\x88271f7b1a9add0f10fad144188a2610223f2dbd5f28454d8a7b80c8af9216ea	261
\\x8d29764eb1e4047b26a4ad894d8bd8a7c05eb43b052bbb98292930396aa5168f	177
\\x763d2e33cfd27f813533fb85379c5d1e3ce95e945964ab212ae64189f587ffdb	188
\\xdca6e4879fab028bd0cab18736bd9ad9420c7c77402dda8adf7c9f0841740a1a	154
\\x88eeb4c2e5282e409658126381bc6ab7c4b36362a6ce85716ec6ed9a0c966fea	199
\\xf6a322c455aa3b3ae55d619f2bc7b429e47da617723e43747a8d8df1fa79ad85	167
\\xccc72961d06facfc2bb4ac6bd93f7c8c388dd9a10a3db987f414af9618707a1f	222
\\xaced65f234d10dacb85f4aa32e4ed099f1e843b09ea9b0a47f43cc2ea7cf841b	328
\\x7ab6fac22fac244c45e3043735bebf6f431e787092d8d274787aa4425e713ad6	190
\\x24c28b766852231f950565f54fa8f0bdebe7baeb8f06a6f428d273259699b274	176
\\xc2f4267218ed45e0d8954085f573e8dd030da9a34336bb8018a1b9b031ae49f8	182
\\xe444430b5f8a2c02f9315ff32aab54f74a48dace70d40acb2596b80d53ea21ea	204
\\xb7a9e91a682c4bdea3b8057b6cd9be1ce77e883c15fa96f9c8fe465a80dd5f6d	203
\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	74
\\xfce9c1e1627811d38682239f87c7eea7cc2df6e1b27c5229194342ed0a681901	184
\\xe23816f4f03e482400c6ef36b1ff52a5b4cffbe30dbb1b2006c683b94cd0f477	264
\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	436
\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	504
\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	426
\\x3eabb3700168d7d0b83264c933df64099e3594d2600eb05ec35d302fa75b6269	331
\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	523
\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	376
\.


--
-- Data for Name: query_cache; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY query_cache (query_hash, updated_at, results) FROM stdin;
\.


--
-- Data for Name: query_execution; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) FROM stdin;
1	\\x1952eeb9cffeb4f6fa80e763f00b376d93655f00afff8a78550a2c550984247d	2017-11-11 23:03:41.14	109	200	f	ad-hoc	\N	1	\N	\N	\N
2	\\x1952eeb9cffeb4f6fa80e763f00b376d93655f00afff8a78550a2c550984247d	2017-11-11 23:04:31.805	38	200	f	question	\N	1	1	\N	\N
3	\\x1952eeb9cffeb4f6fa80e763f00b376d93655f00afff8a78550a2c550984247d	2017-11-12 03:20:04.815	1259	200	f	question	\N	1	1	\N	\N
4	\\x1952eeb9cffeb4f6fa80e763f00b376d93655f00afff8a78550a2c550984247d	2017-11-12 03:21:38.266	106	200	f	question	\N	1	1	\N	\N
5	\\x1952eeb9cffeb4f6fa80e763f00b376d93655f00afff8a78550a2c550984247d	2017-11-12 03:30:04.433	84	200	f	question	\N	1	1	\N	\N
6	\\x1952eeb9cffeb4f6fa80e763f00b376d93655f00afff8a78550a2c550984247d	2017-11-12 03:30:49.16	90	200	f	question	\N	1	1	\N	\N
7	\\x1952eeb9cffeb4f6fa80e763f00b376d93655f00afff8a78550a2c550984247d	2017-11-12 03:31:13.873	86	200	f	embedded-dashboard	\N	1	1	1	\N
8	\\x1952eeb9cffeb4f6fa80e763f00b376d93655f00afff8a78550a2c550984247d	2017-11-12 03:31:31.424	73	200	f	question	\N	1	1	\N	\N
9	\\x1952eeb9cffeb4f6fa80e763f00b376d93655f00afff8a78550a2c550984247d	2017-11-12 03:31:38.953	69	200	f	question	\N	1	1	\N	\N
10	\\x1952eeb9cffeb4f6fa80e763f00b376d93655f00afff8a78550a2c550984247d	2017-11-12 03:33:20.91	87	200	f	embedded-question	\N	1	1	\N	\N
11	\\x84881d6eed23f92773c544bc295953c6b410bdc2dc65cf8c4887c2d971504eb0	2017-11-12 21:42:02.119	516	172	f	ad-hoc	\N	1	\N	\N	\N
12	\\xf6a322c455aa3b3ae55d619f2bc7b429e47da617723e43747a8d8df1fa79ad85	2017-11-12 21:42:17.662	339	172	f	ad-hoc	\N	1	\N	\N	\N
13	\\xf6a322c455aa3b3ae55d619f2bc7b429e47da617723e43747a8d8df1fa79ad85	2017-11-12 21:42:43.895	320	172	f	question	\N	1	2	\N	\N
14	\\x1952eeb9cffeb4f6fa80e763f00b376d93655f00afff8a78550a2c550984247d	2017-11-12 21:42:43.434	1519	200	f	question	\N	1	1	\N	\N
15	\\xf6a322c455aa3b3ae55d619f2bc7b429e47da617723e43747a8d8df1fa79ad85	2017-11-12 21:43:05.568	239	172	f	question	\N	1	2	\N	\N
16	\\xf6a322c455aa3b3ae55d619f2bc7b429e47da617723e43747a8d8df1fa79ad85	2017-11-12 21:43:17.131	209	172	f	embedded-question	\N	1	2	\N	\N
17	\\xf6a322c455aa3b3ae55d619f2bc7b429e47da617723e43747a8d8df1fa79ad85	2017-11-12 22:48:55.818	385	172	f	embedded-question	\N	1	2	\N	\N
18	\\xf6a322c455aa3b3ae55d619f2bc7b429e47da617723e43747a8d8df1fa79ad85	2017-11-12 22:49:10.49	207	172	f	embedded-question	\N	1	2	\N	\N
19	\\x76e3f6861b438289d4efe86bff7d75e281ffbb526fc5cf54a5638ee0e55fb3de	2017-11-12 22:49:35.175	181	2000	f	ad-hoc	\N	1	\N	\N	\N
20	\\x0bcaaa171f5fc700467dabe355bfa55ee83099a0d38713c6eade37fd81d8514c	2017-11-12 22:50:08.537	653	1111	f	ad-hoc	\N	1	\N	\N	\N
21	\\x0c480ddd387c202f81aa41f565e8f0ead01c888346a902b21bc58fa404811443	2017-11-12 22:51:50.603	240	1111	f	ad-hoc	\N	1	\N	\N	\N
22	\\x0bcaaa171f5fc700467dabe355bfa55ee83099a0d38713c6eade37fd81d8514c	2017-11-12 22:52:58.065	226	1111	f	ad-hoc	\N	1	\N	\N	\N
23	\\x96297fb5aabe8bf3b5b104b3752f4cfff759c03e2d952b47ad83c6d4fa81f5aa	2017-11-12 22:53:02.718	85	1	f	ad-hoc	\N	1	\N	\N	\N
24	\\x96297fb5aabe8bf3b5b104b3752f4cfff759c03e2d952b47ad83c6d4fa81f5aa	2017-11-12 22:53:10.577	84	1	f	ad-hoc	\N	1	\N	\N	\N
25	\\xb1c5f6928fade2408e504d0c2fd65252134ab116f86cfe0c2de3378c55415358	2017-11-12 22:53:23.611	153	1	f	ad-hoc	\N	1	\N	\N	\N
26	\\xac6e9a2315fb7fc03901a5391da9ecb2c09381cbdbf887e1b00c4828390c4669	2017-11-12 22:55:20.686	599	5804	f	ad-hoc	\N	1	\N	\N	\N
27	\\xc71d5697a0a286492485414de79a0e2b33b9769bf32b201f27ffdb3965bffc39	2017-11-12 22:56:12.821	162	24	f	ad-hoc	\N	1	\N	\N	\N
28	\\xd802fcb890d2a1f9c80453440931fae77acc21ceaf5a1c5cfeb982ca3dd674fb	2017-11-12 23:01:01.613	170	54	f	ad-hoc	\N	1	\N	\N	\N
29	\\xf6a322c455aa3b3ae55d619f2bc7b429e47da617723e43747a8d8df1fa79ad85	2017-11-12 23:01:26.471	340	172	f	question	\N	1	2	\N	\N
30	\\xd802fcb890d2a1f9c80453440931fae77acc21ceaf5a1c5cfeb982ca3dd674fb	2017-11-12 23:01:26.91	281	54	f	question	\N	1	3	\N	\N
31	\\x1952eeb9cffeb4f6fa80e763f00b376d93655f00afff8a78550a2c550984247d	2017-11-12 23:01:26.489	1643	200	f	question	\N	1	1	\N	\N
32	\\xd802fcb890d2a1f9c80453440931fae77acc21ceaf5a1c5cfeb982ca3dd674fb	2017-11-12 23:01:57.996	178	54	f	question	\N	1	3	\N	\N
33	\\xccc72961d06facfc2bb4ac6bd93f7c8c388dd9a10a3db987f414af9618707a1f	2017-11-12 23:02:07.036	235	131	f	ad-hoc	\N	1	\N	\N	\N
34	\\xc8a70e7b5f24e721ab4a6769834fb2e82e2dd2aaaa1ff7fbd5584f7d47fad6ba	2017-11-12 23:03:08.898	165	131	f	ad-hoc	\N	1	\N	\N	\N
35	\\x24c28b766852231f950565f54fa8f0bdebe7baeb8f06a6f428d273259699b274	2017-11-12 23:03:36.211	223	131	f	ad-hoc	\N	1	\N	\N	\N
36	\\x7ab6fac22fac244c45e3043735bebf6f431e787092d8d274787aa4425e713ad6	2017-11-12 23:04:57.974	211	54	f	ad-hoc	\N	1	\N	\N	\N
37	\\x7ab6fac22fac244c45e3043735bebf6f431e787092d8d274787aa4425e713ad6	2017-11-12 23:05:12.802	134	54	f	ad-hoc	\N	1	\N	\N	\N
38	\\xccc72961d06facfc2bb4ac6bd93f7c8c388dd9a10a3db987f414af9618707a1f	2017-11-12 23:05:41.782	331	131	f	question	\N	1	3	\N	\N
39	\\xf6a322c455aa3b3ae55d619f2bc7b429e47da617723e43747a8d8df1fa79ad85	2017-11-12 23:05:41.775	357	172	f	question	\N	1	2	\N	\N
40	\\x7ab6fac22fac244c45e3043735bebf6f431e787092d8d274787aa4425e713ad6	2017-11-12 23:05:42.155	193	54	f	question	\N	1	4	\N	\N
41	\\x24c28b766852231f950565f54fa8f0bdebe7baeb8f06a6f428d273259699b274	2017-11-12 23:06:16.067	193	131	f	ad-hoc	\N	1	\N	\N	\N
42	\\xf6a322c455aa3b3ae55d619f2bc7b429e47da617723e43747a8d8df1fa79ad85	2017-11-12 23:07:10.67	413	172	f	question	\N	1	2	\N	\N
43	\\x7ab6fac22fac244c45e3043735bebf6f431e787092d8d274787aa4425e713ad6	2017-11-12 23:07:10.672	451	54	f	question	\N	1	4	\N	\N
44	\\xccc72961d06facfc2bb4ac6bd93f7c8c388dd9a10a3db987f414af9618707a1f	2017-11-12 23:07:10.676	482	131	f	question	\N	1	3	\N	\N
45	\\x24c28b766852231f950565f54fa8f0bdebe7baeb8f06a6f428d273259699b274	2017-11-12 23:07:11.055	223	131	f	question	\N	1	5	\N	\N
46	\\xc1a274c75a0bb7c0c62baa536b8bcf2c410f97b3c3d43c94e367b2f24d92bcf4	2017-11-12 23:07:32.01	323	9	f	ad-hoc	\N	1	\N	\N	\N
47	\\xf6a322c455aa3b3ae55d619f2bc7b429e47da617723e43747a8d8df1fa79ad85	2017-11-12 23:07:52.165	272	172	f	question	\N	1	2	\N	\N
48	\\x7ab6fac22fac244c45e3043735bebf6f431e787092d8d274787aa4425e713ad6	2017-11-12 23:07:52.223	262	54	f	question	\N	1	4	\N	\N
49	\\xccc72961d06facfc2bb4ac6bd93f7c8c388dd9a10a3db987f414af9618707a1f	2017-11-12 23:07:52.165	323	131	f	question	\N	1	3	\N	\N
50	\\x52c4a8898e894a6f42b9886c9c9f08f7c9b63e49746e8f6943fd830451c540e0	2017-11-12 23:08:29.53	208	54	f	ad-hoc	\N	1	\N	\N	\N
51	\\x24c28b766852231f950565f54fa8f0bdebe7baeb8f06a6f428d273259699b274	2017-11-12 23:08:41.868	167	131	f	ad-hoc	\N	1	\N	\N	\N
52	\\xf6a322c455aa3b3ae55d619f2bc7b429e47da617723e43747a8d8df1fa79ad85	2017-11-12 23:08:55.575	315	172	f	question	\N	1	2	\N	\N
53	\\x7ab6fac22fac244c45e3043735bebf6f431e787092d8d274787aa4425e713ad6	2017-11-12 23:08:55.65	316	54	f	question	\N	1	4	\N	\N
54	\\xccc72961d06facfc2bb4ac6bd93f7c8c388dd9a10a3db987f414af9618707a1f	2017-11-12 23:08:55.586	504	131	f	question	\N	1	3	\N	\N
55	\\x24c28b766852231f950565f54fa8f0bdebe7baeb8f06a6f428d273259699b274	2017-11-12 23:08:55.94	272	131	f	question	\N	1	6	\N	\N
56	\\x24c28b766852231f950565f54fa8f0bdebe7baeb8f06a6f428d273259699b274	2017-11-12 23:09:13.043	168	131	f	question	\N	1	6	\N	\N
57	\\x88271f7b1a9add0f10fad144188a2610223f2dbd5f28454d8a7b80c8af9216ea	2017-11-12 23:09:41.275	261	72	f	ad-hoc	\N	1	\N	\N	\N
58	\\x24c28b766852231f950565f54fa8f0bdebe7baeb8f06a6f428d273259699b274	2017-11-12 23:10:08.8	233	131	f	ad-hoc	\N	1	\N	\N	\N
59	\\x7ab6fac22fac244c45e3043735bebf6f431e787092d8d274787aa4425e713ad6	2017-11-12 23:10:18.797	340	54	f	question	\N	1	4	\N	\N
60	\\xf6a322c455aa3b3ae55d619f2bc7b429e47da617723e43747a8d8df1fa79ad85	2017-11-12 23:10:18.782	386	172	f	question	\N	1	2	\N	\N
61	\\xccc72961d06facfc2bb4ac6bd93f7c8c388dd9a10a3db987f414af9618707a1f	2017-11-12 23:10:18.788	394	131	f	question	\N	1	3	\N	\N
62	\\x24c28b766852231f950565f54fa8f0bdebe7baeb8f06a6f428d273259699b274	2017-11-12 23:10:18.799	404	131	f	question	\N	1	6	\N	\N
63	\\xf6a322c455aa3b3ae55d619f2bc7b429e47da617723e43747a8d8df1fa79ad85	2017-11-12 23:34:15.641	313	0	f	embedded-question	\N	1	2	\N	\N
64	\\x7ab6fac22fac244c45e3043735bebf6f431e787092d8d274787aa4425e713ad6	2017-11-12 23:35:21.986	230	0	f	question	\N	1	4	\N	\N
65	\\xf6a322c455aa3b3ae55d619f2bc7b429e47da617723e43747a8d8df1fa79ad85	2017-11-12 23:35:21.978	289	0	f	question	\N	1	2	\N	\N
66	\\xccc72961d06facfc2bb4ac6bd93f7c8c388dd9a10a3db987f414af9618707a1f	2017-11-12 23:35:21.984	273	0	f	question	\N	1	3	\N	\N
67	\\x24c28b766852231f950565f54fa8f0bdebe7baeb8f06a6f428d273259699b274	2017-11-12 23:35:21.997	244	0	f	question	\N	1	6	\N	\N
68	\\xf6a322c455aa3b3ae55d619f2bc7b429e47da617723e43747a8d8df1fa79ad85	2017-11-12 23:35:23.706	102	0	f	question	\N	1	2	\N	\N
69	\\x24c28b766852231f950565f54fa8f0bdebe7baeb8f06a6f428d273259699b274	2017-11-12 23:35:35.606	163	0	f	question	\N	1	6	\N	\N
70	\\x7ab6fac22fac244c45e3043735bebf6f431e787092d8d274787aa4425e713ad6	2017-11-12 23:35:35.609	186	0	f	question	\N	1	4	\N	\N
71	\\xccc72961d06facfc2bb4ac6bd93f7c8c388dd9a10a3db987f414af9618707a1f	2017-11-12 23:35:35.607	213	0	f	question	\N	1	3	\N	\N
72	\\xf6a322c455aa3b3ae55d619f2bc7b429e47da617723e43747a8d8df1fa79ad85	2017-11-12 23:35:35.653	171	0	f	question	\N	1	2	\N	\N
73	\\xf6a322c455aa3b3ae55d619f2bc7b429e47da617723e43747a8d8df1fa79ad85	2017-11-12 23:35:37.122	85	0	f	question	\N	1	2	\N	\N
74	\\xf6a322c455aa3b3ae55d619f2bc7b429e47da617723e43747a8d8df1fa79ad85	2017-11-12 23:36:14.866	83	0	f	question	\N	1	2	\N	\N
75	\\xccc72961d06facfc2bb4ac6bd93f7c8c388dd9a10a3db987f414af9618707a1f	2017-11-12 23:36:14.866	151	0	f	question	\N	1	3	\N	\N
77	\\x7ab6fac22fac244c45e3043735bebf6f431e787092d8d274787aa4425e713ad6	2017-11-12 23:36:14.882	155	0	f	question	\N	1	4	\N	\N
88	\\xf6a322c455aa3b3ae55d619f2bc7b429e47da617723e43747a8d8df1fa79ad85	2017-11-12 23:38:34.486	137	0	f	question	\N	1	2	\N	\N
95	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-12 23:39:45.578	390	172	f	question	\N	1	2	\N	\N
96	\\xccc72961d06facfc2bb4ac6bd93f7c8c388dd9a10a3db987f414af9618707a1f	2017-11-12 23:39:48.086	50	0	f	question	\N	1	3	\N	\N
97	\\xaced65f234d10dacb85f4aa32e4ed099f1e843b09ea9b0a47f43cc2ea7cf841b	2017-11-12 23:40:02.72	328	54	f	ad-hoc	\N	1	\N	\N	\N
101	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-12 23:40:53.168	306	172	f	question	\N	1	2	\N	\N
103	\\x7ab6fac22fac244c45e3043735bebf6f431e787092d8d274787aa4425e713ad6	2017-11-12 23:41:00.001	32	0	f	question	\N	1	4	\N	\N
105	\\x24c28b766852231f950565f54fa8f0bdebe7baeb8f06a6f428d273259699b274	2017-11-12 23:41:55.79	172	0	f	question	\N	1	6	\N	\N
109	\\x24c28b766852231f950565f54fa8f0bdebe7baeb8f06a6f428d273259699b274	2017-11-12 23:41:58.383	33	0	f	question	\N	1	6	\N	\N
110	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-12 23:42:22.046	177	131	f	ad-hoc	\N	1	\N	\N	\N
76	\\x24c28b766852231f950565f54fa8f0bdebe7baeb8f06a6f428d273259699b274	2017-11-12 23:36:14.888	121	0	f	question	\N	1	6	\N	\N
78	\\xf6a322c455aa3b3ae55d619f2bc7b429e47da617723e43747a8d8df1fa79ad85	2017-11-12 23:36:15.986	69	0	f	question	\N	1	2	\N	\N
79	\\xf6a322c455aa3b3ae55d619f2bc7b429e47da617723e43747a8d8df1fa79ad85	2017-11-12 23:36:29.37	45	0	f	embedded-question	\N	1	2	\N	\N
80	\\xf6a322c455aa3b3ae55d619f2bc7b429e47da617723e43747a8d8df1fa79ad85	2017-11-12 23:37:02.013	109	0	f	embedded-question	\N	1	2	\N	\N
84	\\x7ab6fac22fac244c45e3043735bebf6f431e787092d8d274787aa4425e713ad6	2017-11-12 23:38:02.04	190	0	f	question	\N	1	4	\N	\N
85	\\xf6a322c455aa3b3ae55d619f2bc7b429e47da617723e43747a8d8df1fa79ad85	2017-11-12 23:38:03.279	45	0	f	question	\N	1	2	\N	\N
86	\\xccc72961d06facfc2bb4ac6bd93f7c8c388dd9a10a3db987f414af9618707a1f	2017-11-12 23:38:34.485	124	0	f	question	\N	1	3	\N	\N
87	\\x7ab6fac22fac244c45e3043735bebf6f431e787092d8d274787aa4425e713ad6	2017-11-12 23:38:34.504	121	0	f	question	\N	1	4	\N	\N
90	\\xf6a322c455aa3b3ae55d619f2bc7b429e47da617723e43747a8d8df1fa79ad85	2017-11-12 23:38:35.433	72	0	f	question	\N	1	2	\N	\N
92	\\x7ab6fac22fac244c45e3043735bebf6f431e787092d8d274787aa4425e713ad6	2017-11-12 23:39:45.578	198	0	f	question	\N	1	4	\N	\N
99	\\x7ab6fac22fac244c45e3043735bebf6f431e787092d8d274787aa4425e713ad6	2017-11-12 23:40:53.18	134	0	f	question	\N	1	4	\N	\N
104	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-12 23:41:25.825	144	54	f	ad-hoc	\N	1	\N	\N	\N
106	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-12 23:41:55.748	271	172	f	question	\N	1	2	\N	\N
107	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-12 23:41:55.775	348	54	f	question	\N	1	4	\N	\N
81	\\x24c28b766852231f950565f54fa8f0bdebe7baeb8f06a6f428d273259699b274	2017-11-12 23:38:02.038	107	0	f	question	\N	1	6	\N	\N
83	\\xccc72961d06facfc2bb4ac6bd93f7c8c388dd9a10a3db987f414af9618707a1f	2017-11-12 23:38:02.035	179	0	f	question	\N	1	3	\N	\N
82	\\xf6a322c455aa3b3ae55d619f2bc7b429e47da617723e43747a8d8df1fa79ad85	2017-11-12 23:38:01.993	131	0	f	question	\N	1	2	\N	\N
89	\\x24c28b766852231f950565f54fa8f0bdebe7baeb8f06a6f428d273259699b274	2017-11-12 23:38:34.509	135	0	f	question	\N	1	6	\N	\N
91	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-12 23:39:07.903	190	172	f	ad-hoc	\N	1	\N	\N	\N
93	\\xccc72961d06facfc2bb4ac6bd93f7c8c388dd9a10a3db987f414af9618707a1f	2017-11-12 23:39:45.588	105	0	f	question	\N	1	3	\N	\N
94	\\x24c28b766852231f950565f54fa8f0bdebe7baeb8f06a6f428d273259699b274	2017-11-12 23:39:45.667	218	0	f	question	\N	1	6	\N	\N
98	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-12 23:40:31.875	220	131	f	ad-hoc	\N	1	\N	\N	\N
100	\\x24c28b766852231f950565f54fa8f0bdebe7baeb8f06a6f428d273259699b274	2017-11-12 23:40:53.226	108	0	f	question	\N	1	6	\N	\N
102	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-12 23:40:53.18	416	131	f	question	\N	1	3	\N	\N
108	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-12 23:41:55.806	427	131	f	question	\N	1	3	\N	\N
111	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-12 23:42:49.001	287	54	f	question	\N	1	4	\N	\N
113	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-12 23:42:48.991	421	131	f	question	\N	1	3	\N	\N
112	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-12 23:42:48.985	371	172	f	question	\N	1	2	\N	\N
114	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-12 23:42:49.019	406	131	f	question	\N	1	6	\N	\N
115	\\xc2f4267218ed45e0d8954085f573e8dd030da9a34336bb8018a1b9b031ae49f8	2017-11-12 23:43:19.306	187	256	f	ad-hoc	\N	1	\N	\N	\N
116	\\xc2f4267218ed45e0d8954085f573e8dd030da9a34336bb8018a1b9b031ae49f8	2017-11-12 23:45:49.192	134	256	f	ad-hoc	\N	1	\N	\N	\N
117	\\xe444430b5f8a2c02f9315ff32aab54f74a48dace70d40acb2596b80d53ea21ea	2017-11-12 23:46:18.006	211	256	f	ad-hoc	\N	1	\N	\N	\N
118	\\xe444430b5f8a2c02f9315ff32aab54f74a48dace70d40acb2596b80d53ea21ea	2017-11-12 23:46:23.433	145	256	f	ad-hoc	\N	1	\N	\N	\N
119	\\xb7a9e91a682c4bdea3b8057b6cd9be1ce77e883c15fa96f9c8fe465a80dd5f6d	2017-11-12 23:46:31.419	203	256	f	ad-hoc	\N	1	\N	\N	\N
120	\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	2017-11-12 23:46:55.179	74	1	f	ad-hoc	\N	1	\N	\N	\N
121	\\xfce9c1e1627811d38682239f87c7eea7cc2df6e1b27c5229194342ed0a681901	2017-11-12 23:47:00.513	184	3	f	ad-hoc	\N	1	\N	\N	\N
122	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-12 23:47:07.424	183	256	f	ad-hoc	\N	1	\N	\N	\N
123	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-12 23:47:48.579	178	256	f	ad-hoc	\N	1	\N	\N	\N
124	\\xe23816f4f03e482400c6ef36b1ff52a5b4cffbe30dbb1b2006c683b94cd0f477	2017-11-12 23:48:55.295	264	4047	f	ad-hoc	\N	1	\N	\N	\N
125	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-12 23:48:58.608	192	256	f	ad-hoc	\N	1	\N	\N	\N
126	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-12 23:51:17.611	296	172	f	question	\N	1	2	\N	\N
127	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-12 23:51:17.679	361	54	f	question	\N	1	4	\N	\N
128	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-12 23:51:17.676	446	131	f	question	\N	1	3	\N	\N
129	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-12 23:51:17.679	471	131	f	question	\N	1	6	\N	\N
130	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-12 23:51:18.141	198	256	f	question	\N	1	7	\N	\N
131	\\x3eabb3700168d7d0b83264c933df64099e3594d2600eb05ec35d302fa75b6269	2017-11-12 23:51:41.5	331	30	f	ad-hoc	\N	1	\N	\N	\N
132	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-12 23:51:46.202	283	54	f	question	\N	1	4	\N	\N
133	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-12 23:51:46.241	286	172	f	question	\N	1	2	\N	\N
134	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-12 23:51:46.202	349	131	f	question	\N	1	6	\N	\N
135	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-12 23:51:46.209	358	131	f	question	\N	1	3	\N	\N
136	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-12 23:51:50.847	254	172	f	question	\N	1	2	\N	\N
137	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-12 23:51:50.88	258	54	f	question	\N	1	4	\N	\N
138	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-12 23:51:50.851	348	131	f	question	\N	1	3	\N	\N
139	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-12 23:51:50.9	326	131	f	question	\N	1	6	\N	\N
140	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-12 23:52:16.97	155	256	f	question	\N	1	7	\N	\N
141	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-12 23:52:22.569	264	54	f	question	\N	1	4	\N	\N
142	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-12 23:52:22.559	393	172	f	question	\N	1	2	\N	\N
143	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-12 23:52:22.568	443	131	f	question	\N	1	3	\N	\N
144	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-12 23:52:22.57	494	131	f	question	\N	1	6	\N	\N
145	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-12 23:52:22.876	243	256	f	question	\N	1	7	\N	\N
146	\\x8d29764eb1e4047b26a4ad894d8bd8a7c05eb43b052bbb98292930396aa5168f	2017-11-12 23:52:52.738	177	18	f	ad-hoc	\N	1	\N	\N	\N
147	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-12 23:53:03.055	362	172	f	question	\N	1	2	\N	\N
148	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-12 23:53:03.06	376	54	f	question	\N	1	4	\N	\N
149	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-12 23:53:03.084	342	256	f	question	\N	1	7	\N	\N
150	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-12 23:53:03.058	410	131	f	question	\N	1	3	\N	\N
151	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-12 23:53:03.077	410	131	f	question	\N	1	6	\N	\N
152	\\x763d2e33cfd27f813533fb85379c5d1e3ce95e945964ab212ae64189f587ffdb	2017-11-12 23:53:16.103	188	10	f	ad-hoc	\N	1	\N	\N	\N
153	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-12 23:53:23.869	319	172	f	question	\N	1	2	\N	\N
154	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-12 23:53:23.955	399	256	f	question	\N	1	7	\N	\N
155	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-12 23:53:23.891	481	131	f	question	\N	1	3	\N	\N
156	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-12 23:53:23.902	511	54	f	question	\N	1	4	\N	\N
157	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-12 23:53:23.899	540	131	f	question	\N	1	6	\N	\N
158	\\xdca6e4879fab028bd0cab18736bd9ad9420c7c77402dda8adf7c9f0841740a1a	2017-11-12 23:53:52.983	154	14	f	ad-hoc	\N	1	\N	\N	\N
159	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-12 23:53:57.084	296	54	f	question	\N	1	4	\N	\N
160	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-12 23:53:57.056	336	172	f	question	\N	1	2	\N	\N
161	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-12 23:53:57.113	399	256	f	question	\N	1	7	\N	\N
162	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-12 23:53:57.075	452	131	f	question	\N	1	3	\N	\N
163	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-12 23:53:57.101	420	131	f	question	\N	1	6	\N	\N
164	\\x88eeb4c2e5282e409658126381bc6ab7c4b36362a6ce85716ec6ed9a0c966fea	2017-11-12 23:54:04.153	199	42	f	ad-hoc	\N	1	\N	\N	\N
165	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-12 23:54:09.88	381	256	f	question	\N	1	7	\N	\N
166	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-12 23:54:09.87	457	172	f	question	\N	1	2	\N	\N
167	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-12 23:54:09.866	468	131	f	question	\N	1	3	\N	\N
168	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-12 23:54:09.871	509	54	f	question	\N	1	4	\N	\N
169	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-12 23:54:09.871	539	131	f	question	\N	1	6	\N	\N
170	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-12 23:54:57.631	146	131	f	question	\N	1	6	\N	\N
171	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-12 23:55:01.381	312	172	f	question	\N	1	2	\N	\N
172	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-12 23:55:01.431	444	54	f	question	\N	1	4	\N	\N
173	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-12 23:55:01.423	474	131	f	question	\N	1	3	\N	\N
174	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-12 23:55:01.452	445	256	f	question	\N	1	7	\N	\N
175	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-12 23:55:01.439	496	131	f	question	\N	1	6	\N	\N
176	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-12 23:59:21.339	977	256	f	embedded-dashboard	\N	1	7	1	\N
177	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-12 23:59:21.341	1014	172	f	embedded-dashboard	\N	1	2	1	\N
178	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-12 23:59:21.338	1085	54	f	embedded-dashboard	\N	1	4	1	\N
179	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-12 23:59:21.34	1103	131	f	embedded-dashboard	\N	1	3	1	\N
180	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-12 23:59:21.339	1116	131	f	embedded-dashboard	\N	1	6	1	\N
181	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-12 23:59:38.288	561	172	f	embedded-dashboard	\N	1	2	1	\N
182	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-12 23:59:38.396	564	256	f	embedded-dashboard	\N	1	7	1	\N
183	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-12 23:59:38.309	660	54	f	embedded-dashboard	\N	1	4	1	\N
184	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-12 23:59:38.325	648	131	f	embedded-dashboard	\N	1	3	1	\N
185	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-12 23:59:38.369	705	131	f	embedded-dashboard	\N	1	6	1	\N
186	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-12 23:59:58.379	478	54	f	embedded-dashboard	\N	1	4	1	\N
187	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-12 23:59:58.269	671	172	f	embedded-dashboard	\N	1	2	1	\N
188	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-12 23:59:58.379	687	131	f	embedded-dashboard	\N	1	3	1	\N
189	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-12 23:59:58.38	761	256	f	embedded-dashboard	\N	1	7	1	\N
190	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-12 23:59:58.396	754	131	f	embedded-dashboard	\N	1	6	1	\N
191	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 00:00:09.596	441	172	f	embedded-dashboard	\N	1	2	1	\N
192	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-13 00:00:09.628	549	54	f	embedded-dashboard	\N	1	4	1	\N
193	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-13 00:00:09.779	515	256	f	embedded-dashboard	\N	1	7	1	\N
194	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-13 00:00:09.714	677	131	f	embedded-dashboard	\N	1	3	1	\N
195	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-13 00:00:09.715	713	131	f	embedded-dashboard	\N	1	6	1	\N
196	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 00:00:22.784	431	172	f	embedded-dashboard	\N	1	2	1	\N
197	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-13 00:00:22.828	562	131	f	embedded-dashboard	\N	1	3	1	\N
198	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-13 00:00:22.815	683	54	f	embedded-dashboard	\N	1	4	1	\N
199	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-13 00:00:22.966	547	256	f	embedded-dashboard	\N	1	7	1	\N
200	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-13 00:00:22.857	754	131	f	embedded-dashboard	\N	1	6	1	\N
201	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 00:00:36.042	467	172	f	embedded-dashboard	\N	1	2	1	\N
202	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-13 00:00:36.046	613	54	f	embedded-dashboard	\N	1	4	1	\N
203	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-13 00:00:36.114	611	256	f	embedded-dashboard	\N	1	7	1	\N
204	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-13 00:00:36.104	633	131	f	embedded-dashboard	\N	1	3	1	\N
205	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-13 00:00:36.112	642	131	f	embedded-dashboard	\N	1	6	1	\N
206	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 00:00:59.304	486	172	f	embedded-dashboard	\N	1	2	1	\N
207	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-13 00:00:59.48	347	256	f	embedded-dashboard	\N	1	7	1	\N
208	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-13 00:00:59.325	539	54	f	embedded-dashboard	\N	1	4	1	\N
209	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-13 00:00:59.362	547	131	f	embedded-dashboard	\N	1	6	1	\N
210	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-13 00:00:59.471	465	131	f	embedded-dashboard	\N	1	3	1	\N
211	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 00:04:26.134	170	172	f	question	\N	1	2	\N	\N
212	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 00:05:36.426	364	172	f	question	\N	1	2	\N	\N
213	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-13 00:05:36.45	566	131	f	question	\N	1	3	\N	\N
214	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-13 00:05:36.464	672	54	f	question	\N	1	4	\N	\N
215	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-13 00:05:36.546	608	256	f	question	\N	1	7	\N	\N
216	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-13 00:05:36.48	718	131	f	question	\N	1	6	\N	\N
217	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-13 00:05:40.904	173	54	f	question	\N	1	4	\N	\N
218	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 00:07:08.165	396	172	f	question	\N	1	2	\N	\N
219	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-13 00:07:08.246	335	256	f	question	\N	1	7	\N	\N
220	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-13 00:07:08.173	491	54	f	question	\N	1	4	\N	\N
221	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-13 00:07:08.176	549	131	f	question	\N	1	3	\N	\N
222	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-13 00:07:08.177	561	131	f	question	\N	1	6	\N	\N
223	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-13 00:07:16.243	179	131	f	question	\N	1	6	\N	\N
224	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-13 00:07:34.075	244	54	f	question	\N	1	4	\N	\N
225	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-13 00:07:34.08	509	131	f	question	\N	1	6	\N	\N
226	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 00:07:34.07	577	172	f	question	\N	1	2	\N	\N
227	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-13 00:07:34.129	539	256	f	question	\N	1	7	\N	\N
228	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-13 00:07:34.078	624	131	f	question	\N	1	3	\N	\N
229	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-13 00:07:41.258	164	131	f	question	\N	1	3	\N	\N
230	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 00:08:14.643	373	172	f	question	\N	1	2	\N	\N
231	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-13 00:08:14.727	448	54	f	question	\N	1	4	\N	\N
232	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-13 00:08:14.708	504	256	f	question	\N	1	7	\N	\N
233	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-13 00:08:14.676	561	131	f	question	\N	1	6	\N	\N
234	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-13 00:08:14.705	534	131	f	question	\N	1	3	\N	\N
235	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-13 00:08:25.192	140	256	f	question	\N	1	7	\N	\N
236	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 00:09:41.357	408	172	f	question	\N	1	2	\N	\N
237	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-13 00:09:41.39	467	54	f	question	\N	1	4	\N	\N
238	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-13 00:09:41.387	461	131	f	question	\N	1	3	\N	\N
239	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-13 00:09:41.462	458	131	f	question	\N	1	6	\N	\N
240	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-13 00:09:41.445	508	256	f	question	\N	1	7	\N	\N
241	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-13 00:09:55.004	135	54	f	question	\N	1	4	\N	\N
242	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 00:10:10.69	270	172	f	question	\N	1	2	\N	\N
243	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-13 00:10:10.81	363	256	f	question	\N	1	7	\N	\N
244	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-13 00:10:10.697	517	54	f	question	\N	1	4	\N	\N
245	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-13 00:10:10.691	581	131	f	question	\N	1	3	\N	\N
246	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-13 00:10:10.725	553	131	f	question	\N	1	6	\N	\N
247	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-13 00:10:20.92	362	256	f	embedded-dashboard	\N	1	7	1	\N
248	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 00:10:20.751	570	172	f	embedded-dashboard	\N	1	2	1	\N
249	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-13 00:10:20.797	559	131	f	embedded-dashboard	\N	1	3	1	\N
250	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-13 00:10:20.794	577	54	f	embedded-dashboard	\N	1	4	1	\N
251	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-13 00:10:20.901	536	131	f	embedded-dashboard	\N	1	6	1	\N
252	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 00:11:57.37	146	172	f	question	\N	1	2	\N	\N
253	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-13 00:12:10.493	384	54	f	question	\N	1	4	\N	\N
254	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-13 00:12:10.513	425	131	f	question	\N	1	3	\N	\N
255	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-13 00:12:10.55	468	256	f	question	\N	1	7	\N	\N
256	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 00:12:10.529	514	172	f	question	\N	1	2	\N	\N
257	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-13 00:12:10.566	525	131	f	question	\N	1	6	\N	\N
258	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 00:12:29.379	145	172	f	question	\N	1	2	\N	\N
\.


--
-- Data for Name: raw_column; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY raw_column (id, raw_table_id, active, name, column_type, is_pk, fk_target_column_id, details, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: raw_table; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY raw_table (id, database_id, active, schema, name, details, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: report_card; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY report_card (id, created_at, updated_at, name, description, display, dataset_query, visualization_settings, creator_id, database_id, table_id, query_type, archived, collection_id, public_uuid, made_public_by_id, enable_embedding, embedding_params, cache_ttl, result_metadata) FROM stdin;
1	2017-11-11 23:04:00.232+00	2017-11-12 23:01:28.072+00	Products	\N	line	{"database":1,"type":"query","query":{"source_table":1}}	{"graph.dimensions":["ID"],"graph.metrics":["PRICE"]}	1	1	1	query	f	\N	\N	\N	t	{}	\N	[{"base_type":"type/BigInteger","display_name":"ID","name":"ID","description":"The numerical product number. Only used internally. All external communication should use the title or EAN.","special_type":"type/PK"},{"base_type":"type/Text","display_name":"Category","name":"CATEGORY","description":"The type of product, valid values include: Doohicky, Gadget, Gizmo and Widget","special_type":"type/Category"},{"base_type":"type/DateTime","display_name":"Created At","name":"CREATED_AT","description":"The date the product was added to our catalog.","unit":"default"},{"base_type":"type/Text","display_name":"Ean","name":"EAN","description":"The international article number. A 13 digit number uniquely identifying the product.","special_type":"type/Category"},{"base_type":"type/Float","display_name":"Price","name":"PRICE","description":"The list price of the product. Note that this is not always the price the product sold for due to discounts, promotions, etc.","special_type":"type/Category"},{"base_type":"type/Float","display_name":"Rating","name":"RATING","description":"The average rating users have given the product. This ranges from 1 - 5","special_type":"type/Category"},{"base_type":"type/Text","display_name":"Title","name":"TITLE","description":"The name of the product as it should be displayed to customers.","special_type":"type/Category"},{"base_type":"type/Text","display_name":"Vendor","name":"VENDOR","description":"The source of the product.","special_type":"type/Category"}]
5	2017-11-12 23:07:07.706+00	2017-11-12 23:07:07.706+00	Per Occupation Areas, Cumulative count, Grouped by Date (month) and Instance	\N	line	{"database":2,"type":"query","query":{"source_table":6,"breakout":[["datetime-field",["field-id",495],"month"],["field-id",272]],"aggregation":[["cum_count"]]}}	{"line.interpolate":"linear","line.marker_enabled":true}	1	2	6	query	f	\N	\N	\N	f	\N	\N	[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Text","display_name":"Instance","name":"_instance","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
2	2017-11-12 21:42:36.767+00	2017-11-13 00:12:06.545+00	Áreas de Atuação por Instância	\N	bar	{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"breakout":[["field-id",500],["field-id",497]]}}	{"stackable.stack_type":"normalized"}	1	2	12	query	f	\N	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Occupation Area","name":"_occupation_area"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
7	2017-11-12 23:51:12.874+00	2017-11-13 00:09:16.417+00	Tipos por Instância	\N	bar	{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"breakout":[["field-id",500],["field-id",498]]}}	{"stackable.stack_type":"stacked","graph.x_axis.title_text":"","graph.y_axis.scale":"linear","graph.y_axis.auto_split":true,"graph.x_axis.axis_enabled":true,"graph.y_axis.axis_enabled":true,"graph.y_axis.auto_range":true}	1	2	12	query	f	\N	\N	\N	f	\N	\N	[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Space Type","name":"_space_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
4	2017-11-12 23:05:39.061+00	2017-11-13 00:10:07.438+00	Crescimento Cumulativo Mensal	\N	line	{"database":2,"type":"query","query":{"source_table":12,"breakout":[["datetime-field",["field-id",501],"month"]],"aggregation":[["cum_count"]]}}	{"line.interpolate":"cardinal","line.marker_enabled":true}	1	2	12	query	f	\N	\N	\N	f	\N	\N	[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
6	2017-11-12 23:08:52.511+00	2017-11-13 00:07:30.38+00	Crescimento Cumulativo Mensal por Instância	\N	line	{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",501],"month"],["field-id",500]]}}	{"line.interpolate":"cardinal","line.marker_enabled":true}	1	2	12	query	f	\N	\N	\N	f	\N	\N	[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
3	2017-11-12 23:01:23.161+00	2017-11-13 00:08:11.126+00	Quantidade de Registros por Mês	\N	bar	{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"breakout":[["datetime-field",["field-id",501],"month"],["field-id",500]]}}	{"stackable.stack_type":"stacked"}	1	2	12	query	f	\N	\N	\N	f	\N	\N	[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
\.


--
-- Data for Name: report_cardfavorite; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY report_cardfavorite (id, created_at, updated_at, card_id, owner_id) FROM stdin;
\.


--
-- Data for Name: report_dashboard; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY report_dashboard (id, created_at, updated_at, name, description, creator_id, parameters, points_of_interest, caveats, show_in_getting_started, public_uuid, made_public_by_id, enable_embedding, embedding_params, archived, "position") FROM stdin;
1	2017-11-11 23:04:31.428+00	2017-11-13 00:11:38.681+00	Espaços	Indicadores criados para as informações de Espaços fornecidas pela plataforma Mapas Culturais do MinC	1	[]	\N	\N	f	\N	\N	t	{}	f	\N
\.


--
-- Data for Name: report_dashboardcard; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY report_dashboardcard (id, created_at, updated_at, "sizeX", "sizeY", "row", col, card_id, dashboard_id, parameter_mappings, visualization_settings) FROM stdin;
2	2017-11-12 21:43:02.934+00	2017-11-12 23:56:01.659+00	9	8	0	0	2	1	[]	{}
3	2017-11-12 23:01:55.335+00	2017-11-12 23:56:01.692+00	9	8	8	0	3	1	[]	{}
4	2017-11-12 23:05:46.611+00	2017-11-12 23:56:01.703+00	9	8	0	9	4	1	[]	{}
5	2017-11-12 23:09:03.988+00	2017-11-12 23:56:01.714+00	9	8	8	9	6	1	[]	{}
6	2017-11-12 23:52:25.488+00	2017-11-12 23:56:01.725+00	18	10	16	0	7	1	[]	{}
\.


--
-- Data for Name: revision; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY revision (id, model, model_id, user_id, "timestamp", object, is_reversion, is_creation, message) FROM stdin;
1	Card	1	1	2017-11-11 23:04:00.307+00	{"description":null,"archived":false,"table_id":1,"result_metadata":[{"base_type":"type/BigInteger","display_name":"ID","name":"ID","description":"The numerical product number. Only used internally. All external communication should use the title or EAN.","special_type":"type/PK"},{"base_type":"type/Text","display_name":"Category","name":"CATEGORY","description":"The type of product, valid values include: Doohicky, Gadget, Gizmo and Widget","special_type":"type/Category"},{"base_type":"type/DateTime","display_name":"Created At","name":"CREATED_AT","description":"The date the product was added to our catalog.","unit":"default"},{"base_type":"type/Text","display_name":"Ean","name":"EAN","description":"The international article number. A 13 digit number uniquely identifying the product.","special_type":"type/Category"},{"base_type":"type/Float","display_name":"Price","name":"PRICE","description":"The list price of the product. Note that this is not always the price the product sold for due to discounts, promotions, etc.","special_type":"type/Category"},{"base_type":"type/Float","display_name":"Rating","name":"RATING","description":"The average rating users have given the product. This ranges from 1 - 5","special_type":"type/Category"},{"base_type":"type/Text","display_name":"Title","name":"TITLE","description":"The name of the product as it should be displayed to customers.","special_type":"type/Category"},{"base_type":"type/Text","display_name":"Vendor","name":"VENDOR","description":"The source of the product.","special_type":"type/Category"}],"database_id":1,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Products","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":1,"type":"query","query":{"source_table":1}},"id":1,"display":"line","visualization_settings":{"graph.dimensions":["ID"],"graph.metrics":["PRICE"]},"public_uuid":null}	f	t	\N
8	Card	1	1	2017-11-12 03:31:56.422+00	{"description":null,"archived":false,"table_id":1,"result_metadata":[{"base_type":"type/BigInteger","display_name":"ID","name":"ID","description":"The numerical product number. Only used internally. All external communication should use the title or EAN.","special_type":"type/PK"},{"base_type":"type/Text","display_name":"Category","name":"CATEGORY","description":"The type of product, valid values include: Doohicky, Gadget, Gizmo and Widget","special_type":"type/Category"},{"base_type":"type/DateTime","display_name":"Created At","name":"CREATED_AT","description":"The date the product was added to our catalog.","unit":"default"},{"base_type":"type/Text","display_name":"Ean","name":"EAN","description":"The international article number. A 13 digit number uniquely identifying the product.","special_type":"type/Category"},{"base_type":"type/Float","display_name":"Price","name":"PRICE","description":"The list price of the product. Note that this is not always the price the product sold for due to discounts, promotions, etc.","special_type":"type/Category"},{"base_type":"type/Float","display_name":"Rating","name":"RATING","description":"The average rating users have given the product. This ranges from 1 - 5","special_type":"type/Category"},{"base_type":"type/Text","display_name":"Title","name":"TITLE","description":"The name of the product as it should be displayed to customers.","special_type":"type/Category"},{"base_type":"type/Text","display_name":"Vendor","name":"VENDOR","description":"The source of the product.","special_type":"type/Category"}],"database_id":1,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Products","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":1,"type":"query","query":{"source_table":1}},"id":1,"display":"line","visualization_settings":{"graph.dimensions":["ID"],"graph.metrics":["PRICE"]},"public_uuid":null}	f	f	\N
9	Card	1	1	2017-11-12 03:31:56.486+00	{"description":null,"archived":false,"table_id":1,"result_metadata":[{"base_type":"type/BigInteger","display_name":"ID","name":"ID","description":"The numerical product number. Only used internally. All external communication should use the title or EAN.","special_type":"type/PK"},{"base_type":"type/Text","display_name":"Category","name":"CATEGORY","description":"The type of product, valid values include: Doohicky, Gadget, Gizmo and Widget","special_type":"type/Category"},{"base_type":"type/DateTime","display_name":"Created At","name":"CREATED_AT","description":"The date the product was added to our catalog.","unit":"default"},{"base_type":"type/Text","display_name":"Ean","name":"EAN","description":"The international article number. A 13 digit number uniquely identifying the product.","special_type":"type/Category"},{"base_type":"type/Float","display_name":"Price","name":"PRICE","description":"The list price of the product. Note that this is not always the price the product sold for due to discounts, promotions, etc.","special_type":"type/Category"},{"base_type":"type/Float","display_name":"Rating","name":"RATING","description":"The average rating users have given the product. This ranges from 1 - 5","special_type":"type/Category"},{"base_type":"type/Text","display_name":"Title","name":"TITLE","description":"The name of the product as it should be displayed to customers.","special_type":"type/Category"},{"base_type":"type/Text","display_name":"Vendor","name":"VENDOR","description":"The source of the product.","special_type":"type/Category"}],"database_id":1,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Products","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":1,"type":"query","query":{"source_table":1}},"id":1,"display":"line","visualization_settings":{"graph.dimensions":["ID"],"graph.metrics":["PRICE"]},"public_uuid":null}	f	f	\N
10	Card	2	1	2017-11-12 21:42:36.865+00	{"description":null,"archived":false,"table_id":6,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance","special_type":"type/Category"},{"base_type":"type/Text","display_name":"Occupation Area","name":"_occupation_area","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Per Occupation Areas, Count, Grouped by Instance and Occupation Area","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":6,"breakout":[["field-id",272],["field-id",270]],"aggregation":[["count"]]}},"id":2,"display":"bar","visualization_settings":{"stackable.stack_type":"normalized"},"public_uuid":null}	f	t	\N
15	Card	2	1	2017-11-12 21:43:12.314+00	{"description":null,"archived":false,"table_id":6,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance","special_type":"type/Category"},{"base_type":"type/Text","display_name":"Occupation Area","name":"_occupation_area","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Per Occupation Areas, Count, Grouped by Instance and Occupation Area","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":6,"breakout":[["field-id",272],["field-id",270]],"aggregation":[["count"]]}},"id":2,"display":"bar","visualization_settings":{"stackable.stack_type":"normalized"},"public_uuid":null}	f	f	\N
16	Card	2	1	2017-11-12 21:43:12.415+00	{"description":null,"archived":false,"table_id":6,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance","special_type":"type/Category"},{"base_type":"type/Text","display_name":"Occupation Area","name":"_occupation_area","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Per Occupation Areas, Count, Grouped by Instance and Occupation Area","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":6,"breakout":[["field-id",272],["field-id",270]],"aggregation":[["count"]]}},"id":2,"display":"bar","visualization_settings":{"stackable.stack_type":"normalized"},"public_uuid":null}	f	f	\N
17	Card	3	1	2017-11-12 23:01:23.185+00	{"description":null,"archived":false,"table_id":6,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Per Occupation Areas, Count, Grouped by Date (month)","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":6,"breakout":[["datetime-field",["field-id",495],"month"]],"aggregation":[["count"]]}},"id":3,"display":"bar","visualization_settings":{},"public_uuid":null}	f	t	\N
22	Card	3	1	2017-11-12 23:02:45.107+00	{"description":null,"archived":false,"table_id":6,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Text","display_name":"Instance","name":"_instance","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Per Occupation Areas, Count, Grouped by Date (month)","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":6,"breakout":[["datetime-field",["field-id",495],"month"],["field-id",272]],"aggregation":[["count"]]}},"id":3,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
23	Card	4	1	2017-11-12 23:05:39.103+00	{"description":null,"archived":false,"table_id":6,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Per Occupation Areas, Cumulative count, Grouped by Date (month)","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":6,"breakout":[["datetime-field",["field-id",495],"month"]],"aggregation":[["cum_count"]]}},"id":4,"display":"line","visualization_settings":{"line.marker_enabled":true,"line.interpolate":"cardinal","line.missing":"interpolate"},"public_uuid":null}	f	t	\N
43	Dashboard	1	1	2017-11-12 23:54:51.513+00	{"description":null,"name":"Space Indicators","cards":[{"sizeX":9,"sizeY":8,"row":0,"col":0,"id":2,"card_id":2,"series":[]},{"sizeX":4,"sizeY":4,"row":16,"col":4,"id":3,"card_id":3,"series":[]},{"sizeX":9,"sizeY":8,"row":0,"col":9,"id":4,"card_id":4,"series":[]},{"sizeX":4,"sizeY":4,"row":8,"col":8,"id":5,"card_id":6,"series":[]},{"sizeX":4,"sizeY":4,"row":8,"col":0,"id":6,"card_id":7,"series":[]}]}	f	f	\N
52	Card	3	1	2017-11-13 00:08:11.164+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Quantidade de Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"breakout":[["datetime-field",["field-id",501],"month"],["field-id",500]]}},"id":3,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
55	Card	4	1	2017-11-13 00:10:07.479+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"breakout":[["datetime-field",["field-id",501],"month"]],"aggregation":[["cum_count"]]}},"id":4,"display":"line","visualization_settings":{"line.interpolate":"cardinal","line.marker_enabled":true},"public_uuid":null}	f	f	\N
57	Dashboard	1	1	2017-11-13 00:10:44.794+00	{"description":null,"name":"                                                                                         Indicadores de Espaços","cards":[{"sizeX":9,"sizeY":8,"row":0,"col":0,"id":2,"card_id":2,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":0,"id":3,"card_id":3,"series":[]},{"sizeX":9,"sizeY":8,"row":0,"col":9,"id":4,"card_id":4,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":9,"id":5,"card_id":6,"series":[]},{"sizeX":18,"sizeY":10,"row":16,"col":0,"id":6,"card_id":7,"series":[]}]}	f	f	\N
27	Card	5	1	2017-11-12 23:07:07.754+00	{"description":null,"archived":false,"table_id":6,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Text","display_name":"Instance","name":"_instance","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Per Occupation Areas, Cumulative count, Grouped by Date (month) and Instance","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":6,"breakout":[["datetime-field",["field-id",495],"month"],["field-id",272]],"aggregation":[["cum_count"]]}},"id":5,"display":"line","visualization_settings":{"line.interpolate":"linear","line.marker_enabled":true},"public_uuid":null}	f	t	\N
28	Card	6	1	2017-11-12 23:08:52.57+00	{"description":null,"archived":false,"table_id":6,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Text","display_name":"Instance","name":"_instance","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Per Occupation Areas, Cumulative count, Grouped by Date (month) and Instance","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":6,"breakout":[["datetime-field",["field-id",495],"month"],["field-id",272]],"aggregation":[["cum_count"]]}},"id":6,"display":"line","visualization_settings":{"line.interpolate":"cardinal","line.marker_enabled":true},"public_uuid":null}	f	t	\N
32	Card	2	1	2017-11-12 23:39:41.142+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Occupation Area","name":"_occupation_area"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Per Occupation Areas, Count, Grouped by Instance and Occupation Area","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"breakout":[["field-id",500],["field-id",497]]}},"id":2,"display":"bar","visualization_settings":{"stackable.stack_type":"normalized"},"public_uuid":null}	f	f	\N
33	Card	3	1	2017-11-12 23:40:19.033+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Per Occupation Areas, Count, Grouped by Date (month)","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"breakout":[["datetime-field",["field-id",501],"month"]]}},"id":3,"display":"bar","visualization_settings":{},"public_uuid":null}	f	f	\N
34	Card	3	1	2017-11-12 23:40:49.773+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Per Occupation Areas, Count, Grouped by Date (month)","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"breakout":[["datetime-field",["field-id",501],"month"],["field-id",500]]}},"id":3,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
35	Card	4	1	2017-11-12 23:41:52.319+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Per Occupation Areas, Cumulative count, Grouped by Date (month)","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"breakout":[["datetime-field",["field-id",501],"month"]],"aggregation":[["cum_count"]]}},"id":4,"display":"line","visualization_settings":{"line.interpolate":"cardinal","line.marker_enabled":true},"public_uuid":null}	f	f	\N
36	Card	6	1	2017-11-12 23:42:45.231+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Per Occupation Areas, Cumulative count, Grouped by Date (month) and Instance","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",501],"month"],["field-id",500]]}},"id":6,"display":"line","visualization_settings":{"line.interpolate":"cardinal","line.marker_enabled":true},"public_uuid":null}	f	f	\N
41	Dashboard	1	1	2017-11-12 23:53:49.086+00	{"description":null,"name":"Space Indicators","cards":[{"sizeX":8,"sizeY":8,"row":0,"col":0,"id":2,"card_id":2,"series":[]},{"sizeX":4,"sizeY":4,"row":8,"col":4,"id":3,"card_id":3,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":8,"id":4,"card_id":4,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":12,"id":5,"card_id":6,"series":[]},{"sizeX":4,"sizeY":4,"row":8,"col":0,"id":6,"card_id":7,"series":[]}]}	f	f	\N
42	Dashboard	1	1	2017-11-12 23:53:49.125+00	{"description":null,"name":"Space Indicators","cards":[{"sizeX":8,"sizeY":8,"row":0,"col":0,"id":2,"card_id":2,"series":[]},{"sizeX":4,"sizeY":4,"row":8,"col":4,"id":3,"card_id":3,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":8,"id":4,"card_id":4,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":12,"id":5,"card_id":6,"series":[]},{"sizeX":4,"sizeY":4,"row":8,"col":0,"id":6,"card_id":7,"series":[]}]}	f	f	\N
37	Card	7	1	2017-11-12 23:51:12.946+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Space Type","name":"_space_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Space Data, Count, Grouped by Instance and Space Type","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"breakout":[["field-id",500],["field-id",498]]}},"id":7,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked","graph.x_axis.title_text":"","graph.y_axis.scale":"linear","graph.y_axis.auto_split":true,"graph.x_axis.axis_enabled":true,"graph.y_axis.axis_enabled":true,"graph.y_axis.auto_range":true},"public_uuid":null}	f	t	\N
40	Dashboard	1	1	2017-11-12 23:52:25.712+00	{"description":null,"name":"Space Indicators","cards":[{"sizeX":4,"sizeY":4,"row":0,"col":0,"id":2,"card_id":2,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":4,"id":3,"card_id":3,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":8,"id":4,"card_id":4,"series":[]},{"sizeX":4,"sizeY":4,"row":0,"col":12,"id":5,"card_id":6,"series":[]},{"sizeX":4,"sizeY":4,"row":4,"col":0,"id":6,"card_id":7,"series":[]}]}	f	f	\N
44	Dashboard	1	1	2017-11-12 23:54:51.554+00	{"description":null,"name":"Space Indicators","cards":[{"sizeX":9,"sizeY":8,"row":0,"col":0,"id":2,"card_id":2,"series":[]},{"sizeX":4,"sizeY":4,"row":16,"col":4,"id":3,"card_id":3,"series":[]},{"sizeX":9,"sizeY":8,"row":0,"col":9,"id":4,"card_id":4,"series":[]},{"sizeX":4,"sizeY":4,"row":8,"col":8,"id":5,"card_id":6,"series":[]},{"sizeX":4,"sizeY":4,"row":8,"col":0,"id":6,"card_id":7,"series":[]}]}	f	f	\N
45	Dashboard	1	1	2017-11-12 23:56:01.755+00	{"description":null,"name":"Space Indicators","cards":[{"sizeX":9,"sizeY":8,"row":0,"col":0,"id":2,"card_id":2,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":0,"id":3,"card_id":3,"series":[]},{"sizeX":9,"sizeY":8,"row":0,"col":9,"id":4,"card_id":4,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":9,"id":5,"card_id":6,"series":[]},{"sizeX":18,"sizeY":10,"row":16,"col":0,"id":6,"card_id":7,"series":[]}]}	f	f	\N
46	Dashboard	1	1	2017-11-12 23:56:01.815+00	{"description":null,"name":"Space Indicators","cards":[{"sizeX":9,"sizeY":8,"row":0,"col":0,"id":2,"card_id":2,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":0,"id":3,"card_id":3,"series":[]},{"sizeX":9,"sizeY":8,"row":0,"col":9,"id":4,"card_id":4,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":9,"id":5,"card_id":6,"series":[]},{"sizeX":18,"sizeY":10,"row":16,"col":0,"id":6,"card_id":7,"series":[]}]}	f	f	\N
47	Dashboard	1	1	2017-11-13 00:04:22.916+00	{"description":null,"name":"Indicadores de Espaços","cards":[{"sizeX":9,"sizeY":8,"row":0,"col":0,"id":2,"card_id":2,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":0,"id":3,"card_id":3,"series":[]},{"sizeX":9,"sizeY":8,"row":0,"col":9,"id":4,"card_id":4,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":9,"id":5,"card_id":6,"series":[]},{"sizeX":18,"sizeY":10,"row":16,"col":0,"id":6,"card_id":7,"series":[]}]}	f	f	\N
48	Dashboard	1	1	2017-11-13 00:04:22.982+00	{"description":null,"name":"Indicadores de Espaços","cards":[{"sizeX":9,"sizeY":8,"row":0,"col":0,"id":2,"card_id":2,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":0,"id":3,"card_id":3,"series":[]},{"sizeX":9,"sizeY":8,"row":0,"col":9,"id":4,"card_id":4,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":9,"id":5,"card_id":6,"series":[]},{"sizeX":18,"sizeY":10,"row":16,"col":0,"id":6,"card_id":7,"series":[]}]}	f	f	\N
49	Card	2	1	2017-11-13 00:05:31.185+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Occupation Area","name":"_occupation_area"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Áreas de Atuação por Instância","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"breakout":[["field-id",500],["field-id",497]]}},"id":2,"display":"bar","visualization_settings":{"stackable.stack_type":"normalized"},"public_uuid":null}	f	f	\N
50	Card	4	1	2017-11-13 00:07:04.798+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Crescimento cumulativo mensal","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"breakout":[["datetime-field",["field-id",501],"month"]],"aggregation":[["cum_count"]]}},"id":4,"display":"line","visualization_settings":{"line.interpolate":"cardinal","line.marker_enabled":true},"public_uuid":null}	f	f	\N
51	Card	6	1	2017-11-13 00:07:30.434+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Crescimento Cumulativo Mensal por Instância","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",501],"month"],["field-id",500]]}},"id":6,"display":"line","visualization_settings":{"line.interpolate":"cardinal","line.marker_enabled":true},"public_uuid":null}	f	f	\N
58	Dashboard	1	1	2017-11-13 00:10:55.212+00	{"description":null,"name":"Indicadores de Espaços","cards":[{"sizeX":9,"sizeY":8,"row":0,"col":0,"id":2,"card_id":2,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":0,"id":3,"card_id":3,"series":[]},{"sizeX":9,"sizeY":8,"row":0,"col":9,"id":4,"card_id":4,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":9,"id":5,"card_id":6,"series":[]},{"sizeX":18,"sizeY":10,"row":16,"col":0,"id":6,"card_id":7,"series":[]}]}	f	f	\N
53	Card	7	1	2017-11-13 00:09:00.328+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Space Type","name":"_space_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Quantidade por Tipo por Instância","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"breakout":[["field-id",500],["field-id",498]]}},"id":7,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked","graph.x_axis.title_text":"","graph.y_axis.scale":"linear","graph.y_axis.auto_split":true,"graph.x_axis.axis_enabled":true,"graph.y_axis.axis_enabled":true,"graph.y_axis.auto_range":true},"public_uuid":null}	f	f	\N
54	Card	7	1	2017-11-13 00:09:16.463+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Space Type","name":"_space_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Tipos por Instância","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"breakout":[["field-id",500],["field-id",498]]}},"id":7,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked","graph.x_axis.title_text":"","graph.y_axis.scale":"linear","graph.y_axis.auto_split":true,"graph.x_axis.axis_enabled":true,"graph.y_axis.axis_enabled":true,"graph.y_axis.auto_range":true},"public_uuid":null}	f	f	\N
56	Dashboard	1	1	2017-11-13 00:10:44.728+00	{"description":null,"name":"                                                                                         Indicadores de Espaços","cards":[{"sizeX":9,"sizeY":8,"row":0,"col":0,"id":2,"card_id":2,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":0,"id":3,"card_id":3,"series":[]},{"sizeX":9,"sizeY":8,"row":0,"col":9,"id":4,"card_id":4,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":9,"id":5,"card_id":6,"series":[]},{"sizeX":18,"sizeY":10,"row":16,"col":0,"id":6,"card_id":7,"series":[]}]}	f	f	\N
59	Dashboard	1	1	2017-11-13 00:10:55.256+00	{"description":null,"name":"Indicadores de Espaços","cards":[{"sizeX":9,"sizeY":8,"row":0,"col":0,"id":2,"card_id":2,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":0,"id":3,"card_id":3,"series":[]},{"sizeX":9,"sizeY":8,"row":0,"col":9,"id":4,"card_id":4,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":9,"id":5,"card_id":6,"series":[]},{"sizeX":18,"sizeY":10,"row":16,"col":0,"id":6,"card_id":7,"series":[]}]}	f	f	\N
60	Dashboard	1	1	2017-11-13 00:11:38.628+00	{"description":"Indicadores criados para as informações de Espaços fornecidas pela plataforma Mapas Culturais do MinC","name":"Espaços","cards":[{"sizeX":9,"sizeY":8,"row":0,"col":0,"id":2,"card_id":2,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":0,"id":3,"card_id":3,"series":[]},{"sizeX":9,"sizeY":8,"row":0,"col":9,"id":4,"card_id":4,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":9,"id":5,"card_id":6,"series":[]},{"sizeX":18,"sizeY":10,"row":16,"col":0,"id":6,"card_id":7,"series":[]}]}	f	f	\N
61	Dashboard	1	1	2017-11-13 00:11:38.715+00	{"description":"Indicadores criados para as informações de Espaços fornecidas pela plataforma Mapas Culturais do MinC","name":"Espaços","cards":[{"sizeX":9,"sizeY":8,"row":0,"col":0,"id":2,"card_id":2,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":0,"id":3,"card_id":3,"series":[]},{"sizeX":9,"sizeY":8,"row":0,"col":9,"id":4,"card_id":4,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":9,"id":5,"card_id":6,"series":[]},{"sizeX":18,"sizeY":10,"row":16,"col":0,"id":6,"card_id":7,"series":[]}]}	f	f	\N
62	Card	2	1	2017-11-13 00:12:06.592+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Occupation Area","name":"_occupation_area"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Áreas de Atuação por Instância","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"breakout":[["field-id",500],["field-id",497]]}},"id":2,"display":"bar","visualization_settings":{"stackable.stack_type":"normalized"},"public_uuid":null}	f	f	\N
\.


--
-- Data for Name: segment; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY segment (id, table_id, creator_id, name, description, is_active, definition, created_at, updated_at, points_of_interest, caveats, show_in_getting_started) FROM stdin;
\.


--
-- Data for Name: setting; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY setting (key, value) FROM stdin;
site-url	http://0.0.0.0:3000
site-name	Quero Cultura
admin-email	querocultura61@gmail.com
anon-tracking-enabled	true
enable-embedding	true
embedding-secret-key	1798c3ba25f5799bd75538a7fe2896b79e24f3ec1df9d921558899dc690bbcd9
\.


--
-- Data for Name: view_log; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY view_log (id, user_id, model, model_id, "timestamp") FROM stdin;
1	1	card	1	2017-11-11 23:04:00.261+00
2	1	dashboard	1	2017-11-11 23:04:31.647+00
3	1	dashboard	1	2017-11-11 23:04:36.16+00
4	1	dashboard	1	2017-11-12 03:20:04.745+00
5	1	dashboard	1	2017-11-12 03:21:38.217+00
6	1	dashboard	1	2017-11-12 03:30:04.372+00
7	1	dashboard	1	2017-11-12 03:30:49.105+00
8	1	dashboard	1	2017-11-12 03:31:31.363+00
9	1	card	1	2017-11-12 03:31:38.802+00
10	1	card	2	2017-11-12 21:42:36.84+00
11	1	dashboard	1	2017-11-12 21:42:43.353+00
12	1	dashboard	1	2017-11-12 21:43:03.414+00
13	1	card	2	2017-11-12 21:43:05.44+00
14	1	card	3	2017-11-12 23:01:23.177+00
15	1	dashboard	1	2017-11-12 23:01:26.419+00
16	1	dashboard	1	2017-11-12 23:01:55.615+00
17	1	card	3	2017-11-12 23:01:57.898+00
18	1	card	4	2017-11-12 23:05:39.1+00
19	1	dashboard	1	2017-11-12 23:05:41.711+00
20	1	dashboard	1	2017-11-12 23:05:46.855+00
21	1	card	5	2017-11-12 23:07:07.744+00
22	1	dashboard	1	2017-11-12 23:07:10.534+00
23	1	card	3	2017-11-12 23:07:31.92+00
24	1	dashboard	1	2017-11-12 23:07:52.124+00
25	1	card	6	2017-11-12 23:08:52.562+00
26	1	dashboard	1	2017-11-12 23:08:55.536+00
27	1	dashboard	1	2017-11-12 23:09:04.336+00
28	1	card	6	2017-11-12 23:09:12.926+00
29	1	dashboard	1	2017-11-12 23:10:18.745+00
30	1	dashboard	1	2017-11-12 23:35:21.909+00
31	1	card	2	2017-11-12 23:35:23.569+00
32	1	dashboard	1	2017-11-12 23:35:35.519+00
33	1	card	2	2017-11-12 23:35:37.036+00
34	1	dashboard	1	2017-11-12 23:36:14.801+00
35	1	card	2	2017-11-12 23:36:15.922+00
36	1	dashboard	1	2017-11-12 23:38:01.96+00
37	1	card	2	2017-11-12 23:38:03.219+00
38	1	dashboard	1	2017-11-12 23:38:34.443+00
39	1	card	2	2017-11-12 23:38:35.378+00
40	1	dashboard	1	2017-11-12 23:39:45.535+00
41	1	card	3	2017-11-12 23:39:47.999+00
42	1	dashboard	1	2017-11-12 23:40:53.137+00
43	1	card	4	2017-11-12 23:40:59.918+00
44	1	dashboard	1	2017-11-12 23:41:55.683+00
45	1	card	6	2017-11-12 23:41:58.296+00
46	1	dashboard	1	2017-11-12 23:42:48.938+00
47	1	card	7	2017-11-12 23:51:12.938+00
48	1	dashboard	1	2017-11-12 23:51:17.545+00
49	1	card	3	2017-11-12 23:51:41.409+00
50	1	dashboard	1	2017-11-12 23:51:46.156+00
51	1	dashboard	1	2017-11-12 23:51:50.816+00
52	1	card	7	2017-11-12 23:52:16.888+00
53	1	dashboard	1	2017-11-12 23:52:22.535+00
54	1	dashboard	1	2017-11-12 23:52:25.734+00
55	1	card	6	2017-11-12 23:52:52.623+00
56	1	dashboard	1	2017-11-12 23:53:03.002+00
57	1	card	3	2017-11-12 23:53:16.009+00
58	1	dashboard	1	2017-11-12 23:53:23.833+00
59	1	dashboard	1	2017-11-12 23:53:49.145+00
60	1	card	6	2017-11-12 23:53:52.893+00
61	1	dashboard	1	2017-11-12 23:53:57.036+00
62	1	card	4	2017-11-12 23:54:04.082+00
63	1	dashboard	1	2017-11-12 23:54:09.825+00
64	1	dashboard	1	2017-11-12 23:54:51.578+00
65	1	card	6	2017-11-12 23:54:57.54+00
66	1	dashboard	1	2017-11-12 23:55:01.361+00
67	1	dashboard	1	2017-11-12 23:56:01.841+00
68	1	dashboard	1	2017-11-13 00:04:23.011+00
69	1	card	2	2017-11-13 00:04:26.036+00
70	1	dashboard	1	2017-11-13 00:05:36.383+00
71	1	card	4	2017-11-13 00:05:40.831+00
72	1	dashboard	1	2017-11-13 00:07:08.119+00
73	1	card	6	2017-11-13 00:07:16.145+00
74	1	dashboard	1	2017-11-13 00:07:34.025+00
75	1	card	3	2017-11-13 00:07:41.198+00
76	1	dashboard	1	2017-11-13 00:08:14.623+00
77	1	card	7	2017-11-13 00:08:25.129+00
78	1	dashboard	1	2017-11-13 00:09:41.333+00
79	1	card	4	2017-11-13 00:09:54.926+00
80	1	dashboard	1	2017-11-13 00:10:10.596+00
81	1	dashboard	1	2017-11-13 00:10:44.786+00
82	1	dashboard	1	2017-11-13 00:10:55.269+00
83	1	dashboard	1	2017-11-13 00:11:38.733+00
84	1	card	2	2017-11-13 00:11:57.237+00
85	1	dashboard	1	2017-11-13 00:12:10.429+00
86	1	card	2	2017-11-13 00:12:29.321+00
\.


--
-- Name: activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('activity_id_seq', 35, true);


--
-- Name: card_label_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('card_label_id_seq', 1, false);


--
-- Name: collection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('collection_id_seq', 1, false);


--
-- Name: collection_revision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('collection_revision_id_seq', 1, false);


--
-- Name: core_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('core_user_id_seq', 1, true);


--
-- Name: dashboard_favorite_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('dashboard_favorite_id_seq', 1, false);


--
-- Name: dashboardcard_series_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('dashboardcard_series_id_seq', 1, false);


--
-- Name: dependency_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('dependency_id_seq', 1, false);


--
-- Name: dimension_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('dimension_id_seq', 1, false);


--
-- Name: label_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('label_id_seq', 1, false);


--
-- Name: metabase_database_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('metabase_database_id_seq', 2, true);


--
-- Name: metabase_field_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('metabase_field_id_seq', 501, true);


--
-- Name: metabase_fieldvalues_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('metabase_fieldvalues_id_seq', 46, true);


--
-- Name: metabase_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('metabase_table_id_seq', 13, true);


--
-- Name: metric_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('metric_id_seq', 1, false);


--
-- Name: metric_important_field_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('metric_important_field_id_seq', 1, false);


--
-- Name: permissions_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('permissions_group_id_seq', 3, true);


--
-- Name: permissions_group_membership_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('permissions_group_membership_id_seq', 2, true);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('permissions_id_seq', 5, true);


--
-- Name: permissions_revision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('permissions_revision_id_seq', 1, false);


--
-- Name: pulse_card_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('pulse_card_id_seq', 1, false);


--
-- Name: pulse_channel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('pulse_channel_id_seq', 1, false);


--
-- Name: pulse_channel_recipient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('pulse_channel_recipient_id_seq', 1, false);


--
-- Name: pulse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('pulse_id_seq', 1, false);


--
-- Name: query_execution_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('query_execution_id_seq', 258, true);


--
-- Name: raw_column_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('raw_column_id_seq', 1, false);


--
-- Name: raw_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('raw_table_id_seq', 1, false);


--
-- Name: report_card_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('report_card_id_seq', 7, true);


--
-- Name: report_cardfavorite_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('report_cardfavorite_id_seq', 1, false);


--
-- Name: report_dashboard_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('report_dashboard_id_seq', 1, true);


--
-- Name: report_dashboardcard_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('report_dashboardcard_id_seq', 6, true);


--
-- Name: revision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('revision_id_seq', 62, true);


--
-- Name: segment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('segment_id_seq', 1, false);


--
-- Name: view_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('view_log_id_seq', 86, true);


--
-- Name: collection collection_slug_key; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY collection
    ADD CONSTRAINT collection_slug_key UNIQUE (slug);


--
-- Name: core_user core_user_email_key; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY core_user
    ADD CONSTRAINT core_user_email_key UNIQUE (email);


--
-- Name: report_cardfavorite idx_unique_cardfavorite_card_id_owner_id; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY report_cardfavorite
    ADD CONSTRAINT idx_unique_cardfavorite_card_id_owner_id UNIQUE (card_id, owner_id);


--
-- Name: label label_slug_key; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY label
    ADD CONSTRAINT label_slug_key UNIQUE (slug);


--
-- Name: permissions permissions_group_id_object_key; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY permissions
    ADD CONSTRAINT permissions_group_id_object_key UNIQUE (group_id, object);


--
-- Name: activity pk_activity; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY activity
    ADD CONSTRAINT pk_activity PRIMARY KEY (id);


--
-- Name: card_label pk_card_label; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY card_label
    ADD CONSTRAINT pk_card_label PRIMARY KEY (id);


--
-- Name: collection pk_collection; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY collection
    ADD CONSTRAINT pk_collection PRIMARY KEY (id);


--
-- Name: collection_revision pk_collection_revision; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY collection_revision
    ADD CONSTRAINT pk_collection_revision PRIMARY KEY (id);


--
-- Name: core_session pk_core_session; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY core_session
    ADD CONSTRAINT pk_core_session PRIMARY KEY (id);


--
-- Name: core_user pk_core_user; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY core_user
    ADD CONSTRAINT pk_core_user PRIMARY KEY (id);


--
-- Name: dashboard_favorite pk_dashboard_favorite; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY dashboard_favorite
    ADD CONSTRAINT pk_dashboard_favorite PRIMARY KEY (id);


--
-- Name: dashboardcard_series pk_dashboardcard_series; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY dashboardcard_series
    ADD CONSTRAINT pk_dashboardcard_series PRIMARY KEY (id);


--
-- Name: data_migrations pk_data_migrations; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY data_migrations
    ADD CONSTRAINT pk_data_migrations PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: dependency pk_dependency; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY dependency
    ADD CONSTRAINT pk_dependency PRIMARY KEY (id);


--
-- Name: dimension pk_dimension; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY dimension
    ADD CONSTRAINT pk_dimension PRIMARY KEY (id);


--
-- Name: label pk_label; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY label
    ADD CONSTRAINT pk_label PRIMARY KEY (id);


--
-- Name: metabase_database pk_metabase_database; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY metabase_database
    ADD CONSTRAINT pk_metabase_database PRIMARY KEY (id);


--
-- Name: metabase_field pk_metabase_field; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY metabase_field
    ADD CONSTRAINT pk_metabase_field PRIMARY KEY (id);


--
-- Name: metabase_fieldvalues pk_metabase_fieldvalues; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY metabase_fieldvalues
    ADD CONSTRAINT pk_metabase_fieldvalues PRIMARY KEY (id);


--
-- Name: metabase_table pk_metabase_table; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY metabase_table
    ADD CONSTRAINT pk_metabase_table PRIMARY KEY (id);


--
-- Name: metric pk_metric; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY metric
    ADD CONSTRAINT pk_metric PRIMARY KEY (id);


--
-- Name: metric_important_field pk_metric_important_field; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY metric_important_field
    ADD CONSTRAINT pk_metric_important_field PRIMARY KEY (id);


--
-- Name: permissions pk_permissions; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY permissions
    ADD CONSTRAINT pk_permissions PRIMARY KEY (id);


--
-- Name: permissions_group pk_permissions_group; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY permissions_group
    ADD CONSTRAINT pk_permissions_group PRIMARY KEY (id);


--
-- Name: permissions_group_membership pk_permissions_group_membership; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY permissions_group_membership
    ADD CONSTRAINT pk_permissions_group_membership PRIMARY KEY (id);


--
-- Name: permissions_revision pk_permissions_revision; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY permissions_revision
    ADD CONSTRAINT pk_permissions_revision PRIMARY KEY (id);


--
-- Name: pulse pk_pulse; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY pulse
    ADD CONSTRAINT pk_pulse PRIMARY KEY (id);


--
-- Name: pulse_card pk_pulse_card; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY pulse_card
    ADD CONSTRAINT pk_pulse_card PRIMARY KEY (id);


--
-- Name: pulse_channel pk_pulse_channel; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY pulse_channel
    ADD CONSTRAINT pk_pulse_channel PRIMARY KEY (id);


--
-- Name: pulse_channel_recipient pk_pulse_channel_recipient; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY pulse_channel_recipient
    ADD CONSTRAINT pk_pulse_channel_recipient PRIMARY KEY (id);


--
-- Name: query pk_query; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY query
    ADD CONSTRAINT pk_query PRIMARY KEY (query_hash);


--
-- Name: query_cache pk_query_cache; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY query_cache
    ADD CONSTRAINT pk_query_cache PRIMARY KEY (query_hash);


--
-- Name: query_execution pk_query_execution; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY query_execution
    ADD CONSTRAINT pk_query_execution PRIMARY KEY (id);


--
-- Name: raw_column pk_raw_column; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY raw_column
    ADD CONSTRAINT pk_raw_column PRIMARY KEY (id);


--
-- Name: raw_table pk_raw_table; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY raw_table
    ADD CONSTRAINT pk_raw_table PRIMARY KEY (id);


--
-- Name: report_card pk_report_card; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY report_card
    ADD CONSTRAINT pk_report_card PRIMARY KEY (id);


--
-- Name: report_cardfavorite pk_report_cardfavorite; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY report_cardfavorite
    ADD CONSTRAINT pk_report_cardfavorite PRIMARY KEY (id);


--
-- Name: report_dashboard pk_report_dashboard; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY report_dashboard
    ADD CONSTRAINT pk_report_dashboard PRIMARY KEY (id);


--
-- Name: report_dashboardcard pk_report_dashboardcard; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY report_dashboardcard
    ADD CONSTRAINT pk_report_dashboardcard PRIMARY KEY (id);


--
-- Name: revision pk_revision; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY revision
    ADD CONSTRAINT pk_revision PRIMARY KEY (id);


--
-- Name: segment pk_segment; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY segment
    ADD CONSTRAINT pk_segment PRIMARY KEY (id);


--
-- Name: setting pk_setting; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY setting
    ADD CONSTRAINT pk_setting PRIMARY KEY (key);


--
-- Name: view_log pk_view_log; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY view_log
    ADD CONSTRAINT pk_view_log PRIMARY KEY (id);


--
-- Name: report_card report_card_public_uuid_key; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY report_card
    ADD CONSTRAINT report_card_public_uuid_key UNIQUE (public_uuid);


--
-- Name: report_dashboard report_dashboard_public_uuid_key; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY report_dashboard
    ADD CONSTRAINT report_dashboard_public_uuid_key UNIQUE (public_uuid);


--
-- Name: raw_column uniq_raw_column_table_name; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY raw_column
    ADD CONSTRAINT uniq_raw_column_table_name UNIQUE (raw_table_id, name);


--
-- Name: raw_table uniq_raw_table_db_schema_name; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY raw_table
    ADD CONSTRAINT uniq_raw_table_db_schema_name UNIQUE (database_id, schema, name);


--
-- Name: card_label unique_card_label_card_id_label_id; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY card_label
    ADD CONSTRAINT unique_card_label_card_id_label_id UNIQUE (card_id, label_id);


--
-- Name: dashboard_favorite unique_dashboard_favorite_user_id_dashboard_id; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY dashboard_favorite
    ADD CONSTRAINT unique_dashboard_favorite_user_id_dashboard_id UNIQUE (user_id, dashboard_id);


--
-- Name: dimension unique_dimension_field_id_name; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY dimension
    ADD CONSTRAINT unique_dimension_field_id_name UNIQUE (field_id, name);


--
-- Name: metric_important_field unique_metric_important_field_metric_id_field_id; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY metric_important_field
    ADD CONSTRAINT unique_metric_important_field_metric_id_field_id UNIQUE (metric_id, field_id);


--
-- Name: permissions_group_membership unique_permissions_group_membership_user_id_group_id; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY permissions_group_membership
    ADD CONSTRAINT unique_permissions_group_membership_user_id_group_id UNIQUE (user_id, group_id);


--
-- Name: permissions_group unique_permissions_group_name; Type: CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY permissions_group
    ADD CONSTRAINT unique_permissions_group_name UNIQUE (name);


--
-- Name: idx_activity_custom_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_activity_custom_id ON activity USING btree (custom_id);


--
-- Name: idx_activity_timestamp; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_activity_timestamp ON activity USING btree ("timestamp");


--
-- Name: idx_activity_user_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_activity_user_id ON activity USING btree (user_id);


--
-- Name: idx_card_collection_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_card_collection_id ON report_card USING btree (collection_id);


--
-- Name: idx_card_creator_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_card_creator_id ON report_card USING btree (creator_id);


--
-- Name: idx_card_label_card_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_card_label_card_id ON card_label USING btree (card_id);


--
-- Name: idx_card_label_label_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_card_label_label_id ON card_label USING btree (label_id);


--
-- Name: idx_card_public_uuid; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_card_public_uuid ON report_card USING btree (public_uuid);


--
-- Name: idx_cardfavorite_card_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_cardfavorite_card_id ON report_cardfavorite USING btree (card_id);


--
-- Name: idx_cardfavorite_owner_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_cardfavorite_owner_id ON report_cardfavorite USING btree (owner_id);


--
-- Name: idx_collection_slug; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_collection_slug ON collection USING btree (slug);


--
-- Name: idx_dashboard_creator_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_dashboard_creator_id ON report_dashboard USING btree (creator_id);


--
-- Name: idx_dashboard_favorite_dashboard_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_dashboard_favorite_dashboard_id ON dashboard_favorite USING btree (dashboard_id);


--
-- Name: idx_dashboard_favorite_user_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_dashboard_favorite_user_id ON dashboard_favorite USING btree (user_id);


--
-- Name: idx_dashboard_public_uuid; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_dashboard_public_uuid ON report_dashboard USING btree (public_uuid);


--
-- Name: idx_dashboardcard_card_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_dashboardcard_card_id ON report_dashboardcard USING btree (card_id);


--
-- Name: idx_dashboardcard_dashboard_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_dashboardcard_dashboard_id ON report_dashboardcard USING btree (dashboard_id);


--
-- Name: idx_dashboardcard_series_card_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_dashboardcard_series_card_id ON dashboardcard_series USING btree (card_id);


--
-- Name: idx_dashboardcard_series_dashboardcard_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_dashboardcard_series_dashboardcard_id ON dashboardcard_series USING btree (dashboardcard_id);


--
-- Name: idx_data_migrations_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_data_migrations_id ON data_migrations USING btree (id);


--
-- Name: idx_dependency_dependent_on_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_dependency_dependent_on_id ON dependency USING btree (dependent_on_id);


--
-- Name: idx_dependency_dependent_on_model; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_dependency_dependent_on_model ON dependency USING btree (dependent_on_model);


--
-- Name: idx_dependency_model; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_dependency_model ON dependency USING btree (model);


--
-- Name: idx_dependency_model_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_dependency_model_id ON dependency USING btree (model_id);


--
-- Name: idx_dimension_field_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_dimension_field_id ON dimension USING btree (field_id);


--
-- Name: idx_field_table_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_field_table_id ON metabase_field USING btree (table_id);


--
-- Name: idx_fieldvalues_field_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_fieldvalues_field_id ON metabase_fieldvalues USING btree (field_id);


--
-- Name: idx_label_slug; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_label_slug ON label USING btree (slug);


--
-- Name: idx_metabase_table_db_id_schema; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_metabase_table_db_id_schema ON metabase_table USING btree (schema);


--
-- Name: idx_metabase_table_show_in_getting_started; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_metabase_table_show_in_getting_started ON metabase_table USING btree (show_in_getting_started);


--
-- Name: idx_metric_creator_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_metric_creator_id ON metric USING btree (creator_id);


--
-- Name: idx_metric_important_field_field_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_metric_important_field_field_id ON metric_important_field USING btree (field_id);


--
-- Name: idx_metric_important_field_metric_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_metric_important_field_metric_id ON metric_important_field USING btree (metric_id);


--
-- Name: idx_metric_show_in_getting_started; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_metric_show_in_getting_started ON metric USING btree (show_in_getting_started);


--
-- Name: idx_metric_table_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_metric_table_id ON metric USING btree (table_id);


--
-- Name: idx_permissions_group_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_permissions_group_id ON permissions USING btree (group_id);


--
-- Name: idx_permissions_group_id_object; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_permissions_group_id_object ON permissions USING btree (object);


--
-- Name: idx_permissions_group_membership_group_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_permissions_group_membership_group_id ON permissions_group_membership USING btree (group_id);


--
-- Name: idx_permissions_group_membership_group_id_user_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_permissions_group_membership_group_id_user_id ON permissions_group_membership USING btree (user_id);


--
-- Name: idx_permissions_group_membership_user_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_permissions_group_membership_user_id ON permissions_group_membership USING btree (user_id);


--
-- Name: idx_permissions_group_name; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_permissions_group_name ON permissions_group USING btree (name);


--
-- Name: idx_permissions_object; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_permissions_object ON permissions USING btree (object);


--
-- Name: idx_pulse_card_card_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_pulse_card_card_id ON pulse_card USING btree (card_id);


--
-- Name: idx_pulse_card_pulse_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_pulse_card_pulse_id ON pulse_card USING btree (pulse_id);


--
-- Name: idx_pulse_channel_pulse_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_pulse_channel_pulse_id ON pulse_channel USING btree (pulse_id);


--
-- Name: idx_pulse_channel_schedule_type; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_pulse_channel_schedule_type ON pulse_channel USING btree (schedule_type);


--
-- Name: idx_pulse_creator_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_pulse_creator_id ON pulse USING btree (creator_id);


--
-- Name: idx_query_cache_updated_at; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_query_cache_updated_at ON query_cache USING btree (updated_at);


--
-- Name: idx_query_execution_query_hash_started_at; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_query_execution_query_hash_started_at ON query_execution USING btree (started_at);


--
-- Name: idx_query_execution_started_at; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_query_execution_started_at ON query_execution USING btree (started_at);


--
-- Name: idx_rawcolumn_raw_table_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_rawcolumn_raw_table_id ON raw_column USING btree (raw_table_id);


--
-- Name: idx_rawtable_database_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_rawtable_database_id ON raw_table USING btree (database_id);


--
-- Name: idx_report_dashboard_show_in_getting_started; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_report_dashboard_show_in_getting_started ON report_dashboard USING btree (show_in_getting_started);


--
-- Name: idx_revision_model_model_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_revision_model_model_id ON revision USING btree (model_id);


--
-- Name: idx_segment_creator_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_segment_creator_id ON segment USING btree (creator_id);


--
-- Name: idx_segment_show_in_getting_started; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_segment_show_in_getting_started ON segment USING btree (show_in_getting_started);


--
-- Name: idx_segment_table_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_segment_table_id ON segment USING btree (table_id);


--
-- Name: idx_table_db_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_table_db_id ON metabase_table USING btree (db_id);


--
-- Name: idx_view_log_timestamp; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_view_log_timestamp ON view_log USING btree (model_id);


--
-- Name: idx_view_log_user_id; Type: INDEX; Schema: public; Owner: quero_cultura
--

CREATE INDEX idx_view_log_user_id ON view_log USING btree (user_id);


--
-- Name: activity fk_activity_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY activity
    ADD CONSTRAINT fk_activity_ref_user_id FOREIGN KEY (user_id) REFERENCES core_user(id);


--
-- Name: report_card fk_card_collection_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY report_card
    ADD CONSTRAINT fk_card_collection_id FOREIGN KEY (collection_id) REFERENCES collection(id);


--
-- Name: card_label fk_card_label_ref_card_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY card_label
    ADD CONSTRAINT fk_card_label_ref_card_id FOREIGN KEY (card_id) REFERENCES report_card(id);


--
-- Name: card_label fk_card_label_ref_label_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY card_label
    ADD CONSTRAINT fk_card_label_ref_label_id FOREIGN KEY (label_id) REFERENCES label(id);


--
-- Name: report_card fk_card_made_public_by_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY report_card
    ADD CONSTRAINT fk_card_made_public_by_id FOREIGN KEY (made_public_by_id) REFERENCES core_user(id);


--
-- Name: report_card fk_card_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY report_card
    ADD CONSTRAINT fk_card_ref_user_id FOREIGN KEY (creator_id) REFERENCES core_user(id);


--
-- Name: report_cardfavorite fk_cardfavorite_ref_card_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY report_cardfavorite
    ADD CONSTRAINT fk_cardfavorite_ref_card_id FOREIGN KEY (card_id) REFERENCES report_card(id);


--
-- Name: report_cardfavorite fk_cardfavorite_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY report_cardfavorite
    ADD CONSTRAINT fk_cardfavorite_ref_user_id FOREIGN KEY (owner_id) REFERENCES core_user(id);


--
-- Name: collection_revision fk_collection_revision_user_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY collection_revision
    ADD CONSTRAINT fk_collection_revision_user_id FOREIGN KEY (user_id) REFERENCES core_user(id);


--
-- Name: dashboard_favorite fk_dashboard_favorite_dashboard_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY dashboard_favorite
    ADD CONSTRAINT fk_dashboard_favorite_dashboard_id FOREIGN KEY (dashboard_id) REFERENCES report_dashboard(id) ON DELETE CASCADE;


--
-- Name: dashboard_favorite fk_dashboard_favorite_user_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY dashboard_favorite
    ADD CONSTRAINT fk_dashboard_favorite_user_id FOREIGN KEY (user_id) REFERENCES core_user(id) ON DELETE CASCADE;


--
-- Name: report_dashboard fk_dashboard_made_public_by_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY report_dashboard
    ADD CONSTRAINT fk_dashboard_made_public_by_id FOREIGN KEY (made_public_by_id) REFERENCES core_user(id);


--
-- Name: report_dashboard fk_dashboard_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY report_dashboard
    ADD CONSTRAINT fk_dashboard_ref_user_id FOREIGN KEY (creator_id) REFERENCES core_user(id);


--
-- Name: report_dashboardcard fk_dashboardcard_ref_card_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY report_dashboardcard
    ADD CONSTRAINT fk_dashboardcard_ref_card_id FOREIGN KEY (card_id) REFERENCES report_card(id);


--
-- Name: report_dashboardcard fk_dashboardcard_ref_dashboard_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY report_dashboardcard
    ADD CONSTRAINT fk_dashboardcard_ref_dashboard_id FOREIGN KEY (dashboard_id) REFERENCES report_dashboard(id);


--
-- Name: dashboardcard_series fk_dashboardcard_series_ref_card_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY dashboardcard_series
    ADD CONSTRAINT fk_dashboardcard_series_ref_card_id FOREIGN KEY (card_id) REFERENCES report_card(id);


--
-- Name: dashboardcard_series fk_dashboardcard_series_ref_dashboardcard_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY dashboardcard_series
    ADD CONSTRAINT fk_dashboardcard_series_ref_dashboardcard_id FOREIGN KEY (dashboardcard_id) REFERENCES report_dashboardcard(id);


--
-- Name: dimension fk_dimension_displayfk_ref_field_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY dimension
    ADD CONSTRAINT fk_dimension_displayfk_ref_field_id FOREIGN KEY (human_readable_field_id) REFERENCES metabase_field(id) ON DELETE CASCADE;


--
-- Name: dimension fk_dimension_ref_field_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY dimension
    ADD CONSTRAINT fk_dimension_ref_field_id FOREIGN KEY (field_id) REFERENCES metabase_field(id) ON DELETE CASCADE;


--
-- Name: metabase_field fk_field_parent_ref_field_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY metabase_field
    ADD CONSTRAINT fk_field_parent_ref_field_id FOREIGN KEY (parent_id) REFERENCES metabase_field(id);


--
-- Name: metabase_field fk_field_ref_table_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY metabase_field
    ADD CONSTRAINT fk_field_ref_table_id FOREIGN KEY (table_id) REFERENCES metabase_table(id);


--
-- Name: metabase_fieldvalues fk_fieldvalues_ref_field_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY metabase_fieldvalues
    ADD CONSTRAINT fk_fieldvalues_ref_field_id FOREIGN KEY (field_id) REFERENCES metabase_field(id);


--
-- Name: metric_important_field fk_metric_important_field_metabase_field_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY metric_important_field
    ADD CONSTRAINT fk_metric_important_field_metabase_field_id FOREIGN KEY (field_id) REFERENCES metabase_field(id);


--
-- Name: metric_important_field fk_metric_important_field_metric_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY metric_important_field
    ADD CONSTRAINT fk_metric_important_field_metric_id FOREIGN KEY (metric_id) REFERENCES metric(id);


--
-- Name: metric fk_metric_ref_creator_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY metric
    ADD CONSTRAINT fk_metric_ref_creator_id FOREIGN KEY (creator_id) REFERENCES core_user(id);


--
-- Name: metric fk_metric_ref_table_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY metric
    ADD CONSTRAINT fk_metric_ref_table_id FOREIGN KEY (table_id) REFERENCES metabase_table(id);


--
-- Name: permissions_group_membership fk_permissions_group_group_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY permissions_group_membership
    ADD CONSTRAINT fk_permissions_group_group_id FOREIGN KEY (group_id) REFERENCES permissions_group(id);


--
-- Name: permissions fk_permissions_group_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY permissions
    ADD CONSTRAINT fk_permissions_group_id FOREIGN KEY (group_id) REFERENCES permissions_group(id);


--
-- Name: permissions_group_membership fk_permissions_group_membership_user_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY permissions_group_membership
    ADD CONSTRAINT fk_permissions_group_membership_user_id FOREIGN KEY (user_id) REFERENCES core_user(id);


--
-- Name: permissions_revision fk_permissions_revision_user_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY permissions_revision
    ADD CONSTRAINT fk_permissions_revision_user_id FOREIGN KEY (user_id) REFERENCES core_user(id);


--
-- Name: pulse_card fk_pulse_card_ref_card_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY pulse_card
    ADD CONSTRAINT fk_pulse_card_ref_card_id FOREIGN KEY (card_id) REFERENCES report_card(id);


--
-- Name: pulse_card fk_pulse_card_ref_pulse_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY pulse_card
    ADD CONSTRAINT fk_pulse_card_ref_pulse_id FOREIGN KEY (pulse_id) REFERENCES pulse(id);


--
-- Name: pulse_channel_recipient fk_pulse_channel_recipient_ref_pulse_channel_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY pulse_channel_recipient
    ADD CONSTRAINT fk_pulse_channel_recipient_ref_pulse_channel_id FOREIGN KEY (pulse_channel_id) REFERENCES pulse_channel(id);


--
-- Name: pulse_channel_recipient fk_pulse_channel_recipient_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY pulse_channel_recipient
    ADD CONSTRAINT fk_pulse_channel_recipient_ref_user_id FOREIGN KEY (user_id) REFERENCES core_user(id);


--
-- Name: pulse_channel fk_pulse_channel_ref_pulse_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY pulse_channel
    ADD CONSTRAINT fk_pulse_channel_ref_pulse_id FOREIGN KEY (pulse_id) REFERENCES pulse(id);


--
-- Name: pulse fk_pulse_ref_creator_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY pulse
    ADD CONSTRAINT fk_pulse_ref_creator_id FOREIGN KEY (creator_id) REFERENCES core_user(id);


--
-- Name: raw_column fk_rawcolumn_fktarget_ref_rawcolumn; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY raw_column
    ADD CONSTRAINT fk_rawcolumn_fktarget_ref_rawcolumn FOREIGN KEY (fk_target_column_id) REFERENCES raw_column(id);


--
-- Name: raw_column fk_rawcolumn_tableid_ref_rawtable; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY raw_column
    ADD CONSTRAINT fk_rawcolumn_tableid_ref_rawtable FOREIGN KEY (raw_table_id) REFERENCES raw_table(id);


--
-- Name: report_card fk_report_card_ref_database_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY report_card
    ADD CONSTRAINT fk_report_card_ref_database_id FOREIGN KEY (database_id) REFERENCES metabase_database(id);


--
-- Name: report_card fk_report_card_ref_table_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY report_card
    ADD CONSTRAINT fk_report_card_ref_table_id FOREIGN KEY (table_id) REFERENCES metabase_table(id);


--
-- Name: revision fk_revision_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY revision
    ADD CONSTRAINT fk_revision_ref_user_id FOREIGN KEY (user_id) REFERENCES core_user(id);


--
-- Name: segment fk_segment_ref_creator_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY segment
    ADD CONSTRAINT fk_segment_ref_creator_id FOREIGN KEY (creator_id) REFERENCES core_user(id);


--
-- Name: segment fk_segment_ref_table_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY segment
    ADD CONSTRAINT fk_segment_ref_table_id FOREIGN KEY (table_id) REFERENCES metabase_table(id);


--
-- Name: core_session fk_session_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY core_session
    ADD CONSTRAINT fk_session_ref_user_id FOREIGN KEY (user_id) REFERENCES core_user(id);


--
-- Name: metabase_table fk_table_ref_database_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY metabase_table
    ADD CONSTRAINT fk_table_ref_database_id FOREIGN KEY (db_id) REFERENCES metabase_database(id);


--
-- Name: view_log fk_view_log_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY view_log
    ADD CONSTRAINT fk_view_log_ref_user_id FOREIGN KEY (user_id) REFERENCES core_user(id);


--
-- PostgreSQL database dump complete
--

