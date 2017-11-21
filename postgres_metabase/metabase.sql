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
36	card-update	2017-11-14 00:19:10.262+00	1	card	4	2	12	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
37	card-update	2017-11-14 00:19:10.373+00	1	card	4	2	12	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
38	card-update	2017-11-14 00:24:14.125+00	1	card	3	2	12	\N	{"name":"Quantidade de Registros por Mês","description":null}
39	card-update	2017-11-14 00:24:14.188+00	1	card	3	2	12	\N	{"name":"Quantidade de Registros por Mês","description":null}
40	card-update	2017-11-14 00:25:00.67+00	1	card	6	2	12	\N	{"name":"Crescimento Cumulativo Mensal por Instância","description":null}
41	card-update	2017-11-14 00:25:00.726+00	1	card	6	2	12	\N	{"name":"Crescimento Cumulativo Mensal por Instância","description":null}
42	card-update	2017-11-14 00:25:30.437+00	1	card	7	2	12	\N	{"name":"Tipos por Instância","description":null}
43	card-update	2017-11-14 00:25:30.482+00	1	card	7	2	12	\N	{"name":"Tipos por Instância","description":null}
44	card-update	2017-11-14 06:15:27.875+00	1	card	2	2	15	\N	{"name":"Áreas de Atuação por Instância","description":null}
45	card-update	2017-11-14 13:45:43.322+00	1	card	6	2	12	\N	{"name":"Crescimento Cumulativo Mensal por Instância","description":null}
46	card-update	2017-11-14 14:07:36.194+00	1	card	7	2	12	\N	{"name":"Tipos por Instância","description":null}
47	card-create	2017-11-14 14:12:47.74+00	1	card	8	2	12	\N	{"name":"Space Data, Count, Grouped by Date (hour-of-day), Sorted by Date, (day) descending","description":null}
48	dashboard-add-cards	2017-11-14 14:13:01.556+00	1	dashboard	1	\N	\N	\N	{"description":"Indicadores criados para as informações de Espaços fornecidas pela plataforma Mapas Culturais do MinC","name":"Espaços","dashcards":[{"name":"Space Data, Count, Grouped by Date (hour-of-day), Sorted by Date, (day) descending","description":null,"id":7,"card_id":8}]}
49	card-create	2017-11-14 14:13:59.883+00	1	card	9	2	12	\N	{"name":"Space Data, Count, Grouped by Date (day-of-week)","description":null}
50	dashboard-add-cards	2017-11-14 14:14:17.404+00	1	dashboard	1	\N	\N	\N	{"description":"Indicadores criados para as informações de Espaços fornecidas pela plataforma Mapas Culturais do MinC","name":"Espaços","dashcards":[{"name":"Space Data, Count, Grouped by Date (day-of-week)","description":null,"id":8,"card_id":9}]}
51	card-create	2017-11-18 01:16:54.007+00	1	card	10	2	16	\N	{"name":"Registros por Mês","description":null}
52	card-create	2017-11-18 01:17:45.46+00	1	card	11	2	16	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
53	card-create	2017-11-18 01:19:39.368+00	1	card	12	2	16	\N	{"name":"Porcentagem de Projetos que Aceitam Inscrições Online","description":null}
54	card-create	2017-11-18 01:22:09.789+00	1	card	13	2	16	\N	{"name":"Tipos por Instancia","description":null}
55	card-update	2017-11-18 02:49:25.842+00	1	card	11	2	16	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
56	card-update	2017-11-18 02:49:36.679+00	1	card	12	2	16	\N	{"name":"Porcentagem de Projetos que Aceitam Inscrições Online","description":null}
57	card-update	2017-11-18 02:49:47.318+00	1	card	10	2	16	\N	{"name":"Registros por Mês","description":null}
58	card-update	2017-11-18 02:49:54.521+00	1	card	13	2	16	\N	{"name":"Tipos por Instancia","description":null}
59	card-update	2017-11-18 02:54:50.991+00	1	card	13	2	16	\N	{"name":"Tipos por Instancia","description":null}
60	card-update	2017-11-18 02:54:51.037+00	1	card	13	2	16	\N	{"name":"Tipos por Instancia","description":null}
61	card-update	2017-11-18 02:55:09.134+00	1	card	10	2	16	\N	{"name":"Registros por Mês","description":null}
62	card-update	2017-11-18 02:55:09.186+00	1	card	10	2	16	\N	{"name":"Registros por Mês","description":null}
63	card-update	2017-11-18 02:55:26.464+00	1	card	12	2	16	\N	{"name":"Porcentagem de Projetos que Aceitam Inscrições Online","description":null}
64	card-update	2017-11-18 02:55:26.515+00	1	card	12	2	16	\N	{"name":"Porcentagem de Projetos que Aceitam Inscrições Online","description":null}
65	card-update	2017-11-18 02:55:42.495+00	1	card	11	2	16	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
66	card-update	2017-11-18 02:55:42.531+00	1	card	11	2	16	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
67	card-create	2017-11-19 17:58:14.341+00	1	card	14	2	18	\N	{"name":"Quantidade de Registros por Mês","description":null}
68	card-create	2017-11-19 17:59:28.649+00	1	card	15	2	18	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
69	card-create	2017-11-19 18:02:10.791+00	1	card	16	2	18	\N	{"name":"Porcentagem de Eventos por Faixa Etária","description":null}
70	card-create	2017-11-19 18:03:50.534+00	1	card	17	2	20	\N	{"name":"Linguagens por Instância","description":null}
71	card-update	2017-11-19 18:04:13.063+00	1	card	15	2	18	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
72	card-update	2017-11-19 18:04:25.248+00	1	card	17	2	20	\N	{"name":"Linguagens por Instância","description":null}
73	card-update	2017-11-19 18:04:39.123+00	1	card	16	2	18	\N	{"name":"Porcentagem de Eventos por Faixa Etária","description":null}
74	card-update	2017-11-19 18:04:46.967+00	1	card	14	2	18	\N	{"name":"Quantidade de Registros por Mês","description":null}
75	card-update	2017-11-19 18:07:36.6+00	1	card	15	2	18	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
76	card-update	2017-11-19 18:07:36.673+00	1	card	15	2	18	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
77	card-update	2017-11-19 18:07:47.679+00	1	card	17	2	20	\N	{"name":"Linguagens por Instância","description":null}
78	card-update	2017-11-19 18:07:47.753+00	1	card	17	2	20	\N	{"name":"Linguagens por Instância","description":null}
79	card-update	2017-11-19 18:08:01.729+00	1	card	16	2	18	\N	{"name":"Porcentagem de Eventos por Faixa Etária","description":null}
80	card-update	2017-11-19 18:08:01.81+00	1	card	16	2	18	\N	{"name":"Porcentagem de Eventos por Faixa Etária","description":null}
81	card-update	2017-11-19 18:08:12.18+00	1	card	14	2	18	\N	{"name":"Quantidade de Registros por Mês","description":null}
82	card-update	2017-11-19 18:08:12.235+00	1	card	14	2	18	\N	{"name":"Quantidade de Registros por Mês","description":null}
83	card-create	2017-11-20 23:04:08.7+00	1	card	18	2	22	\N	{"name":"Quantidade de Registros por Tipo","description":null}
84	card-create	2017-11-20 23:05:38.408+00	1	card	19	2	22	\N	{"name":"Quantidade de Registros por Temática","description":null}
85	card-create	2017-11-20 23:06:35.801+00	1	card	20	2	22	\N	{"name":"Porcentagem por Esfera","description":null}
86	card-create	2017-11-20 23:07:18.334+00	1	card	21	2	22	\N	{"name":"Porcentagem por Visita Guiada","description":null}
87	card-create	2017-11-20 23:08:03.883+00	1	card	22	2	22	\N	{"name":"Porcentagem por Arquivo com Acesso Público","description":null}
88	card-create	2017-11-20 23:09:02.864+00	1	card	23	2	22	\N	{"name":"Registros por Mês","description":null}
89	card-create	2017-11-20 23:10:58.3+00	1	card	24	2	22	\N	{"name":"Crscimento Cumulativo Mensal","description":null}
90	card-update	2017-11-20 23:11:14.58+00	1	card	24	2	22	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
91	card-update	2017-11-20 23:11:47.174+00	1	card	24	2	22	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
92	card-update	2017-11-20 23:11:53.716+00	1	card	22	2	22	\N	{"name":"Porcentagem por Arquivo com Acesso Público","description":null}
93	card-update	2017-11-20 23:11:59.642+00	1	card	20	2	22	\N	{"name":"Porcentagem por Esfera","description":null}
94	card-update	2017-11-20 23:12:09.736+00	1	card	21	2	22	\N	{"name":"Porcentagem por Visita Guiada","description":null}
95	card-update	2017-11-20 23:12:21.462+00	1	card	19	2	22	\N	{"name":"Quantidade de Registros por Temática","description":null}
96	card-update	2017-11-20 23:12:26.716+00	1	card	18	2	22	\N	{"name":"Quantidade de Registros por Tipo","description":null}
97	card-update	2017-11-20 23:12:32.985+00	1	card	23	2	22	\N	{"name":"Registros por Mês","description":null}
98	card-update	2017-11-20 23:16:43.757+00	1	card	24	2	22	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
99	card-update	2017-11-20 23:16:43.796+00	1	card	24	2	22	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
103	card-update	2017-11-20 23:17:21.363+00	1	card	20	2	22	\N	{"name":"Porcentagem por Esfera","description":null}
105	card-update	2017-11-20 23:17:41.059+00	1	card	21	2	22	\N	{"name":"Porcentagem por Visita Guiada","description":null}
107	card-update	2017-11-20 23:17:57.13+00	1	card	19	2	22	\N	{"name":"Quantidade de Registros por Temática","description":null}
127	card-update	2017-11-20 23:51:58.642+00	1	card	26	2	25	\N	{"name":"Porcentagem por Tipo de Esfera","description":null}
100	card-update	2017-11-20 23:17:02.523+00	1	card	22	2	22	\N	{"name":"Porcentagem por Arquivo com Acesso Público","description":null}
111	card-update	2017-11-20 23:18:33.111+00	1	card	23	2	22	\N	{"name":"Registros por Mês","description":null}
122	card-update	2017-11-20 23:51:33.907+00	1	card	28	2	25	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
125	card-update	2017-11-20 23:51:43.738+00	1	card	25	2	25	\N	{"name":"Porcentagem por Esfera","description":null}
128	card-update	2017-11-20 23:52:08.771+00	1	card	29	2	23	\N	{"name":"Quantidade de Registros por Área","description":null}
101	card-update	2017-11-20 23:17:02.576+00	1	card	22	2	22	\N	{"name":"Porcentagem por Arquivo com Acesso Público","description":null}
102	card-update	2017-11-20 23:17:21.313+00	1	card	20	2	22	\N	{"name":"Porcentagem por Esfera","description":null}
104	card-update	2017-11-20 23:17:40.989+00	1	card	21	2	22	\N	{"name":"Porcentagem por Visita Guiada","description":null}
110	card-update	2017-11-20 23:18:33.037+00	1	card	23	2	22	\N	{"name":"Registros por Mês","description":null}
114	card-create	2017-11-20 23:47:48.657+00	1	card	27	2	25	\N	{"name":"Quantidade de Registros por Mês","description":null}
120	card-update	2017-11-20 23:51:04.7+00	1	card	29	2	23	\N	{"name":"Quantidade de Registros por Área","description":null}
126	card-update	2017-11-20 23:51:58.58+00	1	card	26	2	25	\N	{"name":"Porcentagem por Tipo de Esfera","description":null}
106	card-update	2017-11-20 23:17:57.076+00	1	card	19	2	22	\N	{"name":"Quantidade de Registros por Temática","description":null}
108	card-update	2017-11-20 23:18:15.143+00	1	card	18	2	22	\N	{"name":"Quantidade de Registros por Tipo","description":null}
109	card-update	2017-11-20 23:18:15.233+00	1	card	18	2	22	\N	{"name":"Quantidade de Registros por Tipo","description":null}
115	card-create	2017-11-20 23:48:24.601+00	1	card	28	2	25	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
124	card-update	2017-11-20 23:51:43.687+00	1	card	25	2	25	\N	{"name":"Porcentagem por Esfera","description":null}
112	card-create	2017-11-20 23:46:06.839+00	1	card	25	2	25	\N	{"name":"Porcentagem por Esfera","description":null}
113	card-create	2017-11-20 23:47:00.417+00	1	card	26	2	25	\N	{"name":"Porcentagem por Tipo de Esfera","description":null}
116	card-create	2017-11-20 23:50:00.693+00	1	card	29	2	23	\N	{"name":"Quantidade de Registros por Área","description":null}
117	card-update	2017-11-20 23:50:36.315+00	1	card	28	2	25	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
118	card-update	2017-11-20 23:50:49.119+00	1	card	25	2	25	\N	{"name":"Porcentagem por Esfera","description":null}
119	card-update	2017-11-20 23:50:54.652+00	1	card	26	2	25	\N	{"name":"Porcentagem por Tipo de Esfera","description":null}
121	card-update	2017-11-20 23:51:10.716+00	1	card	27	2	25	\N	{"name":"Quantidade de Registros por Mês","description":null}
123	card-update	2017-11-20 23:51:33.989+00	1	card	28	2	25	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
129	card-update	2017-11-20 23:52:08.842+00	1	card	29	2	23	\N	{"name":"Quantidade de Registros por Área","description":null}
130	card-update	2017-11-20 23:52:23.214+00	1	card	27	2	25	\N	{"name":"Quantidade de Registros por Mês","description":null}
131	card-update	2017-11-20 23:52:23.293+00	1	card	27	2	25	\N	{"name":"Quantidade de Registros por Mês","description":null}
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
1	Indicadores de Projetos	indicadores_de_projetos	\N	#EF8C8C	f
2	Indicadores de Eventos	indicadores_de_eventos	\N	#F1B556	f
3	Indicadores de Museus	indicadores_de_museus	\N	#9CC177	f
4	Indicadores de Bibliotecas	indicadores_de_bibliotecas	\N	#7172AD	f
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
1b788770-feae-4aed-8959-7a30b61edb7a	1	2017-11-13 23:18:11.831+00
1c05e8ee-4a4d-4d80-9c7d-35c7605bc526	1	2017-11-18 01:13:21.639+00
\.


--
-- Data for Name: core_user; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY core_user (id, email, first_name, last_name, password, password_salt, date_joined, last_login, is_superuser, is_active, reset_token, reset_triggered, is_qbnewb, google_auth, ldap_auth) FROM stdin;
1	querocultura61@gmail.com	Quero	Cultura	$2a$10$mucdErrPR1pnf39krDT6Zu6TcEbtqE3SLNMEUsVJoHOxWJBzeXf9m	8c9df11c-9bd9-49fd-b830-8b8e90b802cb	2017-11-11 23:03:21.9+00	2017-11-18 01:13:21.658+00	t	t	\N	\N	f	f	f
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
28	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	27	EXECUTED	7:335e7e6b32dcbeb392150b3c3db2d5eb	addColumn tableName=core_user		\N	3.5.3	\N	\N	0441238708
23	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	22	EXECUTED	7:43b9662bd798db391d4bbb7d4615bf0d	modifyDataType columnName=rows, tableName=metabase_table		\N	3.5.3	\N	\N	0441238708
24	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	23	EXECUTED	7:69c2cad167fd7cec9e8c920d9ccab86e	createTable tableName=dependency; createIndex indexName=idx_dependency_model, tableName=dependency; createIndex indexName=idx_dependency_model_id, tableName=dependency; createIndex indexName=idx_dependency_dependent_on_model, tableName=dependency;...		\N	3.5.3	\N	\N	0441238708
25	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	24	EXECUTED	7:327941d9ac9414f493471b746a812fa4	createTable tableName=metric; createIndex indexName=idx_metric_creator_id, tableName=metric; createIndex indexName=idx_metric_table_id, tableName=metric		\N	3.5.3	\N	\N	0441238708
26	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	25	EXECUTED	7:ac7f40d2a3fbf3fea7936aa79bb1532b	addColumn tableName=metabase_database; sql		\N	3.5.3	\N	\N	0441238708
27	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	26	EXECUTED	7:e3a52bd649da7940246e4236b204714b	createTable tableName=dashboardcard_series; createIndex indexName=idx_dashboardcard_series_dashboardcard_id, tableName=dashboardcard_series; createIndex indexName=idx_dashboardcard_series_card_id, tableName=dashboardcard_series		\N	3.5.3	\N	\N	0441238708
28	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	27	EXECUTED	7:335e7e6b32dcbeb392150b3c3db2d5eb	addColumn tableName=core_user		\N	3.5.3	\N	\N	0441238708
29	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	28	EXECUTED	7:7b0bb8fcb7de2aa29ce57b32baf9ff31	addColumn tableName=pulse_channel		\N	3.5.3	\N	\N	0441238708
30	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	29	EXECUTED	7:7b5245de5d964eedb5cd6fdf5afdb6fd	addColumn tableName=metabase_field; addNotNullConstraint columnName=visibility_type, tableName=metabase_field		\N	3.5.3	\N	\N	0441238708
31	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	30	EXECUTED	7:347281cdb65a285b03aeaf77cb28e618	addColumn tableName=metabase_field		\N	3.5.3	\N	\N	0441238708
59	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	58	EXECUTED	7:583e67af40cae19cab645bbd703558ef	addColumn tableName=metabase_field	Added 0.26.0	\N	3.5.3	\N	\N	0441238708
32	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	31	EXECUTED	7:ff40b5fbe06dc5221d0b9223992ece25	createTable tableName=label; createIndex indexName=idx_label_slug, tableName=label; createTable tableName=card_label; addUniqueConstraint constraintName=unique_card_label_card_id_label_id, tableName=card_label; createIndex indexName=idx_card_label...		\N	3.5.3	\N	\N	0441238708
66	senior	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	64	EXECUTED	7:76d06b44a544105c2a613603b8bdf25f	sql; sql	Added 0.26.0	\N	3.5.3	\N	\N	0441238708
32	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	32	EXECUTED	7:af1dea42abdc7cd058b5f744602d7a22	createTable tableName=raw_table; createIndex indexName=idx_rawtable_database_id, tableName=raw_table; addUniqueConstraint constraintName=uniq_raw_table_db_schema_name, tableName=raw_table; createTable tableName=raw_column; createIndex indexName=id...		\N	3.5.3	\N	\N	0441238708
34	tlrobinson	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	33	EXECUTED	7:e65d70b4c914cfdf5b3ef9927565e899	addColumn tableName=pulse_channel		\N	3.5.3	\N	\N	0441238708
35	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	34	EXECUTED	7:ab80b6b8e6dfc3fa3e8fa5954e3a8ec4	modifyDataType columnName=value, tableName=setting		\N	3.5.3	\N	\N	0441238708
36	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	35	EXECUTED	7:de534c871471b400d70ee29122f23847	addColumn tableName=report_dashboard; addNotNullConstraint columnName=parameters, tableName=report_dashboard; addColumn tableName=report_dashboardcard; addNotNullConstraint columnName=parameter_mappings, tableName=report_dashboardcard		\N	3.5.3	\N	\N	0441238708
66	senior	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	64	EXECUTED	7:76d06b44a544105c2a613603b8bdf25f	sql; sql	Added 0.26.0	\N	3.5.3	\N	\N	0441238708
37	tlrobinson	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	36	EXECUTED	7:487dd1fa57af0f25edf3265ed9899588	addColumn tableName=query_queryexecution; addNotNullConstraint columnName=query_hash, tableName=query_queryexecution; createIndex indexName=idx_query_queryexecution_query_hash, tableName=query_queryexecution; createIndex indexName=idx_query_querye...		\N	3.5.3	\N	\N	0441238708
8	tlrobinson	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	7	EXECUTED	7:ea2727c7ce666178cff436549f81ddbd	addColumn tableName=metabase_table; addColumn tableName=metabase_field		\N	3.5.3	\N	\N	0441238708
38	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	37	EXECUTED	7:5e32fa14a0c34b99027e25901b7e3255	addColumn tableName=metabase_database; addColumn tableName=metabase_table; addColumn tableName=metabase_field; addColumn tableName=report_dashboard; addColumn tableName=metric; addColumn tableName=segment; addColumn tableName=metabase_database; ad...		\N	3.5.3	\N	\N	0441238708
40	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	39	EXECUTED	7:0ba56822308957969bf5ad5ea8ee6707	createTable tableName=permissions_group; createIndex indexName=idx_permissions_group_name, tableName=permissions_group; createTable tableName=permissions_group_membership; addUniqueConstraint constraintName=unique_permissions_group_membership_user...		\N	3.5.3	\N	\N	0441238708
41	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	40	EXECUTED	7:e1aa5b70f61426b29d74d38936e560de	dropColumn columnName=field_type, tableName=metabase_field; addDefaultValue columnName=active, tableName=metabase_field; addDefaultValue columnName=preview_display, tableName=metabase_field; addDefaultValue columnName=position, tableName=metabase_...		\N	3.5.3	\N	\N	0441238708
42	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	41	EXECUTED	7:779407e2ea3b8d89092fc9f72e29fdaa	dropForeignKeyConstraint baseTableName=query_queryexecution, constraintName=fk_queryexecution_ref_query_id; dropColumn columnName=query_id, tableName=query_queryexecution; dropColumn columnName=is_staff, tableName=core_user; dropColumn columnName=...		\N	3.5.3	\N	\N	0441238708
57	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	56	EXECUTED	7:5d51b16e22be3c81a27d3b5b345a8270	addColumn tableName=report_card	Added 0.25.0	\N	3.5.3	\N	\N	0441238708
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
39	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	38	EXECUTED	7:a63ada256c44684d2649b8f3c28a3023	addColumn tableName=core_user		\N	3.5.3	\N	\N	0441238708
4	cammsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	3	EXECUTED	7:1ed887e91a846f4d6cbe84d1efd126c4	createTable tableName=setting		\N	3.5.3	\N	\N	0441238708
10	cammsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	9	EXECUTED	7:ec4f8eecc37fdc8c22440490de3a13f0	createTable tableName=revision; createIndex indexName=idx_revision_model_model_id, tableName=revision		\N	3.5.3	\N	\N	0441238708
12	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	11	EXECUTED	7:f78e18f669d7c9e6d06c63ea9929391f	addColumn tableName=report_card		\N	3.5.3	\N	\N	0441238708
13	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	12	EXECUTED	7:20a2ef1765573854864909ec2e7de766	createTable tableName=activity; createIndex indexName=idx_activity_timestamp, tableName=activity; createIndex indexName=idx_activity_user_id, tableName=activity; createIndex indexName=idx_activity_custom_id, tableName=activity		\N	3.5.3	\N	\N	0441238708
14	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	13	EXECUTED	7:6614fcaca4e41d003ce26de5cbc882f7	createTable tableName=view_log; createIndex indexName=idx_view_log_user_id, tableName=view_log; createIndex indexName=idx_view_log_timestamp, tableName=view_log		\N	3.5.3	\N	\N	0441238708
15	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	14	EXECUTED	7:50c72a51651af76928c06f21c9e04f97	addColumn tableName=revision		\N	3.5.3	\N	\N	0441238708
16	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	15	EXECUTED	7:a398a37dd953a0e82633d12658c6ac8f	dropNotNullConstraint columnName=last_login, tableName=core_user		\N	3.5.3	\N	\N	0441238708
17	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	16	EXECUTED	7:5401ec35a5bd1275f93a7cac1ddd7591	addColumn tableName=metabase_database; sql		\N	3.5.3	\N	\N	0441238708
11	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	10	EXECUTED	7:c7ef8b4f4dcb3528f9282b51aea5bb2a	sql		\N	3.5.3	\N	\N	0441238708
18	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	17	EXECUTED	7:329d897d44ba9893fdafc9ce7e876d73	createTable tableName=data_migrations; createIndex indexName=idx_data_migrations_id, tableName=data_migrations		\N	3.5.3	\N	\N	0441238708
19	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	18	EXECUTED	7:e8fa976811e4d58d42a45804affa1d07	addColumn tableName=metabase_table		\N	3.5.3	\N	\N	0441238708
20	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	19	EXECUTED	7:9c5fedbd888307edf521a6a547f96f99	createTable tableName=pulse; createIndex indexName=idx_pulse_creator_id, tableName=pulse; createTable tableName=pulse_card; createIndex indexName=idx_pulse_card_pulse_id, tableName=pulse_card; createIndex indexName=idx_pulse_card_card_id, tableNam...		\N	3.5.3	\N	\N	0441238708
21	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	20	EXECUTED	7:c23c71d8a11b3f38aaf5bf98acf51e6f	createTable tableName=segment; createIndex indexName=idx_segment_creator_id, tableName=segment; createIndex indexName=idx_segment_table_id, tableName=segment		\N	3.5.3	\N	\N	0441238708
22	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	21	EXECUTED	7:cb6776ec86ab0ad9e74806a5460b9085	addColumn tableName=revision		\N	3.5.3	\N	\N	0441238708
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
23	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	22	EXECUTED	7:43b9662bd798db391d4bbb7d4615bf0d	modifyDataType columnName=rows, tableName=metabase_table		\N	3.5.3	\N	\N	0441238708
24	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	23	EXECUTED	7:69c2cad167fd7cec9e8c920d9ccab86e	createTable tableName=dependency; createIndex indexName=idx_dependency_model, tableName=dependency; createIndex indexName=idx_dependency_model_id, tableName=dependency; createIndex indexName=idx_dependency_dependent_on_model, tableName=dependency;...		\N	3.5.3	\N	\N	0441238708
25	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	24	EXECUTED	7:327941d9ac9414f493471b746a812fa4	createTable tableName=metric; createIndex indexName=idx_metric_creator_id, tableName=metric; createIndex indexName=idx_metric_table_id, tableName=metric		\N	3.5.3	\N	\N	0441238708
26	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	25	EXECUTED	7:ac7f40d2a3fbf3fea7936aa79bb1532b	addColumn tableName=metabase_database; sql		\N	3.5.3	\N	\N	0441238708
27	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	26	EXECUTED	7:e3a52bd649da7940246e4236b204714b	createTable tableName=dashboardcard_series; createIndex indexName=idx_dashboardcard_series_dashboardcard_id, tableName=dashboardcard_series; createIndex indexName=idx_dashboardcard_series_card_id, tableName=dashboardcard_series		\N	3.5.3	\N	\N	0441238708
29	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	28	EXECUTED	7:7b0bb8fcb7de2aa29ce57b32baf9ff31	addColumn tableName=pulse_channel		\N	3.5.3	\N	\N	0441238708
30	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	29	EXECUTED	7:7b5245de5d964eedb5cd6fdf5afdb6fd	addColumn tableName=metabase_field; addNotNullConstraint columnName=visibility_type, tableName=metabase_field		\N	3.5.3	\N	\N	0441238708
31	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	30	EXECUTED	7:347281cdb65a285b03aeaf77cb28e618	addColumn tableName=metabase_field		\N	3.5.3	\N	\N	0441238708
59	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	58	EXECUTED	7:583e67af40cae19cab645bbd703558ef	addColumn tableName=metabase_field	Added 0.26.0	\N	3.5.3	\N	\N	0441238708
32	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	31	EXECUTED	7:ff40b5fbe06dc5221d0b9223992ece25	createTable tableName=label; createIndex indexName=idx_label_slug, tableName=label; createTable tableName=card_label; addUniqueConstraint constraintName=unique_card_label_card_id_label_id, tableName=card_label; createIndex indexName=idx_card_label...		\N	3.5.3	\N	\N	0441238708
32	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	32	EXECUTED	7:af1dea42abdc7cd058b5f744602d7a22	createTable tableName=raw_table; createIndex indexName=idx_rawtable_database_id, tableName=raw_table; addUniqueConstraint constraintName=uniq_raw_table_db_schema_name, tableName=raw_table; createTable tableName=raw_column; createIndex indexName=id...		\N	3.5.3	\N	\N	0441238708
34	tlrobinson	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	33	EXECUTED	7:e65d70b4c914cfdf5b3ef9927565e899	addColumn tableName=pulse_channel		\N	3.5.3	\N	\N	0441238708
35	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	34	EXECUTED	7:ab80b6b8e6dfc3fa3e8fa5954e3a8ec4	modifyDataType columnName=value, tableName=setting		\N	3.5.3	\N	\N	0441238708
36	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	35	EXECUTED	7:de534c871471b400d70ee29122f23847	addColumn tableName=report_dashboard; addNotNullConstraint columnName=parameters, tableName=report_dashboard; addColumn tableName=report_dashboardcard; addNotNullConstraint columnName=parameter_mappings, tableName=report_dashboardcard		\N	3.5.3	\N	\N	0441238708
37	tlrobinson	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	36	EXECUTED	7:487dd1fa57af0f25edf3265ed9899588	addColumn tableName=query_queryexecution; addNotNullConstraint columnName=query_hash, tableName=query_queryexecution; createIndex indexName=idx_query_queryexecution_query_hash, tableName=query_queryexecution; createIndex indexName=idx_query_querye...		\N	3.5.3	\N	\N	0441238708
8	tlrobinson	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	7	EXECUTED	7:ea2727c7ce666178cff436549f81ddbd	addColumn tableName=metabase_table; addColumn tableName=metabase_field		\N	3.5.3	\N	\N	0441238708
38	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	37	EXECUTED	7:5e32fa14a0c34b99027e25901b7e3255	addColumn tableName=metabase_database; addColumn tableName=metabase_table; addColumn tableName=metabase_field; addColumn tableName=report_dashboard; addColumn tableName=metric; addColumn tableName=segment; addColumn tableName=metabase_database; ad...		\N	3.5.3	\N	\N	0441238708
40	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	39	EXECUTED	7:0ba56822308957969bf5ad5ea8ee6707	createTable tableName=permissions_group; createIndex indexName=idx_permissions_group_name, tableName=permissions_group; createTable tableName=permissions_group_membership; addUniqueConstraint constraintName=unique_permissions_group_membership_user...		\N	3.5.3	\N	\N	0441238708
41	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	40	EXECUTED	7:e1aa5b70f61426b29d74d38936e560de	dropColumn columnName=field_type, tableName=metabase_field; addDefaultValue columnName=active, tableName=metabase_field; addDefaultValue columnName=preview_display, tableName=metabase_field; addDefaultValue columnName=position, tableName=metabase_...		\N	3.5.3	\N	\N	0441238708
42	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	41	EXECUTED	7:779407e2ea3b8d89092fc9f72e29fdaa	dropForeignKeyConstraint baseTableName=query_queryexecution, constraintName=fk_queryexecution_ref_query_id; dropColumn columnName=query_id, tableName=query_queryexecution; dropColumn columnName=is_staff, tableName=core_user; dropColumn columnName=...		\N	3.5.3	\N	\N	0441238708
57	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	56	EXECUTED	7:5d51b16e22be3c81a27d3b5b345a8270	addColumn tableName=report_card	Added 0.25.0	\N	3.5.3	\N	\N	0441238708
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
39	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	38	EXECUTED	7:a63ada256c44684d2649b8f3c28a3023	addColumn tableName=core_user		\N	3.5.3	\N	\N	0441238708
4	cammsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	3	EXECUTED	7:1ed887e91a846f4d6cbe84d1efd126c4	createTable tableName=setting		\N	3.5.3	\N	\N	0441238708
10	cammsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	9	EXECUTED	7:ec4f8eecc37fdc8c22440490de3a13f0	createTable tableName=revision; createIndex indexName=idx_revision_model_model_id, tableName=revision		\N	3.5.3	\N	\N	0441238708
12	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	11	EXECUTED	7:f78e18f669d7c9e6d06c63ea9929391f	addColumn tableName=report_card		\N	3.5.3	\N	\N	0441238708
13	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	12	EXECUTED	7:20a2ef1765573854864909ec2e7de766	createTable tableName=activity; createIndex indexName=idx_activity_timestamp, tableName=activity; createIndex indexName=idx_activity_user_id, tableName=activity; createIndex indexName=idx_activity_custom_id, tableName=activity		\N	3.5.3	\N	\N	0441238708
14	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	13	EXECUTED	7:6614fcaca4e41d003ce26de5cbc882f7	createTable tableName=view_log; createIndex indexName=idx_view_log_user_id, tableName=view_log; createIndex indexName=idx_view_log_timestamp, tableName=view_log		\N	3.5.3	\N	\N	0441238708
15	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	14	EXECUTED	7:50c72a51651af76928c06f21c9e04f97	addColumn tableName=revision		\N	3.5.3	\N	\N	0441238708
16	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	15	EXECUTED	7:a398a37dd953a0e82633d12658c6ac8f	dropNotNullConstraint columnName=last_login, tableName=core_user		\N	3.5.3	\N	\N	0441238708
17	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	16	EXECUTED	7:5401ec35a5bd1275f93a7cac1ddd7591	addColumn tableName=metabase_database; sql		\N	3.5.3	\N	\N	0441238708
11	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	10	EXECUTED	7:c7ef8b4f4dcb3528f9282b51aea5bb2a	sql		\N	3.5.3	\N	\N	0441238708
18	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	17	EXECUTED	7:329d897d44ba9893fdafc9ce7e876d73	createTable tableName=data_migrations; createIndex indexName=idx_data_migrations_id, tableName=data_migrations		\N	3.5.3	\N	\N	0441238708
19	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	18	EXECUTED	7:e8fa976811e4d58d42a45804affa1d07	addColumn tableName=metabase_table		\N	3.5.3	\N	\N	0441238708
20	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	19	EXECUTED	7:9c5fedbd888307edf521a6a547f96f99	createTable tableName=pulse; createIndex indexName=idx_pulse_creator_id, tableName=pulse; createTable tableName=pulse_card; createIndex indexName=idx_pulse_card_pulse_id, tableName=pulse_card; createIndex indexName=idx_pulse_card_card_id, tableNam...		\N	3.5.3	\N	\N	0441238708
21	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	20	EXECUTED	7:c23c71d8a11b3f38aaf5bf98acf51e6f	createTable tableName=segment; createIndex indexName=idx_segment_creator_id, tableName=segment; createIndex indexName=idx_segment_table_id, tableName=segment		\N	3.5.3	\N	\N	0441238708
22	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	21	EXECUTED	7:cb6776ec86ab0ad9e74806a5460b9085	addColumn tableName=revision		\N	3.5.3	\N	\N	0441238708
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
1	2017-11-11 23:01:35.379+00	2017-11-20 22:55:02.44+00	Sample Dataset	\N	{"db":"zip:/app/metabase.jar!/sample-dataset.db;USER=GUEST;PASSWORD=guest"}	h2	t	t	\N	\N	0 50 * * * ? *	0 50 0 * * ? *	UTC	f
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
129	2017-11-12 21:38:38.72+00	2017-11-14 13:50:01.18+00	02	type/Integer	\N	t	\N	t	0	5	118	02	normal	\N	\N	\N	\N	\N	\N	0
17	2017-11-11 23:01:36.688+00	2017-11-11 23:01:40.973+00	STATE	type/Text	type/State	t	The state or province of the account’s billing address	t	0	3	\N	State	normal	\N	\N	2017-11-11 23:01:41.036+00	\N	\N	{"global":{"distinct-count":62},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":2.0}}}	1
16	2017-11-11 23:01:36.67+00	2017-11-11 23:01:40.397+00	PASSWORD	type/Text	\N	t	This is the salted password of the user. It should not be visible	t	0	3	\N	Password	normal	\N	\N	2017-11-11 23:01:41.036+00	\N	\N	{"global":{"distinct-count":2500},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}	1
15	2017-11-11 23:01:36.656+00	2017-11-11 23:01:40.993+00	NAME	type/Text	type/Name	t	The name of the user who owns an account	t	0	3	\N	Name	normal	\N	\N	2017-11-11 23:01:41.036+00	\N	\N	{"global":{"distinct-count":2498},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":13.5328}}}	1
14	2017-11-11 23:01:36.636+00	2017-11-11 23:01:40.507+00	ID	type/BigInteger	type/PK	t	A unique identifier given to each user.	t	0	3	\N	ID	normal	\N	\N	2017-11-11 23:01:41.036+00	\N	\N	{"global":{"distinct-count":2500},"type":{"type/Number":{"min":1,"max":2500,"avg":1250.5}}}	1
13	2017-11-11 23:01:36.618+00	2017-11-11 23:01:41.005+00	EMAIL	type/Text	type/Email	t	The contact email for the account.	t	0	3	\N	Email	normal	\N	\N	2017-11-11 23:01:41.036+00	\N	\N	{"global":{"distinct-count":2500},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":1.0,"average-length":24.2184}}}	1
12	2017-11-11 23:01:36.587+00	2017-11-11 23:01:40.693+00	ZIP	type/Text	type/ZipCode	t	The postal code of the account’s billing address	t	0	3	\N	Zip	normal	\N	\N	2017-11-11 23:01:41.036+00	\N	\N	{"global":{"distinct-count":2469},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.0}}}	1
11	2017-11-11 23:01:36.554+00	2017-11-11 23:01:40.753+00	ADDRESS	type/Text	\N	t	The street address of the account’s billing address	t	0	3	\N	Address	normal	\N	\N	2017-11-11 23:01:41.036+00	\N	\N	{"global":{"distinct-count":2500},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":17.996}}}	1
9	2017-11-11 23:01:36.497+00	2017-11-11 23:01:41.029+00	SOURCE	type/Text	type/Category	t	The channel through which we acquired this user. Valid values include: Affiliate, Facebook, Google, Organic and Twitter	t	0	3	\N	Source	normal	\N	\N	2017-11-11 23:01:41.036+00	\N	\N	{"global":{"distinct-count":5},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.3856}}}	1
8	2017-11-11 23:01:36.471+00	2017-11-11 23:01:40.851+00	BIRTH_DATE	type/Date	\N	t	The date of birth of the user	t	0	3	\N	Birth Date	normal	\N	\N	2017-11-11 23:01:41.036+00	\N	\N	{"global":{"distinct-count":2300}}	1
271	2017-11-12 21:38:44.707+00	2017-11-12 22:54:47.753+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	6	\N	ID	normal	\N	\N	2017-11-12 21:38:58.302+00	\N	\N	{"global":{"distinct-count":10000}}	1
70	2017-11-12 21:38:37.865+00	2017-11-14 13:50:01.838+00	2016	type/Dictionary	\N	t	\N	t	0	5	36	2016	normal	\N	\N	2017-11-13 23:50:17.492+00	\N	\N	{"global":{"distinct-count":2}}	1
71	2017-11-12 21:38:37.875+00	2017-11-14 13:50:01.861+00	09	type/Integer	\N	t	\N	t	0	5	70	09	normal	\N	\N	\N	\N	\N	\N	0
72	2017-11-12 21:38:37.887+00	2017-11-14 13:50:01.878+00	06	type/Integer	\N	t	\N	t	0	5	70	06	normal	\N	\N	\N	\N	\N	\N	0
73	2017-11-12 21:38:37.898+00	2017-11-14 13:50:01.889+00	03	type/Integer	\N	t	\N	t	0	5	70	03	normal	\N	\N	\N	\N	\N	\N	0
74	2017-11-12 21:38:37.908+00	2017-11-14 13:50:01.911+00	11	type/Integer	\N	t	\N	t	0	5	70	11	normal	\N	\N	\N	\N	\N	\N	0
77	2017-11-12 21:38:37.964+00	2017-11-14 13:50:01.922+00	07	type/Integer	\N	t	\N	t	0	5	70	07	normal	\N	\N	\N	\N	\N	\N	0
78	2017-11-12 21:38:37.975+00	2017-11-14 13:50:01.933+00	10	type/Integer	\N	t	\N	t	0	5	70	10	normal	\N	\N	\N	\N	\N	\N	0
79	2017-11-12 21:38:37.985+00	2017-11-14 13:50:01.944+00	12	type/Integer	\N	t	\N	t	0	5	70	12	normal	\N	\N	\N	\N	\N	\N	0
80	2017-11-12 21:38:37.997+00	2017-11-14 13:50:01.955+00	04	type/Integer	\N	t	\N	t	0	5	70	04	normal	\N	\N	\N	\N	\N	\N	0
81	2017-11-12 21:38:38.009+00	2017-11-14 13:50:01.967+00	01	type/Integer	\N	t	\N	t	0	5	70	01	normal	\N	\N	\N	\N	\N	\N	0
82	2017-11-12 21:38:38.052+00	2017-11-14 13:50:01.977+00	02	type/Integer	\N	t	\N	t	0	5	70	02	normal	\N	\N	\N	\N	\N	\N	0
52	2017-11-12 21:38:37.577+00	2017-11-14 13:50:02.026+00	06	type/Integer	\N	t	\N	t	0	5	50	06	normal	\N	\N	\N	\N	\N	\N	0
53	2017-11-12 21:38:37.594+00	2017-11-14 13:50:02.044+00	03	type/Integer	\N	t	\N	t	0	5	50	03	normal	\N	\N	\N	\N	\N	\N	0
54	2017-11-12 21:38:37.613+00	2017-11-14 13:50:02.055+00	11	type/Integer	\N	t	\N	t	0	5	50	11	normal	\N	\N	\N	\N	\N	\N	0
56	2017-11-12 21:38:37.655+00	2017-11-14 13:50:02.067+00	08	type/Integer	\N	t	\N	t	0	5	50	08	normal	\N	\N	\N	\N	\N	\N	0
57	2017-11-12 21:38:37.668+00	2017-11-14 13:50:02.077+00	07	type/Integer	\N	t	\N	t	0	5	50	07	normal	\N	\N	\N	\N	\N	\N	0
58	2017-11-12 21:38:37.687+00	2017-11-14 13:50:02.088+00	10	type/Integer	\N	t	\N	t	0	5	50	10	normal	\N	\N	\N	\N	\N	\N	0
59	2017-11-12 21:38:37.698+00	2017-11-14 13:50:02.099+00	04	type/Integer	\N	t	\N	t	0	5	50	04	normal	\N	\N	\N	\N	\N	\N	0
64	2017-11-12 21:38:37.77+00	2017-11-14 13:50:02.167+00	11	type/Integer	\N	t	\N	t	0	5	62	11	normal	\N	\N	\N	\N	\N	\N	0
65	2017-11-12 21:38:37.801+00	2017-11-14 13:50:02.188+00	08	type/Integer	\N	t	\N	t	0	5	62	08	normal	\N	\N	\N	\N	\N	\N	0
66	2017-11-12 21:38:37.82+00	2017-11-14 13:50:02.199+00	07	type/Integer	\N	t	\N	t	0	5	62	07	normal	\N	\N	\N	\N	\N	\N	0
67	2017-11-12 21:38:37.832+00	2017-11-14 13:50:02.21+00	10	type/Integer	\N	t	\N	t	0	5	62	10	normal	\N	\N	\N	\N	\N	\N	0
68	2017-11-12 21:38:37.842+00	2017-11-14 13:50:02.222+00	12	type/Integer	\N	t	\N	t	0	5	62	12	normal	\N	\N	\N	\N	\N	\N	0
63	2017-11-12 21:38:37.753+00	2017-11-14 13:50:02.232+00	09	type/Integer	\N	t	\N	t	0	5	62	09	normal	\N	\N	\N	\N	\N	\N	0
38	2017-11-12 21:38:37.333+00	2017-11-14 13:50:02.27+00	09	type/Integer	\N	t	\N	t	0	5	37	09	normal	\N	\N	\N	\N	\N	\N	0
39	2017-11-12 21:38:37.344+00	2017-11-14 13:50:02.288+00	06	type/Integer	\N	t	\N	t	0	5	37	06	normal	\N	\N	\N	\N	\N	\N	0
40	2017-11-12 21:38:37.354+00	2017-11-14 13:50:02.299+00	03	type/Integer	\N	t	\N	t	0	5	37	03	normal	\N	\N	\N	\N	\N	\N	0
41	2017-11-12 21:38:37.378+00	2017-11-14 13:50:02.31+00	11	type/Integer	\N	t	\N	t	0	5	37	11	normal	\N	\N	\N	\N	\N	\N	0
43	2017-11-12 21:38:37.435+00	2017-11-14 13:50:02.321+00	08	type/Integer	\N	t	\N	t	0	5	37	08	normal	\N	\N	\N	\N	\N	\N	0
44	2017-11-12 21:38:37.456+00	2017-11-14 13:50:02.332+00	07	type/Integer	\N	t	\N	t	0	5	37	07	normal	\N	\N	\N	\N	\N	\N	0
45	2017-11-12 21:38:37.467+00	2017-11-14 13:50:02.343+00	10	type/Integer	\N	t	\N	t	0	5	37	10	normal	\N	\N	\N	\N	\N	\N	0
47	2017-11-12 21:38:37.5+00	2017-11-14 13:50:02.365+00	04	type/Integer	\N	t	\N	t	0	5	37	04	normal	\N	\N	\N	\N	\N	\N	0
48	2017-11-12 21:38:37.51+00	2017-11-14 13:50:02.376+00	01	type/Integer	\N	t	\N	t	0	5	37	01	normal	\N	\N	\N	\N	\N	\N	0
49	2017-11-12 21:38:37.521+00	2017-11-14 13:50:02.387+00	02	type/Integer	\N	t	\N	t	0	5	37	02	normal	\N	\N	\N	\N	\N	\N	0
115	2017-11-12 21:38:38.507+00	2017-11-14 13:50:02.426+00	2014	type/Dictionary	\N	t	\N	t	0	5	83	2014	normal	\N	\N	\N	\N	\N	\N	0
116	2017-11-12 21:38:38.517+00	2017-11-14 13:50:02.447+00	10	type/Integer	\N	t	\N	t	0	5	115	10	normal	\N	\N	\N	\N	\N	\N	0
84	2017-11-12 21:38:38.075+00	2017-11-14 13:50:02.454+00	2015	type/Dictionary	\N	t	\N	t	0	5	83	2015	normal	\N	\N	\N	\N	\N	\N	0
88	2017-11-12 21:38:38.119+00	2017-11-14 13:50:02.469+00	10	type/Integer	\N	t	\N	t	0	5	84	10	normal	\N	\N	\N	\N	\N	\N	0
267	2017-11-12 21:38:40.51+00	2017-11-14 13:50:03.616+00	Exposição	type/Integer	\N	t	\N	t	0	5	242	Exposição	normal	\N	\N	\N	\N	\N	\N	0
260	2017-11-12 21:38:40.432+00	2017-11-14 13:50:03.638+00	Edital	type/Integer	\N	t	\N	t	0	5	242	Edit Al	normal	\N	\N	\N	\N	\N	\N	0
247	2017-11-12 21:38:40.225+00	2017-11-14 13:50:03.65+00	Conferência Pública Municipal	type/Integer	\N	t	\N	t	0	5	242	Conferência Pública Municipal	normal	\N	\N	\N	\N	\N	\N	0
124	2017-11-12 21:38:38.638+00	2017-11-14 13:50:01.125+00	08	type/Integer	\N	t	\N	t	0	5	118	08	normal	\N	\N	\N	\N	\N	\N	0
125	2017-11-12 21:38:38.653+00	2017-11-14 13:50:01.135+00	07	type/Integer	\N	t	\N	t	0	5	118	07	normal	\N	\N	\N	\N	\N	\N	0
127	2017-11-12 21:38:38.683+00	2017-11-14 13:50:01.157+00	04	type/Integer	\N	t	\N	t	0	5	118	04	normal	\N	\N	\N	\N	\N	\N	0
128	2017-11-12 21:38:38.704+00	2017-11-14 13:50:01.169+00	01	type/Integer	\N	t	\N	t	0	5	118	01	normal	\N	\N	\N	\N	\N	\N	0
121	2017-11-12 21:38:38.599+00	2017-11-14 13:50:01.191+00	03	type/Integer	\N	t	\N	t	0	5	118	03	normal	\N	\N	\N	\N	\N	\N	0
123	2017-11-12 21:38:38.628+00	2017-11-14 13:50:01.202+00	05	type/Integer	\N	t	\N	t	0	5	118	05	normal	\N	\N	\N	\N	\N	\N	0
119	2017-11-12 21:38:38.552+00	2017-11-14 13:50:01.213+00	09	type/Integer	\N	t	\N	t	0	5	118	09	normal	\N	\N	\N	\N	\N	\N	0
130	2017-11-12 21:38:38.739+00	2017-11-14 13:50:01.246+00	2014	type/Dictionary	\N	t	\N	t	0	5	117	2014	normal	\N	\N	\N	\N	\N	\N	0
132	2017-11-12 21:38:38.761+00	2017-11-14 13:50:01.258+00	06	type/Integer	\N	t	\N	t	0	5	130	06	normal	\N	\N	\N	\N	\N	\N	0
133	2017-11-12 21:38:38.773+00	2017-11-14 13:50:01.269+00	03	type/Integer	\N	t	\N	t	0	5	130	03	normal	\N	\N	\N	\N	\N	\N	0
134	2017-11-12 21:38:38.782+00	2017-11-14 13:50:01.28+00	11	type/Integer	\N	t	\N	t	0	5	130	11	normal	\N	\N	\N	\N	\N	\N	0
135	2017-11-12 21:38:38.794+00	2017-11-14 13:50:01.291+00	05	type/Integer	\N	t	\N	t	0	5	130	05	normal	\N	\N	\N	\N	\N	\N	0
136	2017-11-12 21:38:38.805+00	2017-11-14 13:50:01.302+00	08	type/Integer	\N	t	\N	t	0	5	130	08	normal	\N	\N	\N	\N	\N	\N	0
137	2017-11-12 21:38:38.83+00	2017-11-14 13:50:01.313+00	07	type/Integer	\N	t	\N	t	0	5	130	07	normal	\N	\N	\N	\N	\N	\N	0
138	2017-11-12 21:38:38.839+00	2017-11-14 13:50:01.325+00	10	type/Integer	\N	t	\N	t	0	5	130	10	normal	\N	\N	\N	\N	\N	\N	0
139	2017-11-12 21:38:38.851+00	2017-11-14 13:50:01.335+00	12	type/Integer	\N	t	\N	t	0	5	130	12	normal	\N	\N	\N	\N	\N	\N	0
140	2017-11-12 21:38:38.86+00	2017-11-14 13:50:01.346+00	04	type/Integer	\N	t	\N	t	0	5	130	04	normal	\N	\N	\N	\N	\N	\N	0
176	2017-11-12 21:38:39.341+00	2017-11-14 13:50:01.559+00	02	type/Integer	\N	t	\N	t	0	5	164	02	normal	\N	\N	\N	\N	\N	\N	0
69	2017-11-12 21:38:37.853+00	2017-11-14 13:50:02.243+00	04	type/Integer	\N	t	\N	t	0	5	62	04	normal	\N	\N	\N	\N	\N	\N	0
103	2017-11-12 21:38:38.31+00	2017-11-14 13:50:02.542+00	2016	type/Dictionary	\N	t	\N	t	0	5	83	2016	normal	\N	\N	\N	\N	\N	\N	0
110	2017-11-12 21:38:38.42+00	2017-11-14 13:50:02.558+00	07	type/Integer	\N	t	\N	t	0	5	103	07	normal	\N	\N	\N	\N	\N	\N	0
111	2017-11-12 21:38:38.441+00	2017-11-14 13:50:02.575+00	10	type/Integer	\N	t	\N	t	0	5	103	10	normal	\N	\N	\N	\N	\N	\N	0
112	2017-11-12 21:38:38.452+00	2017-11-14 13:50:02.586+00	12	type/Integer	\N	t	\N	t	0	5	103	12	normal	\N	\N	\N	\N	\N	\N	0
113	2017-11-12 21:38:38.463+00	2017-11-14 13:50:02.598+00	04	type/Integer	\N	t	\N	t	0	5	103	04	normal	\N	\N	\N	\N	\N	\N	0
114	2017-11-12 21:38:38.486+00	2017-11-14 13:50:02.609+00	02	type/Integer	\N	t	\N	t	0	5	103	02	normal	\N	\N	\N	\N	\N	\N	0
104	2017-11-12 21:38:38.344+00	2017-11-14 13:50:02.62+00	09	type/Integer	\N	t	\N	t	0	5	103	09	normal	\N	\N	\N	\N	\N	\N	0
105	2017-11-12 21:38:38.363+00	2017-11-14 13:50:02.631+00	06	type/Integer	\N	t	\N	t	0	5	103	06	normal	\N	\N	\N	\N	\N	\N	0
108	2017-11-12 21:38:38.396+00	2017-11-14 13:50:02.653+00	05	type/Integer	\N	t	\N	t	0	5	103	05	normal	\N	\N	\N	\N	\N	\N	0
109	2017-11-12 21:38:38.407+00	2017-11-14 13:50:02.664+00	08	type/Integer	\N	t	\N	t	0	5	103	08	normal	\N	\N	\N	\N	\N	\N	0
93	2017-11-12 21:38:38.174+00	2017-11-14 13:50:02.701+00	06	type/Integer	\N	t	\N	t	0	5	91	06	normal	\N	\N	\N	\N	\N	\N	0
102	2017-11-12 21:38:38.288+00	2017-11-14 13:50:02.72+00	02	type/Integer	\N	t	\N	t	0	5	91	02	normal	\N	\N	\N	\N	\N	\N	0
193	2017-11-12 21:38:39.562+00	2017-11-14 13:50:02.999+00	Festa Popular	type/Integer	\N	t	\N	t	0	5	192	Festa Popular	normal	\N	\N	\N	\N	\N	\N	0
199	2017-11-12 21:38:39.634+00	2017-11-14 13:50:03.007+00	Exibição	type/Integer	\N	t	\N	t	0	5	192	Exibição	normal	\N	\N	\N	\N	\N	\N	0
200	2017-11-12 21:38:39.646+00	2017-11-14 13:50:03.019+00	Ciclo	type/Integer	\N	t	\N	t	0	5	192	Ci Clo	normal	\N	\N	\N	\N	\N	\N	0
201	2017-11-12 21:38:39.67+00	2017-11-14 13:50:03.03+00	Reunião	type/Integer	\N	t	\N	t	0	5	192	Reunião	normal	\N	\N	\N	\N	\N	\N	0
202	2017-11-12 21:38:39.679+00	2017-11-14 13:50:03.041+00	Festival	type/Integer	\N	t	\N	t	0	5	192	Festival	normal	\N	\N	\N	\N	\N	\N	0
203	2017-11-12 21:38:39.69+00	2017-11-14 13:50:03.052+00	Feira	type/Integer	\N	t	\N	t	0	5	192	Feira	normal	\N	\N	\N	\N	\N	\N	0
204	2017-11-12 21:38:39.701+00	2017-11-14 13:50:03.063+00	Jornada	type/Integer	\N	t	\N	t	0	5	192	Jorn Ada	normal	\N	\N	\N	\N	\N	\N	0
206	2017-11-12 21:38:39.726+00	2017-11-14 13:50:03.085+00	Seminário	type/Integer	\N	t	\N	t	0	5	192	Seminário	normal	\N	\N	\N	\N	\N	\N	0
207	2017-11-12 21:38:39.735+00	2017-11-14 13:50:03.097+00	Oficina	type/Integer	\N	t	\N	t	0	5	192	Oficina	normal	\N	\N	\N	\N	\N	\N	0
208	2017-11-12 21:38:39.746+00	2017-11-14 13:50:03.107+00	Edital	type/Integer	\N	t	\N	t	0	5	192	Edit Al	normal	\N	\N	\N	\N	\N	\N	0
209	2017-11-12 21:38:39.757+00	2017-11-14 13:50:03.118+00	Encontro	type/Integer	\N	t	\N	t	0	5	192	Enc On Tro	normal	\N	\N	\N	\N	\N	\N	0
197	2017-11-12 21:38:39.613+00	2017-11-14 13:50:03.129+00	Curso	type/Integer	\N	t	\N	t	0	5	192	Cur So	normal	\N	\N	\N	\N	\N	\N	0
198	2017-11-12 21:38:39.624+00	2017-11-14 13:50:03.14+00	Inscrições	type/Integer	\N	t	\N	t	0	5	192	Inscrições	normal	\N	\N	\N	\N	\N	\N	0
212	2017-11-12 21:38:39.79+00	2017-11-14 13:50:03.151+00	Programa	type/Integer	\N	t	\N	t	0	5	192	Program A	normal	\N	\N	\N	\N	\N	\N	0
227	2017-11-12 21:38:39.97+00	2017-11-14 13:50:03.311+00	Festival	type/Integer	\N	t	\N	t	0	5	217	Festival	normal	\N	\N	\N	\N	\N	\N	0
249	2017-11-12 21:38:40.245+00	2017-11-14 13:50:03.661+00	Curso	type/Integer	\N	t	\N	t	0	5	242	Cur So	normal	\N	\N	\N	\N	\N	\N	0
250	2017-11-12 21:38:40.255+00	2017-11-14 13:50:03.672+00	Inscrições	type/Integer	\N	t	\N	t	0	5	242	Inscrições	normal	\N	\N	\N	\N	\N	\N	0
252	2017-11-12 21:38:40.288+00	2017-11-14 13:50:03.694+00	Exibição	type/Integer	\N	t	\N	t	0	5	242	Exibição	normal	\N	\N	\N	\N	\N	\N	0
255	2017-11-12 21:38:40.321+00	2017-11-14 13:50:03.705+00	Feira	type/Integer	\N	t	\N	t	0	5	242	Feira	normal	\N	\N	\N	\N	\N	\N	0
259	2017-11-12 21:38:40.421+00	2017-11-14 13:50:03.716+00	Oficina	type/Integer	\N	t	\N	t	0	5	242	Oficina	normal	\N	\N	\N	\N	\N	\N	0
264	2017-11-12 21:38:40.477+00	2017-11-14 13:50:03.728+00	Programa	type/Integer	\N	t	\N	t	0	5	242	Program A	normal	\N	\N	\N	\N	\N	\N	0
256	2017-11-12 21:38:40.367+00	2017-11-14 13:50:03.738+00	Jornada	type/Integer	\N	t	\N	t	0	5	242	Jorn Ada	normal	\N	\N	\N	\N	\N	\N	0
243	2017-11-12 21:38:40.156+00	2017-11-14 13:50:03.749+00	Festa Religiosa	type/Integer	\N	t	\N	t	0	5	242	Festa Religiosa	normal	\N	\N	\N	\N	\N	\N	0
142	2017-11-12 21:38:38.888+00	2017-11-14 13:50:01.368+00	02	type/Integer	\N	t	\N	t	0	5	130	02	normal	\N	\N	\N	\N	\N	\N	0
152	2017-11-12 21:38:39.004+00	2017-11-14 13:50:01.391+00	2017	type/Dictionary	\N	t	\N	t	0	5	117	2017	normal	\N	\N	\N	\N	\N	\N	0
153	2017-11-12 21:38:39.015+00	2017-11-14 13:50:01.406+00	09	type/Integer	\N	t	\N	t	0	5	152	09	normal	\N	\N	\N	\N	\N	\N	0
154	2017-11-12 21:38:39.026+00	2017-11-14 13:50:01.424+00	06	type/Integer	\N	t	\N	t	0	5	152	06	normal	\N	\N	\N	\N	\N	\N	0
155	2017-11-12 21:38:39.037+00	2017-11-14 13:50:01.435+00	03	type/Integer	\N	t	\N	t	0	5	152	03	normal	\N	\N	\N	\N	\N	\N	0
156	2017-11-12 21:38:39.053+00	2017-11-14 13:50:01.446+00	11	type/Integer	\N	t	\N	t	0	5	152	11	normal	\N	\N	\N	\N	\N	\N	0
157	2017-11-12 21:38:39.071+00	2017-11-14 13:50:01.457+00	05	type/Integer	\N	t	\N	t	0	5	152	05	normal	\N	\N	\N	\N	\N	\N	0
158	2017-11-12 21:38:39.081+00	2017-11-14 13:50:01.468+00	08	type/Integer	\N	t	\N	t	0	5	152	08	normal	\N	\N	\N	\N	\N	\N	0
159	2017-11-12 21:38:39.094+00	2017-11-14 13:50:01.48+00	07	type/Integer	\N	t	\N	t	0	5	152	07	normal	\N	\N	\N	\N	\N	\N	0
160	2017-11-12 21:38:39.116+00	2017-11-14 13:50:01.491+00	10	type/Integer	\N	t	\N	t	0	5	152	10	normal	\N	\N	\N	\N	\N	\N	0
162	2017-11-12 21:38:39.138+00	2017-11-14 13:50:01.503+00	01	type/Integer	\N	t	\N	t	0	5	152	01	normal	\N	\N	\N	\N	\N	\N	0
163	2017-11-12 21:38:39.149+00	2017-11-14 13:50:01.523+00	02	type/Integer	\N	t	\N	t	0	5	152	02	normal	\N	\N	\N	\N	\N	\N	0
165	2017-11-12 21:38:39.17+00	2017-11-14 13:50:01.567+00	09	type/Integer	\N	t	\N	t	0	5	164	09	normal	\N	\N	\N	\N	\N	\N	0
166	2017-11-12 21:38:39.188+00	2017-11-14 13:50:01.579+00	06	type/Integer	\N	t	\N	t	0	5	164	06	normal	\N	\N	\N	\N	\N	\N	0
279	2017-11-12 21:38:44.872+00	2017-11-20 23:50:01.421+00	11	type/Integer	\N	t	\N	t	0	7	275	11	normal	\N	\N	\N	\N	\N	\N	0
167	2017-11-12 21:38:39.21+00	2017-11-14 13:50:01.589+00	03	type/Integer	\N	t	\N	t	0	5	164	03	normal	\N	\N	\N	\N	\N	\N	0
286	2017-11-12 21:38:44.95+00	2017-11-20 23:50:01.431+00	01	type/Integer	\N	t	\N	t	0	7	275	01	normal	\N	\N	\N	\N	\N	\N	0
282	2017-11-12 21:38:44.906+00	2017-11-20 23:50:01.413+00	07	type/Integer	\N	t	\N	t	0	7	275	07	normal	\N	\N	\N	\N	\N	\N	0
281	2017-11-12 21:38:44.895+00	2017-11-20 23:50:01.416+00	08	type/Integer	\N	t	\N	t	0	7	275	08	normal	\N	\N	\N	\N	\N	\N	0
278	2017-11-12 21:38:44.862+00	2017-11-20 23:50:01.423+00	03	type/Integer	\N	t	\N	t	0	7	275	03	normal	\N	\N	\N	\N	\N	\N	0
277	2017-11-12 21:38:44.85+00	2017-11-20 23:50:01.426+00	06	type/Integer	\N	t	\N	t	0	7	275	06	normal	\N	\N	\N	\N	\N	\N	0
276	2017-11-12 21:38:44.839+00	2017-11-20 23:50:01.429+00	09	type/Integer	\N	t	\N	t	0	7	275	09	normal	\N	\N	\N	\N	\N	\N	0
280	2017-11-12 21:38:44.883+00	2017-11-20 23:50:01.418+00	05	type/Integer	\N	t	\N	t	0	7	275	05	normal	\N	\N	\N	\N	\N	\N	0
169	2017-11-12 21:38:39.251+00	2017-11-14 13:50:01.6+00	05	type/Integer	\N	t	\N	t	0	5	164	05	normal	\N	\N	\N	\N	\N	\N	0
171	2017-11-12 21:38:39.281+00	2017-11-14 13:50:01.612+00	07	type/Integer	\N	t	\N	t	0	5	164	07	normal	\N	\N	\N	\N	\N	\N	0
172	2017-11-12 21:38:39.292+00	2017-11-14 13:50:01.623+00	10	type/Integer	\N	t	\N	t	0	5	164	10	normal	\N	\N	\N	\N	\N	\N	0
173	2017-11-12 21:38:39.304+00	2017-11-14 13:50:01.634+00	12	type/Integer	\N	t	\N	t	0	5	164	12	normal	\N	\N	\N	\N	\N	\N	0
175	2017-11-12 21:38:39.325+00	2017-11-14 13:50:01.645+00	01	type/Integer	\N	t	\N	t	0	5	164	01	normal	\N	\N	\N	\N	\N	\N	0
146	2017-11-12 21:38:38.938+00	2017-11-14 13:50:01.734+00	11	type/Integer	\N	t	\N	t	0	5	143	11	normal	\N	\N	\N	\N	\N	\N	0
147	2017-11-12 21:38:38.949+00	2017-11-14 13:50:01.745+00	05	type/Integer	\N	t	\N	t	0	5	143	05	normal	\N	\N	\N	\N	\N	\N	0
148	2017-11-12 21:38:38.96+00	2017-11-14 13:50:01.756+00	08	type/Integer	\N	t	\N	t	0	5	143	08	normal	\N	\N	\N	\N	\N	\N	0
150	2017-11-12 21:38:38.983+00	2017-11-14 13:50:01.767+00	10	type/Integer	\N	t	\N	t	0	5	143	10	normal	\N	\N	\N	\N	\N	\N	0
151	2017-11-12 21:38:38.995+00	2017-11-14 13:50:01.778+00	12	type/Integer	\N	t	\N	t	0	5	143	12	normal	\N	\N	\N	\N	\N	\N	0
149	2017-11-12 21:38:38.972+00	2017-11-14 13:50:01.79+00	07	type/Integer	\N	t	\N	t	0	5	143	07	normal	\N	\N	\N	\N	\N	\N	0
188	2017-11-12 21:38:39.493+00	2017-11-14 13:50:02.845+00	mapaculturacegovbr	type/Dictionary	\N	t	\N	t	0	5	181	Map A Cultura Ce Gov Br	normal	\N	\N	\N	\N	\N	\N	0
189	2017-11-12 21:38:39.504+00	2017-11-14 13:50:02.856+00	True	type/Integer	\N	t	\N	t	0	5	188	True	normal	\N	\N	\N	\N	\N	\N	0
190	2017-11-12 21:38:39.515+00	2017-11-14 13:50:02.863+00	False	type/Integer	\N	t	\N	t	0	5	188	False	normal	\N	\N	\N	\N	\N	\N	0
182	2017-11-12 21:38:39.427+00	2017-11-14 13:50:02.874+00	mapasculturagovbr	type/Dictionary	\N	t	\N	t	0	5	181	Map As Cultura Gov Br	normal	\N	\N	\N	\N	\N	\N	0
183	2017-11-12 21:38:39.438+00	2017-11-14 13:50:02.89+00	True	type/Integer	\N	t	\N	t	0	5	182	True	normal	\N	\N	\N	\N	\N	\N	0
184	2017-11-12 21:38:39.448+00	2017-11-14 13:50:02.908+00	False	type/Integer	\N	t	\N	t	0	5	182	False	normal	\N	\N	\N	\N	\N	\N	0
186	2017-11-12 21:38:39.47+00	2017-11-14 13:50:02.933+00	True	type/Integer	\N	t	\N	t	0	5	185	True	normal	\N	\N	\N	\N	\N	\N	0
187	2017-11-12 21:38:39.481+00	2017-11-14 13:50:02.941+00	False	type/Integer	\N	t	\N	t	0	5	185	False	normal	\N	\N	\N	\N	\N	\N	0
213	2017-11-12 21:38:39.801+00	2017-11-14 13:50:03.162+00	Fórum	type/Integer	\N	t	\N	t	0	5	192	Fórum	normal	\N	\N	\N	\N	\N	\N	0
214	2017-11-12 21:38:39.812+00	2017-11-14 13:50:03.189+00	Sarau	type/Integer	\N	t	\N	t	0	5	192	Sara U	normal	\N	\N	\N	\N	\N	\N	0
195	2017-11-12 21:38:39.591+00	2017-11-14 13:50:03.217+00	Palestra	type/Integer	\N	t	\N	t	0	5	192	Palestra	normal	\N	\N	\N	\N	\N	\N	0
211	2017-11-12 21:38:39.78+00	2017-11-14 13:50:03.24+00	Concurso	type/Integer	\N	t	\N	t	0	5	192	Concur So	normal	\N	\N	\N	\N	\N	\N	0
232	2017-11-12 21:38:40.023+00	2017-11-14 13:50:03.328+00	Oficina	type/Integer	\N	t	\N	t	0	5	217	Oficina	normal	\N	\N	\N	\N	\N	\N	0
233	2017-11-12 21:38:40.035+00	2017-11-14 13:50:03.339+00	Edital	type/Integer	\N	t	\N	t	0	5	217	Edit Al	normal	\N	\N	\N	\N	\N	\N	0
235	2017-11-12 21:38:40.056+00	2017-11-14 13:50:03.351+00	Encontro	type/Integer	\N	t	\N	t	0	5	217	Enc On Tro	normal	\N	\N	\N	\N	\N	\N	0
237	2017-11-12 21:38:40.078+00	2017-11-14 13:50:03.362+00	Programa	type/Integer	\N	t	\N	t	0	5	217	Program A	normal	\N	\N	\N	\N	\N	\N	0
238	2017-11-12 21:38:40.089+00	2017-11-14 13:50:03.373+00	Fórum	type/Integer	\N	t	\N	t	0	5	217	Fórum	normal	\N	\N	\N	\N	\N	\N	0
239	2017-11-12 21:38:40.101+00	2017-11-14 13:50:03.385+00	Sarau	type/Integer	\N	t	\N	t	0	5	217	Sara U	normal	\N	\N	\N	\N	\N	\N	0
240	2017-11-12 21:38:40.124+00	2017-11-14 13:50:03.394+00	Exposição	type/Integer	\N	t	\N	t	0	5	217	Exposição	normal	\N	\N	\N	\N	\N	\N	0
241	2017-11-12 21:38:40.133+00	2017-11-14 13:50:03.405+00	Mostra	type/Integer	\N	t	\N	t	0	5	217	Most Ra	normal	\N	\N	\N	\N	\N	\N	0
236	2017-11-12 21:38:40.067+00	2017-11-14 13:50:03.416+00	Concurso	type/Integer	\N	t	\N	t	0	5	217	Concur So	normal	\N	\N	\N	\N	\N	\N	0
218	2017-11-12 21:38:39.858+00	2017-11-14 13:50:03.428+00	Festa Religiosa	type/Integer	\N	t	\N	t	0	5	217	Festa Religiosa	normal	\N	\N	\N	\N	\N	\N	0
219	2017-11-12 21:38:39.868+00	2017-11-14 13:50:03.439+00	Festa Popular	type/Integer	\N	t	\N	t	0	5	217	Festa Popular	normal	\N	\N	\N	\N	\N	\N	0
222	2017-11-12 21:38:39.901+00	2017-11-14 13:50:03.45+00	Palestra	type/Integer	\N	t	\N	t	0	5	217	Palestra	normal	\N	\N	\N	\N	\N	\N	0
223	2017-11-12 21:38:39.912+00	2017-11-14 13:50:03.461+00	Curso	type/Integer	\N	t	\N	t	0	5	217	Cur So	normal	\N	\N	\N	\N	\N	\N	0
224	2017-11-12 21:38:39.923+00	2017-11-14 13:50:03.472+00	Inscrições	type/Integer	\N	t	\N	t	0	5	217	Inscrições	normal	\N	\N	\N	\N	\N	\N	0
225	2017-11-12 21:38:39.935+00	2017-11-14 13:50:03.483+00	Exibição	type/Integer	\N	t	\N	t	0	5	217	Exibição	normal	\N	\N	\N	\N	\N	\N	0
226	2017-11-12 21:38:39.956+00	2017-11-14 13:50:03.494+00	Ciclo	type/Integer	\N	t	\N	t	0	5	217	Ci Clo	normal	\N	\N	\N	\N	\N	\N	0
228	2017-11-12 21:38:39.979+00	2017-11-14 13:50:03.506+00	Feira	type/Integer	\N	t	\N	t	0	5	217	Feira	normal	\N	\N	\N	\N	\N	\N	0
230	2017-11-12 21:38:40.001+00	2017-11-14 13:50:03.516+00	Intercâmbio Cultural	type/Integer	\N	t	\N	t	0	5	217	Intercâmbio Cultural	normal	\N	\N	\N	\N	\N	\N	0
495	2017-11-12 22:49:23.957+00	2017-11-12 22:54:47.742+00	_date	type/DateTime	\N	t	\N	t	0	6	\N	Date	normal	\N	\N	2017-11-12 22:50:11.107+00	\N	\N	{"global":{"distinct-count":327}}	1
272	2017-11-12 21:38:44.719+00	2017-11-12 22:54:47.764+00	_instance	type/Text	type/Category	t	\N	t	0	6	\N	Instance	normal	\N	\N	2017-11-12 21:38:58.302+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":17.0}}}	1
270	2017-11-12 21:38:44.683+00	2017-11-12 22:54:47.775+00	_occupation_area	type/Text	type/Category	t	\N	t	0	6	\N	Occupation Area	normal	\N	\N	2017-11-12 21:38:58.302+00	\N	\N	{"global":{"distinct-count":59},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":8.5765}}}	1
95	2017-11-12 21:38:38.197+00	2017-11-14 13:50:02.742+00	11	type/Integer	\N	t	\N	t	0	5	91	11	normal	\N	\N	\N	\N	\N	\N	0
96	2017-11-12 21:38:38.209+00	2017-11-14 13:50:02.753+00	05	type/Integer	\N	t	\N	t	0	5	91	05	normal	\N	\N	\N	\N	\N	\N	0
97	2017-11-12 21:38:38.23+00	2017-11-14 13:50:02.764+00	08	type/Integer	\N	t	\N	t	0	5	91	08	normal	\N	\N	\N	\N	\N	\N	0
98	2017-11-12 21:38:38.241+00	2017-11-14 13:50:02.775+00	07	type/Integer	\N	t	\N	t	0	5	91	07	normal	\N	\N	\N	\N	\N	\N	0
257	2017-11-12 21:38:40.39+00	2017-11-14 13:50:03.772+00	Intercâmbio Cultural	type/Integer	\N	t	\N	t	0	5	242	Intercâmbio Cultural	normal	\N	\N	\N	\N	\N	\N	0
494	2017-11-12 22:49:23.922+00	2017-11-12 22:54:47.709+00	_name	type/Text	\N	t	\N	t	0	6	\N	Name	normal	\N	\N	2017-11-12 22:50:11.107+00	\N	\N	{"global":{"distinct-count":4825},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":32.5611}}}	1
168	2017-11-12 21:38:39.231+00	2017-11-14 13:50:01.656+00	11	type/Integer	\N	t	\N	t	0	5	164	11	normal	\N	\N	\N	\N	\N	\N	0
36	2017-11-12 21:38:37.295+00	2017-11-14 13:50:01.823+00	spculturaprefeituraspgovbr	type/Dictionary	\N	t	\N	t	0	5	35	Sp Cultura Pre Fei Tura Sp Gov Br	normal	\N	\N	\N	\N	\N	\N	0
76	2017-11-12 21:38:37.953+00	2017-11-14 13:50:01.99+00	08	type/Integer	\N	t	\N	t	0	5	70	08	normal	\N	\N	\N	\N	\N	\N	0
50	2017-11-12 21:38:37.538+00	2017-11-14 13:50:02.011+00	2017	type/Dictionary	\N	t	\N	t	0	5	36	2017	normal	\N	\N	2017-11-12 22:50:09.997+00	\N	\N	{"global":{"distinct-count":2}}	1
302	2017-11-12 21:38:45.184+00	2017-11-20 23:50:01.529+00	05	type/Integer	\N	t	\N	t	0	7	297	05	normal	\N	\N	\N	\N	\N	\N	0
87	2017-11-12 21:38:38.107+00	2017-11-14 13:50:02.488+00	05	type/Integer	\N	t	\N	t	0	5	84	05	normal	\N	\N	\N	\N	\N	\N	0
92	2017-11-12 21:38:38.163+00	2017-11-14 13:50:02.786+00	09	type/Integer	\N	t	\N	t	0	5	91	09	normal	\N	\N	\N	\N	\N	\N	0
303	2017-11-12 21:38:45.194+00	2017-11-20 23:50:01.546+00	08	type/Integer	\N	t	\N	t	0	7	297	08	normal	\N	\N	\N	\N	\N	\N	0
305	2017-11-12 21:38:45.237+00	2017-11-20 23:50:01.517+00	10	type/Integer	\N	t	\N	t	0	7	297	10	normal	\N	\N	\N	\N	\N	\N	0
304	2017-11-12 21:38:45.216+00	2017-11-20 23:50:01.521+00	07	type/Integer	\N	t	\N	t	0	7	297	07	normal	\N	\N	\N	\N	\N	\N	0
301	2017-11-12 21:38:45.171+00	2017-11-20 23:50:01.525+00	11	type/Integer	\N	t	\N	t	0	7	297	11	normal	\N	\N	\N	\N	\N	\N	0
300	2017-11-12 21:38:45.16+00	2017-11-20 23:50:01.533+00	03	type/Integer	\N	t	\N	t	0	7	297	03	normal	\N	\N	\N	\N	\N	\N	0
299	2017-11-12 21:38:45.122+00	2017-11-20 23:50:01.538+00	06	type/Integer	\N	t	\N	t	0	7	297	06	normal	\N	\N	\N	\N	\N	\N	0
298	2017-11-12 21:38:45.104+00	2017-11-20 23:50:01.542+00	09	type/Integer	\N	t	\N	t	0	7	297	09	normal	\N	\N	\N	\N	\N	\N	0
101	2017-11-12 21:38:38.273+00	2017-11-14 13:50:02.797+00	01	type/Integer	\N	t	\N	t	0	5	91	01	normal	\N	\N	\N	\N	\N	\N	0
100	2017-11-12 21:38:38.264+00	2017-11-14 13:50:02.808+00	04	type/Integer	\N	t	\N	t	0	5	91	04	normal	\N	\N	\N	\N	\N	\N	0
196	2017-11-12 21:38:39.604+00	2017-11-14 13:50:03.251+00	Convenção	type/Integer	\N	t	\N	t	0	5	192	Convenção	normal	\N	\N	\N	\N	\N	\N	0
265	2017-11-12 21:38:40.488+00	2017-11-14 13:50:03.782+00	Fórum	type/Integer	\N	t	\N	t	0	5	242	Fórum	normal	\N	\N	\N	\N	\N	\N	0
504	2017-11-13 23:50:00.833+00	2017-11-14 13:50:00.482+00	Privada	type/Integer	\N	t	\N	t	0	13	502	Priv Ada	normal	\N	\N	\N	\N	\N	\N	0
503	2017-11-13 23:50:00.823+00	2017-11-14 13:50:00.493+00	None	type/Integer	\N	t	\N	t	0	13	502	None	normal	\N	\N	\N	\N	\N	\N	0
131	2017-11-12 21:38:38.75+00	2017-11-14 13:50:01.38+00	09	type/Integer	type/Category	t	\N	t	0	5	130	09	normal	\N	\N	2017-11-12 23:50:08.883+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":39,"avg":19.5}}}	1
55	2017-11-12 21:38:37.634+00	2017-11-14 13:50:02.121+00	05	type/Integer	type/Category	t	\N	t	0	5	50	05	normal	\N	\N	2017-11-12 22:50:09.997+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":3257,"avg":1628.5}}}	1
61	2017-11-12 21:38:37.723+00	2017-11-14 13:50:02.132+00	02	type/Integer	type/Category	t	\N	t	0	5	50	02	normal	\N	\N	2017-11-12 23:50:08.883+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":3258,"avg":1629.0}}}	1
62	2017-11-12 21:38:37.744+00	2017-11-14 13:50:02.154+00	2014	type/Dictionary	\N	t	\N	t	0	5	36	2014	normal	\N	\N	2017-11-12 22:50:09.997+00	\N	\N	{"global":{"distinct-count":3}}	1
89	2017-11-12 21:38:38.129+00	2017-11-14 13:50:02.499+00	04	type/Integer	\N	t	\N	t	0	5	84	04	normal	\N	\N	\N	\N	\N	\N	0
185	2017-11-12 21:38:39.46+00	2017-11-14 13:50:02.919+00	spculturaprefeituraspgovbr	type/Dictionary	\N	t	\N	t	0	5	181	Sp Cultura Pre Fei Tura Sp Gov Br	normal	\N	\N	\N	\N	\N	\N	0
192	2017-11-12 21:38:39.544+00	2017-11-14 13:50:02.979+00	spculturaprefeituraspgovbr	type/Dictionary	\N	t	\N	t	0	5	191	Sp Cultura Pre Fei Tura Sp Gov Br	normal	\N	\N	\N	\N	\N	\N	0
194	2017-11-12 21:38:39.581+00	2017-11-14 13:50:03.262+00	Conferência Pública Estadual	type/Integer	\N	t	\N	t	0	5	192	Conferência Pública Esta Dual	normal	\N	\N	\N	\N	\N	\N	0
294	2017-11-12 21:38:45.061+00	2017-11-19 17:54:25.968+00	07	type/Integer	\N	f	\N	t	0	7	288	07	normal	\N	\N	\N	\N	\N	\N	0
293	2017-11-12 21:38:45.05+00	2017-11-19 17:54:25.952+00	08	type/Integer	\N	f	\N	t	0	7	288	08	normal	\N	\N	\N	\N	\N	\N	0
292	2017-11-12 21:38:45.028+00	2017-11-19 17:54:25.96+00	05	type/Integer	\N	f	\N	t	0	7	288	05	normal	\N	\N	\N	\N	\N	\N	0
295	2017-11-12 21:38:45.071+00	2017-11-19 17:54:25.964+00	10	type/Integer	\N	f	\N	t	0	7	288	10	normal	\N	\N	\N	\N	\N	\N	0
333	2017-11-12 21:38:45.748+00	2017-11-20 23:50:01.387+00	01	type/Integer	\N	t	\N	t	0	7	322	01	normal	\N	\N	\N	\N	\N	\N	0
326	2017-11-12 21:38:45.625+00	2017-11-20 23:50:01.39+00	11	type/Integer	\N	t	\N	t	0	7	322	11	normal	\N	\N	\N	\N	\N	\N	0
427	2017-11-12 21:38:48.393+00	2017-11-19 17:54:27.267+00	Carnaval	type/Integer	\N	f	\N	t	0	8	337	Carnaval	normal	\N	\N	\N	\N	\N	\N	0
325	2017-11-12 21:38:45.615+00	2017-11-20 23:50:01.393+00	03	type/Integer	\N	t	\N	t	0	7	322	03	normal	\N	\N	\N	\N	\N	\N	0
216	2017-11-12 21:38:39.834+00	2017-11-14 13:50:03.273+00	Mostra	type/Integer	\N	t	\N	t	0	5	192	Most Ra	normal	\N	\N	\N	\N	\N	\N	0
229	2017-11-12 21:38:39.989+00	2017-11-14 13:50:03.528+00	Jornada	type/Integer	\N	t	\N	t	0	5	217	Jorn Ada	normal	\N	\N	\N	\N	\N	\N	0
253	2017-11-12 21:38:40.299+00	2017-11-14 13:50:03.793+00	Ciclo	type/Integer	\N	t	\N	t	0	5	242	Ci Clo	normal	\N	\N	\N	\N	\N	\N	0
266	2017-11-12 21:38:40.499+00	2017-11-14 13:50:03.805+00	Sarau	type/Integer	\N	t	\N	t	0	5	242	Sara U	normal	\N	\N	\N	\N	\N	\N	0
570	2017-11-13 23:50:12.505+00	2017-11-14 13:50:08.354+00	03	type/Integer	\N	t	\N	t	0	14	567	03	normal	\N	\N	\N	\N	\N	\N	0
317	2017-11-12 21:38:45.403+00	2017-11-20 23:50:01.459+00	07	type/Integer	\N	t	\N	t	0	7	310	07	normal	\N	\N	\N	\N	\N	\N	0
316	2017-11-12 21:38:45.393+00	2017-11-20 23:50:01.463+00	08	type/Integer	\N	t	\N	t	0	7	310	08	normal	\N	\N	\N	\N	\N	\N	0
315	2017-11-12 21:38:45.382+00	2017-11-20 23:50:01.468+00	05	type/Integer	\N	t	\N	t	0	7	310	05	normal	\N	\N	\N	\N	\N	\N	0
314	2017-11-12 21:38:45.371+00	2017-11-20 23:50:01.472+00	11	type/Integer	\N	t	\N	t	0	7	310	11	normal	\N	\N	\N	\N	\N	\N	0
313	2017-11-12 21:38:45.36+00	2017-11-20 23:50:01.475+00	03	type/Integer	\N	t	\N	t	0	7	310	03	normal	\N	\N	\N	\N	\N	\N	0
312	2017-11-12 21:38:45.349+00	2017-11-20 23:50:01.48+00	06	type/Integer	\N	t	\N	t	0	7	310	06	normal	\N	\N	\N	\N	\N	\N	0
319	2017-11-12 21:38:45.426+00	2017-11-20 23:50:01.487+00	04	type/Integer	\N	t	\N	t	0	7	310	04	normal	\N	\N	\N	\N	\N	\N	0
311	2017-11-12 21:38:45.338+00	2017-11-20 23:50:01.491+00	09	type/Integer	\N	t	\N	t	0	7	310	09	normal	\N	\N	\N	\N	\N	\N	0
321	2017-11-12 21:38:45.512+00	2017-11-20 23:50:01.496+00	02	type/Integer	\N	t	\N	t	0	7	310	02	normal	\N	\N	\N	\N	\N	\N	0
320	2017-11-12 21:38:45.448+00	2017-11-20 23:50:01.501+00	01	type/Integer	\N	t	\N	t	0	7	310	01	normal	\N	\N	\N	\N	\N	\N	0
318	2017-11-12 21:38:45.415+00	2017-11-20 23:50:01.505+00	10	type/Integer	\N	t	\N	t	0	7	310	10	normal	\N	\N	\N	\N	\N	\N	0
296	2017-11-12 21:38:45.082+00	2017-11-20 23:50:01.571+00	12	type/Integer	\N	t	\N	t	0	7	288	12	normal	\N	\N	\N	\N	\N	\N	0
362	2017-11-12 21:38:47.176+00	2017-11-20 23:50:02.05+00	arte digital	type/Integer	\N	t	\N	t	0	8	337	Arte Digital	normal	\N	\N	\N	\N	\N	\N	0
352	2017-11-12 21:38:46.949+00	2017-11-20 23:50:02.052+00	cultura digital	type/Integer	\N	t	\N	t	0	8	337	Cultura Digital	normal	\N	\N	\N	\N	\N	\N	0
351	2017-11-12 21:38:46.899+00	2017-11-20 23:50:02.055+00	livro	type/Integer	\N	t	\N	t	0	8	337	Liv Ro	normal	\N	\N	\N	\N	\N	\N	0
349	2017-11-12 21:38:46.866+00	2017-11-20 23:50:02.057+00	comunicação	type/Integer	\N	t	\N	t	0	8	337	Comunicação	normal	\N	\N	\N	\N	\N	\N	0
348	2017-11-12 21:38:46.833+00	2017-11-20 23:50:02.06+00	gestão cultural	type/Integer	\N	t	\N	t	0	8	337	Gestão Cultural	normal	\N	\N	\N	\N	\N	\N	0
347	2017-11-12 21:38:46.811+00	2017-11-20 23:50:02.062+00	artes visuais	type/Integer	\N	t	\N	t	0	8	337	Artes Vi Sua Is	normal	\N	\N	\N	\N	\N	\N	0
346	2017-11-12 21:38:46.799+00	2017-11-20 23:50:02.065+00	cultura indígena	type/Integer	\N	t	\N	t	0	8	337	Cultura Indígena	normal	\N	\N	\N	\N	\N	\N	0
345	2017-11-12 21:38:46.778+00	2017-11-20 23:50:02.067+00	circo	type/Integer	\N	t	\N	t	0	8	337	Circo	normal	\N	\N	\N	\N	\N	\N	0
344	2017-11-12 21:38:46.738+00	2017-11-20 23:50:02.071+00	Esporte	type/Integer	\N	t	\N	t	0	8	337	Esporte	normal	\N	\N	\N	\N	\N	\N	0
343	2017-11-12 21:38:46.711+00	2017-11-20 23:50:02.102+00	cultura lgbt	type/Integer	\N	t	\N	t	0	8	337	Cultura Lgbt	normal	\N	\N	\N	\N	\N	\N	0
342	2017-11-12 21:38:46.7+00	2017-11-20 23:50:02.104+00	Cultura Digital	type/Integer	\N	t	\N	t	0	8	337	Cultura Digital	normal	\N	\N	\N	\N	\N	\N	0
340	2017-11-12 21:38:46.666+00	2017-11-20 23:50:02.106+00	Moda	type/Integer	\N	t	\N	t	0	8	337	Moda	normal	\N	\N	\N	\N	\N	\N	0
339	2017-11-12 21:38:46.656+00	2017-11-20 23:50:02.109+00	cultura popular	type/Integer	\N	t	\N	t	0	8	337	Cultura Popular	normal	\N	\N	\N	\N	\N	\N	0
436	2017-11-12 21:38:48.515+00	2017-11-20 23:50:02.111+00	Arqueologia	type/Integer	\N	t	\N	t	0	8	337	Ar Que O Logia	normal	\N	\N	\N	\N	\N	\N	0
431	2017-11-12 21:38:48.438+00	2017-11-20 23:50:02.114+00	Fotografia	type/Integer	\N	t	\N	t	0	8	337	Fotogr A Fia	normal	\N	\N	\N	\N	\N	\N	0
420	2017-11-12 21:38:48.263+00	2017-11-20 23:50:02.116+00	Rádio	type/Integer	\N	t	\N	t	0	8	337	Rádio	normal	\N	\N	\N	\N	\N	\N	0
417	2017-11-12 21:38:48.205+00	2017-11-20 23:50:02.119+00	Antropologia	type/Integer	\N	t	\N	t	0	8	337	An Tro Polo Gia	normal	\N	\N	\N	\N	\N	\N	0
416	2017-11-12 21:38:48.196+00	2017-11-20 23:50:02.121+00	dança	type/Integer	\N	t	\N	t	0	8	337	Dança	normal	\N	\N	\N	\N	\N	\N	0
414	2017-11-12 21:38:48.172+00	2017-11-20 23:50:02.124+00	Música	type/Integer	\N	t	\N	t	0	8	337	Música	normal	\N	\N	\N	\N	\N	\N	0
413	2017-11-12 21:38:48.152+00	2017-11-20 23:50:02.126+00	literatura	type/Integer	\N	t	\N	t	0	8	337	Literatura	normal	\N	\N	\N	\N	\N	\N	0
330	2017-11-12 21:38:45.692+00	2017-11-20 23:50:01.379+00	10	type/Integer	\N	t	\N	t	0	7	322	10	normal	\N	\N	\N	\N	\N	\N	0
328	2017-11-12 21:38:45.648+00	2017-11-20 23:50:01.382+00	08	type/Integer	\N	t	\N	t	0	7	322	08	normal	\N	\N	\N	\N	\N	\N	0
334	2017-11-12 21:38:45.76+00	2017-11-20 23:50:01.385+00	02	type/Integer	\N	t	\N	t	0	7	322	02	normal	\N	\N	\N	\N	\N	\N	0
332	2017-11-12 21:38:45.727+00	2017-11-20 23:50:01.395+00	04	type/Integer	\N	t	\N	t	0	7	322	04	normal	\N	\N	\N	\N	\N	\N	0
261	2017-11-12 21:38:40.444+00	2017-11-14 13:50:03.816+00	Parada e Desfile de Ações Afirmativas	type/Integer	\N	t	\N	t	0	5	242	Parada E Des File De Ações A Firm At Iv As	normal	\N	\N	\N	\N	\N	\N	0
263	2017-11-12 21:38:40.465+00	2017-11-14 13:50:03.827+00	Concurso	type/Integer	type/Category	t	\N	t	0	5	242	Concur So	normal	\N	\N	2017-11-12 21:38:54.891+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":3257,"avg":1628.5}}}	1
571	2017-11-13 23:50:12.517+00	2017-11-14 13:50:08.344+00	11	type/Integer	\N	t	\N	t	0	14	567	11	normal	\N	\N	\N	\N	\N	\N	0
535	2017-11-13 23:50:01.244+00	2017-11-14 13:50:00.139+00	Ecomuseu	type/Integer	\N	t	\N	t	0	13	528	Eco Muse U	normal	\N	\N	\N	\N	\N	\N	0
532	2017-11-13 23:50:01.21+00	2017-11-14 13:50:00.16+00	Virtual	type/Integer	\N	t	\N	t	0	13	528	Virtual	normal	\N	\N	\N	\N	\N	\N	0
531	2017-11-13 23:50:01.2+00	2017-11-14 13:50:00.171+00	Clássico	type/Integer	\N	t	\N	t	0	13	528	Clássico	normal	\N	\N	\N	\N	\N	\N	0
529	2017-11-13 23:50:01.17+00	2017-11-14 13:50:00.194+00	None	type/Integer	\N	t	\N	t	0	13	528	None	normal	\N	\N	\N	\N	\N	\N	0
527	2017-11-13 23:50:01.145+00	2017-11-14 13:50:00.227+00	_create_date	type/Text	\N	t	\N	t	0	13	\N	Create Date	normal	\N	\N	\N	\N	\N	\N	0
526	2017-11-13 23:50:01.133+00	2017-11-14 13:50:00.238+00	_cls	type/Text	\N	t	\N	t	0	13	\N	Cls	normal	\N	\N	\N	\N	\N	\N	0
515	2017-11-13 23:50:00.989+00	2017-11-14 13:50:00.249+00	_thematics_museums	type/Dictionary	\N	t	\N	t	0	13	\N	Them A Tics Museums	normal	\N	\N	\N	\N	\N	\N	0
525	2017-11-13 23:50:01.122+00	2017-11-14 13:50:00.262+00	Produção de bens e serviços	type/Integer	\N	t	\N	t	0	13	515	Produção De Be Ns E Serviços	normal	\N	\N	\N	\N	\N	\N	0
524	2017-11-13 23:50:01.111+00	2017-11-14 13:50:00.271+00	História	type/Integer	\N	t	\N	t	0	13	515	História	normal	\N	\N	\N	\N	\N	\N	0
523	2017-11-13 23:50:01.1+00	2017-11-14 13:50:00.282+00	Educação, esporte e lazer	type/Integer	\N	t	\N	t	0	13	515	Educação, Esporte E Laz Er	normal	\N	\N	\N	\N	\N	\N	0
522	2017-11-13 23:50:01.088+00	2017-11-14 13:50:00.293+00	Ciências exatas, da terra, biológicas e da saúde	type/Integer	\N	t	\N	t	0	13	515	Ciências Exatas, Da Terra, Biológicas E Da Saúde	normal	\N	\N	\N	\N	\N	\N	0
521	2017-11-13 23:50:01.077+00	2017-11-14 13:50:00.305+00	None	type/Integer	\N	t	\N	t	0	13	515	None	normal	\N	\N	\N	\N	\N	\N	0
520	2017-11-13 23:50:01.065+00	2017-11-14 13:50:00.316+00	Antropologia e arqueologia	type/Integer	\N	t	\N	t	0	13	515	An Tro Polo Gia E Ar Que O Logia	normal	\N	\N	\N	\N	\N	\N	0
519	2017-11-13 23:50:01.045+00	2017-11-14 13:50:00.327+00	Defesa e segurança pública	type/Integer	\N	t	\N	t	0	13	515	Def Esa E Segurança Pública	normal	\N	\N	\N	\N	\N	\N	0
387	2017-11-12 21:38:47.564+00	2017-11-19 17:54:27.239+00	literatura infantil	type/Integer	\N	f	\N	t	0	8	337	Literatura Infant Il	normal	\N	\N	\N	\N	\N	\N	0
400	2017-11-12 21:38:47.795+00	2017-11-19 17:54:27.248+00	exposições	type/Integer	\N	f	\N	t	0	8	337	Exposições	normal	\N	\N	\N	\N	\N	\N	0
412	2017-11-12 21:38:48.131+00	2017-11-19 17:54:27.275+00	agentes	type/Integer	\N	f	\N	t	0	8	337	Agent Es	normal	\N	\N	\N	\N	\N	\N	0
465	2017-11-12 21:38:48.869+00	2017-11-19 17:54:27.289+00	teatro estudantil	type/Integer	\N	f	\N	t	0	8	337	Teatro Est Ud An Til	normal	\N	\N	\N	\N	\N	\N	0
423	2017-11-12 21:38:48.318+00	2017-11-19 17:54:27.303+00	danca	type/Integer	\N	f	\N	t	0	8	337	Dan Ca	normal	\N	\N	\N	\N	\N	\N	0
467	2017-11-12 21:38:48.891+00	2017-11-20 23:50:02.136+00	arqueologia	type/Integer	\N	t	\N	t	0	8	337	Ar Que O Logia	normal	\N	\N	\N	\N	\N	\N	0
466	2017-11-12 21:38:48.881+00	2017-11-19 17:54:27.217+00	Orquestra	type/Integer	\N	f	\N	t	0	8	337	Or Quest Ra	normal	\N	\N	\N	\N	\N	\N	0
464	2017-11-12 21:38:48.858+00	2017-11-20 23:50:02.139+00	Outros	type/Integer	\N	t	\N	t	0	8	337	Out Ros	normal	\N	\N	\N	\N	\N	\N	0
463	2017-11-12 21:38:48.847+00	2017-11-20 23:50:02.142+00	Pesquisa	type/Integer	\N	t	\N	t	0	8	337	Pes Quis A	normal	\N	\N	\N	\N	\N	\N	0
518	2017-11-13 23:50:01.028+00	2017-11-14 13:50:00.338+00	Artes, arquitetura e linguística	type/Integer	\N	t	\N	t	0	13	515	Artes, Ar Quite Tura E Linguística	normal	\N	\N	\N	\N	\N	\N	0
517	2017-11-13 23:50:01.012+00	2017-11-14 13:50:00.349+00	Antropologia e Arqueologia	type/Integer	\N	t	\N	t	0	13	515	An Tro Polo Gia E Ar Que O Logia	normal	\N	\N	\N	\N	\N	\N	0
516	2017-11-13 23:50:01.001+00	2017-11-14 13:50:00.36+00	Meios de comunicação e transporte	type/Integer	\N	t	\N	t	0	13	515	Me Ios De Comunicação E Trans Porte	normal	\N	\N	\N	\N	\N	\N	0
514	2017-11-13 23:50:00.972+00	2017-11-14 13:50:00.371+00	_total_museums	type/Integer	\N	t	\N	t	0	13	\N	Total Museums	normal	\N	\N	\N	\N	\N	\N	0
506	2017-11-13 23:50:00.855+00	2017-11-14 13:50:00.382+00	_total_museums_historical	type/Dictionary	\N	t	\N	t	0	13	\N	Total Museums Historical	normal	\N	\N	\N	\N	\N	\N	0
459	2017-11-12 21:38:48.797+00	2017-11-20 23:50:02.147+00	artesanato	type/Integer	\N	t	\N	t	0	8	337	Artes An A To	normal	\N	\N	\N	\N	\N	\N	0
458	2017-11-12 21:38:48.781+00	2017-11-20 23:50:02.149+00	arquivo	type/Integer	\N	t	\N	t	0	8	337	Ar Qui Vo	normal	\N	\N	\N	\N	\N	\N	0
354	2017-11-12 21:38:47.043+00	2017-11-20 23:50:02.152+00	Cinema	type/Integer	\N	t	\N	t	0	8	337	Cinema	normal	\N	\N	\N	\N	\N	\N	0
437	2017-11-12 21:38:48.539+00	2017-11-20 23:50:02.154+00	Literatura	type/Integer	\N	t	\N	t	0	8	337	Literatura	normal	\N	\N	\N	\N	\N	\N	0
439	2017-11-12 21:38:48.559+00	2017-11-20 23:50:02.157+00	rádio	type/Integer	\N	t	\N	t	0	8	337	Rádio	normal	\N	\N	\N	\N	\N	\N	0
430	2017-11-12 21:38:48.427+00	2017-11-20 23:50:02.159+00	Sociologia	type/Integer	\N	t	\N	t	0	8	337	Socio Logia	normal	\N	\N	\N	\N	\N	\N	0
429	2017-11-12 21:38:48.415+00	2017-11-20 23:50:02.162+00	turismo	type/Integer	\N	t	\N	t	0	8	337	Turismo	normal	\N	\N	\N	\N	\N	\N	0
425	2017-11-12 21:38:48.361+00	2017-11-20 23:50:02.166+00	esporte	type/Integer	\N	t	\N	t	0	8	337	Esporte	normal	\N	\N	\N	\N	\N	\N	0
424	2017-11-12 21:38:48.339+00	2017-11-20 23:50:02.169+00	Turismo	type/Integer	\N	t	\N	t	0	8	337	Turismo	normal	\N	\N	\N	\N	\N	\N	0
407	2017-11-12 21:38:47.974+00	2017-11-20 23:50:02.173+00	Direito Autoral	type/Integer	\N	t	\N	t	0	8	337	Dire I To Aut Oral	normal	\N	\N	\N	\N	\N	\N	0
406	2017-11-12 21:38:47.962+00	2017-11-20 23:50:02.177+00	leitura	type/Integer	\N	t	\N	t	0	8	337	Lei Tura	normal	\N	\N	\N	\N	\N	\N	0
402	2017-11-12 21:38:47.896+00	2017-11-20 23:50:02.181+00	Cultura Cigana	type/Integer	\N	t	\N	t	0	8	337	Cultura Cig An A	normal	\N	\N	\N	\N	\N	\N	0
399	2017-11-12 21:38:47.784+00	2017-11-20 23:50:02.185+00	Cultura LGBT	type/Integer	\N	t	\N	t	0	8	337	Cultura Lgbt	normal	\N	\N	\N	\N	\N	\N	0
398	2017-11-12 21:38:47.762+00	2017-11-20 23:50:02.189+00	Novas Mídias	type/Integer	\N	t	\N	t	0	8	337	Novas Mídias	normal	\N	\N	\N	\N	\N	\N	0
396	2017-11-12 21:38:47.717+00	2017-11-20 23:50:02.193+00	filosofia	type/Integer	\N	t	\N	t	0	8	337	Filo Sofia	normal	\N	\N	\N	\N	\N	\N	0
395	2017-11-12 21:38:47.706+00	2017-11-20 23:50:02.198+00	Saúde	type/Integer	\N	t	\N	t	0	8	337	Saúde	normal	\N	\N	\N	\N	\N	\N	0
394	2017-11-12 21:38:47.696+00	2017-11-20 23:50:02.202+00	Teatro	type/Integer	\N	t	\N	t	0	8	337	Teatro	normal	\N	\N	\N	\N	\N	\N	0
393	2017-11-12 21:38:47.686+00	2017-11-20 23:50:02.207+00	Filosofia	type/Integer	\N	t	\N	t	0	8	337	Filo Sofia	normal	\N	\N	\N	\N	\N	\N	0
392	2017-11-12 21:38:47.661+00	2017-11-20 23:50:02.21+00	Livro	type/Integer	\N	t	\N	t	0	8	337	Liv Ro	normal	\N	\N	\N	\N	\N	\N	0
391	2017-11-12 21:38:47.64+00	2017-11-20 23:50:02.214+00	Museu	type/Integer	\N	t	\N	t	0	8	337	Muse U	normal	\N	\N	\N	\N	\N	\N	0
389	2017-11-12 21:38:47.6+00	2017-11-20 23:50:02.218+00	Cultura Popular	type/Integer	\N	t	\N	t	0	8	337	Cultura Popular	normal	\N	\N	\N	\N	\N	\N	0
388	2017-11-12 21:38:47.577+00	2017-11-20 23:50:02.222+00	jornalismo	type/Integer	\N	t	\N	t	0	8	337	Jorn Al Is Mo	normal	\N	\N	\N	\N	\N	\N	0
386	2017-11-12 21:38:47.541+00	2017-11-20 23:50:02.228+00	direito autoral	type/Integer	\N	t	\N	t	0	8	337	Dire I To Aut Oral	normal	\N	\N	\N	\N	\N	\N	0
408	2017-11-12 21:38:48+00	2017-11-20 23:50:02.129+00	jogos eletrônicos	type/Integer	\N	t	\N	t	0	8	337	Jog Os Eletrônicos	normal	\N	\N	\N	\N	\N	\N	0
471	2017-11-12 21:38:48.949+00	2017-11-20 23:50:02.131+00	Dança	type/Integer	\N	t	\N	t	0	8	337	Dança	normal	\N	\N	\N	\N	\N	\N	0
461	2017-11-12 21:38:48.824+00	2017-11-20 23:50:02.144+00	audiovisual	type/Integer	\N	t	\N	t	0	8	337	Audiovisual	normal	\N	\N	\N	\N	\N	\N	0
470	2017-11-12 21:38:48.928+00	2017-11-20 23:50:02.134+00	Artes Visuais	type/Integer	\N	t	\N	t	0	8	337	Artes Vi Sua Is	normal	\N	\N	\N	\N	\N	\N	0
497	2017-11-12 23:36:13.427+00	2017-11-14 06:14:07.926+00	_occupation_area	type/Text	type/Category	f	\N	t	0	12	\N	Occupation Area	normal	\N	\N	2017-11-12 23:50:11.918+00	\N	\N	{"global":{"distinct-count":59},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":8.5765}}}	1
509	2017-11-13 23:50:00.888+00	2017-11-14 13:50:00.405+00	sim	type/Integer	\N	t	\N	t	0	13	506	Sim	normal	\N	\N	\N	\N	\N	\N	0
502	2017-11-13 23:50:00.796+00	2017-11-14 13:50:00.449+00	_total_public_private_museums	type/Dictionary	\N	t	\N	t	0	13	\N	Total Public Private Museums	normal	\N	\N	\N	\N	\N	\N	0
513	2017-11-13 23:50:00.953+00	2017-11-14 13:50:00.528+00	sim	type/Integer	\N	t	\N	t	0	13	510	Sim	normal	\N	\N	\N	\N	\N	\N	0
512	2017-11-13 23:50:00.933+00	2017-11-14 13:50:00.538+00	None	type/Integer	\N	t	\N	t	0	13	510	None	normal	\N	\N	\N	\N	\N	\N	0
511	2017-11-13 23:50:00.914+00	2017-11-14 13:50:00.548+00	não	type/Integer	\N	t	\N	t	0	13	510	Não	normal	\N	\N	\N	\N	\N	\N	0
179	2017-11-12 21:38:39.393+00	2017-11-14 13:50:01.069+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	5	\N	ID	normal	\N	\N	\N	\N	\N	\N	0
35	2017-11-12 21:38:37.273+00	2017-11-14 13:50:01.08+00	_total_project_registered_per_mounth_per_year	type/Dictionary	\N	t	\N	t	0	5	\N	Total Project Registered Per Mou Nth Per Year	normal	\N	\N	2017-11-12 21:38:54.891+00	\N	\N	{"global":{"distinct-count":2}}	1
170	2017-11-12 21:38:39.271+00	2017-11-14 13:50:01.667+00	08	type/Integer	\N	t	\N	t	0	5	164	08	normal	\N	\N	\N	\N	\N	\N	0
174	2017-11-12 21:38:39.315+00	2017-11-14 13:50:01.678+00	04	type/Integer	\N	t	\N	t	0	5	164	04	normal	\N	\N	\N	\N	\N	\N	0
143	2017-11-12 21:38:38.905+00	2017-11-14 13:50:01.705+00	2013	type/Dictionary	\N	t	\N	t	0	5	117	2013	normal	\N	\N	\N	\N	\N	\N	0
144	2017-11-12 21:38:38.915+00	2017-11-14 13:50:01.8+00	09	type/Integer	\N	t	\N	t	0	5	143	09	normal	\N	\N	\N	\N	\N	\N	0
145	2017-11-12 21:38:38.927+00	2017-11-14 13:50:01.812+00	06	type/Integer	\N	t	\N	t	0	5	143	06	normal	\N	\N	\N	\N	\N	\N	0
75	2017-11-12 21:38:37.936+00	2017-11-14 13:50:01.999+00	05	type/Integer	\N	t	\N	t	0	5	70	05	normal	\N	\N	\N	\N	\N	\N	0
60	2017-11-12 21:38:37.71+00	2017-11-14 13:50:02.143+00	01	type/Integer	\N	t	\N	t	0	5	50	01	normal	\N	\N	\N	\N	\N	\N	0
83	2017-11-12 21:38:38.065+00	2017-11-14 13:50:02.409+00	mapaculturacegovbr	type/Dictionary	\N	t	\N	t	0	5	35	Map A Cultura Ce Gov Br	normal	\N	\N	2017-11-12 21:38:54.891+00	\N	\N	{"global":{"distinct-count":2}}	1
85	2017-11-12 21:38:38.085+00	2017-11-14 13:50:02.509+00	09	type/Integer	\N	t	\N	t	0	5	84	09	normal	\N	\N	\N	\N	\N	\N	0
86	2017-11-12 21:38:38.1+00	2017-11-14 13:50:02.52+00	03	type/Integer	\N	t	\N	t	0	5	84	03	normal	\N	\N	\N	\N	\N	\N	0
99	2017-11-12 21:38:38.253+00	2017-11-14 13:50:02.819+00	10	type/Integer	\N	t	\N	t	0	5	91	10	normal	\N	\N	\N	\N	\N	\N	0
181	2017-11-12 21:38:39.417+00	2017-11-14 13:50:02.83+00	_total_project_that_accept_online_transitions	type/Dictionary	\N	t	\N	t	0	5	\N	Total Project That Accept Online Transitions	normal	\N	\N	\N	\N	\N	\N	0
217	2017-11-12 21:38:39.846+00	2017-11-14 13:50:03.296+00	mapaculturacegovbr	type/Dictionary	\N	t	\N	t	0	5	191	Map A Cultura Ce Gov Br	normal	\N	\N	\N	\N	\N	\N	0
447	2017-11-12 21:38:48.659+00	2017-11-19 17:54:27.253+00	Capoeira	type/Integer	\N	f	\N	t	0	8	337	Capoeira	normal	\N	\N	\N	\N	\N	\N	0
365	2017-11-12 21:38:47.208+00	2017-11-19 17:54:27.257+00	Opera	type/Integer	\N	f	\N	t	0	8	337	Opera	normal	\N	\N	\N	\N	\N	\N	0
450	2017-11-12 21:38:48.692+00	2017-11-19 17:54:27.278+00	ponto de memória	type/Integer	\N	f	\N	t	0	8	337	Pon To De Memória	normal	\N	\N	\N	\N	\N	\N	0
374	2017-11-12 21:38:47.319+00	2017-11-19 17:54:27.3+00	Biblioteca	type/Integer	\N	f	\N	t	0	8	337	Bib Li Otec A	normal	\N	\N	\N	\N	\N	\N	0
446	2017-11-12 21:38:48.648+00	2017-11-20 23:50:02.245+00	educação	type/Integer	\N	t	\N	t	0	8	337	Educação	normal	\N	\N	\N	\N	\N	\N	0
442	2017-11-12 21:38:48.594+00	2017-11-19 17:54:27.244+00	intercambio cultural	type/Integer	\N	f	\N	t	0	8	337	Inter Cambio Cultural	normal	\N	\N	\N	\N	\N	\N	0
444	2017-11-12 21:38:48.615+00	2017-11-20 23:50:02.249+00	Cultura Negra	type/Integer	\N	t	\N	t	0	8	337	Cultura Negra	normal	\N	\N	\N	\N	\N	\N	0
221	2017-11-12 21:38:39.891+00	2017-11-14 13:50:03.539+00	Conferência Pública Municipal	type/Integer	\N	t	\N	t	0	5	217	Conferência Pública Municipal	normal	\N	\N	\N	\N	\N	\N	0
246	2017-11-12 21:38:40.208+00	2017-11-14 13:50:03.838+00	Conferência Pública Estadual	type/Integer	\N	t	\N	t	0	5	242	Conferência Pública Esta Dual	normal	\N	\N	\N	\N	\N	\N	0
537	2017-11-13 23:50:12.115+00	2017-11-14 13:50:08.323+00	_total_museums_registered_year	type/Dictionary	\N	t	\N	t	0	14	\N	Total Museums Registered Year	normal	\N	\N	\N	\N	\N	\N	0
567	2017-11-13 23:50:12.472+00	2017-11-14 13:50:08.333+00	2016	type/Dictionary	\N	t	\N	t	0	14	537	2016	normal	\N	\N	\N	\N	\N	\N	0
577	2017-11-13 23:50:12.605+00	2017-11-14 13:50:08.365+00	04	type/Integer	\N	t	\N	t	0	14	567	04	normal	\N	\N	\N	\N	\N	\N	0
572	2017-11-13 23:50:12.533+00	2017-11-14 13:50:08.376+00	05	type/Integer	\N	t	\N	t	0	14	567	05	normal	\N	\N	\N	\N	\N	\N	0
508	2017-11-13 23:50:00.876+00	2017-11-14 13:50:00.431+00	None	type/Integer	\N	t	\N	t	0	13	506	None	normal	\N	\N	\N	\N	\N	\N	0
536	2017-11-13 23:50:01.256+00	2017-11-14 13:50:00.505+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	13	\N	ID	normal	\N	\N	2017-11-13 23:50:15.449+00	\N	\N	{"global":{"distinct-count":2}}	1
375	2017-11-12 21:38:47.33+00	2017-11-20 23:50:02.261+00	Televisão	type/Integer	\N	t	\N	t	0	8	337	Televisão	normal	\N	\N	\N	\N	\N	\N	0
373	2017-11-12 21:38:47.308+00	2017-11-20 23:50:02.265+00	Educação	type/Integer	\N	t	\N	t	0	8	337	Educação	normal	\N	\N	\N	\N	\N	\N	0
371	2017-11-12 21:38:47.285+00	2017-11-20 23:50:02.267+00	Produção Cultural	type/Integer	\N	t	\N	t	0	8	337	Produção Cultural	normal	\N	\N	\N	\N	\N	\N	0
370	2017-11-12 21:38:47.275+00	2017-11-20 23:50:02.27+00	fotografia	type/Integer	\N	t	\N	t	0	8	337	Fotogr A Fia	normal	\N	\N	\N	\N	\N	\N	0
369	2017-11-12 21:38:47.264+00	2017-11-20 23:50:02.273+00	Gestão Cultural	type/Integer	\N	t	\N	t	0	8	337	Gestão Cultural	normal	\N	\N	\N	\N	\N	\N	0
368	2017-11-12 21:38:47.252+00	2017-11-20 23:50:02.276+00	teatro	type/Integer	\N	t	\N	t	0	8	337	Teatro	normal	\N	\N	\N	\N	\N	\N	0
355	2017-11-12 21:38:47.065+00	2017-11-20 23:50:02.279+00	Arquivo	type/Integer	\N	t	\N	t	0	8	337	Ar Qui Vo	normal	\N	\N	\N	\N	\N	\N	0
364	2017-11-12 21:38:47.197+00	2017-11-20 23:50:02.282+00	Cultura Indígena	type/Integer	\N	t	\N	t	0	8	337	Cultura Indígena	normal	\N	\N	\N	\N	\N	\N	0
363	2017-11-12 21:38:47.186+00	2017-11-20 23:50:02.285+00	antropologia	type/Integer	\N	t	\N	t	0	8	337	An Tro Polo Gia	normal	\N	\N	\N	\N	\N	\N	0
451	2017-11-12 21:38:48.702+00	2017-11-20 23:50:02.288+00	cinema	type/Integer	\N	t	\N	t	0	8	337	Cinema	normal	\N	\N	\N	\N	\N	\N	0
449	2017-11-12 21:38:48.682+00	2017-11-20 23:50:02.291+00	arte de rua	type/Integer	\N	t	\N	t	0	8	337	Arte De Rua	normal	\N	\N	\N	\N	\N	\N	0
448	2017-11-12 21:38:48.669+00	2017-11-20 23:50:02.294+00	arquitetura-urbanismo	type/Integer	\N	t	\N	t	0	8	337	Ar Quite Tura Urbanism O	normal	\N	\N	\N	\N	\N	\N	0
359	2017-11-12 21:38:47.133+00	2017-11-20 23:50:02.297+00	Mídias Sociais	type/Integer	\N	t	\N	t	0	8	337	Mídias Soci A Is	normal	\N	\N	\N	\N	\N	\N	0
456	2017-11-12 21:38:48.759+00	2017-11-20 23:50:02.301+00	saúde	type/Integer	\N	t	\N	t	0	8	337	Saúde	normal	\N	\N	\N	\N	\N	\N	0
455	2017-11-12 21:38:48.748+00	2017-11-20 23:50:02.303+00	sociologia	type/Integer	\N	t	\N	t	0	8	337	Socio Logia	normal	\N	\N	\N	\N	\N	\N	0
454	2017-11-12 21:38:48.736+00	2017-11-20 23:50:02.306+00	história	type/Integer	\N	t	\N	t	0	8	337	História	normal	\N	\N	\N	\N	\N	\N	0
453	2017-11-12 21:38:48.724+00	2017-11-20 23:50:02.309+00	moda	type/Integer	\N	t	\N	t	0	8	337	Moda	normal	\N	\N	\N	\N	\N	\N	0
384	2017-11-12 21:38:47.521+00	2017-11-20 23:50:02.312+00	pesquisa	type/Integer	\N	t	\N	t	0	8	337	Pes Quis A	normal	\N	\N	\N	\N	\N	\N	0
381	2017-11-12 21:38:47.463+00	2017-11-20 23:50:02.232+00	Gastronomia	type/Integer	\N	t	\N	t	0	8	337	Gas Trono Mia	normal	\N	\N	\N	\N	\N	\N	0
443	2017-11-12 21:38:48.604+00	2017-11-20 23:50:02.253+00	design	type/Integer	\N	t	\N	t	0	8	337	Design	normal	\N	\N	\N	\N	\N	\N	0
376	2017-11-12 21:38:47.343+00	2017-11-20 23:50:02.258+00	Artesanato	type/Integer	\N	t	\N	t	0	8	337	Artes An A To	normal	\N	\N	\N	\N	\N	\N	0
378	2017-11-12 21:38:47.431+00	2017-11-20 23:50:02.24+00	Arte Digital	type/Integer	\N	t	\N	t	0	8	337	Arte Digital	normal	\N	\N	\N	\N	\N	\N	0
379	2017-11-12 21:38:47.441+00	2017-11-20 23:50:02.236+00	Meio Ambiente	type/Integer	\N	t	\N	t	0	8	337	Mei O Am Bien Te	normal	\N	\N	\N	\N	\N	\N	0
510	2017-11-13 23:50:00.901+00	2017-11-14 13:50:00.515+00	_total_museums_promote_guide	type/Dictionary	\N	t	\N	t	0	13	\N	Total Museums Promote Guide	normal	\N	\N	2017-11-13 23:50:15.449+00	\N	\N	{"global":{"distinct-count":2}}	1
120	2017-11-12 21:38:38.584+00	2017-11-14 13:50:01.235+00	06	type/Integer	\N	t	\N	t	0	5	118	06	normal	\N	\N	\N	\N	\N	\N	0
161	2017-11-12 21:38:39.128+00	2017-11-14 13:50:01.534+00	04	type/Integer	\N	t	\N	t	0	5	152	04	normal	\N	\N	\N	\N	\N	\N	0
37	2017-11-12 21:38:37.317+00	2017-11-14 13:50:02.254+00	2015	type/Dictionary	\N	t	\N	t	0	5	36	2015	normal	\N	\N	2017-11-12 23:50:08.883+00	\N	\N	{"global":{"distinct-count":2}}	1
42	2017-11-12 21:38:37.403+00	2017-11-14 13:50:02.398+00	05	type/Integer	type/Category	t	\N	t	0	5	37	05	normal	\N	\N	2017-11-13 23:50:17.492+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":3266,"avg":1633.0}}}	1
90	2017-11-12 21:38:38.141+00	2017-11-14 13:50:02.531+00	01	type/Integer	type/Category	t	\N	t	0	5	84	01	normal	\N	\N	2017-11-13 23:50:17.492+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":39,"avg":19.5}}}	1
107	2017-11-12 21:38:38.385+00	2017-11-14 13:50:02.675+00	11	type/Integer	\N	t	\N	t	0	5	103	11	normal	\N	\N	\N	\N	\N	\N	0
91	2017-11-12 21:38:38.153+00	2017-11-14 13:50:02.686+00	2017	type/Dictionary	\N	t	\N	t	0	5	83	2017	normal	\N	\N	\N	\N	\N	\N	0
180	2017-11-12 21:38:39.405+00	2017-11-14 13:50:02.952+00	_total_project	type/Integer	\N	t	\N	t	0	5	\N	Total Project	normal	\N	\N	\N	\N	\N	\N	0
191	2017-11-12 21:38:39.527+00	2017-11-14 13:50:02.963+00	_total_project_per_type	type/Dictionary	\N	t	\N	t	0	5	\N	Total Project Per Type	normal	\N	\N	\N	\N	\N	\N	0
215	2017-11-12 21:38:39.823+00	2017-11-14 13:50:03.284+00	Exposição	type/Integer	type/Category	t	\N	t	0	5	192	Exposição	normal	\N	\N	2017-11-12 21:38:54.891+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":39,"avg":19.5}}}	1
231	2017-11-12 21:38:40.012+00	2017-11-14 13:50:03.549+00	Seminário	type/Integer	\N	t	\N	t	0	5	217	Seminário	normal	\N	\N	\N	\N	\N	\N	0
234	2017-11-12 21:38:40.045+00	2017-11-14 13:50:03.561+00	Parada e Desfile de Ações Afirmativas	type/Integer	\N	t	\N	t	0	5	217	Parada E Des File De Ações A Firm At Iv As	normal	\N	\N	\N	\N	\N	\N	0
220	2017-11-12 21:38:39.88+00	2017-11-14 13:50:03.572+00	Conferência Pública Nacional	type/Integer	\N	t	\N	t	0	5	217	Conferência Pública Nacional	normal	\N	\N	\N	\N	\N	\N	0
242	2017-11-12 21:38:40.146+00	2017-11-14 13:50:03.583+00	mapasculturagovbr	type/Dictionary	\N	t	\N	t	0	5	191	Map As Cultura Gov Br	normal	\N	\N	\N	\N	\N	\N	0
269	2017-11-12 21:38:40.532+00	2017-11-14 13:50:03.849+00	Mostra	type/Integer	\N	t	\N	t	0	5	242	Most Ra	normal	\N	\N	\N	\N	\N	\N	0
254	2017-11-12 21:38:40.31+00	2017-11-14 13:50:03.86+00	Festival	type/Integer	\N	t	\N	t	0	5	242	Festival	normal	\N	\N	\N	\N	\N	\N	0
262	2017-11-12 21:38:40.454+00	2017-11-14 13:50:03.871+00	Encontro	type/Integer	\N	t	\N	t	0	5	242	Enc On Tro	normal	\N	\N	\N	\N	\N	\N	0
245	2017-11-12 21:38:40.185+00	2017-11-14 13:50:03.882+00	Parada e Desfile Cívico	type/Integer	\N	t	\N	t	0	5	242	Parada E Des File Cívico	normal	\N	\N	\N	\N	\N	\N	0
244	2017-11-12 21:38:40.167+00	2017-11-14 13:50:03.893+00	Festa Popular	type/Integer	\N	t	\N	t	0	5	242	Festa Popular	normal	\N	\N	\N	\N	\N	\N	0
568	2017-11-13 23:50:12.482+00	2017-11-14 13:50:08.387+00	09	type/Integer	\N	t	\N	t	0	14	567	09	normal	\N	\N	\N	\N	\N	\N	0
569	2017-11-13 23:50:12.494+00	2017-11-14 13:50:08.398+00	06	type/Integer	type/Category	t	\N	t	0	14	567	06	normal	\N	\N	2017-11-13 23:50:19.325+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":3,"avg":1.5}}}	1
358	2017-11-12 21:38:47.111+00	2017-11-19 17:54:27.297+00	culturas urbanas	type/Integer	\N	f	\N	t	0	8	337	Cult Ur As Urban As	normal	\N	\N	\N	\N	\N	\N	0
460	2017-11-12 21:38:48.814+00	2017-11-19 17:54:27.307+00	demais atividades correlatas a cultura popular	type/Integer	\N	f	\N	t	0	8	337	Dem A Is At I Vida Des Corre Lat As A Cultura Popular	normal	\N	\N	\N	\N	\N	\N	0
469	2017-11-12 21:38:48.914+00	2017-11-19 17:54:27.311+00	artistas agentes culturais	type/Integer	\N	f	\N	t	0	8	337	Artist As Agent Es Cultura Is	normal	\N	\N	\N	\N	\N	\N	0
452	2017-11-12 21:38:48.715+00	2017-11-19 17:54:27.264+00	Coral	type/Integer	\N	f	\N	t	0	8	337	Coral	normal	\N	\N	\N	\N	\N	\N	0
489	2017-11-12 21:38:50.941+00	2017-11-19 17:54:28.03+00	_libraries_registered_monthly	type/Dictionary	\N	t	\N	t	0	10	\N	Libraries Registered Monthly	normal	\N	\N	2017-11-12 21:39:01.856+00	\N	\N	{"global":{"distinct-count":4}}	1
490	2017-11-12 21:38:50.951+00	2017-11-19 17:54:28.033+00	julho	type/Integer	type/Category	t	\N	t	0	10	489	Jul Ho	normal	\N	\N	2017-11-13 23:50:18.67+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}	1
485	2017-11-12 21:38:50.896+00	2017-11-19 17:54:28.036+00	_total_libraries	type/Integer	type/Category	t	\N	t	0	10	\N	Total Libraries	normal	\N	\N	2017-11-12 21:39:01.856+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}	1
480	2017-11-12 21:38:50.83+00	2017-11-19 17:54:28.038+00	_total_libraries_type_sphere	type/Dictionary	\N	t	\N	t	0	10	\N	Total Libraries Type Sphere	normal	\N	\N	2017-11-12 22:50:12.544+00	\N	\N	{"global":{"distinct-count":1}}	1
487	2017-11-12 21:38:50.918+00	2017-11-19 17:54:28.046+00	_libraries_registered_yearly	type/Dictionary	\N	t	\N	t	0	10	\N	Libraries Registered Yearly	normal	\N	\N	2017-11-12 21:39:01.856+00	\N	\N	{"global":{"distinct-count":4}}	1
488	2017-11-12 21:38:50.929+00	2017-11-19 17:54:28.05+00	2010	type/Integer	type/Category	t	\N	t	0	10	487	2010	normal	\N	\N	2017-11-12 21:39:01.856+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}	1
486	2017-11-12 21:38:50.907+00	2017-11-19 17:54:28.053+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	10	\N	ID	normal	\N	\N	2017-11-12 21:39:01.856+00	\N	\N	{"global":{"distinct-count":1}}	1
492	2017-11-12 21:38:50.973+00	2017-11-19 17:54:28.056+00	_libraries_per_activity	type/Dictionary	\N	t	\N	t	0	10	\N	Libraries Per Activity	normal	\N	\N	2017-11-12 21:39:01.856+00	\N	\N	{"global":{"distinct-count":1}}	1
493	2017-11-12 21:38:50.984+00	2017-11-19 17:54:28.059+00	Leitura	type/Integer	\N	t	\N	t	0	10	492	Lei Tura	normal	\N	\N	\N	\N	\N	\N	0
483	2017-11-12 21:38:50.868+00	2017-11-19 17:54:28.062+00	_total_private_libraries	type/Integer	type/Category	t	\N	t	0	10	\N	Total Private Libraries	normal	\N	\N	2017-11-12 22:50:12.544+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}	1
561	2017-11-13 23:50:12.405+00	2017-11-14 13:50:08.476+00	2013	type/Dictionary	\N	t	\N	t	0	14	537	2013	normal	\N	\N	\N	\N	\N	\N	0
566	2017-11-13 23:50:12.46+00	2017-11-14 13:50:08.492+00	10	type/Integer	\N	t	\N	t	0	14	561	10	normal	\N	\N	\N	\N	\N	\N	0
565	2017-11-13 23:50:12.45+00	2017-11-14 13:50:08.509+00	07	type/Integer	\N	t	\N	t	0	14	561	07	normal	\N	\N	\N	\N	\N	\N	0
564	2017-11-13 23:50:12.438+00	2017-11-14 13:50:08.52+00	08	type/Integer	\N	t	\N	t	0	14	561	08	normal	\N	\N	\N	\N	\N	\N	0
563	2017-11-13 23:50:12.427+00	2017-11-14 13:50:08.532+00	11	type/Integer	\N	t	\N	t	0	14	561	11	normal	\N	\N	\N	\N	\N	\N	0
562	2017-11-13 23:50:12.416+00	2017-11-14 13:50:08.542+00	06	type/Integer	\N	t	\N	t	0	14	561	06	normal	\N	\N	\N	\N	\N	\N	0
538	2017-11-13 23:50:12.127+00	2017-11-14 13:50:08.554+00	2014	type/Dictionary	\N	t	\N	t	0	14	537	2014	normal	\N	\N	\N	\N	\N	\N	0
547	2017-11-13 23:50:12.239+00	2017-11-14 13:50:08.566+00	12	type/Integer	\N	t	\N	t	0	14	538	12	normal	\N	\N	\N	\N	\N	\N	0
546	2017-11-13 23:50:12.228+00	2017-11-14 13:50:08.576+00	10	type/Integer	\N	t	\N	t	0	14	538	10	normal	\N	\N	\N	\N	\N	\N	0
545	2017-11-13 23:50:12.219+00	2017-11-14 13:50:08.587+00	07	type/Integer	\N	t	\N	t	0	14	538	07	normal	\N	\N	\N	\N	\N	\N	0
544	2017-11-13 23:50:12.204+00	2017-11-14 13:50:08.598+00	08	type/Integer	\N	t	\N	t	0	14	538	08	normal	\N	\N	\N	\N	\N	\N	0
543	2017-11-13 23:50:12.194+00	2017-11-14 13:50:08.609+00	05	type/Integer	\N	t	\N	t	0	14	538	05	normal	\N	\N	\N	\N	\N	\N	0
542	2017-11-13 23:50:12.183+00	2017-11-14 13:50:08.62+00	11	type/Integer	\N	t	\N	t	0	14	538	11	normal	\N	\N	\N	\N	\N	\N	0
541	2017-11-13 23:50:12.166+00	2017-11-14 13:50:08.631+00	03	type/Integer	\N	t	\N	t	0	14	538	03	normal	\N	\N	\N	\N	\N	\N	0
341	2017-11-12 21:38:46.68+00	2017-11-20 23:50:02.315+00	novas mídias	type/Integer	\N	t	\N	t	0	8	337	Novas Mídias	normal	\N	\N	\N	\N	\N	\N	0
421	2017-11-12 21:38:48.283+00	2017-11-20 23:50:02.318+00	Economia Criativa	type/Integer	\N	t	\N	t	0	8	337	Eco No Mia Cri At Iva	normal	\N	\N	\N	\N	\N	\N	0
478	2017-11-12 21:38:50.778+00	2017-11-20 23:50:02.433+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	9	\N	ID	normal	\N	\N	2017-11-12 21:39:00.716+00	\N	\N	{"global":{"distinct-count":2}}	1
539	2017-11-13 23:50:12.138+00	2017-11-14 13:50:08.653+00	09	type/Integer	\N	t	\N	t	0	14	538	09	normal	\N	\N	\N	\N	\N	\N	0
580	2017-11-13 23:50:12.641+00	2017-11-14 13:50:08.676+00	2015	type/Dictionary	\N	t	\N	t	0	14	537	2015	normal	\N	\N	\N	\N	\N	\N	0
589	2017-11-13 23:50:12.894+00	2017-11-14 13:50:08.691+00	01	type/Integer	\N	t	\N	t	0	14	580	01	normal	\N	\N	\N	\N	\N	\N	0
588	2017-11-13 23:50:12.883+00	2017-11-14 13:50:08.709+00	04	type/Integer	\N	t	\N	t	0	14	580	04	normal	\N	\N	\N	\N	\N	\N	0
587	2017-11-13 23:50:12.873+00	2017-11-14 13:50:08.72+00	12	type/Integer	\N	t	\N	t	0	14	580	12	normal	\N	\N	\N	\N	\N	\N	0
586	2017-11-13 23:50:12.835+00	2017-11-14 13:50:08.731+00	07	type/Integer	\N	t	\N	t	0	14	580	07	normal	\N	\N	\N	\N	\N	\N	0
585	2017-11-13 23:50:12.706+00	2017-11-14 13:50:08.742+00	05	type/Integer	\N	t	\N	t	0	14	580	05	normal	\N	\N	\N	\N	\N	\N	0
584	2017-11-13 23:50:12.694+00	2017-11-14 13:50:08.753+00	11	type/Integer	\N	t	\N	t	0	14	580	11	normal	\N	\N	\N	\N	\N	\N	0
583	2017-11-13 23:50:12.687+00	2017-11-14 13:50:08.764+00	03	type/Integer	\N	t	\N	t	0	14	580	03	normal	\N	\N	\N	\N	\N	\N	0
582	2017-11-13 23:50:12.66+00	2017-11-14 13:50:08.775+00	06	type/Integer	\N	t	\N	t	0	14	580	06	normal	\N	\N	\N	\N	\N	\N	0
581	2017-11-13 23:50:12.654+00	2017-11-14 13:50:08.786+00	09	type/Integer	\N	t	\N	t	0	14	580	09	normal	\N	\N	\N	\N	\N	\N	0
560	2017-11-13 23:50:12.393+00	2017-11-14 13:50:08.813+00	02	type/Integer	\N	t	\N	t	0	14	549	02	normal	\N	\N	\N	\N	\N	\N	0
559	2017-11-13 23:50:12.382+00	2017-11-14 13:50:08.831+00	01	type/Integer	\N	t	\N	t	0	14	549	01	normal	\N	\N	\N	\N	\N	\N	0
558	2017-11-13 23:50:12.375+00	2017-11-14 13:50:08.842+00	04	type/Integer	\N	t	\N	t	0	14	549	04	normal	\N	\N	\N	\N	\N	\N	0
557	2017-11-13 23:50:12.354+00	2017-11-14 13:50:08.853+00	10	type/Integer	\N	t	\N	t	0	14	549	10	normal	\N	\N	\N	\N	\N	\N	0
540	2017-11-13 23:50:12.152+00	2017-11-14 13:50:12.74+00	06	type/Integer	type/Category	t	\N	t	0	14	538	06	normal	\N	\N	2017-11-14 13:50:12.749+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":3,"avg":1.5}}}	1
528	2017-11-13 23:50:01.158+00	2017-11-14 13:50:00.12+00	_type_museums	type/Dictionary	\N	t	\N	t	0	13	\N	Type Museums	normal	\N	\N	\N	\N	\N	\N	0
533	2017-11-13 23:50:01.223+00	2017-11-14 13:50:00.205+00	Jardim zoológico, jardim botânico herbário, oceanário ou planetário	type/Integer	\N	t	\N	t	0	13	528	Jardim Zoológico, Jardim Botânico Herbário, Oceanário Ou Planetário	normal	\N	\N	\N	\N	\N	\N	0
507	2017-11-13 23:50:00.867+00	2017-11-14 13:50:00.395+00	não	type/Integer	type/Category	t	\N	t	0	13	506	Não	normal	\N	\N	2017-11-13 23:50:15.449+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":3795,"avg":1897.5}}}	1
505	2017-11-13 23:50:00.844+00	2017-11-14 13:50:00.464+00	Pública	type/Integer	\N	t	\N	t	0	13	502	Pública	normal	\N	\N	\N	\N	\N	\N	0
177	2017-11-12 21:38:39.359+00	2017-11-14 13:50:01.032+00	_cls	type/Text	\N	t	\N	t	0	5	\N	Cls	normal	\N	\N	\N	\N	\N	\N	0
178	2017-11-12 21:38:39.374+00	2017-11-14 13:50:01.058+00	_create_date	type/Text	\N	t	\N	t	0	5	\N	Create Date	normal	\N	\N	\N	\N	\N	\N	0
117	2017-11-12 21:38:38.53+00	2017-11-14 13:50:01.093+00	mapasculturagovbr	type/Dictionary	\N	t	\N	t	0	5	35	Map As Cultura Gov Br	normal	\N	\N	\N	\N	\N	\N	0
118	2017-11-12 21:38:38.539+00	2017-11-14 13:50:01.114+00	2015	type/Dictionary	\N	t	\N	t	0	5	117	2015	normal	\N	\N	\N	\N	\N	\N	0
126	2017-11-12 21:38:38.673+00	2017-11-14 13:50:01.146+00	10	type/Integer	\N	t	\N	t	0	5	118	10	normal	\N	\N	\N	\N	\N	\N	0
122	2017-11-12 21:38:38.617+00	2017-11-14 13:50:01.224+00	11	type/Integer	type/Category	t	\N	t	0	5	118	11	normal	\N	\N	2017-11-12 22:50:09.997+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":39,"avg":19.5}}}	1
357	2017-11-12 21:38:47.098+00	2017-11-20 23:50:02.331+00	museu	type/Integer	type/Category	t	\N	t	0	8	337	Muse U	normal	\N	\N	2017-11-12 23:50:09.691+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":27718,"avg":18478.666666666668}}}	1
428	2017-11-12 21:38:48.403+00	2017-11-19 17:54:27.322+00	dança e canto coral	type/Integer	\N	f	\N	t	0	8	337	Dança E Can To Coral	normal	\N	\N	\N	\N	\N	\N	0
481	2017-11-12 21:38:50.841+00	2017-11-19 17:54:28.043+00	Municipal	type/Integer	type/Category	t	\N	t	0	10	480	Municipal	normal	\N	\N	2017-11-12 23:50:09.857+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}	1
479	2017-11-12 21:38:50.824+00	2017-11-19 17:54:28.065+00	_create_date	type/DateTime	\N	t	\N	t	0	10	\N	Create Date	normal	\N	\N	2017-11-12 22:50:12.544+00	\N	\N	{"global":{"distinct-count":1}}	1
141	2017-11-12 21:38:38.873+00	2017-11-14 13:50:01.357+00	01	type/Integer	\N	t	\N	t	0	5	130	01	normal	\N	\N	\N	\N	\N	\N	0
164	2017-11-12 21:38:39.159+00	2017-11-14 13:50:01.545+00	2016	type/Dictionary	\N	t	\N	t	0	5	117	2016	normal	\N	\N	\N	\N	\N	\N	0
51	2017-11-12 21:38:37.554+00	2017-11-14 13:50:02.11+00	09	type/Integer	\N	t	\N	t	0	5	50	09	normal	\N	\N	\N	\N	\N	\N	0
106	2017-11-12 21:38:38.375+00	2017-11-14 13:50:02.642+00	03	type/Integer	\N	t	\N	t	0	5	103	03	normal	\N	\N	\N	\N	\N	\N	0
94	2017-11-12 21:38:38.187+00	2017-11-14 13:50:02.73+00	03	type/Integer	\N	t	\N	t	0	5	91	03	normal	\N	\N	\N	\N	\N	\N	0
210	2017-11-12 21:38:39.768+00	2017-11-14 13:50:03.229+00	Simpósio	type/Integer	\N	t	\N	t	0	5	192	Simpósio	normal	\N	\N	\N	\N	\N	\N	0
248	2017-11-12 21:38:40.237+00	2017-11-14 13:50:03.599+00	Palestra	type/Integer	\N	t	\N	t	0	5	242	Palestra	normal	\N	\N	\N	\N	\N	\N	0
268	2017-11-12 21:38:40.521+00	2017-11-14 13:50:03.627+00	Pesquisa	type/Integer	\N	t	\N	t	0	5	242	Pes Quis A	normal	\N	\N	\N	\N	\N	\N	0
251	2017-11-12 21:38:40.277+00	2017-11-14 13:50:03.683+00	Parada e Desfile Festivo	type/Integer	\N	t	\N	t	0	5	242	Parada E Des File Fest Ivo	normal	\N	\N	\N	\N	\N	\N	0
258	2017-11-12 21:38:40.411+00	2017-11-14 13:50:03.76+00	Seminário	type/Integer	\N	t	\N	t	0	5	242	Seminário	normal	\N	\N	\N	\N	\N	\N	0
579	2017-11-13 23:50:12.628+00	2017-11-14 13:50:08.41+00	02	type/Integer	\N	t	\N	t	0	14	567	02	normal	\N	\N	\N	\N	\N	\N	0
578	2017-11-13 23:50:12.617+00	2017-11-14 13:50:08.421+00	01	type/Integer	\N	t	\N	t	0	14	567	01	normal	\N	\N	\N	\N	\N	\N	0
576	2017-11-13 23:50:12.595+00	2017-11-14 13:50:08.432+00	12	type/Integer	\N	t	\N	t	0	14	567	12	normal	\N	\N	\N	\N	\N	\N	0
575	2017-11-13 23:50:12.583+00	2017-11-14 13:50:08.443+00	10	type/Integer	\N	t	\N	t	0	14	567	10	normal	\N	\N	\N	\N	\N	\N	0
574	2017-11-13 23:50:12.569+00	2017-11-14 13:50:08.454+00	07	type/Integer	\N	t	\N	t	0	14	567	07	normal	\N	\N	\N	\N	\N	\N	0
573	2017-11-13 23:50:12.553+00	2017-11-14 13:50:08.465+00	08	type/Integer	\N	t	\N	t	0	14	567	08	normal	\N	\N	\N	\N	\N	\N	0
548	2017-11-13 23:50:12.252+00	2017-11-14 13:50:08.665+00	04	type/Integer	\N	t	\N	t	0	14	538	04	normal	\N	\N	\N	\N	\N	\N	0
549	2017-11-13 23:50:12.261+00	2017-11-14 13:50:08.798+00	2017	type/Dictionary	\N	t	\N	t	0	14	537	2017	normal	\N	\N	\N	\N	\N	\N	0
499	2017-11-12 23:36:13.485+00	2017-11-20 23:50:03.16+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	12	\N	ID	normal	\N	\N	2017-11-12 23:50:11.918+00	\N	\N	{"global":{"distinct-count":10000}}	1
496	2017-11-12 23:36:13.344+00	2017-11-20 23:50:03.162+00	_name	type/Text	\N	t	\N	t	0	12	\N	Name	normal	\N	\N	2017-11-12 23:50:11.918+00	\N	\N	{"global":{"distinct-count":4825},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":32.5611}}}	1
422	2017-11-12 21:38:48.295+00	2017-11-20 23:50:02.322+00	meio ambiente	type/Integer	\N	t	\N	t	0	8	337	Mei O Am Bien Te	normal	\N	\N	\N	\N	\N	\N	0
360	2017-11-12 21:38:47.155+00	2017-11-20 23:50:02.325+00	música	type/Integer	type/Category	t	\N	t	0	8	337	Música	normal	\N	\N	2017-11-12 22:50:12.266+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":27718,"avg":18478.666666666668}}}	1
438	2017-11-12 21:38:48.549+00	2017-11-20 23:50:02.328+00	Design	type/Integer	type/Category	t	\N	t	0	8	337	Design	normal	\N	\N	2017-11-12 21:39:00.594+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":27717,"avg":18478.0}}}	1
405	2017-11-12 21:38:47.95+00	2017-11-20 23:50:02.334+00	Audiovisual	type/Integer	\N	t	\N	t	0	8	337	Audiovisual	normal	\N	\N	\N	\N	\N	\N	0
501	2017-11-12 23:36:13.529+00	2017-11-20 23:50:03.151+00	_date	type/DateTime	\N	t	\N	t	0	12	\N	Date	normal	\N	\N	2017-11-12 23:50:11.918+00	\N	\N	{"global":{"distinct-count":327}}	1
500	2017-11-12 23:36:13.515+00	2017-11-20 23:50:03.154+00	_instance	type/Text	type/Category	t	\N	t	0	12	\N	Instance	normal	\N	\N	2017-11-12 23:50:11.918+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":17.0}}}	1
556	2017-11-13 23:50:12.337+00	2017-11-14 13:50:08.864+00	07	type/Integer	\N	t	\N	t	0	14	549	07	normal	\N	\N	\N	\N	\N	\N	0
555	2017-11-13 23:50:12.327+00	2017-11-14 13:50:08.886+00	08	type/Integer	\N	t	\N	t	0	14	549	08	normal	\N	\N	\N	\N	\N	\N	0
554	2017-11-13 23:50:12.316+00	2017-11-14 13:50:08.898+00	05	type/Integer	\N	t	\N	t	0	14	549	05	normal	\N	\N	\N	\N	\N	\N	0
553	2017-11-13 23:50:12.305+00	2017-11-14 13:50:08.908+00	11	type/Integer	\N	t	\N	t	0	14	549	11	normal	\N	\N	\N	\N	\N	\N	0
552	2017-11-13 23:50:12.294+00	2017-11-14 13:50:08.919+00	03	type/Integer	\N	t	\N	t	0	14	549	03	normal	\N	\N	\N	\N	\N	\N	0
551	2017-11-13 23:50:12.282+00	2017-11-14 13:50:08.93+00	06	type/Integer	\N	t	\N	t	0	14	549	06	normal	\N	\N	\N	\N	\N	\N	0
550	2017-11-13 23:50:12.275+00	2017-11-14 13:50:08.941+00	09	type/Integer	\N	t	\N	t	0	14	549	09	normal	\N	\N	\N	\N	\N	\N	0
591	2017-11-13 23:50:12.917+00	2017-11-14 13:50:08.952+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	14	\N	ID	normal	\N	\N	2017-11-13 23:50:19.325+00	\N	\N	{"global":{"distinct-count":2}}	1
534	2017-11-13 23:50:01.233+00	2017-11-14 13:50:10.304+00	Unidade de conservação da natureza	type/Integer	type/Category	t	\N	t	0	13	528	Uni Dade De Conservação Da Nature Za	normal	\N	\N	2017-11-14 13:50:10.316+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":2573,"avg":1286.5}}}	1
590	2017-11-13 23:50:12.907+00	2017-11-14 13:50:08.964+00	_create_date	type/Text	type/Category	t	\N	t	0	14	\N	Create Date	normal	\N	\N	2017-11-13 23:50:19.325+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":26.0}}}	1
530	2017-11-13 23:50:01.19+00	2017-11-14 13:50:10.294+00	Jardim zoológico, botânico, herbário, oceanário ou planetário	type/Integer	type/Category	t	\N	t	0	13	528	Jardim Zoológico, Botânico, Herbário, Oceanário Ou Planetário	normal	\N	\N	2017-11-14 13:50:10.316+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":3796,"avg":1898.0}}}	1
46	2017-11-12 21:38:37.49+00	2017-11-14 13:50:11.533+00	12	type/Integer	type/Category	t	\N	t	0	5	37	12	normal	\N	\N	2017-11-14 13:50:11.553+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":3266,"avg":1633.0}}}	1
205	2017-11-12 21:38:39.713+00	2017-11-14 13:50:11.543+00	Intercâmbio Cultural	type/Integer	type/Category	t	\N	t	0	5	192	Intercâmbio Cultural	normal	\N	\N	2017-11-14 13:50:11.553+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":39,"avg":19.5}}}	1
599	2017-11-18 01:13:58.413+00	2017-11-20 23:50:01.303+00	_date	type/DateTime	\N	t	\N	t	0	16	\N	Date	normal	\N	\N	2017-11-18 01:50:03.075+00	\N	\N	{"global":{"distinct-count":974}}	1
289	2017-11-12 21:38:44.994+00	2017-11-19 17:54:25.957+00	09	type/Integer	\N	f	\N	t	0	7	288	09	normal	\N	\N	\N	\N	\N	\N	0
367	2017-11-12 21:38:47.233+00	2017-11-19 17:54:27.293+00	acervos museológicos	type/Integer	\N	f	\N	t	0	8	337	Acer Vos Museológicos	normal	\N	\N	\N	\N	\N	\N	0
441	2017-11-12 21:38:48.582+00	2017-11-19 17:54:27.319+00	fabricação de obras de arte	type/Integer	\N	f	\N	t	0	8	337	Fabricação De Obras De Arte	normal	\N	\N	\N	\N	\N	\N	0
415	2017-11-12 21:38:48.184+00	2017-11-19 17:54:27.284+00	fortalecimento de cultura de rede local	type/Integer	\N	f	\N	t	0	8	337	For Tale Ci Men To De Cultura De Rede Local	normal	\N	\N	\N	\N	\N	\N	0
595	2017-11-18 01:13:58.383+00	2017-11-20 23:50:01.305+00	_online_subscribe	type/Text	type/Category	t	\N	t	0	16	\N	Online Subscribe	normal	\N	\N	2017-11-18 01:50:03.075+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":4.801405438435686}}}	1
601	2017-11-18 01:13:58.461+00	2017-11-20 23:50:01.317+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	17	\N	ID	normal	\N	\N	2017-11-18 01:50:03.118+00	\N	\N	{"global":{"distinct-count":2}}	1
600	2017-11-18 01:13:58.453+00	2017-11-20 23:50:01.319+00	_create_date	type/Text	type/Category	t	\N	t	0	17	\N	Create Date	normal	\N	\N	2017-11-18 01:50:03.118+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":26.0}}}	1
273	2017-11-12 21:38:44.789+00	2017-11-20 23:50:01.368+00	_create_date	type/Text	\N	t	\N	t	0	7	\N	Create Date	normal	\N	\N	\N	\N	\N	\N	0
335	2017-11-12 21:38:45.77+00	2017-11-20 23:50:01.37+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	7	\N	ID	normal	\N	\N	2017-11-12 21:38:59.409+00	\N	\N	{"global":{"distinct-count":3}}	1
274	2017-11-12 21:38:44.808+00	2017-11-20 23:50:01.373+00	_total_agents_registered_month	type/Dictionary	\N	t	\N	t	0	7	\N	Total Agents Registered Month	normal	\N	\N	2017-11-12 21:38:59.409+00	\N	\N	{"global":{"distinct-count":2}}	1
322	2017-11-12 21:38:45.539+00	2017-11-20 23:50:01.376+00	2016	type/Dictionary	\N	t	\N	t	0	7	274	2016	normal	\N	\N	\N	\N	\N	\N	0
329	2017-11-12 21:38:45.67+00	2017-11-20 23:50:01.398+00	07	type/Integer	\N	t	\N	t	0	7	322	07	normal	\N	\N	\N	\N	\N	\N	0
323	2017-11-12 21:38:45.581+00	2017-11-20 23:50:01.4+00	09	type/Integer	\N	t	\N	t	0	7	322	09	normal	\N	\N	\N	\N	\N	\N	0
327	2017-11-12 21:38:45.636+00	2017-11-20 23:50:01.402+00	05	type/Integer	\N	t	\N	t	0	7	322	05	normal	\N	\N	\N	\N	\N	\N	0
275	2017-11-12 21:38:44.828+00	2017-11-20 23:50:01.41+00	2014	type/Dictionary	\N	t	\N	t	0	7	274	2014	normal	\N	\N	2017-11-12 23:50:09.134+00	\N	\N	{"global":{"distinct-count":3}}	1
287	2017-11-12 21:38:44.966+00	2017-11-20 23:50:01.434+00	02	type/Integer	\N	t	\N	t	0	7	275	02	normal	\N	\N	\N	\N	\N	\N	0
310	2017-11-12 21:38:45.327+00	2017-11-20 23:50:01.452+00	2017	type/Dictionary	\N	t	\N	t	0	7	274	2017	normal	\N	\N	\N	\N	\N	\N	0
297	2017-11-12 21:38:45.094+00	2017-11-20 23:50:01.511+00	2015	type/Dictionary	\N	t	\N	t	0	7	274	2015	normal	\N	\N	2017-11-13 23:50:17.808+00	\N	\N	{"global":{"distinct-count":2}}	1
309	2017-11-12 21:38:45.315+00	2017-11-20 23:50:01.549+00	02	type/Integer	\N	t	\N	t	0	7	297	02	normal	\N	\N	\N	\N	\N	\N	0
291	2017-11-12 21:38:45.017+00	2017-11-20 23:50:01.574+00	11	type/Integer	\N	t	\N	t	0	7	288	11	normal	\N	\N	\N	\N	\N	\N	0
592	2017-11-14 06:14:08.657+00	2017-11-20 23:50:01.936+00	_occupation_area	type/Text	type/Category	t	\N	t	0	15	\N	Occupation Area	normal	\N	\N	2017-11-14 13:50:13.669+00	\N	\N	{"global":{"distinct-count":59},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":8.5765}}}	1
593	2017-11-14 06:14:08.663+00	2017-11-20 23:50:01.938+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	15	\N	ID	normal	\N	\N	2017-11-14 13:50:13.669+00	\N	\N	{"global":{"distinct-count":10000}}	1
594	2017-11-14 06:14:08.668+00	2017-11-20 23:50:01.941+00	_instance	type/Text	type/Category	t	\N	t	0	15	\N	Instance	normal	\N	\N	2017-11-14 13:50:13.669+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":17.0}}}	1
418	2017-11-12 21:38:48.217+00	2017-11-20 23:50:02.339+00	Jornalismo	type/Integer	\N	t	\N	t	0	8	337	Jorn Al Is Mo	normal	\N	\N	\N	\N	\N	\N	0
434	2017-11-12 21:38:48.481+00	2017-11-20 23:50:02.348+00	História	type/Integer	type/Category	t	\N	t	0	8	337	História	normal	\N	\N	2017-11-12 21:39:00.594+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":38745,"avg":25830.0}}}	1
614	2017-11-20 23:00:05.809+00	2017-11-20 23:50:04.241+00	_sphere	type/Text	type/Category	t	\N	t	0	22	\N	Sphere	normal	\N	\N	2017-11-20 23:50:04.244+00	\N	\N	{"global":{"distinct-count":3},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":6.521074815595363}}}	1
607	2017-11-19 17:54:25.682+00	2017-11-20 23:50:06.27+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	19	\N	ID	normal	\N	\N	2017-11-20 23:50:06.28+00	\N	\N	{"global":{"distinct-count":2}}	1
603	2017-11-19 17:54:25.313+00	2017-11-20 23:50:06.021+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	18	\N	ID	normal	\N	\N	2017-11-20 23:50:06.24+00	\N	\N	{"global":{"distinct-count":10000}}	1
606	2017-11-19 17:54:25.675+00	2017-11-20 23:50:06.277+00	_create_date	type/Text	type/Category	t	\N	t	0	19	\N	Create Date	normal	\N	\N	2017-11-20 23:50:06.28+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":26.0}}}	1
372	2017-11-12 21:38:47.298+00	2017-11-19 17:54:27.228+00	turismo de base comunitária	type/Integer	\N	f	\N	t	0	8	337	Turismo De Base Comunitária	normal	\N	\N	\N	\N	\N	\N	0
435	2017-11-12 21:38:48.493+00	2017-11-19 17:54:27.232+00	mostras culturais	type/Integer	type/Category	f	\N	t	0	8	337	Most Ras Cultura Is	normal	\N	\N	2017-11-12 21:39:00.594+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":11028,"avg":7352.0}}}	1
440	2017-11-12 21:38:48.57+00	2017-11-19 17:54:27.315+00	permacultura e cultura hacker	type/Integer	\N	f	\N	t	0	8	337	Perm A Cultura E Cultura Hacker	normal	\N	\N	\N	\N	\N	\N	0
404	2017-11-12 21:38:47.939+00	2017-11-19 17:54:27.331+00	intercâmbio cultural	type/Integer	\N	f	\N	t	0	8	337	Intercâmbio Cultural	normal	\N	\N	\N	\N	\N	\N	0
383	2017-11-12 21:38:47.498+00	2017-11-19 17:54:27.21+00	Banda	type/Integer	\N	f	\N	t	0	8	337	Band A	normal	\N	\N	\N	\N	\N	\N	0
491	2017-11-12 21:38:50.963+00	2017-11-19 17:54:28.067+00	_amount_areas	type/Integer	type/Category	t	\N	t	0	10	\N	Amount Areas	normal	\N	\N	2017-11-14 13:50:12.362+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}	1
484	2017-11-12 21:38:50.885+00	2017-11-19 17:54:28.07+00	_cls	type/Text	type/Category	t	\N	t	0	10	\N	Cls	normal	\N	\N	2017-11-12 21:39:01.856+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":14.0}}}	1
307	2017-11-12 21:38:45.26+00	2017-11-20 23:50:01.553+00	04	type/Integer	\N	t	\N	t	0	7	297	04	normal	\N	\N	\N	\N	\N	\N	0
290	2017-11-12 21:38:45.006+00	2017-11-19 17:54:25.948+00	06	type/Integer	\N	f	\N	t	0	7	288	06	normal	\N	\N	\N	\N	\N	\N	0
288	2017-11-12 21:38:44.983+00	2017-11-20 23:50:01.565+00	2013	type/Dictionary	\N	t	\N	t	0	7	274	2013	normal	\N	\N	\N	\N	\N	\N	0
476	2017-11-12 21:38:49.023+00	2017-11-20 23:50:02.036+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	8	\N	ID	normal	\N	\N	2017-11-12 23:50:09.691+00	\N	\N	{"global":{"distinct-count":3}}	1
397	2017-11-12 21:38:47.739+00	2017-11-19 17:54:27.214+00	marchetaria	type/Integer	\N	f	\N	t	0	8	337	March Et Aria	normal	\N	\N	\N	\N	\N	\N	0
457	2017-11-12 21:38:48.77+00	2017-11-19 17:54:27.221+00	festas calendarizadas populares	type/Integer	\N	f	\N	t	0	8	337	Fest As Calendar Iz Adas Popular Es	normal	\N	\N	\N	\N	\N	\N	0
445	2017-11-12 21:38:48.636+00	2017-11-19 17:54:27.225+00	arte terapia	type/Integer	\N	f	\N	t	0	8	337	Arte Ter Apia	normal	\N	\N	\N	\N	\N	\N	0
377	2017-11-12 21:38:47.364+00	2017-11-19 17:54:27.26+00	Ciência Política	type/Integer	\N	f	\N	t	0	8	337	Ciência Política	normal	\N	\N	\N	\N	\N	\N	0
426	2017-11-12 21:38:48.382+00	2017-11-19 17:54:27.271+00	Gestor Publico de Cultura	type/Integer	\N	f	\N	t	0	8	337	Ge Stor Public O De Cultura	normal	\N	\N	\N	\N	\N	\N	0
432	2017-11-12 21:38:48.448+00	2017-11-19 17:54:27.327+00	agroecologia	type/Integer	\N	f	\N	t	0	8	337	A Gro Eco Logia	normal	\N	\N	\N	\N	\N	\N	0
482	2017-11-12 21:38:50.852+00	2017-11-19 17:54:28.027+00	_total_public_libraries	type/Integer	type/Category	t	\N	t	0	10	\N	Total Public Libraries	normal	\N	\N	2017-11-12 22:50:12.544+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}	1
337	2017-11-12 21:38:46.635+00	2017-11-20 23:50:02.046+00	_total_agents_area_oreration	type/Dictionary	\N	t	\N	t	0	8	\N	Total Agents Area Ore Ration	normal	\N	\N	2017-11-18 02:50:03.313+00	\N	\N	{"global":{"distinct-count":2}}	1
410	2017-11-12 21:38:48.085+00	2017-11-20 23:50:02.353+00	cultura negra	type/Integer	\N	t	\N	t	0	8	337	Cultura Negra	normal	\N	\N	\N	\N	\N	\N	0
403	2017-11-12 21:38:47.928+00	2017-11-20 23:50:02.361+00	Jogos Eletrônicos	type/Integer	\N	t	\N	t	0	8	337	Jog Os Eletrônicos	normal	\N	\N	\N	\N	\N	\N	0
390	2017-11-12 21:38:47.622+00	2017-11-20 23:50:02.365+00	mídias sociais	type/Integer	\N	t	\N	t	0	8	337	Mídias Soci A Is	normal	\N	\N	\N	\N	\N	\N	0
411	2017-11-12 21:38:48.11+00	2017-11-20 23:50:02.368+00	Comunicação	type/Integer	\N	t	\N	t	0	8	337	Comunicação	normal	\N	\N	\N	\N	\N	\N	0
401	2017-11-12 21:38:47.806+00	2017-11-20 23:50:02.373+00	economia criativa	type/Integer	\N	t	\N	t	0	8	337	Eco No Mia Cri At Iva	normal	\N	\N	\N	\N	\N	\N	0
385	2017-11-12 21:38:47.533+00	2017-11-20 23:50:02.377+00	Leitura	type/Integer	\N	t	\N	t	0	8	337	Lei Tura	normal	\N	\N	\N	\N	\N	\N	0
380	2017-11-12 21:38:47.453+00	2017-11-20 23:50:02.381+00	cultura estrangeira (imigrantes)	type/Integer	\N	t	\N	t	0	8	337	Cultura Estrange Ira (imigrantes)	normal	\N	\N	\N	\N	\N	\N	0
361	2017-11-12 21:38:47.165+00	2017-11-20 23:50:02.385+00	Circo	type/Integer	type/Category	t	\N	t	0	8	337	Circo	normal	\N	\N	2017-11-13 23:50:18.503+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":27724,"avg":13862.0}}}	1
356	2017-11-12 21:38:47.08+00	2017-11-20 23:50:02.388+00	Patrimônio Imaterial	type/Integer	type/Category	t	\N	t	0	8	337	Patrimônio I Material	normal	\N	\N	2017-11-12 22:50:12.266+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":11028,"avg":7352.0}}}	1
419	2017-11-12 21:38:48.241+00	2017-11-20 23:50:02.391+00	televisão	type/Integer	\N	t	\N	t	0	8	337	Televisão	normal	\N	\N	\N	\N	\N	\N	0
353	2017-11-12 21:38:47.022+00	2017-11-20 23:50:02.395+00	produção cultural	type/Integer	type/Category	t	\N	t	0	8	337	Produção Cultural	normal	\N	\N	2017-11-12 22:50:12.266+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":38746,"avg":25830.666666666668}}}	1
462	2017-11-12 21:38:48.835+00	2017-11-20 23:50:02.399+00	patrimônio material	type/Integer	\N	t	\N	t	0	8	337	Patrimônio Material	normal	\N	\N	\N	\N	\N	\N	0
474	2017-11-12 21:38:49.002+00	2017-11-20 23:50:02.425+00	_create_date	type/Text	type/Category	t	\N	t	0	8	\N	Create Date	normal	\N	\N	2017-11-12 23:50:09.691+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":3.6666666666666665}}}	1
477	2017-11-12 21:38:50.763+00	2017-11-20 23:50:02.436+00	_create_date	type/Text	type/Category	t	\N	t	0	9	\N	Create Date	normal	\N	\N	2017-11-12 21:39:00.716+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":26.0}}}	1
610	2017-11-19 17:54:28.001+00	2017-11-20 23:50:07.336+00	_instance	type/Text	type/Category	t	\N	t	0	20	\N	Instance	normal	\N	\N	2017-11-20 23:50:07.342+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":23.9246}}}	1
605	2017-11-19 17:54:25.328+00	2017-11-20 23:50:05.719+00	_date	type/DateTime	\N	t	\N	t	0	18	\N	Date	normal	\N	\N	2017-11-20 23:50:06.24+00	\N	\N	{"global":{"distinct-count":757}}	1
617	2017-11-20 23:00:05.826+00	2017-11-20 23:50:03.895+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	22	\N	ID	normal	\N	\N	2017-11-20 23:50:04.244+00	\N	\N	{"global":{"distinct-count":3796}}	1
336	2017-11-12 21:38:46.613+00	2017-11-20 23:50:02.039+00	_total_agents	type/Integer	type/Category	t	\N	t	0	8	\N	Total Agents	normal	\N	\N	2017-11-14 13:50:12.196+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":38756,"avg":25837.333333333332}}}	1
472	2017-11-12 21:38:48.973+00	2017-11-20 23:50:02.041+00	_total_collective_agent	type/Integer	type/Category	t	\N	t	0	8	\N	Total Collective Agent	normal	\N	\N	2017-11-13 23:50:18.503+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":38754,"avg":19377.0}}}	1
475	2017-11-12 21:38:49.015+00	2017-11-20 23:50:02.044+00	_total_individual_agent	type/Integer	type/Category	t	\N	t	0	8	\N	Total Individual Agent	normal	\N	\N	2017-11-13 23:50:18.503+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":11030,"avg":5515.0}}}	1
331	2017-11-12 21:38:45.708+00	2017-11-20 23:50:01.405+00	12	type/Integer	\N	t	\N	t	0	7	322	12	normal	\N	\N	\N	\N	\N	\N	0
285	2017-11-12 21:38:44.941+00	2017-11-20 23:50:01.436+00	04	type/Integer	\N	t	\N	t	0	7	275	04	normal	\N	\N	\N	\N	\N	\N	0
623	2017-11-20 23:41:06.518+00	2017-11-20 23:50:04.584+00	_instance	type/Text	type/Category	t	\N	t	0	23	\N	Instance	normal	\N	\N	2017-11-20 23:50:04.591+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":23.0}}}	1
625	2017-11-20 23:41:06.536+00	2017-11-20 23:50:04.617+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	24	\N	ID	normal	\N	\N	2017-11-20 23:50:04.627+00	\N	\N	{"global":{"distinct-count":2}}	1
624	2017-11-20 23:41:06.532+00	2017-11-20 23:50:04.624+00	_create_date	type/Text	type/Category	t	\N	t	0	24	\N	Create Date	normal	\N	\N	2017-11-20 23:50:04.627+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":26.0}}}	1
630	2017-11-20 23:41:06.814+00	2017-11-20 23:50:04.898+00	_date	type/DateTime	\N	t	\N	t	0	25	\N	Date	normal	\N	\N	2017-11-20 23:50:05.415+00	\N	\N	{"global":{"distinct-count":312}}	1
366	2017-11-12 21:38:47.219+00	2017-11-20 23:50:02.417+00	Cultura Estrangeira (imigrantes)	type/Integer	\N	t	\N	t	0	8	337	Cultura Estrange Ira (imigrantes)	normal	\N	\N	\N	\N	\N	\N	0
338	2017-11-12 21:38:46.645+00	2017-11-20 23:50:02.42+00	gastronomia	type/Integer	\N	t	\N	t	0	8	337	Gas Trono Mia	normal	\N	\N	\N	\N	\N	\N	0
433	2017-11-12 21:38:48.46+00	2017-11-20 23:50:02.423+00	Arquitetura-Urbanismo	type/Integer	\N	t	\N	t	0	8	337	Ar Quite Tura Urbanism O	normal	\N	\N	\N	\N	\N	\N	0
473	2017-11-12 21:38:48.991+00	2017-11-20 23:50:02.428+00	_cls	type/Text	type/Category	t	\N	t	0	8	\N	Cls	normal	\N	\N	2017-11-12 23:50:09.691+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":3.6666666666666665}}}	1
498	2017-11-12 23:36:13.463+00	2017-11-20 23:50:03.149+00	_space_type	type/Text	type/Category	t	\N	t	0	12	\N	Space Type	normal	\N	\N	2017-11-12 23:50:11.918+00	\N	\N	{"global":{"distinct-count":70},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":17.4366}}}	1
622	2017-11-20 23:41:06.514+00	2017-11-20 23:50:04.472+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	23	\N	ID	normal	\N	\N	2017-11-20 23:50:04.591+00	\N	\N	{"global":{"distinct-count":5141}}	1
611	2017-11-20 23:00:05.486+00	2017-11-20 23:50:03.241+00	_create_date	type/Text	type/Category	t	\N	t	0	21	\N	Create Date	normal	\N	\N	2017-11-20 23:50:03.245+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":26.0}}}	1
612	2017-11-20 23:00:05.501+00	2017-11-20 23:50:03.224+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	21	\N	ID	normal	\N	\N	2017-11-20 23:50:03.245+00	\N	\N	{"global":{"distinct-count":2}}	1
621	2017-11-20 23:41:06.508+00	2017-11-20 23:50:04.588+00	_area	type/Text	type/Category	t	\N	t	0	23	\N	Area	normal	\N	\N	2017-11-20 23:50:04.591+00	\N	\N	{"global":{"distinct-count":61},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":9.78603384555534}}}	1
598	2017-11-18 01:13:58.407+00	2017-11-20 23:50:01.295+00	_instance	type/Text	type/Category	t	\N	t	0	16	\N	Instance	normal	\N	\N	2017-11-18 01:50:03.075+00	\N	\N	{"global":{"distinct-count":3},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":22.80446073938283}}}	1
597	2017-11-18 01:13:58.401+00	2017-11-20 23:50:01.297+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	16	\N	ID	normal	\N	\N	2017-11-18 01:50:03.075+00	\N	\N	{"global":{"distinct-count":3273}}	1
596	2017-11-18 01:13:58.395+00	2017-11-20 23:50:01.3+00	_project_type	type/Text	type/Category	t	\N	t	0	16	\N	Project Type	normal	\N	\N	2017-11-18 01:50:03.075+00	\N	\N	{"global":{"distinct-count":31},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.45096241979835}}}	1
324	2017-11-12 21:38:45.603+00	2017-11-20 23:50:01.407+00	06	type/Integer	\N	t	\N	t	0	7	322	06	normal	\N	\N	\N	\N	\N	\N	0
283	2017-11-12 21:38:44.918+00	2017-11-20 23:50:01.442+00	10	type/Integer	\N	t	\N	t	0	7	275	10	normal	\N	\N	\N	\N	\N	\N	0
284	2017-11-12 21:38:44.928+00	2017-11-20 23:50:01.448+00	12	type/Integer	\N	t	\N	t	0	7	275	12	normal	\N	\N	\N	\N	\N	\N	0
306	2017-11-12 21:38:45.249+00	2017-11-20 23:50:01.557+00	12	type/Integer	\N	t	\N	t	0	7	297	12	normal	\N	\N	\N	\N	\N	\N	0
308	2017-11-12 21:38:45.271+00	2017-11-20 23:50:01.561+00	01	type/Integer	type/Category	t	\N	t	0	7	297	01	normal	\N	\N	2017-11-12 21:38:59.409+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":315,"avg":210.0}}}	1
350	2017-11-12 21:38:46.878+00	2017-11-20 23:50:02.403+00	patrimônio imaterial	type/Integer	\N	t	\N	t	0	8	337	Patrimônio I Material	normal	\N	\N	\N	\N	\N	\N	0
409	2017-11-12 21:38:48.055+00	2017-11-20 23:50:02.405+00	Patrimônio Material	type/Integer	\N	t	\N	t	0	8	337	Patrimônio Material	normal	\N	\N	\N	\N	\N	\N	0
468	2017-11-12 21:38:48.902+00	2017-11-20 23:50:02.408+00	cultura cigana	type/Integer	\N	t	\N	t	0	8	337	Cultura Cig An A	normal	\N	\N	\N	\N	\N	\N	0
629	2017-11-20 23:41:06.81+00	2017-11-20 23:50:05.404+00	_instance	type/Text	type/Category	t	\N	t	0	25	\N	Instance	normal	\N	\N	2017-11-20 23:50:05.415+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":23.0}}}	1
615	2017-11-20 23:00:05.816+00	2017-11-20 23:50:04.238+00	_public_archive	type/Text	type/Category	t	\N	t	0	22	\N	Public Archive	normal	\N	\N	2017-11-20 23:50:04.244+00	\N	\N	{"global":{"distinct-count":3},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":3.05927291886196}}}	1
618	2017-11-20 23:00:05.831+00	2017-11-20 23:50:04.231+00	_museum_type	type/Text	type/Category	t	\N	t	0	22	\N	Museum Type	normal	\N	\N	2017-11-20 23:50:04.244+00	\N	\N	{"global":{"distinct-count":7},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":10.303477344573235}}}	1
613	2017-11-20 23:00:05.804+00	2017-11-20 23:50:04.223+00	_thematic	type/Text	type/Category	t	\N	t	0	22	\N	Thematic	normal	\N	\N	2017-11-20 23:50:04.244+00	\N	\N	{"global":{"distinct-count":10},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":8.754741833508957}}}	1
619	2017-11-20 23:00:05.837+00	2017-11-20 23:50:04.227+00	_instance	type/Text	type/Category	t	\N	t	0	22	\N	Instance	normal	\N	\N	2017-11-20 23:50:04.244+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":18.0}}}	1
620	2017-11-20 23:00:05.841+00	2017-11-20 23:50:03.787+00	_date	type/DateTime	\N	t	\N	t	0	22	\N	Date	normal	\N	\N	2017-11-20 23:50:04.244+00	\N	\N	{"global":{"distinct-count":194}}	1
616	2017-11-20 23:00:05.821+00	2017-11-20 23:50:04.234+00	_guided_tuor	type/Text	type/Category	t	\N	t	0	22	\N	Guided Tu Or	normal	\N	\N	2017-11-20 23:50:04.244+00	\N	\N	{"global":{"distinct-count":3},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":3.0508429926238145}}}	1
628	2017-11-20 23:41:06.806+00	2017-11-20 23:50:05.078+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	25	\N	ID	normal	\N	\N	2017-11-20 23:50:05.415+00	\N	\N	{"global":{"distinct-count":7178}}	1
382	2017-11-12 21:38:47.486+00	2017-11-20 23:50:02.412+00	Arte de Rua	type/Integer	\N	t	\N	t	0	8	337	Arte De Rua	normal	\N	\N	\N	\N	\N	\N	0
627	2017-11-20 23:41:06.802+00	2017-11-20 23:50:05.408+00	_sphere_type	type/Text	type/Category	t	\N	t	0	25	\N	Sphere Type	normal	\N	\N	2017-11-20 23:50:05.415+00	\N	\N	{"global":{"distinct-count":13},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":8.354137642797436}}}	1
626	2017-11-20 23:41:06.797+00	2017-11-20 23:50:05.412+00	_sphere	type/Text	type/Category	t	\N	t	0	25	\N	Sphere	normal	\N	\N	2017-11-20 23:50:05.415+00	\N	\N	{"global":{"distinct-count":3},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":4.201030927835052}}}	1
604	2017-11-19 17:54:25.322+00	2017-11-20 23:50:06.234+00	_instance	type/Text	type/Category	t	\N	t	0	18	\N	Instance	normal	\N	\N	2017-11-20 23:50:06.24+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":24.7148}}}	1
602	2017-11-19 17:54:25.306+00	2017-11-20 23:50:06.238+00	_age_rage	type/Text	type/Category	t	\N	t	0	18	\N	Age Rage	normal	\N	\N	2017-11-20 23:50:06.24+00	\N	\N	{"global":{"distinct-count":7},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.3429}}}	1
609	2017-11-19 17:54:27.996+00	2017-11-20 23:50:07.126+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	20	\N	ID	normal	\N	\N	2017-11-20 23:50:07.342+00	\N	\N	{"global":{"distinct-count":10000}}	1
608	2017-11-19 17:54:27.978+00	2017-11-20 23:50:07.34+00	_language	type/Text	type/Category	t	\N	t	0	20	\N	Language	normal	\N	\N	2017-11-20 23:50:07.342+00	\N	\N	{"global":{"distinct-count":19},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":12.9404}}}	1
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
47	2017-11-14 06:14:04.871+00	2017-11-14 06:14:04.871+00	[null,null]	\N	507
32	2017-11-12 23:37:26.842+00	2017-11-14 06:14:05.198+00	[null,null]	\N	122
48	2017-11-14 06:14:05.231+00	2017-11-14 06:14:05.231+00	[null,null]	\N	131
33	2017-11-12 23:37:26.891+00	2017-11-14 06:14:05.275+00	[null,null]	\N	55
49	2017-11-14 06:14:05.315+00	2017-11-14 06:14:05.315+00	[null,null]	\N	61
31	2017-11-12 23:37:26.787+00	2017-11-14 06:14:05.353+00	[null,null]	\N	263
30	2017-11-12 23:37:26.742+00	2017-11-14 06:14:05.404+00	[null,null]	\N	215
50	2017-11-14 06:14:05.458+00	2017-11-14 06:14:05.458+00	[null,null]	\N	42
51	2017-11-14 06:14:05.499+00	2017-11-14 06:14:05.499+00	[null,null]	\N	90
60	2017-11-14 06:14:06.499+00	2017-11-14 06:14:06.499+00	[null]	\N	497
38	2017-11-12 23:37:27.383+00	2017-11-19 17:54:26.658+00	[null]	\N	435
42	2017-11-12 23:37:27.594+00	2017-11-19 17:54:26.829+00	[null,0]	\N	482
58	2017-11-14 06:14:06.415+00	2017-11-19 17:54:26.86+00	[null,null]	\N	490
44	2017-11-12 23:37:27.653+00	2017-11-19 17:54:26.888+00	[0]	\N	485
45	2017-11-12 23:37:27.699+00	2017-11-19 17:54:26.919+00	[null,null]	\N	488
46	2017-11-12 23:37:27.73+00	2017-11-19 17:54:26.949+00	[null,0]	\N	483
59	2017-11-14 06:14:06.439+00	2017-11-19 17:54:26.986+00	[null,null]	\N	481
43	2017-11-12 23:37:27.629+00	2017-11-19 17:54:27.027+00	["PercentLibraries.PercentLibrariesTypeSphere","PercentLibraries.PercentLibraryPerAreaOfActivity","PercentLibraries.PercentPublicOrPrivateLibrary","PercentLibraries.QuantityOfRegisteredlibraries"]	\N	484
63	2017-11-14 06:14:06.727+00	2017-11-14 06:14:06.727+00	[null,null]	\N	569
64	2017-11-14 06:14:06.766+00	2017-11-14 06:14:06.766+00	["2012-01-01 15:47:38.337553","2017-11-14 06:12:01.892804"]	\N	590
57	2017-11-14 06:14:06.175+00	2017-11-20 23:41:05.732+00	[null,0,4655]	\N	472
52	2017-11-14 06:14:05.668+00	2017-11-20 23:41:05.749+00	[null,0,24537]	\N	475
56	2017-11-14 06:14:06.148+00	2017-11-20 23:41:05.779+00	[null,null]	\N	361
39	2017-11-12 23:37:27.45+00	2017-11-20 23:41:05.795+00	[null,null]	\N	356
40	2017-11-12 23:37:27.527+00	2017-11-20 23:41:05.822+00	[null]	\N	353
54	2017-11-14 06:14:06.059+00	2017-11-20 23:41:05.85+00	["PercentAgents.PercentAgentsPerAreaOperation","PercentAgents.PercentIndividualAndCollectiveAgent"]	\N	473
41	2017-11-12 23:37:27.559+00	2017-11-20 23:41:05.871+00	["2012-01-01 00:00:00.000000","2017-11-20 22:50:50.034824"]	\N	477
61	2017-11-14 06:14:06.568+00	2017-11-20 23:41:05.995+00	["mapaculturacegovbr","mapasculturagovbr","spculturaprefeituraspgovbr"]	\N	500
34	2017-11-12 23:37:27.002+00	2017-11-20 23:41:05.444+00	[0,318]	\N	308
35	2017-11-12 23:37:27.044+00	2017-11-20 23:41:05.65+00	[null]	\N	360
36	2017-11-12 23:37:27.116+00	2017-11-20 23:41:05.669+00	[null,null]	\N	438
55	2017-11-14 06:14:06.085+00	2017-11-20 23:41:05.687+00	[null]	\N	357
37	2017-11-12 23:37:27.298+00	2017-11-20 23:41:05.707+00	[null,null]	\N	434
72	2017-11-19 17:54:27.008+00	2017-11-19 17:54:27.008+00	[null,0]	\N	491
65	2017-11-19 17:54:25.571+00	2017-11-20 23:41:05.303+00	["mapaculturacegovbr","mapasculturagovbr","spculturaprefeituraspgovbr"]	\N	598
66	2017-11-19 17:54:25.649+00	2017-11-20 23:41:05.335+00	["Ciclo","Concurso","Conferência Pública Estadual","Conferência Pública Municipal","Conferência Pública Nacional","Convenção","Curso","Edital","Encontro","Exibição","Exposição","Feira","Festa Popular","Festa Religiosa","Festival","Fórum","Inscrições","Intercâmbio Cultural","Jornada","Mostra","Oficina","Palestra","Parada e Desfile Cívico","Parada e Desfile Festivo","Parada e Desfile de Ações Afirmativas","Pesquisa","Programa","Reunião","Sarau","Seminário","Simpósio"]	\N	596
67	2017-11-19 17:54:25.693+00	2017-11-20 23:41:05.363+00	["False","True"]	\N	595
68	2017-11-19 17:54:25.735+00	2017-11-20 23:41:05.388+00	["2012-01-01 15:47:38.337553","2017-11-20 22:50:05.934185"]	\N	600
69	2017-11-19 17:54:26.009+00	2017-11-20 23:41:05.516+00	["Antropologia","Arqueologia","Arquitetura-Urbanismo","Arquivo","Arte Digital","Arte de Rua","Artes Visuais","Artesanato","Audiovisual","Banda","Biblioteca","Capoeira","Carnaval","Cinema","Circo","Ciência Política","Comunicação","Coral","Cultura Cigana","Cultura Digital","Cultura Estrangeira (imigrantes)","Cultura Indígena","Cultura LGBT","Cultura Negra","Cultura Popular","Dança","Design","Direito Autoral","Economia Criativa","Educação","Esporte","Filosofia","Fotografia","Gastronomia","Gestor Publico de Cultura","Gestão Cultural","História","Humor","Jogos Eletrônicos","Jornalismo","Leitura","Literatura","Livro","Meio Ambiente","Moda","Museu","Mídias Sociais","Música","Novas Mídias","Opera","Orquestra","Outros","Patrimônio Imaterial","Patrimônio Material","Pesquisa","Produção Cultural","Rádio","Saúde","Sociologia","Teatro","Televisão","Turismo","acervos museológicos","agente cultura viva","arquivo","arte de rua","artes visuais","artistas agentes culturais","cultura popular"]	\N	592
70	2017-11-19 17:54:26.119+00	2017-11-20 23:41:05.614+00	["mapaculturacegovbr","mapasculturagovbr","spculturaprefeituraspgovbr"]	\N	594
71	2017-11-19 17:54:26.55+00	2017-11-20 23:41:05.721+00	[0,29192]	\N	336
53	2017-11-14 06:14:06.039+00	2017-11-20 23:41:05.835+00	["2012-01-01 00:00:00.000000","2017-11-20 22:50:41.884470","2017-11-20 22:50:53.226614"]	\N	474
62	2017-11-14 06:14:06.664+00	2017-11-20 23:41:05.931+00	["Antiquário","Arquivo Privado","Arquivo Público","Ateliê","Audioteca","Banca de jornal","Bem Arqueológico","Bem Imóvel","Bem Móvel ou Integrado","Bem Paisagístico","Bens culturais de natureza imaterial","Bens culturais de natureza material","Biblioteca Comunitária (incluí­dos os pontos de leitura)","Biblioteca Escolar","Biblioteca Especializada","Biblioteca Nacional","Biblioteca Privada","Biblioteca Pública","Biblioteca Universitária","Casa de espetáculo","Casa do Patrimônio","Centro Comunitário","Centro Cultural Privado","Centro Cultural Público","Centro Espírita","Centro cultural itinerante","Centro de Artes e Esportes Unificados - CEUs","Centro de Documentação Privado","Centro de Documentação Público","Centro de artesanato","Centro de tradições","Cine itinerante","Cineclube","Circo Fixo","Circo Itinerante","Circo Tradicional","Clube social","Coleções","Concha acústica","Coreto","Creative Bureau","Danceteria","Documentação","Escola livre de Artes Cênicas","Escola livre de Artes Visuais","Escola livre de Audiovisual","Escola livre de Cultura Digital","Escola livre de Cultura Popular","Escola livre de Design","Escola livre de Gestão Cultural","Escola livre de Hip Hop","Escola livre de Música","Escola livre de Patrimônio","Escola livre de Pontinhos de cultura","Espaço Mais Cultura","Espaço Público Para Projeção de Filmes","Espaço para Eventos","Espaço para apresentação de dança","Estúdio","Galeria de arte","Ginásio Poliesportivo","Igreja","Instituição Privada Comunitária","Instituição Privada Comunitária exclusivamente voltada para formação artistica e cultural","Instituição Privada Confessional","Instituição Privada Confessional exclusivamente voltada para formação artistica e cultural","Instituição Privada Filantrópica","Instituição Privada Filantrópica exclusivamente voltada para formação artistica e cultural","Instituição Privada Particular","Instituição Privada Particular exclusivamente voltada para formação artistica e cultural","Instituição Pública Distrital exclusivamente voltada para formação artistica e cultural","Instituição Pública Estadual exclusivamente voltada para formação artistica e cultural","Instituição Pública Federal exclusivamente voltada para formação artistica e cultural","Instituição Pública Municipal exclusivamente voltada para formação artistica e cultural","Instituição Pública de Ensino Regular Distrital","Instituição Pública de Ensino Regular Estadual","Instituição Pública de Ensino Regular Federal","Instituição Pública de Ensino Regular Municipal","Lan-house","Livraria","Mesquitas","Museu Privado","Museu Público","Outros","Outros Equipamentos Culturais","Palco de Rua","Ponto de Cultura","Ponto de Leitura Afro","Pontos de Memória","Praça dos esportes e da cultura","Rádio Comunitária","Sala Multiuso","Sala de Leitura","Sala de cinema","Sala de dança","Sebo","Sitio Histórico","Teatro Privado","Teatro Público","Templo","Terreiro","Terreno para Circo","Trio elétrico","Usina Cultural","Videolocadora"]	\N	498
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
13	2017-11-12 23:37:27.205+00	2017-11-14 13:50:09.447+00	percent_museums	10	\N	\N	\N	f	2	Percent Museums	\N	\N	\N	\N	\N	f
5	2017-11-12 21:38:37.009+00	2017-11-14 13:50:10.355+00	percent_projects	6	\N	\N	\N	f	2	Percent Projects	\N	\N	\N	\N	\N	f
14	2017-11-13 23:50:00.364+00	2017-11-14 13:50:12.489+00	amount_museums_registered_year	2	\N	\N	\N	f	2	Amount Museums Registered Year	\N	\N	\N	\N	\N	f
11	2017-11-12 21:38:37.155+00	2017-11-18 02:50:03.396+00	percent_event	6	\N	\N	\N	f	2	Percent Event	\N	\N	\N	\N	\N	f
21	2017-11-20 23:00:05.458+00	2017-11-20 23:50:03.187+00	last_update_museum_date	2	\N	\N	\N	t	2	Last Update Museum Date	\N	\N	\N	\N	\N	f
22	2017-11-20 23:00:05.471+00	2017-11-20 23:50:03.259+00	museum_data	3796	\N	\N	\N	t	2	Museum Data	\N	\N	\N	\N	\N	f
23	2017-11-20 23:41:06.025+00	2017-11-20 23:50:04.255+00	library_area	5141	\N	\N	\N	t	2	Library Area	\N	\N	\N	\N	\N	f
24	2017-11-20 23:41:06.031+00	2017-11-20 23:50:04.604+00	last_update_library_date	2	\N	\N	\N	t	2	Last Update Library Date	\N	\N	\N	\N	\N	f
10	2017-11-12 21:38:37.145+00	2017-11-19 17:54:24.599+00	percent_libraries	4	\N	\N	\N	f	2	Percent Libraries	\N	\N	\N	\N	\N	f
25	2017-11-20 23:41:06.038+00	2017-11-20 23:50:04.638+00	library_data	7178	\N	\N	\N	t	2	Library Data	\N	\N	\N	\N	\N	f
18	2017-11-19 17:54:15.822+00	2017-11-20 23:50:05.431+00	event_data	21573	\N	\N	\N	t	2	Event Data	\N	\N	\N	\N	\N	f
16	2017-11-18 01:13:49.852+00	2017-11-20 23:50:06.25+00	project_data	3281	\N	\N	\N	t	2	Project Data	\N	\N	\N	\N	\N	f
19	2017-11-19 17:54:15.839+00	2017-11-20 23:50:06.261+00	last_update_event_date	2	\N	\N	\N	t	2	Last Update Event Date	\N	\N	\N	\N	\N	f
17	2017-11-18 01:13:49.861+00	2017-11-20 23:50:06.289+00	last_update_project_date	2	\N	\N	\N	t	2	Last Update Project Date	\N	\N	\N	\N	\N	f
7	2017-11-12 21:38:37.093+00	2017-11-20 23:50:06.301+00	amount_agents_registered_per_month	3	\N	\N	\N	t	2	Amount Agents Registered Per Month	\N	\N	\N	\N	\N	f
15	2017-11-14 06:14:04.121+00	2017-11-20 23:50:06.473+00	occupation_area	30115	\N	\N	\N	t	2	Occupation Area	\N	\N	\N	\N	\N	f
8	2017-11-12 21:38:37.113+00	2017-11-20 23:50:06.498+00	percent_agents	6	\N	\N	\N	t	2	Percent Agents	\N	\N	\N	\N	\N	f
9	2017-11-12 21:38:37.126+00	2017-11-20 23:50:06.657+00	last_update_date	2	\N	\N	\N	t	2	Last Update Date	\N	\N	\N	\N	\N	f
20	2017-11-19 17:54:15.848+00	2017-11-20 23:50:06.678+00	event_language	27032	\N	\N	\N	t	2	Event Language	\N	\N	\N	\N	\N	f
12	2017-11-12 23:34:53.741+00	2017-11-20 23:50:07.356+00	space_data	19967	\N	\N	\N	t	2	Space Data	\N	\N	\N	\N	\N	f
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
\\x3eabb3700168d7d0b83264c933df64099e3594d2600eb05ec35d302fa75b6269	331
\\x1952eeb9cffeb4f6fa80e763f00b376d93655f00afff8a78550a2c550984247d	425
\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	280
\\xfd5f2a64561cd4eaadfb0565d03e40770f5882c9b94dd6fb7019fe11dbf29898	97
\\xaf88207ed389ddf2ec7daccb2f096c11e729c561ab59b86b9b0bae7f737c3cab	107
\\x690786c578aa71dbfc39be02bb8000711daa70ec780a85dea55674415b456869	159
\\xdf52930e81201248ac87b273716bcd36685236a820763c0910351a6423f64dd0	157
\\x83bc7a2c3fddc70fa50685b09c203f96fc8ab1e3f9874344cd64c04f561b6180	152
\\x42ab6672810aae8ab9c80a8773f3c9ccd4163abd15ce71c392f0d3bf26e7432a	174
\\xef5bd9ef6a787e726a00f1f31afbcf66a820544b5dbd88a3d3090b8d9667cefc	186
\\x2787f566432a601c9d94e99f64d09057a13693b8ca76e9c670f73c105ee05e84	148
\\x0d6dacd4a22d71ef38c35c9491e56b83c0d72367d6c709bc0110be1078cb12d4	94
\\xa38a092a927dc417d2c0722172e7964b38ad1c069b195b87b09bae385c15a548	243
\\x4e7c893acd5bfde7fcd471e99e3177f9513a2d2fd4169da913d89cb1605c78df	174
\\xe620746dca7282cc9c4b6158121b53b22fb3385ac46fc75c6940a64dbd5ab333	247
\\xe4823303a34368d35b0c8290fc3e5cd7ab7925c3d22f6e489a8e7676e750058e	216
\\x13beb1bf0eed2bbc5de8f6c2f86060c9c3d9abae7a4b0009371e97dbe4480fc0	152
\\x4a6a19c7878b6f238890925b421d0ff96a674dab847cb962f6ed3fc9abab0d86	177
\\xe484be966386b13d08209a8a31952e21d486fcb4a1546f54d764ed9a4ce0fb39	194
\\x5597c7db1e2ac6aba6e4962252b31458acdbfc15a4223c18e78b13351d9f8d10	154
\\xe7ce71c0296b3bed3d1b3ce5c6fe84437f0529e22b6b608b73e89f5fc2e026ae	267
\\xc2ae1a1e2e8be5db1e55f61c039034cb17ca0c1edb6a9ca3e52e5ecf93fc6b9f	127
\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	293
\\x3e0aa390c3145a73d478d4dee6c735f4bd4230c5b1d4d4ea022bde4e9627f8a0	149
\\x03466c05eb29b4f578c57c55e37bb44fc978b08d095f8c4255dd8a7aa80f7510	628
\\xf9dd02dcf34a436ba1f43c19f258bea90c3778738187fe9de7ddb8e617bd74d0	135
\\xcd6c11684675fd9ee2df16501ce78f775d0b4660f671f0e3652eb002a32f76da	113
\\xb8ffca5df3125a1fc0115bbc4b6d25f74b61672ed730d91b397967cd5307f206	135
\\x54e94b9f2a7b6c509ea7455c067fa9c9b3c1da6cad8e418ff92653027f054bfe	81
\\x89cb9ad8bf643497986a3d5582ec59f4b69a653026dacd524b31b29be87a4229	127
\\xcf5fa65ff623d108eb46e643a888d5cb7a593a64af7314b44379bbe7a510e574	159
\\xbc462fc1376ef84c69934f95a21232cf42adf867eaea01c64d05fd4215667f9b	148
\\xcca62bcb9ce629ccb24f725ece5e35030524055a86b66bcc953aba3577ebc9c3	54
\\x6211b1138bac14e5fa2bcfee231d2ef771cfbaf3c6f887897328190dd8ff31cb	156
\\x16e2d7ff11bc2e7d42782f48f0e2396a8b5a768fbc30b8d6e5aaaa10ab8ac394	96
\\xddf69860789b56378e70bb0200b6ad3cfe9dcdb22cc1a67e2806a9d78a172d5b	145
\\x3d017954f202fb414a9c97d85b9aeda04aee29cd7e642a6d9934c3444ef076c7	190
\\x145da31dd998d0d0e86cebcf61f819850b54e1b817610ef0f57af5b3e2cc1171	74
\\x5c7f8a7da7a185bcb6d36485e5ced07d14db9a872f29b08bb9c969ce0a59205b	90
\\x79b9821f976e9b44dcefe483b0b0aac3aeeae51ad963ad7a420c1d2af4258a11	69
\\x6266766110761ffd546a5658d01aa2416f0dfe685509a41988e80dfbff701be4	112
\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	72
\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	84
\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	81
\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	73
\\xd4ed4ac21fda71a4b2231eff9a755b9dead0d0bf27404a27a5dbc10010653ffc	60
\\x9c0228d167203464c42d91efe815d6f17a8be95ddbe03adadcb8617b5a1c4a46	137
\\x23e4321c147245a4d20fb56fd5e3a7c76ed29c2139ae859a90a9a2f04ab731bc	137
\\x496390f2f0b50e2fbfc8c751ba6e74596619323710bdcbbeea173e6d7f0bd10b	90
\\x8945bdcc19389d03a61d4f8ed4b39f90d8c87456afe41af017db088ef52f6028	153
\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	153
\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	134
\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	109
\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	131
\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	314
\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	363
\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	324
\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	309
\\x6b5039481ad1749520b96d2176d5bfbc2b6eba08495cf8054faed42d28658a53	63
\\x1c446c3459dadecb44f60ee7c2138493eadb825ab7ed7d7461513f3d5bfd7185	83
\\xe7a4740534679b9671915c65b50eadd2563f583450724d8b3b902061afa64279	106
\\xb204f11185354b6c0ec52816fc20f7cc5bf1d6d243ec958396bca494fe96a3e6	130
\\xc9c537fffd3a147ff3f39f6ce2e59b24d97bb2467c3818ac5495f6f9e07181d6	111
\\xae104a6053fee2863008c26b825968d22fb42f575f9657358821ac862b87fd2b	115
\\xd124d06e139130090a743e729d1bdf5e57997154ac5afa515a3de80a3a48f6ac	68
\\xec6fcbd015478995fa62dad707519637458ee1b7b9d7dca35aa2784b39b7c518	91
\\xf8ab73da628afbbd148c05f79cda69acc8b423606ecfc38614e2285f065b31c5	98
\\xf429d0082adac3811e2b09eae4f56e1fd5b00b94e25974cd3300caf8fbf69bc5	66
\\x9bec7843a5f94ab47eb40948622b1f8f78b7429885aff8c4e92e72ae5dfa105a	319
\\x490d37dcbc61cde4cabda5f9801f4464045fb2834df78c9a9fb3488c2399b6f9	84
\\xa6e43734a8b76c28bb3723d3475c2427ff139362a5a98c49cc96035ff3f1d29c	105
\\xea15adb9ebf96bf593bb87a25e21c6a4976a7aef779aab72073e95005a5f83e8	100
\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	63
\\x4378f8e359fd2cef7a7968e05f2c7b5aa6155e537a799688097eb1a1844b079c	76
\\x4fa64b3921a5345e56cafded326679d694ff759dc9c14a9c99a091b6ef7b026a	111
\\x619ba579cc2cba9995d467f0c1b5eeceb63896b971c47ee34e6ed4b154eaefa3	92
\\xbd3c80317764415cbb70c03f7e0e90dfc07a01e3e1333ce11ff44575c04a364e	80
\\x2df1c1b99dab5d6c0df61c40a4bc206c6dfad0aa9bb3abebb778075cb7301608	50
\\xf19ab079b9f266aa766b47ddf4b37c76acd4aff757e3e118d5ca627fa49566ee	94
\\x792a044714c63be23038204865243264e18fb8501465b9b23451a2a84ebe4db3	111
\\x3d4b7ca05f18b2de0927bd10138aba99a571e980b545ad1e4ba4e57151a9d8c7	59
\\xe48a2eaa6c8d7695da35bdcaf46e865a3bc1a8d734088e03a888695e2524a0a0	43
\\xa10b50b18a6553118701872a96318522684bf78ab319b585168ef6fb1a59f9c0	76
\\x62e27e4990cc2b7ff87a3330d56cdd634cf8669d2fede6b98363dd360be4de0a	52
\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	45
\\x439520b880e95500549b7ebcda358e9b5c6a2f3c005991646856e318da1a604a	98
\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	98
\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	365
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
259	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:18:20.391	2215	171	f	question	\N	1	2	\N	\N
260	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-13 23:18:20.391	2214	246	f	question	\N	1	7	\N	\N
261	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-13 23:18:20.415	2278	116	f	question	\N	1	3	\N	\N
262	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-13 23:18:20.376	2362	54	f	question	\N	1	4	\N	\N
263	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-13 23:18:20.395	2373	117	f	question	\N	1	6	\N	\N
264	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-13 23:18:36.443	590	54	f	embedded-dashboard	\N	\N	4	1	\N
265	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-13 23:18:36.456	736	256	f	embedded-dashboard	\N	\N	7	1	\N
266	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:18:36.454	776	172	f	embedded-dashboard	\N	\N	2	1	\N
267	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-13 23:18:36.453	775	131	f	embedded-dashboard	\N	\N	3	1	\N
268	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-13 23:18:36.442	823	131	f	embedded-dashboard	\N	\N	6	1	\N
269	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-13 23:19:00.769	403	54	f	embedded-dashboard	\N	\N	4	1	\N
270	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:19:00.767	667	172	f	embedded-dashboard	\N	\N	2	1	\N
271	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-13 23:19:00.871	696	256	f	embedded-dashboard	\N	\N	7	1	\N
272	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-13 23:19:00.846	755	131	f	embedded-dashboard	\N	\N	3	1	\N
273	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-13 23:19:00.869	751	131	f	embedded-dashboard	\N	\N	6	1	\N
274	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:19:35.865	286	172	f	question	\N	1	2	\N	\N
275	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-13 23:19:39.351	550	256	f	question	\N	1	7	\N	\N
276	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-13 23:19:39.353	590	131	f	question	\N	1	3	\N	\N
277	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:19:39.334	835	172	f	question	\N	1	2	\N	\N
278	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-13 23:19:39.348	894	54	f	question	\N	1	4	\N	\N
279	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-13 23:19:39.514	750	131	f	question	\N	1	6	\N	\N
280	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:19:53.285	207	172	f	question	\N	1	2	\N	\N
285	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-13 23:20:02.557	737	131	f	question	\N	1	6	\N	\N
286	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:20:14.886	197	172	f	question	\N	1	2	\N	\N
281	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-13 23:20:02.521	450	54	f	question	\N	1	4	\N	\N
282	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-13 23:20:02.538	620	256	f	question	\N	1	7	\N	\N
283	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:20:02.503	740	172	f	question	\N	1	2	\N	\N
284	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-13 23:20:02.509	765	131	f	question	\N	1	3	\N	\N
287	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-13 23:20:20.56	541	256	f	question	\N	1	7	\N	\N
288	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-13 23:20:20.56	666	131	f	question	\N	1	6	\N	\N
289	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:20:20.545	675	172	f	question	\N	1	2	\N	\N
290	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-13 23:20:20.558	720	54	f	question	\N	1	4	\N	\N
291	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-13 23:20:20.557	723	131	f	question	\N	1	3	\N	\N
292	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:20:32.343	215	172	f	question	\N	1	2	\N	\N
293	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:21:29.888	235	172	f	question	\N	1	2	\N	\N
294	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:21:35.656	364	172	f	question	\N	1	2	\N	\N
295	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-13 23:21:35.879	419	256	f	question	\N	1	7	\N	\N
296	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-13 23:21:35.688	660	131	f	question	\N	1	6	\N	\N
297	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-13 23:21:35.671	710	54	f	question	\N	1	4	\N	\N
298	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-13 23:21:35.654	749	131	f	question	\N	1	3	\N	\N
299	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-13 23:22:03.021	511	131	f	question	\N	1	6	\N	\N
300	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-13 23:22:03.052	545	256	f	question	\N	1	7	\N	\N
301	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-13 23:22:03.042	570	54	f	question	\N	1	4	\N	\N
302	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:22:03.021	614	172	f	question	\N	1	2	\N	\N
303	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-13 23:22:03.021	705	131	f	question	\N	1	3	\N	\N
304	\\x1952eeb9cffeb4f6fa80e763f00b376d93655f00afff8a78550a2c550984247d	2017-11-13 23:24:47.755	1244	200	f	embedded-question	\N	\N	1	\N	\N
305	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:25:08.679	294	172	f	embedded-question	\N	\N	2	\N	\N
306	\\x1952eeb9cffeb4f6fa80e763f00b376d93655f00afff8a78550a2c550984247d	2017-11-13 23:32:19.299	128	200	f	embedded-question	\N	\N	1	\N	\N
307	\\x1952eeb9cffeb4f6fa80e763f00b376d93655f00afff8a78550a2c550984247d	2017-11-13 23:32:24.986	55	200	f	embedded-question	\N	\N	1	\N	\N
308	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:32:34.709	244	172	f	embedded-question	\N	\N	2	\N	\N
309	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:35:34.935	256	172	f	embedded-question	\N	\N	2	\N	\N
310	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:37:01.056	229	172	f	embedded-question	\N	\N	2	\N	\N
311	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:37:32.896	259	172	f	embedded-question	\N	\N	2	\N	\N
312	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:39:10.175	230	172	f	embedded-question	\N	\N	2	\N	\N
313	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:39:40.937	194	172	f	embedded-question	\N	\N	2	\N	\N
314	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:44:08.725	229	172	f	embedded-question	\N	\N	2	\N	\N
315	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:47:18.798	195	172	f	embedded-question	\N	\N	2	\N	\N
316	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:56:43.846	207	172	f	embedded-question	\N	\N	2	\N	\N
317	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:56:44.111	174	172	f	embedded-question	\N	\N	2	\N	\N
318	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:56:57.541	202	172	f	embedded-question	\N	\N	2	\N	\N
319	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:56:57.805	186	172	f	embedded-question	\N	\N	2	\N	\N
320	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:58:18.128	194	172	f	embedded-question	\N	\N	2	\N	\N
321	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:58:18.442	177	172	f	embedded-question	\N	\N	2	\N	\N
322	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:58:55.452	196	172	f	embedded-question	\N	\N	2	\N	\N
323	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-13 23:58:55.7	193	172	f	embedded-question	\N	\N	2	\N	\N
324	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:03:21.224	215	172	f	embedded-question	\N	\N	2	\N	\N
325	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:03:21.491	203	172	f	embedded-question	\N	\N	2	\N	\N
326	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:05:42.45	200	172	f	embedded-question	\N	\N	2	\N	\N
327	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:05:42.708	205	172	f	embedded-question	\N	\N	2	\N	\N
328	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:08:46.388	202	172	f	embedded-question	\N	\N	2	\N	\N
329	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:08:46.677	165	172	f	embedded-question	\N	\N	2	\N	\N
330	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:09:18.405	213	172	f	embedded-question	\N	\N	2	\N	\N
331	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:09:18.69	153	172	f	embedded-question	\N	\N	2	\N	\N
332	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:11:37.842	249	172	f	embedded-question	\N	\N	2	\N	\N
333	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:11:38.17	170	172	f	embedded-question	\N	\N	2	\N	\N
334	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:11:58.403	215	172	f	embedded-question	\N	\N	2	\N	\N
335	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:11:58.699	143	172	f	embedded-question	\N	\N	2	\N	\N
336	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:15:58.843	213	172	f	embedded-question	\N	\N	2	\N	\N
337	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:15:59.103	187	172	f	embedded-question	\N	\N	2	\N	\N
338	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:16:37.771	181	172	f	embedded-question	\N	\N	2	\N	\N
339	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:16:38.012	245	172	f	embedded-question	\N	\N	2	\N	\N
340	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:18:23.897	220	172	f	embedded-question	\N	\N	2	\N	\N
341	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:18:35.11	222	172	f	embedded-question	\N	\N	2	\N	\N
342	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:18:54.141	453	172	f	question	\N	1	2	\N	\N
343	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 00:18:54.15	466	131	f	question	\N	1	3	\N	\N
344	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 00:18:54.169	499	256	f	question	\N	1	7	\N	\N
345	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 00:18:54.147	539	54	f	question	\N	1	4	\N	\N
346	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 00:18:54.158	602	131	f	question	\N	1	6	\N	\N
347	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 00:19:00.426	178	54	f	question	\N	1	4	\N	\N
348	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:19:36.643	274	172	f	embedded-question	\N	\N	2	\N	\N
349	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 00:20:00.476	197	54	f	embedded-question	\N	\N	4	\N	\N
350	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:20:00.549	212	172	f	embedded-question	\N	\N	2	\N	\N
351	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 00:22:48.293	206	54	f	embedded-question	\N	\N	4	\N	\N
352	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:22:48.376	249	172	f	embedded-question	\N	\N	2	\N	\N
353	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:23:39.095	222	172	f	embedded-question	\N	\N	2	\N	\N
354	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 00:23:39.402	155	54	f	embedded-question	\N	\N	4	\N	\N
355	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 00:23:53.89	194	54	f	question	\N	1	4	\N	\N
356	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:23:58.099	453	172	f	question	\N	1	2	\N	\N
357	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 00:23:58.206	348	256	f	question	\N	1	7	\N	\N
358	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 00:23:58.154	420	54	f	question	\N	1	4	\N	\N
359	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 00:23:58.106	572	131	f	question	\N	1	6	\N	\N
360	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 00:23:58.101	633	131	f	question	\N	1	3	\N	\N
361	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 00:24:02.873	195	131	f	question	\N	1	3	\N	\N
362	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 00:24:38.979	236	131	f	question	\N	1	3	\N	\N
363	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:24:43.087	371	172	f	question	\N	1	2	\N	\N
364	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 00:24:43.147	449	54	f	question	\N	1	4	\N	\N
365	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 00:24:43.166	480	256	f	question	\N	1	7	\N	\N
368	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 00:24:46.274	200	131	f	question	\N	1	6	\N	\N
366	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 00:24:43.17	518	131	f	question	\N	1	3	\N	\N
367	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 00:24:43.149	557	131	f	question	\N	1	6	\N	\N
369	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 00:25:14.384	207	131	f	question	\N	1	6	\N	\N
371	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 00:25:17.34	448	54	f	question	\N	1	4	\N	\N
372	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:25:17.336	517	172	f	question	\N	1	2	\N	\N
373	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 00:25:17.417	508	256	f	question	\N	1	7	\N	\N
377	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:25:47.105	272	172	f	embedded-question	\N	\N	2	\N	\N
384	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 00:27:25.907	174	256	f	embedded-question	\N	\N	7	\N	\N
385	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 00:27:26.114	189	131	f	embedded-question	\N	\N	3	\N	\N
386	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 00:27:59.302	218	131	f	embedded-question	\N	\N	6	\N	\N
387	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 00:27:59.588	184	54	f	embedded-question	\N	\N	4	\N	\N
388	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 00:28:00.541	230	131	f	embedded-question	\N	\N	3	\N	\N
389	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:28:01.044	161	172	f	embedded-question	\N	\N	2	\N	\N
390	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 00:28:01.784	206	256	f	embedded-question	\N	\N	7	\N	\N
400	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 00:29:03.09	167	131	f	embedded-question	\N	\N	6	\N	\N
370	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 00:25:17.341	408	131	f	question	\N	1	3	\N	\N
374	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 00:25:17.384	582	131	f	question	\N	1	6	\N	\N
375	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 00:25:23.114	171	256	f	question	\N	1	7	\N	\N
376	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 00:25:46.629	180	54	f	embedded-question	\N	\N	4	\N	\N
378	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 00:25:47.182	226	131	f	embedded-question	\N	\N	3	\N	\N
379	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 00:25:47.51	284	256	f	embedded-question	\N	\N	7	\N	\N
380	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 00:25:47.463	347	131	f	embedded-question	\N	\N	6	\N	\N
381	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:27:24.44	263	172	f	embedded-question	\N	\N	2	\N	\N
382	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 00:27:24.447	254	54	f	embedded-question	\N	\N	4	\N	\N
383	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 00:27:25.159	218	131	f	embedded-question	\N	\N	6	\N	\N
391	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 00:28:57.244	157	256	f	embedded-question	\N	\N	7	\N	\N
392	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 00:28:56.554	624	131	f	embedded-question	\N	\N	3	\N	\N
393	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:28:57.998	229	172	f	embedded-question	\N	\N	2	\N	\N
394	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 00:28:58.104	308	131	f	embedded-question	\N	\N	6	\N	\N
395	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 00:28:58.632	166	54	f	embedded-question	\N	\N	4	\N	\N
396	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 00:29:01.007	197	131	f	embedded-question	\N	\N	3	\N	\N
397	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 00:29:01.215	174	256	f	embedded-question	\N	\N	7	\N	\N
398	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 00:29:02.139	189	172	f	embedded-question	\N	\N	2	\N	\N
399	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 00:29:02.427	192	54	f	embedded-question	\N	\N	4	\N	\N
401	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 06:13:25.394	754	3	f	question	\N	1	2	\N	\N
402	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 06:13:25.426	732	260	f	question	\N	1	7	\N	\N
403	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 06:13:25.407	788	55	f	question	\N	1	4	\N	\N
404	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 06:13:25.433	768	132	f	question	\N	1	6	\N	\N
405	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 06:13:25.373	835	132	f	question	\N	1	3	\N	\N
406	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 06:13:32.132	121	3	f	question	\N	1	2	\N	\N
407	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 06:14:16.131	75	3	f	question	\N	1	2	\N	\N
408	\\x3af79e11629b83e5da24a666e7b741539778aa13d2216ca5f89c3118e93f3c00	2017-11-14 06:15:00.819	370	3	f	question	\N	1	2	\N	\N
409	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-14 06:15:13.583	140	172	f	ad-hoc	\N	1	\N	\N	\N
410	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 06:15:37.244	175	55	f	question	\N	1	4	\N	\N
411	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 06:15:52.638	133	132	f	question	\N	1	6	\N	\N
412	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 06:16:04.265	119	132	f	question	\N	1	3	\N	\N
413	\\x54e94b9f2a7b6c509ea7455c067fa9c9b3c1da6cad8e418ff92653027f054bfe	2017-11-14 06:16:32.075	73	3	f	ad-hoc	\N	1	\N	\N	\N
414	\\xfd5f2a64561cd4eaadfb0565d03e40770f5882c9b94dd6fb7019fe11dbf29898	2017-11-14 06:16:41.438	97	3	f	ad-hoc	\N	1	\N	\N	\N
415	\\xaf88207ed389ddf2ec7daccb2f096c11e729c561ab59b86b9b0bae7f737c3cab	2017-11-14 06:16:47.891	107	260	f	ad-hoc	\N	1	\N	\N	\N
416	\\x16e2d7ff11bc2e7d42782f48f0e2396a8b5a768fbc30b8d6e5aaaa10ab8ac394	2017-11-14 06:17:05.506	83	55	f	ad-hoc	\N	1	\N	\N	\N
417	\\xb8ffca5df3125a1fc0115bbc4b6d25f74b61672ed730d91b397967cd5307f206	2017-11-14 06:17:16.11	132	132	f	ad-hoc	\N	1	\N	\N	\N
418	\\xddf69860789b56378e70bb0200b6ad3cfe9dcdb22cc1a67e2806a9d78a172d5b	2017-11-14 06:17:22.068	145	132	f	ad-hoc	\N	1	\N	\N	\N
419	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 06:17:54.656	144	132	f	embedded-question	\N	\N	3	\N	\N
420	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-14 06:17:54.812	148	172	f	embedded-question	\N	\N	2	\N	\N
421	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 06:17:55.05	131	55	f	embedded-question	\N	\N	4	\N	\N
422	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 06:17:55.19	148	260	f	embedded-question	\N	\N	7	\N	\N
423	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 06:18:44.958	204	55	f	embedded-question	\N	\N	4	\N	\N
424	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 06:18:44.962	247	260	f	embedded-question	\N	\N	7	\N	\N
425	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-14 06:18:44.962	272	172	f	embedded-question	\N	\N	2	\N	\N
426	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 06:18:45.013	272	132	f	embedded-question	\N	\N	3	\N	\N
427	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-14 13:33:11.358	732	172	f	embedded-question	\N	1	2	\N	\N
428	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 13:33:11.363	732	260	f	embedded-question	\N	1	7	\N	\N
429	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 13:33:11.357	945	55	f	embedded-question	\N	1	4	\N	\N
430	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 13:33:11.36	947	132	f	embedded-question	\N	1	3	\N	\N
431	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-14 13:35:26.91	240	172	f	embedded-question	\N	1	2	\N	\N
432	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 13:35:26.897	265	55	f	embedded-question	\N	1	4	\N	\N
433	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 13:35:27.399	188	132	f	embedded-question	\N	1	3	\N	\N
434	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 13:35:27.784	200	260	f	embedded-question	\N	1	7	\N	\N
435	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 13:37:27.373	239	55	f	question	\N	1	4	\N	\N
436	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 13:37:27.377	355	132	f	question	\N	1	3	\N	\N
437	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-14 13:37:27.379	417	172	f	question	\N	1	2	\N	\N
438	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 13:37:27.382	437	132	f	question	\N	1	6	\N	\N
439	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 13:37:27.521	318	260	f	question	\N	1	7	\N	\N
440	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 13:37:55.686	158	132	f	question	\N	1	6	\N	\N
441	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 13:38:07.208	184	132	f	embedded-question	\N	1	6	\N	\N
442	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 13:39:28.18	173	132	f	embedded-question	\N	1	6	\N	\N
443	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-14 13:42:30.066	204	172	f	embedded-question	\N	1	2	\N	\N
444	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 13:42:30.319	138	132	f	embedded-question	\N	1	6	\N	\N
445	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 13:42:31.01	139	132	f	embedded-question	\N	1	3	\N	\N
446	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 13:42:31.688	129	55	f	embedded-question	\N	1	4	\N	\N
447	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 13:42:31.895	139	260	f	embedded-question	\N	1	7	\N	\N
448	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 13:43:21.8	155	260	f	embedded-question	\N	1	7	\N	\N
449	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 13:43:22.082	185	132	f	embedded-question	\N	1	6	\N	\N
450	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-14 13:43:22.017	297	172	f	embedded-question	\N	1	2	\N	\N
451	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 13:43:22.531	131	132	f	embedded-question	\N	1	3	\N	\N
452	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 13:43:22.715	104	55	f	embedded-question	\N	1	4	\N	\N
453	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-14 13:45:04.487	118	172	f	embedded-question	\N	1	2	\N	\N
454	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 13:45:05.092	124	260	f	embedded-question	\N	1	7	\N	\N
455	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 13:45:05.597	162	55	f	embedded-question	\N	1	4	\N	\N
456	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 13:45:05.989	140	132	f	embedded-question	\N	1	6	\N	\N
457	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 13:45:06.483	160	132	f	embedded-question	\N	1	3	\N	\N
458	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 13:45:49.348	109	55	f	embedded-question	\N	1	4	\N	\N
459	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-14 13:45:50.933	156	172	f	embedded-question	\N	1	2	\N	\N
460	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 13:45:51.147	213	260	f	embedded-question	\N	1	7	\N	\N
461	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 13:45:51.147	261	132	f	embedded-question	\N	1	6	\N	\N
462	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 13:45:51.166	246	132	f	embedded-question	\N	1	3	\N	\N
463	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 13:47:10.08	200	132	f	embedded-question	\N	1	3	\N	\N
464	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 13:47:10.851	168	260	f	embedded-question	\N	1	7	\N	\N
465	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 13:47:11.081	197	132	f	embedded-question	\N	1	6	\N	\N
466	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 13:47:11.177	190	55	f	embedded-question	\N	1	4	\N	\N
467	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-14 13:47:11.101	280	172	f	embedded-question	\N	1	2	\N	\N
468	\\x03466c05eb29b4f578c57c55e37bb44fc978b08d095f8c4255dd8a7aa80f7510	2017-11-14 13:49:35.998	628	10000	f	ad-hoc	\N	1	\N	\N	\N
469	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 13:50:15.449	189	132	f	ad-hoc	\N	1	\N	\N	\N
470	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 13:50:29.59	145	132	f	ad-hoc	\N	1	\N	\N	\N
471	\\xb8ffca5df3125a1fc0115bbc4b6d25f74b61672ed730d91b397967cd5307f206	2017-11-14 13:50:42.869	166	132	f	ad-hoc	\N	1	\N	\N	\N
472	\\x16e2d7ff11bc2e7d42782f48f0e2396a8b5a768fbc30b8d6e5aaaa10ab8ac394	2017-11-14 13:51:15.921	124	55	f	ad-hoc	\N	1	\N	\N	\N
473	\\x6211b1138bac14e5fa2bcfee231d2ef771cfbaf3c6f887897328190dd8ff31cb	2017-11-14 13:51:21.958	158	2000	f	ad-hoc	\N	1	\N	\N	\N
474	\\x54e94b9f2a7b6c509ea7455c067fa9c9b3c1da6cad8e418ff92653027f054bfe	2017-11-14 13:51:57.61	129	3	f	ad-hoc	\N	1	\N	\N	\N
475	\\x54e94b9f2a7b6c509ea7455c067fa9c9b3c1da6cad8e418ff92653027f054bfe	2017-11-14 13:52:00.627	95	3	f	ad-hoc	\N	1	\N	\N	\N
476	\\x6211b1138bac14e5fa2bcfee231d2ef771cfbaf3c6f887897328190dd8ff31cb	2017-11-14 13:52:03.608	130	2000	f	ad-hoc	\N	1	\N	\N	\N
477	\\x89cb9ad8bf643497986a3d5582ec59f4b69a653026dacd524b31b29be87a4229	2017-11-14 13:52:15.052	127	2000	f	ad-hoc	\N	1	\N	\N	\N
478	\\x6211b1138bac14e5fa2bcfee231d2ef771cfbaf3c6f887897328190dd8ff31cb	2017-11-14 13:52:38.37	125	2000	f	ad-hoc	\N	1	\N	\N	\N
479	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 13:54:14.077	354	132	f	question	\N	1	3	\N	\N
480	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 13:54:14.121	349	132	f	question	\N	1	6	\N	\N
481	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 13:54:14.079	397	55	f	question	\N	1	4	\N	\N
482	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 13:54:14.134	364	260	f	question	\N	1	7	\N	\N
483	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-14 13:54:14.07	421	172	f	question	\N	1	2	\N	\N
484	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 13:54:16.372	113	55	f	question	\N	1	4	\N	\N
485	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 13:54:29.699	151	55	f	ad-hoc	\N	1	\N	\N	\N
486	\\xcca62bcb9ce629ccb24f725ece5e35030524055a86b66bcc953aba3577ebc9c3	2017-11-14 13:54:33.179	54	1	f	ad-hoc	\N	1	\N	\N	\N
487	\\x6211b1138bac14e5fa2bcfee231d2ef771cfbaf3c6f887897328190dd8ff31cb	2017-11-14 13:54:41.824	193	2000	f	ad-hoc	\N	1	\N	\N	\N
488	\\x16e2d7ff11bc2e7d42782f48f0e2396a8b5a768fbc30b8d6e5aaaa10ab8ac394	2017-11-14 13:54:58.863	178	55	f	ad-hoc	\N	1	\N	\N	\N
489	\\x690786c578aa71dbfc39be02bb8000711daa70ec780a85dea55674415b456869	2017-11-14 13:55:06.233	160	55	f	ad-hoc	\N	1	\N	\N	\N
490	\\xddf69860789b56378e70bb0200b6ad3cfe9dcdb22cc1a67e2806a9d78a172d5b	2017-11-14 13:55:13.525	143	132	f	ad-hoc	\N	1	\N	\N	\N
493	\\xdf52930e81201248ac87b273716bcd36685236a820763c0910351a6423f64dd0	2017-11-14 13:56:11.005	157	132	f	ad-hoc	\N	1	\N	\N	\N
494	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 13:58:01.113	259	260	f	question	\N	1	7	\N	\N
498	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-14 13:58:01.033	364	172	f	question	\N	1	2	\N	\N
503	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 13:59:04.067	334	55	f	question	\N	1	4	\N	\N
491	\\x690786c578aa71dbfc39be02bb8000711daa70ec780a85dea55674415b456869	2017-11-14 13:55:34.15	145	55	f	ad-hoc	\N	1	\N	\N	\N
495	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 13:58:01.043	341	55	f	question	\N	1	4	\N	\N
501	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-14 13:59:04.056	342	172	f	question	\N	1	2	\N	\N
492	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 13:55:53.315	145	55	f	ad-hoc	\N	1	\N	\N	\N
497	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 13:58:01.06	360	132	f	question	\N	1	3	\N	\N
499	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 13:58:09.863	107	132	f	question	\N	1	6	\N	\N
504	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 13:59:04.142	276	260	f	question	\N	1	7	\N	\N
496	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 13:58:01.055	358	132	f	question	\N	1	6	\N	\N
502	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 13:59:04.088	306	132	f	question	\N	1	6	\N	\N
500	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 13:59:04.057	319	132	f	question	\N	1	3	\N	\N
505	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 14:01:35.943	414	260	f	question	\N	1	7	\N	\N
506	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 14:01:40.057	510	260	f	question	\N	1	7	\N	\N
507	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 14:01:40.009	575	55	f	question	\N	1	4	\N	\N
508	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-14 14:01:40.042	528	172	f	question	\N	1	2	\N	\N
509	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 14:01:40.059	510	132	f	question	\N	1	3	\N	\N
510	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 14:01:40.092	538	132	f	question	\N	1	6	\N	\N
511	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 14:01:47.392	131	260	f	question	\N	1	7	\N	\N
512	\\xa38a092a927dc417d2c0722172e7964b38ad1c069b195b87b09bae385c15a548	2017-11-14 14:02:07.784	243	260	f	ad-hoc	\N	1	\N	\N	\N
513	\\x4e7c893acd5bfde7fcd471e99e3177f9513a2d2fd4169da913d89cb1605c78df	2017-11-14 14:02:49.543	174	10	f	ad-hoc	\N	1	\N	\N	\N
514	\\xe620746dca7282cc9c4b6158121b53b22fb3385ac46fc75c6940a64dbd5ab333	2017-11-14 14:03:20.709	247	10	f	ad-hoc	\N	1	\N	\N	\N
515	\\x3e0aa390c3145a73d478d4dee6c735f4bd4230c5b1d4d4ea022bde4e9627f8a0	2017-11-14 14:03:32.627	150	10	f	ad-hoc	\N	1	\N	\N	\N
516	\\xe4823303a34368d35b0c8290fc3e5cd7ab7925c3d22f6e489a8e7676e750058e	2017-11-14 14:03:39.749	216	260	f	ad-hoc	\N	1	\N	\N	\N
517	\\x13beb1bf0eed2bbc5de8f6c2f86060c9c3d9abae7a4b0009371e97dbe4480fc0	2017-11-14 14:04:08.778	155	260	f	ad-hoc	\N	1	\N	\N	\N
518	\\x13beb1bf0eed2bbc5de8f6c2f86060c9c3d9abae7a4b0009371e97dbe4480fc0	2017-11-14 14:04:11.164	123	260	f	ad-hoc	\N	1	\N	\N	\N
519	\\xe484be966386b13d08209a8a31952e21d486fcb4a1546f54d764ed9a4ce0fb39	2017-11-14 14:04:17.433	195	260	f	ad-hoc	\N	1	\N	\N	\N
520	\\x4a6a19c7878b6f238890925b421d0ff96a674dab847cb962f6ed3fc9abab0d86	2017-11-14 14:04:34.253	177	10	f	ad-hoc	\N	1	\N	\N	\N
521	\\xe484be966386b13d08209a8a31952e21d486fcb4a1546f54d764ed9a4ce0fb39	2017-11-14 14:04:54.109	185	260	f	ad-hoc	\N	1	\N	\N	\N
522	\\x5597c7db1e2ac6aba6e4962252b31458acdbfc15a4223c18e78b13351d9f8d10	2017-11-14 14:05:24.081	154	25	f	ad-hoc	\N	1	\N	\N	\N
523	\\xe7ce71c0296b3bed3d1b3ce5c6fe84437f0529e22b6b608b73e89f5fc2e026ae	2017-11-14 14:05:43.261	267	2000	f	ad-hoc	\N	1	\N	\N	\N
524	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 14:06:02.644	315	132	f	question	\N	1	3	\N	\N
525	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-14 14:06:02.644	318	172	f	question	\N	1	2	\N	\N
526	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 14:06:02.738	249	55	f	question	\N	1	4	\N	\N
527	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 14:06:02.686	349	132	f	question	\N	1	6	\N	\N
528	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 14:06:02.762	351	260	f	question	\N	1	7	\N	\N
529	\\xa8e6002aaf6b28052f04f321ba30b282f3606f857220d3388fc53b01daa26dc3	2017-11-14 14:06:08.798	132	260	f	question	\N	1	7	\N	\N
530	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-14 14:06:27.001	208	25	f	ad-hoc	\N	1	\N	\N	\N
531	\\x3e0aa390c3145a73d478d4dee6c735f4bd4230c5b1d4d4ea022bde4e9627f8a0	2017-11-14 14:07:16.79	137	10	f	ad-hoc	\N	1	\N	\N	\N
532	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-14 14:07:28.304	139	25	f	ad-hoc	\N	1	\N	\N	\N
533	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 14:07:53.714	161	55	f	embedded-question	\N	1	4	\N	\N
534	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-14 14:07:53.716	215	172	f	embedded-question	\N	1	2	\N	\N
535	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 14:07:54.317	200	132	f	embedded-question	\N	1	3	\N	\N
536	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-14 14:07:54.397	235	25	f	embedded-question	\N	1	7	\N	\N
537	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 14:07:55.177	129	132	f	embedded-question	\N	1	6	\N	\N
538	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 14:08:43.817	104	132	f	embedded-question	\N	1	6	\N	\N
539	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-14 14:08:44.02	165	172	f	embedded-question	\N	1	2	\N	\N
540	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 14:08:46.306	188	132	f	embedded-question	\N	1	3	\N	\N
541	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 14:08:46.558	140	55	f	embedded-question	\N	1	4	\N	\N
542	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-14 14:08:46.744	135	25	f	embedded-question	\N	1	7	\N	\N
543	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-14 14:10:21.073	374	25	f	question	\N	1	7	\N	\N
544	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 14:10:27.898	333	55	f	question	\N	1	4	\N	\N
545	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 14:10:27.91	462	132	f	question	\N	1	6	\N	\N
546	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-14 14:10:27.866	526	25	f	question	\N	1	7	\N	\N
547	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-14 14:10:27.833	629	172	f	question	\N	1	2	\N	\N
548	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 14:10:27.967	549	132	f	question	\N	1	3	\N	\N
549	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-14 14:10:37.911	277	25	f	question	\N	1	7	\N	\N
550	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 14:10:37.822	429	55	f	question	\N	1	4	\N	\N
551	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-14 14:10:37.84	446	172	f	question	\N	1	2	\N	\N
552	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 14:10:37.839	450	132	f	question	\N	1	3	\N	\N
553	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 14:10:37.857	469	132	f	question	\N	1	6	\N	\N
554	\\x83bc7a2c3fddc70fa50685b09c203f96fc8ab1e3f9874344cd64c04f561b6180	2017-11-14 14:10:59.572	152	24	f	ad-hoc	\N	1	\N	\N	\N
555	\\x42ab6672810aae8ab9c80a8773f3c9ccd4163abd15ce71c392f0d3bf26e7432a	2017-11-14 14:11:07.107	180	24	f	ad-hoc	\N	1	\N	\N	\N
556	\\x42ab6672810aae8ab9c80a8773f3c9ccd4163abd15ce71c392f0d3bf26e7432a	2017-11-14 14:11:18.939	122	24	f	ad-hoc	\N	1	\N	\N	\N
557	\\xef5bd9ef6a787e726a00f1f31afbcf66a820544b5dbd88a3d3090b8d9667cefc	2017-11-14 14:11:33.427	186	24	f	ad-hoc	\N	1	\N	\N	\N
558	\\x2787f566432a601c9d94e99f64d09057a13693b8ca76e9c670f73c105ee05e84	2017-11-14 14:11:39.461	148	24	f	ad-hoc	\N	1	\N	\N	\N
559	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 14:12:54.612	425	55	f	question	\N	1	4	\N	\N
560	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-14 14:12:54.712	378	25	f	question	\N	1	7	\N	\N
561	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-14 14:12:54.596	587	172	f	question	\N	1	2	\N	\N
562	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 14:12:54.608	577	132	f	question	\N	1	3	\N	\N
563	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 14:12:54.7	540	132	f	question	\N	1	6	\N	\N
564	\\xcf5fa65ff623d108eb46e643a888d5cb7a593a64af7314b44379bbe7a510e574	2017-11-14 14:12:55.309	131	24	f	question	\N	1	8	\N	\N
565	\\x0d6dacd4a22d71ef38c35c9491e56b83c0d72367d6c709bc0110be1078cb12d4	2017-11-14 14:13:14.147	94	7	f	ad-hoc	\N	1	\N	\N	\N
566	\\xbc462fc1376ef84c69934f95a21232cf42adf867eaea01c64d05fd4215667f9b	2017-11-14 14:13:21.612	154	7	f	ad-hoc	\N	1	\N	\N	\N
567	\\xcf5fa65ff623d108eb46e643a888d5cb7a593a64af7314b44379bbe7a510e574	2017-11-14 14:14:04.194	257	24	f	question	\N	1	8	\N	\N
568	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-14 14:14:04.122	344	172	f	question	\N	1	2	\N	\N
569	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-14 14:14:04.159	457	25	f	question	\N	1	7	\N	\N
570	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 14:14:04.165	482	55	f	question	\N	1	4	\N	\N
571	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 14:14:04.16	497	132	f	question	\N	1	3	\N	\N
572	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 14:14:04.181	487	132	f	question	\N	1	6	\N	\N
573	\\xbc462fc1376ef84c69934f95a21232cf42adf867eaea01c64d05fd4215667f9b	2017-11-14 14:14:04.947	119	7	f	question	\N	1	9	\N	\N
574	\\xbc462fc1376ef84c69934f95a21232cf42adf867eaea01c64d05fd4215667f9b	2017-11-14 14:14:28.809	108	7	f	question	\N	1	9	\N	\N
575	\\xc2ae1a1e2e8be5db1e55f61c039034cb17ca0c1edb6a9ca3e52e5ecf93fc6b9f	2017-11-14 14:14:41.73	127	7	f	ad-hoc	\N	1	\N	\N	\N
576	\\xf9dd02dcf34a436ba1f43c19f258bea90c3778738187fe9de7ddb8e617bd74d0	2017-11-14 14:14:48.543	135	7	f	ad-hoc	\N	1	\N	\N	\N
577	\\xcd6c11684675fd9ee2df16501ce78f775d0b4660f671f0e3652eb002a32f76da	2017-11-14 14:14:56.092	113	7	f	ad-hoc	\N	1	\N	\N	\N
580	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-14 14:15:28.765	334	25	f	question	\N	1	7	\N	\N
581	\\xcf5fa65ff623d108eb46e643a888d5cb7a593a64af7314b44379bbe7a510e574	2017-11-14 14:15:28.83	296	24	f	question	\N	1	8	\N	\N
578	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-14 14:15:28.795	262	55	f	question	\N	1	4	\N	\N
579	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-14 14:15:28.745	342	172	f	question	\N	1	2	\N	\N
582	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-14 14:15:28.764	419	132	f	question	\N	1	6	\N	\N
583	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-14 14:15:28.758	452	132	f	question	\N	1	3	\N	\N
584	\\xbc462fc1376ef84c69934f95a21232cf42adf867eaea01c64d05fd4215667f9b	2017-11-14 14:15:29.127	159	7	f	question	\N	1	9	\N	\N
585	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-18 01:13:11.404	738	119	f	embedded-question	\N	\N	2	\N	\N
586	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-18 01:13:11.414	765	64	f	embedded-question	\N	\N	3	\N	\N
587	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-18 01:13:11.42	779	55	f	embedded-question	\N	\N	4	\N	\N
588	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-18 01:13:11.423	765	64	f	embedded-question	\N	\N	6	\N	\N
589	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-18 01:13:11.417	712	25	f	embedded-question	\N	\N	7	\N	\N
590	\\x3d017954f202fb414a9c97d85b9aeda04aee29cd7e642a6d9934c3444ef076c7	2017-11-18 01:14:27.359	190	2000	f	ad-hoc	\N	1	\N	\N	\N
591	\\x145da31dd998d0d0e86cebcf61f819850b54e1b817610ef0f57af5b3e2cc1171	2017-11-18 01:15:15.364	74	55	f	ad-hoc	\N	1	\N	\N	\N
592	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-11-18 01:15:57.77	91	125	f	ad-hoc	\N	1	\N	\N	\N
593	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-11-18 01:17:09.688	92	55	f	ad-hoc	\N	1	\N	\N	\N
594	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-11-18 01:18:04.042	90	2	f	ad-hoc	\N	1	\N	\N	\N
595	\\x5c7f8a7da7a185bcb6d36485e5ced07d14db9a872f29b08bb9c969ce0a59205b	2017-11-18 01:19:50.608	90	31	f	ad-hoc	\N	1	\N	\N	\N
596	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-18 01:20:23.294	150	173	f	embedded-question	\N	\N	2	\N	\N
597	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-18 01:20:23.718	87	55	f	embedded-question	\N	\N	4	\N	\N
598	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-18 01:20:23.748	134	132	f	embedded-question	\N	\N	3	\N	\N
599	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-18 01:20:23.921	127	25	f	embedded-question	\N	\N	7	\N	\N
600	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-18 01:20:23.919	187	132	f	embedded-question	\N	\N	6	\N	\N
601	\\x79b9821f976e9b44dcefe483b0b0aac3aeeae51ad963ad7a420c1d2af4258a11	2017-11-18 01:20:53.223	69	31	f	ad-hoc	\N	1	\N	\N	\N
602	\\x6266766110761ffd546a5658d01aa2416f0dfe685509a41988e80dfbff701be4	2017-11-18 01:21:13.877	112	75	f	ad-hoc	\N	1	\N	\N	\N
603	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-11-18 01:21:30.702	94	75	f	ad-hoc	\N	1	\N	\N	\N
604	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-18 01:23:16.165	148	173	f	embedded-question	\N	\N	2	\N	\N
605	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-18 01:23:16.509	112	55	f	embedded-question	\N	\N	4	\N	\N
606	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-18 01:23:16.676	121	132	f	embedded-question	\N	\N	3	\N	\N
607	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-18 01:23:16.832	203	132	f	embedded-question	\N	\N	6	\N	\N
608	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-18 01:23:16.876	202	25	f	embedded-question	\N	\N	7	\N	\N
609	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-11-18 01:25:00.291	52	125	f	question	\N	1	10	\N	\N
610	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-11-18 01:25:15.059	43	125	f	question	\N	1	10	\N	\N
611	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-11-18 02:17:44.537	57	125	f	question	\N	1	10	\N	\N
612	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-18 02:17:52.558	146	173	f	embedded-question	\N	\N	2	\N	\N
613	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-18 02:17:52.77	107	25	f	embedded-question	\N	\N	7	\N	\N
614	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-18 02:17:53.27	147	132	f	embedded-question	\N	\N	6	\N	\N
615	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-18 02:17:53.31	139	132	f	embedded-question	\N	\N	3	\N	\N
616	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-18 02:17:53.747	75	55	f	embedded-question	\N	\N	4	\N	\N
617	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-18 02:40:22.621	658	173	f	embedded-question	\N	\N	2	\N	\N
618	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-18 02:40:22.422	885	55	f	embedded-question	\N	\N	4	\N	\N
619	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-18 02:40:22.761	518	25	f	embedded-question	\N	\N	7	\N	\N
620	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-18 02:40:22.883	462	132	f	embedded-question	\N	\N	6	\N	\N
621	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-18 02:40:22.738	597	132	f	embedded-question	\N	\N	3	\N	\N
622	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-18 02:46:41.723	170	173	f	embedded-question	\N	\N	2	\N	\N
623	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-18 02:46:42.127	184	55	f	embedded-question	\N	\N	4	\N	\N
624	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-18 02:46:42.13	251	132	f	embedded-question	\N	\N	6	\N	\N
625	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-18 02:46:42.333	220	132	f	embedded-question	\N	\N	3	\N	\N
626	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-18 02:46:42.37	214	25	f	embedded-question	\N	\N	7	\N	\N
627	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-11-18 02:50:22.926	35	2	f	question	\N	1	12	\N	\N
628	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-11-18 02:50:48.776	59	2	f	question	\N	1	12	\N	\N
629	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-18 02:52:37.262	104	132	f	embedded-question	\N	\N	6	\N	\N
630	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-11-18 02:52:56.838	47	55	f	question	\N	1	11	\N	\N
631	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-11-18 02:54:35.601	32	75	f	question	\N	1	13	\N	\N
632	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-11-18 02:55:03.458	56	125	f	question	\N	1	10	\N	\N
633	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-11-18 02:55:10.882	44	125	f	question	\N	1	10	\N	\N
634	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-18 02:55:14.984	127	55	f	question	\N	1	4	\N	\N
635	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-11-18 02:55:20.479	27	2	f	question	\N	1	12	\N	\N
637	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-11-18 02:55:55.26	46	125	f	embedded-question	\N	\N	10	\N	\N
636	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-11-18 02:55:36.523	44	55	f	question	\N	1	11	\N	\N
639	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-11-18 02:55:55.818	50	55	f	embedded-question	\N	\N	11	\N	\N
641	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-18 02:55:56.146	105	132	f	embedded-question	\N	\N	6	\N	\N
638	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-11-18 02:55:55.515	43	75	f	embedded-question	\N	\N	13	\N	\N
640	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-11-18 02:55:55.993	37	2	f	embedded-question	\N	\N	12	\N	\N
642	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-19 17:53:35.043	707	132	f	embedded-question	\N	\N	6	\N	\N
643	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-19 17:53:35.04	690	55	f	embedded-question	\N	\N	4	\N	\N
644	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-19 17:53:34.78	915	173	f	embedded-question	\N	\N	2	\N	\N
645	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-19 17:53:35.122	581	25	f	embedded-question	\N	\N	7	\N	\N
646	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-19 17:53:35.036	730	132	f	embedded-question	\N	\N	3	\N	\N
647	\\xd4ed4ac21fda71a4b2231eff9a755b9dead0d0bf27404a27a5dbc10010653ffc	2017-11-19 17:55:02.871	60	2000	f	ad-hoc	\N	1	\N	\N	\N
648	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-11-19 17:56:28.396	164	107	f	ad-hoc	\N	1	\N	\N	\N
649	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-11-19 17:56:37.97	143	107	f	ad-hoc	\N	1	\N	\N	\N
650	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-19 17:57:42.351	186	173	f	embedded-question	\N	\N	2	\N	\N
651	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-19 17:57:42.804	123	132	f	embedded-question	\N	\N	3	\N	\N
652	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-19 17:57:42.876	123	55	f	embedded-question	\N	\N	4	\N	\N
653	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-19 17:57:43.104	114	25	f	embedded-question	\N	\N	7	\N	\N
654	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-19 17:57:43.083	174	132	f	embedded-question	\N	\N	6	\N	\N
655	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-11-19 17:58:41.895	133	44	f	ad-hoc	\N	1	\N	\N	\N
656	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-11-19 17:59:44.175	148	7	f	ad-hoc	\N	1	\N	\N	\N
657	\\x9c0228d167203464c42d91efe815d6f17a8be95ddbe03adadcb8617b5a1c4a46	2017-11-19 18:00:22.499	137	3	f	ad-hoc	\N	1	\N	\N	\N
658	\\x23e4321c147245a4d20fb56fd5e3a7c76ed29c2139ae859a90a9a2f04ab731bc	2017-11-19 18:00:34.704	137	19	f	ad-hoc	\N	1	\N	\N	\N
659	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-11-19 18:01:00.86	128	7	f	ad-hoc	\N	1	\N	\N	\N
660	\\x496390f2f0b50e2fbfc8c751ba6e74596619323710bdcbbeea173e6d7f0bd10b	2017-11-19 18:02:22.399	90	1	f	ad-hoc	\N	1	\N	\N	\N
661	\\x8945bdcc19389d03a61d4f8ed4b39f90d8c87456afe41af017db088ef52f6028	2017-11-19 18:02:28.447	153	19	f	ad-hoc	\N	1	\N	\N	\N
662	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-11-19 18:02:49.421	106	57	f	ad-hoc	\N	1	\N	\N	\N
663	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-11-19 18:07:28.981	91	44	f	question	\N	1	15	\N	\N
664	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-11-19 18:07:43.699	96	57	f	question	\N	1	17	\N	\N
665	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-11-19 18:07:57.059	102	7	f	question	\N	1	16	\N	\N
666	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-11-19 18:08:07.611	110	107	f	question	\N	1	14	\N	\N
667	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-11-19 18:09:06.949	120	107	f	embedded-question	\N	\N	14	\N	\N
668	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-11-19 18:09:07.237	62	7	f	embedded-question	\N	\N	16	\N	\N
669	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-11-19 18:09:07.496	144	57	f	embedded-question	\N	\N	17	\N	\N
670	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-11-19 18:09:07.522	151	44	f	embedded-question	\N	\N	15	\N	\N
671	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-19 18:09:07.624	167	132	f	embedded-question	\N	\N	6	\N	\N
672	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-20 22:51:40.577	530	173	f	embedded-question	\N	\N	2	\N	\N
673	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-20 22:51:40.592	484	25	f	embedded-question	\N	\N	7	\N	\N
674	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-20 22:51:40.573	550	55	f	embedded-question	\N	\N	4	\N	\N
675	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-20 22:51:40.594	560	132	f	embedded-question	\N	\N	3	\N	\N
676	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-20 22:51:40.574	599	132	f	embedded-question	\N	\N	6	\N	\N
677	\\xb204f11185354b6c0ec52816fc20f7cc5bf1d6d243ec958396bca494fe96a3e6	2017-11-20 23:00:45.443	200	0	f	ad-hoc	ERROR: duplicate key value violates unique constraint "pk_query_execution"\n  Detail: Key (id)=(676) already exists.	1	\N	\N	\N
678	\\xb204f11185354b6c0ec52816fc20f7cc5bf1d6d243ec958396bca494fe96a3e6	2017-11-20 23:00:53.692	116	2000	f	ad-hoc	\N	1	\N	\N	\N
679	\\xb204f11185354b6c0ec52816fc20f7cc5bf1d6d243ec958396bca494fe96a3e6	2017-11-20 23:00:56.079	60	2000	f	ad-hoc	\N	1	\N	\N	\N
680	\\xc9c537fffd3a147ff3f39f6ce2e59b24d97bb2467c3818ac5495f6f9e07181d6	2017-11-20 23:02:00.668	112	7	f	ad-hoc	\N	1	\N	\N	\N
681	\\xc9c537fffd3a147ff3f39f6ce2e59b24d97bb2467c3818ac5495f6f9e07181d6	2017-11-20 23:02:19.486	99	7	f	ad-hoc	\N	1	\N	\N	\N
682	\\xae104a6053fee2863008c26b825968d22fb42f575f9657358821ac862b87fd2b	2017-11-20 23:02:35.846	117	7	f	ad-hoc	\N	1	\N	\N	\N
683	\\xae104a6053fee2863008c26b825968d22fb42f575f9657358821ac862b87fd2b	2017-11-20 23:02:36.919	101	7	f	ad-hoc	\N	1	\N	\N	\N
684	\\xd124d06e139130090a743e729d1bdf5e57997154ac5afa515a3de80a3a48f6ac	2017-11-20 23:02:52.179	68	7	f	ad-hoc	\N	1	\N	\N	\N
685	\\xf429d0082adac3811e2b09eae4f56e1fd5b00b94e25974cd3300caf8fbf69bc5	2017-11-20 23:02:59.092	67	7	f	ad-hoc	\N	1	\N	\N	\N
686	\\xec6fcbd015478995fa62dad707519637458ee1b7b9d7dca35aa2784b39b7c518	2017-11-20 23:03:05.361	91	7	f	ad-hoc	\N	1	\N	\N	\N
687	\\xf429d0082adac3811e2b09eae4f56e1fd5b00b94e25974cd3300caf8fbf69bc5	2017-11-20 23:03:09.519	98	7	f	ad-hoc	\N	1	\N	\N	\N
688	\\xbd3c80317764415cbb70c03f7e0e90dfc07a01e3e1333ce11ff44575c04a364e	2017-11-20 23:04:27.462	89	10	f	ad-hoc	\N	1	\N	\N	\N
689	\\x4378f8e359fd2cef7a7968e05f2c7b5aa6155e537a799688097eb1a1844b079c	2017-11-20 23:05:57.95	90	3	f	ad-hoc	\N	1	\N	\N	\N
690	\\x4378f8e359fd2cef7a7968e05f2c7b5aa6155e537a799688097eb1a1844b079c	2017-11-20 23:06:06.269	57	3	f	ad-hoc	\N	1	\N	\N	\N
691	\\x6b5039481ad1749520b96d2176d5bfbc2b6eba08495cf8054faed42d28658a53	2017-11-20 23:06:49.667	71	3	f	ad-hoc	\N	1	\N	\N	\N
692	\\x619ba579cc2cba9995d467f0c1b5eeceb63896b971c47ee34e6ed4b154eaefa3	2017-11-20 23:07:29.42	110	3	f	ad-hoc	\N	1	\N	\N	\N
693	\\x619ba579cc2cba9995d467f0c1b5eeceb63896b971c47ee34e6ed4b154eaefa3	2017-11-20 23:07:35.379	38	3	f	ad-hoc	\N	1	\N	\N	\N
694	\\x4fa64b3921a5345e56cafded326679d694ff759dc9c14a9c99a091b6ef7b026a	2017-11-20 23:08:23.699	118	47	f	ad-hoc	\N	1	\N	\N	\N
695	\\xe7a4740534679b9671915c65b50eadd2563f583450724d8b3b902061afa64279	2017-11-20 23:09:14.958	107	47	f	ad-hoc	\N	1	\N	\N	\N
697	\\xe7a4740534679b9671915c65b50eadd2563f583450724d8b3b902061afa64279	2017-11-20 23:09:28.296	105	47	f	ad-hoc	\N	1	\N	\N	\N
698	\\x9bec7843a5f94ab47eb40948622b1f8f78b7429885aff8c4e92e72ae5dfa105a	2017-11-20 23:09:34.817	325	0	f	ad-hoc	BSON field name can not be null	1	\N	\N	\N
702	\\xa6e43734a8b76c28bb3723d3475c2427ff139362a5a98c49cc96035ff3f1d29c	2017-11-20 23:10:03.741	105	47	f	ad-hoc	\N	1	\N	\N	\N
708	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-11-20 23:10:40.093	104	47	f	ad-hoc	\N	1	\N	\N	\N
720	\\xf8ab73da628afbbd148c05f79cda69acc8b423606ecfc38614e2285f065b31c5	2017-11-20 23:41:50.163	99	2000	f	ad-hoc	\N	1	\N	\N	\N
721	\\xf8ab73da628afbbd148c05f79cda69acc8b423606ecfc38614e2285f065b31c5	2017-11-20 23:42:01.904	93	2000	f	ad-hoc	\N	1	\N	\N	\N
722	\\x2df1c1b99dab5d6c0df61c40a4bc206c6dfad0aa9bb3abebb778075cb7301608	2017-11-20 23:43:47.824	50	1	f	ad-hoc	\N	1	\N	\N	\N
723	\\x3d4b7ca05f18b2de0927bd10138aba99a571e980b545ad1e4ba4e57151a9d8c7	2017-11-20 23:44:37.417	62	3	f	ad-hoc	\N	1	\N	\N	\N
735	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-20 23:51:21.515	46	54	f	question	\N	1	28	\N	\N
737	\\x439520b880e95500549b7ebcda358e9b5c6a2f3c005991646856e318da1a604a	2017-11-20 23:51:52.26	35	13	f	question	\N	1	26	\N	\N
738	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-20 23:52:04.413	37	25	f	question	\N	1	29	\N	\N
696	\\xe7a4740534679b9671915c65b50eadd2563f583450724d8b3b902061afa64279	2017-11-20 23:09:17.638	92	47	f	ad-hoc	\N	1	\N	\N	\N
699	\\x9bec7843a5f94ab47eb40948622b1f8f78b7429885aff8c4e92e72ae5dfa105a	2017-11-20 23:09:36.265	286	0	f	ad-hoc	BSON field name can not be null	1	\N	\N	\N
700	\\x9bec7843a5f94ab47eb40948622b1f8f78b7429885aff8c4e92e72ae5dfa105a	2017-11-20 23:09:38.198	301	0	f	ad-hoc	BSON field name can not be null	1	\N	\N	\N
701	\\x490d37dcbc61cde4cabda5f9801f4464045fb2834df78c9a9fb3488c2399b6f9	2017-11-20 23:09:44.373	84	47	f	ad-hoc	\N	1	\N	\N	\N
703	\\xea15adb9ebf96bf593bb87a25e21c6a4976a7aef779aab72073e95005a5f83e8	2017-11-20 23:10:13.619	100	47	f	ad-hoc	\N	1	\N	\N	\N
704	\\x1c446c3459dadecb44f60ee7c2138493eadb825ab7ed7d7461513f3d5bfd7185	2017-11-20 23:10:26.302	83	47	f	ad-hoc	\N	1	\N	\N	\N
705	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-11-20 23:10:29.403	51	47	f	ad-hoc	\N	1	\N	\N	\N
706	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-11-20 23:10:30.363	120	47	f	ad-hoc	\N	1	\N	\N	\N
707	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-11-20 23:10:31.115	88	47	f	ad-hoc	\N	1	\N	\N	\N
715	\\x6b5039481ad1749520b96d2176d5bfbc2b6eba08495cf8054faed42d28658a53	2017-11-20 23:17:45.541	27	3	f	question	\N	1	21	\N	\N
716	\\xbd3c80317764415cbb70c03f7e0e90dfc07a01e3e1333ce11ff44575c04a364e	2017-11-20 23:17:51.13	34	10	f	question	\N	1	19	\N	\N
724	\\x439520b880e95500549b7ebcda358e9b5c6a2f3c005991646856e318da1a604a	2017-11-20 23:46:15.165	105	13	f	ad-hoc	\N	1	\N	\N	\N
709	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-11-20 23:16:35.26	49	47	f	question	\N	1	24	\N	\N
710	\\x619ba579cc2cba9995d467f0c1b5eeceb63896b971c47ee34e6ed4b154eaefa3	2017-11-20 23:16:58.034	50	3	f	question	\N	1	22	\N	\N
711	\\x619ba579cc2cba9995d467f0c1b5eeceb63896b971c47ee34e6ed4b154eaefa3	2017-11-20 23:17:08.07	34	3	f	question	\N	1	22	\N	\N
712	\\x4378f8e359fd2cef7a7968e05f2c7b5aa6155e537a799688097eb1a1844b079c	2017-11-20 23:17:13.511	24	3	f	question	\N	1	20	\N	\N
713	\\x4378f8e359fd2cef7a7968e05f2c7b5aa6155e537a799688097eb1a1844b079c	2017-11-20 23:17:27.83	32	3	f	question	\N	1	20	\N	\N
718	\\xf429d0082adac3811e2b09eae4f56e1fd5b00b94e25974cd3300caf8fbf69bc5	2017-11-20 23:18:07.876	33	7	f	question	\N	1	18	\N	\N
739	\\xf19ab079b9f266aa766b47ddf4b37c76acd4aff757e3e118d5ca627fa49566ee	2017-11-20 23:52:15.77	52	54	f	question	\N	1	27	\N	\N
742	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-21 00:02:36.523	103	55	f	embedded-question	\N	\N	4	\N	\N
743	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-21 00:02:36.8	132	132	f	embedded-question	\N	\N	3	\N	\N
745	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-21 00:02:36.975	147	132	f	embedded-question	\N	\N	6	\N	\N
714	\\x6b5039481ad1749520b96d2176d5bfbc2b6eba08495cf8054faed42d28658a53	2017-11-20 23:17:35.022	32	3	f	question	\N	1	21	\N	\N
717	\\xbd3c80317764415cbb70c03f7e0e90dfc07a01e3e1333ce11ff44575c04a364e	2017-11-20 23:18:02.482	42	10	f	question	\N	1	19	\N	\N
719	\\x4fa64b3921a5345e56cafded326679d694ff759dc9c14a9c99a091b6ef7b026a	2017-11-20 23:18:24.865	44	47	f	question	\N	1	23	\N	\N
725	\\xf19ab079b9f266aa766b47ddf4b37c76acd4aff757e3e118d5ca627fa49566ee	2017-11-20 23:47:19.474	101	54	f	ad-hoc	\N	1	\N	\N	\N
726	\\xf19ab079b9f266aa766b47ddf4b37c76acd4aff757e3e118d5ca627fa49566ee	2017-11-20 23:47:23.767	106	54	f	ad-hoc	\N	1	\N	\N	\N
727	\\x792a044714c63be23038204865243264e18fb8501465b9b23451a2a84ebe4db3	2017-11-20 23:47:53.991	111	54	f	ad-hoc	\N	1	\N	\N	\N
728	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-20 23:47:58.429	43	54	f	ad-hoc	\N	1	\N	\N	\N
729	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-20 23:48:04.873	58	54	f	ad-hoc	\N	1	\N	\N	\N
730	\\xe48a2eaa6c8d7695da35bdcaf46e865a3bc1a8d734088e03a888695e2524a0a0	2017-11-20 23:48:51.624	39	61	f	ad-hoc	\N	1	\N	\N	\N
731	\\xe48a2eaa6c8d7695da35bdcaf46e865a3bc1a8d734088e03a888695e2524a0a0	2017-11-20 23:48:57.453	78	61	f	ad-hoc	\N	1	\N	\N	\N
732	\\xa10b50b18a6553118701872a96318522684bf78ab319b585168ef6fb1a59f9c0	2017-11-20 23:49:10.409	76	61	f	ad-hoc	\N	1	\N	\N	\N
733	\\x62e27e4990cc2b7ff87a3330d56cdd634cf8669d2fede6b98363dd360be4de0a	2017-11-20 23:49:27.731	52	10	f	ad-hoc	\N	1	\N	\N	\N
734	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-20 23:49:32.774	105	25	f	ad-hoc	\N	1	\N	\N	\N
736	\\x3d4b7ca05f18b2de0927bd10138aba99a571e980b545ad1e4ba4e57151a9d8c7	2017-11-20 23:51:39.359	36	3	f	question	\N	1	25	\N	\N
740	\\xf19ab079b9f266aa766b47ddf4b37c76acd4aff757e3e118d5ca627fa49566ee	2017-11-20 23:52:27.258	66	54	f	question	\N	1	27	\N	\N
741	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-21 00:02:36.251	140	173	f	embedded-question	\N	\N	2	\N	\N
744	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-21 00:02:36.809	196	25	f	embedded-question	\N	\N	7	\N	\N
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
5	2017-11-12 23:07:07.706+00	2017-11-12 23:07:07.706+00	Per Occupation Areas, Cumulative count, Grouped by Date (month) and Instance	\N	line	{"database":2,"type":"query","query":{"source_table":6,"breakout":[["datetime-field",["field-id",495],"month"],["field-id",272]],"aggregation":[["cum_count"]]}}	{"line.interpolate":"linear","line.marker_enabled":true}	1	2	6	query	f	\N	\N	\N	f	\N	\N	[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Text","display_name":"Instance","name":"_instance","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
4	2017-11-12 23:05:39.061+00	2017-11-14 00:19:10.169+00	Crescimento Cumulativo Mensal	\N	line	{"database":2,"type":"query","query":{"source_table":12,"breakout":[["datetime-field",["field-id",501],"month"]],"aggregation":[["cum_count"]]}}	{"line.interpolate":"cardinal","line.marker_enabled":true}	1	2	12	query	f	\N	\N	\N	t	{}	\N	[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
3	2017-11-12 23:01:23.161+00	2017-11-14 00:24:14.147+00	Quantidade de Registros por Mês	\N	bar	{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"breakout":[["datetime-field",["field-id",501],"month"],["field-id",500]]}}	{"stackable.stack_type":"stacked"}	1	2	12	query	f	\N	\N	\N	t	{}	\N	[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
1	2017-11-11 23:04:00.232+00	2017-11-13 23:32:25.016+00	Products	\N	line	{"database":1,"type":"query","query":{"source_table":1}}	{"graph.dimensions":["ID"],"graph.metrics":["PRICE"]}	1	1	1	query	f	\N	\N	\N	t	{}	\N	[{"base_type":"type/BigInteger","display_name":"ID","name":"ID","description":"The numerical product number. Only used internally. All external communication should use the title or EAN.","special_type":"type/PK"},{"base_type":"type/Text","display_name":"Category","name":"CATEGORY","description":"The type of product, valid values include: Doohicky, Gadget, Gizmo and Widget","special_type":"type/Category"},{"base_type":"type/DateTime","display_name":"Created At","name":"CREATED_AT","description":"The date the product was added to our catalog.","unit":"default"},{"base_type":"type/Text","display_name":"Ean","name":"EAN","description":"The international article number. A 13 digit number uniquely identifying the product.","special_type":"type/Category"},{"base_type":"type/Float","display_name":"Price","name":"PRICE","description":"The list price of the product. Note that this is not always the price the product sold for due to discounts, promotions, etc.","special_type":"type/Category"},{"base_type":"type/Float","display_name":"Rating","name":"RATING","description":"The average rating users have given the product. This ranges from 1 - 5","special_type":"type/Category"},{"base_type":"type/Text","display_name":"Title","name":"TITLE","description":"The name of the product as it should be displayed to customers.","special_type":"type/Category"},{"base_type":"type/Text","display_name":"Vendor","name":"VENDOR","description":"The source of the product.","special_type":"type/Category"}]
2	2017-11-12 21:42:36.767+00	2017-11-14 06:15:27.825+00	Áreas de Atuação por Instância	\N	bar	{"database":2,"type":"query","query":{"source_table":15,"aggregation":[["count"]],"breakout":[["field-id",594],["field-id",592]]}}	{"stackable.stack_type":"normalized"}	1	2	15	query	f	\N	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Occupation Area","name":"_occupation_area"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
6	2017-11-12 23:08:52.511+00	2017-11-14 13:45:43.174+00	Crescimento Cumulativo Mensal por Instância	\N	line	{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",501],"month"],["field-id",500]]}}	{"line.interpolate":"linear","line.marker_enabled":true}	1	2	12	query	f	\N	\N	\N	t	{}	\N	[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
7	2017-11-12 23:51:12.874+00	2017-11-14 14:07:36.034+00	Tipos por Instância	\N	bar	{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"breakout":[["field-id",500],["field-id",498]],"order_by":[[["aggregation",0],"descending"]],"limit":25}}	{"stackable.stack_type":"stacked","graph.x_axis.title_text":"","graph.y_axis.scale":"linear","graph.y_axis.auto_split":true,"graph.x_axis.axis_enabled":true,"graph.y_axis.axis_enabled":true,"graph.y_axis.auto_range":true}	1	2	12	query	f	\N	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Instance","name":"_instance","special_type":"type/Category"},{"base_type":"type/Text","display_name":"Space Type","name":"_space_type","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
8	2017-11-14 14:12:47.594+00	2017-11-14 14:12:47.594+00	Space Data, Count, Grouped by Date (hour-of-day), Sorted by Date, (day) descending	\N	bar	{"database":2,"type":"query","query":{"source_table":12,"breakout":[["datetime-field",["field-id",501],"hour-of-day"]],"aggregation":[["count"]],"order_by":[[["datetime-field",["field-id",501],"hour-of-day"],"descending"]]}}	{}	1	2	12	query	f	\N	\N	\N	f	\N	\N	[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"hour-of-day"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
9	2017-11-14 14:13:59.746+00	2017-11-14 14:13:59.746+00	Space Data, Count, Grouped by Date (day-of-week)	\N	line	{"database":2,"type":"query","query":{"source_table":12,"breakout":[["datetime-field",["field-id",501],"day-of-week"]],"aggregation":[["count"]]}}	{}	1	2	12	query	f	\N	\N	\N	f	\N	\N	[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"day-of-week"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
10	2017-11-18 01:16:53.944+00	2017-11-18 02:55:09.148+00	Registros por Mês	\N	bar	{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"breakout":[["field-id",598],["datetime-field",["field-id",599],"month"]]}}	{"stackable.stack_type":"stacked"}	1	2	16	query	f	1	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
13	2017-11-18 01:22:09.721+00	2017-11-18 02:54:51.013+00	Tipos por Instancia	\N	bar	{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",598],["field-id",596]]}}	{"stackable.stack_type":"stacked","pie.show_legend":false}	1	2	16	query	f	1	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Project Type","name":"_project_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
12	2017-11-18 01:19:39.314+00	2017-11-18 02:55:26.491+00	Porcentagem de Projetos que Aceitam Inscrições Online	\N	pie	{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"breakout":[["field-id",595]]}}	{"stackable.stack_type":"stacked","pie.show_legend":false}	1	2	16	query	f	1	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Online Subscribe","name":"_online_subscribe"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
11	2017-11-18 01:17:45.402+00	2017-11-18 02:55:42.51+00	Crescimento Cumulativo Mensal	\N	line	{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"],["cum_count"]],"breakout":[["datetime-field",["field-id",599],"month"]]}}	{"stackable.stack_type":"stacked"}	1	2	16	query	f	1	\N	\N	t	{}	\N	[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
16	2017-11-19 18:02:10.747+00	2017-11-19 18:08:01.785+00	Porcentagem de Eventos por Faixa Etária	\N	pie	{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["count"]],"breakout":[["field-id",602]]}}	{"stackable.stack_type":"stacked"}	1	2	18	query	f	2	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Age Rage","name":"_age_rage"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
15	2017-11-19 17:59:28.594+00	2017-11-19 18:07:36.646+00	Crescimento Cumulativo Mensal	\N	line	{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",605],"month"]]}}	{"stackable.stack_type":"stacked"}	1	2	18	query	f	2	\N	\N	t	{}	\N	[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
17	2017-11-19 18:03:50.473+00	2017-11-19 18:07:47.727+00	Linguagens por Instância	\N	bar	{"database":2,"type":"query","query":{"source_table":20,"aggregation":[["count"]],"breakout":[["field-id",610],["field-id",608]]}}	{"stackable.stack_type":"normalized"}	1	2	20	query	f	2	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Language","name":"_language"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
14	2017-11-19 17:58:14.276+00	2017-11-19 18:08:12.217+00	Quantidade de Registros por Mês	\N	bar	{"database":2,"type":"query","query":{"source_table":18,"breakout":[["field-id",604],["datetime-field",["field-id",605],"month"]],"aggregation":[["count"]]}}	{"stackable.stack_type":"stacked"}	1	2	18	query	f	2	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
19	2017-11-20 23:05:38.349+00	2017-11-20 23:17:57.119+00	Quantidade de Registros por Temática	\N	bar	{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"breakout":[["field-id",619],["field-id",613]],"order_by":[[["aggregation",0],"descending"]]}}	{}	1	2	22	query	f	3	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Thematic","name":"_thematic"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
18	2017-11-20 23:04:08.622+00	2017-11-20 23:18:15.213+00	Quantidade de Registros por Tipo	\N	bar	{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"breakout":[["field-id",619],["field-id",618]],"order_by":[[["aggregation",0],"descending"]]}}	{}	1	2	22	query	f	3	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Museum Type","name":"_museum_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
28	2017-11-20 23:48:24.569+00	2017-11-20 23:51:33.95+00	Crescimento Cumulativo Mensal	\N	line	{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",630],"month"]]}}	{}	1	2	25	query	f	4	\N	\N	t	{}	\N	[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
22	2017-11-20 23:08:03.853+00	2017-11-20 23:17:02.558+00	Porcentagem por Arquivo com Acesso Público	\N	pie	{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",615]]}}	{}	1	2	22	query	f	3	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Public Archive","name":"_public_archive"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
20	2017-11-20 23:06:35.749+00	2017-11-20 23:17:21.35+00	Porcentagem por Esfera	\N	pie	{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",614]]}}	{}	1	2	22	query	f	3	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Sphere","name":"_sphere"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
21	2017-11-20 23:07:18.266+00	2017-11-20 23:17:41.046+00	Porcentagem por Visita Guiada	\N	pie	{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",616]]}}	{}	1	2	22	query	f	3	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Guided Tu Or","name":"_guided_tuor"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
24	2017-11-20 23:10:58.259+00	2017-11-20 23:16:43.778+00	Crescimento Cumulativo Mensal	\N	line	{"database":2,"type":"query","query":{"source_table":22,"breakout":[["datetime-field",["field-id",620],"month"]],"aggregation":[["cum_count"]]}}	{}	1	2	22	query	f	3	\N	\N	t	{}	\N	[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
25	2017-11-20 23:46:06.796+00	2017-11-20 23:51:43.728+00	Porcentagem por Esfera	\N	pie	{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"breakout":[["field-id",626]]}}	{}	1	2	25	query	f	4	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Sphere","name":"_sphere"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
23	2017-11-20 23:09:02.8+00	2017-11-20 23:18:33.09+00	Registros por Mês	\N	bar	{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",619],["datetime-field",["field-id",620],"month"]]}}	{}	1	2	22	query	f	3	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
26	2017-11-20 23:47:00.348+00	2017-11-20 23:51:58.626+00	Porcentagem por Tipo de Esfera	\N	pie	{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"breakout":[["field-id",627]]}}	{}	1	2	25	query	f	4	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Sphere Type","name":"_sphere_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
29	2017-11-20 23:50:00.67+00	2017-11-20 23:52:08.823+00	Quantidade de Registros por Área	\N	bar	{"database":2,"type":"query","query":{"source_table":23,"aggregation":[["count"]],"breakout":[["field-id",623],["field-id",621]],"order_by":[[["aggregation",0],"descending"]],"limit":25}}	{}	1	2	23	query	f	4	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Area","name":"_area"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
27	2017-11-20 23:47:48.605+00	2017-11-20 23:52:23.277+00	Quantidade de Registros por Mês	\N	bar	{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"breakout":[["field-id",629],["datetime-field",["field-id",630],"month"]]}}	{}	1	2	25	query	f	4	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
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
1	2017-11-11 23:04:31.428+00	2017-11-14 14:14:17.625+00	Espaços	Indicadores criados para as informações de Espaços fornecidas pela plataforma Mapas Culturais do MinC	1	[]	\N	\N	f	\N	\N	t	{}	f	\N
\.


--
-- Data for Name: report_dashboardcard; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY report_dashboardcard (id, created_at, updated_at, "sizeX", "sizeY", "row", col, card_id, dashboard_id, parameter_mappings, visualization_settings) FROM stdin;
2	2017-11-12 21:43:02.934+00	2017-11-14 14:14:17.459+00	9	8	0	0	2	1	[]	{}
3	2017-11-12 23:01:55.335+00	2017-11-14 14:14:17.476+00	9	8	8	0	3	1	[]	{}
4	2017-11-12 23:05:46.611+00	2017-11-14 14:14:17.487+00	9	8	0	9	4	1	[]	{}
5	2017-11-12 23:09:03.988+00	2017-11-14 14:14:17.498+00	9	8	8	9	6	1	[]	{}
6	2017-11-12 23:52:25.488+00	2017-11-14 14:14:17.509+00	18	10	16	0	7	1	[]	{}
7	2017-11-14 14:13:01.5+00	2017-11-14 14:14:17.52+00	4	4	26	0	8	1	[]	{}
8	2017-11-14 14:14:17.36+00	2017-11-14 14:14:17.532+00	4	4	26	4	9	1	[]	{}
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
37	Card	7	1	2017-11-12 23:51:12.946+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Space Type","name":"_space_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Space Data, Count, Grouped by Instance and Space Type","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"breakout":[["field-id",500],["field-id",498]]}},"id":7,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked","graph.x_axis.title_text":"","graph.y_axis.scale":"linear","graph.y_axis.auto_split":true,"graph.x_axis.axis_enabled":true,"graph.y_axis.axis_enabled":true,"graph.y_axis.auto_range":true},"public_uuid":null}	f	t	\N
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
100	Card	16	1	2017-11-19 18:02:10.779+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Text","display_name":"Age Rage","name":"_age_rage"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Porcentagem de Eventos por Faixa Etária","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["count"]],"breakout":[["field-id",602]]}},"id":16,"display":"pie","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	t	\N
63	Card	4	1	2017-11-14 00:19:10.135+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"breakout":[["datetime-field",["field-id",501],"month"]],"aggregation":[["cum_count"]]}},"id":4,"display":"line","visualization_settings":{"line.interpolate":"cardinal","line.marker_enabled":true},"public_uuid":null}	f	f	\N
64	Card	4	1	2017-11-14 00:19:10.367+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"breakout":[["datetime-field",["field-id",501],"month"]],"aggregation":[["cum_count"]]}},"id":4,"display":"line","visualization_settings":{"line.interpolate":"cardinal","line.marker_enabled":true},"public_uuid":null}	f	f	\N
65	Card	3	1	2017-11-14 00:24:14.116+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Quantidade de Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"breakout":[["datetime-field",["field-id",501],"month"],["field-id",500]]}},"id":3,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
66	Card	3	1	2017-11-14 00:24:14.161+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Quantidade de Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"breakout":[["datetime-field",["field-id",501],"month"],["field-id",500]]}},"id":3,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
67	Card	6	1	2017-11-14 00:25:00.662+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Crescimento Cumulativo Mensal por Instância","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",501],"month"],["field-id",500]]}},"id":6,"display":"line","visualization_settings":{"line.interpolate":"cardinal","line.marker_enabled":true},"public_uuid":null}	f	f	\N
68	Card	6	1	2017-11-14 00:25:00.716+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Crescimento Cumulativo Mensal por Instância","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",501],"month"],["field-id",500]]}},"id":6,"display":"line","visualization_settings":{"line.interpolate":"cardinal","line.marker_enabled":true},"public_uuid":null}	f	f	\N
69	Card	7	1	2017-11-14 00:25:30.426+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Space Type","name":"_space_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Tipos por Instância","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"breakout":[["field-id",500],["field-id",498]]}},"id":7,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked","graph.x_axis.title_text":"","graph.y_axis.scale":"linear","graph.y_axis.auto_split":true,"graph.x_axis.axis_enabled":true,"graph.y_axis.axis_enabled":true,"graph.y_axis.auto_range":true},"public_uuid":null}	f	f	\N
70	Card	7	1	2017-11-14 00:25:30.473+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Space Type","name":"_space_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Tipos por Instância","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"breakout":[["field-id",500],["field-id",498]]}},"id":7,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked","graph.x_axis.title_text":"","graph.y_axis.scale":"linear","graph.y_axis.auto_split":true,"graph.x_axis.axis_enabled":true,"graph.y_axis.axis_enabled":true,"graph.y_axis.auto_range":true},"public_uuid":null}	f	f	\N
71	Card	2	1	2017-11-14 06:15:27.844+00	{"description":null,"archived":false,"table_id":15,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Occupation Area","name":"_occupation_area"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Áreas de Atuação por Instância","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":15,"aggregation":[["count"]],"breakout":[["field-id",594],["field-id",592]]}},"id":2,"display":"bar","visualization_settings":{"stackable.stack_type":"normalized"},"public_uuid":null}	f	f	\N
72	Card	6	1	2017-11-14 13:45:43.255+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Crescimento Cumulativo Mensal por Instância","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",501],"month"],["field-id",500]]}},"id":6,"display":"line","visualization_settings":{"line.interpolate":"linear","line.marker_enabled":true},"public_uuid":null}	f	f	\N
73	Card	7	1	2017-11-14 14:07:36.104+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance","special_type":"type/Category"},{"base_type":"type/Text","display_name":"Space Type","name":"_space_type","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Tipos por Instância","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"breakout":[["field-id",500],["field-id",498]],"order_by":[[["aggregation",0],"descending"]],"limit":25}},"id":7,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked","graph.x_axis.title_text":"","graph.y_axis.scale":"linear","graph.y_axis.auto_split":true,"graph.x_axis.axis_enabled":true,"graph.y_axis.axis_enabled":true,"graph.y_axis.auto_range":true},"public_uuid":null}	f	f	\N
74	Card	8	1	2017-11-14 14:12:47.705+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"hour-of-day"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Space Data, Count, Grouped by Date (hour-of-day), Sorted by Date, (day) descending","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"breakout":[["datetime-field",["field-id",501],"hour-of-day"]],"aggregation":[["count"]],"order_by":[[["datetime-field",["field-id",501],"hour-of-day"],"descending"]]}},"id":8,"display":"bar","visualization_settings":{},"public_uuid":null}	f	t	\N
75	Dashboard	1	1	2017-11-14 14:13:01.588+00	{"description":"Indicadores criados para as informações de Espaços fornecidas pela plataforma Mapas Culturais do MinC","name":"Espaços","cards":[{"sizeX":9,"sizeY":8,"row":0,"col":0,"id":2,"card_id":2,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":0,"id":3,"card_id":3,"series":[]},{"sizeX":9,"sizeY":8,"row":0,"col":9,"id":4,"card_id":4,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":9,"id":5,"card_id":6,"series":[]},{"sizeX":18,"sizeY":10,"row":16,"col":0,"id":6,"card_id":7,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":7,"card_id":8,"series":[]}]}	f	f	\N
76	Dashboard	1	1	2017-11-14 14:13:01.732+00	{"description":"Indicadores criados para as informações de Espaços fornecidas pela plataforma Mapas Culturais do MinC","name":"Espaços","cards":[{"sizeX":9,"sizeY":8,"row":0,"col":0,"id":2,"card_id":2,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":0,"id":3,"card_id":3,"series":[]},{"sizeX":9,"sizeY":8,"row":0,"col":9,"id":4,"card_id":4,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":9,"id":5,"card_id":6,"series":[]},{"sizeX":18,"sizeY":10,"row":16,"col":0,"id":6,"card_id":7,"series":[]},{"sizeX":4,"sizeY":4,"row":26,"col":0,"id":7,"card_id":8,"series":[]}]}	f	f	\N
77	Dashboard	1	1	2017-11-14 14:13:01.825+00	{"description":"Indicadores criados para as informações de Espaços fornecidas pela plataforma Mapas Culturais do MinC","name":"Espaços","cards":[{"sizeX":9,"sizeY":8,"row":0,"col":0,"id":2,"card_id":2,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":0,"id":3,"card_id":3,"series":[]},{"sizeX":9,"sizeY":8,"row":0,"col":9,"id":4,"card_id":4,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":9,"id":5,"card_id":6,"series":[]},{"sizeX":18,"sizeY":10,"row":16,"col":0,"id":6,"card_id":7,"series":[]},{"sizeX":4,"sizeY":4,"row":26,"col":0,"id":7,"card_id":8,"series":[]}]}	f	f	\N
78	Card	9	1	2017-11-14 14:13:59.816+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"day-of-week"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Space Data, Count, Grouped by Date (day-of-week)","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"breakout":[["datetime-field",["field-id",501],"day-of-week"]],"aggregation":[["count"]]}},"id":9,"display":"line","visualization_settings":{},"public_uuid":null}	f	t	\N
79	Dashboard	1	1	2017-11-14 14:14:17.419+00	{"description":"Indicadores criados para as informações de Espaços fornecidas pela plataforma Mapas Culturais do MinC","name":"Espaços","cards":[{"sizeX":9,"sizeY":8,"row":0,"col":0,"id":2,"card_id":2,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":0,"id":3,"card_id":3,"series":[]},{"sizeX":9,"sizeY":8,"row":0,"col":9,"id":4,"card_id":4,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":9,"id":5,"card_id":6,"series":[]},{"sizeX":18,"sizeY":10,"row":16,"col":0,"id":6,"card_id":7,"series":[]},{"sizeX":4,"sizeY":4,"row":26,"col":0,"id":7,"card_id":8,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":8,"card_id":9,"series":[]}]}	f	f	\N
80	Dashboard	1	1	2017-11-14 14:14:17.607+00	{"description":"Indicadores criados para as informações de Espaços fornecidas pela plataforma Mapas Culturais do MinC","name":"Espaços","cards":[{"sizeX":9,"sizeY":8,"row":0,"col":0,"id":2,"card_id":2,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":0,"id":3,"card_id":3,"series":[]},{"sizeX":9,"sizeY":8,"row":0,"col":9,"id":4,"card_id":4,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":9,"id":5,"card_id":6,"series":[]},{"sizeX":18,"sizeY":10,"row":16,"col":0,"id":6,"card_id":7,"series":[]},{"sizeX":4,"sizeY":4,"row":26,"col":0,"id":7,"card_id":8,"series":[]},{"sizeX":4,"sizeY":4,"row":26,"col":4,"id":8,"card_id":9,"series":[]}]}	f	f	\N
81	Dashboard	1	1	2017-11-14 14:14:17.681+00	{"description":"Indicadores criados para as informações de Espaços fornecidas pela plataforma Mapas Culturais do MinC","name":"Espaços","cards":[{"sizeX":9,"sizeY":8,"row":0,"col":0,"id":2,"card_id":2,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":0,"id":3,"card_id":3,"series":[]},{"sizeX":9,"sizeY":8,"row":0,"col":9,"id":4,"card_id":4,"series":[]},{"sizeX":9,"sizeY":8,"row":8,"col":9,"id":5,"card_id":6,"series":[]},{"sizeX":18,"sizeY":10,"row":16,"col":0,"id":6,"card_id":7,"series":[]},{"sizeX":4,"sizeY":4,"row":26,"col":0,"id":7,"card_id":8,"series":[]},{"sizeX":4,"sizeY":4,"row":26,"col":4,"id":8,"card_id":9,"series":[]}]}	f	f	\N
82	Card	10	1	2017-11-18 01:16:53.979+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"breakout":[["field-id",598],["datetime-field",["field-id",599],"month"]]}},"id":10,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	t	\N
83	Card	11	1	2017-11-18 01:17:45.437+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"],["cum_count"]],"breakout":[["datetime-field",["field-id",599],"month"]]}},"id":11,"display":"line","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	t	\N
84	Card	12	1	2017-11-18 01:19:39.341+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Text","display_name":"Online Subscribe","name":"_online_subscribe"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Porcentagem de Projetos que Aceitam Inscrições Online","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"breakout":[["field-id",595]]}},"id":12,"display":"pie","visualization_settings":{"stackable.stack_type":"stacked","pie.show_legend":false},"public_uuid":null}	f	t	\N
85	Card	13	1	2017-11-18 01:22:09.755+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Project Type","name":"_project_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Tipos por Instancia","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",598],["field-id",596]]}},"id":13,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked","pie.show_legend":false},"public_uuid":null}	f	t	\N
86	Card	11	1	2017-11-18 02:49:25.822+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":1,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"],["cum_count"]],"breakout":[["datetime-field",["field-id",599],"month"]]}},"id":11,"display":"line","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
87	Card	12	1	2017-11-18 02:49:36.67+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Text","display_name":"Online Subscribe","name":"_online_subscribe"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":1,"query_type":"query","name":"Porcentagem de Projetos que Aceitam Inscrições Online","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"breakout":[["field-id",595]]}},"id":12,"display":"pie","visualization_settings":{"stackable.stack_type":"stacked","pie.show_legend":false},"public_uuid":null}	f	f	\N
88	Card	10	1	2017-11-18 02:49:47.311+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":1,"query_type":"query","name":"Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"breakout":[["field-id",598],["datetime-field",["field-id",599],"month"]]}},"id":10,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
89	Card	13	1	2017-11-18 02:49:54.506+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Project Type","name":"_project_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":1,"query_type":"query","name":"Tipos por Instancia","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",598],["field-id",596]]}},"id":13,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked","pie.show_legend":false},"public_uuid":null}	f	f	\N
90	Card	13	1	2017-11-18 02:54:50.964+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Project Type","name":"_project_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":1,"query_type":"query","name":"Tipos por Instancia","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",598],["field-id",596]]}},"id":13,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked","pie.show_legend":false},"public_uuid":null}	f	f	\N
91	Card	13	1	2017-11-18 02:54:51.026+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Project Type","name":"_project_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":1,"query_type":"query","name":"Tipos por Instancia","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",598],["field-id",596]]}},"id":13,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked","pie.show_legend":false},"public_uuid":null}	f	f	\N
92	Card	10	1	2017-11-18 02:55:09.106+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":1,"query_type":"query","name":"Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"breakout":[["field-id",598],["datetime-field",["field-id",599],"month"]]}},"id":10,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
93	Card	10	1	2017-11-18 02:55:09.18+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":1,"query_type":"query","name":"Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"breakout":[["field-id",598],["datetime-field",["field-id",599],"month"]]}},"id":10,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
94	Card	12	1	2017-11-18 02:55:26.454+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Text","display_name":"Online Subscribe","name":"_online_subscribe"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":1,"query_type":"query","name":"Porcentagem de Projetos que Aceitam Inscrições Online","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"breakout":[["field-id",595]]}},"id":12,"display":"pie","visualization_settings":{"stackable.stack_type":"stacked","pie.show_legend":false},"public_uuid":null}	f	f	\N
95	Card	12	1	2017-11-18 02:55:26.506+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Text","display_name":"Online Subscribe","name":"_online_subscribe"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":1,"query_type":"query","name":"Porcentagem de Projetos que Aceitam Inscrições Online","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"breakout":[["field-id",595]]}},"id":12,"display":"pie","visualization_settings":{"stackable.stack_type":"stacked","pie.show_legend":false},"public_uuid":null}	f	f	\N
96	Card	11	1	2017-11-18 02:55:42.479+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":1,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"],["cum_count"]],"breakout":[["datetime-field",["field-id",599],"month"]]}},"id":11,"display":"line","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
97	Card	11	1	2017-11-18 02:55:42.525+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":1,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"],["cum_count"]],"breakout":[["datetime-field",["field-id",599],"month"]]}},"id":11,"display":"line","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
98	Card	14	1	2017-11-19 17:58:14.308+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Quantidade de Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"breakout":[["field-id",604],["datetime-field",["field-id",605],"month"]],"aggregation":[["count"]]}},"id":14,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	t	\N
99	Card	15	1	2017-11-19 17:59:28.616+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",605],"month"]]}},"id":15,"display":"line","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	t	\N
101	Card	17	1	2017-11-19 18:03:50.505+00	{"description":null,"archived":false,"table_id":20,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Language","name":"_language"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Linguagens por Instância","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":20,"aggregation":[["count"]],"breakout":[["field-id",610],["field-id",608]]}},"id":17,"display":"bar","visualization_settings":{"stackable.stack_type":"normalized"},"public_uuid":null}	f	t	\N
102	Card	15	1	2017-11-19 18:04:13.032+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":2,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",605],"month"]]}},"id":15,"display":"line","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
112	Card	14	1	2017-11-19 18:08:12.152+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":2,"query_type":"query","name":"Quantidade de Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"breakout":[["field-id",604],["datetime-field",["field-id",605],"month"]],"aggregation":[["count"]]}},"id":14,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
103	Card	17	1	2017-11-19 18:04:25.22+00	{"description":null,"archived":false,"table_id":20,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Language","name":"_language"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":2,"query_type":"query","name":"Linguagens por Instância","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":20,"aggregation":[["count"]],"breakout":[["field-id",610],["field-id",608]]}},"id":17,"display":"bar","visualization_settings":{"stackable.stack_type":"normalized"},"public_uuid":null}	f	f	\N
104	Card	16	1	2017-11-19 18:04:39.1+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Text","display_name":"Age Rage","name":"_age_rage"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":2,"query_type":"query","name":"Porcentagem de Eventos por Faixa Etária","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["count"]],"breakout":[["field-id",602]]}},"id":16,"display":"pie","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
105	Card	14	1	2017-11-19 18:04:46.958+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":2,"query_type":"query","name":"Quantidade de Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"breakout":[["field-id",604],["datetime-field",["field-id",605],"month"]],"aggregation":[["count"]]}},"id":14,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
106	Card	15	1	2017-11-19 18:07:36.578+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":2,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",605],"month"]]}},"id":15,"display":"line","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
107	Card	15	1	2017-11-19 18:07:36.66+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":2,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",605],"month"]]}},"id":15,"display":"line","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
108	Card	17	1	2017-11-19 18:07:47.644+00	{"description":null,"archived":false,"table_id":20,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Language","name":"_language"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":2,"query_type":"query","name":"Linguagens por Instância","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":20,"aggregation":[["count"]],"breakout":[["field-id",610],["field-id",608]]}},"id":17,"display":"bar","visualization_settings":{"stackable.stack_type":"normalized"},"public_uuid":null}	f	f	\N
116	Card	20	1	2017-11-20 23:06:35.779+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Sphere","name":"_sphere"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Porcentagem por Esfera","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",614]]}},"id":20,"display":"pie","visualization_settings":{},"public_uuid":null}	f	t	\N
109	Card	17	1	2017-11-19 18:07:47.743+00	{"description":null,"archived":false,"table_id":20,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Language","name":"_language"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":2,"query_type":"query","name":"Linguagens por Instância","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":20,"aggregation":[["count"]],"breakout":[["field-id",610],["field-id",608]]}},"id":17,"display":"bar","visualization_settings":{"stackable.stack_type":"normalized"},"public_uuid":null}	f	f	\N
110	Card	16	1	2017-11-19 18:08:01.706+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Text","display_name":"Age Rage","name":"_age_rage"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":2,"query_type":"query","name":"Porcentagem de Eventos por Faixa Etária","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["count"]],"breakout":[["field-id",602]]}},"id":16,"display":"pie","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
111	Card	16	1	2017-11-19 18:08:01.801+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Text","display_name":"Age Rage","name":"_age_rage"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":2,"query_type":"query","name":"Porcentagem de Eventos por Faixa Etária","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["count"]],"breakout":[["field-id",602]]}},"id":16,"display":"pie","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
113	Card	14	1	2017-11-19 18:08:12.238+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":2,"query_type":"query","name":"Quantidade de Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"breakout":[["field-id",604],["datetime-field",["field-id",605],"month"]],"aggregation":[["count"]]}},"id":14,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
114	Card	18	1	2017-11-20 23:04:08.671+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Museum Type","name":"_museum_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Quantidade de Registros por Tipo","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"breakout":[["field-id",619],["field-id",618]],"order_by":[[["aggregation",0],"descending"]]}},"id":18,"display":"bar","visualization_settings":{},"public_uuid":null}	f	t	\N
115	Card	19	1	2017-11-20 23:05:38.372+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Thematic","name":"_thematic"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Quantidade de Registros por Temática","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"breakout":[["field-id",619],["field-id",613]],"order_by":[[["aggregation",0],"descending"]]}},"id":19,"display":"bar","visualization_settings":{},"public_uuid":null}	f	t	\N
117	Card	21	1	2017-11-20 23:07:18.297+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Guided Tu Or","name":"_guided_tuor"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Porcentagem por Visita Guiada","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",616]]}},"id":21,"display":"pie","visualization_settings":{},"public_uuid":null}	f	t	\N
118	Card	22	1	2017-11-20 23:08:03.869+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Public Archive","name":"_public_archive"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Porcentagem por Arquivo com Acesso Público","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",615]]}},"id":22,"display":"pie","visualization_settings":{},"public_uuid":null}	f	t	\N
119	Card	23	1	2017-11-20 23:09:02.829+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",619],["datetime-field",["field-id",620],"month"]]}},"id":23,"display":"bar","visualization_settings":{},"public_uuid":null}	f	t	\N
120	Card	24	1	2017-11-20 23:10:58.289+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Crscimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"breakout":[["datetime-field",["field-id",620],"month"]],"aggregation":[["cum_count"]]}},"id":24,"display":"line","visualization_settings":{},"public_uuid":null}	f	t	\N
121	Card	24	1	2017-11-20 23:11:14.565+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"breakout":[["datetime-field",["field-id",620],"month"]],"aggregation":[["cum_count"]]}},"id":24,"display":"line","visualization_settings":{},"public_uuid":null}	f	f	\N
122	Card	24	1	2017-11-20 23:11:47.148+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":3,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"breakout":[["datetime-field",["field-id",620],"month"]],"aggregation":[["cum_count"]]}},"id":24,"display":"line","visualization_settings":{},"public_uuid":null}	f	f	\N
124	Card	20	1	2017-11-20 23:11:59.63+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Sphere","name":"_sphere"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":3,"query_type":"query","name":"Porcentagem por Esfera","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",614]]}},"id":20,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
132	Card	22	1	2017-11-20 23:17:02.569+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Public Archive","name":"_public_archive"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Porcentagem por Arquivo com Acesso Público","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",615]]}},"id":22,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
162	Card	27	1	2017-11-20 23:52:23.289+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":4,"query_type":"query","name":"Quantidade de Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"breakout":[["field-id",629],["datetime-field",["field-id",630],"month"]]}},"id":27,"display":"bar","visualization_settings":{},"public_uuid":null}	f	f	\N
123	Card	22	1	2017-11-20 23:11:53.696+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Public Archive","name":"_public_archive"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":3,"query_type":"query","name":"Porcentagem por Arquivo com Acesso Público","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",615]]}},"id":22,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
125	Card	21	1	2017-11-20 23:12:09.689+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Guided Tu Or","name":"_guided_tuor"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":3,"query_type":"query","name":"Porcentagem por Visita Guiada","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",616]]}},"id":21,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
126	Card	19	1	2017-11-20 23:12:21.435+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Thematic","name":"_thematic"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":3,"query_type":"query","name":"Quantidade de Registros por Temática","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"breakout":[["field-id",619],["field-id",613]],"order_by":[[["aggregation",0],"descending"]]}},"id":19,"display":"bar","visualization_settings":{},"public_uuid":null}	f	f	\N
129	Card	24	1	2017-11-20 23:16:43.734+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"breakout":[["datetime-field",["field-id",620],"month"]],"aggregation":[["cum_count"]]}},"id":24,"display":"line","visualization_settings":{},"public_uuid":null}	f	f	\N
130	Card	24	1	2017-11-20 23:16:43.79+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"breakout":[["datetime-field",["field-id",620],"month"]],"aggregation":[["cum_count"]]}},"id":24,"display":"line","visualization_settings":{},"public_uuid":null}	f	f	\N
133	Card	20	1	2017-11-20 23:17:21.252+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Sphere","name":"_sphere"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Porcentagem por Esfera","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",614]]}},"id":20,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
134	Card	20	1	2017-11-20 23:17:21.359+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Sphere","name":"_sphere"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Porcentagem por Esfera","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",614]]}},"id":20,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
135	Card	21	1	2017-11-20 23:17:40.967+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Guided Tu Or","name":"_guided_tuor"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Porcentagem por Visita Guiada","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",616]]}},"id":21,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
137	Card	19	1	2017-11-20 23:17:57.03+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Thematic","name":"_thematic"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Quantidade de Registros por Temática","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"breakout":[["field-id",619],["field-id",613]],"order_by":[[["aggregation",0],"descending"]]}},"id":19,"display":"bar","visualization_settings":{},"public_uuid":null}	f	f	\N
138	Card	19	1	2017-11-20 23:17:57.125+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Thematic","name":"_thematic"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Quantidade de Registros por Temática","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"breakout":[["field-id",619],["field-id",613]],"order_by":[[["aggregation",0],"descending"]]}},"id":19,"display":"bar","visualization_settings":{},"public_uuid":null}	f	f	\N
127	Card	18	1	2017-11-20 23:12:26.673+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Museum Type","name":"_museum_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":3,"query_type":"query","name":"Quantidade de Registros por Tipo","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"breakout":[["field-id",619],["field-id",618]],"order_by":[[["aggregation",0],"descending"]]}},"id":18,"display":"bar","visualization_settings":{},"public_uuid":null}	f	f	\N
131	Card	22	1	2017-11-20 23:17:02.491+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Public Archive","name":"_public_archive"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Porcentagem por Arquivo com Acesso Público","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",615]]}},"id":22,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
146	Card	28	1	2017-11-20 23:48:24.581+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",630],"month"]]}},"id":28,"display":"line","visualization_settings":{},"public_uuid":null}	f	t	\N
149	Card	25	1	2017-11-20 23:50:49.098+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/Text","display_name":"Sphere","name":"_sphere"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":4,"query_type":"query","name":"Porcentagem por Esfera","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"breakout":[["field-id",626]]}},"id":25,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
152	Card	27	1	2017-11-20 23:51:10.709+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":4,"query_type":"query","name":"Quantidade de Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"breakout":[["field-id",629],["datetime-field",["field-id",630],"month"]]}},"id":27,"display":"bar","visualization_settings":{},"public_uuid":null}	f	f	\N
158	Card	26	1	2017-11-20 23:51:58.637+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/Text","display_name":"Sphere Type","name":"_sphere_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":4,"query_type":"query","name":"Porcentagem por Tipo de Esfera","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"breakout":[["field-id",627]]}},"id":26,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
128	Card	23	1	2017-11-20 23:12:32.963+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":3,"query_type":"query","name":"Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",619],["datetime-field",["field-id",620],"month"]]}},"id":23,"display":"bar","visualization_settings":{},"public_uuid":null}	f	f	\N
136	Card	21	1	2017-11-20 23:17:41.056+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Guided Tu Or","name":"_guided_tuor"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Porcentagem por Visita Guiada","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",616]]}},"id":21,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
139	Card	18	1	2017-11-20 23:18:15.131+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Museum Type","name":"_museum_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Quantidade de Registros por Tipo","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"breakout":[["field-id",619],["field-id",618]],"order_by":[[["aggregation",0],"descending"]]}},"id":18,"display":"bar","visualization_settings":{},"public_uuid":null}	f	f	\N
141	Card	23	1	2017-11-20 23:18:33.006+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",619],["datetime-field",["field-id",620],"month"]]}},"id":23,"display":"bar","visualization_settings":{},"public_uuid":null}	f	f	\N
145	Card	27	1	2017-11-20 23:47:48.637+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Quantidade de Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"breakout":[["field-id",629],["datetime-field",["field-id",630],"month"]]}},"id":27,"display":"bar","visualization_settings":{},"public_uuid":null}	f	t	\N
150	Card	26	1	2017-11-20 23:50:54.637+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/Text","display_name":"Sphere Type","name":"_sphere_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":4,"query_type":"query","name":"Porcentagem por Tipo de Esfera","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"breakout":[["field-id",627]]}},"id":26,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
151	Card	29	1	2017-11-20 23:51:04.676+00	{"description":null,"archived":false,"table_id":23,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Area","name":"_area"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":4,"query_type":"query","name":"Quantidade de Registros por Área","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":23,"aggregation":[["count"]],"breakout":[["field-id",623],["field-id",621]],"order_by":[[["aggregation",0],"descending"]],"limit":25}},"id":29,"display":"bar","visualization_settings":{},"public_uuid":null}	f	f	\N
153	Card	28	1	2017-11-20 23:51:33.894+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":4,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",630],"month"]]}},"id":28,"display":"line","visualization_settings":{},"public_uuid":null}	f	f	\N
157	Card	26	1	2017-11-20 23:51:58.565+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/Text","display_name":"Sphere Type","name":"_sphere_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":4,"query_type":"query","name":"Porcentagem por Tipo de Esfera","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"breakout":[["field-id",627]]}},"id":26,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
159	Card	29	1	2017-11-20 23:52:08.748+00	{"description":null,"archived":false,"table_id":23,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Area","name":"_area"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":4,"query_type":"query","name":"Quantidade de Registros por Área","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":23,"aggregation":[["count"]],"breakout":[["field-id",623],["field-id",621]],"order_by":[[["aggregation",0],"descending"]],"limit":25}},"id":29,"display":"bar","visualization_settings":{},"public_uuid":null}	f	f	\N
140	Card	18	1	2017-11-20 23:18:15.224+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Museum Type","name":"_museum_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Quantidade de Registros por Tipo","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"breakout":[["field-id",619],["field-id",618]],"order_by":[[["aggregation",0],"descending"]]}},"id":18,"display":"bar","visualization_settings":{},"public_uuid":null}	f	f	\N
148	Card	28	1	2017-11-20 23:50:36.295+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":4,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",630],"month"]]}},"id":28,"display":"line","visualization_settings":{},"public_uuid":null}	f	f	\N
155	Card	25	1	2017-11-20 23:51:43.669+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/Text","display_name":"Sphere","name":"_sphere"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":4,"query_type":"query","name":"Porcentagem por Esfera","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"breakout":[["field-id",626]]}},"id":25,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
142	Card	23	1	2017-11-20 23:18:33.102+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",619],["datetime-field",["field-id",620],"month"]]}},"id":23,"display":"bar","visualization_settings":{},"public_uuid":null}	f	f	\N
156	Card	25	1	2017-11-20 23:51:43.736+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/Text","display_name":"Sphere","name":"_sphere"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":4,"query_type":"query","name":"Porcentagem por Esfera","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"breakout":[["field-id",626]]}},"id":25,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
143	Card	25	1	2017-11-20 23:46:06.812+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/Text","display_name":"Sphere","name":"_sphere"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Porcentagem por Esfera","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"breakout":[["field-id",626]]}},"id":25,"display":"pie","visualization_settings":{},"public_uuid":null}	f	t	\N
144	Card	26	1	2017-11-20 23:47:00.376+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/Text","display_name":"Sphere Type","name":"_sphere_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Porcentagem por Tipo de Esfera","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"breakout":[["field-id",627]]}},"id":26,"display":"pie","visualization_settings":{},"public_uuid":null}	f	t	\N
147	Card	29	1	2017-11-20 23:50:00.688+00	{"description":null,"archived":false,"table_id":23,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Area","name":"_area"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Quantidade de Registros por Área","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":23,"aggregation":[["count"]],"breakout":[["field-id",623],["field-id",621]],"order_by":[[["aggregation",0],"descending"]],"limit":25}},"id":29,"display":"bar","visualization_settings":{},"public_uuid":null}	f	t	\N
154	Card	28	1	2017-11-20 23:51:33.983+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":4,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",630],"month"]]}},"id":28,"display":"line","visualization_settings":{},"public_uuid":null}	f	f	\N
160	Card	29	1	2017-11-20 23:52:08.836+00	{"description":null,"archived":false,"table_id":23,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Area","name":"_area"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":4,"query_type":"query","name":"Quantidade de Registros por Área","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":23,"aggregation":[["count"]],"breakout":[["field-id",623],["field-id",621]],"order_by":[[["aggregation",0],"descending"]],"limit":25}},"id":29,"display":"bar","visualization_settings":{},"public_uuid":null}	f	f	\N
161	Card	27	1	2017-11-20 23:52:23.185+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":4,"query_type":"query","name":"Quantidade de Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"breakout":[["field-id",629],["datetime-field",["field-id",630],"month"]]}},"id":27,"display":"bar","visualization_settings":{},"public_uuid":null}	f	f	\N
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
version-info	{"latest":{"version":"v0.26.2","released":"2017-09-27T11:09:36.358Z","patch":true,"highlights":["Update Redshift Driver","Support Java 9","Fix performance issue with fields listing"]},"older":[{"version":"v0.26.1","released":"2017-09-27T11:09:36.358Z","patch":true,"highlights":["Fix migration issue on MySQL"]},{"version":"v0.26.0","released":"2017-09-26T11:09:36.358Z","patch":true,"highlights":["Segment + Metric X-Rays and Comparisons","Better control over metadata introspection process","Improved Timezone support and bug fixes"]},{"version":"v0.25.2","released":"2017-08-09T11:09:36.358Z","patch":true,"highlights":["Bug and performance fixes"]},{"version":"v0.25.1","released":"2017-07-27T11:09:36.358Z","patch":true,"highlights":["After upgrading to 0.25, unknown protocol error.","Don't show saved questions in the permissions database lists","Elastic beanstalk upgrades broken in 0.25 "]},{"version":"v0.25.0","released":"2017-07-25T11:09:36.358Z","patch":false,"highlights":["Nested questions","Enum and custom remapping support","LDAP authentication support"]},{"version":"v0.24.2","released":"2017-06-01T11:09:36.358Z","patch":true,"highlights":["Misc Bug fixes"]},{"version":"v0.24.1","released":"2017-05-10T11:09:36.358Z","patch":true,"highlights":["Fix upgrades with MySQL/Mariadb"]},{"version":"v0.24.0","released":"2017-05-10T11:09:36.358Z","patch":false,"highlights":["Drill-through + Actions","Result Caching","Presto Driver"]},{"version":"v0.23.1","released":"2017-03-30T11:09:36.358Z","patch":true,"highlights":["Filter widgets for SQL Template Variables","Fix spurious startup error","Java 7 startup bug fixed"]},{"version":"v0.23.0","released":"2017-03-21T11:09:36.358Z","patch":false,"highlights":["Public links for cards + dashboards","Embedding cards + dashboards in other applications","Encryption of database credentials"]},{"version":"v0.22.2","released":"2017-01-10T11:09:36.358Z","patch":true,"highlights":["Fix startup on OpenJDK 7"]},{"version":"v0.22.1","released":"2017-01-10T11:09:36.358Z","patch":true,"highlights":["IMPORTANT: Closed a Collections Permissions security hole","Improved startup performance","Bug fixes"]},{"version":"v0.22.0","released":"2017-01-10T11:09:36.358Z","patch":false,"highlights":["Collections + Collections Permissions","Multiple Aggregations","Custom Expressions"]},{"version":"v0.21.1","released":"2016-12-08T11:09:36.358Z","patch":true,"highlights":["BigQuery bug fixes","Charting bug fixes"]},{"version":"v0.21.0","released":"2016-12-08T11:09:36.358Z","patch":false,"highlights":["Google Analytics Driver","Vertica Driver","Better Time + Date Filters"]},{"version":"v0.20.3","released":"2016-10-26T11:09:36.358Z","patch":true,"highlights":["Fix H2->MySQL/PostgreSQL migrations, part 2"]},{"version":"v0.20.2","released":"2016-10-25T11:09:36.358Z","patch":true,"highlights":["Support Oracle 10+11","Fix H2->MySQL/PostgreSQL migrations","Revision timestamp fix"]},{"version":"v0.20.1","released":"2016-10-18T11:09:36.358Z","patch":true,"highlights":["Lots of bug fixes"]},{"version":"v0.20.0","released":"2016-10-11T11:09:36.358Z","patch":false,"highlights":["Data access permissions","Oracle Driver","Charting improvements"]},{"version":"v0.19.3","released":"2016-08-12T11:09:36.358Z","patch":true,"highlights":["fix Dashboard editing header"]},{"version":"v0.19.2","released":"2016-08-10T11:09:36.358Z","patch":true,"highlights":["fix Dashboard chart titles","fix pin map saving"]},{"version":"v0.19.1","released":"2016-08-04T11:09:36.358Z","patch":true,"highlights":["fix Dashboard Filter Editing","fix CSV Download of SQL Templates","fix Metabot enabled toggle"]},{"version":"v0.19.0","released":"2016-08-01T21:09:36.358Z","patch":false,"highlights":["SSO via Google Accounts","SQL Templates","Better charting controls"]},{"version":"v0.18.1","released":"2016-06-29T21:09:36.358Z","patch":true,"highlights":["Fix for Hour of day sorting bug","Fix for Column ordering bug in BigQuery","Fix for Mongo charting bug"]},{"version":"v0.18.0","released":"2016-06-022T21:09:36.358Z","patch":false,"highlights":["Dashboard Filters","Crate.IO Support","Checklist for Metabase Admins","Converting Metabase Questions -> SQL"]},{"version":"v0.17.1","released":"2016-05-04T21:09:36.358Z","patch":true,"highlights":["Fix for Line chart ordering bug","Fix for Time granularity bugs"]},{"version":"v0.17.0","released":"2016-05-04T21:09:36.358Z","patch":false,"highlights":["Tags + Search for Saved Questions","Calculated columns","Faster Syncing of Metadata","Lots of database driver improvements and bug fixes"]},{"version":"v0.16.1","released":"2016-05-04T21:09:36.358Z","patch":true,"highlights":["Fixes for several time alignment issues (timezones)","Resolved problem with SQL Server db connections"]},{"version":"v0.16.0","released":"2016-05-04T21:09:36.358Z","patch":false,"highlights":["Fullscreen (and fabulous) Dashboards","Say hello to Metabot in Slack"]}]}
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
87	1	dashboard	1	2017-11-13 23:18:20.238+00
88	1	card	2	2017-11-13 23:19:35.692+00
89	1	dashboard	1	2017-11-13 23:19:39.274+00
90	1	card	2	2017-11-13 23:19:53.234+00
91	1	dashboard	1	2017-11-13 23:20:02.462+00
92	1	card	2	2017-11-13 23:20:14.839+00
93	1	dashboard	1	2017-11-13 23:20:20.498+00
94	1	card	2	2017-11-13 23:20:32.265+00
95	1	card	2	2017-11-13 23:21:29.808+00
96	1	dashboard	1	2017-11-13 23:21:35.611+00
97	1	dashboard	1	2017-11-13 23:22:02.945+00
98	1	dashboard	1	2017-11-14 00:18:54.095+00
99	1	card	4	2017-11-14 00:19:00.181+00
100	1	card	4	2017-11-14 00:23:53.745+00
101	1	dashboard	1	2017-11-14 00:23:58.084+00
102	1	card	3	2017-11-14 00:24:02.802+00
103	1	card	3	2017-11-14 00:24:38.867+00
104	1	dashboard	1	2017-11-14 00:24:43.044+00
105	1	card	6	2017-11-14 00:24:46.217+00
106	1	card	6	2017-11-14 00:25:14.291+00
107	1	dashboard	1	2017-11-14 00:25:17.306+00
108	1	card	7	2017-11-14 00:25:23.05+00
109	1	dashboard	1	2017-11-14 06:13:25.32+00
110	1	card	2	2017-11-14 06:13:32.024+00
111	1	card	2	2017-11-14 06:14:16.103+00
112	1	card	2	2017-11-14 06:15:00.702+00
113	1	card	4	2017-11-14 06:15:37.188+00
114	1	card	6	2017-11-14 06:15:52.597+00
115	1	card	3	2017-11-14 06:16:04.213+00
116	1	dashboard	1	2017-11-14 13:37:27.323+00
117	1	card	6	2017-11-14 13:37:55.529+00
118	1	dashboard	1	2017-11-14 13:54:14.006+00
119	1	card	4	2017-11-14 13:54:16.31+00
120	1	dashboard	1	2017-11-14 13:58:00.992+00
121	1	card	6	2017-11-14 13:58:09.788+00
122	1	dashboard	1	2017-11-14 13:59:04.041+00
123	1	card	7	2017-11-14 14:01:35.808+00
124	1	dashboard	1	2017-11-14 14:01:39.933+00
125	1	card	7	2017-11-14 14:01:47.337+00
126	1	card	7	2017-11-14 14:05:43.041+00
127	1	dashboard	1	2017-11-14 14:06:02.606+00
128	1	card	7	2017-11-14 14:06:08.712+00
129	1	card	7	2017-11-14 14:10:20.967+00
130	1	dashboard	1	2017-11-14 14:10:27.754+00
131	1	dashboard	1	2017-11-14 14:10:37.773+00
132	1	card	8	2017-11-14 14:12:47.66+00
133	1	dashboard	1	2017-11-14 14:12:54.548+00
134	1	dashboard	1	2017-11-14 14:13:01.807+00
135	1	card	9	2017-11-14 14:13:59.794+00
136	1	dashboard	1	2017-11-14 14:14:04.09+00
137	1	dashboard	1	2017-11-14 14:14:17.703+00
138	1	card	9	2017-11-14 14:14:28.741+00
139	1	dashboard	1	2017-11-14 14:15:28.72+00
140	1	card	10	2017-11-18 01:16:53.964+00
141	1	card	11	2017-11-18 01:17:45.429+00
142	1	card	12	2017-11-18 01:19:39.331+00
143	1	card	13	2017-11-18 01:22:09.736+00
144	1	card	10	2017-11-18 01:25:00.239+00
145	1	card	10	2017-11-18 01:25:15.025+00
146	1	card	10	2017-11-18 02:17:44.421+00
147	1	card	12	2017-11-18 02:50:22.877+00
148	1	card	12	2017-11-18 02:50:48.744+00
149	1	card	11	2017-11-18 02:52:56.8+00
150	1	card	13	2017-11-18 02:54:35.548+00
151	1	card	10	2017-11-18 02:55:03.423+00
152	1	card	10	2017-11-18 02:55:10.824+00
153	1	card	4	2017-11-18 02:55:14.943+00
154	1	card	12	2017-11-18 02:55:20.448+00
155	1	card	11	2017-11-18 02:55:36.482+00
156	1	card	14	2017-11-19 17:58:14.298+00
157	1	card	15	2017-11-19 17:59:28.606+00
158	1	card	16	2017-11-19 18:02:10.769+00
159	1	card	17	2017-11-19 18:03:50.489+00
160	1	card	15	2017-11-19 18:07:28.931+00
161	1	card	17	2017-11-19 18:07:43.663+00
162	1	card	16	2017-11-19 18:07:57.014+00
163	1	card	14	2017-11-19 18:08:07.561+00
164	1	card	18	2017-11-20 23:04:08.64+00
165	1	card	19	2017-11-20 23:05:38.364+00
166	1	card	20	2017-11-20 23:06:35.764+00
167	1	card	21	2017-11-20 23:07:18.286+00
168	1	card	22	2017-11-20 23:08:03.866+00
169	1	card	23	2017-11-20 23:09:02.818+00
170	1	card	24	2017-11-20 23:10:58.272+00
171	1	card	24	2017-11-20 23:16:35.206+00
172	1	card	22	2017-11-20 23:16:57.984+00
173	1	card	22	2017-11-20 23:17:07.964+00
174	1	card	20	2017-11-20 23:17:13.466+00
175	1	card	20	2017-11-20 23:17:27.73+00
176	1	card	21	2017-11-20 23:17:34.96+00
177	1	card	21	2017-11-20 23:17:45.441+00
178	1	card	19	2017-11-20 23:17:51.071+00
179	1	card	19	2017-11-20 23:18:02.386+00
180	1	card	18	2017-11-20 23:18:07.833+00
181	1	card	23	2017-11-20 23:18:24.799+00
182	1	card	25	2017-11-20 23:46:06.806+00
183	1	card	26	2017-11-20 23:47:00.356+00
184	1	card	27	2017-11-20 23:47:48.618+00
185	1	card	28	2017-11-20 23:48:24.577+00
186	1	card	29	2017-11-20 23:50:00.684+00
187	1	card	28	2017-11-20 23:51:21.469+00
188	1	card	25	2017-11-20 23:51:39.299+00
189	1	card	26	2017-11-20 23:51:52.22+00
190	1	card	29	2017-11-20 23:52:04.377+00
191	1	card	27	2017-11-20 23:52:15.719+00
192	1	card	27	2017-11-20 23:52:27.158+00
\.


--
-- Name: activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('activity_id_seq', 131, true);


--
-- Name: card_label_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('card_label_id_seq', 1, false);


--
-- Name: collection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('collection_id_seq', 4, true);


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

SELECT pg_catalog.setval('metabase_field_id_seq', 630, true);


--
-- Name: metabase_fieldvalues_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('metabase_fieldvalues_id_seq', 72, true);


--
-- Name: metabase_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('metabase_table_id_seq', 25, true);


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

SELECT pg_catalog.setval('query_execution_id_seq', 745, true);


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

SELECT pg_catalog.setval('report_card_id_seq', 29, true);


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

SELECT pg_catalog.setval('report_dashboardcard_id_seq', 8, true);


--
-- Name: revision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('revision_id_seq', 162, true);


--
-- Name: segment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('segment_id_seq', 1, false);


--
-- Name: view_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('view_log_id_seq', 192, true);


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

