--
-- PostgreSQL database dump
--

-- Dumped from database version 10.1
-- Dumped by pg_dump version 10.1

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
132	card-create	2017-11-21 03:37:10.707+00	1	card	30	2	27	\N	{"name":"Porcentagem por Tipo","description":null}
133	card-create	2017-11-21 03:41:35.722+00	1	card	31	2	27	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
134	card-create	2017-11-21 03:42:30.552+00	1	card	32	2	27	\N	{"name":"Agents Data, Count, Grouped by Instance and Date (month)","description":null}
135	card-update	2017-11-21 03:42:56.221+00	1	card	32	2	27	\N	{"name":"Registros por Mês","description":null}
136	card-create	2017-11-21 03:44:57.702+00	1	card	33	2	26	\N	{"name":"Registros por Área","description":null}
137	card-update	2017-11-21 03:45:30.749+00	1	card	31	2	27	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
138	card-update	2017-11-21 03:45:39.818+00	1	card	30	2	27	\N	{"name":"Porcentagem por Tipo","description":null}
139	card-update	2017-11-21 03:45:49.342+00	1	card	33	2	26	\N	{"name":"Registros por Área","description":null}
140	card-update	2017-11-21 03:45:59.391+00	1	card	32	2	27	\N	{"name":"Registros por Mês","description":null}
141	card-update	2017-11-21 03:46:20.094+00	1	card	31	2	27	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
142	card-update	2017-11-21 03:46:20.162+00	1	card	31	2	27	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
143	card-update	2017-11-21 03:46:40.381+00	1	card	30	2	27	\N	{"name":"Porcentagem por Tipo","description":null}
144	card-update	2017-11-21 03:46:40.451+00	1	card	30	2	27	\N	{"name":"Porcentagem por Tipo","description":null}
145	card-update	2017-11-21 03:46:52.894+00	1	card	33	2	26	\N	{"name":"Registros por Área","description":null}
146	card-update	2017-11-21 03:46:52.955+00	1	card	33	2	26	\N	{"name":"Registros por Área","description":null}
147	card-update	2017-11-21 03:47:04.754+00	1	card	32	2	27	\N	{"name":"Registros por Mês","description":null}
148	card-update	2017-11-21 03:47:04.841+00	1	card	32	2	27	\N	{"name":"Registros por Mês","description":null}
149	card-create	2017-11-25 19:04:26.365+00	1	card	34	2	27	\N	{"name":"Quantidade total de registros de agentes","description":null}
150	card-update	2017-11-25 19:04:44.038+00	1	card	34	2	27	\N	{"name":"Quantidade total de registros de agentes","description":null}
151	card-update	2017-11-25 19:05:02.953+00	1	card	34	2	27	\N	{"name":"Quantidade total de registros de agentes","description":null}
152	card-update	2017-11-25 19:05:03.016+00	1	card	34	2	27	\N	{"name":"Quantidade total de registros de agentes","description":null}
153	card-create	2017-11-25 19:06:12.447+00	1	card	35	2	27	\N	{"name":"Quantidade de registros de agentes nos últimos 30 dias","description":null}
154	card-update	2017-11-25 19:06:27.154+00	1	card	35	2	27	\N	{"name":"Quantidade de registros de agentes nos últimos 30 dias","description":null}
155	card-update	2017-11-25 19:06:44.352+00	1	card	35	2	27	\N	{"name":"Quantidade de registros de agentes nos últimos 30 dias","description":null}
156	card-update	2017-11-25 19:06:44.406+00	1	card	35	2	27	\N	{"name":"Quantidade de registros de agentes nos últimos 30 dias","description":null}
157	card-create	2017-11-26 17:58:11.843+00	1	card	36	2	18	\N	{"name":"Quantidade total de registros de eventos","description":null}
158	card-update	2017-11-26 18:11:08.702+00	1	card	36	2	18	\N	{"name":"Quantidade total de registros de eventos","description":null}
159	card-update	2017-11-26 18:11:32.335+00	1	card	36	2	18	\N	{"name":"Quantidade total de registros de eventos","description":null}
160	card-update	2017-11-26 18:11:32.389+00	1	card	36	2	18	\N	{"name":"Quantidade total de registros de eventos","description":null}
161	card-create	2017-11-26 18:12:18.462+00	1	card	37	2	18	\N	{"name":"Quantidade de registros nos últimos 30 dias","description":null}
162	card-update	2017-11-26 18:12:35.416+00	1	card	37	2	18	\N	{"name":"Quantidade de registros nos últimos 30 dias","description":null}
163	card-update	2017-11-26 18:12:49+00	1	card	37	2	18	\N	{"name":"Quantidade de registros nos últimos 30 dias","description":null}
164	card-update	2017-11-26 18:12:49.084+00	1	card	37	2	18	\N	{"name":"Quantidade de registros nos últimos 30 dias","description":null}
165	card-update	2017-11-29 23:21:06.542+00	1	card	25	2	25	\N	{"name":"Porcentagem por Acessibilidade","description":null}
166	card-update	2017-11-29 23:21:49.77+00	1	card	26	2	25	\N	{"name":"Porcentagem por Tipo","description":null}
167	card-update	2017-11-29 23:22:13.42+00	1	card	26	2	25	\N	{"name":"Porcentagem por Tipo","description":null}
168	card-update	2017-11-29 23:22:45.155+00	1	card	25	2	25	\N	{"name":"Porcentagem por Acessibilidade","description":null}
169	card-update	2017-11-29 23:25:52.142+00	1	card	27	2	25	\N	{"name":"Quantidade de Registros por Mês","description":null}
170	card-create	2017-11-29 23:31:40.446+00	1	card	38	2	25	\N	{"name":"Quantidade total de registros de bibliotecas","description":null}
171	card-create	2017-11-29 23:32:53.538+00	1	card	39	2	25	\N	{"name":"Quantidade de registros de bibliotecas nos últimos 30 dias","description":null}
172	card-update	2017-11-29 23:35:33.82+00	1	card	38	2	25	\N	{"name":"Quantidade total de registros de bibliotecas","description":null}
173	card-update	2017-11-29 23:35:33.868+00	1	card	38	2	25	\N	{"name":"Quantidade total de registros de bibliotecas","description":null}
174	card-update	2017-11-29 23:35:46.258+00	1	card	39	2	25	\N	{"name":"Quantidade de registros de bibliotecas nos últimos 30 dias","description":null}
175	card-update	2017-11-29 23:35:46.299+00	1	card	39	2	25	\N	{"name":"Quantidade de registros de bibliotecas nos últimos 30 dias","description":null}
176	card-update	2017-11-29 23:51:24.04+00	1	card	22	2	22	\N	{"name":"Porcentagem por Tipo","description":null}
177	card-update	2017-11-29 23:52:03.8+00	1	card	20	2	22	\N	{"name":"Porcentagem por Acessibilidade","description":null}
178	card-update	2017-11-29 23:53:26.762+00	1	card	23	2	22	\N	{"name":"Registros por Mês","description":null}
179	card-update	2017-11-29 23:54:00.655+00	1	card	23	2	22	\N	{"name":"Quantidade de registros de museus nos últimos 30 dias","description":null}
180	card-create	2017-11-29 23:54:44.453+00	1	card	40	2	22	\N	{"name":"Quantidade total de registros de museus","description":null}
181	card-update	2017-11-29 23:55:25.639+00	1	card	40	2	22	\N	{"name":"Quantidade total de registros de museus","description":null}
182	card-update	2017-11-29 23:55:25.714+00	1	card	40	2	22	\N	{"name":"Quantidade total de registros de museus","description":null}
183	card-update	2017-11-29 23:56:31.892+00	1	card	18	2	22	\N	{"name":"Quantidade de Registros por Tipo","description":null}
184	card-update	2017-11-29 23:56:38.388+00	1	card	19	2	22	\N	{"name":"Quantidade de Registros por Temática","description":null}
185	card-update	2017-11-29 23:56:45.952+00	1	card	21	2	22	\N	{"name":"Porcentagem por Visita Guiada","description":null}
186	card-create	2017-11-30 00:00:50.058+00	1	card	41	2	30	\N	{"name":"Quantidade de Registros por Área","description":null}
187	card-update	2017-11-30 00:01:47.203+00	1	card	24	2	22	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
188	card-create	2017-11-30 00:03:31.834+00	1	card	42	2	31	\N	{"name":"Top 10 tags","description":null}
189	card-update	2017-11-30 00:06:45.157+00	1	card	42	2	31	\N	{"name":"Top 10 tags","description":null}
190	card-update	2017-11-30 00:06:45.201+00	1	card	42	2	31	\N	{"name":"Top 10 tags","description":null}
191	card-update	2017-11-30 00:07:09.275+00	1	card	41	2	30	\N	{"name":"Quantidade de Registros por Área","description":null}
192	card-update	2017-11-30 00:07:09.328+00	1	card	41	2	30	\N	{"name":"Quantidade de Registros por Área","description":null}
193	card-update	2017-11-30 00:07:34.153+00	1	card	41	2	30	\N	{"name":"Quantidade de Registros por Área","description":null}
194	card-update	2017-11-30 00:07:34.198+00	1	card	41	2	30	\N	{"name":"Quantidade de Registros por Área","description":null}
195	card-update	2017-11-30 00:09:16.752+00	1	card	28	2	25	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
196	card-update	2017-11-30 00:12:03.145+00	1	card	27	2	29	\N	{"name":"Top 10 tags","description":null}
197	card-update	2017-11-30 00:12:30.685+00	1	card	29	2	23	\N	{"name":"Quantidade de Registros por Área","description":null}
198	card-update	2017-11-30 00:12:54.191+00	1	card	29	2	23	\N	{"name":"Quantidade de Registros por Área","description":null}
199	card-update	2017-11-30 00:13:24.186+00	1	card	29	2	23	\N	{"name":"Quantidade de Registros por Área","description":null}
200	card-create	2017-12-01 23:55:37.168+00	1	card	43	2	18	\N	{"name":"Número de instancias","description":null}
201	card-create	2017-12-01 23:55:37.343+00	1	card	44	2	18	\N	{"name":"Número de instancias","description":null}
202	card-update	2017-12-01 23:56:21.86+00	1	card	44	2	18	\N	{"name":"Número de instancias","description":null}
203	card-update	2017-12-01 23:56:42.289+00	1	card	44	2	18	\N	{"name":"Número de instancias","description":null}
204	card-update	2017-12-01 23:56:42.433+00	1	card	44	2	18	\N	{"name":"Número de instancias","description":null}
205	card-create	2017-12-02 00:04:47.841+00	1	card	45	2	12	\N	{"name":"Quantidade total de registros de espaços","description":null}
206	card-create	2017-12-02 00:05:34.545+00	1	card	46	2	12	\N	{"name":"Quantidade de registros no últimos 30 dias","description":null}
207	card-update	2017-12-02 00:07:22.692+00	1	card	46	2	12	\N	{"name":"Quantidade de registros no últimos 30 dias de Espaço","description":null}
208	card-update	2017-12-02 00:11:20.69+00	1	card	46	2	12	\N	{"name":"Quantidade de registros no últimos 30 dias de Espaço","description":null}
209	card-update	2017-12-02 00:11:20.728+00	1	card	46	2	12	\N	{"name":"Quantidade de registros no últimos 30 dias de Espaço","description":null}
210	card-update	2017-12-02 00:12:10.46+00	1	card	45	2	12	\N	{"name":"Quantidade total de registros de espaços","description":null}
211	card-update	2017-12-02 00:12:10.509+00	1	card	45	2	12	\N	{"name":"Quantidade total de registros de espaços","description":null}
212	card-update	2017-12-02 00:13:57.279+00	1	card	46	2	12	\N	{"name":"Quantidade de registros no últimos 30 dias de Espaço","description":null}
216	card-update	2017-12-02 00:18:22.137+00	1	card	47	2	22	\N	{"name":"Quantidade total de registros de museus","description":null}
217	card-update	2017-12-02 00:18:22.184+00	1	card	47	2	22	\N	{"name":"Quantidade total de registros de museus","description":null}
221	card-update	2017-12-02 00:19:47.846+00	1	card	48	2	22	\N	{"name":"Quantidade de registros nos últimos 30 dias","description":null}
222	card-update	2017-12-02 00:20:06.38+00	1	card	48	2	22	\N	{"name":"Quantidade de registros nos últimos 30 dias","description":null}
213	card-update	2017-12-02 00:14:05.123+00	1	card	45	2	12	\N	{"name":"Quantidade total de registros de espaços","description":null}
214	card-update	2017-12-02 00:14:20.395+00	1	card	46	2	12	\N	{"name":"Quantidade de registros no últimos 30 dias","description":null}
215	card-create	2017-12-02 00:18:13.437+00	1	card	47	2	22	\N	{"name":"Quantidade total de registros de museus","description":null}
219	card-create	2017-12-02 00:19:41.496+00	1	card	48	2	22	\N	{"name":"Quantidade de registros nos últimos 30 dias","description":null}
218	card-update	2017-12-02 00:18:50.182+00	1	card	47	2	22	\N	{"name":"Quantidade total de registros de museus","description":null}
220	card-update	2017-12-02 00:19:47.8+00	1	card	48	2	22	\N	{"name":"Quantidade de registros nos últimos 30 dias","description":null}
223	card-update	2017-12-02 00:20:58.068+00	1	card	48	2	22	\N	{"name":"Quantidade de registros nos últimos 30 dias","description":null}
224	card-update	2017-12-02 00:21:33.01+00	1	card	23	2	22	\N	{"name":"Quantidade de registros  nos últimos 30 dias","description":null}
225	card-update	2017-12-02 00:23:08.766+00	1	card	39	2	25	\N	{"name":"Quantidade de registros  nos últimos 30 dias","description":null}
226	card-create	2017-12-05 01:43:19.721+00	1	card	49	2	16	\N	{"name":"Quantidade Total de Registros","description":null}
227	card-update	2017-12-05 01:43:40.03+00	1	card	49	2	16	\N	{"name":"Quantidade Total de Registros","description":null}
228	card-update	2017-12-05 01:43:55.762+00	1	card	49	2	16	\N	{"name":"Quantidade Total de Registros","description":null}
229	card-update	2017-12-05 01:43:55.805+00	1	card	49	2	16	\N	{"name":"Quantidade Total de Registros","description":null}
230	card-create	2017-12-05 01:45:20.211+00	1	card	50	2	16	\N	{"name":"Quantidade de Registros nos Últimos 30 Dias","description":null}
231	card-update	2017-12-05 01:45:48.227+00	1	card	50	2	16	\N	{"name":"Quantidade de Registros nos Últimos 30 Dias","description":null}
232	card-update	2017-12-05 01:45:48.267+00	1	card	50	2	16	\N	{"name":"Quantidade de Registros nos Últimos 30 Dias","description":null}
233	card-update	2017-12-05 03:04:59.49+00	1	card	2	2	15	\N	{"name":"Áreas de Atuação por Instância","description":null}
234	card-update	2017-12-05 03:07:37.27+00	1	card	17	2	20	\N	{"name":"Linguagens por Instância","description":null}
235	card-update	2017-12-05 03:12:03.934+00	1	card	35	2	27	\N	{"name":"Quantidade de registros nos últimos 30 dias","description":null}
236	dashboard-create	2017-12-05 03:12:41.879+00	1	dashboard	2	\N	\N	\N	{"description":null,"name":"números"}
237	dashboard-add-cards	2017-12-05 03:14:22.972+00	1	dashboard	2	\N	\N	\N	{"description":null,"name":"números","dashcards":[{"name":"Quantidade total de registros de agentes","description":null,"id":10,"card_id":34}]}
238	dashboard-add-cards	2017-12-05 03:14:23.028+00	1	dashboard	2	\N	\N	\N	{"description":null,"name":"números","dashcards":[{"name":"Quantidade de registros nos últimos 30 dias","description":null,"id":11,"card_id":35}]}
239	dashboard-add-cards	2017-12-05 03:14:23.094+00	1	dashboard	2	\N	\N	\N	{"description":null,"name":"números","dashcards":[{"name":"Número de instancias","description":null,"id":9,"card_id":44}]}
240	card-create	2017-12-07 23:37:29.233+00	1	card	51	2	35	\N	{"name":"Porcentagem de eventos em espaços acessiveis","description":null}
241	card-update	2017-12-07 23:39:22.869+00	1	card	51	2	35	\N	{"name":"Porcentagem de eventos em espaços acessiveis","description":null}
242	card-update	2017-12-07 23:39:22.947+00	1	card	51	2	35	\N	{"name":"Porcentagem de eventos em espaços acessiveis","description":null}
243	card-update	2017-12-10 00:51:11.997+00	1	card	17	2	20	\N	{"name":"Linguagens por Instância","description":null}
244	card-update	2017-12-10 00:52:09.473+00	1	card	2	2	15	\N	{"name":"Áreas de Atuação por Instância","description":null}
245	card-update	2017-12-10 00:57:39.302+00	1	card	2	2	15	\N	{"name":"Áreas de Atuação por Instância","description":null}
246	card-update	2017-12-10 10:42:54.664+00	1	card	41	2	30	\N	{"name":"Quantidade de Registros por Área","description":null}
247	card-update	2017-12-10 10:44:06.37+00	1	card	14	2	18	\N	{"name":"Quantidade de Registros por Mês","description":null}
248	card-update	2017-12-10 10:44:51.587+00	1	card	15	2	18	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
249	card-update	2017-12-10 10:46:10.376+00	1	card	17	2	20	\N	{"name":"Linguagens por Instância","description":null}
250	card-update	2017-12-10 10:47:49.32+00	1	card	2	2	15	\N	{"name":"Áreas de Atuação por Instância","description":null}
251	card-update	2017-12-10 10:48:26.062+00	1	card	4	2	12	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
252	card-update	2017-12-10 10:49:25.52+00	1	card	3	2	12	\N	{"name":"Quantidade de Registros por Mês","description":null}
253	card-update	2017-12-10 10:50:25.171+00	1	card	7	2	12	\N	{"name":"Tipos por Instância","description":null}
254	card-update	2017-12-10 10:51:03.799+00	1	card	6	2	12	\N	{"name":"Crescimento Cumulativo Mensal por Instância","description":null}
255	card-update	2017-12-10 10:51:44.082+00	1	card	31	2	27	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
256	card-update	2017-12-10 10:52:29.104+00	1	card	33	2	26	\N	{"name":"Registros por Área","description":null}
257	card-update	2017-12-10 10:53:00.211+00	1	card	32	2	27	\N	{"name":"Registros por Mês","description":null}
258	card-update	2017-12-10 10:53:35.696+00	1	card	11	2	16	\N	{"name":"Crescimento Cumulativo Mensal","description":null}
259	card-update	2017-12-10 10:54:08.872+00	1	card	10	2	16	\N	{"name":"Registros por Mês","description":null}
260	card-update	2017-12-10 10:54:48.785+00	1	card	13	2	16	\N	{"name":"Tipos por Instancia","description":null}
261	card-create	2017-12-10 12:02:39.51+00	1	card	52	2	18	\N	{"name":"Porcentagem de eventos por faixa etária","description":null}
262	card-update	2017-12-10 12:02:53.368+00	1	card	52	2	18	\N	{"name":"Porcentagem de eventos por faixa etária","description":null}
263	card-update	2017-12-10 12:02:53.435+00	1	card	52	2	18	\N	{"name":"Porcentagem de eventos por faixa etária","description":null}
264	card-update	2017-12-11 20:18:21.324+00	1	card	52	2	18	\N	{"name":"Classificação indicativa","description":null}
265	card-update	2017-12-12 02:13:15.622+00	1	card	52	2	18	\N	{"name":"Classificação indicativa","description":null}
266	card-create	2017-12-12 15:57:47.824+00	1	card	53	2	27	\N	{"name":"Quantidade de registros nos últimos 7 dias","description":null}
267	card-update	2017-12-12 15:59:00.206+00	1	card	53	2	27	\N	{"name":"Quantidade de registros nos últimos 7 dias","description":null}
268	card-update	2017-12-12 15:59:00.409+00	1	card	53	2	27	\N	{"name":"Quantidade de registros nos últimos 7 dias","description":null}
269	card-create	2017-12-12 16:03:34.994+00	1	card	54	2	18	\N	{"name":"Quantidade de registros nos últimos 7 dias","description":null}
270	card-update	2017-12-12 16:03:59.774+00	1	card	54	2	18	\N	{"name":"Quantidade de registros nos últimos 7 dias","description":null}
271	card-update	2017-12-12 16:03:59.998+00	1	card	54	2	18	\N	{"name":"Quantidade de registros nos últimos 7 dias","description":null}
272	card-create	2017-12-12 16:06:43.715+00	1	card	55	2	12	\N	{"name":"Quantidade de registros nos últimos 7 dias","description":null}
273	card-update	2017-12-12 16:07:02.76+00	1	card	55	2	12	\N	{"name":"Quantidade de registros nos últimos 7 dias","description":null}
274	card-update	2017-12-12 16:07:02.879+00	1	card	55	2	12	\N	{"name":"Quantidade de registros nos últimos 7 dias","description":null}
275	card-create	2017-12-12 16:08:01.775+00	1	card	56	2	16	\N	{"name":"Quantidade de registros nos últimos 7 dias","description":null}
276	card-update	2017-12-12 16:08:11.875+00	1	card	56	2	16	\N	{"name":"Quantidade de registros nos últimos 7 dias","description":null}
277	card-update	2017-12-12 16:08:12.077+00	1	card	56	2	16	\N	{"name":"Quantidade de registros nos últimos 7 dias","description":null}
278	dashboard-create	2017-12-12 18:15:52.748+00	1	dashboard	3	\N	\N	\N	{"description":null,"name":"Numeros Agentes"}
279	dashboard-add-cards	2017-12-12 18:18:44.32+00	1	dashboard	3	\N	\N	\N	{"description":null,"name":"Numeros Agentes","dashcards":[{"name":"Quantidade de registros nos últimos 7 dias","description":null,"id":12,"card_id":53}]}
280	dashboard-add-cards	2017-12-12 18:18:44.361+00	1	dashboard	3	\N	\N	\N	{"description":null,"name":"Numeros Agentes","dashcards":[{"name":"Quantidade de registros nos últimos 30 dias","description":null,"id":13,"card_id":35}]}
281	dashboard-add-cards	2017-12-12 18:18:44.499+00	1	dashboard	3	\N	\N	\N	{"description":null,"name":"Numeros Agentes","dashcards":[{"name":"Quantidade total de registros de agentes","description":null,"id":14,"card_id":34}]}
282	dashboard-create	2017-12-12 18:41:43.006+00	1	dashboard	4	\N	\N	\N	{"description":null,"name":"Numeros Eventos"}
283	dashboard-add-cards	2017-12-12 18:43:27.893+00	1	dashboard	4	\N	\N	\N	{"description":null,"name":"Numeros Eventos","dashcards":[{"name":"Quantidade total de registros de eventos","description":null,"id":15,"card_id":36}]}
284	dashboard-add-cards	2017-12-12 18:43:27.965+00	1	dashboard	4	\N	\N	\N	{"description":null,"name":"Numeros Eventos","dashcards":[{"name":"Quantidade de registros nos últimos 7 dias","description":null,"id":16,"card_id":54}]}
285	dashboard-add-cards	2017-12-12 18:43:27.988+00	1	dashboard	4	\N	\N	\N	{"description":null,"name":"Numeros Eventos","dashcards":[{"name":"Quantidade de registros nos últimos 30 dias","description":null,"id":17,"card_id":37}]}
286	dashboard-create	2017-12-12 18:45:44.07+00	1	dashboard	5	\N	\N	\N	{"description":null,"name":"Numeros Espaços"}
287	dashboard-add-cards	2017-12-12 18:46:10.857+00	1	dashboard	5	\N	\N	\N	{"description":null,"name":"Numeros Espaços","dashcards":[{"name":"Quantidade de registros no últimos 30 dias","description":null,"id":18,"card_id":46}]}
288	dashboard-add-cards	2017-12-12 18:46:10.879+00	1	dashboard	5	\N	\N	\N	{"description":null,"name":"Numeros Espaços","dashcards":[{"name":"Quantidade de registros nos últimos 7 dias","description":null,"id":19,"card_id":55}]}
289	dashboard-add-cards	2017-12-12 18:46:10.902+00	1	dashboard	5	\N	\N	\N	{"description":null,"name":"Numeros Espaços","dashcards":[{"name":"Quantidade total de registros de espaços","description":null,"id":20,"card_id":45}]}
290	dashboard-create	2017-12-12 18:47:27.526+00	1	dashboard	6	\N	\N	\N	{"description":null,"name":"Numeros Projetos"}
291	dashboard-add-cards	2017-12-12 18:47:53.648+00	1	dashboard	6	\N	\N	\N	{"description":null,"name":"Numeros Projetos","dashcards":[{"name":"Quantidade de Registros nos Últimos 30 Dias","description":null,"id":22,"card_id":50}]}
292	dashboard-add-cards	2017-12-12 18:47:53.811+00	1	dashboard	6	\N	\N	\N	{"description":null,"name":"Numeros Projetos","dashcards":[{"name":"Quantidade de registros nos últimos 7 dias","description":null,"id":23,"card_id":56}]}
293	dashboard-add-cards	2017-12-12 18:47:53.823+00	1	dashboard	6	\N	\N	\N	{"description":null,"name":"Numeros Projetos","dashcards":[{"name":"Quantidade Total de Registros","description":null,"id":21,"card_id":49}]}
294	dashboard-create	2017-12-12 18:49:20.149+00	1	dashboard	7	\N	\N	\N	{"description":null,"name":"Numeros Museus"}
295	dashboard-add-cards	2017-12-12 18:50:18.489+00	1	dashboard	7	\N	\N	\N	{"description":null,"name":"Numeros Museus","dashcards":[{"name":"Número de instancias","description":null,"id":24,"card_id":43}]}
296	dashboard-add-cards	2017-12-12 18:50:18.506+00	1	dashboard	7	\N	\N	\N	{"description":null,"name":"Numeros Museus","dashcards":[{"name":"Quantidade de registros  nos últimos 30 dias","description":null,"id":26,"card_id":23}]}
297	dashboard-add-cards	2017-12-12 18:50:18.527+00	1	dashboard	7	\N	\N	\N	{"description":null,"name":"Numeros Museus","dashcards":[{"name":"Quantidade total de registros de museus","description":null,"id":25,"card_id":47}]}
298	dashboard-create	2017-12-12 18:51:47.34+00	1	dashboard	8	\N	\N	\N	{"description":null,"name":"Numeros Bibliotecas"}
299	dashboard-add-cards	2017-12-12 18:52:29.569+00	1	dashboard	8	\N	\N	\N	{"description":null,"name":"Numeros Bibliotecas","dashcards":[{"name":"Número de instancias","description":null,"id":28,"card_id":43}]}
300	dashboard-add-cards	2017-12-12 18:52:29.588+00	1	dashboard	8	\N	\N	\N	{"description":null,"name":"Numeros Bibliotecas","dashcards":[{"name":"Quantidade total de registros de bibliotecas","description":null,"id":27,"card_id":38}]}
301	dashboard-add-cards	2017-12-12 18:52:29.611+00	1	dashboard	8	\N	\N	\N	{"description":null,"name":"Numeros Bibliotecas","dashcards":[{"name":"Quantidade de registros  nos últimos 30 dias","description":null,"id":29,"card_id":39}]}
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
5	Indicadores de Agentes	indicadores_de_agentes	\N	#A6E7F3	f
4	Indicadores de Bibliotecas	indicadores_de_bibliotecas	\N	#7172AD	f
6	Indicadores de Espaços	indicadores_de_espacos	\N	#509EE3	f
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
e8c138a3-35cc-4363-9520-29a35615cd81	1	2017-11-25 19:00:43.81+00
56c9edc7-b6ca-4ac4-9cef-33aa936e613f	1	2017-11-26 17:57:06.555+00
bb48b004-d614-45e3-a4aa-0a988f875c82	1	2017-11-29 23:15:00.954+00
80523723-7c77-4b32-b61e-cef73b7ba300	1	2017-12-01 23:53:32.829+00
ddc33cfb-e8d0-4b90-b7e3-beebc8a6d531	1	2017-12-05 01:36:43.354+00
fdabce52-74cd-411c-8471-0c1f45a18947	1	2017-12-05 02:59:35.794+00
2a6c4c90-3908-44f6-adce-a13a0d83b073	1	2017-12-05 02:59:47.447+00
999ace09-d34d-43ae-b136-6e9ec64228d4	1	2017-12-05 02:59:57.632+00
b230466c-a2d2-4d7a-afbe-ab0150142e07	1	2017-12-05 03:00:15.231+00
08c78a1a-58f1-48dd-8d5d-a4a54d364a3a	1	2017-12-05 03:00:32.552+00
986e1d25-3572-4903-b64d-5029e014058f	1	2017-12-05 03:00:54.822+00
3bfdcc3c-642a-4d11-8b88-3c8047d69c66	1	2017-12-05 03:01:27.094+00
c303ed7d-c3fa-4a39-a773-f9669f8671ed	1	2017-12-05 03:02:12.752+00
d22b0d70-9b0b-48d5-9c64-a5e8d994346c	1	2017-12-07 23:31:23.427+00
8f9ddf15-c9b2-4a86-a5e2-d98da0ad0789	1	2017-12-12 15:56:45.933+00
\.


--
-- Data for Name: core_user; Type: TABLE DATA; Schema: public; Owner: quero_cultura
--

COPY core_user (id, email, first_name, last_name, password, password_salt, date_joined, last_login, is_superuser, is_active, reset_token, reset_triggered, is_qbnewb, google_auth, ldap_auth) FROM stdin;
1	querocultura61@gmail.com	Quero	Cultura	$2a$10$mucdErrPR1pnf39krDT6Zu6TcEbtqE3SLNMEUsVJoHOxWJBzeXf9m	8c9df11c-9bd9-49fd-b830-8b8e90b802cb	2017-11-11 23:03:21.9+00	2017-12-12 15:56:46.007+00	t	t	\N	\N	f	f	f
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
39	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	38	EXECUTED	7:a63ada256c44684d2649b8f3c28a3023	addColumn tableName=core_user		\N	3.5.3	\N	\N	0441238708
7	cammsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	6	EXECUTED	7:baec0ec600ccc9bdadc176c1c4b29b77	addColumn tableName=metabase_field		\N	3.5.3	\N	\N	0441238708
32	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	31	EXECUTED	7:ff40b5fbe06dc5221d0b9223992ece25	createTable tableName=label; createIndex indexName=idx_label_slug, tableName=label; createTable tableName=card_label; addUniqueConstraint constraintName=unique_card_label_card_id_label_id, tableName=card_label; createIndex indexName=idx_card_label...		\N	3.5.3	\N	\N	0441238708
32	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	32	EXECUTED	7:af1dea42abdc7cd058b5f744602d7a22	createTable tableName=raw_table; createIndex indexName=idx_rawtable_database_id, tableName=raw_table; addUniqueConstraint constraintName=uniq_raw_table_db_schema_name, tableName=raw_table; createTable tableName=raw_column; createIndex indexName=id...		\N	3.5.3	\N	\N	0441238708
34	tlrobinson	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	33	EXECUTED	7:e65d70b4c914cfdf5b3ef9927565e899	addColumn tableName=pulse_channel		\N	3.5.3	\N	\N	0441238708
35	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	34	EXECUTED	7:ab80b6b8e6dfc3fa3e8fa5954e3a8ec4	modifyDataType columnName=value, tableName=setting		\N	3.5.3	\N	\N	0441238708
36	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	35	EXECUTED	7:de534c871471b400d70ee29122f23847	addColumn tableName=report_dashboard; addNotNullConstraint columnName=parameters, tableName=report_dashboard; addColumn tableName=report_dashboardcard; addNotNullConstraint columnName=parameter_mappings, tableName=report_dashboardcard		\N	3.5.3	\N	\N	0441238708
37	tlrobinson	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	36	EXECUTED	7:487dd1fa57af0f25edf3265ed9899588	addColumn tableName=query_queryexecution; addNotNullConstraint columnName=query_hash, tableName=query_queryexecution; createIndex indexName=idx_query_queryexecution_query_hash, tableName=query_queryexecution; createIndex indexName=idx_query_querye...		\N	3.5.3	\N	\N	0441238708
8	tlrobinson	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	7	EXECUTED	7:ea2727c7ce666178cff436549f81ddbd	addColumn tableName=metabase_table; addColumn tableName=metabase_field		\N	3.5.3	\N	\N	0441238708
38	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	37	EXECUTED	7:5e32fa14a0c34b99027e25901b7e3255	addColumn tableName=metabase_database; addColumn tableName=metabase_table; addColumn tableName=metabase_field; addColumn tableName=report_dashboard; addColumn tableName=metric; addColumn tableName=segment; addColumn tableName=metabase_database; ad...		\N	3.5.3	\N	\N	0441238708
40	camsaul	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	39	EXECUTED	7:0ba56822308957969bf5ad5ea8ee6707	createTable tableName=permissions_group; createIndex indexName=idx_permissions_group_name, tableName=permissions_group; createTable tableName=permissions_group_membership; addUniqueConstraint constraintName=unique_permissions_group_membership_user...		\N	3.5.3	\N	\N	0441238708
21	agilliland	migrations/000_migrations.yaml	2017-11-11 23:01:22.192703	20	EXECUTED	7:c23c71d8a11b3f38aaf5bf98acf51e6f	createTable tableName=segment; createIndex indexName=idx_segment_creator_id, tableName=segment; createIndex indexName=idx_segment_table_id, tableName=segment		\N	3.5.3	\N	\N	0441238708
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
1	2017-11-11 23:01:35.379+00	2017-12-12 18:13:36.072+00	Sample Dataset	\N	{"db":"zip:/app/metabase.jar!/sample-dataset.db;USER=GUEST;PASSWORD=guest"}	h2	t	t	\N	\N	0 50 * * * ? *	0 50 0 * * ? *	UTC	f
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
282	2017-11-12 21:38:44.906+00	2017-11-21 03:50:01.035+00	07	type/Integer	\N	t	\N	t	0	7	275	07	normal	\N	\N	\N	\N	\N	\N	0
167	2017-11-12 21:38:39.21+00	2017-11-14 13:50:01.589+00	03	type/Integer	\N	t	\N	t	0	5	164	03	normal	\N	\N	\N	\N	\N	\N	0
278	2017-11-12 21:38:44.862+00	2017-11-21 03:50:01.049+00	03	type/Integer	\N	t	\N	t	0	7	275	03	normal	\N	\N	\N	\N	\N	\N	0
277	2017-11-12 21:38:44.85+00	2017-11-21 03:50:01.051+00	06	type/Integer	\N	t	\N	t	0	7	275	06	normal	\N	\N	\N	\N	\N	\N	0
276	2017-11-12 21:38:44.839+00	2017-11-21 03:50:01.054+00	09	type/Integer	\N	t	\N	t	0	7	275	09	normal	\N	\N	\N	\N	\N	\N	0
286	2017-11-12 21:38:44.95+00	2017-11-21 03:50:01.056+00	01	type/Integer	\N	t	\N	t	0	7	275	01	normal	\N	\N	\N	\N	\N	\N	0
281	2017-11-12 21:38:44.895+00	2017-11-21 03:50:01.037+00	08	type/Integer	\N	t	\N	t	0	7	275	08	normal	\N	\N	\N	\N	\N	\N	0
280	2017-11-12 21:38:44.883+00	2017-11-21 03:50:01.044+00	05	type/Integer	\N	t	\N	t	0	7	275	05	normal	\N	\N	\N	\N	\N	\N	0
279	2017-11-12 21:38:44.872+00	2017-11-21 03:50:01.046+00	11	type/Integer	\N	t	\N	t	0	7	275	11	normal	\N	\N	\N	\N	\N	\N	0
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
305	2017-11-12 21:38:45.237+00	2017-11-21 03:50:01.105+00	10	type/Integer	\N	t	\N	t	0	7	297	10	normal	\N	\N	\N	\N	\N	\N	0
87	2017-11-12 21:38:38.107+00	2017-11-14 13:50:02.488+00	05	type/Integer	\N	t	\N	t	0	5	84	05	normal	\N	\N	\N	\N	\N	\N	0
92	2017-11-12 21:38:38.163+00	2017-11-14 13:50:02.786+00	09	type/Integer	\N	t	\N	t	0	5	91	09	normal	\N	\N	\N	\N	\N	\N	0
300	2017-11-12 21:38:45.16+00	2017-11-21 03:50:01.115+00	03	type/Integer	\N	t	\N	t	0	7	297	03	normal	\N	\N	\N	\N	\N	\N	0
299	2017-11-12 21:38:45.122+00	2017-11-21 03:50:01.117+00	06	type/Integer	\N	t	\N	t	0	7	297	06	normal	\N	\N	\N	\N	\N	\N	0
298	2017-11-12 21:38:45.104+00	2017-11-21 03:50:01.12+00	09	type/Integer	\N	t	\N	t	0	7	297	09	normal	\N	\N	\N	\N	\N	\N	0
303	2017-11-12 21:38:45.194+00	2017-11-21 03:50:01.122+00	08	type/Integer	\N	t	\N	t	0	7	297	08	normal	\N	\N	\N	\N	\N	\N	0
304	2017-11-12 21:38:45.216+00	2017-11-21 03:50:01.107+00	07	type/Integer	\N	t	\N	t	0	7	297	07	normal	\N	\N	\N	\N	\N	\N	0
301	2017-11-12 21:38:45.171+00	2017-11-21 03:50:01.11+00	11	type/Integer	\N	t	\N	t	0	7	297	11	normal	\N	\N	\N	\N	\N	\N	0
302	2017-11-12 21:38:45.184+00	2017-11-21 03:50:01.112+00	05	type/Integer	\N	t	\N	t	0	7	297	05	normal	\N	\N	\N	\N	\N	\N	0
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
315	2017-11-12 21:38:45.382+00	2017-11-21 03:50:01.079+00	05	type/Integer	\N	t	\N	t	0	7	310	05	normal	\N	\N	\N	\N	\N	\N	0
314	2017-11-12 21:38:45.371+00	2017-11-21 03:50:01.081+00	11	type/Integer	\N	t	\N	t	0	7	310	11	normal	\N	\N	\N	\N	\N	\N	0
427	2017-11-12 21:38:48.393+00	2017-11-19 17:54:27.267+00	Carnaval	type/Integer	\N	f	\N	t	0	8	337	Carnaval	normal	\N	\N	\N	\N	\N	\N	0
313	2017-11-12 21:38:45.36+00	2017-11-21 03:50:01.083+00	03	type/Integer	\N	t	\N	t	0	7	310	03	normal	\N	\N	\N	\N	\N	\N	0
216	2017-11-12 21:38:39.834+00	2017-11-14 13:50:03.273+00	Mostra	type/Integer	\N	t	\N	t	0	5	192	Most Ra	normal	\N	\N	\N	\N	\N	\N	0
229	2017-11-12 21:38:39.989+00	2017-11-14 13:50:03.528+00	Jornada	type/Integer	\N	t	\N	t	0	5	217	Jorn Ada	normal	\N	\N	\N	\N	\N	\N	0
253	2017-11-12 21:38:40.299+00	2017-11-14 13:50:03.793+00	Ciclo	type/Integer	\N	t	\N	t	0	5	242	Ci Clo	normal	\N	\N	\N	\N	\N	\N	0
266	2017-11-12 21:38:40.499+00	2017-11-14 13:50:03.805+00	Sarau	type/Integer	\N	t	\N	t	0	5	242	Sara U	normal	\N	\N	\N	\N	\N	\N	0
570	2017-11-13 23:50:12.505+00	2017-11-14 13:50:08.354+00	03	type/Integer	\N	t	\N	t	0	14	567	03	normal	\N	\N	\N	\N	\N	\N	0
319	2017-11-12 21:38:45.426+00	2017-11-21 03:50:01.088+00	04	type/Integer	\N	t	\N	t	0	7	310	04	normal	\N	\N	\N	\N	\N	\N	0
311	2017-11-12 21:38:45.338+00	2017-11-21 03:50:01.091+00	09	type/Integer	\N	t	\N	t	0	7	310	09	normal	\N	\N	\N	\N	\N	\N	0
321	2017-11-12 21:38:45.512+00	2017-11-21 03:50:01.093+00	02	type/Integer	\N	t	\N	t	0	7	310	02	normal	\N	\N	\N	\N	\N	\N	0
320	2017-11-12 21:38:45.448+00	2017-11-21 03:50:01.096+00	01	type/Integer	\N	t	\N	t	0	7	310	01	normal	\N	\N	\N	\N	\N	\N	0
318	2017-11-12 21:38:45.415+00	2017-11-21 03:50:01.099+00	10	type/Integer	\N	t	\N	t	0	7	310	10	normal	\N	\N	\N	\N	\N	\N	0
296	2017-11-12 21:38:45.082+00	2017-11-21 03:50:01.143+00	12	type/Integer	\N	t	\N	t	0	7	288	12	normal	\N	\N	\N	\N	\N	\N	0
362	2017-11-12 21:38:47.176+00	2017-11-21 03:50:01.663+00	arte digital	type/Integer	\N	t	\N	t	0	8	337	Arte Digital	normal	\N	\N	\N	\N	\N	\N	0
352	2017-11-12 21:38:46.949+00	2017-11-21 03:50:01.666+00	cultura digital	type/Integer	\N	t	\N	t	0	8	337	Cultura Digital	normal	\N	\N	\N	\N	\N	\N	0
351	2017-11-12 21:38:46.899+00	2017-11-21 03:50:01.668+00	livro	type/Integer	\N	t	\N	t	0	8	337	Liv Ro	normal	\N	\N	\N	\N	\N	\N	0
349	2017-11-12 21:38:46.866+00	2017-11-21 03:50:01.671+00	comunicação	type/Integer	\N	t	\N	t	0	8	337	Comunicação	normal	\N	\N	\N	\N	\N	\N	0
348	2017-11-12 21:38:46.833+00	2017-11-21 03:50:01.673+00	gestão cultural	type/Integer	\N	t	\N	t	0	8	337	Gestão Cultural	normal	\N	\N	\N	\N	\N	\N	0
347	2017-11-12 21:38:46.811+00	2017-11-21 03:50:01.683+00	artes visuais	type/Integer	\N	t	\N	t	0	8	337	Artes Vi Sua Is	normal	\N	\N	\N	\N	\N	\N	0
346	2017-11-12 21:38:46.799+00	2017-11-21 03:50:01.685+00	cultura indígena	type/Integer	\N	t	\N	t	0	8	337	Cultura Indígena	normal	\N	\N	\N	\N	\N	\N	0
345	2017-11-12 21:38:46.778+00	2017-11-21 03:50:01.688+00	circo	type/Integer	\N	t	\N	t	0	8	337	Circo	normal	\N	\N	\N	\N	\N	\N	0
344	2017-11-12 21:38:46.738+00	2017-11-21 03:50:01.69+00	Esporte	type/Integer	\N	t	\N	t	0	8	337	Esporte	normal	\N	\N	\N	\N	\N	\N	0
343	2017-11-12 21:38:46.711+00	2017-11-21 03:50:01.693+00	cultura lgbt	type/Integer	\N	t	\N	t	0	8	337	Cultura Lgbt	normal	\N	\N	\N	\N	\N	\N	0
342	2017-11-12 21:38:46.7+00	2017-11-21 03:50:01.695+00	Cultura Digital	type/Integer	\N	t	\N	t	0	8	337	Cultura Digital	normal	\N	\N	\N	\N	\N	\N	0
340	2017-11-12 21:38:46.666+00	2017-11-21 03:50:01.698+00	Moda	type/Integer	\N	t	\N	t	0	8	337	Moda	normal	\N	\N	\N	\N	\N	\N	0
339	2017-11-12 21:38:46.656+00	2017-11-21 03:50:01.701+00	cultura popular	type/Integer	\N	t	\N	t	0	8	337	Cultura Popular	normal	\N	\N	\N	\N	\N	\N	0
436	2017-11-12 21:38:48.515+00	2017-11-21 03:50:01.703+00	Arqueologia	type/Integer	\N	t	\N	t	0	8	337	Ar Que O Logia	normal	\N	\N	\N	\N	\N	\N	0
431	2017-11-12 21:38:48.438+00	2017-11-21 03:50:01.706+00	Fotografia	type/Integer	\N	t	\N	t	0	8	337	Fotogr A Fia	normal	\N	\N	\N	\N	\N	\N	0
420	2017-11-12 21:38:48.263+00	2017-11-21 03:50:01.71+00	Rádio	type/Integer	\N	t	\N	t	0	8	337	Rádio	normal	\N	\N	\N	\N	\N	\N	0
417	2017-11-12 21:38:48.205+00	2017-11-21 03:50:01.713+00	Antropologia	type/Integer	\N	t	\N	t	0	8	337	An Tro Polo Gia	normal	\N	\N	\N	\N	\N	\N	0
416	2017-11-12 21:38:48.196+00	2017-11-21 03:50:01.716+00	dança	type/Integer	\N	t	\N	t	0	8	337	Dança	normal	\N	\N	\N	\N	\N	\N	0
414	2017-11-12 21:38:48.172+00	2017-11-21 03:50:01.718+00	Música	type/Integer	\N	t	\N	t	0	8	337	Música	normal	\N	\N	\N	\N	\N	\N	0
413	2017-11-12 21:38:48.152+00	2017-11-21 03:50:01.721+00	literatura	type/Integer	\N	t	\N	t	0	8	337	Literatura	normal	\N	\N	\N	\N	\N	\N	0
330	2017-11-12 21:38:45.692+00	2017-11-21 03:50:00.998+00	10	type/Integer	\N	t	\N	t	0	7	322	10	normal	\N	\N	\N	\N	\N	\N	0
328	2017-11-12 21:38:45.648+00	2017-11-21 03:50:01+00	08	type/Integer	\N	t	\N	t	0	7	322	08	normal	\N	\N	\N	\N	\N	\N	0
334	2017-11-12 21:38:45.76+00	2017-11-21 03:50:01.003+00	02	type/Integer	\N	t	\N	t	0	7	322	02	normal	\N	\N	\N	\N	\N	\N	0
333	2017-11-12 21:38:45.748+00	2017-11-21 03:50:01.008+00	01	type/Integer	\N	t	\N	t	0	7	322	01	normal	\N	\N	\N	\N	\N	\N	0
326	2017-11-12 21:38:45.625+00	2017-11-21 03:50:01.012+00	11	type/Integer	\N	t	\N	t	0	7	322	11	normal	\N	\N	\N	\N	\N	\N	0
325	2017-11-12 21:38:45.615+00	2017-11-21 03:50:01.015+00	03	type/Integer	\N	t	\N	t	0	7	322	03	normal	\N	\N	\N	\N	\N	\N	0
332	2017-11-12 21:38:45.727+00	2017-11-21 03:50:01.017+00	04	type/Integer	\N	t	\N	t	0	7	322	04	normal	\N	\N	\N	\N	\N	\N	0
317	2017-11-12 21:38:45.403+00	2017-11-21 03:50:01.074+00	07	type/Integer	\N	t	\N	t	0	7	310	07	normal	\N	\N	\N	\N	\N	\N	0
316	2017-11-12 21:38:45.393+00	2017-11-21 03:50:01.076+00	08	type/Integer	\N	t	\N	t	0	7	310	08	normal	\N	\N	\N	\N	\N	\N	0
312	2017-11-12 21:38:45.349+00	2017-11-21 03:50:01.086+00	06	type/Integer	\N	t	\N	t	0	7	310	06	normal	\N	\N	\N	\N	\N	\N	0
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
354	2017-11-12 21:38:47.043+00	2017-11-21 03:50:01.749+00	Cinema	type/Integer	\N	t	\N	t	0	8	337	Cinema	normal	\N	\N	\N	\N	\N	\N	0
466	2017-11-12 21:38:48.881+00	2017-11-19 17:54:27.217+00	Orquestra	type/Integer	\N	f	\N	t	0	8	337	Or Quest Ra	normal	\N	\N	\N	\N	\N	\N	0
437	2017-11-12 21:38:48.539+00	2017-11-21 03:50:01.753+00	Literatura	type/Integer	\N	t	\N	t	0	8	337	Literatura	normal	\N	\N	\N	\N	\N	\N	0
439	2017-11-12 21:38:48.559+00	2017-11-21 03:50:01.755+00	rádio	type/Integer	\N	t	\N	t	0	8	337	Rádio	normal	\N	\N	\N	\N	\N	\N	0
518	2017-11-13 23:50:01.028+00	2017-11-14 13:50:00.338+00	Artes, arquitetura e linguística	type/Integer	\N	t	\N	t	0	13	515	Artes, Ar Quite Tura E Linguística	normal	\N	\N	\N	\N	\N	\N	0
517	2017-11-13 23:50:01.012+00	2017-11-14 13:50:00.349+00	Antropologia e Arqueologia	type/Integer	\N	t	\N	t	0	13	515	An Tro Polo Gia E Ar Que O Logia	normal	\N	\N	\N	\N	\N	\N	0
516	2017-11-13 23:50:01.001+00	2017-11-14 13:50:00.36+00	Meios de comunicação e transporte	type/Integer	\N	t	\N	t	0	13	515	Me Ios De Comunicação E Trans Porte	normal	\N	\N	\N	\N	\N	\N	0
514	2017-11-13 23:50:00.972+00	2017-11-14 13:50:00.371+00	_total_museums	type/Integer	\N	t	\N	t	0	13	\N	Total Museums	normal	\N	\N	\N	\N	\N	\N	0
506	2017-11-13 23:50:00.855+00	2017-11-14 13:50:00.382+00	_total_museums_historical	type/Dictionary	\N	t	\N	t	0	13	\N	Total Museums Historical	normal	\N	\N	\N	\N	\N	\N	0
429	2017-11-12 21:38:48.415+00	2017-11-21 03:50:01.76+00	turismo	type/Integer	\N	t	\N	t	0	8	337	Turismo	normal	\N	\N	\N	\N	\N	\N	0
425	2017-11-12 21:38:48.361+00	2017-11-21 03:50:01.762+00	esporte	type/Integer	\N	t	\N	t	0	8	337	Esporte	normal	\N	\N	\N	\N	\N	\N	0
424	2017-11-12 21:38:48.339+00	2017-11-21 03:50:01.765+00	Turismo	type/Integer	\N	t	\N	t	0	8	337	Turismo	normal	\N	\N	\N	\N	\N	\N	0
407	2017-11-12 21:38:47.974+00	2017-11-21 03:50:01.77+00	Direito Autoral	type/Integer	\N	t	\N	t	0	8	337	Dire I To Aut Oral	normal	\N	\N	\N	\N	\N	\N	0
406	2017-11-12 21:38:47.962+00	2017-11-21 03:50:01.773+00	leitura	type/Integer	\N	t	\N	t	0	8	337	Lei Tura	normal	\N	\N	\N	\N	\N	\N	0
402	2017-11-12 21:38:47.896+00	2017-11-21 03:50:01.776+00	Cultura Cigana	type/Integer	\N	t	\N	t	0	8	337	Cultura Cig An A	normal	\N	\N	\N	\N	\N	\N	0
399	2017-11-12 21:38:47.784+00	2017-11-21 03:50:01.779+00	Cultura LGBT	type/Integer	\N	t	\N	t	0	8	337	Cultura Lgbt	normal	\N	\N	\N	\N	\N	\N	0
398	2017-11-12 21:38:47.762+00	2017-11-21 03:50:01.781+00	Novas Mídias	type/Integer	\N	t	\N	t	0	8	337	Novas Mídias	normal	\N	\N	\N	\N	\N	\N	0
396	2017-11-12 21:38:47.717+00	2017-11-21 03:50:01.784+00	filosofia	type/Integer	\N	t	\N	t	0	8	337	Filo Sofia	normal	\N	\N	\N	\N	\N	\N	0
395	2017-11-12 21:38:47.706+00	2017-11-21 03:50:01.789+00	Saúde	type/Integer	\N	t	\N	t	0	8	337	Saúde	normal	\N	\N	\N	\N	\N	\N	0
394	2017-11-12 21:38:47.696+00	2017-11-21 03:50:01.792+00	Teatro	type/Integer	\N	t	\N	t	0	8	337	Teatro	normal	\N	\N	\N	\N	\N	\N	0
393	2017-11-12 21:38:47.686+00	2017-11-21 03:50:01.794+00	Filosofia	type/Integer	\N	t	\N	t	0	8	337	Filo Sofia	normal	\N	\N	\N	\N	\N	\N	0
392	2017-11-12 21:38:47.661+00	2017-11-21 03:50:01.797+00	Livro	type/Integer	\N	t	\N	t	0	8	337	Liv Ro	normal	\N	\N	\N	\N	\N	\N	0
391	2017-11-12 21:38:47.64+00	2017-11-21 03:50:01.799+00	Museu	type/Integer	\N	t	\N	t	0	8	337	Muse U	normal	\N	\N	\N	\N	\N	\N	0
389	2017-11-12 21:38:47.6+00	2017-11-21 03:50:01.802+00	Cultura Popular	type/Integer	\N	t	\N	t	0	8	337	Cultura Popular	normal	\N	\N	\N	\N	\N	\N	0
388	2017-11-12 21:38:47.577+00	2017-11-21 03:50:01.804+00	jornalismo	type/Integer	\N	t	\N	t	0	8	337	Jorn Al Is Mo	normal	\N	\N	\N	\N	\N	\N	0
386	2017-11-12 21:38:47.541+00	2017-11-21 03:50:01.807+00	direito autoral	type/Integer	\N	t	\N	t	0	8	337	Dire I To Aut Oral	normal	\N	\N	\N	\N	\N	\N	0
408	2017-11-12 21:38:48+00	2017-11-21 03:50:01.723+00	jogos eletrônicos	type/Integer	\N	t	\N	t	0	8	337	Jog Os Eletrônicos	normal	\N	\N	\N	\N	\N	\N	0
471	2017-11-12 21:38:48.949+00	2017-11-21 03:50:01.726+00	Dança	type/Integer	\N	t	\N	t	0	8	337	Dança	normal	\N	\N	\N	\N	\N	\N	0
470	2017-11-12 21:38:48.928+00	2017-11-21 03:50:01.728+00	Artes Visuais	type/Integer	\N	t	\N	t	0	8	337	Artes Vi Sua Is	normal	\N	\N	\N	\N	\N	\N	0
467	2017-11-12 21:38:48.891+00	2017-11-21 03:50:01.731+00	arqueologia	type/Integer	\N	t	\N	t	0	8	337	Ar Que O Logia	normal	\N	\N	\N	\N	\N	\N	0
464	2017-11-12 21:38:48.858+00	2017-11-21 03:50:01.735+00	Outros	type/Integer	\N	t	\N	t	0	8	337	Out Ros	normal	\N	\N	\N	\N	\N	\N	0
463	2017-11-12 21:38:48.847+00	2017-11-21 03:50:01.738+00	Pesquisa	type/Integer	\N	t	\N	t	0	8	337	Pes Quis A	normal	\N	\N	\N	\N	\N	\N	0
461	2017-11-12 21:38:48.824+00	2017-11-21 03:50:01.74+00	audiovisual	type/Integer	\N	t	\N	t	0	8	337	Audiovisual	normal	\N	\N	\N	\N	\N	\N	0
459	2017-11-12 21:38:48.797+00	2017-11-21 03:50:01.743+00	artesanato	type/Integer	\N	t	\N	t	0	8	337	Artes An A To	normal	\N	\N	\N	\N	\N	\N	0
458	2017-11-12 21:38:48.781+00	2017-11-21 03:50:01.747+00	arquivo	type/Integer	\N	t	\N	t	0	8	337	Ar Qui Vo	normal	\N	\N	\N	\N	\N	\N	0
430	2017-11-12 21:38:48.427+00	2017-11-21 03:50:01.758+00	Sociologia	type/Integer	\N	t	\N	t	0	8	337	Socio Logia	normal	\N	\N	\N	\N	\N	\N	0
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
371	2017-11-12 21:38:47.285+00	2017-11-21 03:50:01.842+00	Produção Cultural	type/Integer	\N	t	\N	t	0	8	337	Produção Cultural	normal	\N	\N	\N	\N	\N	\N	0
442	2017-11-12 21:38:48.594+00	2017-11-19 17:54:27.244+00	intercambio cultural	type/Integer	\N	f	\N	t	0	8	337	Inter Cambio Cultural	normal	\N	\N	\N	\N	\N	\N	0
370	2017-11-12 21:38:47.275+00	2017-11-21 03:50:01.844+00	fotografia	type/Integer	\N	t	\N	t	0	8	337	Fotogr A Fia	normal	\N	\N	\N	\N	\N	\N	0
221	2017-11-12 21:38:39.891+00	2017-11-14 13:50:03.539+00	Conferência Pública Municipal	type/Integer	\N	t	\N	t	0	5	217	Conferência Pública Municipal	normal	\N	\N	\N	\N	\N	\N	0
246	2017-11-12 21:38:40.208+00	2017-11-14 13:50:03.838+00	Conferência Pública Estadual	type/Integer	\N	t	\N	t	0	5	242	Conferência Pública Esta Dual	normal	\N	\N	\N	\N	\N	\N	0
537	2017-11-13 23:50:12.115+00	2017-11-14 13:50:08.323+00	_total_museums_registered_year	type/Dictionary	\N	t	\N	t	0	14	\N	Total Museums Registered Year	normal	\N	\N	\N	\N	\N	\N	0
567	2017-11-13 23:50:12.472+00	2017-11-14 13:50:08.333+00	2016	type/Dictionary	\N	t	\N	t	0	14	537	2016	normal	\N	\N	\N	\N	\N	\N	0
577	2017-11-13 23:50:12.605+00	2017-11-14 13:50:08.365+00	04	type/Integer	\N	t	\N	t	0	14	567	04	normal	\N	\N	\N	\N	\N	\N	0
572	2017-11-13 23:50:12.533+00	2017-11-14 13:50:08.376+00	05	type/Integer	\N	t	\N	t	0	14	567	05	normal	\N	\N	\N	\N	\N	\N	0
508	2017-11-13 23:50:00.876+00	2017-11-14 13:50:00.431+00	None	type/Integer	\N	t	\N	t	0	13	506	None	normal	\N	\N	\N	\N	\N	\N	0
536	2017-11-13 23:50:01.256+00	2017-11-14 13:50:00.505+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	13	\N	ID	normal	\N	\N	2017-11-13 23:50:15.449+00	\N	\N	{"global":{"distinct-count":2}}	1
355	2017-11-12 21:38:47.065+00	2017-11-21 03:50:01.852+00	Arquivo	type/Integer	\N	t	\N	t	0	8	337	Ar Qui Vo	normal	\N	\N	\N	\N	\N	\N	0
364	2017-11-12 21:38:47.197+00	2017-11-21 03:50:01.855+00	Cultura Indígena	type/Integer	\N	t	\N	t	0	8	337	Cultura Indígena	normal	\N	\N	\N	\N	\N	\N	0
363	2017-11-12 21:38:47.186+00	2017-11-21 03:50:01.857+00	antropologia	type/Integer	\N	t	\N	t	0	8	337	An Tro Polo Gia	normal	\N	\N	\N	\N	\N	\N	0
451	2017-11-12 21:38:48.702+00	2017-11-21 03:50:01.86+00	cinema	type/Integer	\N	t	\N	t	0	8	337	Cinema	normal	\N	\N	\N	\N	\N	\N	0
449	2017-11-12 21:38:48.682+00	2017-11-21 03:50:01.863+00	arte de rua	type/Integer	\N	t	\N	t	0	8	337	Arte De Rua	normal	\N	\N	\N	\N	\N	\N	0
448	2017-11-12 21:38:48.669+00	2017-11-21 03:50:01.867+00	arquitetura-urbanismo	type/Integer	\N	t	\N	t	0	8	337	Ar Quite Tura Urbanism O	normal	\N	\N	\N	\N	\N	\N	0
359	2017-11-12 21:38:47.133+00	2017-11-21 03:50:01.869+00	Mídias Sociais	type/Integer	\N	t	\N	t	0	8	337	Mídias Soci A Is	normal	\N	\N	\N	\N	\N	\N	0
456	2017-11-12 21:38:48.759+00	2017-11-21 03:50:01.872+00	saúde	type/Integer	\N	t	\N	t	0	8	337	Saúde	normal	\N	\N	\N	\N	\N	\N	0
455	2017-11-12 21:38:48.748+00	2017-11-21 03:50:01.874+00	sociologia	type/Integer	\N	t	\N	t	0	8	337	Socio Logia	normal	\N	\N	\N	\N	\N	\N	0
454	2017-11-12 21:38:48.736+00	2017-11-21 03:50:01.877+00	história	type/Integer	\N	t	\N	t	0	8	337	História	normal	\N	\N	\N	\N	\N	\N	0
453	2017-11-12 21:38:48.724+00	2017-11-21 03:50:01.88+00	moda	type/Integer	\N	t	\N	t	0	8	337	Moda	normal	\N	\N	\N	\N	\N	\N	0
384	2017-11-12 21:38:47.521+00	2017-11-21 03:50:01.886+00	pesquisa	type/Integer	\N	t	\N	t	0	8	337	Pes Quis A	normal	\N	\N	\N	\N	\N	\N	0
381	2017-11-12 21:38:47.463+00	2017-11-21 03:50:01.81+00	Gastronomia	type/Integer	\N	t	\N	t	0	8	337	Gas Trono Mia	normal	\N	\N	\N	\N	\N	\N	0
379	2017-11-12 21:38:47.441+00	2017-11-21 03:50:01.813+00	Meio Ambiente	type/Integer	\N	t	\N	t	0	8	337	Mei O Am Bien Te	normal	\N	\N	\N	\N	\N	\N	0
378	2017-11-12 21:38:47.431+00	2017-11-21 03:50:01.816+00	Arte Digital	type/Integer	\N	t	\N	t	0	8	337	Arte Digital	normal	\N	\N	\N	\N	\N	\N	0
446	2017-11-12 21:38:48.648+00	2017-11-21 03:50:01.818+00	educação	type/Integer	\N	t	\N	t	0	8	337	Educação	normal	\N	\N	\N	\N	\N	\N	0
444	2017-11-12 21:38:48.615+00	2017-11-21 03:50:01.826+00	Cultura Negra	type/Integer	\N	t	\N	t	0	8	337	Cultura Negra	normal	\N	\N	\N	\N	\N	\N	0
443	2017-11-12 21:38:48.604+00	2017-11-21 03:50:01.83+00	design	type/Integer	\N	t	\N	t	0	8	337	Design	normal	\N	\N	\N	\N	\N	\N	0
376	2017-11-12 21:38:47.343+00	2017-11-21 03:50:01.834+00	Artesanato	type/Integer	\N	t	\N	t	0	8	337	Artes An A To	normal	\N	\N	\N	\N	\N	\N	0
375	2017-11-12 21:38:47.33+00	2017-11-21 03:50:01.837+00	Televisão	type/Integer	\N	t	\N	t	0	8	337	Televisão	normal	\N	\N	\N	\N	\N	\N	0
369	2017-11-12 21:38:47.264+00	2017-11-21 03:50:01.847+00	Gestão Cultural	type/Integer	\N	t	\N	t	0	8	337	Gestão Cultural	normal	\N	\N	\N	\N	\N	\N	0
368	2017-11-12 21:38:47.252+00	2017-11-21 03:50:01.849+00	teatro	type/Integer	\N	t	\N	t	0	8	337	Teatro	normal	\N	\N	\N	\N	\N	\N	0
373	2017-11-12 21:38:47.308+00	2017-11-21 03:50:01.839+00	Educação	type/Integer	\N	t	\N	t	0	8	337	Educação	normal	\N	\N	\N	\N	\N	\N	0
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
421	2017-11-12 21:38:48.283+00	2017-11-21 03:50:01.895+00	Economia Criativa	type/Integer	\N	t	\N	t	0	8	337	Eco No Mia Cri At Iva	normal	\N	\N	\N	\N	\N	\N	0
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
341	2017-11-12 21:38:46.68+00	2017-11-21 03:50:01.889+00	novas mídias	type/Integer	\N	t	\N	t	0	8	337	Novas Mídias	normal	\N	\N	\N	\N	\N	\N	0
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
357	2017-11-12 21:38:47.098+00	2017-11-21 03:50:01.906+00	museu	type/Integer	type/Category	t	\N	t	0	8	337	Muse U	normal	\N	\N	2017-11-12 23:50:09.691+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":27718,"avg":18478.666666666668}}}	1
405	2017-11-12 21:38:47.95+00	2017-11-21 03:50:01.909+00	Audiovisual	type/Integer	\N	t	\N	t	0	8	337	Audiovisual	normal	\N	\N	\N	\N	\N	\N	0
422	2017-11-12 21:38:48.295+00	2017-11-21 03:50:01.897+00	meio ambiente	type/Integer	\N	t	\N	t	0	8	337	Mei O Am Bien Te	normal	\N	\N	\N	\N	\N	\N	0
360	2017-11-12 21:38:47.155+00	2017-11-21 03:50:01.9+00	música	type/Integer	type/Category	t	\N	t	0	8	337	Música	normal	\N	\N	2017-11-12 22:50:12.266+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":27718,"avg":18478.666666666668}}}	1
438	2017-11-12 21:38:48.549+00	2017-11-21 03:50:01.904+00	Design	type/Integer	type/Category	t	\N	t	0	8	337	Design	normal	\N	\N	2017-11-12 21:39:00.594+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":27717,"avg":18478.0}}}	1
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
457	2017-11-12 21:38:48.77+00	2017-11-19 17:54:27.221+00	festas calendarizadas populares	type/Integer	\N	f	\N	t	0	8	337	Fest As Calendar Iz Adas Popular Es	normal	\N	\N	\N	\N	\N	\N	0
530	2017-11-13 23:50:01.19+00	2017-11-14 13:50:10.294+00	Jardim zoológico, botânico, herbário, oceanário ou planetário	type/Integer	type/Category	t	\N	t	0	13	528	Jardim Zoológico, Botânico, Herbário, Oceanário Ou Planetário	normal	\N	\N	2017-11-14 13:50:10.316+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":3796,"avg":1898.0}}}	1
46	2017-11-12 21:38:37.49+00	2017-11-14 13:50:11.533+00	12	type/Integer	type/Category	t	\N	t	0	5	37	12	normal	\N	\N	2017-11-14 13:50:11.553+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":3266,"avg":1633.0}}}	1
205	2017-11-12 21:38:39.713+00	2017-11-14 13:50:11.543+00	Intercâmbio Cultural	type/Integer	type/Category	t	\N	t	0	5	192	Intercâmbio Cultural	normal	\N	\N	2017-11-14 13:50:11.553+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":39,"avg":19.5}}}	1
273	2017-11-12 21:38:44.789+00	2017-11-21 03:50:00.986+00	_create_date	type/Text	\N	t	\N	t	0	7	\N	Create Date	normal	\N	\N	\N	\N	\N	\N	0
289	2017-11-12 21:38:44.994+00	2017-11-19 17:54:25.957+00	09	type/Integer	\N	f	\N	t	0	7	288	09	normal	\N	\N	\N	\N	\N	\N	0
367	2017-11-12 21:38:47.233+00	2017-11-19 17:54:27.293+00	acervos museológicos	type/Integer	\N	f	\N	t	0	8	337	Acer Vos Museológicos	normal	\N	\N	\N	\N	\N	\N	0
441	2017-11-12 21:38:48.582+00	2017-11-19 17:54:27.319+00	fabricação de obras de arte	type/Integer	\N	f	\N	t	0	8	337	Fabricação De Obras De Arte	normal	\N	\N	\N	\N	\N	\N	0
415	2017-11-12 21:38:48.184+00	2017-11-19 17:54:27.284+00	fortalecimento de cultura de rede local	type/Integer	\N	f	\N	t	0	8	337	For Tale Ci Men To De Cultura De Rede Local	normal	\N	\N	\N	\N	\N	\N	0
335	2017-11-12 21:38:45.77+00	2017-11-21 03:50:00.988+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	7	\N	ID	normal	\N	\N	2017-11-12 21:38:59.409+00	\N	\N	{"global":{"distinct-count":3}}	1
329	2017-11-12 21:38:45.67+00	2017-11-21 03:50:01.019+00	07	type/Integer	\N	t	\N	t	0	7	322	07	normal	\N	\N	\N	\N	\N	\N	0
323	2017-11-12 21:38:45.581+00	2017-11-21 03:50:01.022+00	09	type/Integer	\N	t	\N	t	0	7	322	09	normal	\N	\N	\N	\N	\N	\N	0
327	2017-11-12 21:38:45.636+00	2017-11-21 03:50:01.024+00	05	type/Integer	\N	t	\N	t	0	7	322	05	normal	\N	\N	\N	\N	\N	\N	0
275	2017-11-12 21:38:44.828+00	2017-11-21 03:50:01.032+00	2014	type/Dictionary	\N	t	\N	t	0	7	274	2014	normal	\N	\N	2017-11-12 23:50:09.134+00	\N	\N	{"global":{"distinct-count":3}}	1
287	2017-11-12 21:38:44.966+00	2017-11-21 03:50:01.059+00	02	type/Integer	\N	t	\N	t	0	7	275	02	normal	\N	\N	\N	\N	\N	\N	0
310	2017-11-12 21:38:45.327+00	2017-11-21 03:50:01.07+00	2017	type/Dictionary	\N	t	\N	t	0	7	274	2017	normal	\N	\N	\N	\N	\N	\N	0
297	2017-11-12 21:38:45.094+00	2017-11-21 03:50:01.101+00	2015	type/Dictionary	\N	t	\N	t	0	7	274	2015	normal	\N	\N	2017-11-13 23:50:17.808+00	\N	\N	{"global":{"distinct-count":2}}	1
309	2017-11-12 21:38:45.315+00	2017-11-21 03:50:01.126+00	02	type/Integer	\N	t	\N	t	0	7	297	02	normal	\N	\N	\N	\N	\N	\N	0
291	2017-11-12 21:38:45.017+00	2017-11-21 03:50:01.147+00	11	type/Integer	\N	t	\N	t	0	7	288	11	normal	\N	\N	\N	\N	\N	\N	0
418	2017-11-12 21:38:48.217+00	2017-11-21 03:50:01.912+00	Jornalismo	type/Integer	\N	t	\N	t	0	8	337	Jorn Al Is Mo	normal	\N	\N	\N	\N	\N	\N	0
434	2017-11-12 21:38:48.481+00	2017-11-21 03:50:01.914+00	História	type/Integer	type/Category	t	\N	t	0	8	337	História	normal	\N	\N	2017-11-12 21:39:00.594+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":38745,"avg":25830.0}}}	1
274	2017-11-12 21:38:44.808+00	2017-11-21 03:50:00.991+00	_total_agents_registered_month	type/Dictionary	\N	t	\N	t	0	7	\N	Total Agents Registered Month	normal	\N	\N	2017-11-12 21:38:59.409+00	\N	\N	{"global":{"distinct-count":2}}	1
322	2017-11-12 21:38:45.539+00	2017-11-21 03:50:00.994+00	2016	type/Dictionary	\N	t	\N	t	0	7	274	2016	normal	\N	\N	\N	\N	\N	\N	0
372	2017-11-12 21:38:47.298+00	2017-11-19 17:54:27.228+00	turismo de base comunitária	type/Integer	\N	f	\N	t	0	8	337	Turismo De Base Comunitária	normal	\N	\N	\N	\N	\N	\N	0
435	2017-11-12 21:38:48.493+00	2017-11-19 17:54:27.232+00	mostras culturais	type/Integer	type/Category	f	\N	t	0	8	337	Most Ras Cultura Is	normal	\N	\N	2017-11-12 21:39:00.594+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":11028,"avg":7352.0}}}	1
440	2017-11-12 21:38:48.57+00	2017-11-19 17:54:27.315+00	permacultura e cultura hacker	type/Integer	\N	f	\N	t	0	8	337	Perm A Cultura E Cultura Hacker	normal	\N	\N	\N	\N	\N	\N	0
404	2017-11-12 21:38:47.939+00	2017-11-19 17:54:27.331+00	intercâmbio cultural	type/Integer	\N	f	\N	t	0	8	337	Intercâmbio Cultural	normal	\N	\N	\N	\N	\N	\N	0
383	2017-11-12 21:38:47.498+00	2017-11-19 17:54:27.21+00	Banda	type/Integer	\N	f	\N	t	0	8	337	Band A	normal	\N	\N	\N	\N	\N	\N	0
491	2017-11-12 21:38:50.963+00	2017-11-19 17:54:28.067+00	_amount_areas	type/Integer	type/Category	t	\N	t	0	10	\N	Amount Areas	normal	\N	\N	2017-11-14 13:50:12.362+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}	1
484	2017-11-12 21:38:50.885+00	2017-11-19 17:54:28.07+00	_cls	type/Text	type/Category	t	\N	t	0	10	\N	Cls	normal	\N	\N	2017-11-12 21:39:01.856+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":14.0}}}	1
337	2017-11-12 21:38:46.635+00	2017-11-21 03:50:01.659+00	_total_agents_area_oreration	type/Dictionary	\N	t	\N	t	0	8	\N	Total Agents Area Ore Ration	normal	\N	\N	2017-11-18 02:50:03.313+00	\N	\N	{"global":{"distinct-count":2}}	1
290	2017-11-12 21:38:45.006+00	2017-11-19 17:54:25.948+00	06	type/Integer	\N	f	\N	t	0	7	288	06	normal	\N	\N	\N	\N	\N	\N	0
410	2017-11-12 21:38:48.085+00	2017-11-21 03:50:01.917+00	cultura negra	type/Integer	\N	t	\N	t	0	8	337	Cultura Negra	normal	\N	\N	\N	\N	\N	\N	0
403	2017-11-12 21:38:47.928+00	2017-11-21 03:50:01.919+00	Jogos Eletrônicos	type/Integer	\N	t	\N	t	0	8	337	Jog Os Eletrônicos	normal	\N	\N	\N	\N	\N	\N	0
397	2017-11-12 21:38:47.739+00	2017-11-19 17:54:27.214+00	marchetaria	type/Integer	\N	f	\N	t	0	8	337	March Et Aria	normal	\N	\N	\N	\N	\N	\N	0
445	2017-11-12 21:38:48.636+00	2017-11-19 17:54:27.225+00	arte terapia	type/Integer	\N	f	\N	t	0	8	337	Arte Ter Apia	normal	\N	\N	\N	\N	\N	\N	0
377	2017-11-12 21:38:47.364+00	2017-11-19 17:54:27.26+00	Ciência Política	type/Integer	\N	f	\N	t	0	8	337	Ciência Política	normal	\N	\N	\N	\N	\N	\N	0
426	2017-11-12 21:38:48.382+00	2017-11-19 17:54:27.271+00	Gestor Publico de Cultura	type/Integer	\N	f	\N	t	0	8	337	Ge Stor Public O De Cultura	normal	\N	\N	\N	\N	\N	\N	0
432	2017-11-12 21:38:48.448+00	2017-11-19 17:54:27.327+00	agroecologia	type/Integer	\N	f	\N	t	0	8	337	A Gro Eco Logia	normal	\N	\N	\N	\N	\N	\N	0
482	2017-11-12 21:38:50.852+00	2017-11-19 17:54:28.027+00	_total_public_libraries	type/Integer	type/Category	t	\N	t	0	10	\N	Total Public Libraries	normal	\N	\N	2017-11-12 22:50:12.544+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Number":{"min":0,"max":0,"avg":0.0}}}	1
385	2017-11-12 21:38:47.533+00	2017-11-21 03:50:01.932+00	Leitura	type/Integer	\N	t	\N	t	0	8	337	Lei Tura	normal	\N	\N	\N	\N	\N	\N	0
380	2017-11-12 21:38:47.453+00	2017-11-21 03:50:01.935+00	cultura estrangeira (imigrantes)	type/Integer	\N	t	\N	t	0	8	337	Cultura Estrange Ira (imigrantes)	normal	\N	\N	\N	\N	\N	\N	0
361	2017-11-12 21:38:47.165+00	2017-11-21 03:50:01.938+00	Circo	type/Integer	type/Category	t	\N	t	0	8	337	Circo	normal	\N	\N	2017-11-13 23:50:18.503+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":27724,"avg":13862.0}}}	1
356	2017-11-12 21:38:47.08+00	2017-11-21 03:50:01.94+00	Patrimônio Imaterial	type/Integer	type/Category	t	\N	t	0	8	337	Patrimônio I Material	normal	\N	\N	2017-11-12 22:50:12.266+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":11028,"avg":7352.0}}}	1
419	2017-11-12 21:38:48.241+00	2017-11-21 03:50:01.943+00	televisão	type/Integer	\N	t	\N	t	0	8	337	Televisão	normal	\N	\N	\N	\N	\N	\N	0
353	2017-11-12 21:38:47.022+00	2017-11-21 03:50:01.945+00	produção cultural	type/Integer	type/Category	t	\N	t	0	8	337	Produção Cultural	normal	\N	\N	2017-11-12 22:50:12.266+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":38746,"avg":25830.666666666668}}}	1
462	2017-11-12 21:38:48.835+00	2017-11-21 03:50:01.948+00	patrimônio material	type/Integer	\N	t	\N	t	0	8	337	Patrimônio Material	normal	\N	\N	\N	\N	\N	\N	0
474	2017-11-12 21:38:49.002+00	2017-11-21 03:50:01.968+00	_create_date	type/Text	type/Category	t	\N	t	0	8	\N	Create Date	normal	\N	\N	2017-11-12 23:50:09.691+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":3.6666666666666665}}}	1
331	2017-11-12 21:38:45.708+00	2017-11-21 03:50:01.027+00	12	type/Integer	\N	t	\N	t	0	7	322	12	normal	\N	\N	\N	\N	\N	\N	0
307	2017-11-12 21:38:45.26+00	2017-11-21 03:50:01.129+00	04	type/Integer	\N	t	\N	t	0	7	297	04	normal	\N	\N	\N	\N	\N	\N	0
288	2017-11-12 21:38:44.983+00	2017-11-21 03:50:01.14+00	2013	type/Dictionary	\N	t	\N	t	0	7	274	2013	normal	\N	\N	\N	\N	\N	\N	0
285	2017-11-12 21:38:44.941+00	2017-11-21 03:50:01.061+00	04	type/Integer	\N	t	\N	t	0	7	275	04	normal	\N	\N	\N	\N	\N	\N	0
476	2017-11-12 21:38:49.023+00	2017-11-21 03:50:01.648+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	8	\N	ID	normal	\N	\N	2017-11-12 23:50:09.691+00	\N	\N	{"global":{"distinct-count":3}}	1
336	2017-11-12 21:38:46.613+00	2017-11-21 03:50:01.651+00	_total_agents	type/Integer	type/Category	t	\N	t	0	8	\N	Total Agents	normal	\N	\N	2017-11-14 13:50:12.196+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":38756,"avg":25837.333333333332}}}	1
472	2017-11-12 21:38:48.973+00	2017-11-21 03:50:01.654+00	_total_collective_agent	type/Integer	type/Category	t	\N	t	0	8	\N	Total Collective Agent	normal	\N	\N	2017-11-13 23:50:18.503+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":38754,"avg":19377.0}}}	1
475	2017-11-12 21:38:49.015+00	2017-11-21 03:50:01.657+00	_total_individual_agent	type/Integer	type/Category	t	\N	t	0	8	\N	Total Individual Agent	normal	\N	\N	2017-11-13 23:50:18.503+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":11030,"avg":5515.0}}}	1
390	2017-11-12 21:38:47.622+00	2017-11-21 03:50:01.922+00	mídias sociais	type/Integer	\N	t	\N	t	0	8	337	Mídias Soci A Is	normal	\N	\N	\N	\N	\N	\N	0
411	2017-11-12 21:38:48.11+00	2017-11-21 03:50:01.926+00	Comunicação	type/Integer	\N	t	\N	t	0	8	337	Comunicação	normal	\N	\N	\N	\N	\N	\N	0
401	2017-11-12 21:38:47.806+00	2017-11-21 03:50:01.929+00	economia criativa	type/Integer	\N	t	\N	t	0	8	337	Eco No Mia Cri At Iva	normal	\N	\N	\N	\N	\N	\N	0
283	2017-11-12 21:38:44.918+00	2017-11-21 03:50:01.064+00	10	type/Integer	\N	t	\N	t	0	7	275	10	normal	\N	\N	\N	\N	\N	\N	0
350	2017-11-12 21:38:46.878+00	2017-11-21 03:50:01.95+00	patrimônio imaterial	type/Integer	\N	t	\N	t	0	8	337	Patrimônio I Material	normal	\N	\N	\N	\N	\N	\N	0
409	2017-11-12 21:38:48.055+00	2017-11-21 03:50:01.953+00	Patrimônio Material	type/Integer	\N	t	\N	t	0	8	337	Patrimônio Material	normal	\N	\N	\N	\N	\N	\N	0
382	2017-11-12 21:38:47.486+00	2017-11-21 03:50:01.958+00	Arte de Rua	type/Integer	\N	t	\N	t	0	8	337	Arte De Rua	normal	\N	\N	\N	\N	\N	\N	0
366	2017-11-12 21:38:47.219+00	2017-11-21 03:50:01.96+00	Cultura Estrangeira (imigrantes)	type/Integer	\N	t	\N	t	0	8	337	Cultura Estrange Ira (imigrantes)	normal	\N	\N	\N	\N	\N	\N	0
338	2017-11-12 21:38:46.645+00	2017-11-21 03:50:01.963+00	gastronomia	type/Integer	\N	t	\N	t	0	8	337	Gas Trono Mia	normal	\N	\N	\N	\N	\N	\N	0
433	2017-11-12 21:38:48.46+00	2017-11-21 03:50:01.965+00	Arquitetura-Urbanismo	type/Integer	\N	t	\N	t	0	8	337	Ar Quite Tura Urbanism O	normal	\N	\N	\N	\N	\N	\N	0
473	2017-11-12 21:38:48.991+00	2017-11-21 03:50:01.97+00	_cls	type/Text	type/Category	t	\N	t	0	8	\N	Cls	normal	\N	\N	2017-11-12 23:50:09.691+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":3.6666666666666665}}}	1
324	2017-11-12 21:38:45.603+00	2017-11-21 03:50:01.029+00	06	type/Integer	\N	t	\N	t	0	7	322	06	normal	\N	\N	\N	\N	\N	\N	0
284	2017-11-12 21:38:44.928+00	2017-11-21 03:50:01.067+00	12	type/Integer	\N	t	\N	t	0	7	275	12	normal	\N	\N	\N	\N	\N	\N	0
616	2017-11-20 23:00:05.821+00	2017-11-29 23:50:01.413+00	_guided_tuor	type/Text	type/Category	f	\N	t	0	22	\N	Guided Tu Or	normal	\N	\N	2017-11-20 23:50:04.244+00	\N	\N	{"global":{"distinct-count":3},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":3.0508429926238145}}}	1
615	2017-11-20 23:00:05.816+00	2017-11-29 23:50:01.436+00	_public_archive	type/Text	type/Category	f	\N	t	0	22	\N	Public Archive	normal	\N	\N	2017-11-20 23:50:04.244+00	\N	\N	{"global":{"distinct-count":3},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":3.05927291886196}}}	1
306	2017-11-12 21:38:45.249+00	2017-11-21 03:50:01.133+00	12	type/Integer	\N	t	\N	t	0	7	297	12	normal	\N	\N	\N	\N	\N	\N	0
468	2017-11-12 21:38:48.902+00	2017-11-21 03:50:01.955+00	cultura cigana	type/Integer	\N	t	\N	t	0	8	337	Cultura Cig An A	normal	\N	\N	\N	\N	\N	\N	0
308	2017-11-12 21:38:45.271+00	2017-11-21 03:50:01.137+00	01	type/Integer	type/Category	t	\N	t	0	7	297	01	normal	\N	\N	2017-11-12 21:38:59.409+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":0,"max":315,"avg":210.0}}}	1
626	2017-11-20 23:41:06.797+00	2017-11-29 23:16:08.104+00	_sphere	type/Text	type/Category	f	\N	t	0	25	\N	Sphere	normal	\N	\N	2017-11-20 23:50:05.415+00	\N	\N	{"global":{"distinct-count":3},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":4.201030927835052}}}	1
627	2017-11-20 23:41:06.802+00	2017-11-29 23:16:08.086+00	_sphere_type	type/Text	type/Category	f	\N	t	0	25	\N	Sphere Type	normal	\N	\N	2017-11-20 23:50:05.415+00	\N	\N	{"global":{"distinct-count":13},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":8.354137642797436}}}	1
613	2017-11-20 23:00:05.804+00	2017-11-29 23:50:01.398+00	_thematic	type/Text	type/Category	f	\N	t	0	22	\N	Thematic	normal	\N	\N	2017-11-20 23:50:04.244+00	\N	\N	{"global":{"distinct-count":10},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":8.754741833508957}}}	1
614	2017-11-20 23:00:05.809+00	2017-11-29 23:50:01.424+00	_sphere	type/Text	type/Category	f	\N	t	0	22	\N	Sphere	normal	\N	\N	2017-11-20 23:50:04.244+00	\N	\N	{"global":{"distinct-count":3},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":6.521074815595363}}}	1
652	2017-12-05 02:50:07.452+00	2017-12-12 18:50:00.541+00	subsite	type/Integer	type/Category	t	\N	t	0	32	\N	Sub Site	normal	\N	\N	2017-12-10 00:50:09.132+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Number":{"min":4,"max":9,"avg":5.111111111111111}}}	1
663	2017-12-05 02:50:07.604+00	2017-12-12 18:50:00.552+00	update_time_stamp	type/DateTime	\N	t	\N	t	0	32	\N	Update Time Stamp	normal	\N	\N	2017-12-05 02:50:10.247+00	\N	\N	{"global":{"distinct-count":2}}	1
662	2017-12-05 02:50:07.594+00	2017-12-12 18:50:00.563+00	create_time_stamp	type/DateTime	\N	t	\N	t	0	32	\N	Create Time Stamp	normal	\N	\N	2017-12-05 02:50:10.247+00	\N	\N	{"global":{"distinct-count":32}}	1
477	2017-11-12 21:38:50.763+00	2017-12-12 18:50:05.472+00	_create_date	type/Text	type/Category	t	\N	t	0	9	\N	Create Date	normal	\N	\N	2017-11-12 21:39:00.716+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":26.0}}}	1
609	2017-11-19 17:54:27.996+00	2017-12-12 18:50:09.584+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	20	\N	ID	normal	\N	\N	2017-11-20 23:50:07.342+00	\N	\N	{"global":{"distinct-count":10000}}	1
617	2017-11-20 23:00:05.826+00	2017-12-12 18:50:10.483+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	22	\N	ID	normal	\N	\N	2017-11-20 23:50:04.244+00	\N	\N	{"global":{"distinct-count":3796}}	1
622	2017-11-20 23:41:06.514+00	2017-12-12 18:50:06.277+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	23	\N	ID	normal	\N	\N	2017-11-20 23:50:04.591+00	\N	\N	{"global":{"distinct-count":5141}}	1
622	2017-11-20 23:41:06.514+00	2017-12-12 18:50:06.277+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	23	\N	ID	normal	\N	\N	2017-11-20 23:50:04.591+00	\N	\N	{"global":{"distinct-count":5141}}	1
620	2017-11-20 23:00:05.841+00	2017-12-12 18:50:10.493+00	_date	type/DateTime	\N	t	\N	t	0	22	\N	Date	normal	\N	\N	2017-11-20 23:50:04.244+00	\N	\N	{"global":{"distinct-count":194}}	1
619	2017-11-20 23:00:05.837+00	2017-12-12 18:50:10.504+00	_instance	type/Text	type/Category	t	\N	t	0	22	\N	Instance	normal	\N	\N	2017-11-20 23:50:04.244+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":18.0}}}	1
501	2017-11-12 23:36:13.529+00	2017-12-12 18:50:11.664+00	_date	type/DateTime	\N	t	\N	t	0	12	\N	Date	normal	\N	\N	2017-11-12 23:50:11.918+00	\N	\N	{"global":{"distinct-count":327}}	1
496	2017-11-12 23:36:13.344+00	2017-12-12 18:50:11.935+00	_name	type/Text	\N	t	\N	t	0	12	\N	Name	normal	\N	\N	2017-11-12 23:50:11.918+00	\N	\N	{"global":{"distinct-count":4825},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":32.5611}}}	1
634	2017-11-21 03:35:34.461+00	2017-12-12 18:50:13.478+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	27	\N	ID	normal	\N	\N	2017-11-21 03:50:07.172+00	\N	\N	{"global":{"distinct-count":10000}}	1
637	2017-11-21 03:35:34.473+00	2017-12-12 18:50:13.51+00	_date	type/DateTime	\N	t	\N	t	0	27	\N	Date	normal	\N	\N	2017-11-21 03:50:07.172+00	\N	\N	{"global":{"distinct-count":30}}	1
642	2017-11-29 23:16:16.441+00	2017-12-12 18:50:13.6+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	29	\N	ID	normal	\N	\N	2017-11-29 23:50:11.533+00	\N	\N	{"global":{"distinct-count":770}}	1
673	2017-12-07 23:33:10.768+00	2017-12-12 18:50:15.268+00	_name	type/Text	\N	f	\N	t	0	35	\N	Name	normal	\N	\N	2017-12-10 00:50:10.975+00	\N	\N	{"global":{"distinct-count":5841},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":25.9089}}}	1
629	2017-11-20 23:41:06.81+00	2017-12-12 18:50:14.265+00	_instance	type/Text	type/Category	t	\N	t	0	25	\N	Instance	normal	\N	\N	2017-11-20 23:50:05.415+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":23.0}}}	1
602	2017-11-19 17:54:25.306+00	2017-12-12 02:11:22.731+00	_age_rage	type/Text	type/Category	f	\N	t	0	18	\N	Age Rage	normal	\N	\N	2017-11-20 23:50:06.24+00	\N	\N	{"global":{"distinct-count":7},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.3429}}}	1
661	2017-12-05 02:50:07.581+00	2017-12-12 18:50:00.574+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	32	\N	ID	normal	\N	\N	2017-12-05 02:50:10.247+00	\N	\N	{"global":{"distinct-count":108}}	1
657	2017-12-05 02:50:07.508+00	2017-12-12 18:50:00.585+00	location	type/Dictionary	\N	t	\N	t	0	32	\N	Location	normal	\N	\N	2017-12-05 02:50:10.247+00	\N	\N	{"global":{"distinct-count":23}}	1
605	2017-11-19 17:54:25.328+00	2017-12-12 18:50:03.479+00	_date	type/DateTime	\N	t	\N	t	0	18	\N	Date	normal	\N	\N	2017-11-20 23:50:06.24+00	\N	\N	{"global":{"distinct-count":757}}	1
603	2017-11-19 17:54:25.313+00	2017-12-12 18:50:03.492+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	18	\N	ID	normal	\N	\N	2017-11-20 23:50:06.24+00	\N	\N	{"global":{"distinct-count":10000}}	1
597	2017-11-18 01:13:58.401+00	2017-12-12 18:50:04.23+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	16	\N	ID	normal	\N	\N	2017-11-18 01:50:03.075+00	\N	\N	{"global":{"distinct-count":3273}}	1
595	2017-11-18 01:13:58.383+00	2017-12-12 18:50:04.257+00	_online_subscribe	type/Text	type/Category	t	\N	t	0	16	\N	Online Subscribe	normal	\N	\N	2017-11-18 01:50:03.075+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":4.801405438435686}}}	1
606	2017-11-19 17:54:25.675+00	2017-12-12 18:50:04.306+00	_create_date	type/DateTime	type/Category	t	\N	t	0	19	\N	Create Date	normal	\N	\N	2017-11-20 23:50:06.28+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":26.0}}}	1
607	2017-11-19 17:54:25.682+00	2017-12-12 18:50:04.313+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	19	\N	ID	normal	\N	\N	2017-11-20 23:50:06.28+00	\N	\N	{"global":{"distinct-count":2}}	1
478	2017-11-12 21:38:50.778+00	2017-12-12 18:50:05.511+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	9	\N	ID	normal	\N	\N	2017-11-12 21:39:00.716+00	\N	\N	{"global":{"distinct-count":2}}	1
651	2017-11-29 23:50:07.343+00	2017-12-12 18:50:05.779+00	_instance	type/Text	type/Category	t	\N	t	0	30	\N	Instance	normal	\N	\N	2017-11-29 23:50:13.197+00	\N	\N	{"global":{"distinct-count":3},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":17.207477098291655}}}	1
650	2017-11-29 23:50:07.329+00	2017-12-12 18:50:05.789+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	30	\N	ID	normal	\N	\N	2017-11-29 23:50:13.197+00	\N	\N	{"global":{"distinct-count":4039}}	1
649	2017-11-29 23:50:07.313+00	2017-12-12 18:50:05.8+00	_area	type/Text	type/Category	t	\N	t	0	30	\N	Area	normal	\N	\N	2017-11-29 23:50:13.197+00	\N	\N	{"global":{"distinct-count":41},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.387967318643229}}}	1
621	2017-11-20 23:41:06.508+00	2017-12-12 18:50:06.288+00	_area	type/Text	type/Category	t	\N	t	0	23	\N	Area	normal	\N	\N	2017-11-20 23:50:04.591+00	\N	\N	{"global":{"distinct-count":61},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":9.78603384555534}}}	1
633	2017-11-21 03:35:33.592+00	2017-12-12 18:50:07.848+00	_instance	type/Text	type/Category	t	\N	t	0	26	\N	Instance	normal	\N	\N	2017-11-21 03:50:06.271+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":17.0}}}	1
632	2017-11-21 03:35:33.588+00	2017-12-12 18:50:07.896+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	26	\N	ID	normal	\N	\N	2017-11-21 03:50:06.271+00	\N	\N	{"global":{"distinct-count":10000}}	1
631	2017-11-21 03:35:33.578+00	2017-12-12 18:50:07.907+00	_area	type/Text	type/Category	t	\N	t	0	26	\N	Area	normal	\N	\N	2017-11-21 03:50:06.271+00	\N	\N	{"global":{"distinct-count":103},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":10.8197}}}	1
608	2017-11-19 17:54:27.978+00	2017-12-12 18:50:09.701+00	_language	type/Text	type/Category	t	\N	t	0	20	\N	Language	normal	\N	\N	2017-11-20 23:50:07.342+00	\N	\N	{"global":{"distinct-count":19},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":12.9404}}}	1
610	2017-11-19 17:54:28.001+00	2017-12-12 18:50:09.849+00	_instance	type/Text	type/Category	t	\N	t	0	20	\N	Instance	normal	\N	\N	2017-11-20 23:50:07.342+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":23.9246}}}	1
645	2017-11-29 23:50:00.497+00	2017-12-12 18:50:09.922+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	31	\N	ID	normal	\N	\N	2017-11-29 23:50:10.736+00	\N	\N	{"global":{"distinct-count":914}}	1
647	2017-11-29 23:50:00.557+00	2017-12-12 18:50:09.926+00	_instance	type/Text	type/Category	t	\N	t	0	31	\N	Instance	normal	\N	\N	2017-11-29 23:50:10.736+00	\N	\N	{"global":{"distinct-count":3},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":17.38949671772429}}}	1
618	2017-11-20 23:00:05.831+00	2017-12-12 18:50:10.515+00	_museum_type	type/Text	type/Category	t	\N	t	0	22	\N	Museum Type	normal	\N	\N	2017-11-20 23:50:04.244+00	\N	\N	{"global":{"distinct-count":7},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":10.303477344573235}}}	1
498	2017-11-12 23:36:13.463+00	2017-12-12 18:50:11.946+00	_space_type	type/Text	type/Category	t	\N	t	0	12	\N	Space Type	normal	\N	\N	2017-11-12 23:50:11.918+00	\N	\N	{"global":{"distinct-count":70},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":17.4366}}}	1
500	2017-11-12 23:36:13.515+00	2017-12-12 18:50:11.957+00	_instance	type/Text	type/Category	t	\N	t	0	12	\N	Instance	normal	\N	\N	2017-11-12 23:50:11.918+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":17.0}}}	1
499	2017-11-12 23:36:13.485+00	2017-12-12 18:50:11.968+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	12	\N	ID	normal	\N	\N	2017-11-12 23:50:11.918+00	\N	\N	{"global":{"distinct-count":10000}}	1
625	2017-11-20 23:41:06.536+00	2017-12-12 18:50:11.984+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	24	\N	ID	normal	\N	\N	2017-11-20 23:50:04.627+00	\N	\N	{"global":{"distinct-count":2}}	1
624	2017-11-20 23:41:06.532+00	2017-12-12 18:50:11.99+00	_create_date	type/Text	type/Category	t	\N	t	0	24	\N	Create Date	normal	\N	\N	2017-11-20 23:50:04.627+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":26.0}}}	1
630	2017-11-20 23:41:06.814+00	2017-12-12 18:50:14.22+00	_date	type/DateTime	\N	t	\N	t	0	25	\N	Date	normal	\N	\N	2017-11-20 23:50:05.415+00	\N	\N	{"global":{"distinct-count":312}}	1
628	2017-11-20 23:41:06.806+00	2017-12-12 18:50:14.232+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	25	\N	ID	normal	\N	\N	2017-11-20 23:50:05.415+00	\N	\N	{"global":{"distinct-count":7178}}	1
639	2017-11-21 03:35:34.495+00	2017-12-12 18:50:14.281+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	28	\N	ID	normal	\N	\N	2017-11-21 03:50:07.204+00	\N	\N	{"global":{"distinct-count":1}}	1
638	2017-11-21 03:35:34.492+00	2017-12-12 18:50:14.287+00	_create_date	type/Text	type/Category	t	\N	t	0	28	\N	Create Date	normal	\N	\N	2017-11-21 03:50:07.204+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":26.0}}}	1
677	2017-12-07 23:33:10.995+00	2017-12-12 18:50:15.297+00	_date	type/DateTime	\N	t	\N	t	0	35	\N	Date	normal	\N	\N	2017-12-10 00:50:10.975+00	\N	\N	{"global":{"distinct-count":742}}	1
675	2017-12-07 23:33:10.939+00	2017-12-12 18:50:15.308+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	35	\N	ID	normal	\N	\N	2017-12-10 00:50:10.975+00	\N	\N	{"global":{"distinct-count":10000}}	1
676	2017-12-07 23:33:10.985+00	2017-12-12 18:50:15.319+00	_instance	type/Text	type/Category	t	\N	t	0	35	\N	Instance	normal	\N	\N	2017-12-10 00:50:10.975+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":25.6562}}}	1
679	2017-12-07 23:33:11.695+00	2017-12-10 10:50:04.697+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	36	\N	ID	normal	\N	\N	2017-12-10 00:50:11.175+00	\N	\N	{"global":{"distinct-count":2}}	1
678	2017-12-07 23:33:11.685+00	2017-12-10 10:50:04.703+00	_create_date	type/Text	type/Category	t	\N	t	0	36	\N	Create Date	normal	\N	\N	2017-12-10 00:50:11.175+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":26.0}}}	1
665	2017-12-05 02:50:07.626+00	2017-12-12 18:50:00.629+00	action_time	type/DateTime	\N	t	\N	t	0	32	\N	Action Time	normal	\N	\N	2017-12-05 02:50:10.247+00	\N	\N	{"global":{"distinct-count":2}}	1
653	2017-12-05 02:50:07.459+00	2017-12-12 18:50:00.64+00	single_url	type/Text	type/URL	t	\N	t	0	32	\N	Single URL	normal	\N	\N	2017-12-05 02:50:10.247+00	\N	\N	{"global":{"distinct-count":50},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":8.342592592592593}}}	1
666	2017-12-05 02:50:07.636+00	2017-12-12 18:50:00.652+00	state	type/Text	type/State	t	\N	t	0	32	\N	State	normal	\N	\N	2017-12-05 02:50:10.247+00	\N	\N	{"global":{"distinct-count":7},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":2.0}}}	1
660	2017-12-05 02:50:07.571+00	2017-12-12 18:50:00.663+00	platform_id	type/Integer	type/Category	t	\N	t	0	32	\N	Platform ID	normal	\N	\N	2017-12-05 02:50:10.247+00	\N	\N	{"global":{"distinct-count":108},"type":{"type/Number":{"min":208,"max":111456,"avg":11785.907407407407}}}	1
654	2017-12-05 02:50:07.473+00	2017-12-12 18:50:00.674+00	name	type/Text	type/Name	t	\N	t	0	32	\N	Name	normal	\N	\N	2017-12-05 02:50:10.247+00	\N	\N	{"global":{"distinct-count":3},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":1.5238095238095237}}}	1
604	2017-11-19 17:54:25.322+00	2017-12-12 18:50:03.503+00	_instance	type/Text	type/Category	t	\N	t	0	18	\N	Instance	normal	\N	\N	2017-11-20 23:50:06.24+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":24.7148}}}	1
611	2017-11-20 23:00:05.486+00	2017-12-12 18:50:03.54+00	_create_date	type/Text	type/Category	t	\N	t	0	21	\N	Create Date	normal	\N	\N	2017-11-20 23:50:03.245+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":26.0}}}	1
612	2017-11-20 23:00:05.501+00	2017-12-12 18:50:03.547+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	21	\N	ID	normal	\N	\N	2017-11-20 23:50:03.245+00	\N	\N	{"global":{"distinct-count":2}}	1
599	2017-11-18 01:13:58.413+00	2017-12-12 18:50:04.269+00	_date	type/DateTime	\N	t	\N	t	0	16	\N	Date	normal	\N	\N	2017-11-18 01:50:03.075+00	\N	\N	{"global":{"distinct-count":974}}	1
596	2017-11-18 01:13:58.395+00	2017-12-12 18:50:04.28+00	_project_type	type/Text	type/Category	t	\N	t	0	16	\N	Project Type	normal	\N	\N	2017-11-18 01:50:03.075+00	\N	\N	{"global":{"distinct-count":31},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.45096241979835}}}	1
598	2017-11-18 01:13:58.407+00	2017-12-12 18:50:04.291+00	_instance	type/Text	type/Category	t	\N	t	0	16	\N	Instance	normal	\N	\N	2017-11-18 01:50:03.075+00	\N	\N	{"global":{"distinct-count":3},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":22.80446073938283}}}	1
600	2017-11-18 01:13:58.453+00	2017-12-12 18:50:04.329+00	_create_date	type/Text	type/Category	t	\N	t	0	17	\N	Create Date	normal	\N	\N	2017-11-18 01:50:03.118+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":26.0}}}	1
601	2017-11-18 01:13:58.461+00	2017-12-12 18:50:04.337+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	17	\N	ID	normal	\N	\N	2017-11-18 01:50:03.118+00	\N	\N	{"global":{"distinct-count":2}}	1
592	2017-11-14 06:14:08.657+00	2017-12-12 18:50:05.121+00	_occupation_area	type/Text	type/Category	t	\N	t	0	15	\N	Occupation Area	normal	\N	\N	2017-11-14 13:50:13.669+00	\N	\N	{"global":{"distinct-count":59},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":8.5765}}}	1
593	2017-11-14 06:14:08.663+00	2017-12-12 18:50:05.393+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	15	\N	ID	normal	\N	\N	2017-11-14 13:50:13.669+00	\N	\N	{"global":{"distinct-count":10000}}	1
669	2017-12-05 02:50:08.135+00	2017-12-12 18:50:05.814+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	33	\N	ID	normal	\N	\N	2017-12-05 02:50:10.536+00	\N	\N	{"global":{"distinct-count":1}}	1
668	2017-12-05 02:50:08.108+00	2017-12-12 18:50:05.822+00	date	type/DateTime	\N	t	\N	t	0	33	\N	Date	normal	\N	\N	2017-12-05 02:50:10.536+00	\N	\N	{"global":{"distinct-count":1}}	1
623	2017-11-20 23:41:06.518+00	2017-12-12 18:50:06.299+00	_instance	type/Text	type/Category	t	\N	t	0	23	\N	Instance	normal	\N	\N	2017-11-20 23:50:04.591+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":23.0}}}	1
635	2017-11-21 03:35:34.465+00	2017-12-12 18:50:13.522+00	_agents_type	type/Text	type/Category	t	\N	t	0	27	\N	Agents Type	normal	\N	\N	2017-11-21 03:50:07.172+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":9.5416}}}	1
636	2017-11-21 03:35:34.469+00	2017-12-12 18:50:13.533+00	_instance	type/Text	type/Category	t	\N	t	0	27	\N	Instance	normal	\N	\N	2017-11-21 03:50:07.172+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":17.0}}}	1
643	2017-11-29 23:16:16.495+00	2017-12-12 18:50:13.61+00	_tag	type/Text	type/URL	t	\N	t	0	29	\N	Tag	normal	\N	\N	2017-11-29 23:50:11.533+00	\N	\N	{"global":{"distinct-count":323},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0025974025974025974,"percent-email":0.0,"average-length":13.7987012987013}}}	1
644	2017-11-29 23:16:16.509+00	2017-12-12 18:50:13.622+00	_instance	type/Text	type/Category	t	\N	t	0	29	\N	Instance	normal	\N	\N	2017-11-29 23:50:11.533+00	\N	\N	{"global":{"distinct-count":3},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":20.08961038961039}}}	1
672	2017-12-05 02:50:08.711+00	2017-12-12 18:50:13.637+00	subsite_id	type/Integer	type/Category	t	\N	t	0	34	\N	Sub Site ID	normal	\N	\N	2017-12-05 02:50:10.702+00	\N	\N	{"global":{"distinct-count":3},"type":{"type/Number":{"min":1,"max":33,"avg":17.333333333333332}}}	1
671	2017-12-05 02:50:08.699+00	2017-12-12 18:50:13.644+00	_id	type/MongoBSONID	type/PK	t	\N	t	0	34	\N	ID	normal	\N	\N	2017-12-05 02:50:10.702+00	\N	\N	{"global":{"distinct-count":3}}	1
670	2017-12-05 02:50:08.69+00	2017-12-12 18:50:13.655+00	url	type/Text	type/URL	t	\N	t	0	34	\N	URL	normal	\N	\N	2017-12-05 02:50:10.702+00	\N	\N	{"global":{"distinct-count":3},"type":{"type/Text":{"percent-json":0.0,"percent-url":1.0,"percent-email":0.0,"average-length":31.666666666666668}}}	1
674	2017-12-07 23:33:10.831+00	2017-12-12 18:50:15.33+00	_accessible_space	type/Text	type/Category	t	\N	t	0	35	\N	Accessible Space	normal	\N	\N	2017-12-10 00:50:10.975+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":3.0}}}	1
641	2017-11-29 23:16:08.069+00	2017-12-12 18:50:14.243+00	_library_type	type/Text	type/Category	t	\N	t	0	25	\N	Library Type	normal	\N	\N	2017-11-29 23:50:12.498+00	\N	\N	{"global":{"distinct-count":7},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":19.528301886792452}}}	1
640	2017-11-29 23:16:08.033+00	2017-12-12 18:50:14.254+00	_accessibility	type/Text	type/Category	t	\N	t	0	25	\N	Accessibility	normal	\N	\N	2017-11-29 23:50:12.498+00	\N	\N	{"global":{"distinct-count":3},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":11.431553592934565}}}	1
629	2017-11-20 23:41:06.81+00	2017-12-12 18:50:14.265+00	_instance	type/Text	type/Category	t	\N	t	0	25	\N	Instance	normal	\N	\N	2017-11-20 23:50:05.415+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":23.0}}}	1
656	2017-12-05 02:50:07.493+00	2017-12-12 18:50:00.521+00	instance_url	type/Text	type/URL	t	\N	t	0	32	\N	Instance URL	normal	\N	\N	2017-12-05 02:50:10.247+00	\N	\N	{"global":{"distinct-count":98},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":28.35185185185185}}}	1
658	2017-12-05 02:50:07.532+00	2017-12-12 18:50:00.598+00	latitude	type/Text	type/Category	t	\N	t	0	32	657	Latitude	normal	\N	\N	2017-12-05 02:50:10.247+00	\N	\N	{"global":{"distinct-count":108},"type":{"type/Text":{"percent-json":0.0,"percent-url":1.0,"percent-email":0.0,"average-length":45.342592592592595}}}	1
659	2017-12-05 02:50:07.549+00	2017-12-12 18:50:00.607+00	longitude	type/Text	type/Category	t	\N	t	0	32	657	Longitude	normal	\N	\N	2017-12-05 02:50:10.247+00	\N	\N	{"global":{"distinct-count":50},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":45.75}}}	1
667	2017-12-05 02:50:07.648+00	2017-12-12 18:50:00.618+00	action_type	type/Text	type/Category	t	\N	t	0	32	\N	Action Type	normal	\N	\N	2017-12-05 02:50:10.247+00	\N	\N	{"global":{"distinct-count":2},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":9.592592592592593}}}	1
664	2017-12-05 02:50:07.614+00	2017-12-12 18:50:00.685+00	marker_type	type/Text	type/Category	t	\N	t	0	32	\N	Marker Type	normal	\N	\N	2017-12-05 02:50:10.247+00	\N	\N	{"global":{"distinct-count":4},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.055555555555555}}}	1
655	2017-12-05 02:50:07.481+00	2017-12-12 18:50:00.696+00	city	type/Text	type/City	t	\N	t	0	32	\N	City	normal	\N	\N	2017-12-05 02:50:10.247+00	\N	\N	{"global":{"distinct-count":108},"type":{"type/Text":{"percent-json":0.0,"percent-url":1.0,"percent-email":0.0,"average-length":44.861111111111114}}}	1
594	2017-11-14 06:14:08.668+00	2017-12-12 18:50:05.411+00	_instance	type/Text	type/Category	t	\N	t	0	15	\N	Instance	normal	\N	\N	2017-11-14 13:50:13.669+00	\N	\N	{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":17.0}}}	1
646	2017-11-29 23:50:00.533+00	2017-12-12 18:50:10.082+00	_tag	type/Text	type/Category	t	\N	t	0	31	\N	Tag	normal	\N	\N	2017-11-29 23:50:10.736+00	\N	\N	{"global":{"distinct-count":137},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":11.24835886214442}}}	1
648	2017-11-29 23:50:01.318+00	2017-12-12 18:50:10.526+00	_accessibility	type/Text	type/Category	t	\N	t	0	22	\N	Accessibility	normal	\N	\N	2017-11-29 23:50:11.088+00	\N	\N	{"global":{"distinct-count":3},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":11.099767981438514}}}	1
681	2017-12-12 02:11:22.711+00	2017-12-12 18:50:16.235+00	_occurrences	type/Array	\N	t	\N	t	0	18	\N	Occurrences	normal	\N	\N	2017-12-12 18:50:16.994+00	\N	\N	{"global":{"distinct-count":8302}}	1
680	2017-12-12 02:11:22.69+00	2017-12-12 18:50:16.984+00	_age_range	type/Text	type/Category	t	\N	t	0	18	\N	Age Range	normal	\N	\N	2017-12-12 18:50:16.994+00	\N	\N	{"global":{"distinct-count":6},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.344}}}	1
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
39	2017-11-12 23:37:27.45+00	2017-11-21 03:35:37.078+00	[null,null]	\N	356
40	2017-11-12 23:37:27.527+00	2017-11-21 03:35:37.091+00	[null]	\N	353
54	2017-11-14 06:14:06.059+00	2017-11-21 03:35:37.115+00	["PercentAgents.PercentAgentsPerAreaOperation","PercentAgents.PercentIndividualAndCollectiveAgent"]	\N	473
34	2017-11-12 23:37:27.002+00	2017-11-21 03:35:36.792+00	[0,318]	\N	308
35	2017-11-12 23:37:27.044+00	2017-11-21 03:35:36.978+00	[null]	\N	360
36	2017-11-12 23:37:27.116+00	2017-11-21 03:35:36.989+00	[null,null]	\N	438
55	2017-11-14 06:14:06.085+00	2017-11-21 03:35:37+00	[null]	\N	357
37	2017-11-12 23:37:27.298+00	2017-11-21 03:35:37.012+00	[null,null]	\N	434
57	2017-11-14 06:14:06.175+00	2017-11-21 03:35:37.035+00	[null,0,4655]	\N	472
52	2017-11-14 06:14:05.668+00	2017-11-21 03:35:37.043+00	[null,0,24537]	\N	475
56	2017-11-14 06:14:06.148+00	2017-11-21 03:35:37.065+00	[null,null]	\N	361
72	2017-11-19 17:54:27.008+00	2017-11-19 17:54:27.008+00	[null,0]	\N	491
71	2017-11-19 17:54:26.55+00	2017-11-21 03:35:37.023+00	[0,29192]	\N	336
53	2017-11-14 06:14:06.039+00	2017-11-21 03:35:37.105+00	["2012-01-01 00:00:00.000000","2017-11-20 22:50:41.884470","2017-11-20 22:50:53.226614"]	\N	474
77	2017-11-21 00:50:00.208+00	2017-11-21 03:35:37.72+00	["Antropologia e Arqueologia","Antropologia e arqueologia","Artes, arquitetura e linguística","Ciências exatas, da terra, biológicas e da saúde","Defesa e segurança pública","Educação, esporte e lazer","História","Meios de comunicação e transporte","None","Produção de bens e serviços"]	\N	613
79	2017-11-21 00:50:00.242+00	2017-11-21 03:35:37.773+00	["None","Privada","Pública"]	\N	614
74	2017-11-21 00:50:00.109+00	2017-11-21 03:35:37.557+00	["None","não","sim"]	\N	616
75	2017-11-21 00:50:00.144+00	2017-11-21 03:35:37.637+00	["None","não","sim"]	\N	615
84	2017-11-21 00:50:00.355+00	2017-11-29 23:16:07.055+00	[null]	\N	627
83	2017-11-21 00:50:00.332+00	2017-11-29 23:16:07.195+00	[null]	\N	626
111	2017-12-07 23:31:46.029+00	2017-12-12 02:11:19.853+00	[null,"","Alumínio","Aquiraz","Aracaju","Atibaia","Campos do Jordão","Carlos Chagas","Caucaia","Chorozinho","Crato","Curitiba","Florianópolis","Fortaleza","Guarulhos","Itu","Mulungu","Niterói","Pentecoste","Reriutaba","SP","Santo André","Vila Velha","Várzea Paulista"]	\N	655
104	2017-12-07 23:31:45.772+00	2017-12-12 02:11:19.983+00	["Atualização","Criação"]	\N	667
107	2017-12-07 23:31:45.919+00	2017-12-12 02:11:20.039+00	[null,"","CE","ES","MG","PB","PE","PR","RJ","SC","SE","SP"]	\N	666
86	2017-11-21 00:50:00.428+00	2017-12-12 02:11:20.672+00	[null]	\N	602
87	2017-11-21 00:50:00.484+00	2017-12-12 02:11:21.022+00	["culturazsantoandrespgovbr","estadodaculturaspgovbr","lugaresdaculturaorgbr","mapaculturacegovbr","mapasculturagovbr","spculturaprefeituraspgovbr"]	\N	604
73	2017-11-21 00:50:00.068+00	2017-12-12 02:11:21.107+00	["2012-01-01 00:00:00.000000","2017-12-12 02:08:40.747022","2017-12-12 02:08:52.968244","2017-12-12 02:11:00.829071"]	\N	611
67	2017-11-19 17:54:25.693+00	2017-12-12 02:11:21.356+00	["Não","Sim"]	\N	595
66	2017-11-19 17:54:25.649+00	2017-12-12 02:11:21.432+00	["Ciclo","Concurso","Conferência Pública Estadual","Conferência Pública Municipal","Conferência Pública Nacional","Convenção","Curso","Edital","Encontro","Exibição","Exposição","Feira","Festa Popular","Festa Religiosa","Festival","Fórum","Inscrições","Intercâmbio Cultural","Jornada","Mostra","Oficina","Palestra","Parada e Desfile Cívico","Parada e Desfile Festivo","Parada e Desfile de Ações Afirmativas","Pesquisa","Programa","Reunião","Sarau","Seminário","Simpósio"]	\N	596
65	2017-11-19 17:54:25.571+00	2017-12-12 02:11:21.489+00	["blumenaumaisculturacombr","culturazsantoandrespgovbr","estadodaculturaspgovbr","jpculturajoaopessoapbgovbr","lugaresdaculturaorgbr","mapaculturacegovbr","mapasculturagovbr","spculturaprefeituraspgovbr","wwwmapaculturalpegovbr"]	\N	598
88	2017-11-21 00:50:00.599+00	2017-12-12 02:11:21.552+00	["2012-01-01T15:47:38.337Z"]	\N	606
68	2017-11-19 17:54:25.735+00	2017-12-12 02:11:21.64+00	["2012-01-01 15:47:38.337553","2017-12-12 02:09:06.078510","2017-12-12 02:10:41.379735"]	\N	600
70	2017-11-19 17:54:26.119+00	2017-12-12 02:11:22.331+00	["blumenaumaisculturacombr","culturazsantoandrespgovbr","estadodaculturaspgovbr","jpculturajoaopessoapbgovbr","lugaresdaculturaorgbr","mapaculturacegovbr","mapasculturagovbr","spculturaprefeituraspgovbr","wwwmapaculturalpegovbr"]	\N	594
41	2017-11-12 23:37:27.559+00	2017-12-12 02:11:22.424+00	["2012-01-01 00:00:00.000000","2017-12-12 02:10:04.181240","2017-12-12 02:10:37.978457","2017-12-12 02:11:04.703097"]	\N	477
102	2017-12-05 00:50:01.62+00	2017-12-12 02:11:22.636+00	["blumenaumaisculturacombr","culturazsantoandrespgovbr","estadodaculturaspgovbr","lugaresdaculturaorgbr","mapaculturacegovbr","mapasculturagovbr","spculturaprefeituraspgovbr","wwwmapaculturalpegovbr"]	\N	651
103	2017-12-05 00:50:01.634+00	2017-12-12 02:11:22.72+00	["Antropologia","Arqueologia","Arquitetura-Urbanismo","Arquivo","Arte Digital","Artes Visuais","Artesanato","Audiovisual","Cinema","Circo","Comunicação","Cultura Cigana","Cultura Digital","Cultura Estrangeira (Imigrantes)","Cultura Indígena","Cultura Lgbt","Cultura Negra","Cultura Popular","Design","Educação","Esporte","Fotografia","Gastronomia","Gestão Cultural","História","Jornalismo","Leitura","Literatura","Livro","Meio Ambiente","Moda","Museu","Mídias Sociais","Música","Novas Mídias","Outros","Patrimônio Imaterial","Patrimônio Material","Pesquisa","Produção Cultural","Rádio","Saúde","Teatro","Televisão","Turismo"]	\N	649
80	2017-11-21 00:50:00.262+00	2017-12-12 02:11:22.886+00	["blumenaumaisculturacombr","culturazsantoandrespgovbr","estadodaculturaspgovbr","jpculturajoaopessoapbgovbr","lugaresdaculturaorgbr","mapaculturacegovbr","mapasculturagovbr","spculturaprefeituraspgovbr","wwwmapaculturalpegovbr"]	\N	623
94	2017-11-29 23:16:08.782+00	2017-12-12 02:11:23.217+00	["mapasculturagovbr"]	\N	633
90	2017-11-21 00:50:01.485+00	2017-12-12 02:11:24.255+00	["culturazsantoandrespgovbr","estadodaculturaspgovbr","lugaresdaculturaorgbr","mapaculturacegovbr","mapasculturagovbr","spculturaprefeituraspgovbr"]	\N	610
96	2017-12-05 00:50:00.141+00	2017-12-12 02:11:24.318+00	["blumenaumaisculturacombr","culturazsantoandrespgovbr","estadodaculturaspgovbr","lugaresdaculturaorgbr","mapaculturacegovbr","mapasculturagovbr","spculturaprefeituraspgovbr","wwwmapaculturalpegovbr"]	\N	647
97	2017-12-05 00:50:00.174+00	2017-12-12 02:11:24.403+00	["#Arte_E_Inclusão_Social","#Casadochico","#Comunicadhsp","#Ecoasobral","#Exposições","#Fitecmaranguape","#Museu, #Icequi, #Quixelô","#Pinacotecadesobral","2016","Abin","Acervo","Acervoindigena","Acervos","Acessibilidade Cultural","Adminibram","Agente De Patrimônio","Aman","Amazônia","Ambr","Amor","Antigo","Anápolis","Arquitetura","Arquitetura-Urbanismo","Arquivo,Biblioteca, Museu","Arte","Arte Contemporanea","Arte Contemporânea","Arte Educador","Arte Moderna","Arte Sacra","Arte Sacra Sp","Artes","Artes Da Palavra","Artes Plásticas","Artes Visuais","Astronomia","Audiovisual","Audiovisual E Artes Digitais","Automóvel","Ação Educativa","Ações Culturais","Ações Educativas","Ações Literarias","Ações Sociais","Barão Do Sahy","Beco","Bem Tombado","Benedito Calixto","Biblioteca De Museu","Bibliotecas","Bioculturalidade","Biodiversidade","Blumenau","Botânica","Brasil","Café","Campinas","Capela","Carandiru","Carpologia","Casa","Casa Das Rosas","Casa Guilherme De Almeida","Casacivil","Casarãopaupreto","Centro Cultural","Centro De Referência","Centro Oeste Paulista","Cia. De Jesus","Cinema","Cinematographos","Circo","Ciência","Ciência E Tecnologia","Ciências Naturais","Coleção Biocultural","Coleção Universitária","Comdephaapasa","Comendador Breves","Companhia De Jesus","Companhia Paulista","Contação De História","Contemporânea","Coronelfabriciano","Cp","Critica Cinematográfica","Ctg","Cultura","Cultura Familiar","Cultura Popular","Cultura Prisional","Câmara Municipal","Cícero Dias","Democracia","Dialogolgbt","Direito Eleitoral","Diversidade","Diversidadesexual","Eclipse","Ecoturismo","Educação","Educação Em Instituições Culturais","Educação Informal","Educação Patrimonial","Eleições","Encontro Paulista De Museus","Equipamento Cultural","Escada","Esportes","Estação Da Língua","Estrigas","Etnobotânica","Exposição","Exposições","Filme Limite","Flora","Folclore","Força Expedicionária Brasileira","Fundacaocasagrande","Fundação Benedicto Calixto","Galeria","Geologia","Gestão Cultural","Glas Park","Governodoestadodesaopaulo","Haroldo De Campos","Herbário","História","História Regional","Inclusão Cultural","Indaiatuba","Interatividade","Interior De São Paulo","Iphan","Itinerante","Jaguarao","Jesuítas","Jogos","José Pancetti","Judiciário","Justiça Eleitoral","Karinadias","Lançamento De Livro","Legislativo","Lesbica","Lgbt","Literatura","Literaturalesbica","Literaturalgbt","Livro","Mab","Macc","Madi","Mangaratiba","Mario Peixoto","Maternidade","Mausoléu","Medicina","Meio Ambiente","Meioambiente","Memoria","Memorial","Memória","Memória Coletiva","Memória Ferroviária","Militar","Minimuseu Firmeza","Ministériopúblico","Mmr","Mpp","Municipal","Museu","Museu Casa","Museu Da Família Colonial","Museu De Arte Sacra","Museu De Ciência","Museu De Esportes","Museu De Minerais E Rochas","Museu Do Cristal","Museu Dos Clubes De Caça E Tiro De Blumenau","Museu Ferroviário","Museu Madi Sobral","Museu Penitenciário Paulista","Museu Universitário","Museuafro","Museus","Música","N4I20 Go","Natureza: Estado","Natureza: Pessoa Física","Nice Firmeza","Nob","Noroeste","Obras","Observatorio","Oficinas Artísticas","Organizacao Social","Palmas","Parque Cesamar","Partidos Políticos","Parto","Patrimonio Arquitetonico","Patrimônio Cultural","Patrimônio Cultural Andreense","Patrimônio Histórico","Patrimônio Industrial","Patrimônio Natural","Patrimônios Joseenses","Pavilhão","Penitenciária","Período Colonial","Pessoas Com Deficiência","Pinacoteca","Planetário","Plantas","Poesia","Poesia Concreta","Primeira Escola","Proac","Professores","Rasjcsisem","Restauro De Livros","Retratos Do Vento","Romancehomossexual","Rpg","Sala Especial","Sala Oficial","Santa Leopoldina","Santos Sp","Saraus","Secretariadacultura","Segunda Guerra Mundial","Semdestinodepoisqueelapartiu","Sensorial","Sentidos","Sjc","Smcespacooficial","Sorocabana","São José Dos Campos","São Paulo","Sítio","Sítio Histórico","Taipa","Taquaruçu","Teatro","Teatro Antonieta Noronha","Tecelagem Parahyba","Tjse","Tradução Literária","Tribunaldecontas","Ufpe","Universidade","Vale Do Paraíba","Virtual"]	\N	646
78	2017-11-21 00:50:00.225+00	2017-12-12 02:11:24.475+00	["blumenaumaisculturacombr","culturazsantoandrespgovbr","estadodaculturaspgovbr","lugaresdaculturaorgbr","mapaculturacegovbr","mapasculturagovbr","spculturaprefeituraspgovbr","wwwmapaculturalpegovbr"]	\N	619
76	2017-11-21 00:50:00.169+00	2017-12-12 02:11:24.532+00	["Museu Privado","Museu Público"]	\N	618
98	2017-12-05 00:50:00.277+00	2017-12-12 02:11:24.598+00	["Não","Não definido","Sim"]	\N	648
61	2017-11-14 06:14:06.568+00	2017-12-12 02:11:25.068+00	["blumenaumaisculturacombr","culturazsantoandrespgovbr","estadodaculturaspgovbr","jpculturajoaopessoapbgovbr","lugaresdaculturaorgbr","mapaculturacegovbr","mapasculturagovbr","spculturaprefeituraspgovbr","wwwmapaculturalpegovbr"]	\N	500
82	2017-11-21 00:50:00.298+00	2017-12-12 02:11:25.199+00	["2012-01-01 15:47:38.337553","2017-12-12 02:08:49.649842","2017-12-12 02:08:56.624962","2017-12-12 02:09:21.275249"]	\N	624
91	2017-11-29 23:16:06.361+00	2017-12-12 02:11:25.409+00	["Coletivo","Individual"]	\N	635
92	2017-11-29 23:16:06.773+00	2017-12-12 02:11:25.662+00	["mapasculturagovbr"]	\N	636
99	2017-12-05 00:50:01.102+00	2017-12-12 02:11:26.014+00	["blumenaumaisculturacombr","culturazsantoandrespgovbr","estadodaculturaspgovbr","jpculturajoaopessoapbgovbr","lugaresdaculturaorgbr","mapaculturacegovbr","mapasculturagovbr","spculturaprefeituraspgovbr","wwwmapaculturalpegovbr"]	\N	644
93	2017-11-29 23:16:07.346+00	2017-12-12 02:11:26.781+00	["2012-01-01 00:00:00.000000"]	\N	638
101	2017-12-05 00:50:01.225+00	2017-12-12 02:11:26.541+00	["Biblioteca Comunitária (incluí­dos os pontos de leitura)","Biblioteca Escolar","Biblioteca Especializada","Biblioteca Nacional","Biblioteca Privada","Biblioteca Pública","Biblioteca Universitária"]	\N	641
100	2017-12-05 00:50:01.193+00	2017-12-12 02:11:26.662+00	["Não","Não definido","Sim"]	\N	640
85	2017-11-21 00:50:00.38+00	2017-12-12 02:11:26.737+00	["blumenaumaisculturacombr","culturazsantoandrespgovbr","estadodaculturaspgovbr","jpculturajoaopessoapbgovbr","lugaresdaculturaorgbr","mapaculturacegovbr","mapasculturagovbr","spculturaprefeituraspgovbr","wwwmapaculturalpegovbr"]	\N	629
106	2017-12-07 23:31:45.881+00	2017-12-12 02:11:19.392+00	[""," MIKAELLY ","#CLICKCULTURASP","4 EM 1 – SETE TEMPOS -  NÓS SOMOS BENJAMIN DE OLIVEIRA","8º Encontro dos Voluntários de Guarulhos","A GERAÇÃO BEAT: VALOR LITERÁRIO, TRADUÇÕES E JAZZ","A RESTAURAÇÃO DE LIMITE","AS GORDINHAS","Aktoro Cia de Teatro","Alex Schinaider","Aline BZ Santos","Aline Nabisi","Allex Nascimento","Andre Matheus Cardoso de Sá","Angélica Sousa","Aos pés do Baobá","Apresentação de Natal, Rua Viva","Associação dos Amigos da Cultura","Ação de Intervenção com Graffiti em escolas.","Balanceará - Redução de Riscos e Danos.","Bonja Roots","Brincadeiras do Congo","CAIXA PRETA","CHURRASCARIA E POUSADA PANTANAL","CHURRASCARIA O DOMINGOS","CHURRASCARIA SÃO FRANCISCO","CHURRASCARIA TRITONIS","CIPASAC","COMUNIDADE SAMBA DO MARIA ZÉLIA","Carla Regina Borges Campos","Chagas Vale","Cleiton Fábio Santana da Silva","Coletivo Carcará","Conselho de Políticas Culturais de Guarulhos","Conselho do Funcultura de Guarulhos","Convocatória Programação É o Gera - Ocupação Artística do Teatro Carlos Câmara","Crioula Brasil Produções","Cruel - Estudos Sobre o Poder","Cultura Musical e Artes!","DANIEL TATIT EM “O SAMBA QUE UNE A GENTE”","DISCOLÉSTRA","DIÁLOGOS INSTIGANTES: O OLHAR DE QUEM VIVE A CIDADE","DUBALIZER","Dança do Ventre _ Projeto Deusas da Zona Sul ","Debora de Castro Lima","Deyse Mara","Drieli Venâncio da Silva Sousa","Duoal","Emú Produções Artísticas e Culturais","Erick  Sousa","FORRÓ DO ASSARÉ","Fabio Simões Soares","Família no Museu: Quilling de Natal","Flávio Carvalho","Flávio Teles Cardoso","Fran Ddk","Francisca Vieira de Oliveira","GEISIANE  ALVES DE ANDRADE","GRUPO ARTE DE VIVER","GRUPO DE REISADO BOI DA CAPIVARA","Geovana  Correia Nunes","Gislaine Martins da Silva","Grupo Cena Fórum ","Grupo Mozangola","Grupo Tambores de Safo","Gustavo Furtado","HELEN BLACK MULTICOR","Halline Mello","Hewerson Freitas","How You Look This Monday","Hugo Gabriel Da Costa","Intergerações Viola Paulista - Etapa Campinas","JORGINHO DO ACORDEOM","Jaqueline Caires Lima","Jardel Romão","Joao Paulo Moura","Joyce Custódio","Joyce Mariana Forte Viana","João Victor","LEITURAS DE GUILHERME DE ALMEIDA MODERNISTA","LEO MAIER","LEÔNIA ARAGAO","LINHA RUBI, o maior mercado itinerante de afetos da cidade","LITER AFRICA","Luciano Morais","Luiza Nascimento Almeida","Lúcio  Alves","MARCIA DORIS DE TOLEDO FRANCISCATTO","MELANJ NUA","Marcelo Donizeti Corrégio","Marcio Aparecido","Marcos Aurelio","Maria Bittencourt","Maria Epinefrina","Maria Juliana Linhares","Maria Lúcia","Marina Leite","Marly Rodrigues","Mary Lopes","Mauricio Rodrigues","Mc Alberto Einstein","Mostra ELCV - Sesc 2017","Mostra dos trabalhos dos alunos da ELCV - Escola LIvre de Cinema e Vídeo","Mozart Vieira","Mulheres Criadoras","Musical Sertanejo","Márcia","Márcia Maria Rodrigues Vieira","NILDO GUETO","Nayana  Misino","Nouha Kattaoui","O ÚLTIMO ALMODÓVAR","OLIDO CANTO","Oficina de Quilling","Oficina | Aquarela","Oficina | Gravuras ​","Osmar Rabelo","Osmário Simões da Silva","PONTO DE CULTURA FLOR DE LÓTUS","PROJETO SAMBA ROCK BLACK","Padero Mc Oficial","Participação e Planejamento de Políticas Culturais","Passados Presentes: A presença negra em São Paulo","Paulo Eduardo Marques de Sousa","Paulo Henrique Serau","Ponto MIS Várzea Paulista","Ponto de Cultura - CORES DO SABER FONTES DO SER","Quem disse que não te entendo?","ROCK ITALIANO","ROMULO NATALINO BONFIM DOS SANTOS","RUA VIVA, GLÓRIA","Rafael","Reginaldo 16","Rhamon Diego Sousa Soares","Roger Ramos","Rosa da Silva Sousa","SWING SAMBA COMBO","Sarah Chaves da Costa","Saulo Hollywood","Secretaria Municipal de Educação, Cultura, Esporte e Lazer de Guarulhos","Secretaria da Cultura de Novo Hamburgo","Sinfonia do Cerrado","Susana Goyeneche","Suzana Helena Fischer","TAPERA  DAS ARTES","Talita Coelho","Teatro Suspenso","Thiago de Jesus Catarino","Trupe Realejo","UMA VIAGEM PELO MUNDO","Unidade Executiva de Cultura e Turismo de Várzea Paulista","VI ENSAIO DO GRBC ESSE NAO DEIXA FURO DE NILOPOLIS PARA O CARNAVAL  2018","Valéria Pinheiro","Vanessa Correia Gonçalves","Vinícius Alves Moraes","Viviane Bizarria","Welington Luiz Moraes","Wellington  Gadelha","Werbet Barboza","X Edital Mecenas do Ceará","Zamboque e as Agonias Delirantes","daniel cruz da fonseca","luana Cavalcante","teatroendoscopia@gmail.com","vanessa furtoso","vera bergold","“NOVOS TEMPOS” E “A FLOR DA PELE”"]	\N	654
113	2017-12-12 02:11:19.494+00	2017-12-12 02:11:19.494+00	[null,1,4,9,18,23,36]	\N	652
108	2017-12-07 23:31:45.947+00	2017-12-12 02:11:19.56+00	["agent","event","project","space"]	\N	664
105	2017-12-07 23:31:45.841+00	2017-12-12 02:11:19.656+00	["-10.9453634","-17.700654799585","-20.3375599452934","-22.7429395117132","-22.9043307","-22.9371164","-23.1381034","-23.2101116712356","-23.3880242737347","-23.4657443","-23.4822985443852","-23.5310431","-23.5324103","-23.543012","-23.5432315","-23.5454822","-23.5464609","-23.5469286","-23.5511669","-23.5838408841753","-23.6298814","-23.6847741668837","-23.6857594","-25.429768423895","-27.5998378562271","-3.60114232015872","-3.7114533","-3.7275841","-3.7354577","-3.7355434","-3.7356174","-3.7360368","-3.7368085","-3.7377154","-3.7383329","-3.7391542","-3.7400037","-3.7428921","-3.7466196","-3.7500588","-3.7505805","-3.754485","-3.7557003","-3.7574993","-3.75883075756072","-3.7612761","-3.7694884","-3.7796291","-3.788234","-3.788891","-3.7942532","-3.79437314265098","-3.8180801","-3.9018879","-4.14505950515899","-4.2916356325709","-4.33211863778494","-4.33314031358957","-4.33332753151931","-4.33432246031098","-4.33554204865632","-6.53364513056753","-7.23127296854986","-7.68221789937012","0","2.81137119333114"]	\N	658
110	2017-12-07 23:31:45.998+00	2017-12-12 02:11:19.755+00	["-32.8971862792969","-37.056898","-38.3896628","-38.47412109375","-38.4747433662415","-38.4747899","-38.475741147995","-38.4766169","-38.4799414873123","-38.4800434112549","-38.4805047512054","-38.5107707977295","-38.5111652","-38.5140562","-38.5216375","-38.5271084","-38.5279906","-38.5348027","-38.5366702","-38.5441981","-38.5517611","-38.5568882","-38.5584172","-38.5628248","-38.5665937","-38.5685936","-38.5795853","-38.5808553","-38.5814456","-38.583984375","-38.5841425","-38.59372","-38.6027689","-38.6086112","-38.6113015","-38.623123170255","-38.6561248","-39.0036535263062","-39.2699432373047","-39.407958984375","-40.305661065504","-40.5799233913422","-40.7634830474854","-43.0078133","-43.1205325","-45.6330871582031","-46.4216136932373","-46.5166349","-46.5228285","-46.5316148","-46.5353014","-46.638609","-46.638795","-46.6397094","-46.6449934","-46.6590964794159","-46.6668822","-46.6732853","-46.6739024","-46.7762231826782","-46.8322062492371","-47.2550228","-47.3397016525269","-48.5484606027603","-49.289174079895","0"]	\N	659
109	2017-12-07 23:31:45.972+00	2017-12-12 02:11:20.24+00	[294,650,670,732,761,844,964,1203,1207,1314,1315,1316,1361,1362,1363,1364,1424,1555,1858,1859,1860,1861,1862,2558,2638,2640,3041,3042,3043,3044,3045,3046,3047,3048,3049,3050,3051,3052,3053,3054,3055,3056,3468,3469,3470,3471,3472,3473,3474,5687,6219,6577,7208,7218,8441,8535,8843,8947,8964,9446,11072,11499,11654,11888,12048,12408,12476,12699,14086,14251,14314,14315,14316,14317,14318,14319,14320,14321,14322,16392,16809,17829,17901,18368,18542,18548,18612,18641,18642,18644,18646,18647,18648,18649,18650,18651,18652,18653,18654,18655,18656,18657,18658,18659,18660,18661,18662,18663,18664,18665,18666,18667,18668,18669,18670,18671,18672,18673,18674,18676,18677,18678,18679,18681,20820,25628,27805,29250,29331,29332,29333,29336,29337,29338,29339,29340,29344,29345,29346,29347,29348,29349,29350,29351,30903,30904,30905,30906,30907,30908,30909,30910,30911,30912,30913,30914,30915,33069,33070,33071,33072,33073,33074,33075,33076,33077,33078,33079,33080,33081,33082,33083,33084,202680]	\N	660
81	2017-11-21 00:50:00.283+00	2017-12-12 02:11:22.81+00	["Antropologia","Arqueologia","Arquitetura-Urbanismo","Arquivo","Arte De Rua","Arte Digital","Artes Visuais","Artesanato","Audiovisual","Banda","Biblioteca","Capoeira","Carnaval","Cinema","Circo","Ciência Política","Comunicação","Coral","Cultura Cigana","Cultura Digital","Cultura Estrangeira (Imigrantes)","Cultura Indígena","Cultura Lgbt","Cultura Negra","Cultura Popular","Dança","Design","Direito Autoral","Economia Criativa","Educação","Esporte","Filosofia","Fotografia","Gastronomia","Gestor Publico De Cultura","Gestão Cultural","História","Jogos Eletrônicos","Jornalismo","Leitura","Literatura","Livro","Meio Ambiente","Moda","Museu","Mídias Sociais","Música","Novas Mídias","Opera","Orquestra","Outros","Patrimônio Imaterial","Patrimônio Material","Pesquisa","Produção Cultural","Rádio","Saúde","Sociologia","Teatro","Televisão","Turismo"]	\N	621
89	2017-11-21 00:50:01.422+00	2017-12-12 02:11:23.973+00	["Artes Circenses","Artes Integradas","Artes Visuais","Audiovisual","Cinema","Cultura Digital","Cultura Indígena","Cultura Tradicional","Curso ou Oficina","Dança","Exposição","Hip Hop","Livro e Literatura","Música Erudita","Música Popular","Outros","Palestra, Debate ou Encontro","Rádio","Teatro"]	\N	608
62	2017-11-14 06:14:06.664+00	2017-12-12 02:11:24.864+00	["Antiquário","Arquivo Privado","Arquivo Público","Ateliê","Audioteca","Banca de jornal","Bem Arqueológico","Bem Imóvel","Bem Móvel ou Integrado","Bem Paisagístico","Bens culturais de natureza imaterial","Bens culturais de natureza material","Biblioteca Comunitária (incluí­dos os pontos de leitura)","Biblioteca Escolar","Biblioteca Especializada","Biblioteca Nacional","Biblioteca Privada","Biblioteca Pública","Biblioteca Universitária","Casa de espetáculo","Casa do Patrimônio","Centro Comunitário","Centro Cultural Privado","Centro Cultural Público","Centro Espírita","Centro cultural itinerante","Centro de Artes e Esportes Unificados - CEUs","Centro de Documentação Privado","Centro de Documentação Público","Centro de artesanato","Centro de tradições","Cine itinerante","Cineclube","Circo Fixo","Circo Itinerante","Circo Moderno","Circo Tradicional","Clube social","Coleções","Concha acústica","Coreto","Creative Bureau","Danceteria","Documentação","Drive-in","Escola livre de Artes Cênicas","Escola livre de Artes Visuais","Escola livre de Audiovisual","Escola livre de Cultura Digital","Escola livre de Cultura Popular","Escola livre de Design","Escola livre de Gestão Cultural","Escola livre de Hip Hop","Escola livre de Música","Escola livre de Patrimônio","Escola livre de Pontinhos de cultura","Espaço Mais Cultura","Espaço Público Para Projeção de Filmes","Espaço para Eventos","Espaço para apresentação de dança","Estúdio","Galeria de arte","Ginásio Poliesportivo","Igreja","Instituição Privada Comunitária","Instituição Privada Comunitária exclusivamente voltada para formação artistica e cultural","Instituição Privada Confessional","Instituição Privada Confessional exclusivamente voltada para formação artistica e cultural","Instituição Privada Filantrópica","Instituição Privada Filantrópica exclusivamente voltada para formação artistica e cultural","Instituição Privada Particular","Instituição Privada Particular exclusivamente voltada para formação artistica e cultural","Instituição Pública Distrital exclusivamente voltada para formação artistica e cultural","Instituição Pública Estadual exclusivamente voltada para formação artistica e cultural","Instituição Pública Federal exclusivamente voltada para formação artistica e cultural","Instituição Pública Municipal exclusivamente voltada para formação artistica e cultural","Instituição Pública de Ensino Regular Distrital","Instituição Pública de Ensino Regular Estadual","Instituição Pública de Ensino Regular Federal","Instituição Pública de Ensino Regular Municipal","Lan-house","Livraria","Mesquitas","Museu Privado","Museu Público","Outros","Outros Equipamentos Culturais","Palco de Rua","Ponto de Cultura","Ponto de Leitura Afro","Pontos de Memória","Praça dos esportes e da cultura","Rádio Comunitária","Sala Multiuso","Sala de Leitura","Sala de cinema","Sala de dança","Sebo","Sitio Histórico","Teatro Privado","Teatro Público","Templo","Terreiro","Terreno para Circo","Trio elétrico","Usina Cultural","Videolocadora"]	\N	498
112	2017-12-07 23:31:46.431+00	2017-12-12 02:11:26.091+00	[1,4,9,18,23,36]	\N	672
69	2017-11-19 17:54:26.009+00	2017-12-12 02:11:22.025+00	["Antropologia","Arqueologia","Arquitetura-Urbanismo","Arquivo","Arte Digital","Arte de Rua","Artes Visuais","Artesanato","Audiovisual","Banda","Biblioteca","Capoeira","Carnaval","Cinema","Circo","Ciência Política","Comunicação","Coral","Cultura Cigana","Cultura Digital","Cultura Estrangeira (imigrantes)","Cultura Indígena","Cultura LGBT","Cultura Negra","Cultura Popular","Dança","Design","Direito Autoral","Economia Criativa","Educação","Esporte","Filosofia","Fotografia","Gastronomia","Gestor Publico de Cultura","Gestão Cultural","História","Humor","Jogos Eletrônicos","Jornalismo","Leitura","Literatura","Livro","Meio Ambiente","Moda","Museu","Mídias Sociais","Música","Novas Mídias","Opera","Orquestra","Outros","Patrimônio Imaterial","Patrimônio Material","Pesquisa","Produção Cultural","Rádio","Saúde","Sociologia","Teatro","Televisão","Turismo","acervos museológicos","agente cultura viva","arquivo","arte de rua","artes visuais","artistas agentes culturais","cultura popular","economia criativa"]	\N	592
95	2017-11-29 23:16:09.367+00	2017-12-12 02:11:23.601+00	["Acervos Museológicos","Agentes","Agroecologia","Antropologia","Arqueologia","Arquitetura-Urbanismo","Arquivo","Arte De Rua","Arte Digital","Arte Terapia","Artes Visuais","Artesanato","Artistas Agentes Culturais","Audiovisual","Banda","Biblioteca","Capoeira","Carnaval","Cinema","Circo","Ciência Política","Comunicação","Coral","Cultura Cigana","Cultura De Redes","Cultura Digital","Cultura Estrangeira (Imigrantes)","Cultura Indígena","Cultura Lgbt","Cultura Negra","Cultura Popular","Culturas Urbanas","Danca","Dança","Dança E Canto Coral","Demais Atividades Correlatas A Cultura Popular","Design","Direito Autoral","Economia Criativa","Educação","Esporte","Exposições","Fabricação De Obras De Arte","Festas Calendarizadas Populares","Filosofia","Fortalecimento De Cultura De Rede Local","Fotografia","Gastronomia","Gestor Publico De Cultura","Gestão Cultural","História","Intercambio Cultural","Intercâmbio Cultural","Jogos Eletrônicos","Jornalismo","Leitura","Literatura","Literatura Infantil","Livro","Marchetaria","Meio Ambiente","Moda","Mostras Culturais","Museu","Mídias Sociais","Música","Novas Mídias","Opera","Orquestra","Outros","Patrimônio Imaterial","Patrimônio Material","Permacultura E Cultura Hacker","Pesquisa","Ponto De Memória","Produção Cultural","Rádio","Saúde","Sociologia","Teatro","Teatro Estudantil","Televisão","Turismo","Turismo De Base Comunitária"]	\N	631
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
10	2017-11-12 21:38:37.145+00	2017-11-19 17:54:24.599+00	percent_libraries	4	\N	\N	\N	f	2	Percent Libraries	\N	\N	\N	\N	\N	f
7	2017-11-12 21:38:37.093+00	2017-11-21 03:50:04.864+00	amount_agents_registered_per_month	3	\N	\N	\N	f	2	Amount Agents Registered Per Month	\N	\N	\N	\N	\N	f
8	2017-11-12 21:38:37.113+00	2017-11-21 03:50:05.162+00	percent_agents	6	\N	\N	\N	f	2	Percent Agents	\N	\N	\N	\N	\N	f
36	2017-12-07 23:31:42.506+00	2017-12-10 10:50:08.961+00	last_update_mixed_date	3	\N	\N	\N	f	2	Last Update Mixed Date	\N	\N	\N	\N	\N	f
32	2017-12-05 02:50:00.101+00	2017-12-12 18:50:15.387+00	marker	211	\N	\N	\N	t	2	Marker	\N	\N	\N	\N	\N	f
18	2017-11-19 17:54:15.822+00	2017-12-12 18:50:15.66+00	event_data	460174	\N	\N	\N	t	2	Event Data	\N	\N	\N	\N	\N	f
21	2017-11-20 23:00:05.458+00	2017-12-12 18:50:17.017+00	last_update_museum_date	16	\N	\N	\N	t	2	Last Update Museum Date	\N	\N	\N	\N	\N	f
16	2017-11-18 01:13:49.852+00	2017-12-12 18:50:17.047+00	project_data	4915	\N	\N	\N	t	2	Project Data	\N	\N	\N	\N	\N	f
19	2017-11-19 17:54:15.839+00	2017-12-12 18:50:17.075+00	last_update_event_date	15	\N	\N	\N	t	2	Last Update Event Date	\N	\N	\N	\N	\N	f
17	2017-11-18 01:13:49.861+00	2017-12-12 18:50:17.098+00	last_update_project_date	16	\N	\N	\N	t	2	Last Update Project Date	\N	\N	\N	\N	\N	f
15	2017-11-14 06:14:04.121+00	2017-12-12 18:50:17.167+00	occupation_area	81116	\N	\N	\N	t	2	Occupation Area	\N	\N	\N	\N	\N	f
9	2017-11-12 21:38:37.126+00	2017-12-12 18:50:17.205+00	last_update_date	16	\N	\N	\N	t	2	Last Update Date	\N	\N	\N	\N	\N	f
30	2017-11-29 23:49:25.126+00	2017-12-12 18:50:17.25+00	museum_area	4697	\N	\N	\N	t	2	Museum Area	\N	\N	\N	\N	\N	f
33	2017-12-05 02:50:00.163+00	2017-12-12 18:50:17.275+00	last_request	1	\N	\N	\N	t	2	Last Request	\N	\N	\N	\N	\N	f
23	2017-11-20 23:41:06.025+00	2017-12-12 18:50:17.306+00	library_area	8873	\N	\N	\N	t	2	Library Area	\N	\N	\N	\N	\N	f
26	2017-11-21 03:35:29.707+00	2017-12-12 18:50:17.893+00	agents_area	1360785	\N	\N	\N	t	2	Agents Area	\N	\N	\N	\N	\N	f
20	2017-11-19 17:54:15.848+00	2017-12-12 18:50:18.232+00	event_language	596390	\N	\N	\N	t	2	Event Language	\N	\N	\N	\N	\N	f
31	2017-11-29 23:49:25.159+00	2017-12-12 18:50:18.267+00	museum_tags	1123	\N	\N	\N	t	2	Museum Tags	\N	\N	\N	\N	\N	f
22	2017-11-20 23:00:05.471+00	2017-12-12 18:50:18.3+00	museum_data	4410	\N	\N	\N	t	2	Museum Data	\N	\N	\N	\N	\N	f
12	2017-11-12 23:34:53.741+00	2017-12-12 18:50:18.348+00	space_data	49992	\N	\N	\N	t	2	Space Data	\N	\N	\N	\N	\N	f
24	2017-11-20 23:41:06.031+00	2017-12-12 18:50:18.371+00	last_update_library_date	16	\N	\N	\N	t	2	Last Update Library Date	\N	\N	\N	\N	\N	f
27	2017-11-21 03:35:29.73+00	2017-12-12 18:50:18.79+00	agents_data	586695	\N	\N	\N	t	2	Agents Data	\N	\N	\N	\N	\N	f
29	2017-11-29 23:16:04.569+00	2017-12-12 18:50:18.822+00	library_tags	850	\N	\N	\N	t	2	Library Tags	\N	\N	\N	\N	\N	f
34	2017-12-05 02:50:00.208+00	2017-12-12 18:50:18.852+00	subsite	7	\N	\N	\N	t	2	Sub Site	\N	\N	\N	\N	\N	f
25	2017-11-20 23:41:06.038+00	2017-12-12 18:50:18.878+00	library_data	8424	\N	\N	\N	t	2	Library Data	\N	\N	\N	\N	\N	f
28	2017-11-21 03:35:29.738+00	2017-12-12 18:50:18.905+00	last_update_agents_date	1	\N	\N	\N	t	2	Last Update Agents Date	\N	\N	\N	\N	\N	f
35	2017-12-07 23:31:42.427+00	2017-12-12 18:50:18.963+00	event_and_space_data	86031	\N	\N	\N	t	2	Event And Space Data	\N	\N	\N	\N	\N	f
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
\\xcca62bcb9ce629ccb24f725ece5e35030524055a86b66bcc953aba3577ebc9c3	54
\\x16e2d7ff11bc2e7d42782f48f0e2396a8b5a768fbc30b8d6e5aaaa10ab8ac394	96
\\xddf69860789b56378e70bb0200b6ad3cfe9dcdb22cc1a67e2806a9d78a172d5b	145
\\x145da31dd998d0d0e86cebcf61f819850b54e1b817610ef0f57af5b3e2cc1171	74
\\x5c7f8a7da7a185bcb6d36485e5ced07d14db9a872f29b08bb9c969ce0a59205b	90
\\x79b9821f976e9b44dcefe483b0b0aac3aeeae51ad963ad7a420c1d2af4258a11	69
\\x6266766110761ffd546a5658d01aa2416f0dfe685509a41988e80dfbff701be4	112
\\x9c0228d167203464c42d91efe815d6f17a8be95ddbe03adadcb8617b5a1c4a46	137
\\x23e4321c147245a4d20fb56fd5e3a7c76ed29c2139ae859a90a9a2f04ab731bc	137
\\x496390f2f0b50e2fbfc8c751ba6e74596619323710bdcbbeea173e6d7f0bd10b	90
\\x8945bdcc19389d03a61d4f8ed4b39f90d8c87456afe41af017db088ef52f6028	153
\\x1c446c3459dadecb44f60ee7c2138493eadb825ab7ed7d7461513f3d5bfd7185	83
\\xe7a4740534679b9671915c65b50eadd2563f583450724d8b3b902061afa64279	106
\\xc9c537fffd3a147ff3f39f6ce2e59b24d97bb2467c3818ac5495f6f9e07181d6	111
\\xae104a6053fee2863008c26b825968d22fb42f575f9657358821ac862b87fd2b	115
\\xd124d06e139130090a743e729d1bdf5e57997154ac5afa515a3de80a3a48f6ac	68
\\xec6fcbd015478995fa62dad707519637458ee1b7b9d7dca35aa2784b39b7c518	91
\\x9bec7843a5f94ab47eb40948622b1f8f78b7429885aff8c4e92e72ae5dfa105a	319
\\x490d37dcbc61cde4cabda5f9801f4464045fb2834df78c9a9fb3488c2399b6f9	84
\\xa6e43734a8b76c28bb3723d3475c2427ff139362a5a98c49cc96035ff3f1d29c	105
\\xea15adb9ebf96bf593bb87a25e21c6a4976a7aef779aab72073e95005a5f83e8	100
\\x792a044714c63be23038204865243264e18fb8501465b9b23451a2a84ebe4db3	111
\\xe48a2eaa6c8d7695da35bdcaf46e865a3bc1a8d734088e03a888695e2524a0a0	43
\\xa10b50b18a6553118701872a96318522684bf78ab319b585168ef6fb1a59f9c0	76
\\x62e27e4990cc2b7ff87a3330d56cdd634cf8669d2fede6b98363dd360be4de0a	52
\\x12f7e73cd2296f266a4e4e2b809490588e85e1dcce9e40d66b830a1b90453530	315
\\x40e11f555ac44ba39d996c77cadb1581fa3a07d058f57bc9b2b57fec9c964f8f	703
\\x3d4b7ca05f18b2de0927bd10138aba99a571e980b545ad1e4ba4e57151a9d8c7	49
\\x439520b880e95500549b7ebcda358e9b5c6a2f3c005991646856e318da1a604a	65
\\xf19ab079b9f266aa766b47ddf4b37c76acd4aff757e3e118d5ca627fa49566ee	80
\\x89cafcce7cfcb2a59fb6d92c927424b393176508506ba184e532d93903a04cfc	691
\\xa0b6ed88d7a11c2ffc8d31672ff10e18c3bbcb88bc64bf0f63f185931b1b8667	672
\\xe2670f46217a0dfc8dcab2ed6364b07504ff883c5f1e8e47c7ef760a5f69f8ac	526
\\x3d4b7ca05f18b2de0927bd10138aba99a571e980b545ad1e4ba4e57151a9d8c7	69
\\xf19ab079b9f266aa766b47ddf4b37c76acd4aff757e3e118d5ca627fa49566ee	90
\\x6b5039481ad1749520b96d2176d5bfbc2b6eba08495cf8054faed42d28658a53	53
\\xbd3c80317764415cbb70c03f7e0e90dfc07a01e3e1333ce11ff44575c04a364e	60
\\x4fa64b3921a5345e56cafded326679d694ff759dc9c14a9c99a091b6ef7b026a	94
\\xb204f11185354b6c0ec52816fc20f7cc5bf1d6d243ec958396bca494fe96a3e6	139
\\xf429d0082adac3811e2b09eae4f56e1fd5b00b94e25974cd3300caf8fbf69bc5	63
\\x1b2c5b875d8182fec9db84e655c89d8a3048a62bc21e7fcdc9fac6c4fb5cf048	125
\\xf8ab73da628afbbd148c05f79cda69acc8b423606ecfc38614e2285f065b31c5	243
\\x439520b880e95500549b7ebcda358e9b5c6a2f3c005991646856e318da1a604a	71
\\x12a53ccb1cb8a3080959a9ce2fd1092c70830f3c85f6bf6486852cca4ef89101	73
\\xc77bd3c48b5a9df9b990a32a667f05820a4338047b22d5ba99e70089ae71772d	65
\\x3d017954f202fb414a9c97d85b9aeda04aee29cd7e642a6d9934c3444ef076c7	180
\\x5b235df997ac3a28fad99220b37bf16e682e1a26d6b784e210e6f046345c28f6	84
\\x079badf11ef5b863ed7cbae46f7622895acbc78068697f5140c33deb98f9cdc3	94
\\xcd5d9bbf219397f5d48c792905989514725c1481176446dd62b66b353892d5d5	53
\\x619ba579cc2cba9995d467f0c1b5eeceb63896b971c47ee34e6ed4b154eaefa3	75
\\x4378f8e359fd2cef7a7968e05f2c7b5aa6155e537a799688097eb1a1844b079c	52
\\x1913b6e388cb6d697ec47a12fcd29ae9abd4a71069f6bfc4c18fc97575ca0a27	48
\\xed2a4829b7a6c6923808014390693d5567723fb8ad2a1cfe6973fb74f1398c6c	72
\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	147
\\x29b0c260982c378cf8a1c056056e713de28c007cc341c89cd0fb1dca40fd5cf8	36
\\x2d92775ca5136dd0fcfd1d1bcd3fb6a8ac2a509ee66e18f7dc4abfb5a4a954e1	360
\\xcf5fa65ff623d108eb46e643a888d5cb7a593a64af7314b44379bbe7a510e574	178
\\xbc462fc1376ef84c69934f95a21232cf42adf867eaea01c64d05fd4215667f9b	168
\\x21678b2295982c88e9789dfcb7287c8fd16779962af06fd27243776617554f13	51
\\xff28920483cc37246197c20a937a686b4dc5a0f2eb23876726db7e099d175cb3	41
\\x6211b1138bac14e5fa2bcfee231d2ef771cfbaf3c6f887897328190dd8ff31cb	226
\\x8c2f81f74f2358b3c15d63bb859c858cce011ebd9fd88c86ccebdab8bd5a2ddb	86
\\x2cf3c6a70291d2eedbfc531b84979a306c14f7311a0f69aeed88991221f441a8	46
\\x828ec0cdaf94cfd3779e38089101f74b8032442aba4864a808d4201ec75718e4	47
\\x522c67fda35f38ca78c1877bcdc6771f8e18baff2989da9f57ab89939c670fd7	118
\\xf929d282ed7b516cf7e299cd2576fcc3eea6e71c4991b382da2c97278a42500d	79
\\xdd3c7f6ba2efd52b79f108613dbffd3eb8e467b60e497bb58be214f335c7483b	94
\\xaa901522813549cd496f3cea1d156873c754ef70bc2db6ad4355aff75881926b	72
\\x193c05af79fa01184fc2e96dc7648387710861d1e3aea4505581754911fa858c	93
\\x1bcc3dbd1e0fd082d85003fb3f6e1aa293f81baa235334a830c5303f55d667f1	161
\\x788c553fafd2b30ce63547893a9363b992cfc0ca291e2a09d712225096ac2343	518
\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	386
\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	350
\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	407
\\xfe08604a45b1dba23d6706c683efeaee01bbbb6f5fa92960dbdf191a185c3e42	124
\\x82b87d1d4b956fada0b7913fd3d8233cc2d0a10f255c584e09464b7f18d06521	254
\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	515
\\xb7a8a7beee1d9d7f6b94ff0a6319ee2fdd3d4b016068d7a98f02223da31d565f	239
\\x4cf43208abb0f3ca767b1cc53b293df5d4af5019eaee0dc8b42c854871b2926d	190
\\x925d0cc3c4d3349e205f4f3566c16eda0d16d0a24d9e13c8a136cee8d5e6d5e6	861
\\xd4ed4ac21fda71a4b2231eff9a755b9dead0d0bf27404a27a5dbc10010653ffc	181
\\x4137eca275677512e40c4067440bbda54abfe13438b361d223e8a468857534e0	1331
\\x11e68b9a037ede3e1ad055c2177f5b6a91586af0720cdd9498eed3113be16777	298
\\x1f5d7e115aa4704cb62d8b71c6d68d190a42ae068e86aca244ce85a8891f7f99	179
\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	144
\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	778
\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	757
\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	1551
\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	146
\\x37cf77f673095db6a1e2cfd7f043a2a64f05eb17c9d788e89bd75de8d5f6645a	879
\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	6969
\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	12069
\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	130
\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	12706
\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	13250
\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	15464
\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	1063
\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	952
\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	902
\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	10843
\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	883
\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	134
\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	902
\\x717d5eb3ecbcf66e03cfdf86a5ed4c2f3d9782c07dc5d19da226844f18d8b124	2928
\\xc346abd9fcf85f7d1e8a8c4fdb8708e47a185aa472f4fdf9f62814de5af77288	4615
\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	4708
\\x8f34e1a8509769dd9f759c926a8a7e9492491ac784b1e7218e221ae8707522b5	90
\\x8ca1483aa78081de6c3e2ebe04e1af174c842edde39e7db8cf04a093acf31d44	120
\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	5270
\\x22857619da3be9a5770e9568affe76f0cd06255f213e2987407e4041c7b81978	4489
\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	4384
\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	224
\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	885
\\x7ed7a6af6a4f9fb06f599568fa7525c4e43cda3accec24b1fcf07f9781e1a3a1	818
\\x2df1c1b99dab5d6c0df61c40a4bc206c6dfad0aa9bb3abebb778075cb7301608	130
\\xb01ab430a97f00647f2ea6776c5224260a950c9bdd337897bfbf26a5ee89aa9b	201
\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	98
\\x6c4e31712c119cf7a66b289f88ff5f98a2fd6f85b950a8d1ba162468c2c67b24	103
\\x08fb682e6462441c203ded87d8fd61c85b379b279309ba2c3baedbec1e3a432c	238
\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	100
\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	161
\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	195
\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	112
\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	118
\\xe70291818d87d3dce40668f3feb8dabcbdfd8288676c4aed01571e4040c0bbab	239
\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	140
\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	204
\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	1077
\\x16f264b4f2051e7b92cd622b1ad1bb9c18ac323fe6b987b14633924632a8343b	138
\\x03ab7b55cad996e98ecdf6097c61c13ef3cb0189c01cc2e66b58a07fcff4fd2c	47
\\x3673ca69aa1bccfd54ec76b12ad8eaa823899b44f9b755114635baba929aeb6d	132
\\x4cdd58ce635e28e4c4632ebf3524af71e4ea32d396bb6fedc1bd717999a95297	86
\\x09ec3782572f315a26db4edbfeeb5929449aa44c1ee7632972ec3e9c66d651df	117
\\xbcffe78744ab2241567e650bea687f68c7215ac8fd15891bc444ec2e4284317a	133
\\xabf202a64060a604c55904bba5c66eac4490ceebb207a3c8910a5daa9108d1d3	115
\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	138
\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	828
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
746	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-11-21 01:54:36.038	26	55	f	embedded-question	\N	\N	11	\N	\N
747	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-11-21 01:54:36.58	36	125	f	embedded-question	\N	\N	10	\N	\N
748	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-11-21 01:54:36.887	30	75	f	embedded-question	\N	\N	13	\N	\N
749	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-11-21 01:54:37.125	20	2	f	embedded-question	\N	\N	12	\N	\N
752	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-11-21 01:55:30.494	39	75	f	embedded-question	\N	\N	13	\N	\N
753	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-11-21 01:55:30.719	25	2	f	embedded-question	\N	\N	12	\N	\N
754	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-11-21 01:58:35.903	39	55	f	embedded-question	\N	\N	11	\N	\N
756	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-11-21 01:58:36.891	27	75	f	embedded-question	\N	\N	13	\N	\N
758	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-11-21 01:58:39.598	216	44	f	embedded-question	\N	\N	15	\N	\N
760	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-11-21 01:58:39.582	187	107	f	embedded-question	\N	\N	14	\N	\N
762	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-11-21 01:59:21.814	101	7	f	embedded-question	\N	\N	16	\N	\N
763	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-11-21 01:59:21.85	134	44	f	embedded-question	\N	\N	15	\N	\N
767	\\x6b5039481ad1749520b96d2176d5bfbc2b6eba08495cf8054faed42d28658a53	2017-11-21 02:03:38.37	28	3	f	embedded-question	\N	\N	21	\N	\N
770	\\xf429d0082adac3811e2b09eae4f56e1fd5b00b94e25974cd3300caf8fbf69bc5	2017-11-21 02:03:39.386	57	7	f	embedded-question	\N	\N	18	\N	\N
773	\\xbd3c80317764415cbb70c03f7e0e90dfc07a01e3e1333ce11ff44575c04a364e	2017-11-21 02:03:45.51	30	10	f	embedded-question	\N	\N	19	\N	\N
774	\\xf429d0082adac3811e2b09eae4f56e1fd5b00b94e25974cd3300caf8fbf69bc5	2017-11-21 02:03:46.021	43	7	f	embedded-question	\N	\N	18	\N	\N
777	\\x4378f8e359fd2cef7a7968e05f2c7b5aa6155e537a799688097eb1a1844b079c	2017-11-21 02:03:46.744	34	3	f	embedded-question	\N	\N	20	\N	\N
778	\\x4378f8e359fd2cef7a7968e05f2c7b5aa6155e537a799688097eb1a1844b079c	2017-11-21 02:04:56.877	24	3	f	embedded-question	\N	\N	20	\N	\N
779	\\xbd3c80317764415cbb70c03f7e0e90dfc07a01e3e1333ce11ff44575c04a364e	2017-11-21 02:04:57.415	24	10	f	embedded-question	\N	\N	19	\N	\N
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
750	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-11-21 01:55:30.062	46	55	f	embedded-question	\N	\N	11	\N	\N
751	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-11-21 01:55:30.076	49	125	f	embedded-question	\N	\N	10	\N	\N
755	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-11-21 01:58:35.946	43	125	f	embedded-question	\N	\N	10	\N	\N
757	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-11-21 01:58:37.512	22	2	f	embedded-question	\N	\N	12	\N	\N
759	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-11-21 01:58:39.609	200	7	f	embedded-question	\N	\N	16	\N	\N
761	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-11-21 01:58:39.684	226	57	f	embedded-question	\N	\N	17	\N	\N
764	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-11-21 01:59:21.794	200	107	f	embedded-question	\N	\N	14	\N	\N
765	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-11-21 01:59:22.479	100	57	f	embedded-question	\N	\N	17	\N	\N
766	\\x4378f8e359fd2cef7a7968e05f2c7b5aa6155e537a799688097eb1a1844b079c	2017-11-21 02:03:37.809	29	3	f	embedded-question	\N	\N	20	\N	\N
768	\\xbd3c80317764415cbb70c03f7e0e90dfc07a01e3e1333ce11ff44575c04a364e	2017-11-21 02:03:39.279	27	10	f	embedded-question	\N	\N	19	\N	\N
769	\\x4378f8e359fd2cef7a7968e05f2c7b5aa6155e537a799688097eb1a1844b079c	2017-11-21 02:03:39.338	31	3	f	embedded-question	\N	\N	20	\N	\N
771	\\x6b5039481ad1749520b96d2176d5bfbc2b6eba08495cf8054faed42d28658a53	2017-11-21 02:03:40.206	24	3	f	embedded-question	\N	\N	21	\N	\N
772	\\x6b5039481ad1749520b96d2176d5bfbc2b6eba08495cf8054faed42d28658a53	2017-11-21 02:03:45.312	21	3	f	embedded-question	\N	\N	21	\N	\N
775	\\x4378f8e359fd2cef7a7968e05f2c7b5aa6155e537a799688097eb1a1844b079c	2017-11-21 02:03:46.248	27	3	f	embedded-question	\N	\N	20	\N	\N
776	\\x6b5039481ad1749520b96d2176d5bfbc2b6eba08495cf8054faed42d28658a53	2017-11-21 02:03:46.417	27	3	f	embedded-question	\N	\N	21	\N	\N
780	\\x619ba579cc2cba9995d467f0c1b5eeceb63896b971c47ee34e6ed4b154eaefa3	2017-11-21 02:04:57.701	41	3	f	embedded-question	\N	\N	22	\N	\N
781	\\x4fa64b3921a5345e56cafded326679d694ff759dc9c14a9c99a091b6ef7b026a	2017-11-21 02:04:57.877	41	47	f	embedded-question	\N	\N	23	\N	\N
782	\\xf429d0082adac3811e2b09eae4f56e1fd5b00b94e25974cd3300caf8fbf69bc5	2017-11-21 02:04:58.047	41	7	f	embedded-question	\N	\N	18	\N	\N
783	\\x6b5039481ad1749520b96d2176d5bfbc2b6eba08495cf8054faed42d28658a53	2017-11-21 02:04:58.252	58	3	f	embedded-question	\N	\N	21	\N	\N
784	\\xf429d0082adac3811e2b09eae4f56e1fd5b00b94e25974cd3300caf8fbf69bc5	2017-11-21 02:05:22.742	36	7	f	embedded-question	\N	\N	18	\N	\N
785	\\x619ba579cc2cba9995d467f0c1b5eeceb63896b971c47ee34e6ed4b154eaefa3	2017-11-21 02:05:23.386	33	3	f	embedded-question	\N	\N	22	\N	\N
786	\\x6b5039481ad1749520b96d2176d5bfbc2b6eba08495cf8054faed42d28658a53	2017-11-21 02:05:23.583	24	3	f	embedded-question	\N	\N	21	\N	\N
787	\\x4378f8e359fd2cef7a7968e05f2c7b5aa6155e537a799688097eb1a1844b079c	2017-11-21 02:05:23.765	24	3	f	embedded-question	\N	\N	20	\N	\N
788	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-11-21 02:05:23.962	40	47	f	embedded-question	\N	\N	24	\N	\N
789	\\xbd3c80317764415cbb70c03f7e0e90dfc07a01e3e1333ce11ff44575c04a364e	2017-11-21 02:05:24.225	31	10	f	embedded-question	\N	\N	19	\N	\N
790	\\xf429d0082adac3811e2b09eae4f56e1fd5b00b94e25974cd3300caf8fbf69bc5	2017-11-21 02:08:24.504	33	7	f	embedded-question	\N	\N	18	\N	\N
791	\\xbd3c80317764415cbb70c03f7e0e90dfc07a01e3e1333ce11ff44575c04a364e	2017-11-21 02:08:25.587	36	10	f	embedded-question	\N	\N	19	\N	\N
792	\\x4378f8e359fd2cef7a7968e05f2c7b5aa6155e537a799688097eb1a1844b079c	2017-11-21 02:08:26.219	25	3	f	embedded-question	\N	\N	20	\N	\N
793	\\x6b5039481ad1749520b96d2176d5bfbc2b6eba08495cf8054faed42d28658a53	2017-11-21 02:08:26.362	37	3	f	embedded-question	\N	\N	21	\N	\N
794	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-11-21 02:08:26.378	45	47	f	embedded-question	\N	\N	24	\N	\N
795	\\x619ba579cc2cba9995d467f0c1b5eeceb63896b971c47ee34e6ed4b154eaefa3	2017-11-21 02:08:26.496	22	3	f	embedded-question	\N	\N	22	\N	\N
796	\\x3d4b7ca05f18b2de0927bd10138aba99a571e980b545ad1e4ba4e57151a9d8c7	2017-11-21 02:10:57.885	43	3	f	embedded-question	\N	\N	25	\N	\N
797	\\x439520b880e95500549b7ebcda358e9b5c6a2f3c005991646856e318da1a604a	2017-11-21 02:10:58.501	33	13	f	embedded-question	\N	\N	26	\N	\N
798	\\xf19ab079b9f266aa766b47ddf4b37c76acd4aff757e3e118d5ca627fa49566ee	2017-11-21 02:10:58.533	52	54	f	embedded-question	\N	\N	27	\N	\N
799	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-21 02:10:58.804	45	25	f	embedded-question	\N	\N	29	\N	\N
800	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-21 02:10:58.97	48	54	f	embedded-question	\N	\N	28	\N	\N
801	\\x3d4b7ca05f18b2de0927bd10138aba99a571e980b545ad1e4ba4e57151a9d8c7	2017-11-21 02:15:57.981	36	3	f	embedded-question	\N	\N	25	\N	\N
802	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-21 02:15:58.189	29	25	f	embedded-question	\N	\N	29	\N	\N
803	\\x439520b880e95500549b7ebcda358e9b5c6a2f3c005991646856e318da1a604a	2017-11-21 02:15:58.709	35	13	f	embedded-question	\N	\N	26	\N	\N
804	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-21 02:15:58.987	59	54	f	embedded-question	\N	\N	28	\N	\N
805	\\xf19ab079b9f266aa766b47ddf4b37c76acd4aff757e3e118d5ca627fa49566ee	2017-11-21 02:15:58.987	65	54	f	embedded-question	\N	\N	27	\N	\N
806	\\x439520b880e95500549b7ebcda358e9b5c6a2f3c005991646856e318da1a604a	2017-11-21 02:19:20.74	27	13	f	embedded-question	\N	\N	26	\N	\N
807	\\x3d4b7ca05f18b2de0927bd10138aba99a571e980b545ad1e4ba4e57151a9d8c7	2017-11-21 02:19:20.865	41	3	f	embedded-question	\N	\N	25	\N	\N
808	\\xf19ab079b9f266aa766b47ddf4b37c76acd4aff757e3e118d5ca627fa49566ee	2017-11-21 02:19:21.05	43	54	f	embedded-question	\N	\N	27	\N	\N
809	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-21 02:19:21.702	32	54	f	embedded-question	\N	\N	28	\N	\N
810	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-21 02:19:21.738	35	25	f	embedded-question	\N	\N	29	\N	\N
811	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-11-21 02:36:21.113	153	107	f	embedded-question	\N	\N	14	\N	\N
812	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-11-21 02:36:21.129	155	44	f	embedded-question	\N	\N	15	\N	\N
813	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-11-21 02:36:22.612	100	7	f	embedded-question	\N	\N	16	\N	\N
814	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-11-21 02:36:22.654	153	57	f	embedded-question	\N	\N	17	\N	\N
815	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-21 02:36:24.451	123	55	f	embedded-question	\N	\N	4	\N	\N
816	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-21 02:36:24.432	162	173	f	embedded-question	\N	\N	2	\N	\N
817	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-21 02:36:24.86	91	132	f	embedded-question	\N	\N	3	\N	\N
818	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-21 02:36:25.043	102	132	f	embedded-question	\N	\N	6	\N	\N
819	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-21 02:36:25.061	115	25	f	embedded-question	\N	\N	7	\N	\N
820	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-11-21 02:36:31.07	34	125	f	embedded-question	\N	\N	10	\N	\N
821	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-11-21 02:36:31.083	34	55	f	embedded-question	\N	\N	11	\N	\N
823	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-11-21 02:36:31.555	45	75	f	embedded-question	\N	\N	13	\N	\N
824	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-11-21 02:36:33.527	44	125	f	embedded-question	\N	\N	10	\N	\N
826	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-11-21 02:36:33.963	24	2	f	embedded-question	\N	\N	12	\N	\N
827	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-11-21 02:36:34.003	50	75	f	embedded-question	\N	\N	13	\N	\N
832	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-21 02:37:17.104	79	25	f	embedded-question	\N	\N	7	\N	\N
843	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-21 02:39:55.728	68	55	f	embedded-question	\N	\N	4	\N	\N
844	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-21 02:39:56.24	76	132	f	embedded-question	\N	\N	3	\N	\N
845	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-21 02:39:56.812	107	173	f	embedded-question	\N	\N	2	\N	\N
847	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-21 02:39:57.126	90	25	f	embedded-question	\N	\N	7	\N	\N
858	\\x6b5039481ad1749520b96d2176d5bfbc2b6eba08495cf8054faed42d28658a53	2017-11-21 02:41:42.787	39	3	f	embedded-question	\N	\N	21	\N	\N
861	\\x4378f8e359fd2cef7a7968e05f2c7b5aa6155e537a799688097eb1a1844b079c	2017-11-21 02:41:42.893	26	3	f	embedded-question	\N	\N	20	\N	\N
870	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-11-21 02:42:52.021	62	47	f	embedded-question	\N	\N	24	\N	\N
872	\\x6b5039481ad1749520b96d2176d5bfbc2b6eba08495cf8054faed42d28658a53	2017-11-21 02:42:52.121	29	3	f	embedded-question	\N	\N	21	\N	\N
876	\\xbd3c80317764415cbb70c03f7e0e90dfc07a01e3e1333ce11ff44575c04a364e	2017-11-21 02:43:09.226	26	10	f	embedded-question	\N	\N	19	\N	\N
881	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-11-21 02:44:26.706	24	47	f	embedded-question	\N	\N	24	\N	\N
882	\\x619ba579cc2cba9995d467f0c1b5eeceb63896b971c47ee34e6ed4b154eaefa3	2017-11-21 02:44:26.92	30	3	f	embedded-question	\N	\N	22	\N	\N
883	\\x4378f8e359fd2cef7a7968e05f2c7b5aa6155e537a799688097eb1a1844b079c	2017-11-21 02:44:27.109	21	3	f	embedded-question	\N	\N	20	\N	\N
884	\\x6b5039481ad1749520b96d2176d5bfbc2b6eba08495cf8054faed42d28658a53	2017-11-21 02:44:27.323	20	3	f	embedded-question	\N	\N	21	\N	\N
886	\\xf19ab079b9f266aa766b47ddf4b37c76acd4aff757e3e118d5ca627fa49566ee	2017-11-21 02:46:02.578	62	54	f	embedded-question	\N	\N	27	\N	\N
888	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-21 02:46:03.143	29	25	f	embedded-question	\N	\N	29	\N	\N
894	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-21 02:46:06.571	37	25	f	embedded-question	\N	\N	29	\N	\N
822	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-11-21 02:36:31.5	60	2	f	embedded-question	\N	\N	12	\N	\N
828	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-21 02:37:16.399	106	173	f	embedded-question	\N	\N	2	\N	\N
829	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-21 02:37:16.687	85	55	f	embedded-question	\N	\N	4	\N	\N
833	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-21 02:37:47.081	118	55	f	embedded-question	\N	\N	4	\N	\N
834	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-21 02:37:47.092	144	173	f	embedded-question	\N	\N	2	\N	\N
837	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-21 02:37:48.312	82	132	f	embedded-question	\N	\N	3	\N	\N
838	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-21 02:39:20.059	109	132	f	embedded-question	\N	\N	3	\N	\N
839	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-21 02:39:20.603	116	173	f	embedded-question	\N	\N	2	\N	\N
840	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-21 02:39:20.757	95	25	f	embedded-question	\N	\N	7	\N	\N
841	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-21 02:39:21.096	78	55	f	embedded-question	\N	\N	4	\N	\N
842	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-21 02:39:21.682	90	132	f	embedded-question	\N	\N	6	\N	\N
846	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-21 02:39:56.949	106	132	f	embedded-question	\N	\N	6	\N	\N
852	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-11-21 02:41:35.142	28	125	f	embedded-question	\N	\N	10	\N	\N
857	\\xbd3c80317764415cbb70c03f7e0e90dfc07a01e3e1333ce11ff44575c04a364e	2017-11-21 02:41:42.57	26	10	f	embedded-question	\N	\N	19	\N	\N
859	\\x619ba579cc2cba9995d467f0c1b5eeceb63896b971c47ee34e6ed4b154eaefa3	2017-11-21 02:41:42.811	43	3	f	embedded-question	\N	\N	22	\N	\N
860	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-11-21 02:41:42.817	45	47	f	embedded-question	\N	\N	24	\N	\N
862	\\x3d4b7ca05f18b2de0927bd10138aba99a571e980b545ad1e4ba4e57151a9d8c7	2017-11-21 02:41:49.62	38	3	f	embedded-question	\N	\N	25	\N	\N
863	\\x439520b880e95500549b7ebcda358e9b5c6a2f3c005991646856e318da1a604a	2017-11-21 02:41:50.041	43	13	f	embedded-question	\N	\N	26	\N	\N
867	\\xbd3c80317764415cbb70c03f7e0e90dfc07a01e3e1333ce11ff44575c04a364e	2017-11-21 02:42:51.493	31	10	f	embedded-question	\N	\N	19	\N	\N
868	\\xf429d0082adac3811e2b09eae4f56e1fd5b00b94e25974cd3300caf8fbf69bc5	2017-11-21 02:42:51.794	24	7	f	embedded-question	\N	\N	18	\N	\N
877	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-11-21 02:43:09.986	26	47	f	embedded-question	\N	\N	24	\N	\N
885	\\x439520b880e95500549b7ebcda358e9b5c6a2f3c005991646856e318da1a604a	2017-11-21 02:46:02.094	28	13	f	embedded-question	\N	\N	26	\N	\N
887	\\x3d4b7ca05f18b2de0927bd10138aba99a571e980b545ad1e4ba4e57151a9d8c7	2017-11-21 02:46:03.079	36	3	f	embedded-question	\N	\N	25	\N	\N
889	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-21 02:46:03.265	45	54	f	embedded-question	\N	\N	28	\N	\N
901	\\x439520b880e95500549b7ebcda358e9b5c6a2f3c005991646856e318da1a604a	2017-11-21 02:49:35.553	64	13	f	embedded-question	\N	\N	26	\N	\N
903	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-21 02:49:36.38	62	25	f	embedded-question	\N	\N	29	\N	\N
904	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-21 02:49:36.397	70	54	f	embedded-question	\N	\N	28	\N	\N
913	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-21 02:50:04.98	98	55	f	embedded-question	\N	\N	4	\N	\N
948	\\x439520b880e95500549b7ebcda358e9b5c6a2f3c005991646856e318da1a604a	2017-11-21 02:51:17.793	30	13	f	embedded-question	\N	\N	26	\N	\N
825	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-11-21 02:36:33.544	44	55	f	embedded-question	\N	\N	11	\N	\N
830	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-21 02:37:16.971	93	132	f	embedded-question	\N	\N	6	\N	\N
831	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-21 02:37:16.948	143	132	f	embedded-question	\N	\N	3	\N	\N
835	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-21 02:37:47.581	95	25	f	embedded-question	\N	\N	7	\N	\N
836	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-21 02:37:47.986	99	132	f	embedded-question	\N	\N	6	\N	\N
864	\\xf19ab079b9f266aa766b47ddf4b37c76acd4aff757e3e118d5ca627fa49566ee	2017-11-21 02:41:50.071	70	54	f	embedded-question	\N	\N	27	\N	\N
866	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-21 02:41:50.463	35	54	f	embedded-question	\N	\N	28	\N	\N
906	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-11-21 02:49:46.014	79	7	f	embedded-question	\N	\N	16	\N	\N
908	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-11-21 02:49:46.212	114	57	f	embedded-question	\N	\N	17	\N	\N
909	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-11-21 02:49:50.768	98	44	f	embedded-question	\N	\N	15	\N	\N
910	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-11-21 02:49:50.766	135	107	f	embedded-question	\N	\N	14	\N	\N
911	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-11-21 02:49:51.1	77	7	f	embedded-question	\N	\N	16	\N	\N
912	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-11-21 02:49:51.294	103	57	f	embedded-question	\N	\N	17	\N	\N
914	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-21 02:50:04.99	95	25	f	embedded-question	\N	\N	7	\N	\N
918	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-21 02:50:09.725	113	55	f	embedded-question	\N	\N	4	\N	\N
919	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-21 02:50:10.268	131	173	f	embedded-question	\N	\N	2	\N	\N
921	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-21 02:50:11.115	92	25	f	embedded-question	\N	\N	7	\N	\N
923	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-11-21 02:50:41.713	21	55	f	embedded-question	\N	\N	11	\N	\N
925	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-11-21 02:50:42.226	37	125	f	embedded-question	\N	\N	10	\N	\N
927	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-11-21 02:50:49.988	27	2	f	embedded-question	\N	\N	12	\N	\N
928	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-11-21 02:50:49.997	61	55	f	embedded-question	\N	\N	11	\N	\N
930	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-11-21 02:50:50.633	25	75	f	embedded-question	\N	\N	13	\N	\N
931	\\x4378f8e359fd2cef7a7968e05f2c7b5aa6155e537a799688097eb1a1844b079c	2017-11-21 02:51:00.763	26	3	f	embedded-question	\N	\N	20	\N	\N
932	\\x6b5039481ad1749520b96d2176d5bfbc2b6eba08495cf8054faed42d28658a53	2017-11-21 02:51:01.728	25	3	f	embedded-question	\N	\N	21	\N	\N
933	\\xbd3c80317764415cbb70c03f7e0e90dfc07a01e3e1333ce11ff44575c04a364e	2017-11-21 02:51:02.203	30	10	f	embedded-question	\N	\N	19	\N	\N
938	\\xf429d0082adac3811e2b09eae4f56e1fd5b00b94e25974cd3300caf8fbf69bc5	2017-11-21 02:51:04.519	34	7	f	embedded-question	\N	\N	18	\N	\N
939	\\x619ba579cc2cba9995d467f0c1b5eeceb63896b971c47ee34e6ed4b154eaefa3	2017-11-21 02:51:04.724	24	3	f	embedded-question	\N	\N	22	\N	\N
941	\\x4378f8e359fd2cef7a7968e05f2c7b5aa6155e537a799688097eb1a1844b079c	2017-11-21 02:51:05.453	21	3	f	embedded-question	\N	\N	20	\N	\N
944	\\xf19ab079b9f266aa766b47ddf4b37c76acd4aff757e3e118d5ca627fa49566ee	2017-11-21 02:51:14.091	37	54	f	embedded-question	\N	\N	27	\N	\N
945	\\x3d4b7ca05f18b2de0927bd10138aba99a571e980b545ad1e4ba4e57151a9d8c7	2017-11-21 02:51:14.583	27	3	f	embedded-question	\N	\N	25	\N	\N
946	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-21 02:51:14.647	40	25	f	embedded-question	\N	\N	29	\N	\N
947	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-21 02:51:14.775	45	54	f	embedded-question	\N	\N	28	\N	\N
956	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-11-21 02:51:26.78	100	57	f	embedded-question	\N	\N	17	\N	\N
957	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-11-21 02:51:30.975	112	107	f	embedded-question	\N	\N	14	\N	\N
960	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-11-21 02:51:32.071	105	57	f	embedded-question	\N	\N	17	\N	\N
848	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-11-21 02:39:58.986	76	44	f	embedded-question	\N	\N	15	\N	\N
849	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-11-21 02:39:59.098	103	7	f	embedded-question	\N	\N	16	\N	\N
850	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-11-21 02:39:59.12	134	107	f	embedded-question	\N	\N	14	\N	\N
851	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-11-21 02:39:59.162	136	57	f	embedded-question	\N	\N	17	\N	\N
853	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-11-21 02:41:35.251	35	55	f	embedded-question	\N	\N	11	\N	\N
854	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-11-21 02:41:35.583	19	2	f	embedded-question	\N	\N	12	\N	\N
855	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-11-21 02:41:35.714	27	75	f	embedded-question	\N	\N	13	\N	\N
856	\\xf429d0082adac3811e2b09eae4f56e1fd5b00b94e25974cd3300caf8fbf69bc5	2017-11-21 02:41:42.226	26	7	f	embedded-question	\N	\N	18	\N	\N
865	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-21 02:41:50.102	60	25	f	embedded-question	\N	\N	29	\N	\N
869	\\x4378f8e359fd2cef7a7968e05f2c7b5aa6155e537a799688097eb1a1844b079c	2017-11-21 02:42:51.934	28	3	f	embedded-question	\N	\N	20	\N	\N
871	\\x619ba579cc2cba9995d467f0c1b5eeceb63896b971c47ee34e6ed4b154eaefa3	2017-11-21 02:42:52.03	39	3	f	embedded-question	\N	\N	22	\N	\N
873	\\x6b5039481ad1749520b96d2176d5bfbc2b6eba08495cf8054faed42d28658a53	2017-11-21 02:43:06.781	33	3	f	embedded-question	\N	\N	21	\N	\N
874	\\x4378f8e359fd2cef7a7968e05f2c7b5aa6155e537a799688097eb1a1844b079c	2017-11-21 02:43:08.179	35	3	f	embedded-question	\N	\N	20	\N	\N
875	\\xf429d0082adac3811e2b09eae4f56e1fd5b00b94e25974cd3300caf8fbf69bc5	2017-11-21 02:43:08.2	39	7	f	embedded-question	\N	\N	18	\N	\N
878	\\x619ba579cc2cba9995d467f0c1b5eeceb63896b971c47ee34e6ed4b154eaefa3	2017-11-21 02:43:10.747	22	3	f	embedded-question	\N	\N	22	\N	\N
879	\\xbd3c80317764415cbb70c03f7e0e90dfc07a01e3e1333ce11ff44575c04a364e	2017-11-21 02:44:26.329	38	10	f	embedded-question	\N	\N	19	\N	\N
880	\\xf429d0082adac3811e2b09eae4f56e1fd5b00b94e25974cd3300caf8fbf69bc5	2017-11-21 02:44:26.357	35	7	f	embedded-question	\N	\N	18	\N	\N
890	\\x3d4b7ca05f18b2de0927bd10138aba99a571e980b545ad1e4ba4e57151a9d8c7	2017-11-21 02:46:05.66	57	3	f	embedded-question	\N	\N	25	\N	\N
891	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-21 02:46:05.825	51	54	f	embedded-question	\N	\N	28	\N	\N
892	\\x439520b880e95500549b7ebcda358e9b5c6a2f3c005991646856e318da1a604a	2017-11-21 02:46:06.109	39	13	f	embedded-question	\N	\N	26	\N	\N
893	\\xf19ab079b9f266aa766b47ddf4b37c76acd4aff757e3e118d5ca627fa49566ee	2017-11-21 02:46:06.357	60	54	f	embedded-question	\N	\N	27	\N	\N
895	\\x3d4b7ca05f18b2de0927bd10138aba99a571e980b545ad1e4ba4e57151a9d8c7	2017-11-21 02:46:18.027	42	3	f	embedded-question	\N	\N	25	\N	\N
896	\\x439520b880e95500549b7ebcda358e9b5c6a2f3c005991646856e318da1a604a	2017-11-21 02:46:18.041	45	13	f	embedded-question	\N	\N	26	\N	\N
897	\\xf19ab079b9f266aa766b47ddf4b37c76acd4aff757e3e118d5ca627fa49566ee	2017-11-21 02:46:18.276	40	54	f	embedded-question	\N	\N	27	\N	\N
898	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-21 02:46:18.579	51	54	f	embedded-question	\N	\N	28	\N	\N
899	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-21 02:46:18.598	45	25	f	embedded-question	\N	\N	29	\N	\N
900	\\xf19ab079b9f266aa766b47ddf4b37c76acd4aff757e3e118d5ca627fa49566ee	2017-11-21 02:49:35.292	64	54	f	embedded-question	\N	\N	27	\N	\N
902	\\x3d4b7ca05f18b2de0927bd10138aba99a571e980b545ad1e4ba4e57151a9d8c7	2017-11-21 02:49:36.026	34	3	f	embedded-question	\N	\N	25	\N	\N
905	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-11-21 02:49:45.448	97	107	f	embedded-question	\N	\N	14	\N	\N
907	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-11-21 02:49:46.033	86	44	f	embedded-question	\N	\N	15	\N	\N
915	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-21 02:50:05.583	167	173	f	embedded-question	\N	\N	2	\N	\N
916	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-21 02:50:05.614	142	132	f	embedded-question	\N	\N	3	\N	\N
917	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-21 02:50:05.902	88	132	f	embedded-question	\N	\N	6	\N	\N
920	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-21 02:50:10.779	109	132	f	embedded-question	\N	\N	3	\N	\N
922	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-21 02:50:11.466	129	132	f	embedded-question	\N	\N	6	\N	\N
924	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-11-21 02:50:42.212	31	75	f	embedded-question	\N	\N	13	\N	\N
926	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-11-21 02:50:42.363	18	2	f	embedded-question	\N	\N	12	\N	\N
929	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-11-21 02:50:50.027	53	125	f	embedded-question	\N	\N	10	\N	\N
934	\\x619ba579cc2cba9995d467f0c1b5eeceb63896b971c47ee34e6ed4b154eaefa3	2017-11-21 02:51:02.28	39	3	f	embedded-question	\N	\N	22	\N	\N
935	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-11-21 02:51:02.295	75	47	f	embedded-question	\N	\N	24	\N	\N
936	\\xf429d0082adac3811e2b09eae4f56e1fd5b00b94e25974cd3300caf8fbf69bc5	2017-11-21 02:51:02.399	36	7	f	embedded-question	\N	\N	18	\N	\N
940	\\x6b5039481ad1749520b96d2176d5bfbc2b6eba08495cf8054faed42d28658a53	2017-11-21 02:51:04.834	23	3	f	embedded-question	\N	\N	21	\N	\N
942	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-11-21 02:51:05.482	27	47	f	embedded-question	\N	\N	24	\N	\N
943	\\x439520b880e95500549b7ebcda358e9b5c6a2f3c005991646856e318da1a604a	2017-11-21 02:51:13.611	28	13	f	embedded-question	\N	\N	26	\N	\N
953	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-11-21 02:51:26.09	98	44	f	embedded-question	\N	\N	15	\N	\N
954	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-11-21 02:51:26.58	59	7	f	embedded-question	\N	\N	16	\N	\N
955	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-11-21 02:51:26.611	123	107	f	embedded-question	\N	\N	14	\N	\N
937	\\xbd3c80317764415cbb70c03f7e0e90dfc07a01e3e1333ce11ff44575c04a364e	2017-11-21 02:51:04.399	22	10	f	embedded-question	\N	\N	19	\N	\N
949	\\x3d4b7ca05f18b2de0927bd10138aba99a571e980b545ad1e4ba4e57151a9d8c7	2017-11-21 02:51:18.058	35	3	f	embedded-question	\N	\N	25	\N	\N
950	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-21 02:51:18.065	51	54	f	embedded-question	\N	\N	28	\N	\N
951	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-21 02:51:18.324	34	25	f	embedded-question	\N	\N	29	\N	\N
952	\\xf19ab079b9f266aa766b47ddf4b37c76acd4aff757e3e118d5ca627fa49566ee	2017-11-21 02:51:18.541	41	54	f	embedded-question	\N	\N	27	\N	\N
958	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-11-21 02:51:31.569	85	44	f	embedded-question	\N	\N	15	\N	\N
959	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-11-21 02:51:31.824	69	7	f	embedded-question	\N	\N	16	\N	\N
961	\\x4cf43208abb0f3ca767b1cc53b293df5d4af5019eaee0dc8b42c854871b2926d	2017-11-21 03:36:10.457	48	2000	f	ad-hoc	\N	1	\N	\N	\N
962	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-11-21 03:36:19.156	63	1	f	ad-hoc	\N	1	\N	\N	\N
963	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-11-21 03:36:32.083	222	2	f	ad-hoc	\N	1	\N	\N	\N
964	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-11-21 03:37:30.888	423	92	f	ad-hoc	\N	1	\N	\N	\N
965	\\x12f7e73cd2296f266a4e4e2b809490588e85e1dcce9e40d66b830a1b90453530	2017-11-21 03:39:40.997	315	2	f	ad-hoc	\N	1	\N	\N	\N
966	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-11-21 03:40:43.118	427	92	f	ad-hoc	\N	1	\N	\N	\N
967	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-11-21 03:41:03.96	344	55	f	ad-hoc	\N	1	\N	\N	\N
968	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-11-21 03:42:15.655	421	92	f	ad-hoc	\N	1	\N	\N	\N
969	\\x40e11f555ac44ba39d996c77cadb1581fa3a07d058f57bc9b2b57fec9c964f8f	2017-11-21 03:43:13.844	703	187	f	ad-hoc	\N	1	\N	\N	\N
970	\\x89cafcce7cfcb2a59fb6d92c927424b393176508506ba184e532d93903a04cfc	2017-11-21 03:43:44.529	691	100	f	ad-hoc	\N	1	\N	\N	\N
971	\\xa0b6ed88d7a11c2ffc8d31672ff10e18c3bbcb88bc64bf0f63f185931b1b8667	2017-11-21 03:43:57.245	672	100	f	ad-hoc	\N	1	\N	\N	\N
972	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-11-21 03:44:05.365	664	100	f	ad-hoc	\N	1	\N	\N	\N
973	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-11-21 03:46:14.15	301	55	f	question	\N	1	31	\N	\N
974	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-11-21 03:46:34.331	220	2	f	question	\N	1	30	\N	\N
975	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-11-21 03:46:46.924	635	100	f	question	\N	1	33	\N	\N
976	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-11-21 03:46:58.929	379	92	f	question	\N	1	32	\N	\N
977	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-11-21 03:51:20.027	209	55	f	question	\N	1	31	\N	\N
978	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-11-21 03:51:33.609	275	141	f	question	\N	1	32	\N	\N
979	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-11-25 18:57:40.06	2604	2	f	embedded-question	\N	\N	30	\N	\N
980	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-11-25 18:57:40.988	1817	100	f	embedded-question	\N	\N	33	\N	\N
981	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-11-25 18:57:39.312	3593	32	f	embedded-question	\N	\N	31	\N	\N
982	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-11-25 18:57:40.603	2381	32	f	embedded-question	\N	\N	32	\N	\N
983	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-11-25 19:01:01.736	1026	2	f	embedded-question	\N	\N	30	\N	\N
984	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-11-25 19:01:01.112	1790	123	f	embedded-question	\N	\N	32	\N	\N
989	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-11-25 19:04:56.252	201	1	f	question	\N	1	34	\N	\N
985	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-11-25 19:01:02.984	1247	55	f	embedded-question	\N	\N	31	\N	\N
986	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-11-25 19:01:02.416	2237	100	f	embedded-question	\N	\N	33	\N	\N
987	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-11-25 19:04:03.989	186	1	f	ad-hoc	\N	1	\N	\N	\N
988	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-11-25 19:04:48.696	117	1	f	question	\N	1	34	\N	\N
990	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-11-25 19:05:13.41	136	1	f	question	\N	1	34	\N	\N
991	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-11-25 19:05:20.056	125	1	f	embedded-question	\N	\N	34	\N	\N
992	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-11-25 19:05:20.316	519	2	f	embedded-question	\N	\N	30	\N	\N
993	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-11-25 19:05:20.557	989	141	f	embedded-question	\N	\N	32	\N	\N
994	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-11-25 19:05:20.875	955	55	f	embedded-question	\N	\N	31	\N	\N
995	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-11-25 19:05:21.253	1426	100	f	embedded-question	\N	\N	33	\N	\N
996	\\xe2670f46217a0dfc8dcab2ed6364b07504ff883c5f1e8e47c7ef760a5f69f8ac	2017-11-25 19:05:44.1	526	1	f	ad-hoc	\N	1	\N	\N	\N
997	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-11-25 19:06:38.31	526	1	f	question	\N	1	35	\N	\N
998	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-11-25 19:07:00.302	232	1	f	embedded-question	\N	\N	34	\N	\N
999	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-11-25 19:07:00.483	1181	2	f	embedded-question	\N	\N	30	\N	\N
1000	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-11-25 19:07:00.336	1824	1	f	embedded-question	\N	\N	35	\N	\N
1001	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-11-25 19:07:00.38	1910	55	f	embedded-question	\N	\N	31	\N	\N
1002	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-11-25 19:07:00.446	2113	141	f	embedded-question	\N	\N	32	\N	\N
1003	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-11-25 19:07:00.627	2221	100	f	embedded-question	\N	\N	33	\N	\N
1004	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-11-25 19:08:45.531	134	1	f	embedded-question	\N	\N	34	\N	\N
1005	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-11-25 19:08:46.043	1574	141	f	embedded-question	\N	\N	32	\N	\N
1006	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-11-25 19:08:46.333	1450	55	f	embedded-question	\N	\N	31	\N	\N
1007	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-11-25 19:08:46.675	1589	1	f	embedded-question	\N	\N	35	\N	\N
1008	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-11-25 19:08:47.634	860	2	f	embedded-question	\N	\N	30	\N	\N
1009	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-11-25 19:08:47.102	1836	100	f	embedded-question	\N	\N	33	\N	\N
1010	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-11-25 19:09:00.947	617	1	f	embedded-question	\N	\N	35	\N	\N
1011	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-11-25 19:09:01.241	715	2	f	embedded-question	\N	\N	30	\N	\N
1012	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-11-25 19:09:01.635	874	55	f	embedded-question	\N	\N	31	\N	\N
1013	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-11-25 19:09:02.049	1200	141	f	embedded-question	\N	\N	32	\N	\N
1014	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-11-25 19:09:03.579	183	1	f	embedded-question	\N	\N	34	\N	\N
1015	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-11-25 19:09:02.6	1861	100	f	embedded-question	\N	\N	33	\N	\N
1016	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-11-25 19:09:20.037	157	1	f	embedded-question	\N	\N	34	\N	\N
1017	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-11-25 19:09:19.706	523	2	f	embedded-question	\N	\N	30	\N	\N
1018	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-11-25 19:09:20.387	591	1	f	embedded-question	\N	\N	35	\N	\N
1019	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-11-25 19:09:21.394	671	55	f	embedded-question	\N	\N	31	\N	\N
1020	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-11-25 19:09:21.058	1172	141	f	embedded-question	\N	\N	32	\N	\N
1021	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-11-25 19:09:20.786	1694	100	f	embedded-question	\N	\N	33	\N	\N
1022	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-11-25 19:11:33.824	141	1	f	embedded-question	\N	\N	34	\N	\N
1023	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-11-25 19:11:34.196	834	1	f	embedded-question	\N	\N	35	\N	\N
1024	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-11-25 19:11:34.496	939	2	f	embedded-question	\N	\N	30	\N	\N
1025	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-11-25 19:11:34.85	958	55	f	embedded-question	\N	\N	31	\N	\N
1026	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-11-25 19:11:35.672	694	141	f	embedded-question	\N	\N	32	\N	\N
1027	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-11-25 19:11:35.277	1410	100	f	embedded-question	\N	\N	33	\N	\N
1028	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-11-25 19:12:13.963	584	1	f	embedded-question	\N	\N	35	\N	\N
1029	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-11-25 19:12:14.271	599	2	f	embedded-question	\N	\N	30	\N	\N
1030	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-11-25 19:12:14.607	766	55	f	embedded-question	\N	\N	31	\N	\N
1031	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-11-25 19:12:15.039	1155	141	f	embedded-question	\N	\N	32	\N	\N
1032	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-11-25 19:12:16.129	152	1	f	embedded-question	\N	\N	34	\N	\N
1033	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-11-25 19:12:15.769	1340	100	f	embedded-question	\N	\N	33	\N	\N
1034	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-11-25 19:12:21.135	144	1	f	embedded-question	\N	\N	34	\N	\N
1035	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-11-25 19:12:21.168	691	1	f	embedded-question	\N	\N	35	\N	\N
1036	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-11-25 19:12:21.481	693	2	f	embedded-question	\N	\N	30	\N	\N
1037	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-11-25 19:12:22.341	1090	55	f	embedded-question	\N	\N	31	\N	\N
1038	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-11-25 19:12:22.645	1202	141	f	embedded-question	\N	\N	32	\N	\N
1039	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-11-25 19:12:22.435	1886	100	f	embedded-question	\N	\N	33	\N	\N
1040	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-11-25 19:12:45.563	105	1	f	embedded-question	\N	\N	34	\N	\N
1041	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-11-25 19:12:45.783	918	2	f	embedded-question	\N	\N	30	\N	\N
1042	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-11-25 19:12:45.752	1172	1	f	embedded-question	\N	\N	35	\N	\N
1043	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-11-25 19:12:45.805	1261	55	f	embedded-question	\N	\N	31	\N	\N
1044	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-11-25 19:12:46.223	1944	100	f	embedded-question	\N	\N	33	\N	\N
1045	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-11-25 19:12:47.504	884	141	f	embedded-question	\N	\N	32	\N	\N
1046	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-11-26 17:54:38.494	3298	41	f	embedded-question	\N	\N	14	\N	\N
1047	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-11-26 17:54:45.088	507	7	f	embedded-question	\N	\N	16	\N	\N
1048	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-11-26 17:54:45.066	628	41	f	embedded-question	\N	\N	15	\N	\N
1049	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-11-26 17:54:53.46	315	38	f	embedded-question	\N	\N	17	\N	\N
1050	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-11-26 17:57:33.877	322	1	f	ad-hoc	\N	1	\N	\N	\N
1051	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-11-26 17:58:02.455	183	1	f	embedded-question	\N	\N	34	\N	\N
1052	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-11-26 17:58:02.396	619	1	f	embedded-question	\N	\N	35	\N	\N
1053	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-11-26 17:58:03.999	594	55	f	embedded-question	\N	\N	31	\N	\N
1054	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-11-26 17:58:06.064	562	2	f	embedded-question	\N	\N	30	\N	\N
1091	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-11-26 18:11:51.145	43	1	f	ad-hoc	\N	1	\N	\N	\N
1098	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-11-26 18:13:26.945	158	44	f	embedded-question	\N	\N	15	\N	\N
1099	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-11-26 18:13:27.235	114	7	f	embedded-question	\N	\N	16	\N	\N
1101	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-11-26 18:14:03.526	112	1	f	embedded-question	\N	\N	37	\N	\N
1102	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-11-26 18:14:03.781	156	107	f	embedded-question	\N	\N	14	\N	\N
1103	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-11-26 18:14:04.196	110	7	f	embedded-question	\N	\N	16	\N	\N
1107	\\x3d4b7ca05f18b2de0927bd10138aba99a571e980b545ad1e4ba4e57151a9d8c7	2017-11-26 18:14:06.659	77	3	f	embedded-question	\N	\N	25	\N	\N
1108	\\x439520b880e95500549b7ebcda358e9b5c6a2f3c005991646856e318da1a604a	2017-11-26 18:14:07.041	66	13	f	embedded-question	\N	\N	26	\N	\N
1109	\\xf19ab079b9f266aa766b47ddf4b37c76acd4aff757e3e118d5ca627fa49566ee	2017-11-26 18:14:07.54	122	54	f	embedded-question	\N	\N	27	\N	\N
1110	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-26 18:14:08.265	75	54	f	embedded-question	\N	\N	28	\N	\N
1111	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-26 18:14:08.584	60	25	f	embedded-question	\N	\N	29	\N	\N
1115	\\xbd3c80317764415cbb70c03f7e0e90dfc07a01e3e1333ce11ff44575c04a364e	2017-11-26 18:15:25.371	190	0	f	embedded-question	\N	\N	19	\N	\N
1055	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-11-26 17:58:06.03	930	55	f	embedded-question	\N	\N	32	\N	\N
1056	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-11-26 17:58:06.949	1220	100	f	embedded-question	\N	\N	33	\N	\N
1057	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-11-26 18:04:31.481	188	1	f	embedded-question	\N	\N	34	\N	\N
1058	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-11-26 18:04:31.451	717	2	f	embedded-question	\N	\N	30	\N	\N
1059	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-11-26 18:04:33.348	953	1	f	embedded-question	\N	\N	35	\N	\N
1060	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-11-26 18:04:33.302	1016	55	f	embedded-question	\N	\N	31	\N	\N
1061	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-11-26 18:04:35.547	794	141	f	embedded-question	\N	\N	32	\N	\N
1062	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-11-26 18:04:35.516	1319	100	f	embedded-question	\N	\N	33	\N	\N
1063	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-11-26 18:05:16.313	261	1	f	embedded-question	\N	\N	34	\N	\N
1064	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-11-26 18:05:16.285	943	1	f	embedded-question	\N	\N	35	\N	\N
1065	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-11-26 18:05:17.947	549	2	f	embedded-question	\N	\N	30	\N	\N
1066	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-11-26 18:05:19.033	1223	55	f	embedded-question	\N	\N	31	\N	\N
1067	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-11-26 18:05:19.632	1387	141	f	embedded-question	\N	\N	32	\N	\N
1068	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-11-26 18:05:21.193	1137	100	f	embedded-question	\N	\N	33	\N	\N
1069	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-11-26 18:06:21.696	191	1	f	embedded-question	\N	\N	34	\N	\N
1070	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-11-26 18:06:21.66	831	1	f	embedded-question	\N	\N	35	\N	\N
1071	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-11-26 18:06:23.706	583	2	f	embedded-question	\N	\N	30	\N	\N
1072	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-11-26 18:06:27.802	142	7	f	embedded-question	\N	\N	16	\N	\N
1073	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-11-26 18:06:27.831	244	107	f	embedded-question	\N	\N	14	\N	\N
1074	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-11-26 18:06:28.987	171	57	f	embedded-question	\N	\N	17	\N	\N
1075	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-11-26 18:06:30.019	124	44	f	embedded-question	\N	\N	15	\N	\N
1076	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-11-26 18:06:51.117	273	7	f	embedded-question	\N	\N	16	\N	\N
1077	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-11-26 18:06:51.107	348	107	f	embedded-question	\N	\N	14	\N	\N
1078	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-11-26 18:06:51.156	378	44	f	embedded-question	\N	\N	15	\N	\N
1079	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-11-26 18:06:51.17	373	57	f	embedded-question	\N	\N	17	\N	\N
1080	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-11-26 18:06:56.831	168	107	f	embedded-question	\N	\N	14	\N	\N
1081	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-11-26 18:06:57.097	145	44	f	embedded-question	\N	\N	15	\N	\N
1082	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-11-26 18:06:57.599	123	7	f	embedded-question	\N	\N	16	\N	\N
1083	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-11-26 18:06:57.851	125	57	f	embedded-question	\N	\N	17	\N	\N
1084	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-11-26 18:09:24.028	239	107	f	embedded-question	\N	\N	14	\N	\N
1085	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-11-26 18:09:24.384	167	44	f	embedded-question	\N	\N	15	\N	\N
1086	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-11-26 18:09:24.916	119	7	f	embedded-question	\N	\N	16	\N	\N
1087	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-11-26 18:09:25.207	129	57	f	embedded-question	\N	\N	17	\N	\N
1088	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-11-26 18:11:21.225	59	1	f	question	\N	1	36	\N	\N
1089	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-11-26 18:11:28.038	47	1	f	question	\N	1	36	\N	\N
1090	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-11-26 18:11:36.556	49	1	f	question	\N	1	36	\N	\N
1092	\\x1b2c5b875d8182fec9db84e655c89d8a3048a62bc21e7fcdc9fac6c4fb5cf048	2017-11-26 18:11:58.439	125	1	f	ad-hoc	\N	1	\N	\N	\N
1093	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-11-26 18:12:43.124	187	1	f	question	\N	1	37	\N	\N
1094	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-11-26 18:13:25.077	41	1	f	embedded-question	\N	\N	36	\N	\N
1095	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-11-26 18:13:25.57	136	1	f	embedded-question	\N	\N	37	\N	\N
1096	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-11-26 18:13:26.023	192	107	f	embedded-question	\N	\N	14	\N	\N
1097	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-11-26 18:13:26.365	223	57	f	embedded-question	\N	\N	17	\N	\N
1100	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-11-26 18:14:03.157	49	1	f	embedded-question	\N	\N	36	\N	\N
1104	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-11-26 18:14:04.567	155	44	f	embedded-question	\N	\N	15	\N	\N
1105	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-11-26 18:14:05.81	36	1	f	embedded-question	\N	\N	36	\N	\N
1106	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-11-26 18:14:06.129	167	1	f	embedded-question	\N	\N	37	\N	\N
1112	\\xf429d0082adac3811e2b09eae4f56e1fd5b00b94e25974cd3300caf8fbf69bc5	2017-11-26 18:15:25.324	146	0	f	embedded-question	\N	\N	18	\N	\N
1113	\\x4378f8e359fd2cef7a7968e05f2c7b5aa6155e537a799688097eb1a1844b079c	2017-11-26 18:15:25.343	152	0	f	embedded-question	\N	\N	20	\N	\N
1114	\\x6b5039481ad1749520b96d2176d5bfbc2b6eba08495cf8054faed42d28658a53	2017-11-26 18:15:25.396	163	0	f	embedded-question	\N	\N	21	\N	\N
1116	\\x619ba579cc2cba9995d467f0c1b5eeceb63896b971c47ee34e6ed4b154eaefa3	2017-11-26 18:15:25.508	212	0	f	embedded-question	\N	\N	22	\N	\N
1117	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-11-26 18:15:25.672	128	0	f	embedded-question	\N	\N	24	\N	\N
1118	\\x4fa64b3921a5345e56cafded326679d694ff759dc9c14a9c99a091b6ef7b026a	2017-11-26 18:15:25.724	83	0	f	embedded-question	\N	\N	23	\N	\N
1119	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-11-26 18:19:31.644	55	1	f	embedded-question	\N	\N	36	\N	\N
1120	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-11-26 18:19:32.401	146	1	f	embedded-question	\N	\N	37	\N	\N
1121	\\x4378f8e359fd2cef7a7968e05f2c7b5aa6155e537a799688097eb1a1844b079c	2017-11-26 18:19:32.712	39	0	f	embedded-question	\N	\N	20	\N	\N
1122	\\xf429d0082adac3811e2b09eae4f56e1fd5b00b94e25974cd3300caf8fbf69bc5	2017-11-26 18:19:33.01	85	0	f	embedded-question	\N	\N	18	\N	\N
1123	\\xbd3c80317764415cbb70c03f7e0e90dfc07a01e3e1333ce11ff44575c04a364e	2017-11-26 18:19:33.403	41	0	f	embedded-question	\N	\N	19	\N	\N
1124	\\x6b5039481ad1749520b96d2176d5bfbc2b6eba08495cf8054faed42d28658a53	2017-11-26 18:19:33.68	47	0	f	embedded-question	\N	\N	21	\N	\N
1125	\\x619ba579cc2cba9995d467f0c1b5eeceb63896b971c47ee34e6ed4b154eaefa3	2017-11-26 18:19:34.099	86	0	f	embedded-question	\N	\N	22	\N	\N
1126	\\x4fa64b3921a5345e56cafded326679d694ff759dc9c14a9c99a091b6ef7b026a	2017-11-26 18:19:34.472	37	0	f	embedded-question	\N	\N	23	\N	\N
1127	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-11-26 18:19:34.762	21	0	f	embedded-question	\N	\N	24	\N	\N
1128	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-11-26 18:22:10.671	66	1	f	embedded-question	\N	\N	36	\N	\N
1129	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-11-26 18:22:11.16	130	1	f	embedded-question	\N	\N	37	\N	\N
1130	\\xf429d0082adac3811e2b09eae4f56e1fd5b00b94e25974cd3300caf8fbf69bc5	2017-11-26 18:22:11.529	51	0	f	embedded-question	\N	\N	18	\N	\N
1131	\\xbd3c80317764415cbb70c03f7e0e90dfc07a01e3e1333ce11ff44575c04a364e	2017-11-26 18:22:12.124	50	0	f	embedded-question	\N	\N	19	\N	\N
1132	\\x4378f8e359fd2cef7a7968e05f2c7b5aa6155e537a799688097eb1a1844b079c	2017-11-26 18:22:12.52	54	0	f	embedded-question	\N	\N	20	\N	\N
1133	\\x619ba579cc2cba9995d467f0c1b5eeceb63896b971c47ee34e6ed4b154eaefa3	2017-11-26 18:22:12.843	38	0	f	embedded-question	\N	\N	22	\N	\N
1134	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-11-26 18:22:15.857	54	1	f	embedded-question	\N	\N	36	\N	\N
1135	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-11-26 18:22:16.703	178	1	f	embedded-question	\N	\N	37	\N	\N
1136	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-11-26 18:22:17.352	105	0	f	embedded-question	\N	\N	11	\N	\N
1137	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-11-26 18:22:18.723	30	0	f	embedded-question	\N	\N	10	\N	\N
1138	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-11-26 18:22:19.072	44	0	f	embedded-question	\N	\N	12	\N	\N
1140	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-11-26 18:23:26.647	52	1	f	embedded-question	\N	\N	36	\N	\N
1141	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-11-26 18:23:27.315	158	1	f	embedded-question	\N	\N	37	\N	\N
1142	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-11-26 18:23:27.817	45	0	f	embedded-question	\N	\N	10	\N	\N
1143	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-11-26 18:23:28.367	68	0	f	embedded-question	\N	\N	11	\N	\N
1145	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-11-26 18:23:30.741	136	1	f	embedded-question	\N	\N	37	\N	\N
1146	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-26 18:23:31.136	32	0	f	embedded-question	\N	\N	2	\N	\N
1147	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-26 18:23:31.506	35	0	f	embedded-question	\N	\N	4	\N	\N
1148	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-26 18:23:32.112	37	0	f	embedded-question	\N	\N	3	\N	\N
1149	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-26 18:23:32.451	63	0	f	embedded-question	\N	\N	6	\N	\N
1150	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-26 18:23:32.821	68	0	f	embedded-question	\N	\N	7	\N	\N
1153	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-26 18:25:20.347	143	0	f	embedded-question	\N	\N	4	\N	\N
1158	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-11-26 18:25:24.556	39	1	f	embedded-question	\N	\N	36	\N	\N
1161	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-11-26 18:25:26.542	139	44	f	embedded-question	\N	\N	15	\N	\N
1139	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-11-26 18:22:19.747	47	0	f	embedded-question	\N	\N	13	\N	\N
1144	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-11-26 18:23:30.35	47	1	f	embedded-question	\N	\N	36	\N	\N
1151	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-11-26 18:25:20.226	214	1	f	embedded-question	\N	\N	37	\N	\N
1152	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-26 18:25:20.343	145	0	f	embedded-question	\N	\N	2	\N	\N
1154	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-26 18:25:20.35	140	0	f	embedded-question	\N	\N	3	\N	\N
1155	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-26 18:25:20.395	124	0	f	embedded-question	\N	\N	6	\N	\N
1156	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-26 18:25:20.385	189	0	f	embedded-question	\N	\N	7	\N	\N
1157	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-11-26 18:25:20.597	63	1	f	embedded-question	\N	\N	36	\N	\N
1159	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-11-26 18:25:25.019	151	1	f	embedded-question	\N	\N	37	\N	\N
1160	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-11-26 18:25:25.738	243	107	f	embedded-question	\N	\N	14	\N	\N
1162	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-11-26 18:25:27.04	252	57	f	embedded-question	\N	\N	17	\N	\N
1163	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-11-26 18:25:27.917	105	7	f	embedded-question	\N	\N	16	\N	\N
1164	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-11-26 18:33:06.849	36	1	f	embedded-question	\N	\N	36	\N	\N
1165	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-11-26 18:33:07.127	108	1	f	embedded-question	\N	\N	37	\N	\N
1166	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-26 18:33:07.378	29	0	f	embedded-question	\N	\N	2	\N	\N
1167	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-26 18:33:07.619	36	0	f	embedded-question	\N	\N	4	\N	\N
1168	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-26 18:33:07.878	30	0	f	embedded-question	\N	\N	7	\N	\N
1169	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-26 18:33:08.09	28	0	f	embedded-question	\N	\N	3	\N	\N
1170	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-11-26 18:33:08.374	69	0	f	embedded-question	\N	\N	6	\N	\N
1171	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-11-26 18:33:33.511	42	1	f	embedded-question	\N	\N	36	\N	\N
1172	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-11-26 18:33:33.928	157	1	f	embedded-question	\N	\N	37	\N	\N
1173	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-11-26 18:33:34.314	43	0	f	embedded-question	\N	\N	4	\N	\N
1174	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-11-26 18:33:34.672	38	0	f	embedded-question	\N	\N	2	\N	\N
1175	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-11-26 18:33:34.941	40	0	f	embedded-question	\N	\N	3	\N	\N
1176	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-11-26 18:33:35.175	23	0	f	embedded-question	\N	\N	7	\N	\N
1177	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-11-26 18:33:36.298	112	1	f	embedded-question	\N	\N	34	\N	\N
1178	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-11-26 18:33:36.532	614	2	f	embedded-question	\N	\N	30	\N	\N
1182	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-11-26 18:33:42.046	23	1	f	embedded-question	\N	\N	36	\N	\N
1183	\\x439520b880e95500549b7ebcda358e9b5c6a2f3c005991646856e318da1a604a	2017-11-26 18:33:42.338	61	13	f	embedded-question	\N	\N	26	\N	\N
1184	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-11-26 18:33:42.602	104	1	f	embedded-question	\N	\N	37	\N	\N
1187	\\x3d4b7ca05f18b2de0927bd10138aba99a571e980b545ad1e4ba4e57151a9d8c7	2017-11-26 18:33:43.495	55	3	f	embedded-question	\N	\N	25	\N	\N
1188	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-26 18:33:43.728	48	25	f	embedded-question	\N	\N	29	\N	\N
1179	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-11-26 18:33:36.799	753	1	f	embedded-question	\N	\N	35	\N	\N
1180	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-11-26 18:33:38.543	26	1	f	embedded-question	\N	\N	36	\N	\N
1181	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-11-26 18:33:38.843	133	1	f	embedded-question	\N	\N	37	\N	\N
1185	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-26 18:33:42.891	63	54	f	embedded-question	\N	\N	28	\N	\N
1186	\\xf19ab079b9f266aa766b47ddf4b37c76acd4aff757e3e118d5ca627fa49566ee	2017-11-26 18:33:43.216	76	54	f	embedded-question	\N	\N	27	\N	\N
1189	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-11-26 19:03:50.62	273	1	f	question	\N	1	37	\N	\N
1190	\\x8f34e1a8509769dd9f759c926a8a7e9492491ac784b1e7218e221ae8707522b5	2017-11-26 19:33:49.226	36	0	f	ad-hoc	\N	1	\N	\N	\N
1191	\\x03ab7b55cad996e98ecdf6097c61c13ef3cb0189c01cc2e66b58a07fcff4fd2c	2017-11-26 19:33:59.551	35	0	f	ad-hoc	\N	1	\N	\N	\N
1192	\\x03ab7b55cad996e98ecdf6097c61c13ef3cb0189c01cc2e66b58a07fcff4fd2c	2017-11-26 19:34:08.544	26	0	f	ad-hoc	\N	1	\N	\N	\N
1193	\\x03ab7b55cad996e98ecdf6097c61c13ef3cb0189c01cc2e66b58a07fcff4fd2c	2017-11-26 19:34:09.662	26	0	f	ad-hoc	\N	1	\N	\N	\N
1194	\\xf8ab73da628afbbd148c05f79cda69acc8b423606ecfc38614e2285f065b31c5	2017-11-29 23:15:02.965	1684	2000	f	ad-hoc	\N	1	\N	\N	\N
1195	\\xf8ab73da628afbbd148c05f79cda69acc8b423606ecfc38614e2285f065b31c5	2017-11-29 23:17:50.056	226	2000	f	ad-hoc	\N	1	\N	\N	\N
1196	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-11-29 23:18:26.046	248	1	f	embedded-question	\N	1	36	\N	\N
1197	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-11-29 23:18:26.042	462	1	f	embedded-question	\N	1	37	\N	\N
1198	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-29 23:18:26.029	578	54	f	embedded-question	\N	1	28	\N	\N
1199	\\x439520b880e95500549b7ebcda358e9b5c6a2f3c005991646856e318da1a604a	2017-11-29 23:18:26.518	201	1	f	embedded-question	\N	1	26	\N	\N
1200	\\x3d4b7ca05f18b2de0927bd10138aba99a571e980b545ad1e4ba4e57151a9d8c7	2017-11-29 23:18:26.918	188	1	f	embedded-question	\N	1	25	\N	\N
1201	\\xf19ab079b9f266aa766b47ddf4b37c76acd4aff757e3e118d5ca627fa49566ee	2017-11-29 23:18:26.944	244	91	f	embedded-question	\N	1	27	\N	\N
1202	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-29 23:18:27.033	168	25	f	embedded-question	\N	1	29	\N	\N
1203	\\xf8ab73da628afbbd148c05f79cda69acc8b423606ecfc38614e2285f065b31c5	2017-11-29 23:19:13.204	142	2000	f	ad-hoc	\N	1	\N	\N	\N
1204	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-29 23:19:36.221	97	54	f	question	\N	1	28	\N	\N
1205	\\x3d4b7ca05f18b2de0927bd10138aba99a571e980b545ad1e4ba4e57151a9d8c7	2017-11-29 23:19:46.116	114	1	f	question	\N	1	25	\N	\N
1206	\\x3d4b7ca05f18b2de0927bd10138aba99a571e980b545ad1e4ba4e57151a9d8c7	2017-11-29 23:20:15.737	80	1	f	question	\N	1	25	\N	\N
1207	\\xc77bd3c48b5a9df9b990a32a667f05820a4338047b22d5ba99e70089ae71772d	2017-11-29 23:20:59.606	62	3	f	ad-hoc	\N	1	\N	\N	\N
1208	\\xc77bd3c48b5a9df9b990a32a667f05820a4338047b22d5ba99e70089ae71772d	2017-11-29 23:21:09.633	74	3	f	question	\N	1	25	\N	\N
1209	\\x439520b880e95500549b7ebcda358e9b5c6a2f3c005991646856e318da1a604a	2017-11-29 23:21:15.827	48	1	f	question	\N	1	26	\N	\N
1210	\\x12a53ccb1cb8a3080959a9ce2fd1092c70830f3c85f6bf6486852cca4ef89101	2017-11-29 23:21:23.579	73	7	f	ad-hoc	\N	1	\N	\N	\N
1211	\\x439520b880e95500549b7ebcda358e9b5c6a2f3c005991646856e318da1a604a	2017-11-29 23:21:38.38	72	1	f	question	\N	1	26	\N	\N
1212	\\x12a53ccb1cb8a3080959a9ce2fd1092c70830f3c85f6bf6486852cca4ef89101	2017-11-29 23:21:48.133	74	7	f	ad-hoc	\N	1	\N	\N	\N
1213	\\x08fb682e6462441c203ded87d8fd61c85b379b279309ba2c3baedbec1e3a432c	2017-11-29 23:22:11.842	74	7	f	ad-hoc	\N	1	\N	\N	\N
1214	\\xc77bd3c48b5a9df9b990a32a667f05820a4338047b22d5ba99e70089ae71772d	2017-11-29 23:22:33.772	83	3	f	question	\N	1	25	\N	\N
1215	\\xe70291818d87d3dce40668f3feb8dabcbdfd8288676c4aed01571e4040c0bbab	2017-11-29 23:22:43.851	80	3	f	ad-hoc	\N	1	\N	\N	\N
1216	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-29 23:23:08.197	76	54	f	question	\N	1	28	\N	\N
1217	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-29 23:23:14.195	120	25	f	question	\N	1	29	\N	\N
1218	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-29 23:23:18.486	52	25	f	question	\N	1	29	\N	\N
1219	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-29 23:23:28.177	55	25	f	ad-hoc	\N	1	\N	\N	\N
1220	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-29 23:23:47.241	62	25	f	question	\N	1	29	\N	\N
1221	\\xf19ab079b9f266aa766b47ddf4b37c76acd4aff757e3e118d5ca627fa49566ee	2017-11-29 23:23:51.527	89	91	f	question	\N	1	27	\N	\N
1222	\\xf19ab079b9f266aa766b47ddf4b37c76acd4aff757e3e118d5ca627fa49566ee	2017-11-29 23:24:09.412	85	91	f	ad-hoc	\N	1	\N	\N	\N
1223	\\x5b235df997ac3a28fad99220b37bf16e682e1a26d6b784e210e6f046345c28f6	2017-11-29 23:24:54.997	84	91	f	ad-hoc	\N	1	\N	\N	\N
1224	\\x079badf11ef5b863ed7cbae46f7622895acbc78068697f5140c33deb98f9cdc3	2017-11-29 23:25:26.909	94	91	f	ad-hoc	\N	1	\N	\N	\N
1225	\\x2d92775ca5136dd0fcfd1d1bcd3fb6a8ac2a509ee66e18f7dc4abfb5a4a954e1	2017-11-29 23:25:56.548	86	91	f	question	\N	1	27	\N	\N
1226	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-11-29 23:26:35.61	157	1	f	embedded-question	\N	1	37	\N	\N
1227	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-11-29 23:26:35.739	292	107	f	embedded-question	\N	1	14	\N	\N
1228	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-11-29 23:26:36.33	136	1	f	embedded-question	\N	1	36	\N	\N
1229	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-11-29 23:26:36.296	218	44	f	embedded-question	\N	1	15	\N	\N
1230	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-11-29 23:26:36.756	119	7	f	embedded-question	\N	1	16	\N	\N
1231	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-11-29 23:26:36.714	203	57	f	embedded-question	\N	1	17	\N	\N
1232	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-11-29 23:26:40.018	139	57	f	embedded-question	\N	1	17	\N	\N
1233	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-29 23:26:56.232	82	25	f	question	\N	1	29	\N	\N
1234	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-29 23:26:58.78	61	25	f	question	\N	1	29	\N	\N
1235	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-29 23:29:05.654	89	25	f	ad-hoc	\N	1	\N	\N	\N
1236	\\x2d92775ca5136dd0fcfd1d1bcd3fb6a8ac2a509ee66e18f7dc4abfb5a4a954e1	2017-11-29 23:29:10.42	80	91	f	question	\N	1	27	\N	\N
1237	\\x2d92775ca5136dd0fcfd1d1bcd3fb6a8ac2a509ee66e18f7dc4abfb5a4a954e1	2017-11-29 23:29:43.988	103	91	f	question	\N	1	27	\N	\N
1238	\\x2d92775ca5136dd0fcfd1d1bcd3fb6a8ac2a509ee66e18f7dc4abfb5a4a954e1	2017-11-29 23:29:47.4	69	91	f	question	\N	1	27	\N	\N
1239	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-29 23:29:49.512	87	25	f	question	\N	1	29	\N	\N
1240	\\x08fb682e6462441c203ded87d8fd61c85b379b279309ba2c3baedbec1e3a432c	2017-11-29 23:29:51.203	79	7	f	question	\N	1	26	\N	\N
1241	\\xe70291818d87d3dce40668f3feb8dabcbdfd8288676c4aed01571e4040c0bbab	2017-11-29 23:29:55.801	59	3	f	question	\N	1	25	\N	\N
1242	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-29 23:29:58.177	81	54	f	question	\N	1	28	\N	\N
1243	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-11-29 23:30:06.23	28	1	f	embedded-question	\N	1	36	\N	\N
1244	\\x2d92775ca5136dd0fcfd1d1bcd3fb6a8ac2a509ee66e18f7dc4abfb5a4a954e1	2017-11-29 23:30:06.991	124	91	f	embedded-question	\N	1	27	\N	\N
1245	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-29 23:30:07.017	182	25	f	embedded-question	\N	1	29	\N	\N
1246	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-29 23:30:07.03	235	54	f	embedded-question	\N	1	28	\N	\N
1247	\\x08fb682e6462441c203ded87d8fd61c85b379b279309ba2c3baedbec1e3a432c	2017-11-29 23:30:07.142	207	7	f	embedded-question	\N	1	26	\N	\N
1248	\\xe70291818d87d3dce40668f3feb8dabcbdfd8288676c4aed01571e4040c0bbab	2017-11-29 23:30:07.198	175	3	f	embedded-question	\N	1	25	\N	\N
1249	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-11-29 23:30:07.154	283	1	f	embedded-question	\N	1	37	\N	\N
1250	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-11-29 23:30:46.3	454	1	f	question	\N	1	35	\N	\N
1251	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-11-29 23:30:52.202	129	1	f	question	\N	1	34	\N	\N
1252	\\x2df1c1b99dab5d6c0df61c40a4bc206c6dfad0aa9bb3abebb778075cb7301608	2017-11-29 23:31:07.238	36	1	f	ad-hoc	\N	1	\N	\N	\N
1253	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-11-29 23:31:18.413	103	1	f	question	\N	1	34	\N	\N
1254	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-11-29 23:31:56.907	481	1	f	question	\N	1	35	\N	\N
1255	\\xcd5d9bbf219397f5d48c792905989514725c1481176446dd62b66b353892d5d5	2017-11-29 23:32:13.304	53	1	f	ad-hoc	\N	1	\N	\N	\N
1256	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-29 23:34:12.737	51	54	f	question	\N	1	28	\N	\N
1257	\\x2df1c1b99dab5d6c0df61c40a4bc206c6dfad0aa9bb3abebb778075cb7301608	2017-11-29 23:34:30.712	52	1	f	question	\N	1	38	\N	\N
1258	\\x2d92775ca5136dd0fcfd1d1bcd3fb6a8ac2a509ee66e18f7dc4abfb5a4a954e1	2017-11-29 23:35:19.909	59	91	f	embedded-question	\N	1	27	\N	\N
1259	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-29 23:35:20.049	157	25	f	embedded-question	\N	1	29	\N	\N
1260	\\x08fb682e6462441c203ded87d8fd61c85b379b279309ba2c3baedbec1e3a432c	2017-11-29 23:35:20.052	145	7	f	embedded-question	\N	1	26	\N	\N
1261	\\xe70291818d87d3dce40668f3feb8dabcbdfd8288676c4aed01571e4040c0bbab	2017-11-29 23:35:20.136	139	3	f	embedded-question	\N	1	25	\N	\N
1262	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-29 23:35:20.778	66	54	f	embedded-question	\N	1	28	\N	\N
1263	\\x2df1c1b99dab5d6c0df61c40a4bc206c6dfad0aa9bb3abebb778075cb7301608	2017-11-29 23:35:29.333	38	1	f	question	\N	1	38	\N	\N
1264	\\xb01ab430a97f00647f2ea6776c5224260a950c9bdd337897bfbf26a5ee89aa9b	2017-11-29 23:35:41.718	61	1	f	question	\N	1	39	\N	\N
1270	\\x2df1c1b99dab5d6c0df61c40a4bc206c6dfad0aa9bb3abebb778075cb7301608	2017-11-29 23:35:56.411	65	1	f	embedded-question	\N	1	38	\N	\N
1271	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-29 23:35:56.398	131	54	f	embedded-question	\N	1	28	\N	\N
1265	\\xe70291818d87d3dce40668f3feb8dabcbdfd8288676c4aed01571e4040c0bbab	2017-11-29 23:35:55.509	78	3	f	embedded-question	\N	1	25	\N	\N
1266	\\x2d92775ca5136dd0fcfd1d1bcd3fb6a8ac2a509ee66e18f7dc4abfb5a4a954e1	2017-11-29 23:35:55.516	93	91	f	embedded-question	\N	1	27	\N	\N
1267	\\xb01ab430a97f00647f2ea6776c5224260a950c9bdd337897bfbf26a5ee89aa9b	2017-11-29 23:35:56.098	57	1	f	embedded-question	\N	1	39	\N	\N
1269	\\x08fb682e6462441c203ded87d8fd61c85b379b279309ba2c3baedbec1e3a432c	2017-11-29 23:35:56.32	149	7	f	embedded-question	\N	1	26	\N	\N
1268	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-29 23:35:56.29	97	25	f	embedded-question	\N	1	29	\N	\N
1272	\\x2df1c1b99dab5d6c0df61c40a4bc206c6dfad0aa9bb3abebb778075cb7301608	2017-11-29 23:43:52.145	1935	1	f	embedded-question	\N	1	38	\N	\N
1273	\\xb01ab430a97f00647f2ea6776c5224260a950c9bdd337897bfbf26a5ee89aa9b	2017-11-29 23:43:51.86	3208	1	f	embedded-question	\N	1	39	\N	\N
1274	\\x08fb682e6462441c203ded87d8fd61c85b379b279309ba2c3baedbec1e3a432c	2017-11-29 23:43:53.278	1871	7	f	embedded-question	\N	1	26	\N	\N
1275	\\xe70291818d87d3dce40668f3feb8dabcbdfd8288676c4aed01571e4040c0bbab	2017-11-29 23:43:51.863	3315	3	f	embedded-question	\N	1	25	\N	\N
1276	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-29 23:43:54.365	1207	54	f	embedded-question	\N	1	28	\N	\N
1277	\\x2d92775ca5136dd0fcfd1d1bcd3fb6a8ac2a509ee66e18f7dc4abfb5a4a954e1	2017-11-29 23:43:52.561	3133	91	f	embedded-question	\N	1	27	\N	\N
1278	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-29 23:43:55.446	358	25	f	embedded-question	\N	1	29	\N	\N
1279	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-11-29 23:50:27.719	106	50	f	question	\N	1	24	\N	\N
1280	\\x619ba579cc2cba9995d467f0c1b5eeceb63896b971c47ee34e6ed4b154eaefa3	2017-11-29 23:50:34.671	90	1	f	question	\N	1	22	\N	\N
1281	\\x16f264b4f2051e7b92cd622b1ad1bb9c18ac323fe6b987b14633924632a8343b	2017-11-29 23:51:16.132	90	2	f	ad-hoc	\N	1	\N	\N	\N
1282	\\x16f264b4f2051e7b92cd622b1ad1bb9c18ac323fe6b987b14633924632a8343b	2017-11-29 23:51:21.783	78	2	f	ad-hoc	\N	1	\N	\N	\N
1283	\\x16f264b4f2051e7b92cd622b1ad1bb9c18ac323fe6b987b14633924632a8343b	2017-11-29 23:51:25.352	90	2	f	question	\N	1	22	\N	\N
1284	\\x619ba579cc2cba9995d467f0c1b5eeceb63896b971c47ee34e6ed4b154eaefa3	2017-11-29 23:51:26.645	98	1	f	ad-hoc	\N	1	\N	\N	\N
1285	\\x4378f8e359fd2cef7a7968e05f2c7b5aa6155e537a799688097eb1a1844b079c	2017-11-29 23:51:32.102	69	1	f	question	\N	1	20	\N	\N
1286	\\xbcffe78744ab2241567e650bea687f68c7215ac8fd15891bc444ec2e4284317a	2017-11-29 23:52:00.514	73	3	f	ad-hoc	\N	1	\N	\N	\N
1287	\\x16f264b4f2051e7b92cd622b1ad1bb9c18ac323fe6b987b14633924632a8343b	2017-11-29 23:52:13.209	54	2	f	question	\N	1	22	\N	\N
1288	\\x6b5039481ad1749520b96d2176d5bfbc2b6eba08495cf8054faed42d28658a53	2017-11-29 23:52:17.01	81	1	f	question	\N	1	21	\N	\N
1289	\\xbd3c80317764415cbb70c03f7e0e90dfc07a01e3e1333ce11ff44575c04a364e	2017-11-29 23:52:34.581	88	3	f	question	\N	1	19	\N	\N
1290	\\x4fa64b3921a5345e56cafded326679d694ff759dc9c14a9c99a091b6ef7b026a	2017-11-29 23:53:03.393	73	74	f	question	\N	1	23	\N	\N
1291	\\x1913b6e388cb6d697ec47a12fcd29ae9abd4a71069f6bfc4c18fc97575ca0a27	2017-11-29 23:53:21.144	48	1	f	ad-hoc	\N	1	\N	\N	\N
1292	\\xf929d282ed7b516cf7e299cd2576fcc3eea6e71c4991b382da2c97278a42500d	2017-11-29 23:53:55.722	83	1	f	ad-hoc	\N	1	\N	\N	\N
1293	\\xb204f11185354b6c0ec52816fc20f7cc5bf1d6d243ec958396bca494fe96a3e6	2017-11-29 23:54:18.055	215	2000	f	ad-hoc	\N	1	\N	\N	\N
1294	\\x8f34e1a8509769dd9f759c926a8a7e9492491ac784b1e7218e221ae8707522b5	2017-11-29 23:54:24.393	56	1	f	ad-hoc	\N	1	\N	\N	\N
1295	\\x2df1c1b99dab5d6c0df61c40a4bc206c6dfad0aa9bb3abebb778075cb7301608	2017-11-29 23:54:54.382	101	1	f	question	\N	1	38	\N	\N
1296	\\x8f34e1a8509769dd9f759c926a8a7e9492491ac784b1e7218e221ae8707522b5	2017-11-29 23:55:07.049	62	1	f	question	\N	1	40	\N	\N
1297	\\x8ca1483aa78081de6c3e2ebe04e1af174c842edde39e7db8cf04a093acf31d44	2017-11-29 23:55:30.562	81	1	f	question	\N	1	23	\N	\N
1298	\\xf429d0082adac3811e2b09eae4f56e1fd5b00b94e25974cd3300caf8fbf69bc5	2017-11-29 23:56:06.953	110	6	f	question	\N	1	18	\N	\N
1299	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-11-29 23:57:01.891	109	50	f	question	\N	1	24	\N	\N
1300	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-29 23:57:29.4	112	25	f	question	\N	1	29	\N	\N
1301	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-29 23:57:43.727	175	25	f	question	\N	1	29	\N	\N
1302	\\xed2a4829b7a6c6923808014390693d5567723fb8ad2a1cfe6973fb74f1398c6c	2017-11-29 23:58:13.567	74	78	f	ad-hoc	\N	1	\N	\N	\N
1303	\\xfe08604a45b1dba23d6706c683efeaee01bbbb6f5fa92960dbdf191a185c3e42	2017-11-29 23:58:26.172	91	41	f	ad-hoc	\N	1	\N	\N	\N
1304	\\xfe08604a45b1dba23d6706c683efeaee01bbbb6f5fa92960dbdf191a185c3e42	2017-11-29 23:58:43.399	49	41	f	ad-hoc	\N	1	\N	\N	\N
1305	\\xfe08604a45b1dba23d6706c683efeaee01bbbb6f5fa92960dbdf191a185c3e42	2017-11-29 23:58:49.772	86	41	f	ad-hoc	\N	1	\N	\N	\N
1306	\\xed2a4829b7a6c6923808014390693d5567723fb8ad2a1cfe6973fb74f1398c6c	2017-11-29 23:59:50.71	56	78	f	ad-hoc	\N	1	\N	\N	\N
1307	\\xfe08604a45b1dba23d6706c683efeaee01bbbb6f5fa92960dbdf191a185c3e42	2017-11-30 00:00:04.819	45	41	f	ad-hoc	\N	1	\N	\N	\N
1308	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-11-30 00:01:02.55	89	50	f	question	\N	1	24	\N	\N
1309	\\xbcffe78744ab2241567e650bea687f68c7215ac8fd15891bc444ec2e4284317a	2017-11-30 00:01:51.727	45	3	f	question	\N	1	20	\N	\N
1310	\\x16f264b4f2051e7b92cd622b1ad1bb9c18ac323fe6b987b14633924632a8343b	2017-11-30 00:02:12.284	47	2	f	question	\N	1	22	\N	\N
1311	\\x8ca1483aa78081de6c3e2ebe04e1af174c842edde39e7db8cf04a093acf31d44	2017-11-30 00:02:16.747	82	1	f	question	\N	1	23	\N	\N
1312	\\xfe08604a45b1dba23d6706c683efeaee01bbbb6f5fa92960dbdf191a185c3e42	2017-11-30 00:02:20.463	50	41	f	question	\N	1	41	\N	\N
1313	\\x8f34e1a8509769dd9f759c926a8a7e9492491ac784b1e7218e221ae8707522b5	2017-11-30 00:02:26.587	16	1	f	question	\N	1	40	\N	\N
1314	\\x29b0c260982c378cf8a1c056056e713de28c007cc341c89cd0fb1dca40fd5cf8	2017-11-30 00:02:43.398	36	137	f	ad-hoc	\N	1	\N	\N	\N
1315	\\x4cdd58ce635e28e4c4632ebf3524af71e4ea32d396bb6fedc1bd717999a95297	2017-11-30 00:02:52.152	52	10	f	ad-hoc	\N	1	\N	\N	\N
1316	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-11-30 00:03:47.059	55	50	f	question	\N	1	24	\N	\N
1317	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-11-30 00:03:58.252	36	50	f	question	\N	1	24	\N	\N
1318	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-11-30 00:04:17.701	80	50	f	question	\N	1	24	\N	\N
1319	\\xbcffe78744ab2241567e650bea687f68c7215ac8fd15891bc444ec2e4284317a	2017-11-30 00:04:23.741	57	3	f	question	\N	1	20	\N	\N
1320	\\x16f264b4f2051e7b92cd622b1ad1bb9c18ac323fe6b987b14633924632a8343b	2017-11-30 00:04:35.203	70	2	f	question	\N	1	22	\N	\N
1321	\\x8ca1483aa78081de6c3e2ebe04e1af174c842edde39e7db8cf04a093acf31d44	2017-11-30 00:04:47.926	73	1	f	question	\N	1	23	\N	\N
1322	\\xfe08604a45b1dba23d6706c683efeaee01bbbb6f5fa92960dbdf191a185c3e42	2017-11-30 00:05:10.67	40	41	f	question	\N	1	41	\N	\N
1323	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-11-30 00:05:36.691	134	50	f	question	\N	1	24	\N	\N
1324	\\xbcffe78744ab2241567e650bea687f68c7215ac8fd15891bc444ec2e4284317a	2017-11-30 00:05:36.911	92	3	f	question	\N	1	20	\N	\N
1325	\\x16f264b4f2051e7b92cd622b1ad1bb9c18ac323fe6b987b14633924632a8343b	2017-11-30 00:05:37.686	47	2	f	question	\N	1	22	\N	\N
1326	\\xfe08604a45b1dba23d6706c683efeaee01bbbb6f5fa92960dbdf191a185c3e42	2017-11-30 00:05:38.755	38	41	f	question	\N	1	41	\N	\N
1327	\\x4cdd58ce635e28e4c4632ebf3524af71e4ea32d396bb6fedc1bd717999a95297	2017-11-30 00:05:40.675	24	10	f	question	\N	1	42	\N	\N
1328	\\x8ca1483aa78081de6c3e2ebe04e1af174c842edde39e7db8cf04a093acf31d44	2017-11-30 00:05:42.682	60	1	f	question	\N	1	23	\N	\N
1329	\\x8f34e1a8509769dd9f759c926a8a7e9492491ac784b1e7218e221ae8707522b5	2017-11-30 00:05:43.684	16	1	f	question	\N	1	40	\N	\N
1330	\\xfe08604a45b1dba23d6706c683efeaee01bbbb6f5fa92960dbdf191a185c3e42	2017-11-30 00:06:54.675	34	41	f	question	\N	1	41	\N	\N
1331	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-30 00:08:33.692	244	54	f	question	\N	1	28	\N	\N
1332	\\xe70291818d87d3dce40668f3feb8dabcbdfd8288676c4aed01571e4040c0bbab	2017-11-30 00:08:34.719	164	3	f	question	\N	1	25	\N	\N
1333	\\x08fb682e6462441c203ded87d8fd61c85b379b279309ba2c3baedbec1e3a432c	2017-11-30 00:08:35.689	134	7	f	question	\N	1	26	\N	\N
1334	\\xb01ab430a97f00647f2ea6776c5224260a950c9bdd337897bfbf26a5ee89aa9b	2017-11-30 00:08:36.665	90	1	f	question	\N	1	39	\N	\N
1336	\\x2d92775ca5136dd0fcfd1d1bcd3fb6a8ac2a509ee66e18f7dc4abfb5a4a954e1	2017-11-30 00:08:37.683	68	91	f	question	\N	1	27	\N	\N
1337	\\x2df1c1b99dab5d6c0df61c40a4bc206c6dfad0aa9bb3abebb778075cb7301608	2017-11-30 00:08:38.662	18	1	f	question	\N	1	38	\N	\N
1342	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-30 00:12:24.695	48	25	f	question	\N	1	29	\N	\N
1335	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-30 00:08:36.734	96	25	f	question	\N	1	29	\N	\N
1368	\\x8ca1483aa78081de6c3e2ebe04e1af174c842edde39e7db8cf04a093acf31d44	2017-11-30 00:14:58.017	143	1	f	embedded-question	\N	1	23	\N	\N
1369	\\xbcffe78744ab2241567e650bea687f68c7215ac8fd15891bc444ec2e4284317a	2017-11-30 00:14:58.118	141	3	f	embedded-question	\N	1	20	\N	\N
1338	\\x21678b2295982c88e9789dfcb7287c8fd16779962af06fd27243776617554f13	2017-11-30 00:11:41.363	51	323	f	ad-hoc	\N	1	\N	\N	\N
1339	\\xff28920483cc37246197c20a937a686b4dc5a0f2eb23876726db7e099d175cb3	2017-11-30 00:11:48.453	41	323	f	ad-hoc	\N	1	\N	\N	\N
1340	\\x6c4e31712c119cf7a66b289f88ff5f98a2fd6f85b950a8d1ba162468c2c67b24	2017-11-30 00:11:52.256	45	10	f	ad-hoc	\N	1	\N	\N	\N
1341	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-30 00:12:17.935	108	54	f	question	\N	1	28	\N	\N
1343	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-30 00:13:30.681	65	54	f	question	\N	1	28	\N	\N
1344	\\xe70291818d87d3dce40668f3feb8dabcbdfd8288676c4aed01571e4040c0bbab	2017-11-30 00:13:31.685	66	3	f	question	\N	1	25	\N	\N
1345	\\x08fb682e6462441c203ded87d8fd61c85b379b279309ba2c3baedbec1e3a432c	2017-11-30 00:13:32.681	64	7	f	question	\N	1	26	\N	\N
1346	\\xb01ab430a97f00647f2ea6776c5224260a950c9bdd337897bfbf26a5ee89aa9b	2017-11-30 00:13:33.679	106	1	f	question	\N	1	39	\N	\N
1347	\\x2df1c1b99dab5d6c0df61c40a4bc206c6dfad0aa9bb3abebb778075cb7301608	2017-11-30 00:13:35.694	39	1	f	question	\N	1	38	\N	\N
1348	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-30 00:13:35.662	97	25	f	question	\N	1	29	\N	\N
1349	\\x6c4e31712c119cf7a66b289f88ff5f98a2fd6f85b950a8d1ba162468c2c67b24	2017-11-30 00:13:36.698	27	10	f	question	\N	1	27	\N	\N
1350	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-11-30 00:13:50.711	188	50	f	question	\N	1	24	\N	\N
1354	\\xfe08604a45b1dba23d6706c683efeaee01bbbb6f5fa92960dbdf191a185c3e42	2017-11-30 00:13:53.883	58	41	f	question	\N	1	41	\N	\N
1355	\\x8f34e1a8509769dd9f759c926a8a7e9492491ac784b1e7218e221ae8707522b5	2017-11-30 00:13:54.691	36	1	f	question	\N	1	40	\N	\N
1356	\\x4cdd58ce635e28e4c4632ebf3524af71e4ea32d396bb6fedc1bd717999a95297	2017-11-30 00:13:55.672	32	10	f	question	\N	1	42	\N	\N
1358	\\xb01ab430a97f00647f2ea6776c5224260a950c9bdd337897bfbf26a5ee89aa9b	2017-11-30 00:14:38.397	56	1	f	embedded-question	\N	1	39	\N	\N
1359	\\x08fb682e6462441c203ded87d8fd61c85b379b279309ba2c3baedbec1e3a432c	2017-11-30 00:14:38.532	144	7	f	embedded-question	\N	1	26	\N	\N
1360	\\xe70291818d87d3dce40668f3feb8dabcbdfd8288676c4aed01571e4040c0bbab	2017-11-30 00:14:38.592	128	3	f	embedded-question	\N	1	25	\N	\N
1361	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-11-30 00:14:38.655	88	54	f	embedded-question	\N	1	28	\N	\N
1362	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-11-30 00:14:38.813	114	25	f	embedded-question	\N	1	29	\N	\N
1363	\\x6c4e31712c119cf7a66b289f88ff5f98a2fd6f85b950a8d1ba162468c2c67b24	2017-11-30 00:14:39.289	32	10	f	embedded-question	\N	1	27	\N	\N
1364	\\x8f34e1a8509769dd9f759c926a8a7e9492491ac784b1e7218e221ae8707522b5	2017-11-30 00:14:57.953	91	1	f	embedded-question	\N	1	40	\N	\N
1366	\\xfe08604a45b1dba23d6706c683efeaee01bbbb6f5fa92960dbdf191a185c3e42	2017-11-30 00:14:57.947	169	41	f	embedded-question	\N	1	41	\N	\N
1367	\\xe70291818d87d3dce40668f3feb8dabcbdfd8288676c4aed01571e4040c0bbab	2017-11-30 00:14:57.935	196	3	f	embedded-question	\N	1	25	\N	\N
1370	\\x16f264b4f2051e7b92cd622b1ad1bb9c18ac323fe6b987b14633924632a8343b	2017-11-30 00:14:58.031	239	2	f	embedded-question	\N	1	22	\N	\N
1351	\\xbcffe78744ab2241567e650bea687f68c7215ac8fd15891bc444ec2e4284317a	2017-11-30 00:13:50.831	102	3	f	question	\N	1	20	\N	\N
1352	\\x16f264b4f2051e7b92cd622b1ad1bb9c18ac323fe6b987b14633924632a8343b	2017-11-30 00:13:52.69	126	2	f	question	\N	1	22	\N	\N
1353	\\x8ca1483aa78081de6c3e2ebe04e1af174c842edde39e7db8cf04a093acf31d44	2017-11-30 00:13:52.959	87	1	f	question	\N	1	23	\N	\N
1357	\\x2df1c1b99dab5d6c0df61c40a4bc206c6dfad0aa9bb3abebb778075cb7301608	2017-11-30 00:14:38.167	29	1	f	embedded-question	\N	1	38	\N	\N
1365	\\x4cdd58ce635e28e4c4632ebf3524af71e4ea32d396bb6fedc1bd717999a95297	2017-11-30 00:14:57.95	157	10	f	embedded-question	\N	1	42	\N	\N
1371	\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	2017-12-01 23:54:02.242	1153	0	f	ad-hoc	\N	1	\N	\N	\N
1372	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-01 23:54:41.523	507	1	f	embedded-question	\N	1	37	\N	\N
1373	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-01 23:54:43.863	293	1	f	embedded-question	\N	1	36	\N	\N
1374	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-01 23:54:44.094	632	109	f	embedded-question	\N	1	14	\N	\N
1375	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-12-01 23:54:46.54	185	7	f	embedded-question	\N	1	16	\N	\N
1376	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-12-01 23:54:46.624	286	57	f	embedded-question	\N	1	17	\N	\N
1377	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-01 23:54:47.852	210	45	f	embedded-question	\N	1	15	\N	\N
1378	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-01 23:55:17.293	202	1	f	ad-hoc	\N	1	\N	\N	\N
1379	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-01 23:56:08.948	229	1	f	question	\N	1	44	\N	\N
1380	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-01 23:56:29.227	189	1	f	question	\N	1	44	\N	\N
1381	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-01 23:56:37.224	192	1	f	question	\N	1	44	\N	\N
1382	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-01 23:57:14.736	362	1	f	embedded-question	\N	1	37	\N	\N
1383	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-01 23:57:14.65	603	109	f	embedded-question	\N	1	14	\N	\N
1384	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-01 23:57:17.142	319	45	f	embedded-question	\N	1	15	\N	\N
1385	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-12-01 23:57:19.659	178	7	f	embedded-question	\N	1	16	\N	\N
1386	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-01 23:57:21.949	298	1	f	embedded-question	\N	1	44	\N	\N
1387	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-01 23:57:22.073	153	1	f	embedded-question	\N	1	36	\N	\N
1388	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-12-01 23:57:22.695	206	57	f	embedded-question	\N	1	17	\N	\N
1389	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-01 23:57:28.774	103	1	f	embedded-question	\N	1	36	\N	\N
1390	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-01 23:57:28.959	437	1	f	embedded-question	\N	1	37	\N	\N
1391	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-12-01 23:57:29.134	348	0	f	embedded-question	\N	1	2	\N	\N
1392	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-01 23:57:29.255	346	0	f	embedded-question	\N	1	4	\N	\N
1393	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-01 23:57:29.224	386	0	f	embedded-question	\N	1	7	\N	\N
1394	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-12-01 23:57:29.228	407	0	f	embedded-question	\N	1	6	\N	\N
1395	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-01 23:57:29.412	309	0	f	embedded-question	\N	1	3	\N	\N
1396	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-01 23:57:38.241	204	1	f	embedded-question	\N	1	34	\N	\N
1397	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-01 23:57:38.226	1011	1	f	embedded-question	\N	1	35	\N	\N
1398	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-01 23:57:40.603	577	2	f	embedded-question	\N	1	30	\N	\N
1399	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-01 23:57:41.775	2142	100	f	embedded-question	\N	1	33	\N	\N
1400	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-01 23:57:43.295	1117	56	f	embedded-question	\N	1	31	\N	\N
1401	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-01 23:57:43.211	1230	144	f	embedded-question	\N	1	32	\N	\N
1402	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-01 23:58:24.946	121	1	f	embedded-question	\N	1	36	\N	\N
1403	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-01 23:58:24.948	256	1	f	embedded-question	\N	1	37	\N	\N
1418	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-02 00:07:30.349	52	1	f	embedded-question	\N	1	36	\N	\N
1421	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-02 00:07:33.609	189	25	f	embedded-question	\N	1	7	\N	\N
1423	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-02 00:07:34.723	144	55	f	embedded-question	\N	1	4	\N	\N
1446	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-02 00:11:38.6	242	1	f	embedded-question	\N	1	46	\N	\N
1454	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-12-02 00:12:00.432	328	174	f	embedded-question	\N	1	2	\N	\N
1455	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-02 00:12:00.561	220	55	f	embedded-question	\N	1	4	\N	\N
1457	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-02 00:12:02.786	169	25	f	embedded-question	\N	1	7	\N	\N
1458	\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	2017-12-02 00:12:03.941	29	1	f	question	\N	1	45	\N	\N
1460	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-12-02 00:12:18.682	340	174	f	embedded-question	\N	1	2	\N	\N
1462	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-02 00:12:18.856	280	1	f	embedded-question	\N	1	46	\N	\N
1475	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-02 00:12:43.241	125	25	f	embedded-question	\N	1	7	\N	\N
1476	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-02 00:14:13.009	105	1	f	question	\N	1	46	\N	\N
1478	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-02 00:14:29.162	193	1	f	embedded-question	\N	1	44	\N	\N
1480	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-12-02 00:14:29.113	318	174	f	embedded-question	\N	1	2	\N	\N
1483	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-02 00:14:31.205	156	132	f	embedded-question	\N	1	3	\N	\N
1484	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-12-02 00:14:31.245	181	132	f	embedded-question	\N	1	6	\N	\N
1490	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-12-02 00:14:39.25	104	50	f	embedded-question	\N	1	24	\N	\N
1508	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-02 00:15:29.977	34	1	f	embedded-question	\N	1	36	\N	\N
1510	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-12-02 00:15:31.983	91	2	f	embedded-question	\N	1	12	\N	\N
1520	\\x8ca1483aa78081de6c3e2ebe04e1af174c842edde39e7db8cf04a093acf31d44	2017-12-02 00:17:02.144	52	1	f	embedded-question	\N	1	23	\N	\N
1521	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-12-02 00:17:03.723	45	50	f	embedded-question	\N	1	24	\N	\N
1523	\\x16f264b4f2051e7b92cd622b1ad1bb9c18ac323fe6b987b14633924632a8343b	2017-12-02 00:17:06.166	61	2	f	embedded-question	\N	1	22	\N	\N
1524	\\xfe08604a45b1dba23d6706c683efeaee01bbbb6f5fa92960dbdf191a185c3e42	2017-12-02 00:17:07.221	62	41	f	embedded-question	\N	1	41	\N	\N
1527	\\x8f34e1a8509769dd9f759c926a8a7e9492491ac784b1e7218e221ae8707522b5	2017-12-02 00:18:24.499	25	1	f	question	\N	1	47	\N	\N
1532	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-02 00:21:26.569	124	1	f	embedded-question	\N	1	36	\N	\N
1545	\\x8ca1483aa78081de6c3e2ebe04e1af174c842edde39e7db8cf04a093acf31d44	2017-12-02 00:21:53.528	48	1	f	embedded-question	\N	1	23	\N	\N
1553	\\xb01ab430a97f00647f2ea6776c5224260a950c9bdd337897bfbf26a5ee89aa9b	2017-12-02 00:22:25.997	62	1	f	embedded-question	\N	1	39	\N	\N
1560	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-12-02 00:22:30.745	77	54	f	embedded-question	\N	1	28	\N	\N
1561	\\xb01ab430a97f00647f2ea6776c5224260a950c9bdd337897bfbf26a5ee89aa9b	2017-12-02 00:22:56.054	76	1	f	question	\N	1	39	\N	\N
1404	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-12-01 23:58:26.999	91	0	f	embedded-question	\N	1	11	\N	\N
1405	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-12-01 23:58:26.997	120	0	f	embedded-question	\N	1	12	\N	\N
1408	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-01 23:58:35.746	105	1	f	question	\N	1	44	\N	\N
1409	\\x8c2f81f74f2358b3c15d63bb859c858cce011ebd9fd88c86ccebdab8bd5a2ddb	2017-12-01 23:59:08.132	90	1	f	ad-hoc	\N	1	\N	\N	\N
1410	\\x8c2f81f74f2358b3c15d63bb859c858cce011ebd9fd88c86ccebdab8bd5a2ddb	2017-12-01 23:59:11.539	50	1	f	ad-hoc	\N	1	\N	\N	\N
1411	\\x828ec0cdaf94cfd3779e38089101f74b8032442aba4864a808d4201ec75718e4	2017-12-01 23:59:41.366	41	1	f	ad-hoc	\N	1	\N	\N	\N
1425	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-02 00:07:36.56	167	1	f	embedded-question	\N	1	37	\N	\N
1426	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-12-02 00:07:37.039	32	0	f	embedded-question	\N	1	12	\N	\N
1430	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-02 00:10:23.314	144	1	f	question	\N	1	46	\N	\N
1433	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-12-02 00:10:42.187	194	174	f	embedded-question	\N	1	2	\N	\N
1434	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-02 00:10:42.528	175	55	f	embedded-question	\N	1	4	\N	\N
1443	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-02 00:11:38.526	127	1	f	embedded-question	\N	1	44	\N	\N
1444	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-02 00:11:38.569	216	25	f	embedded-question	\N	1	7	\N	\N
1445	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-12-02 00:11:38.53	295	174	f	embedded-question	\N	1	2	\N	\N
1494	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-12-02 00:15:04.38	55	56	f	embedded-question	\N	1	11	\N	\N
1496	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-12-02 00:15:04.95	55	2	f	embedded-question	\N	1	12	\N	\N
1497	\\x2df1c1b99dab5d6c0df61c40a4bc206c6dfad0aa9bb3abebb778075cb7301608	2017-12-02 00:15:08.299	34	1	f	embedded-question	\N	1	38	\N	\N
1499	\\xe70291818d87d3dce40668f3feb8dabcbdfd8288676c4aed01571e4040c0bbab	2017-12-02 00:15:09.989	74	3	f	embedded-question	\N	1	25	\N	\N
1505	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-12-02 00:15:27.638	101	56	f	embedded-question	\N	1	11	\N	\N
1506	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-02 00:15:27.72	170	1	f	embedded-question	\N	1	37	\N	\N
1522	\\xbcffe78744ab2241567e650bea687f68c7215ac8fd15891bc444ec2e4284317a	2017-12-02 00:17:04.76	46	3	f	embedded-question	\N	1	20	\N	\N
1536	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-02 00:21:26.62	508	1	f	embedded-question	\N	1	37	\N	\N
1537	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-02 00:21:26.786	437	45	f	embedded-question	\N	1	15	\N	\N
1538	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-12-02 00:21:26.74	520	57	f	embedded-question	\N	1	17	\N	\N
1546	\\x8f34e1a8509769dd9f759c926a8a7e9492491ac784b1e7218e221ae8707522b5	2017-12-02 00:21:53.588	24	1	f	embedded-question	\N	1	47	\N	\N
1548	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-02 00:21:55.244	138	1	f	embedded-question	\N	1	44	\N	\N
1554	\\x2df1c1b99dab5d6c0df61c40a4bc206c6dfad0aa9bb3abebb778075cb7301608	2017-12-02 00:22:26.021	51	1	f	embedded-question	\N	1	38	\N	\N
1556	\\x08fb682e6462441c203ded87d8fd61c85b379b279309ba2c3baedbec1e3a432c	2017-12-02 00:22:28.358	105	7	f	embedded-question	\N	1	26	\N	\N
1565	\\x08fb682e6462441c203ded87d8fd61c85b379b279309ba2c3baedbec1e3a432c	2017-12-02 00:23:17.861	95	7	f	embedded-question	\N	1	26	\N	\N
1567	\\x6c4e31712c119cf7a66b289f88ff5f98a2fd6f85b950a8d1ba162468c2c67b24	2017-12-02 00:23:17.963	68	10	f	embedded-question	\N	1	27	\N	\N
1406	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-12-01 23:58:29.619	56	0	f	embedded-question	\N	1	10	\N	\N
1407	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-12-01 23:58:29.659	108	0	f	embedded-question	\N	1	13	\N	\N
1412	\\x2cf3c6a70291d2eedbfc531b84979a306c14f7311a0f69aeed88991221f441a8	2017-12-01 23:59:59.719	46	1	f	ad-hoc	\N	1	\N	\N	\N
1413	\\x828ec0cdaf94cfd3779e38089101f74b8032442aba4864a808d4201ec75718e4	2017-12-02 00:03:29.584	103	1	f	ad-hoc	\N	1	\N	\N	\N
1414	\\x6211b1138bac14e5fa2bcfee231d2ef771cfbaf3c6f887897328190dd8ff31cb	2017-12-02 00:04:11.672	219	2000	f	ad-hoc	\N	1	\N	\N	\N
1415	\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	2017-12-02 00:04:17.165	47	1	f	ad-hoc	\N	1	\N	\N	\N
1416	\\x522c67fda35f38ca78c1877bcdc6771f8e18baff2989da9f57ab89939c670fd7	2017-12-02 00:05:14.467	118	1	f	ad-hoc	\N	1	\N	\N	\N
1417	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-02 00:07:14.245	123	1	f	question	\N	1	46	\N	\N
1419	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-02 00:07:30.303	121	1	f	embedded-question	\N	1	37	\N	\N
1420	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-12-02 00:07:31.857	176	174	f	embedded-question	\N	1	2	\N	\N
1428	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-12-02 00:07:37.554	51	0	f	embedded-question	\N	1	13	\N	\N
1429	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-12-02 00:07:37.775	32	0	f	embedded-question	\N	1	11	\N	\N
1431	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-02 00:10:41.5	167	1	f	embedded-question	\N	1	37	\N	\N
1436	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-02 00:10:47.707	199	55	f	embedded-question	\N	1	4	\N	\N
1439	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-02 00:10:47.909	242	132	f	embedded-question	\N	1	3	\N	\N
1486	\\xfe08604a45b1dba23d6706c683efeaee01bbbb6f5fa92960dbdf191a185c3e42	2017-12-02 00:14:37.28	87	41	f	embedded-question	\N	1	41	\N	\N
1487	\\xbcffe78744ab2241567e650bea687f68c7215ac8fd15891bc444ec2e4284317a	2017-12-02 00:14:37.306	89	3	f	embedded-question	\N	1	20	\N	\N
1488	\\x16f264b4f2051e7b92cd622b1ad1bb9c18ac323fe6b987b14633924632a8343b	2017-12-02 00:14:38.195	46	2	f	embedded-question	\N	1	22	\N	\N
1489	\\x4cdd58ce635e28e4c4632ebf3524af71e4ea32d396bb6fedc1bd717999a95297	2017-12-02 00:14:39.248	89	10	f	embedded-question	\N	1	42	\N	\N
1491	\\x8f34e1a8509769dd9f759c926a8a7e9492491ac784b1e7218e221ae8707522b5	2017-12-02 00:14:39.706	32	1	f	embedded-question	\N	1	40	\N	\N
1492	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-02 00:15:02.328	48	1	f	embedded-question	\N	1	36	\N	\N
1498	\\xb01ab430a97f00647f2ea6776c5224260a950c9bdd337897bfbf26a5ee89aa9b	2017-12-02 00:15:08.261	91	1	f	embedded-question	\N	1	39	\N	\N
1500	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-02 00:15:09.951	106	1	f	embedded-question	\N	1	44	\N	\N
1504	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-12-02 00:15:13.892	120	54	f	embedded-question	\N	1	28	\N	\N
1529	\\x8ca1483aa78081de6c3e2ebe04e1af174c842edde39e7db8cf04a093acf31d44	2017-12-02 00:19:49.959	68	1	f	question	\N	1	48	\N	\N
1531	\\x8ca1483aa78081de6c3e2ebe04e1af174c842edde39e7db8cf04a093acf31d44	2017-12-02 00:21:09.249	46	1	f	question	\N	1	23	\N	\N
1534	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-12-02 00:21:26.908	206	7	f	embedded-question	\N	1	16	\N	\N
1540	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-12-02 00:21:50.131	220	7	f	embedded-question	\N	1	16	\N	\N
1542	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-02 00:21:50.166	301	1	f	embedded-question	\N	1	37	\N	\N
1543	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-02 00:21:50.176	350	45	f	embedded-question	\N	1	15	\N	\N
1544	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-02 00:21:50.23	377	109	f	embedded-question	\N	1	14	\N	\N
1549	\\x16f264b4f2051e7b92cd622b1ad1bb9c18ac323fe6b987b14633924632a8343b	2017-12-02 00:21:57.031	62	2	f	embedded-question	\N	1	22	\N	\N
1550	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-12-02 00:21:57.066	62	50	f	embedded-question	\N	1	24	\N	\N
1551	\\xfe08604a45b1dba23d6706c683efeaee01bbbb6f5fa92960dbdf191a185c3e42	2017-12-02 00:21:59.025	47	41	f	embedded-question	\N	1	41	\N	\N
1552	\\x4cdd58ce635e28e4c4632ebf3524af71e4ea32d396bb6fedc1bd717999a95297	2017-12-02 00:21:59.059	32	10	f	embedded-question	\N	1	42	\N	\N
1555	\\xe70291818d87d3dce40668f3feb8dabcbdfd8288676c4aed01571e4040c0bbab	2017-12-02 00:22:27.198	47	3	f	embedded-question	\N	1	25	\N	\N
1557	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-02 00:22:28.393	111	1	f	embedded-question	\N	1	44	\N	\N
1558	\\x6c4e31712c119cf7a66b289f88ff5f98a2fd6f85b950a8d1ba162468c2c67b24	2017-12-02 00:22:28.929	44	10	f	embedded-question	\N	1	27	\N	\N
1559	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-12-02 00:22:30.715	68	25	f	embedded-question	\N	1	29	\N	\N
1564	\\xb01ab430a97f00647f2ea6776c5224260a950c9bdd337897bfbf26a5ee89aa9b	2017-12-02 00:23:17.844	93	1	f	embedded-question	\N	1	39	\N	\N
1422	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-02 00:07:33.612	222	132	f	embedded-question	\N	1	3	\N	\N
1424	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-02 00:07:36.265	29	1	f	embedded-question	\N	1	36	\N	\N
1427	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-12-02 00:07:37.301	38	0	f	embedded-question	\N	1	10	\N	\N
1432	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-02 00:10:41.777	83	1	f	embedded-question	\N	1	44	\N	\N
1435	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-02 00:10:46.73	110	1	f	embedded-question	\N	1	44	\N	\N
1437	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-02 00:10:47.741	222	1	f	embedded-question	\N	1	37	\N	\N
1438	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-12-02 00:10:47.749	314	174	f	embedded-question	\N	1	2	\N	\N
1440	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-12-02 00:10:50.835	225	132	f	embedded-question	\N	1	6	\N	\N
1441	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-02 00:10:51.142	238	25	f	embedded-question	\N	1	7	\N	\N
1442	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-02 00:11:38.244	92	1	f	embedded-question	\N	1	37	\N	\N
1449	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-02 00:11:41.359	207	132	f	embedded-question	\N	1	3	\N	\N
1450	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-02 00:11:59.225	148	1	f	embedded-question	\N	1	46	\N	\N
1451	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-02 00:12:00.334	83	1	f	embedded-question	\N	1	44	\N	\N
1452	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-02 00:12:00.357	234	132	f	embedded-question	\N	1	3	\N	\N
1453	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-02 00:12:00.45	230	1	f	embedded-question	\N	1	46	\N	\N
1456	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-12-02 00:12:01.69	135	132	f	embedded-question	\N	1	6	\N	\N
1459	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-02 00:12:18.764	120	1	f	embedded-question	\N	1	44	\N	\N
1463	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-02 00:12:18.992	277	132	f	embedded-question	\N	1	3	\N	\N
1465	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-12-02 00:12:21.354	199	132	f	embedded-question	\N	1	6	\N	\N
1470	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-02 00:12:40.98	367	132	f	embedded-question	\N	1	3	\N	\N
1471	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-12-02 00:12:41.031	379	174	f	embedded-question	\N	1	2	\N	\N
1472	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-02 00:12:41.024	481	1	f	embedded-question	\N	1	46	\N	\N
1473	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-02 00:12:41.223	317	55	f	embedded-question	\N	1	4	\N	\N
1474	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-12-02 00:12:42.433	135	132	f	embedded-question	\N	1	6	\N	\N
1479	\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	2017-12-02 00:14:29.173	194	1	f	embedded-question	\N	1	45	\N	\N
1481	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-02 00:14:29.256	261	25	f	embedded-question	\N	1	7	\N	\N
1485	\\x8ca1483aa78081de6c3e2ebe04e1af174c842edde39e7db8cf04a093acf31d44	2017-12-02 00:14:35.574	42	1	f	embedded-question	\N	1	23	\N	\N
1493	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-02 00:15:02.303	116	1	f	embedded-question	\N	1	37	\N	\N
1495	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-12-02 00:15:04.421	62	128	f	embedded-question	\N	1	10	\N	\N
1501	\\x6c4e31712c119cf7a66b289f88ff5f98a2fd6f85b950a8d1ba162468c2c67b24	2017-12-02 00:15:11.712	39	10	f	embedded-question	\N	1	27	\N	\N
1502	\\x08fb682e6462441c203ded87d8fd61c85b379b279309ba2c3baedbec1e3a432c	2017-12-02 00:15:11.763	75	7	f	embedded-question	\N	1	26	\N	\N
1503	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-12-02 00:15:13.861	108	25	f	embedded-question	\N	1	29	\N	\N
1507	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-12-02 00:15:28.982	75	128	f	embedded-question	\N	1	10	\N	\N
1509	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-02 00:15:30.465	113	1	f	embedded-question	\N	1	44	\N	\N
1511	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-12-02 00:15:31.981	103	75	f	embedded-question	\N	1	13	\N	\N
1512	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-02 00:16:26.155	153	1	f	embedded-question	\N	1	37	\N	\N
1513	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-02 00:16:26.466	28	1	f	embedded-question	\N	1	36	\N	\N
1514	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-12-02 00:16:26.582	98	56	f	embedded-question	\N	1	11	\N	\N
1515	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-12-02 00:16:26.644	102	128	f	embedded-question	\N	1	10	\N	\N
1516	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-02 00:16:26.636	119	1	f	embedded-question	\N	1	44	\N	\N
1517	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-12-02 00:16:26.857	90	75	f	embedded-question	\N	1	13	\N	\N
1518	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-12-02 00:16:28.599	41	2	f	embedded-question	\N	1	12	\N	\N
1519	\\x8f34e1a8509769dd9f759c926a8a7e9492491ac784b1e7218e221ae8707522b5	2017-12-02 00:17:02.151	17	1	f	embedded-question	\N	1	40	\N	\N
1525	\\x4cdd58ce635e28e4c4632ebf3524af71e4ea32d396bb6fedc1bd717999a95297	2017-12-02 00:17:07.242	52	10	f	embedded-question	\N	1	42	\N	\N
1526	\\x8f34e1a8509769dd9f759c926a8a7e9492491ac784b1e7218e221ae8707522b5	2017-12-02 00:17:47.676	24	1	f	ad-hoc	\N	1	\N	\N	\N
1528	\\xf929d282ed7b516cf7e299cd2576fcc3eea6e71c4991b382da2c97278a42500d	2017-12-02 00:19:22.605	41	1	f	ad-hoc	\N	1	\N	\N	\N
1530	\\x8ca1483aa78081de6c3e2ebe04e1af174c842edde39e7db8cf04a093acf31d44	2017-12-02 00:20:40.395	53	1	f	question	\N	1	48	\N	\N
1533	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-02 00:21:26.594	271	1	f	embedded-question	\N	1	44	\N	\N
1535	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-02 00:21:26.627	524	109	f	embedded-question	\N	1	14	\N	\N
1539	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-02 00:21:50.076	125	1	f	embedded-question	\N	1	44	\N	\N
1541	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-02 00:21:50.356	56	1	f	embedded-question	\N	1	36	\N	\N
1547	\\xbcffe78744ab2241567e650bea687f68c7215ac8fd15891bc444ec2e4284317a	2017-12-02 00:21:55.2	62	3	f	embedded-question	\N	1	20	\N	\N
1562	\\x2df1c1b99dab5d6c0df61c40a4bc206c6dfad0aa9bb3abebb778075cb7301608	2017-12-02 00:23:17.08	31	1	f	embedded-question	\N	1	38	\N	\N
1563	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-02 00:23:17.371	90	1	f	embedded-question	\N	1	44	\N	\N
1566	\\xe70291818d87d3dce40668f3feb8dabcbdfd8288676c4aed01571e4040c0bbab	2017-12-02 00:23:17.899	130	3	f	embedded-question	\N	1	25	\N	\N
1447	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-02 00:11:40.122	187	55	f	embedded-question	\N	1	4	\N	\N
1448	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-12-02 00:11:41.33	221	132	f	embedded-question	\N	1	6	\N	\N
1461	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-02 00:12:18.815	272	1	f	embedded-question	\N	1	46	\N	\N
1464	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-02 00:12:19.112	185	55	f	embedded-question	\N	1	4	\N	\N
1466	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-02 00:12:21.437	202	25	f	embedded-question	\N	1	7	\N	\N
1467	\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	2017-12-02 00:12:28.237	39	1	f	question	\N	1	45	\N	\N
1468	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-02 00:12:40.739	72	1	f	embedded-question	\N	1	44	\N	\N
1469	\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	2017-12-02 00:12:40.94	160	1	f	embedded-question	\N	1	45	\N	\N
1477	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-02 00:14:28.894	133	1	f	embedded-question	\N	1	46	\N	\N
1482	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-02 00:14:29.42	216	55	f	embedded-question	\N	1	4	\N	\N
1568	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-12-02 00:23:19.397	91	54	f	embedded-question	\N	1	28	\N	\N
1569	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-12-02 00:23:19.415	83	25	f	embedded-question	\N	1	29	\N	\N
1570	\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	2017-12-05 00:27:40.31	535	1	f	embedded-question	\N	\N	45	\N	\N
1571	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-05 00:27:39.849	1361	1	f	embedded-question	\N	\N	46	\N	\N
1572	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 00:27:40.056	1127	1	f	embedded-question	\N	\N	44	\N	\N
1573	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-12-05 00:27:41.038	413	174	f	embedded-question	\N	\N	2	\N	\N
1574	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-05 00:27:41.024	456	56	f	embedded-question	\N	\N	4	\N	\N
1575	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-05 00:27:41.039	504	133	f	embedded-question	\N	\N	3	\N	\N
1576	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-05 00:27:41.353	199	25	f	embedded-question	\N	\N	7	\N	\N
1577	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-12-05 00:27:41.4	251	133	f	embedded-question	\N	\N	6	\N	\N
1578	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-05 00:27:44.848	347	1	f	embedded-question	\N	\N	35	\N	\N
1579	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-05 00:27:45.605	158	1	f	embedded-question	\N	\N	34	\N	\N
1580	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 00:27:45.671	383	1	f	embedded-question	\N	\N	44	\N	\N
1581	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-05 00:27:45.558	566	56	f	embedded-question	\N	\N	32	\N	\N
1582	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-05 00:27:45.754	592	2	f	embedded-question	\N	\N	30	\N	\N
1583	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-05 00:27:45.74	651	56	f	embedded-question	\N	\N	31	\N	\N
1584	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-05 00:27:45.811	947	100	f	embedded-question	\N	\N	33	\N	\N
1585	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-05 00:27:49.764	105	1	f	embedded-question	\N	\N	34	\N	\N
1586	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-05 00:27:49.789	354	1	f	embedded-question	\N	\N	35	\N	\N
1587	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 00:27:50.516	209	1	f	embedded-question	\N	\N	44	\N	\N
1588	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-05 00:27:50.633	443	2	f	embedded-question	\N	\N	30	\N	\N
1589	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-05 00:27:50.491	605	56	f	embedded-question	\N	\N	32	\N	\N
1590	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-05 00:27:50.604	597	56	f	embedded-question	\N	\N	31	\N	\N
1591	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-05 00:27:50.64	875	100	f	embedded-question	\N	\N	33	\N	\N
1592	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-05 00:27:54.147	35	1	f	embedded-question	\N	\N	36	\N	\N
1593	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-05 00:27:54.264	120	1	f	embedded-question	\N	\N	37	\N	\N
1594	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-12-05 00:27:54.594	115	128	f	embedded-question	\N	\N	10	\N	\N
1595	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 00:27:54.573	158	1	f	embedded-question	\N	\N	44	\N	\N
1596	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-12-05 00:27:54.639	161	2	f	embedded-question	\N	\N	12	\N	\N
1597	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-12-05 00:27:54.691	112	56	f	embedded-question	\N	\N	11	\N	\N
1598	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-12-05 00:27:54.735	136	75	f	embedded-question	\N	\N	13	\N	\N
1599	\\x8f34e1a8509769dd9f759c926a8a7e9492491ac784b1e7218e221ae8707522b5	2017-12-05 00:28:08.777	205	0	f	embedded-question	\N	\N	47	\N	\N
1600	\\x4cdd58ce635e28e4c4632ebf3524af71e4ea32d396bb6fedc1bd717999a95297	2017-12-05 00:28:09.063	122	0	f	embedded-question	\N	\N	42	\N	\N
1601	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 00:28:08.859	375	1	f	embedded-question	\N	\N	44	\N	\N
1602	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-12-05 00:28:08.998	222	0	f	embedded-question	\N	\N	24	\N	\N
1603	\\xbcffe78744ab2241567e650bea687f68c7215ac8fd15891bc444ec2e4284317a	2017-12-05 00:28:08.878	395	0	f	embedded-question	\N	\N	20	\N	\N
1604	\\x8ca1483aa78081de6c3e2ebe04e1af174c842edde39e7db8cf04a093acf31d44	2017-12-05 00:28:08.794	481	0	f	embedded-question	\N	\N	23	\N	\N
1605	\\x16f264b4f2051e7b92cd622b1ad1bb9c18ac323fe6b987b14633924632a8343b	2017-12-05 00:28:09.217	190	0	f	embedded-question	\N	\N	22	\N	\N
1606	\\xfe08604a45b1dba23d6706c683efeaee01bbbb6f5fa92960dbdf191a185c3e42	2017-12-05 00:28:09.311	101	0	f	embedded-question	\N	\N	41	\N	\N
1609	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 00:28:18.138	148	1	f	embedded-question	\N	\N	44	\N	\N
1610	\\x08fb682e6462441c203ded87d8fd61c85b379b279309ba2c3baedbec1e3a432c	2017-12-05 00:28:18.214	156	7	f	embedded-question	\N	\N	26	\N	\N
1613	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-12-05 00:28:18.322	232	54	f	embedded-question	\N	\N	28	\N	\N
1614	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-12-05 00:28:18.421	230	25	f	embedded-question	\N	\N	29	\N	\N
1615	\\xbcffe78744ab2241567e650bea687f68c7215ac8fd15891bc444ec2e4284317a	2017-12-05 00:28:23.877	83	0	f	embedded-question	\N	\N	20	\N	\N
1617	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-12-05 00:28:23.927	92	0	f	embedded-question	\N	\N	24	\N	\N
1618	\\xfe08604a45b1dba23d6706c683efeaee01bbbb6f5fa92960dbdf191a185c3e42	2017-12-05 00:28:23.923	101	0	f	embedded-question	\N	\N	41	\N	\N
1619	\\x8ca1483aa78081de6c3e2ebe04e1af174c842edde39e7db8cf04a093acf31d44	2017-12-05 00:28:24.335	85	0	f	embedded-question	\N	\N	23	\N	\N
1620	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 00:28:24.339	139	1	f	embedded-question	\N	\N	44	\N	\N
1623	\\x8f34e1a8509769dd9f759c926a8a7e9492491ac784b1e7218e221ae8707522b5	2017-12-05 00:40:14.881	16	0	f	embedded-question	\N	\N	47	\N	\N
1624	\\xfe08604a45b1dba23d6706c683efeaee01bbbb6f5fa92960dbdf191a185c3e42	2017-12-05 00:40:14.907	30	0	f	embedded-question	\N	\N	41	\N	\N
1626	\\x16f264b4f2051e7b92cd622b1ad1bb9c18ac323fe6b987b14633924632a8343b	2017-12-05 00:40:15.426	78	0	f	embedded-question	\N	\N	22	\N	\N
1628	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-12-05 00:40:15.744	35	0	f	embedded-question	\N	\N	24	\N	\N
1633	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-05 01:37:10.426	117	1	f	embedded-question	\N	1	37	\N	\N
1639	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 01:37:16.065	103	1	f	embedded-question	\N	1	44	\N	\N
1641	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-05 01:37:16.454	218	110	f	embedded-question	\N	1	14	\N	\N
1642	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-12-05 01:37:16.571	233	7	f	embedded-question	\N	1	16	\N	\N
1643	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-05 01:37:16.652	184	45	f	embedded-question	\N	1	15	\N	\N
1644	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-12-05 01:37:16.617	284	57	f	embedded-question	\N	1	17	\N	\N
1652	\\xaa901522813549cd496f3cea1d156873c754ef70bc2db6ad4355aff75881926b	2017-12-05 01:44:40.314	72	1	f	ad-hoc	\N	1	\N	\N	\N
1656	\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	2017-12-05 01:55:41.676	62	1	f	embedded-question	\N	1	45	\N	\N
1657	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 01:55:41.659	117	1	f	embedded-question	\N	1	44	\N	\N
1658	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-12-05 01:55:41.68	198	174	f	embedded-question	\N	1	2	\N	\N
1666	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 01:55:45.976	53	1	f	embedded-question	\N	1	44	\N	\N
1607	\\x2df1c1b99dab5d6c0df61c40a4bc206c6dfad0aa9bb3abebb778075cb7301608	2017-12-05 00:28:16.858	80	1	f	embedded-question	\N	\N	38	\N	\N
1608	\\xb01ab430a97f00647f2ea6776c5224260a950c9bdd337897bfbf26a5ee89aa9b	2017-12-05 00:28:16.877	133	1	f	embedded-question	\N	\N	39	\N	\N
1627	\\xbcffe78744ab2241567e650bea687f68c7215ac8fd15891bc444ec2e4284317a	2017-12-05 00:40:15.573	21	0	f	embedded-question	\N	\N	20	\N	\N
1629	\\x8ca1483aa78081de6c3e2ebe04e1af174c842edde39e7db8cf04a093acf31d44	2017-12-05 00:40:15.878	24	0	f	embedded-question	\N	\N	23	\N	\N
1630	\\x4cdd58ce635e28e4c4632ebf3524af71e4ea32d396bb6fedc1bd717999a95297	2017-12-05 00:40:16.051	36	0	f	embedded-question	\N	\N	42	\N	\N
1645	\\x3d017954f202fb414a9c97d85b9aeda04aee29cd7e642a6d9934c3444ef076c7	2017-12-05 01:39:07.728	92	2000	f	ad-hoc	\N	1	\N	\N	\N
1649	\\x03ab7b55cad996e98ecdf6097c61c13ef3cb0189c01cc2e66b58a07fcff4fd2c	2017-12-05 01:43:49.225	17	1	f	question	\N	1	49	\N	\N
1650	\\x03ab7b55cad996e98ecdf6097c61c13ef3cb0189c01cc2e66b58a07fcff4fd2c	2017-12-05 01:44:03.911	13	1	f	question	\N	1	49	\N	\N
1651	\\xdd3c7f6ba2efd52b79f108613dbffd3eb8e467b60e497bb58be214f335c7483b	2017-12-05 01:44:29.31	87	3	f	ad-hoc	\N	1	\N	\N	\N
1611	\\xe70291818d87d3dce40668f3feb8dabcbdfd8288676c4aed01571e4040c0bbab	2017-12-05 00:28:18.182	205	3	f	embedded-question	\N	\N	25	\N	\N
1612	\\x6c4e31712c119cf7a66b289f88ff5f98a2fd6f85b950a8d1ba162468c2c67b24	2017-12-05 00:28:18.421	124	10	f	embedded-question	\N	\N	27	\N	\N
1616	\\x8f34e1a8509769dd9f759c926a8a7e9492491ac784b1e7218e221ae8707522b5	2017-12-05 00:28:23.933	69	0	f	embedded-question	\N	\N	47	\N	\N
1621	\\x4cdd58ce635e28e4c4632ebf3524af71e4ea32d396bb6fedc1bd717999a95297	2017-12-05 00:28:24.567	102	0	f	embedded-question	\N	\N	42	\N	\N
1622	\\x16f264b4f2051e7b92cd622b1ad1bb9c18ac323fe6b987b14633924632a8343b	2017-12-05 00:28:24.57	108	0	f	embedded-question	\N	\N	22	\N	\N
1625	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 00:40:15.233	78	1	f	embedded-question	\N	\N	44	\N	\N
1631	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-05 01:37:10.203	58	1	f	embedded-question	\N	1	36	\N	\N
1632	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-12-05 01:37:10.487	55	56	f	embedded-question	\N	1	11	\N	\N
1634	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 01:37:10.726	70	1	f	embedded-question	\N	1	44	\N	\N
1635	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-12-05 01:37:11.185	46	128	f	embedded-question	\N	1	10	\N	\N
1636	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-12-05 01:37:11.232	48	75	f	embedded-question	\N	1	13	\N	\N
1637	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-12-05 01:37:11.298	31	2	f	embedded-question	\N	1	12	\N	\N
1638	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-05 01:37:16.038	78	1	f	embedded-question	\N	1	36	\N	\N
1640	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-05 01:37:16.045	174	1	f	embedded-question	\N	1	37	\N	\N
1646	\\x03ab7b55cad996e98ecdf6097c61c13ef3cb0189c01cc2e66b58a07fcff4fd2c	2017-12-05 01:42:07.69	45	1	f	ad-hoc	\N	1	\N	\N	\N
1647	\\xdd3c7f6ba2efd52b79f108613dbffd3eb8e467b60e497bb58be214f335c7483b	2017-12-05 01:42:14.732	95	3	f	ad-hoc	\N	1	\N	\N	\N
1648	\\x03ab7b55cad996e98ecdf6097c61c13ef3cb0189c01cc2e66b58a07fcff4fd2c	2017-12-05 01:42:40.984	52	1	f	ad-hoc	\N	1	\N	\N	\N
1653	\\x3673ca69aa1bccfd54ec76b12ad8eaa823899b44f9b755114635baba929aeb6d	2017-12-05 01:45:43.515	45	1	f	question	\N	1	50	\N	\N
1654	\\x3673ca69aa1bccfd54ec76b12ad8eaa823899b44f9b755114635baba929aeb6d	2017-12-05 01:46:54.114	28	1	f	question	\N	1	50	\N	\N
1655	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-05 01:55:41.242	72	1	f	embedded-question	\N	1	46	\N	\N
1659	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-05 01:55:41.812	271	25	f	embedded-question	\N	1	7	\N	\N
1660	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-05 01:55:41.837	251	56	f	embedded-question	\N	1	4	\N	\N
1661	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-12-05 01:55:41.8	301	133	f	embedded-question	\N	1	6	\N	\N
1662	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-05 01:55:41.884	283	133	f	embedded-question	\N	1	3	\N	\N
1663	\\x03ab7b55cad996e98ecdf6097c61c13ef3cb0189c01cc2e66b58a07fcff4fd2c	2017-12-05 01:55:45.618	25	1	f	embedded-question	\N	1	49	\N	\N
1664	\\x3673ca69aa1bccfd54ec76b12ad8eaa823899b44f9b755114635baba929aeb6d	2017-12-05 01:55:45.627	46	1	f	embedded-question	\N	1	50	\N	\N
1665	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-12-05 01:55:45.644	38	128	f	embedded-question	\N	1	10	\N	\N
1667	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-12-05 01:55:46.133	29	75	f	embedded-question	\N	1	13	\N	\N
1668	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-12-05 01:55:46.303	29	2	f	embedded-question	\N	1	12	\N	\N
1669	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-12-05 01:55:46.457	30	56	f	embedded-question	\N	1	11	\N	\N
1670	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-05 02:45:15.336	351	1	f	embedded-question	\N	\N	36	\N	\N
1671	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-12-05 02:45:14.28	1571	7	f	embedded-question	\N	\N	16	\N	\N
1672	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-05 02:45:12.87	2991	1	f	embedded-question	\N	\N	37	\N	\N
1673	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 02:45:13.961	1743	1	f	embedded-question	\N	\N	44	\N	\N
1674	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-05 02:45:13.484	2726	45	f	embedded-question	\N	\N	15	\N	\N
1675	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-05 02:45:14.948	1373	266	f	embedded-question	\N	\N	14	\N	\N
1676	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-12-05 02:45:16.425	388	166	f	embedded-question	\N	\N	17	\N	\N
1677	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-05 02:45:22.498	312	56	f	embedded-question	\N	\N	4	\N	\N
1678	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-05 02:45:22.792	388	260	f	embedded-question	\N	\N	3	\N	\N
1679	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 02:45:23.457	179	1	f	embedded-question	\N	\N	44	\N	\N
1680	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-05 02:45:24.105	238	1	f	embedded-question	\N	\N	46	\N	\N
1681	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-12-05 02:45:24.591	331	434	f	embedded-question	\N	\N	2	\N	\N
1682	\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	2017-12-05 02:45:24.924	73	1	f	embedded-question	\N	\N	45	\N	\N
1683	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-05 02:45:25.852	190	25	f	embedded-question	\N	\N	7	\N	\N
1684	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-12-05 02:45:26.134	266	260	f	embedded-question	\N	\N	6	\N	\N
1685	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-05 02:45:28.942	426	1	f	embedded-question	\N	\N	35	\N	\N
1686	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 02:45:29.559	128	1	f	embedded-question	\N	\N	44	\N	\N
1687	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-05 02:45:29.887	79	1	f	embedded-question	\N	\N	34	\N	\N
1688	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-05 02:45:30.415	307	2	f	embedded-question	\N	\N	30	\N	\N
1689	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-05 02:45:30.774	417	56	f	embedded-question	\N	\N	31	\N	\N
1690	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-05 02:45:31.114	845	100	f	embedded-question	\N	\N	33	\N	\N
1691	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-05 02:45:31.531	539	105	f	embedded-question	\N	\N	32	\N	\N
1692	\\x03ab7b55cad996e98ecdf6097c61c13ef3cb0189c01cc2e66b58a07fcff4fd2c	2017-12-05 02:45:35.518	71	1	f	embedded-question	\N	\N	49	\N	\N
1693	\\x3673ca69aa1bccfd54ec76b12ad8eaa823899b44f9b755114635baba929aeb6d	2017-12-05 02:45:35.901	140	1	f	embedded-question	\N	\N	50	\N	\N
1694	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-12-05 02:45:36.307	110	256	f	embedded-question	\N	\N	10	\N	\N
1695	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 02:45:37.081	182	1	f	embedded-question	\N	\N	44	\N	\N
1696	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-12-05 02:45:37.486	136	56	f	embedded-question	\N	\N	11	\N	\N
1697	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-12-05 02:45:37.925	76	2	f	embedded-question	\N	\N	12	\N	\N
1698	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-12-05 02:45:38.214	165	163	f	embedded-question	\N	\N	13	\N	\N
1699	\\x8f34e1a8509769dd9f759c926a8a7e9492491ac784b1e7218e221ae8707522b5	2017-12-05 02:45:41.564	258	1	f	embedded-question	\N	\N	47	\N	\N
1700	\\xbcffe78744ab2241567e650bea687f68c7215ac8fd15891bc444ec2e4284317a	2017-12-05 02:45:41.6	239	3	f	embedded-question	\N	\N	20	\N	\N
1701	\\x4cdd58ce635e28e4c4632ebf3524af71e4ea32d396bb6fedc1bd717999a95297	2017-12-05 02:45:41.677	199	10	f	embedded-question	\N	\N	42	\N	\N
1702	\\x8ca1483aa78081de6c3e2ebe04e1af174c842edde39e7db8cf04a093acf31d44	2017-12-05 02:45:41.642	259	1	f	embedded-question	\N	\N	23	\N	\N
1703	\\x16f264b4f2051e7b92cd622b1ad1bb9c18ac323fe6b987b14633924632a8343b	2017-12-05 02:45:41.64	316	2	f	embedded-question	\N	\N	22	\N	\N
1704	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 02:45:41.597	465	1	f	embedded-question	\N	\N	44	\N	\N
1705	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-12-05 02:45:41.927	212	51	f	embedded-question	\N	\N	24	\N	\N
1706	\\xfe08604a45b1dba23d6706c683efeaee01bbbb6f5fa92960dbdf191a185c3e42	2017-12-05 02:45:42.015	160	45	f	embedded-question	\N	\N	41	\N	\N
1707	\\x2df1c1b99dab5d6c0df61c40a4bc206c6dfad0aa9bb3abebb778075cb7301608	2017-12-05 02:45:49.409	255	1	f	embedded-question	\N	\N	38	\N	\N
1708	\\xe70291818d87d3dce40668f3feb8dabcbdfd8288676c4aed01571e4040c0bbab	2017-12-05 02:45:49.421	322	3	f	embedded-question	\N	\N	25	\N	\N
1709	\\x6c4e31712c119cf7a66b289f88ff5f98a2fd6f85b950a8d1ba162468c2c67b24	2017-12-05 02:45:49.571	236	10	f	embedded-question	\N	\N	27	\N	\N
1710	\\x08fb682e6462441c203ded87d8fd61c85b379b279309ba2c3baedbec1e3a432c	2017-12-05 02:45:49.52	375	7	f	embedded-question	\N	\N	26	\N	\N
1711	\\xb01ab430a97f00647f2ea6776c5224260a950c9bdd337897bfbf26a5ee89aa9b	2017-12-05 02:45:49.459	445	1	f	embedded-question	\N	\N	39	\N	\N
1712	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 02:45:49.461	578	1	f	embedded-question	\N	\N	44	\N	\N
1713	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-12-05 02:45:49.841	223	55	f	embedded-question	\N	\N	28	\N	\N
1714	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-12-05 02:45:49.763	330	25	f	embedded-question	\N	\N	29	\N	\N
1715	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-05 02:45:55.122	108	1	f	embedded-question	\N	\N	36	\N	\N
1716	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 02:45:55.19	178	1	f	embedded-question	\N	\N	44	\N	\N
1717	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-05 02:45:55.227	337	266	f	embedded-question	\N	\N	14	\N	\N
1718	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-05 02:45:56.315	274	1	f	embedded-question	\N	\N	37	\N	\N
1719	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-12-05 02:45:56.829	365	7	f	embedded-question	\N	\N	16	\N	\N
1720	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-05 02:45:56.749	462	45	f	embedded-question	\N	\N	15	\N	\N
1721	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-12-05 02:45:56.947	403	166	f	embedded-question	\N	\N	17	\N	\N
1722	\\x8f34e1a8509769dd9f759c926a8a7e9492491ac784b1e7218e221ae8707522b5	2017-12-05 02:46:16.103	35	1	f	embedded-question	\N	\N	47	\N	\N
1723	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 02:46:16.381	118	1	f	embedded-question	\N	\N	44	\N	\N
1724	\\x8ca1483aa78081de6c3e2ebe04e1af174c842edde39e7db8cf04a093acf31d44	2017-12-05 02:46:16.874	128	1	f	embedded-question	\N	\N	23	\N	\N
1725	\\xbcffe78744ab2241567e650bea687f68c7215ac8fd15891bc444ec2e4284317a	2017-12-05 02:46:17.305	86	3	f	embedded-question	\N	\N	20	\N	\N
1726	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-12-05 02:46:17.583	68	51	f	embedded-question	\N	\N	24	\N	\N
1727	\\x16f264b4f2051e7b92cd622b1ad1bb9c18ac323fe6b987b14633924632a8343b	2017-12-05 02:46:17.905	82	2	f	embedded-question	\N	\N	22	\N	\N
1728	\\x4cdd58ce635e28e4c4632ebf3524af71e4ea32d396bb6fedc1bd717999a95297	2017-12-05 02:46:18.224	89	10	f	embedded-question	\N	\N	42	\N	\N
1729	\\xfe08604a45b1dba23d6706c683efeaee01bbbb6f5fa92960dbdf191a185c3e42	2017-12-05 02:46:18.595	64	45	f	embedded-question	\N	\N	41	\N	\N
1730	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-05 02:47:04.657	56	1	f	embedded-question	\N	\N	34	\N	\N
1731	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-05 02:47:04.813	608	1	f	embedded-question	\N	\N	35	\N	\N
1732	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 02:47:05.088	381	1	f	embedded-question	\N	\N	44	\N	\N
1733	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-05 02:47:05.437	515	2	f	embedded-question	\N	\N	30	\N	\N
1734	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-05 02:47:05.083	917	56	f	embedded-question	\N	\N	31	\N	\N
1735	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-05 02:47:05.207	829	304	f	embedded-question	\N	\N	32	\N	\N
1736	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-05 02:47:04.814	1352	100	f	embedded-question	\N	\N	33	\N	\N
1737	\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	2017-12-05 02:55:48.615	73	1	f	embedded-question	\N	\N	45	\N	\N
1738	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-05 02:55:49.507	118	1	f	embedded-question	\N	\N	46	\N	\N
1739	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-12-05 02:55:49.665	247	434	f	embedded-question	\N	\N	2	\N	\N
1740	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-05 02:55:51.767	185	260	f	embedded-question	\N	\N	3	\N	\N
1742	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-05 02:55:54.056	140	56	f	embedded-question	\N	\N	4	\N	\N
1748	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-05 02:59:12.145	383	25	f	embedded-question	\N	\N	7	\N	\N
1749	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 02:59:12.129	418	1	f	embedded-question	\N	\N	44	\N	\N
1752	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-12-05 02:59:12.284	441	260	f	embedded-question	\N	\N	6	\N	\N
1757	\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	2017-12-05 03:01:46.306	72	1	f	embedded-question	\N	\N	45	\N	\N
1758	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-05 03:01:46.09	345	1	f	embedded-question	\N	\N	46	\N	\N
1764	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-12-05 03:06:17.148	83	163	f	question	\N	1	13	\N	\N
1766	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-12-05 03:06:24.97	52	2	f	question	\N	1	12	\N	\N
1767	\\x16f264b4f2051e7b92cd622b1ad1bb9c18ac323fe6b987b14633924632a8343b	2017-12-05 03:06:32.915	73	2	f	question	\N	1	22	\N	\N
1770	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-12-05 03:07:17.203	216	166	f	question	\N	1	17	\N	\N
1774	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-05 03:08:32.563	126	25	f	question	\N	1	7	\N	\N
1775	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-05 03:11:21.56	57	1	f	question	\N	1	34	\N	\N
1741	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 02:55:53.327	86	1	f	embedded-question	\N	\N	44	\N	\N
1743	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-05 02:55:54.999	130	25	f	embedded-question	\N	\N	7	\N	\N
1744	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-12-05 02:55:56.11	191	260	f	embedded-question	\N	\N	6	\N	\N
1745	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-12-05 02:56:18.622	226	434	f	embedded-question	\N	\N	2	\N	\N
1746	\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	2017-12-05 02:59:12.029	180	1	f	embedded-question	\N	\N	45	\N	\N
1747	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-05 02:59:12.126	313	1	f	embedded-question	\N	\N	46	\N	\N
1751	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-05 02:59:12.502	235	56	f	embedded-question	\N	\N	4	\N	\N
1753	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-12-05 02:59:12.147	605	434	f	embedded-question	\N	\N	2	\N	\N
1769	\\x4cdd58ce635e28e4c4632ebf3524af71e4ea32d396bb6fedc1bd717999a95297	2017-12-05 03:06:42.811	44	10	f	question	\N	1	42	\N	\N
1771	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-12-05 03:07:46.284	204	166	f	question	\N	1	17	\N	\N
1772	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-05 03:07:57.568	609	100	f	question	\N	1	33	\N	\N
1750	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-05 02:59:12.137	532	260	f	embedded-question	\N	\N	3	\N	\N
1759	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-12-05 03:01:45.943	498	434	f	embedded-question	\N	\N	2	\N	\N
1760	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-12-05 03:01:47.456	180	260	f	embedded-question	\N	\N	6	\N	\N
1761	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-05 03:01:48.327	196	260	f	embedded-question	\N	\N	3	\N	\N
1779	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-05 03:13:02.529	87	1	f	question	\N	1	34	\N	\N
1780	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 03:13:13.302	113	1	f	question	\N	1	44	\N	\N
1783	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 03:17:47.425	225	1	f	embedded-dashboard	\N	1	44	2	\N
1786	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-05 03:17:47.633	685	304	f	embedded-question	\N	1	32	\N	\N
1789	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 03:20:14.469	232	1	f	embedded-dashboard	\N	1	44	2	\N
1800	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-05 03:22:54.573	1063	304	f	embedded-question	\N	1	32	\N	\N
1801	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-05 03:22:54.608	1385	100	f	embedded-question	\N	1	33	\N	\N
1817	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 03:29:00.301	139	1	f	question	\N	1	44	\N	\N
1818	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-05 03:29:00.31	329	1	f	question	\N	1	35	\N	\N
1754	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 03:01:45.847	163	1	f	embedded-question	\N	\N	44	\N	\N
1755	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-05 03:01:45.94	296	56	f	embedded-question	\N	\N	4	\N	\N
1756	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-05 03:01:45.957	421	25	f	embedded-question	\N	\N	7	\N	\N
1762	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-05 03:03:58.256	629	100	f	question	\N	1	33	\N	\N
1763	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-12-05 03:04:24.488	220	434	f	question	\N	1	2	\N	\N
1778	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-05 03:12:53.399	308	1	f	question	\N	1	35	\N	\N
1781	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-05 03:17:45.981	365	2	f	embedded-question	\N	1	30	\N	\N
1765	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-12-05 03:06:20.63	70	256	f	question	\N	1	10	\N	\N
1768	\\xfe08604a45b1dba23d6706c683efeaee01bbbb6f5fa92960dbdf191a185c3e42	2017-12-05 03:06:37.542	37	45	f	question	\N	1	41	\N	\N
1773	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-05 03:08:28.519	136	260	f	question	\N	1	3	\N	\N
1776	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-05 03:11:32.017	81	1	f	question	\N	1	34	\N	\N
1777	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-05 03:11:35.5	247	1	f	question	\N	1	35	\N	\N
1782	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-05 03:17:47.376	165	1	f	embedded-dashboard	\N	1	34	2	\N
1784	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-05 03:17:47.392	661	1	f	embedded-dashboard	\N	1	35	2	\N
1785	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-05 03:17:47.618	515	56	f	embedded-question	\N	1	31	\N	\N
1787	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-05 03:17:48.994	766	100	f	embedded-question	\N	1	33	\N	\N
1788	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-05 03:20:14.406	236	1	f	embedded-dashboard	\N	1	34	2	\N
1790	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-05 03:20:14.22	1076	304	f	embedded-question	\N	1	32	\N	\N
1791	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-05 03:20:14.72	615	2	f	embedded-question	\N	1	30	\N	\N
1792	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-05 03:20:14.427	967	1	f	embedded-dashboard	\N	1	35	2	\N
1793	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-05 03:20:14.512	919	56	f	embedded-question	\N	1	31	\N	\N
1794	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-05 03:20:14.15	1619	100	f	embedded-question	\N	1	33	\N	\N
1795	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-05 03:22:54.544	500	2	f	embedded-question	\N	1	30	\N	\N
1796	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-05 03:22:55.04	153	1	f	embedded-dashboard	\N	1	34	2	\N
1797	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 03:22:55.118	190	1	f	embedded-dashboard	\N	1	44	2	\N
1798	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-05 03:22:54.507	870	56	f	embedded-question	\N	1	31	\N	\N
1799	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-05 03:22:54.997	629	1	f	embedded-dashboard	\N	1	35	2	\N
1802	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-05 03:23:07.615	325	56	f	embedded-question	\N	1	31	\N	\N
1803	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-05 03:23:08.306	433	2	f	embedded-question	\N	1	30	\N	\N
1804	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-05 03:23:08.309	640	304	f	embedded-question	\N	1	32	\N	\N
1805	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-05 03:23:09.049	225	1	f	embedded-dashboard	\N	1	34	2	\N
1806	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 03:23:09.091	268	1	f	embedded-dashboard	\N	1	44	2	\N
1807	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-05 03:23:09.069	496	1	f	embedded-dashboard	\N	1	35	2	\N
1808	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-05 03:23:08.47	1185	100	f	embedded-question	\N	1	33	\N	\N
1809	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-05 03:23:24.813	111	1	f	embedded-dashboard	\N	1	34	2	\N
1810	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-05 03:23:24.845	133	1	f	embedded-dashboard	\N	1	44	2	\N
1811	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-05 03:23:24.842	360	1	f	embedded-dashboard	\N	1	35	2	\N
1812	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-05 03:23:25.305	498	2	f	embedded-question	\N	1	30	\N	\N
1813	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-05 03:23:25.402	695	56	f	embedded-question	\N	1	31	\N	\N
1814	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-05 03:23:25.269	922	304	f	embedded-question	\N	1	32	\N	\N
1815	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-05 03:23:25.439	1177	100	f	embedded-question	\N	1	33	\N	\N
1816	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-05 03:29:00.301	133	1	f	question	\N	1	34	\N	\N
1819	\\x193c05af79fa01184fc2e96dc7648387710861d1e3aea4505581754911fa858c	2017-12-07 23:33:50.726	93	2000	f	ad-hoc	\N	1	\N	\N	\N
1820	\\x1bcc3dbd1e0fd082d85003fb3f6e1aa293f81baa235334a830c5303f55d667f1	2017-12-07 23:33:54.967	161	3	f	ad-hoc	\N	1	\N	\N	\N
1821	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-07 23:34:17.509	176	3	f	ad-hoc	\N	1	\N	\N	\N
1822	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-07 23:34:31.122	168	3	f	ad-hoc	\N	1	\N	\N	\N
1823	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-07 23:34:58.822	188	3	f	ad-hoc	\N	1	\N	\N	\N
1824	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-07 23:38:51.549	123	3	f	question	\N	1	51	\N	\N
1825	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-07 23:40:15.858	34	1	f	embedded-question	\N	1	36	\N	\N
1826	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-07 23:40:16.012	90	1	f	embedded-question	\N	1	44	\N	\N
1827	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-07 23:40:16.216	295	45	f	embedded-question	\N	1	15	\N	\N
1828	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-07 23:40:16.455	270	1	f	embedded-question	\N	1	37	\N	\N
1829	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-07 23:40:16.361	381	267	f	embedded-question	\N	1	14	\N	\N
1830	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-12-07 23:40:16.944	206	166	f	embedded-question	\N	1	17	\N	\N
1831	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-07 23:40:20.313	164	1	f	embedded-question	\N	1	36	\N	\N
1832	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-07 23:40:20.36	246	1	f	embedded-question	\N	1	44	\N	\N
1833	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-07 23:40:20.415	553	1	f	embedded-question	\N	1	37	\N	\N
1834	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-07 23:40:20.37	620	45	f	embedded-question	\N	1	15	\N	\N
1835	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-12-07 23:40:20.449	573	166	f	embedded-question	\N	1	17	\N	\N
1836	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-07 23:40:20.375	658	267	f	embedded-question	\N	1	14	\N	\N
1837	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-07 23:40:32.769	65	1	f	embedded-question	\N	1	36	\N	\N
1838	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-07 23:40:32.799	181	3	f	embedded-question	\N	1	51	\N	\N
1839	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-07 23:40:33.285	160	45	f	embedded-question	\N	1	15	\N	\N
1840	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-07 23:40:33.387	285	1	f	embedded-question	\N	1	37	\N	\N
1841	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-07 23:40:33.477	213	1	f	embedded-question	\N	1	44	\N	\N
1842	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-12-07 23:40:33.499	383	166	f	embedded-question	\N	1	17	\N	\N
1843	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-07 23:40:33.491	394	267	f	embedded-question	\N	1	14	\N	\N
1844	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-10 00:42:05.988	2940	1	f	embedded-question	\N	1	36	\N	\N
1845	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 00:42:08.157	1391	1	f	embedded-question	\N	1	44	\N	\N
1846	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-10 00:42:06.546	3150	1	f	embedded-question	\N	1	37	\N	\N
1847	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-10 00:42:09.567	348	2	f	embedded-question	\N	1	51	\N	\N
1848	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-12-10 00:42:08.44	1536	38	f	embedded-question	\N	1	17	\N	\N
1849	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-10 00:42:07.174	2870	57	f	embedded-question	\N	1	14	\N	\N
1850	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-10 00:42:05.992	4068	45	f	embedded-question	\N	1	15	\N	\N
1851	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-10 00:42:40.354	671	56	f	embedded-question	\N	1	4	\N	\N
1852	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 00:42:41.378	404	1	f	embedded-question	\N	1	44	\N	\N
1853	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-10 00:42:40.877	916	205	f	embedded-question	\N	1	3	\N	\N
1854	\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	2017-12-10 00:42:41.535	348	1	f	embedded-question	\N	1	45	\N	\N
1855	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-10 00:42:41.451	1092	1	f	embedded-question	\N	1	46	\N	\N
1856	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-12-10 00:42:41.655	1280	307	f	embedded-question	\N	1	2	\N	\N
1857	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-12-10 00:42:42.19	867	206	f	embedded-question	\N	1	6	\N	\N
1858	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-10 00:42:42.476	616	25	f	embedded-question	\N	1	7	\N	\N
1859	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-10 00:42:49.743	178	1	f	embedded-question	\N	1	34	\N	\N
1860	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-10 00:42:50.114	188	1	f	embedded-question	\N	1	35	\N	\N
1861	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-10 00:42:50.494	299	2	f	embedded-question	\N	1	30	\N	\N
1862	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 00:42:51.228	396	1	f	embedded-question	\N	1	44	\N	\N
1863	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-10 00:42:51.105	499	33	f	embedded-question	\N	1	31	\N	\N
1864	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-10 00:42:51.332	646	33	f	embedded-question	\N	1	32	\N	\N
1865	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-10 00:42:51.358	610	84	f	embedded-question	\N	1	33	\N	\N
1866	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 00:43:04.127	232	1	f	embedded-question	\N	1	44	\N	\N
1867	\\x4cdd58ce635e28e4c4632ebf3524af71e4ea32d396bb6fedc1bd717999a95297	2017-12-10 00:43:05.78	337	10	f	embedded-question	\N	1	42	\N	\N
1868	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-12-10 00:43:05.832	369	51	f	embedded-question	\N	1	24	\N	\N
1869	\\x16f264b4f2051e7b92cd622b1ad1bb9c18ac323fe6b987b14633924632a8343b	2017-12-10 00:43:05.714	543	2	f	embedded-question	\N	1	22	\N	\N
1870	\\x8f34e1a8509769dd9f759c926a8a7e9492491ac784b1e7218e221ae8707522b5	2017-12-10 00:43:06.245	229	1	f	embedded-question	\N	1	47	\N	\N
1871	\\x8ca1483aa78081de6c3e2ebe04e1af174c842edde39e7db8cf04a093acf31d44	2017-12-10 00:43:06.301	292	1	f	embedded-question	\N	1	23	\N	\N
1872	\\xbcffe78744ab2241567e650bea687f68c7215ac8fd15891bc444ec2e4284317a	2017-12-10 00:43:06.391	334	3	f	embedded-question	\N	1	20	\N	\N
1873	\\xfe08604a45b1dba23d6706c683efeaee01bbbb6f5fa92960dbdf191a185c3e42	2017-12-10 00:43:06.543	234	45	f	embedded-question	\N	1	41	\N	\N
1874	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 00:43:20.016	162	1	f	embedded-question	\N	1	44	\N	\N
1877	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-12-10 00:43:21.283	367	56	f	embedded-question	\N	1	28	\N	\N
1880	\\x08fb682e6462441c203ded87d8fd61c85b379b279309ba2c3baedbec1e3a432c	2017-12-10 00:43:21.803	330	7	f	embedded-question	\N	1	26	\N	\N
1889	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-10 00:49:50.948	70	1	f	embedded-question	\N	1	36	\N	\N
1891	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-10 00:49:51.18	325	1	f	embedded-question	\N	1	37	\N	\N
1892	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 00:49:51.776	158	1	f	embedded-question	\N	1	44	\N	\N
1893	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-10 00:49:52.063	143	2	f	embedded-question	\N	1	51	\N	\N
1894	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-12-10 00:49:51.86	529	166	f	embedded-question	\N	1	17	\N	\N
1897	\\x22857619da3be9a5770e9568affe76f0cd06255f213e2987407e4041c7b81978	2017-12-10 00:50:42.994	220	166	f	ad-hoc	\N	1	\N	\N	\N
1900	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 00:51:18.913	115	1	f	embedded-question	\N	1	44	\N	\N
1905	\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	2017-12-10 00:51:23.416	67	1	f	embedded-question	\N	1	45	\N	\N
1906	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-10 00:51:23.431	153	1	f	embedded-question	\N	1	46	\N	\N
1909	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-12-10 00:51:24.528	450	262	f	embedded-question	\N	1	6	\N	\N
1910	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-12-10 00:51:24.606	441	434	f	embedded-question	\N	1	2	\N	\N
1912	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-10 00:51:24.718	419	25	f	embedded-question	\N	1	7	\N	\N
1913	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-12-10 00:51:31.144	154	434	f	embedded-question	\N	1	2	\N	\N
1917	\\x37cf77f673095db6a1e2cfd7f043a2a64f05eb17c9d788e89bd75de8d5f6645a	2017-12-10 00:52:04.456	194	434	f	ad-hoc	\N	1	\N	\N	\N
1921	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-10 00:52:17.868	578	2	f	embedded-question	\N	1	30	\N	\N
1922	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-10 00:52:18.018	573	56	f	embedded-question	\N	1	31	\N	\N
1923	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-10 00:52:17.998	658	304	f	embedded-question	\N	1	32	\N	\N
1924	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-10 00:52:17.795	1057	100	f	embedded-question	\N	1	33	\N	\N
1926	\\x03ab7b55cad996e98ecdf6097c61c13ef3cb0189c01cc2e66b58a07fcff4fd2c	2017-12-10 00:52:24.338	28	1	f	embedded-question	\N	1	49	\N	\N
1927	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-12-10 00:52:24.711	108	56	f	embedded-question	\N	1	11	\N	\N
1947	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-12-10 01:15:22.67	77	56	f	embedded-question	\N	1	11	\N	\N
1875	\\x2df1c1b99dab5d6c0df61c40a4bc206c6dfad0aa9bb3abebb778075cb7301608	2017-12-10 00:43:21.325	145	1	f	embedded-question	\N	1	38	\N	\N
1881	\\xe70291818d87d3dce40668f3feb8dabcbdfd8288676c4aed01571e4040c0bbab	2017-12-10 00:43:22.009	230	3	f	embedded-question	\N	1	25	\N	\N
1883	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 00:43:28.238	300	1	f	embedded-question	\N	1	44	\N	\N
1884	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-10 00:43:28.294	416	1	f	embedded-question	\N	1	37	\N	\N
1885	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-10 00:43:29.247	356	2	f	embedded-question	\N	1	51	\N	\N
1887	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-10 00:43:28.92	783	268	f	embedded-question	\N	1	14	\N	\N
1929	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-12-10 00:52:24.945	220	163	f	embedded-question	\N	1	13	\N	\N
1933	\\xb01ab430a97f00647f2ea6776c5224260a950c9bdd337897bfbf26a5ee89aa9b	2017-12-10 00:52:30.636	182	1	f	embedded-question	\N	1	39	\N	\N
1937	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 00:52:30.681	250	1	f	embedded-question	\N	1	44	\N	\N
1938	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-12-10 00:52:30.88	134	56	f	embedded-question	\N	1	28	\N	\N
1939	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-12-10 00:52:30.951	102	25	f	embedded-question	\N	1	29	\N	\N
1940	\\x37cf77f673095db6a1e2cfd7f043a2a64f05eb17c9d788e89bd75de8d5f6645a	2017-12-10 00:57:18.763	183	434	f	question	\N	1	2	\N	\N
1950	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-12-10 01:15:22.764	78	256	f	embedded-question	\N	1	10	\N	\N
1876	\\x6c4e31712c119cf7a66b289f88ff5f98a2fd6f85b950a8d1ba162468c2c67b24	2017-12-10 00:43:21.329	192	10	f	embedded-question	\N	1	27	\N	\N
1895	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-10 00:49:51.871	608	268	f	embedded-question	\N	1	14	\N	\N
1901	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-10 00:51:19.161	129	2	f	embedded-question	\N	1	51	\N	\N
1902	\\x22857619da3be9a5770e9568affe76f0cd06255f213e2987407e4041c7b81978	2017-12-10 00:51:19.148	252	166	f	embedded-question	\N	1	17	\N	\N
1903	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-10 00:51:19.486	218	45	f	embedded-question	\N	1	15	\N	\N
1904	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-10 00:51:19.574	227	1	f	embedded-question	\N	1	37	\N	\N
1907	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 00:51:23.999	98	1	f	embedded-question	\N	1	44	\N	\N
1908	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-10 00:51:24.483	329	56	f	embedded-question	\N	1	4	\N	\N
1914	\\x22857619da3be9a5770e9568affe76f0cd06255f213e2987407e4041c7b81978	2017-12-10 00:51:45.819	215	166	f	ad-hoc	\N	1	\N	\N	\N
1916	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-12-10 00:51:56.01	201	434	f	question	\N	1	2	\N	\N
1918	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-10 00:52:17.442	79	1	f	embedded-question	\N	1	34	\N	\N
1919	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 00:52:17.757	189	1	f	embedded-question	\N	1	44	\N	\N
1928	\\x3673ca69aa1bccfd54ec76b12ad8eaa823899b44f9b755114635baba929aeb6d	2017-12-10 00:52:24.78	128	1	f	embedded-question	\N	1	50	\N	\N
1931	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-12-10 00:52:24.934	220	2	f	embedded-question	\N	1	12	\N	\N
1936	\\x6c4e31712c119cf7a66b289f88ff5f98a2fd6f85b950a8d1ba162468c2c67b24	2017-12-10 00:52:30.754	120	10	f	embedded-question	\N	1	27	\N	\N
1941	\\x788c553fafd2b30ce63547893a9363b992cfc0ca291e2a09d712225096ac2343	2017-12-10 00:57:28.141	518	0	f	ad-hoc	AnyField: field, ag field reference, expression, expression reference, or field literal.	1	\N	\N	\N
1942	\\x7981e69bbe36912091d0b85d70c16be271b08b8532026d6f212a77019b7c9e70	2017-12-10 00:57:29.61	207	434	f	ad-hoc	\N	1	\N	\N	\N
1943	\\x37cf77f673095db6a1e2cfd7f043a2a64f05eb17c9d788e89bd75de8d5f6645a	2017-12-10 00:57:36.373	170	434	f	ad-hoc	\N	1	\N	\N	\N
1948	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-12-10 01:15:22.72	62	2	f	embedded-question	\N	1	12	\N	\N
1878	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-12-10 00:43:21.591	489	25	f	embedded-question	\N	1	29	\N	\N
1882	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-10 00:43:28.29	183	1	f	embedded-question	\N	1	36	\N	\N
1899	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-10 00:51:18.551	231	268	f	embedded-question	\N	1	14	\N	\N
1925	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 00:52:23.968	91	1	f	embedded-question	\N	1	44	\N	\N
1945	\\x3673ca69aa1bccfd54ec76b12ad8eaa823899b44f9b755114635baba929aeb6d	2017-12-10 01:15:22.048	58	1	f	embedded-question	\N	1	50	\N	\N
1946	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 01:15:22.11	107	1	f	embedded-question	\N	1	44	\N	\N
1879	\\xb01ab430a97f00647f2ea6776c5224260a950c9bdd337897bfbf26a5ee89aa9b	2017-12-10 00:43:21.663	414	1	f	embedded-question	\N	1	39	\N	\N
1890	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-10 00:49:51.189	303	45	f	embedded-question	\N	1	15	\N	\N
1920	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-10 00:52:17.64	519	1	f	embedded-question	\N	1	35	\N	\N
1886	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-10 00:43:28.921	752	45	f	embedded-question	\N	1	15	\N	\N
1888	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-12-10 00:43:29.054	695	166	f	embedded-question	\N	1	17	\N	\N
1896	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-12-10 00:50:29.195	208	166	f	question	\N	1	17	\N	\N
1898	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-10 00:51:18.277	47	1	f	embedded-question	\N	1	36	\N	\N
1911	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-10 00:51:24.726	403	262	f	embedded-question	\N	1	3	\N	\N
1915	\\xe00847a8c515f0e3284beaca82f35119b30336a83bb25d1adc390f4799cbad43	2017-12-10 00:51:46.864	231	166	f	ad-hoc	\N	1	\N	\N	\N
1930	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-12-10 00:52:24.871	248	256	f	embedded-question	\N	1	10	\N	\N
1932	\\x2df1c1b99dab5d6c0df61c40a4bc206c6dfad0aa9bb3abebb778075cb7301608	2017-12-10 00:52:30.669	90	1	f	embedded-question	\N	1	38	\N	\N
1934	\\xe70291818d87d3dce40668f3feb8dabcbdfd8288676c4aed01571e4040c0bbab	2017-12-10 00:52:30.691	119	3	f	embedded-question	\N	1	25	\N	\N
1935	\\x08fb682e6462441c203ded87d8fd61c85b379b279309ba2c3baedbec1e3a432c	2017-12-10 00:52:30.684	156	7	f	embedded-question	\N	1	26	\N	\N
1944	\\x03ab7b55cad996e98ecdf6097c61c13ef3cb0189c01cc2e66b58a07fcff4fd2c	2017-12-10 01:15:22.058	29	1	f	embedded-question	\N	1	49	\N	\N
1949	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-12-10 01:15:22.697	58	163	f	embedded-question	\N	1	13	\N	\N
1951	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-10 10:39:31.006	1873	1	f	embedded-question	\N	1	36	\N	\N
1952	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-10 10:39:31.249	2336	2	f	embedded-question	\N	1	51	\N	\N
1953	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 10:39:31.615	1968	1	f	embedded-question	\N	1	44	\N	\N
1954	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-10 10:39:31.021	2880	1	f	embedded-question	\N	1	37	\N	\N
1955	\\x22857619da3be9a5770e9568affe76f0cd06255f213e2987407e4041c7b81978	2017-12-10 10:39:31.013	3064	114	f	embedded-question	\N	1	17	\N	\N
1956	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-10 10:39:31.646	2688	45	f	embedded-question	\N	1	15	\N	\N
1957	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-10 10:39:33.795	602	187	f	embedded-question	\N	1	14	\N	\N
1958	\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	2017-12-10 10:39:46.4	240	1	f	embedded-question	\N	1	45	\N	\N
1959	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 10:39:46.47	355	1	f	embedded-question	\N	1	44	\N	\N
1960	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-10 10:39:46.678	594	56	f	embedded-question	\N	1	4	\N	\N
1961	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-10 10:39:46.707	734	25	f	embedded-question	\N	1	7	\N	\N
1962	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-10 10:39:46.928	925	1	f	embedded-question	\N	1	46	\N	\N
1963	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-10 10:39:46.681	1310	262	f	embedded-question	\N	1	3	\N	\N
1964	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-12-10 10:39:46.728	1274	262	f	embedded-question	\N	1	6	\N	\N
1965	\\x37cf77f673095db6a1e2cfd7f043a2a64f05eb17c9d788e89bd75de8d5f6645a	2017-12-10 10:39:47.225	867	434	f	embedded-question	\N	1	2	\N	\N
1966	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-10 10:39:53.737	163	1	f	embedded-question	\N	1	34	\N	\N
1967	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 10:39:53.731	358	1	f	embedded-question	\N	1	44	\N	\N
1968	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-10 10:39:54.263	306	2	f	embedded-question	\N	1	30	\N	\N
1969	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-10 10:39:55.044	689	39	f	embedded-question	\N	1	31	\N	\N
1970	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-10 10:39:55.029	862	1	f	embedded-question	\N	1	35	\N	\N
1971	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-10 10:39:55.162	895	39	f	embedded-question	\N	1	32	\N	\N
1972	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-10 10:39:55.166	898	84	f	embedded-question	\N	1	33	\N	\N
1973	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 10:40:04.042	217	1	f	embedded-question	\N	1	44	\N	\N
1974	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-12-10 10:40:04.485	132	56	f	embedded-question	\N	1	11	\N	\N
1975	\\x03ab7b55cad996e98ecdf6097c61c13ef3cb0189c01cc2e66b58a07fcff4fd2c	2017-12-10 10:40:05.575	188	1	f	embedded-question	\N	1	49	\N	\N
1976	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-12-10 10:40:05.589	328	256	f	embedded-question	\N	1	10	\N	\N
1977	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-12-10 10:40:05.841	122	2	f	embedded-question	\N	1	12	\N	\N
1978	\\x3673ca69aa1bccfd54ec76b12ad8eaa823899b44f9b755114635baba929aeb6d	2017-12-10 10:40:05.822	189	1	f	embedded-question	\N	1	50	\N	\N
1979	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-12-10 10:40:05.823	314	163	f	embedded-question	\N	1	13	\N	\N
1980	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 10:40:13.766	283	1	f	embedded-question	\N	1	44	\N	\N
1981	\\x4cdd58ce635e28e4c4632ebf3524af71e4ea32d396bb6fedc1bd717999a95297	2017-12-10 10:40:14.125	97	10	f	embedded-question	\N	1	42	\N	\N
1982	\\x16f264b4f2051e7b92cd622b1ad1bb9c18ac323fe6b987b14633924632a8343b	2017-12-10 10:40:15.315	256	2	f	embedded-question	\N	1	22	\N	\N
1983	\\xbcffe78744ab2241567e650bea687f68c7215ac8fd15891bc444ec2e4284317a	2017-12-10 10:40:15.406	261	3	f	embedded-question	\N	1	20	\N	\N
1984	\\xfe08604a45b1dba23d6706c683efeaee01bbbb6f5fa92960dbdf191a185c3e42	2017-12-10 10:40:15.485	244	45	f	embedded-question	\N	1	41	\N	\N
1985	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-12-10 10:40:15.39	333	51	f	embedded-question	\N	1	24	\N	\N
1986	\\x8f34e1a8509769dd9f759c926a8a7e9492491ac784b1e7218e221ae8707522b5	2017-12-10 10:40:15.408	338	1	f	embedded-question	\N	1	47	\N	\N
1987	\\x8ca1483aa78081de6c3e2ebe04e1af174c842edde39e7db8cf04a093acf31d44	2017-12-10 10:40:15.495	289	1	f	embedded-question	\N	1	23	\N	\N
1988	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 10:41:18.053	315	1	f	embedded-question	\N	1	44	\N	\N
1989	\\xe70291818d87d3dce40668f3feb8dabcbdfd8288676c4aed01571e4040c0bbab	2017-12-10 10:41:18.108	300	3	f	embedded-question	\N	1	25	\N	\N
1990	\\x2df1c1b99dab5d6c0df61c40a4bc206c6dfad0aa9bb3abebb778075cb7301608	2017-12-10 10:41:18.15	315	1	f	embedded-question	\N	1	38	\N	\N
1991	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-12-10 10:41:18.116	353	56	f	embedded-question	\N	1	28	\N	\N
1992	\\x08fb682e6462441c203ded87d8fd61c85b379b279309ba2c3baedbec1e3a432c	2017-12-10 10:41:18.115	505	7	f	embedded-question	\N	1	26	\N	\N
1993	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-12-10 10:41:18.165	503	25	f	embedded-question	\N	1	29	\N	\N
1994	\\x6c4e31712c119cf7a66b289f88ff5f98a2fd6f85b950a8d1ba162468c2c67b24	2017-12-10 10:41:18.504	197	10	f	embedded-question	\N	1	27	\N	\N
1995	\\xb01ab430a97f00647f2ea6776c5224260a950c9bdd337897bfbf26a5ee89aa9b	2017-12-10 10:41:18.626	224	1	f	embedded-question	\N	1	39	\N	\N
1996	\\x8f34e1a8509769dd9f759c926a8a7e9492491ac784b1e7218e221ae8707522b5	2017-12-10 10:41:28.09	43	1	f	embedded-question	\N	1	47	\N	\N
1997	\\x8ca1483aa78081de6c3e2ebe04e1af174c842edde39e7db8cf04a093acf31d44	2017-12-10 10:41:28.665	67	1	f	embedded-question	\N	1	23	\N	\N
1998	\\xbcffe78744ab2241567e650bea687f68c7215ac8fd15891bc444ec2e4284317a	2017-12-10 10:41:28.975	265	3	f	embedded-question	\N	1	20	\N	\N
1999	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 10:41:28.989	364	1	f	embedded-question	\N	1	44	\N	\N
2000	\\x16f264b4f2051e7b92cd622b1ad1bb9c18ac323fe6b987b14633924632a8343b	2017-12-10 10:41:29.059	217	2	f	embedded-question	\N	1	22	\N	\N
2001	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-12-10 10:41:29.062	322	51	f	embedded-question	\N	1	24	\N	\N
2002	\\xfe08604a45b1dba23d6706c683efeaee01bbbb6f5fa92960dbdf191a185c3e42	2017-12-10 10:41:29.546	104	45	f	embedded-question	\N	1	41	\N	\N
2003	\\x4cdd58ce635e28e4c4632ebf3524af71e4ea32d396bb6fedc1bd717999a95297	2017-12-10 10:41:29.605	103	10	f	embedded-question	\N	1	42	\N	\N
2004	\\xfe08604a45b1dba23d6706c683efeaee01bbbb6f5fa92960dbdf191a185c3e42	2017-12-10 10:41:48.681	130	45	f	question	\N	1	41	\N	\N
2005	\\x09ec3782572f315a26db4edbfeeb5929449aa44c1ee7632972ec3e9c66d651df	2017-12-10 10:42:12.439	132	45	f	ad-hoc	\N	1	\N	\N	\N
2006	\\xbcffe78744ab2241567e650bea687f68c7215ac8fd15891bc444ec2e4284317a	2017-12-10 10:42:28.441	106	3	f	embedded-question	\N	1	20	\N	\N
2075	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-12-10 10:53:22.109	56	56	f	question	\N	1	11	\N	\N
2076	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-12-10 10:53:41.027	34	2	f	question	\N	1	12	\N	\N
2077	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-12-10 10:53:45.816	42	256	f	question	\N	1	10	\N	\N
2078	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-12-10 10:54:20.241	51	163	f	question	\N	1	13	\N	\N
2081	\\xbcffe78744ab2241567e650bea687f68c7215ac8fd15891bc444ec2e4284317a	2017-12-10 10:54:54.383	71	3	f	embedded-question	\N	1	20	\N	\N
2084	\\x4cdd58ce635e28e4c4632ebf3524af71e4ea32d396bb6fedc1bd717999a95297	2017-12-10 10:54:54.523	42	10	f	embedded-question	\N	1	42	\N	\N
2086	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 10:54:54.869	90	1	f	embedded-question	\N	1	44	\N	\N
2007	\\x4cdd58ce635e28e4c4632ebf3524af71e4ea32d396bb6fedc1bd717999a95297	2017-12-10 10:42:28.985	145	10	f	embedded-question	\N	1	42	\N	\N
2008	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 10:42:28.708	242	1	f	embedded-question	\N	1	44	\N	\N
2009	\\x16f264b4f2051e7b92cd622b1ad1bb9c18ac323fe6b987b14633924632a8343b	2017-12-10 10:42:28.994	277	2	f	embedded-question	\N	1	22	\N	\N
2010	\\xfe08604a45b1dba23d6706c683efeaee01bbbb6f5fa92960dbdf191a185c3e42	2017-12-10 10:42:29.049	245	45	f	embedded-question	\N	1	41	\N	\N
2011	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-12-10 10:42:29.164	196	51	f	embedded-question	\N	1	24	\N	\N
2012	\\x8f34e1a8509769dd9f759c926a8a7e9492491ac784b1e7218e221ae8707522b5	2017-12-10 10:42:29.154	286	1	f	embedded-question	\N	1	47	\N	\N
2013	\\x8ca1483aa78081de6c3e2ebe04e1af174c842edde39e7db8cf04a093acf31d44	2017-12-10 10:42:29.295	242	1	f	embedded-question	\N	1	23	\N	\N
2014	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-10 10:43:03.239	190	1	f	embedded-question	\N	1	36	\N	\N
2015	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-10 10:43:03.04	564	268	f	embedded-question	\N	1	14	\N	\N
2016	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-10 10:43:03.456	551	2	f	embedded-question	\N	1	51	\N	\N
2017	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-10 10:43:03.464	965	45	f	embedded-question	\N	1	15	\N	\N
2018	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 10:43:03.724	735	1	f	embedded-question	\N	1	44	\N	\N
2022	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-10 10:44:26.518	206	45	f	question	\N	1	15	\N	\N
2023	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-10 10:45:20.86	183	45	f	embedded-question	\N	1	15	\N	\N
2025	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-10 10:46:21.965	144	2	f	embedded-question	\N	1	51	\N	\N
2028	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-10 10:46:40.642	221	56	f	embedded-question	\N	1	4	\N	\N
2043	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-10 10:48:06.249	107	56	f	question	\N	1	4	\N	\N
2046	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-10 10:49:32.067	158	1	f	embedded-question	\N	1	46	\N	\N
2066	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-10 10:52:03.46	1848	100	f	question	\N	1	33	\N	\N
2079	\\x8f34e1a8509769dd9f759c926a8a7e9492491ac784b1e7218e221ae8707522b5	2017-12-10 10:54:53.738	18	1	f	embedded-question	\N	1	47	\N	\N
2080	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-12-10 10:54:54.058	31	51	f	embedded-question	\N	1	24	\N	\N
2082	\\x09ec3782572f315a26db4edbfeeb5929449aa44c1ee7632972ec3e9c66d651df	2017-12-10 10:54:54.38	91	45	f	embedded-question	\N	1	41	\N	\N
2087	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-12-10 10:55:12.22	65	51	f	question	\N	1	24	\N	\N
2091	\\x6c4e31712c119cf7a66b289f88ff5f98a2fd6f85b950a8d1ba162468c2c67b24	2017-12-10 10:55:30.027	127	10	f	embedded-question	\N	1	27	\N	\N
2095	\\x2df1c1b99dab5d6c0df61c40a4bc206c6dfad0aa9bb3abebb778075cb7301608	2017-12-10 10:55:30.371	38	1	f	embedded-question	\N	1	38	\N	\N
2019	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-10 10:43:03.656	905	1	f	embedded-question	\N	1	37	\N	\N
2020	\\x22857619da3be9a5770e9568affe76f0cd06255f213e2987407e4041c7b81978	2017-12-10 10:43:03.622	1191	166	f	embedded-question	\N	1	17	\N	\N
2021	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-10 10:43:19.145	336	268	f	question	\N	1	14	\N	\N
2034	\\x22857619da3be9a5770e9568affe76f0cd06255f213e2987407e4041c7b81978	2017-12-10 10:46:43.212	211	166	f	question	\N	1	17	\N	\N
2036	\\x22857619da3be9a5770e9568affe76f0cd06255f213e2987407e4041c7b81978	2017-12-10 10:46:46.531	195	166	f	ad-hoc	\N	1	\N	\N	\N
2037	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-10 10:46:48.233	154	45	f	question	\N	1	15	\N	\N
2083	\\x16f264b4f2051e7b92cd622b1ad1bb9c18ac323fe6b987b14633924632a8343b	2017-12-10 10:54:54.41	71	2	f	embedded-question	\N	1	22	\N	\N
2085	\\x8ca1483aa78081de6c3e2ebe04e1af174c842edde39e7db8cf04a093acf31d44	2017-12-10 10:54:54.567	42	1	f	embedded-question	\N	1	23	\N	\N
2088	\\xb01ab430a97f00647f2ea6776c5224260a950c9bdd337897bfbf26a5ee89aa9b	2017-12-10 10:55:29.726	79	1	f	embedded-question	\N	1	39	\N	\N
2089	\\xe70291818d87d3dce40668f3feb8dabcbdfd8288676c4aed01571e4040c0bbab	2017-12-10 10:55:29.783	70	3	f	embedded-question	\N	1	25	\N	\N
2090	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 10:55:30.01	142	1	f	embedded-question	\N	1	44	\N	\N
2024	\\x22857619da3be9a5770e9568affe76f0cd06255f213e2987407e4041c7b81978	2017-12-10 10:45:48.943	230	166	f	question	\N	1	17	\N	\N
2029	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-10 10:46:40.818	247	1	f	embedded-question	\N	1	46	\N	\N
2030	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-10 10:46:41.019	291	25	f	embedded-question	\N	1	7	\N	\N
2033	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-12-10 10:46:40.887	542	262	f	embedded-question	\N	1	6	\N	\N
2035	\\x22857619da3be9a5770e9568affe76f0cd06255f213e2987407e4041c7b81978	2017-12-10 10:46:45.831	209	166	f	ad-hoc	\N	1	\N	\N	\N
2038	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-10 10:46:49.076	157	45	f	ad-hoc	\N	1	\N	\N	\N
2039	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-10 10:46:49.685	214	45	f	ad-hoc	\N	1	\N	\N	\N
2042	\\x37cf77f673095db6a1e2cfd7f043a2a64f05eb17c9d788e89bd75de8d5f6645a	2017-12-10 10:47:13.882	170	434	f	question	\N	1	2	\N	\N
2048	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-10 10:49:32.281	286	56	f	embedded-question	\N	1	4	\N	\N
2049	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-10 10:49:32.307	299	262	f	embedded-question	\N	1	3	\N	\N
2050	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-10 10:49:32.385	363	25	f	embedded-question	\N	1	7	\N	\N
2053	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-10 10:49:52.135	114	25	f	question	\N	1	7	\N	\N
2055	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-10 10:51:09.367	150	1	f	embedded-question	\N	1	34	\N	\N
2067	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-10 10:52:39.767	1047	304	f	question	\N	1	32	\N	\N
2069	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-12-10 10:53:11.43	77	163	f	embedded-question	\N	1	13	\N	\N
2071	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-12-10 10:53:11.565	60	56	f	embedded-question	\N	1	11	\N	\N
2074	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 10:53:12.324	137	1	f	embedded-question	\N	1	44	\N	\N
2092	\\x08fb682e6462441c203ded87d8fd61c85b379b279309ba2c3baedbec1e3a432c	2017-12-10 10:55:30.035	168	7	f	embedded-question	\N	1	26	\N	\N
2026	\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	2017-12-10 10:46:40.383	25	1	f	embedded-question	\N	1	45	\N	\N
2027	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 10:46:40.642	136	1	f	embedded-question	\N	1	44	\N	\N
2045	\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	2017-12-10 10:49:31.924	35	1	f	embedded-question	\N	1	45	\N	\N
2047	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 10:49:32.07	156	1	f	embedded-question	\N	1	44	\N	\N
2056	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 10:51:09.648	126	1	f	embedded-question	\N	1	44	\N	\N
2059	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-10 10:51:10.136	1655	56	f	embedded-question	\N	1	31	\N	\N
2060	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-10 10:51:10.187	1926	304	f	embedded-question	\N	1	32	\N	\N
2061	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-10 10:51:10.003	2636	100	f	embedded-question	\N	1	33	\N	\N
2062	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-10 10:51:24.275	824	56	f	question	\N	1	31	\N	\N
2064	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-10 10:51:46.76	798	56	f	ad-hoc	\N	1	\N	\N	\N
2068	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-12-10 10:53:11.409	85	256	f	embedded-question	\N	1	10	\N	\N
2070	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-12-10 10:53:11.569	41	2	f	embedded-question	\N	1	12	\N	\N
2072	\\x03ab7b55cad996e98ecdf6097c61c13ef3cb0189c01cc2e66b58a07fcff4fd2c	2017-12-10 10:53:11.885	17	1	f	embedded-question	\N	1	49	\N	\N
2073	\\x3673ca69aa1bccfd54ec76b12ad8eaa823899b44f9b755114635baba929aeb6d	2017-12-10 10:53:12.317	77	1	f	embedded-question	\N	1	50	\N	\N
2093	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-12-10 10:55:30.063	127	56	f	embedded-question	\N	1	28	\N	\N
2094	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-12-10 10:55:30.267	81	25	f	embedded-question	\N	1	29	\N	\N
2031	\\x37cf77f673095db6a1e2cfd7f043a2a64f05eb17c9d788e89bd75de8d5f6645a	2017-12-10 10:46:40.839	525	434	f	embedded-question	\N	1	2	\N	\N
2032	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-10 10:46:40.89	519	262	f	embedded-question	\N	1	3	\N	\N
2040	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-10 10:46:51.086	216	268	f	question	\N	1	14	\N	\N
2041	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-10 10:46:51.957	229	268	f	ad-hoc	\N	1	\N	\N	\N
2044	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-10 10:48:43.536	130	262	f	question	\N	1	3	\N	\N
2051	\\x37cf77f673095db6a1e2cfd7f043a2a64f05eb17c9d788e89bd75de8d5f6645a	2017-12-10 10:49:32.351	432	434	f	embedded-question	\N	1	2	\N	\N
2052	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-12-10 10:49:32.459	383	262	f	embedded-question	\N	1	6	\N	\N
2054	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-12-10 10:50:43.121	132	262	f	question	\N	1	6	\N	\N
2057	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-10 10:51:09.502	1278	1	f	embedded-question	\N	1	35	\N	\N
2058	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-10 10:51:10.086	1251	2	f	embedded-question	\N	1	30	\N	\N
2063	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-10 10:51:39.673	812	56	f	ad-hoc	\N	1	\N	\N	\N
2065	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-10 10:51:49.282	789	56	f	ad-hoc	\N	1	\N	\N	\N
2096	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-10 11:54:49.861	1530	1	f	embedded-question	\N	1	36	\N	\N
2097	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-10 11:54:50.995	1287	2	f	embedded-question	\N	1	51	\N	\N
2098	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 11:54:49.901	2360	1	f	embedded-question	\N	1	44	\N	\N
2099	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-10 11:54:49.894	2430	1	f	embedded-question	\N	1	37	\N	\N
2100	\\x22857619da3be9a5770e9568affe76f0cd06255f213e2987407e4041c7b81978	2017-12-10 11:54:51.878	505	38	f	embedded-question	\N	1	17	\N	\N
2101	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-10 11:54:49.416	3020	34	f	embedded-question	\N	1	14	\N	\N
2102	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-10 11:54:50.181	2269	34	f	embedded-question	\N	1	15	\N	\N
2103	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-10 11:57:38.469	2071	0	f	embedded-question	\N	1	46	\N	\N
2104	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 11:57:39.416	1130	1	f	embedded-question	\N	1	44	\N	\N
2105	\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	2017-12-10 11:57:39.149	1311	1	f	embedded-question	\N	1	45	\N	\N
2106	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-10 11:57:40.399	533	2	f	embedded-question	\N	1	3	\N	\N
2107	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-10 11:57:40.368	552	2	f	embedded-question	\N	1	4	\N	\N
2108	\\x37cf77f673095db6a1e2cfd7f043a2a64f05eb17c9d788e89bd75de8d5f6645a	2017-12-10 11:57:40.434	472	50	f	embedded-question	\N	1	2	\N	\N
2109	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-12-10 11:57:40.927	232	2	f	embedded-question	\N	1	6	\N	\N
2110	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-10 11:57:40.987	237	10	f	embedded-question	\N	1	7	\N	\N
2111	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-10 11:57:42.855	69	0	f	embedded-question	\N	1	35	\N	\N
2112	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-10 11:57:42.989	53	0	f	embedded-question	\N	1	34	\N	\N
2113	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 11:57:43.461	134	1	f	embedded-question	\N	1	44	\N	\N
2114	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-10 11:57:43.716	97	0	f	embedded-question	\N	1	30	\N	\N
2115	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-10 11:57:44.097	128	0	f	embedded-question	\N	1	32	\N	\N
2116	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-10 11:57:44.174	125	0	f	embedded-question	\N	1	33	\N	\N
2117	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-10 11:57:44.228	105	0	f	embedded-question	\N	1	31	\N	\N
2118	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-10 11:58:47.689	120	1	f	embedded-question	\N	1	36	\N	\N
2119	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-10 11:58:48.495	545	1	f	embedded-question	\N	1	37	\N	\N
2120	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 11:58:48.533	564	1	f	embedded-question	\N	1	44	\N	\N
2121	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-10 11:58:48.724	645	45	f	embedded-question	\N	1	15	\N	\N
2122	\\x22857619da3be9a5770e9568affe76f0cd06255f213e2987407e4041c7b81978	2017-12-10 11:58:48.808	856	113	f	embedded-question	\N	1	17	\N	\N
2123	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-10 11:58:48.927	787	177	f	embedded-question	\N	1	14	\N	\N
2124	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-10 11:58:49.713	222	2	f	embedded-question	\N	1	51	\N	\N
2125	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-10 11:59:55.772	524	262	f	question	\N	1	3	\N	\N
2126	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-10 11:59:55.833	591	25	f	question	\N	1	7	\N	\N
2127	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-10 11:59:55.796	709	56	f	question	\N	1	4	\N	\N
2128	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-12-10 11:59:55.813	904	262	f	question	\N	1	6	\N	\N
2129	\\x37cf77f673095db6a1e2cfd7f043a2a64f05eb17c9d788e89bd75de8d5f6645a	2017-12-10 11:59:55.802	940	434	f	question	\N	1	2	\N	\N
2130	\\xcf5fa65ff623d108eb46e643a888d5cb7a593a64af7314b44379bbe7a510e574	2017-12-10 11:59:56.476	353	24	f	question	\N	1	8	\N	\N
2131	\\xbc462fc1376ef84c69934f95a21232cf42adf867eaea01c64d05fd4215667f9b	2017-12-10 11:59:56.585	352	7	f	question	\N	1	9	\N	\N
2132	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-10 12:00:27.521	533	45	f	question	\N	1	15	\N	\N
2133	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-10 12:00:52.268	465	45	f	question	\N	1	15	\N	\N
2134	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-12-10 12:01:36.526	328	6	f	ad-hoc	\N	1	\N	\N	\N
2135	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-10 12:03:03.064	519	45	f	embedded-question	\N	1	15	\N	\N
2136	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-10 12:03:03.287	537	2	f	embedded-question	\N	1	51	\N	\N
2137	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-10 12:03:03.247	897	1	f	embedded-question	\N	1	37	\N	\N
2138	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-10 12:03:03.511	727	1	f	embedded-question	\N	1	44	\N	\N
2139	\\x22857619da3be9a5770e9568affe76f0cd06255f213e2987407e4041c7b81978	2017-12-10 12:03:03.275	1244	166	f	embedded-question	\N	1	17	\N	\N
2140	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-10 12:03:04.369	157	1	f	embedded-question	\N	1	36	\N	\N
2141	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-10 12:03:04.253	717	267	f	embedded-question	\N	1	14	\N	\N
2142	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-12-10 12:03:04.802	352	6	f	embedded-question	\N	1	52	\N	\N
2143	\\xd4ed4ac21fda71a4b2231eff9a755b9dead0d0bf27404a27a5dbc10010653ffc	2017-12-11 20:15:50.657	932	1521	f	ad-hoc	\N	1	\N	\N	\N
2144	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-11 20:17:29.731	495	1	f	embedded-question	\N	1	44	\N	\N
2145	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-12-11 20:17:29.556	778	6	f	embedded-question	\N	1	52	\N	\N
2146	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-11 20:17:29.583	1113	56	f	embedded-question	\N	1	14	\N	\N
2147	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-11 20:17:30.162	729	45	f	embedded-question	\N	1	15	\N	\N
2148	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-11 20:17:30.442	844	1	f	embedded-question	\N	1	37	\N	\N
2149	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-11 20:17:32.376	337	1	f	embedded-question	\N	1	36	\N	\N
2150	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-11 20:17:32.388	342	0	f	embedded-question	\N	1	51	\N	\N
2151	\\x22857619da3be9a5770e9568affe76f0cd06255f213e2987407e4041c7b81978	2017-12-11 20:17:32.356	549	38	f	embedded-question	\N	1	17	\N	\N
2152	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-12-11 20:17:56.363	235	6	f	question	\N	1	52	\N	\N
2153	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-11 20:18:40.132	621	56	f	question	\N	1	31	\N	\N
2154	\\x82b87d1d4b956fada0b7913fd3d8233cc2d0a10f255c584e09464b7f18d06521	2017-12-11 20:18:48.417	258	6	f	ad-hoc	\N	1	\N	\N	\N
2155	\\x82b87d1d4b956fada0b7913fd3d8233cc2d0a10f255c584e09464b7f18d06521	2017-12-11 20:18:57.297	214	6	f	ad-hoc	\N	1	\N	\N	\N
2156	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-11 20:19:01.02	76	1	f	ad-hoc	\N	1	\N	\N	\N
2157	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-11 20:19:02.227	89	1	f	ad-hoc	\N	1	\N	\N	\N
2158	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-11 20:19:02.814	107	1	f	ad-hoc	\N	1	\N	\N	\N
2159	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-11 20:19:03.58	69	1	f	ad-hoc	\N	1	\N	\N	\N
2160	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-11 20:19:04.205	124	1	f	ad-hoc	\N	1	\N	\N	\N
2161	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-11 20:19:04.88	161	1	f	ad-hoc	\N	1	\N	\N	\N
2162	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-11 20:19:05.523	111	1	f	ad-hoc	\N	1	\N	\N	\N
2163	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-11 20:19:06.217	93	1	f	ad-hoc	\N	1	\N	\N	\N
2164	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-11 20:19:06.851	97	1	f	ad-hoc	\N	1	\N	\N	\N
2165	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-11 20:19:07.471	113	1	f	ad-hoc	\N	1	\N	\N	\N
2166	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-11 20:19:08.104	81	1	f	ad-hoc	\N	1	\N	\N	\N
2167	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-11 20:19:09.058	150	1	f	ad-hoc	\N	1	\N	\N	\N
2168	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-11 20:19:22.152	85	1	f	ad-hoc	\N	1	\N	\N	\N
2169	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-11 20:19:22.901	125	1	f	ad-hoc	\N	1	\N	\N	\N
2170	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-11 20:19:23.515	83	1	f	ad-hoc	\N	1	\N	\N	\N
2171	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-11 20:19:24.102	109	1	f	ad-hoc	\N	1	\N	\N	\N
2172	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-11 20:19:24.693	128	1	f	ad-hoc	\N	1	\N	\N	\N
2173	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-11 20:20:03.75	141	1	f	ad-hoc	\N	1	\N	\N	\N
2174	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-11 20:20:04.84	111	1	f	ad-hoc	\N	1	\N	\N	\N
2175	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-11 20:20:05.606	148	1	f	ad-hoc	\N	1	\N	\N	\N
2176	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-12 02:09:24.911	1547	1	f	embedded-question	\N	1	36	\N	\N
2177	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-12 02:09:25.019	2076	1	f	embedded-question	\N	1	44	\N	\N
2178	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-12-12 02:09:24.911	2230	1	f	embedded-question	\N	1	52	\N	\N
2179	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-12 02:09:24.941	2216	1	f	embedded-question	\N	1	37	\N	\N
2180	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-12 02:09:25.515	1818	27	f	embedded-question	\N	1	15	\N	\N
2181	\\x22857619da3be9a5770e9568affe76f0cd06255f213e2987407e4041c7b81978	2017-12-12 02:09:27.056	469	19	f	embedded-question	\N	1	17	\N	\N
2182	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-12 02:09:27.312	215	0	f	embedded-question	\N	1	51	\N	\N
2183	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-12 02:09:24.91	2424	27	f	embedded-question	\N	1	14	\N	\N
2184	\\xd4ed4ac21fda71a4b2231eff9a755b9dead0d0bf27404a27a5dbc10010653ffc	2017-12-12 02:12:22.022	160	2000	f	ad-hoc	\N	1	\N	\N	\N
2185	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-12 02:12:53.322	184	2	f	question	\N	1	51	\N	\N
2186	\\x25342193c4c0ecf68992b9c9735b8d02ae76530489f6e47ccb88a8ac29b18e75	2017-12-12 02:13:03.148	289	1	f	question	\N	1	52	\N	\N
2187	\\x717d5eb3ecbcf66e03cfdf86a5ed4c2f3d9782c07dc5d19da226844f18d8b124	2017-12-12 02:13:09.741	287	6	f	ad-hoc	\N	1	\N	\N	\N
2188	\\xb7a8a7beee1d9d7f6b94ff0a6319ee2fdd3d4b016068d7a98f02223da31d565f	2017-12-12 02:13:26.727	239	6	f	ad-hoc	\N	1	\N	\N	\N
2189	\\xd4ed4ac21fda71a4b2231eff9a755b9dead0d0bf27404a27a5dbc10010653ffc	2017-12-12 02:13:29.519	82	2000	f	ad-hoc	\N	1	\N	\N	\N
2190	\\xd4ed4ac21fda71a4b2231eff9a755b9dead0d0bf27404a27a5dbc10010653ffc	2017-12-12 02:13:31.888	138	2000	f	ad-hoc	\N	1	\N	\N	\N
2191	\\x4cf43208abb0f3ca767b1cc53b293df5d4af5019eaee0dc8b42c854871b2926d	2017-12-12 15:57:04.318	1172	2000	f	ad-hoc	\N	1	\N	\N	\N
2192	\\x4cf43208abb0f3ca767b1cc53b293df5d4af5019eaee0dc8b42c854871b2926d	2017-12-12 15:57:06.642	464	2000	f	ad-hoc	\N	1	\N	\N	\N
2193	\\x925d0cc3c4d3349e205f4f3566c16eda0d16d0a24d9e13c8a136cee8d5e6d5e6	2017-12-12 15:57:25.755	861	1	f	ad-hoc	\N	1	\N	\N	\N
2194	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 15:58:29.006	751	1	f	question	\N	1	53	\N	\N
2195	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 15:58:31.697	753	1	f	question	\N	1	53	\N	\N
2196	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 15:58:48.043	805	1	f	question	\N	1	53	\N	\N
2197	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-12 16:00:59.787	1157	2	f	embedded-question	\N	1	30	\N	\N
2198	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-12 16:00:59.291	1902	1	f	embedded-question	\N	1	35	\N	\N
2199	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-12 16:00:59.286	2228	56	f	embedded-question	\N	1	31	\N	\N
2200	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-12 16:01:01.235	398	1	f	embedded-question	\N	1	34	\N	\N
2201	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 16:00:59.719	1949	1	f	embedded-question	\N	1	53	\N	\N
2202	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-12 16:00:59.9	1922	56	f	embedded-question	\N	1	32	\N	\N
2203	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-12 16:00:59.94	2528	84	f	embedded-question	\N	1	33	\N	\N
2204	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 16:01:11.529	761	1	f	question	\N	1	53	\N	\N
2205	\\xd4ed4ac21fda71a4b2231eff9a755b9dead0d0bf27404a27a5dbc10010653ffc	2017-12-12 16:01:17.888	542	2000	f	ad-hoc	\N	1	\N	\N	\N
2206	\\x4137eca275677512e40c4067440bbda54abfe13438b361d223e8a468857534e0	2017-12-12 16:02:29.366	1331	1	f	ad-hoc	\N	1	\N	\N	\N
2207	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-12 16:02:55.395	428	1	f	embedded-question	\N	1	36	\N	\N
2208	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-12 16:02:55.697	2378	1	f	embedded-question	\N	1	44	\N	\N
2209	\\x717d5eb3ecbcf66e03cfdf86a5ed4c2f3d9782c07dc5d19da226844f18d8b124	2017-12-12 16:02:55.974	2565	6	f	embedded-question	\N	1	52	\N	\N
2210	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-12 16:02:55.676	3944	1	f	embedded-question	\N	1	37	\N	\N
2211	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-12 16:02:58.757	1511	2	f	embedded-question	\N	1	51	\N	\N
2215	\\xc346abd9fcf85f7d1e8a8c4fdb8708e47a185aa472f4fdf9f62814de5af77288	2017-12-12 16:03:40.702	1719	1	f	question	\N	1	54	\N	\N
2219	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-12 16:04:33.849	5724	267	f	embedded-question	\N	1	14	\N	\N
2220	\\x717d5eb3ecbcf66e03cfdf86a5ed4c2f3d9782c07dc5d19da226844f18d8b124	2017-12-12 16:04:37.4	2622	6	f	embedded-question	\N	1	52	\N	\N
2226	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-12 16:04:50.937	1696	2	f	embedded-question	\N	1	30	\N	\N
2227	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-12 16:04:50.624	2800	56	f	embedded-question	\N	1	31	\N	\N
2228	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 16:04:50.483	3323	1	f	embedded-question	\N	1	53	\N	\N
2229	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-12 16:04:50.698	3407	56	f	embedded-question	\N	1	32	\N	\N
2230	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-12 16:04:50.225	4315	84	f	embedded-question	\N	1	33	\N	\N
2239	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-12 16:05:05.107	2488	45	f	embedded-question	\N	1	15	\N	\N
2240	\\xc346abd9fcf85f7d1e8a8c4fdb8708e47a185aa472f4fdf9f62814de5af77288	2017-12-12 16:05:05.024	2783	1	f	embedded-question	\N	1	54	\N	\N
2244	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-12 16:05:09.165	3550	1	f	embedded-question	\N	1	37	\N	\N
2248	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-12 16:05:14.348	1544	1	f	embedded-question	\N	1	44	\N	\N
2251	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-12-12 16:05:15.917	798	263	f	embedded-question	\N	1	6	\N	\N
2252	\\x37cf77f673095db6a1e2cfd7f043a2a64f05eb17c9d788e89bd75de8d5f6645a	2017-12-12 16:05:16.587	751	434	f	embedded-question	\N	1	2	\N	\N
2254	\\x6211b1138bac14e5fa2bcfee231d2ef771cfbaf3c6f887897328190dd8ff31cb	2017-12-12 16:05:41.036	801	2000	f	ad-hoc	\N	1	\N	\N	\N
2255	\\x11e68b9a037ede3e1ad055c2177f5b6a91586af0720cdd9498eed3113be16777	2017-12-12 16:05:49.79	297	1	f	ad-hoc	\N	1	\N	\N	\N
2257	\\x7ed7a6af6a4f9fb06f599568fa7525c4e43cda3accec24b1fcf07f9781e1a3a1	2017-12-12 16:06:46.86	379	1	f	question	\N	1	55	\N	\N
2259	\\xabf202a64060a604c55904bba5c66eac4490ceebb207a3c8910a5daa9108d1d3	2017-12-12 16:08:05.502	108	1	f	question	\N	1	56	\N	\N
2267	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-12 16:09:12.863	215	1	f	embedded-question	\N	1	34	\N	\N
2212	\\x22857619da3be9a5770e9568affe76f0cd06255f213e2987407e4041c7b81978	2017-12-12 16:02:55.75	4649	166	f	embedded-question	\N	1	17	\N	\N
2213	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-12 16:02:55.851	4647	45	f	embedded-question	\N	1	15	\N	\N
2214	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-12 16:02:56.32	4689	267	f	embedded-question	\N	1	14	\N	\N
2216	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-12 16:04:33.438	245	1	f	embedded-question	\N	1	36	\N	\N
2221	\\xc346abd9fcf85f7d1e8a8c4fdb8708e47a185aa472f4fdf9f62814de5af77288	2017-12-12 16:04:34.309	5775	1	f	embedded-question	\N	1	54	\N	\N
2223	\\x22857619da3be9a5770e9568affe76f0cd06255f213e2987407e4041c7b81978	2017-12-12 16:04:34.432	5681	166	f	embedded-question	\N	1	17	\N	\N
2224	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-12 16:04:48.205	332	1	f	embedded-question	\N	1	34	\N	\N
2225	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-12 16:04:48.232	1212	1	f	embedded-question	\N	1	35	\N	\N
2231	\\x03ab7b55cad996e98ecdf6097c61c13ef3cb0189c01cc2e66b58a07fcff4fd2c	2017-12-12 16:05:00.707	56	1	f	embedded-question	\N	1	49	\N	\N
2245	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-12 16:05:08.366	4452	267	f	embedded-question	\N	1	14	\N	\N
2258	\\x1f5d7e115aa4704cb62d8b71c6d68d190a42ae068e86aca244ce85a8891f7f99	2017-12-12 16:07:38.796	179	1	f	ad-hoc	\N	1	\N	\N	\N
2269	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-12 16:09:15.308	1977	2	f	embedded-question	\N	1	30	\N	\N
2273	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-12 16:09:15.341	4525	84	f	embedded-question	\N	1	33	\N	\N
2217	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-12 16:04:34.61	2637	2	f	embedded-question	\N	1	51	\N	\N
2218	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-12 16:04:33.809	5152	1	f	embedded-question	\N	1	37	\N	\N
2222	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-12 16:04:34.354	5821	45	f	embedded-question	\N	1	15	\N	\N
2234	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-12-12 16:05:03.392	455	2	f	embedded-question	\N	1	12	\N	\N
2241	\\x717d5eb3ecbcf66e03cfdf86a5ed4c2f3d9782c07dc5d19da226844f18d8b124	2017-12-12 16:05:08.591	2165	6	f	embedded-question	\N	1	52	\N	\N
2242	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-12 16:05:08.852	1976	2	f	embedded-question	\N	1	51	\N	\N
2243	\\x22857619da3be9a5770e9568affe76f0cd06255f213e2987407e4041c7b81978	2017-12-12 16:05:07.578	3789	166	f	embedded-question	\N	1	17	\N	\N
2246	\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	2017-12-12 16:05:15.16	243	1	f	embedded-question	\N	1	45	\N	\N
2268	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-12 16:09:12.972	2006	56	f	embedded-question	\N	1	32	\N	\N
2232	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-12-12 16:05:03.083	297	163	f	embedded-question	\N	1	13	\N	\N
2233	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-12-12 16:05:03.198	623	56	f	embedded-question	\N	1	11	\N	\N
2235	\\x3673ca69aa1bccfd54ec76b12ad8eaa823899b44f9b755114635baba929aeb6d	2017-12-12 16:05:03.278	762	1	f	embedded-question	\N	1	50	\N	\N
2249	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-12 16:05:15.219	690	25	f	embedded-question	\N	1	7	\N	\N
2250	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-12 16:05:15.829	571	56	f	embedded-question	\N	1	4	\N	\N
2253	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-12 16:05:17.017	605	263	f	embedded-question	\N	1	3	\N	\N
2256	\\x11e68b9a037ede3e1ad055c2177f5b6a91586af0720cdd9498eed3113be16777	2017-12-12 16:05:54.179	306	1	f	ad-hoc	\N	1	\N	\N	\N
2260	\\x3673ca69aa1bccfd54ec76b12ad8eaa823899b44f9b755114635baba929aeb6d	2017-12-12 16:09:06.824	74	1	f	embedded-question	\N	1	50	\N	\N
2261	\\x03ab7b55cad996e98ecdf6097c61c13ef3cb0189c01cc2e66b58a07fcff4fd2c	2017-12-12 16:09:07.093	51	1	f	embedded-question	\N	1	49	\N	\N
2262	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-12-12 16:09:07.483	83	2	f	embedded-question	\N	1	12	\N	\N
2263	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-12-12 16:09:08.022	96	56	f	embedded-question	\N	1	11	\N	\N
2265	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-12-12 16:09:09.259	135	163	f	embedded-question	\N	1	13	\N	\N
2270	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 16:09:14.01	3284	1	f	embedded-question	\N	1	53	\N	\N
2271	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-12 16:09:15.232	2995	56	f	embedded-question	\N	1	31	\N	\N
2272	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-12 16:09:15.073	3457	1	f	embedded-question	\N	1	35	\N	\N
2236	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-12-12 16:05:03.553	574	256	f	embedded-question	\N	1	10	\N	\N
2237	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-12 16:05:03.403	1309	1	f	embedded-question	\N	1	44	\N	\N
2238	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-12 16:05:06.908	251	1	f	embedded-question	\N	1	36	\N	\N
2247	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-12 16:05:14.822	600	1	f	embedded-question	\N	1	46	\N	\N
2264	\\xabf202a64060a604c55904bba5c66eac4490ceebb207a3c8910a5daa9108d1d3	2017-12-12 16:09:08.72	137	1	f	embedded-question	\N	1	56	\N	\N
2266	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-12-12 16:09:11.37	95	256	f	embedded-question	\N	1	10	\N	\N
2274	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-12 18:15:23.29	3553	1	f	embedded-question	\N	1	36	\N	\N
2275	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-12 18:15:26.394	1409	0	f	embedded-question	\N	1	51	\N	\N
2276	\\x717d5eb3ecbcf66e03cfdf86a5ed4c2f3d9782c07dc5d19da226844f18d8b124	2017-12-12 18:15:23.954	4170	6	f	embedded-question	\N	1	52	\N	\N
2277	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-12 18:15:25.324	2959	1	f	embedded-question	\N	1	37	\N	\N
2278	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-12 18:15:24.659	4276	45	f	embedded-question	\N	1	15	\N	\N
2279	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-12 18:15:27.676	1603	173	f	embedded-question	\N	1	14	\N	\N
2280	\\xc346abd9fcf85f7d1e8a8c4fdb8708e47a185aa472f4fdf9f62814de5af77288	2017-12-12 18:15:27.488	1696	1	f	embedded-question	\N	1	54	\N	\N
2281	\\x22857619da3be9a5770e9568affe76f0cd06255f213e2987407e4041c7b81978	2017-12-12 18:15:28.322	1288	95	f	embedded-question	\N	1	17	\N	\N
2282	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 18:16:13.016	651	1	f	question	\N	1	53	\N	\N
2283	\\xc346abd9fcf85f7d1e8a8c4fdb8708e47a185aa472f4fdf9f62814de5af77288	2017-12-12 18:16:25.607	487	1	f	question	\N	1	54	\N	\N
2284	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-12 18:16:31.838	292	1	f	embedded-question	\N	1	34	\N	\N
2285	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 18:16:31.876	945	1	f	embedded-question	\N	1	53	\N	\N
2286	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-12 18:16:32.386	1427	2	f	embedded-question	\N	1	30	\N	\N
2287	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-12 18:16:32.508	2105	56	f	embedded-question	\N	1	31	\N	\N
2288	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-12 18:16:32.687	2189	84	f	embedded-question	\N	1	33	\N	\N
2289	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-12 18:16:32.466	2522	56	f	embedded-question	\N	1	32	\N	\N
2290	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-12 18:16:33.829	1263	1	f	embedded-question	\N	1	35	\N	\N
2291	\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	2017-12-12 18:16:39.026	575	1	f	embedded-question	\N	1	45	\N	\N
2292	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-12 18:16:38.609	1884	1	f	embedded-question	\N	1	46	\N	\N
2293	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-12 18:16:38.988	1710	263	f	embedded-question	\N	1	3	\N	\N
2294	\\x37cf77f673095db6a1e2cfd7f043a2a64f05eb17c9d788e89bd75de8d5f6645a	2017-12-12 18:16:38.571	2390	434	f	embedded-question	\N	1	2	\N	\N
2295	\\x7ed7a6af6a4f9fb06f599568fa7525c4e43cda3accec24b1fcf07f9781e1a3a1	2017-12-12 18:16:39.39	1877	1	f	embedded-question	\N	1	55	\N	\N
2296	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-12 18:16:38.935	2383	56	f	embedded-question	\N	1	4	\N	\N
2297	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-12 18:16:39.828	1539	25	f	embedded-question	\N	1	7	\N	\N
2298	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-12-12 18:16:40.578	1246	263	f	embedded-question	\N	1	6	\N	\N
2299	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-12 18:16:45.749	463	1	f	embedded-question	\N	1	37	\N	\N
2300	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-12 18:16:47.616	248	1	f	embedded-question	\N	1	36	\N	\N
2301	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-12 18:16:47.8	378	0	f	embedded-question	\N	1	51	\N	\N
2302	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-12 18:16:47.734	1080	45	f	embedded-question	\N	1	15	\N	\N
2303	\\x717d5eb3ecbcf66e03cfdf86a5ed4c2f3d9782c07dc5d19da226844f18d8b124	2017-12-12 18:16:48.003	982	6	f	embedded-question	\N	1	52	\N	\N
2304	\\xc346abd9fcf85f7d1e8a8c4fdb8708e47a185aa472f4fdf9f62814de5af77288	2017-12-12 18:16:47.869	1446	1	f	embedded-question	\N	1	54	\N	\N
2305	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-12 18:16:47.769	1669	187	f	embedded-question	\N	1	14	\N	\N
2306	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-12 18:16:49.405	174	1	f	embedded-question	\N	1	34	\N	\N
2307	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-12 18:16:49.925	475	2	f	embedded-question	\N	1	30	\N	\N
2308	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-12 18:16:50.087	699	56	f	embedded-question	\N	1	31	\N	\N
2309	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-12 18:16:51.459	1263	1	f	embedded-question	\N	1	35	\N	\N
2310	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 18:16:51.508	1559	1	f	embedded-question	\N	1	53	\N	\N
2311	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-12 18:16:51.762	1486	84	f	embedded-question	\N	1	33	\N	\N
2312	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-12 18:16:51.835	1418	56	f	embedded-question	\N	1	32	\N	\N
2313	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-12 18:17:16.192	67	1	f	question	\N	1	34	\N	\N
2314	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-12 18:17:26.526	731	1	f	question	\N	1	35	\N	\N
2315	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-12 18:17:48.282	178	1	f	embedded-question	\N	1	34	\N	\N
2316	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-12 18:17:48.719	1162	2	f	embedded-question	\N	1	30	\N	\N
2317	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-12 18:17:48.718	2120	1	f	embedded-question	\N	1	35	\N	\N
2318	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-12 18:17:49.378	2172	56	f	embedded-question	\N	1	31	\N	\N
2319	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-12 18:17:49.185	2458	56	f	embedded-question	\N	1	32	\N	\N
2320	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 18:17:51.082	1411	1	f	embedded-question	\N	1	53	\N	\N
2321	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-12 18:17:50.187	2437	84	f	embedded-question	\N	1	33	\N	\N
2322	\\xc346abd9fcf85f7d1e8a8c4fdb8708e47a185aa472f4fdf9f62814de5af77288	2017-12-12 18:17:57.253	539	1	f	question	\N	1	54	\N	\N
2323	\\x22857619da3be9a5770e9568affe76f0cd06255f213e2987407e4041c7b81978	2017-12-12 18:18:04.406	573	166	f	embedded-question	\N	1	17	\N	\N
2324	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-12 18:18:05.118	248	2	f	embedded-question	\N	1	51	\N	\N
2325	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-12 18:18:05.224	197	1	f	embedded-question	\N	1	36	\N	\N
2326	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-12 18:18:05.683	487	1	f	embedded-question	\N	1	37	\N	\N
2327	\\xc346abd9fcf85f7d1e8a8c4fdb8708e47a185aa472f4fdf9f62814de5af77288	2017-12-12 18:18:06.852	612	1	f	embedded-question	\N	1	54	\N	\N
2328	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-12 18:18:07.499	945	267	f	embedded-question	\N	1	14	\N	\N
2329	\\x717d5eb3ecbcf66e03cfdf86a5ed4c2f3d9782c07dc5d19da226844f18d8b124	2017-12-12 18:18:08.024	801	6	f	embedded-question	\N	1	52	\N	\N
2330	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-12 18:18:08.527	555	45	f	embedded-question	\N	1	15	\N	\N
2331	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-12 18:18:11.205	619	1	f	embedded-question	\N	1	46	\N	\N
2332	\\x37cf77f673095db6a1e2cfd7f043a2a64f05eb17c9d788e89bd75de8d5f6645a	2017-12-12 18:18:12.379	680	434	f	embedded-question	\N	1	2	\N	\N
2333	\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	2017-12-12 18:18:13.683	226	1	f	embedded-question	\N	1	45	\N	\N
2334	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-12 18:18:13.502	757	56	f	embedded-question	\N	1	4	\N	\N
2335	\\x7ed7a6af6a4f9fb06f599568fa7525c4e43cda3accec24b1fcf07f9781e1a3a1	2017-12-12 18:18:13.753	802	1	f	embedded-question	\N	1	55	\N	\N
2336	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-12 18:18:15.133	169	1	f	embedded-question	\N	1	34	\N	\N
2337	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-12 18:18:15.449	743	56	f	embedded-question	\N	1	31	\N	\N
2338	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-12 18:18:17.44	1543	2	f	embedded-question	\N	1	30	\N	\N
2339	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-12 18:18:17.972	2053	1	f	embedded-question	\N	1	35	\N	\N
2340	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 18:18:17.528	2607	1	f	embedded-question	\N	1	53	\N	\N
2341	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-12 18:18:17.534	2730	56	f	embedded-question	\N	1	32	\N	\N
2342	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-12 18:18:18.239	2483	84	f	embedded-question	\N	1	33	\N	\N
2399	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-12 18:35:48.754	1494	1	f	embedded-dashboard	\N	1	34	3	\N
2403	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-12 18:35:48.791	14063	1	f	embedded-dashboard	\N	1	35	3	\N
2409	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-12 18:36:21.259	15751	56	f	embedded-question	\N	1	31	\N	\N
2410	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-12 18:36:21.584	16888	1	f	embedded-dashboard	\N	1	35	3	\N
2411	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 18:36:23.673	18165	1	f	embedded-dashboard	\N	1	53	3	\N
2412	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-12 18:36:21.343	20701	56	f	embedded-question	\N	1	32	\N	\N
2430	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-12 18:39:31.397	14813	56	f	embedded-question	\N	1	32	\N	\N
2432	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-12 18:39:34.876	12551	56	f	embedded-question	\N	1	31	\N	\N
2433	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-12 18:39:36.419	14238	84	f	embedded-question	\N	1	33	\N	\N
2434	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-12 18:39:55.667	2259	1	f	embedded-dashboard	\N	1	34	3	\N
2435	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-12 18:39:55.481	10405	2	f	embedded-question	\N	1	30	\N	\N
2436	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-12 18:40:04.352	3139	1	f	embedded-dashboard	\N	1	34	3	\N
2440	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-12 18:39:58.045	26589	56	f	embedded-question	\N	1	31	\N	\N
2441	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-12 18:39:55.771	29151	56	f	embedded-question	\N	1	32	\N	\N
2444	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 18:40:04.455	24668	1	f	embedded-dashboard	\N	1	53	3	\N
2446	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-12 18:39:55.692	35579	84	f	embedded-question	\N	1	33	\N	\N
2343	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-12 18:18:28.031	742	56	f	question	\N	1	31	\N	\N
2351	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-12 18:22:18.746	2697	2	f	embedded-question	\N	1	30	\N	\N
2353	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 18:22:17.658	4358	1	f	embedded-dashboard	\N	1	53	3	\N
2355	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-12 18:22:18.995	3728	56	f	embedded-question	\N	1	32	\N	\N
2356	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-12 18:22:21.837	3070	84	f	embedded-question	\N	1	33	\N	\N
2364	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-12 18:28:12.055	939	1	f	embedded-dashboard	\N	1	34	3	\N
2365	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-12 18:28:12.247	3875	2	f	embedded-question	\N	1	30	\N	\N
2367	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-12 18:28:11.295	5996	56	f	embedded-question	\N	1	31	\N	\N
2368	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 18:28:12.118	6633	1	f	embedded-dashboard	\N	1	53	3	\N
2376	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 18:29:20.478	7760	1	f	embedded-dashboard	\N	1	53	3	\N
2377	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-12 18:29:18.88	10603	84	f	embedded-question	\N	1	33	\N	\N
2378	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-12 18:33:38.749	1607	1	f	embedded-dashboard	\N	1	34	3	\N
2382	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 18:33:40.469	10912	1	f	embedded-dashboard	\N	1	53	3	\N
2383	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-12 18:33:38.455	13189	56	f	embedded-question	\N	1	32	\N	\N
2384	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-12 18:33:38.848	14340	84	f	embedded-question	\N	1	33	\N	\N
2462	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-12 18:43:00.144	2138	1	f	embedded-question	\N	1	46	\N	\N
2463	\\x7ed7a6af6a4f9fb06f599568fa7525c4e43cda3accec24b1fcf07f9781e1a3a1	2017-12-12 18:43:00.084	2844	1	f	embedded-question	\N	1	55	\N	\N
2464	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-12 18:43:00.128	2877	56	f	embedded-question	\N	1	4	\N	\N
2476	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-12 18:44:32.983	484	2	f	embedded-question	\N	1	51	\N	\N
2480	\\x22857619da3be9a5770e9568affe76f0cd06255f213e2987407e4041c7b81978	2017-12-12 18:44:34.677	6812	166	f	embedded-question	\N	1	17	\N	\N
2511	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-12 18:46:55.759	1145	1	f	embedded-dashboard	\N	1	46	5	\N
2513	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-12 18:46:55.987	941	56	f	embedded-question	\N	1	4	\N	\N
2517	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-12-12 18:47:08.087	104	56	f	embedded-question	\N	1	11	\N	\N
2521	\\xabf202a64060a604c55904bba5c66eac4490ceebb207a3c8910a5daa9108d1d3	2017-12-12 18:47:09.42	56	1	f	embedded-question	\N	1	56	\N	\N
2525	\\x7ed7a6af6a4f9fb06f599568fa7525c4e43cda3accec24b1fcf07f9781e1a3a1	2017-12-12 18:47:10.713	432	1	f	question	\N	1	55	\N	\N
2529	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-12-12 18:48:27.118	70	2	f	embedded-question	\N	1	12	\N	\N
2536	\\x8f34e1a8509769dd9f759c926a8a7e9492491ac784b1e7218e221ae8707522b5	2017-12-12 18:48:46.658	24	1	f	embedded-question	\N	1	47	\N	\N
2538	\\x16f264b4f2051e7b92cd622b1ad1bb9c18ac323fe6b987b14633924632a8343b	2017-12-12 18:48:47.051	51	2	f	embedded-question	\N	1	22	\N	\N
2539	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-12-12 18:48:47.469	91	51	f	embedded-question	\N	1	24	\N	\N
2545	\\xabf202a64060a604c55904bba5c66eac4490ceebb207a3c8910a5daa9108d1d3	2017-12-12 18:49:06.097	98	1	f	question	\N	1	56	\N	\N
2549	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-12 18:49:56.366	1034	1	f	question	\N	1	43	\N	\N
2344	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 18:18:37.104	778	1	f	question	\N	1	53	\N	\N
2345	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-12 18:20:50.744	1467	56	f	embedded-question	\N	1	32	\N	\N
2358	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-12 18:25:21.162	3071	2	f	embedded-question	\N	1	30	\N	\N
2385	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-12 18:34:34.425	1201	1	f	embedded-dashboard	\N	1	34	3	\N
2387	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-12 18:34:34.397	9685	1	f	embedded-dashboard	\N	1	35	3	\N
2388	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 18:34:34.417	10355	1	f	embedded-dashboard	\N	1	53	3	\N
2389	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-12 18:34:36.202	9236	56	f	embedded-question	\N	1	31	\N	\N
2390	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-12 18:34:35.957	9605	56	f	embedded-question	\N	1	32	\N	\N
2391	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-12 18:34:36.088	11079	84	f	embedded-question	\N	1	33	\N	\N
2393	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-12 18:34:51.887	11668	56	f	embedded-question	\N	1	32	\N	\N
2395	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-12 18:34:52.993	11835	1	f	embedded-dashboard	\N	1	35	3	\N
2407	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-12 18:36:21.283	7088	2	f	embedded-question	\N	1	30	\N	\N
2408	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-12 18:36:33.527	3135	1	f	embedded-dashboard	\N	1	34	3	\N
2413	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-12 18:36:34.297	10501	2	f	embedded-question	\N	1	30	\N	\N
2414	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-12 18:36:21.344	25816	84	f	embedded-question	\N	1	33	\N	\N
2415	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-12 18:36:34.909	15384	56	f	embedded-question	\N	1	31	\N	\N
2416	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 18:36:33.623	17388	1	f	embedded-dashboard	\N	1	53	3	\N
2421	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-12 18:37:49.35	7217	2	f	embedded-question	\N	1	30	\N	\N
2424	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 18:37:49.323	12458	1	f	embedded-dashboard	\N	1	53	3	\N
2425	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-12 18:37:51.175	10956	56	f	embedded-question	\N	1	31	\N	\N
2426	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-12 18:37:47.716	16037	84	f	embedded-question	\N	1	33	\N	\N
2449	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-12 18:40:32.31	10112	2	f	embedded-question	\N	1	30	\N	\N
2452	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-12 18:40:32.139	16414	1	f	embedded-dashboard	\N	1	35	3	\N
2453	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-12 18:40:33.375	16314	56	f	embedded-question	\N	1	32	\N	\N
2454	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-12 18:40:34.476	18072	84	f	embedded-question	\N	1	33	\N	\N
2346	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-12 18:20:52.309	1668	263	f	embedded-question	\N	1	3	\N	\N
2348	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-12 18:20:52.266	2357	56	f	embedded-question	\N	1	31	\N	\N
2349	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-12 18:20:52.332	3394	84	f	embedded-question	\N	1	33	\N	\N
2357	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-12 18:25:21.052	615	1	f	embedded-dashboard	\N	1	34	3	\N
2359	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-12 18:25:21.31	5148	56	f	embedded-question	\N	1	31	\N	\N
2360	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 18:25:21.2	5590	1	f	embedded-dashboard	\N	1	53	3	\N
2361	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-12 18:25:21.071	5850	1	f	embedded-dashboard	\N	1	35	3	\N
2362	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-12 18:25:21.236	5877	56	f	embedded-question	\N	1	32	\N	\N
2363	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-12 18:25:21.735	6328	84	f	embedded-question	\N	1	33	\N	\N
2386	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-12 18:34:34.465	6189	2	f	embedded-question	\N	1	30	\N	\N
2400	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-12 18:35:50.55	7625	2	f	embedded-question	\N	1	30	\N	\N
2401	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 18:35:48.857	13309	1	f	embedded-dashboard	\N	1	53	3	\N
2402	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-12 18:35:48.933	13848	56	f	embedded-question	\N	1	31	\N	\N
2404	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-12 18:35:49.671	14703	56	f	embedded-question	\N	1	32	\N	\N
2405	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-12 18:35:52.04	15008	84	f	embedded-question	\N	1	33	\N	\N
2406	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-12 18:36:21.555	2025	1	f	embedded-dashboard	\N	1	34	3	\N
2417	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-12 18:36:33.565	17499	1	f	embedded-dashboard	\N	1	35	3	\N
2418	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-12 18:36:35.991	15752	56	f	embedded-question	\N	1	32	\N	\N
2419	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-12 18:36:37.101	17180	84	f	embedded-question	\N	1	33	\N	\N
2420	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-12 18:37:49.265	1707	1	f	embedded-dashboard	\N	1	34	3	\N
2422	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-12 18:37:46.997	11482	56	f	embedded-question	\N	1	32	\N	\N
2423	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-12 18:37:49.316	12420	1	f	embedded-dashboard	\N	1	35	3	\N
2428	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-12 18:39:35.092	8795	2	f	embedded-question	\N	1	30	\N	\N
2429	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-12 18:39:31.978	13285	1	f	embedded-dashboard	\N	1	35	3	\N
2437	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-12 18:40:01.774	14058	2	f	embedded-question	\N	1	30	\N	\N
2438	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 18:39:55.724	25747	1	f	embedded-dashboard	\N	1	53	3	\N
2439	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-12 18:39:55.654	27143	1	f	embedded-dashboard	\N	1	35	3	\N
2442	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-12 18:40:04.125	24066	56	f	embedded-question	\N	1	31	\N	\N
2443	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-12 18:40:04.353	24651	1	f	embedded-dashboard	\N	1	35	3	\N
2445	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-12 18:40:05.058	25895	56	f	embedded-question	\N	1	32	\N	\N
2459	\\xc346abd9fcf85f7d1e8a8c4fdb8708e47a185aa472f4fdf9f62814de5af77288	2017-12-12 18:42:48.008	3317	1	f	question	\N	1	54	\N	\N
2460	\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	2017-12-12 18:43:00.048	182	1	f	embedded-question	\N	1	45	\N	\N
2466	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-12 18:43:00.146	3128	263	f	embedded-question	\N	1	3	\N	\N
2467	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-12-12 18:43:00.433	2958	263	f	embedded-question	\N	1	6	\N	\N
2468	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-12 18:43:01.674	1880	2	f	embedded-question	\N	1	51	\N	\N
2470	\\x717d5eb3ecbcf66e03cfdf86a5ed4c2f3d9782c07dc5d19da226844f18d8b124	2017-12-12 18:43:03.743	6060	6	f	embedded-question	\N	1	52	\N	\N
2472	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-12 18:43:03.842	12382	45	f	embedded-question	\N	1	15	\N	\N
2473	\\xc346abd9fcf85f7d1e8a8c4fdb8708e47a185aa472f4fdf9f62814de5af77288	2017-12-12 18:43:06.053	11826	1	f	embedded-question	\N	1	54	\N	\N
2474	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-12 18:43:05.878	12527	1	f	embedded-question	\N	1	37	\N	\N
2475	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-12 18:43:05.989	12758	267	f	embedded-question	\N	1	14	\N	\N
2484	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-12 18:44:56.718	1678	1	f	embedded-dashboard	\N	1	36	4	\N
2533	\\xabf202a64060a604c55904bba5c66eac4490ceebb207a3c8910a5daa9108d1d3	2017-12-12 18:48:27.322	178	1	f	embedded-dashboard	\N	1	56	6	\N
2540	\\x4cdd58ce635e28e4c4632ebf3524af71e4ea32d396bb6fedc1bd717999a95297	2017-12-12 18:48:47.515	60	10	f	embedded-question	\N	1	42	\N	\N
2347	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-12 18:20:52.369	1628	2	f	embedded-question	\N	1	30	\N	\N
2350	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-12 18:22:17.552	421	1	f	embedded-dashboard	\N	1	34	3	\N
2352	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-12 18:22:17.683	4190	56	f	embedded-question	\N	1	31	\N	\N
2354	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-12 18:22:17.567	4451	1	f	embedded-dashboard	\N	1	35	3	\N
2371	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-12 18:29:19.26	1149	1	f	embedded-dashboard	\N	1	34	3	\N
2372	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-12 18:29:18.783	4835	2	f	embedded-question	\N	1	30	\N	\N
2373	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-12 18:29:18.857	8004	56	f	embedded-question	\N	1	31	\N	\N
2374	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-12 18:29:19.274	7911	1	f	embedded-dashboard	\N	1	35	3	\N
2375	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-12 18:29:18.815	9125	56	f	embedded-question	\N	1	32	\N	\N
2486	\\x22857619da3be9a5770e9568affe76f0cd06255f213e2987407e4041c7b81978	2017-12-12 18:44:49.632	10386	166	f	embedded-question	\N	1	17	\N	\N
2488	\\x717d5eb3ecbcf66e03cfdf86a5ed4c2f3d9782c07dc5d19da226844f18d8b124	2017-12-12 18:45:00.179	7473	6	f	embedded-question	\N	1	52	\N	\N
2489	\\x22857619da3be9a5770e9568affe76f0cd06255f213e2987407e4041c7b81978	2017-12-12 18:44:58.736	10975	166	f	embedded-question	\N	1	17	\N	\N
2490	\\xc346abd9fcf85f7d1e8a8c4fdb8708e47a185aa472f4fdf9f62814de5af77288	2017-12-12 18:44:56.76	13200	1	f	embedded-dashboard	\N	1	54	4	\N
2492	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-12 18:45:02.495	9288	45	f	embedded-question	\N	1	15	\N	\N
2493	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-12 18:44:58.817	12990	267	f	embedded-question	\N	1	14	\N	\N
2495	\\x37cf77f673095db6a1e2cfd7f043a2a64f05eb17c9d788e89bd75de8d5f6645a	2017-12-12 18:45:20.022	903	434	f	embedded-question	\N	1	2	\N	\N
2498	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-12 18:45:22.47	2112	25	f	embedded-question	\N	1	7	\N	\N
2507	\\x7ed7a6af6a4f9fb06f599568fa7525c4e43cda3accec24b1fcf07f9781e1a3a1	2017-12-12 18:46:05.807	430	1	f	question	\N	1	55	\N	\N
2508	\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	2017-12-12 18:46:55.744	131	1	f	embedded-dashboard	\N	1	45	5	\N
2519	\\x3673ca69aa1bccfd54ec76b12ad8eaa823899b44f9b755114635baba929aeb6d	2017-12-12 18:47:08.035	182	1	f	embedded-question	\N	1	50	\N	\N
2522	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-12-12 18:47:09.518	87	163	f	embedded-question	\N	1	13	\N	\N
2526	\\x03ab7b55cad996e98ecdf6097c61c13ef3cb0189c01cc2e66b58a07fcff4fd2c	2017-12-12 18:47:34.154	21	1	f	question	\N	1	49	\N	\N
2527	\\x3673ca69aa1bccfd54ec76b12ad8eaa823899b44f9b755114635baba929aeb6d	2017-12-12 18:47:41.324	58	1	f	question	\N	1	50	\N	\N
2528	\\xabf202a64060a604c55904bba5c66eac4490ceebb207a3c8910a5daa9108d1d3	2017-12-12 18:47:47.79	45	1	f	question	\N	1	56	\N	\N
2531	\\x03ab7b55cad996e98ecdf6097c61c13ef3cb0189c01cc2e66b58a07fcff4fd2c	2017-12-12 18:48:27.292	60	1	f	embedded-dashboard	\N	1	49	6	\N
2541	\\x09ec3782572f315a26db4edbfeeb5929449aa44c1ee7632972ec3e9c66d651df	2017-12-12 18:48:47.615	93	45	f	embedded-question	\N	1	41	\N	\N
2542	\\xbcffe78744ab2241567e650bea687f68c7215ac8fd15891bc444ec2e4284317a	2017-12-12 18:48:47.663	65	3	f	embedded-question	\N	1	20	\N	\N
2544	\\x03ab7b55cad996e98ecdf6097c61c13ef3cb0189c01cc2e66b58a07fcff4fd2c	2017-12-12 18:49:06.083	61	1	f	question	\N	1	49	\N	\N
2547	\\x8f34e1a8509769dd9f759c926a8a7e9492491ac784b1e7218e221ae8707522b5	2017-12-12 18:49:32.782	28	1	f	question	\N	1	47	\N	\N
2548	\\x8ca1483aa78081de6c3e2ebe04e1af174c842edde39e7db8cf04a093acf31d44	2017-12-12 18:49:37.186	59	1	f	question	\N	1	23	\N	\N
2550	\\x8f34e1a8509769dd9f759c926a8a7e9492491ac784b1e7218e221ae8707522b5	2017-12-12 18:50:41.269	49	1	f	question	\N	1	47	\N	\N
2551	\\x8ca1483aa78081de6c3e2ebe04e1af174c842edde39e7db8cf04a093acf31d44	2017-12-12 18:50:41.291	103	1	f	question	\N	1	23	\N	\N
2552	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-12 18:50:41.267	993	1	f	question	\N	1	43	\N	\N
2366	\\x02b34ab6008ed80c585c93a66a103907901a6c9c688d3830dc65416cfc07d8da	2017-12-12 18:28:10.439	5941	56	f	embedded-question	\N	1	32	\N	\N
2369	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-12 18:28:12.068	6706	1	f	embedded-dashboard	\N	1	35	3	\N
2370	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-12 18:28:13.396	6715	84	f	embedded-question	\N	1	33	\N	\N
2379	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-12 18:33:38.457	6198	2	f	embedded-question	\N	1	30	\N	\N
2380	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-12 18:33:38.548	11436	56	f	embedded-question	\N	1	31	\N	\N
2381	\\xd93fcc390be5ce0cb05bd30c60c9f95564b14c18276ca2895e36fbbf88f2029c	2017-12-12 18:33:38.778	12434	1	f	embedded-dashboard	\N	1	35	3	\N
2392	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-12 18:34:52.871	1460	1	f	embedded-dashboard	\N	1	34	3	\N
2394	\\xc616341ce03d97f0e16ea98266381eb95de70597be7e0cfcb58e2eb3e2264ba8	2017-12-12 18:34:57.289	7141	2	f	embedded-question	\N	1	30	\N	\N
2396	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-12 18:34:53.653	11367	56	f	embedded-question	\N	1	31	\N	\N
2397	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 18:34:52.986	12133	1	f	embedded-dashboard	\N	1	53	3	\N
2398	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-12 18:34:56.756	12315	84	f	embedded-question	\N	1	33	\N	\N
2427	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-12 18:39:31.983	1226	1	f	embedded-dashboard	\N	1	34	3	\N
2431	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 18:39:32.342	13878	1	f	embedded-dashboard	\N	1	53	3	\N
2447	\\x827190b604dc95c8b13586f78f1058bd10f7039a971419065c4901533e547af6	2017-12-12 18:40:32.122	2294	1	f	embedded-dashboard	\N	1	34	3	\N
2448	\\x560b9e1382970bf3749c151ace92279caecd7522dc40935e3828a7b587df470d	2017-12-12 18:40:07.697	32510	84	f	embedded-question	\N	1	33	\N	\N
2450	\\x67c998d4fe35418d7b06d8bad7f654bdb468d172eef3f64d5d594c6a52899bf9	2017-12-12 18:40:31.786	15347	56	f	embedded-question	\N	1	31	\N	\N
2451	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 18:40:32.166	16214	1	f	embedded-dashboard	\N	1	53	3	\N
2455	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-12 18:41:52.544	2483	1	f	question	\N	1	37	\N	\N
2456	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-12 18:42:04.373	347	1	f	question	\N	1	36	\N	\N
2457	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 18:42:16.161	2851	1	f	question	\N	1	53	\N	\N
2458	\\x6278edbf55c85a421dfa4291f733bcdc78060a2d6727d2369628b239189b5a0e	2017-12-12 18:42:30.693	3508	1	f	question	\N	1	53	\N	\N
2461	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-12 18:43:00.434	1704	25	f	embedded-question	\N	1	7	\N	\N
2465	\\x37cf77f673095db6a1e2cfd7f043a2a64f05eb17c9d788e89bd75de8d5f6645a	2017-12-12 18:43:00.085	3039	434	f	embedded-question	\N	1	2	\N	\N
2469	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-12 18:43:04.266	1711	1	f	embedded-question	\N	1	36	\N	\N
2471	\\x22857619da3be9a5770e9568affe76f0cd06255f213e2987407e4041c7b81978	2017-12-12 18:43:04.058	11848	166	f	embedded-question	\N	1	17	\N	\N
2477	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-12 18:44:33.625	5518	45	f	embedded-question	\N	1	15	\N	\N
2478	\\x717d5eb3ecbcf66e03cfdf86a5ed4c2f3d9782c07dc5d19da226844f18d8b124	2017-12-12 18:44:35.16	4361	6	f	embedded-question	\N	1	52	\N	\N
2479	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-12 18:44:34.203	7067	267	f	embedded-question	\N	1	14	\N	\N
2481	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-12 18:44:49.783	711	2	f	embedded-question	\N	1	51	\N	\N
2482	\\x717d5eb3ecbcf66e03cfdf86a5ed4c2f3d9782c07dc5d19da226844f18d8b124	2017-12-12 18:44:49.85	6413	6	f	embedded-question	\N	1	52	\N	\N
2483	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-12 18:44:47.661	8732	45	f	embedded-question	\N	1	15	\N	\N
2494	\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	2017-12-12 18:45:19.966	180	1	f	embedded-question	\N	1	45	\N	\N
2496	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-12 18:45:21.544	1795	1	f	question	\N	1	36	\N	\N
2497	\\x7ed7a6af6a4f9fb06f599568fa7525c4e43cda3accec24b1fcf07f9781e1a3a1	2017-12-12 18:45:22.333	1816	1	f	embedded-question	\N	1	55	\N	\N
2500	\\x4cfc0f3aba83879afa3fb20ba5aabca28ec7ba35b2bc8fe6e8ff0e2582f3f573	2017-12-12 18:45:22.555	2144	56	f	embedded-question	\N	1	4	\N	\N
2501	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-12 18:45:23.436	2303	263	f	embedded-question	\N	1	3	\N	\N
2503	\\xc346abd9fcf85f7d1e8a8c4fdb8708e47a185aa472f4fdf9f62814de5af77288	2017-12-12 18:45:21.53	9326	1	f	question	\N	1	54	\N	\N
2506	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-12 18:45:57.867	503	1	f	question	\N	1	46	\N	\N
2509	\\x30d5cd2ae52aa932dd01cf0a8b144ca6469c1714b168f1ab868b6246fd095160	2017-12-12 18:46:55.932	794	25	f	embedded-question	\N	1	7	\N	\N
2514	\\x65fe9cf1da7aaf90a3dd358297d79c556be7156c7ac0174657ef700ea21da541	2017-12-12 18:46:55.85	1075	263	f	embedded-question	\N	1	3	\N	\N
2515	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-12-12 18:46:57.268	384	263	f	embedded-question	\N	1	6	\N	\N
2516	\\x03ab7b55cad996e98ecdf6097c61c13ef3cb0189c01cc2e66b58a07fcff4fd2c	2017-12-12 18:47:08.034	60	1	f	embedded-question	\N	1	49	\N	\N
2518	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-12-12 18:47:08.076	131	256	f	embedded-question	\N	1	10	\N	\N
2532	\\x3673ca69aa1bccfd54ec76b12ad8eaa823899b44f9b755114635baba929aeb6d	2017-12-12 18:48:27.303	144	1	f	embedded-dashboard	\N	1	50	6	\N
2534	\\x8a1dcf913cda4cb2f21665257a78abbd1f52e229ef053d55244f420e0488c323	2017-12-12 18:48:27.347	186	256	f	embedded-question	\N	1	10	\N	\N
2535	\\x1ad74b7dab76724abdf6aa334aebb1c63719b1b1859e689ff8ec5373ab000a74	2017-12-12 18:48:27.366	195	56	f	embedded-question	\N	1	11	\N	\N
2537	\\x8ca1483aa78081de6c3e2ebe04e1af174c842edde39e7db8cf04a093acf31d44	2017-12-12 18:48:46.658	48	1	f	embedded-question	\N	1	23	\N	\N
2543	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-12 18:48:48.292	823	1	f	embedded-question	\N	1	44	\N	\N
2546	\\x3673ca69aa1bccfd54ec76b12ad8eaa823899b44f9b755114635baba929aeb6d	2017-12-12 18:49:06.085	123	1	f	question	\N	1	50	\N	\N
2485	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-12 18:44:47.58	11501	267	f	embedded-question	\N	1	14	\N	\N
2487	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-12 18:45:00.684	1648	2	f	embedded-question	\N	1	51	\N	\N
2491	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-12 18:44:56.748	13390	1	f	embedded-dashboard	\N	1	37	4	\N
2499	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-12 18:45:22.396	2294	1	f	embedded-question	\N	1	46	\N	\N
2502	\\xddac82b8edf7a3ecc158e33fc5675fd7a7191897d046e10d79efb07a74319e88	2017-12-12 18:45:23.498	2345	263	f	embedded-question	\N	1	6	\N	\N
2504	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-12 18:45:21.581	9508	1	f	question	\N	1	37	\N	\N
2505	\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	2017-12-12 18:45:50.71	92	1	f	question	\N	1	45	\N	\N
2510	\\x7ed7a6af6a4f9fb06f599568fa7525c4e43cda3accec24b1fcf07f9781e1a3a1	2017-12-12 18:46:55.81	1030	1	f	embedded-dashboard	\N	1	55	5	\N
2512	\\x37cf77f673095db6a1e2cfd7f043a2a64f05eb17c9d788e89bd75de8d5f6645a	2017-12-12 18:46:55.867	1036	434	f	embedded-question	\N	1	2	\N	\N
2520	\\xb0df0f3242598982a2775840afaade9293af5137aced4d204b00cbf25db7c5fb	2017-12-12 18:47:09.46	57	2	f	embedded-question	\N	1	12	\N	\N
2523	\\xbfe33a7ca0e67223f7beaaa024ef5541245f1300bd107966ac0107edfc031f7d	2017-12-12 18:47:10.715	124	1	f	question	\N	1	45	\N	\N
2524	\\xcfc7d56b6fc02c4d76b9401676edec767aeedb90997bfe025bb92fc7bd0014b0	2017-12-12 18:47:10.718	412	1	f	question	\N	1	46	\N	\N
2530	\\x358152939dc5d6414047c3dd1ab7d51fbe2d5369f7100369ece7ea8ec975fa84	2017-12-12 18:48:27.102	108	163	f	embedded-question	\N	1	13	\N	\N
2553	\\x03ab7b55cad996e98ecdf6097c61c13ef3cb0189c01cc2e66b58a07fcff4fd2c	2017-12-12 18:51:31.269	41	1	f	embedded-dashboard	\N	1	49	6	\N
2554	\\xabf202a64060a604c55904bba5c66eac4490ceebb207a3c8910a5daa9108d1d3	2017-12-12 18:51:31.299	56	1	f	embedded-dashboard	\N	1	56	6	\N
2555	\\x3673ca69aa1bccfd54ec76b12ad8eaa823899b44f9b755114635baba929aeb6d	2017-12-12 18:51:31.28	92	1	f	embedded-dashboard	\N	1	50	6	\N
2556	\\xbcffe78744ab2241567e650bea687f68c7215ac8fd15891bc444ec2e4284317a	2017-12-12 18:51:31.638	44	3	f	embedded-question	\N	1	20	\N	\N
2557	\\x16f264b4f2051e7b92cd622b1ad1bb9c18ac323fe6b987b14633924632a8343b	2017-12-12 18:51:31.912	37	2	f	embedded-question	\N	1	22	\N	\N
2558	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-12-12 18:51:32.226	73	51	f	embedded-question	\N	1	24	\N	\N
2559	\\x09ec3782572f315a26db4edbfeeb5929449aa44c1ee7632972ec3e9c66d651df	2017-12-12 18:51:32.602	41	45	f	embedded-question	\N	1	41	\N	\N
2560	\\x4cdd58ce635e28e4c4632ebf3524af71e4ea32d396bb6fedc1bd717999a95297	2017-12-12 18:51:32.898	37	10	f	embedded-question	\N	1	42	\N	\N
2561	\\x2df1c1b99dab5d6c0df61c40a4bc206c6dfad0aa9bb3abebb778075cb7301608	2017-12-12 18:51:35.219	94	1	f	embedded-question	\N	1	38	\N	\N
2562	\\xb01ab430a97f00647f2ea6776c5224260a950c9bdd337897bfbf26a5ee89aa9b	2017-12-12 18:51:35.244	149	1	f	embedded-question	\N	1	39	\N	\N
2563	\\x6c4e31712c119cf7a66b289f88ff5f98a2fd6f85b950a8d1ba162468c2c67b24	2017-12-12 18:51:35.347	104	10	f	embedded-question	\N	1	27	\N	\N
2564	\\x08fb682e6462441c203ded87d8fd61c85b379b279309ba2c3baedbec1e3a432c	2017-12-12 18:51:35.268	184	7	f	embedded-question	\N	1	26	\N	\N
2565	\\xe70291818d87d3dce40668f3feb8dabcbdfd8288676c4aed01571e4040c0bbab	2017-12-12 18:51:35.271	234	3	f	embedded-question	\N	1	25	\N	\N
2566	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-12-12 18:51:35.391	243	56	f	embedded-question	\N	1	28	\N	\N
2567	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-12-12 18:51:35.429	210	25	f	embedded-question	\N	1	29	\N	\N
2568	\\x8f34e1a8509769dd9f759c926a8a7e9492491ac784b1e7218e221ae8707522b5	2017-12-12 18:51:36.139	88	1	f	question	\N	1	47	\N	\N
2569	\\x8ca1483aa78081de6c3e2ebe04e1af174c842edde39e7db8cf04a093acf31d44	2017-12-12 18:51:36.199	96	1	f	question	\N	1	23	\N	\N
2570	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-12 18:51:35.261	1639	1	f	embedded-question	\N	1	44	\N	\N
2571	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-12 18:51:36.127	1187	1	f	question	\N	1	43	\N	\N
2572	\\x2df1c1b99dab5d6c0df61c40a4bc206c6dfad0aa9bb3abebb778075cb7301608	2017-12-12 18:52:03.591	30	1	f	question	\N	1	38	\N	\N
2573	\\xb01ab430a97f00647f2ea6776c5224260a950c9bdd337897bfbf26a5ee89aa9b	2017-12-12 18:52:10.47	81	1	f	question	\N	1	39	\N	\N
2574	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-12 18:52:22.483	997	1	f	question	\N	1	43	\N	\N
2575	\\x2df1c1b99dab5d6c0df61c40a4bc206c6dfad0aa9bb3abebb778075cb7301608	2017-12-12 18:53:07.806	145	1	f	embedded-dashboard	\N	1	38	8	\N
2576	\\xb01ab430a97f00647f2ea6776c5224260a950c9bdd337897bfbf26a5ee89aa9b	2017-12-12 18:53:07.838	148	1	f	embedded-dashboard	\N	1	39	8	\N
2577	\\x6c4e31712c119cf7a66b289f88ff5f98a2fd6f85b950a8d1ba162468c2c67b24	2017-12-12 18:53:08.015	118	10	f	embedded-question	\N	1	27	\N	\N
2578	\\x08fb682e6462441c203ded87d8fd61c85b379b279309ba2c3baedbec1e3a432c	2017-12-12 18:53:07.854	297	7	f	embedded-question	\N	1	26	\N	\N
2579	\\x1d26c377ff1c1798baba15f83c64b34b44430e388d1de4899e7c9f975b4adb01	2017-12-12 18:53:07.938	234	25	f	embedded-question	\N	1	29	\N	\N
2580	\\xe70291818d87d3dce40668f3feb8dabcbdfd8288676c4aed01571e4040c0bbab	2017-12-12 18:53:07.893	317	3	f	embedded-question	\N	1	25	\N	\N
2581	\\x566e90512ee73e32578ce66b23e55fab635802c412c0afa0be0bcf6f95f87500	2017-12-12 18:53:08.07	240	56	f	embedded-question	\N	1	28	\N	\N
2582	\\xb2616cb13705e3bdd1cd4df7823e4cf2e4d62782e11280dfbb8432e612c9a7b8	2017-12-12 18:53:07.837	1419	1	f	embedded-dashboard	\N	1	43	8	\N
2583	\\x16f264b4f2051e7b92cd622b1ad1bb9c18ac323fe6b987b14633924632a8343b	2017-12-12 18:53:13.678	71	2	f	embedded-question	\N	1	22	\N	\N
2584	\\x03ab7b55cad996e98ecdf6097c61c13ef3cb0189c01cc2e66b58a07fcff4fd2c	2017-12-12 18:53:13.769	42	1	f	embedded-dashboard	\N	1	49	6	\N
2585	\\x3673ca69aa1bccfd54ec76b12ad8eaa823899b44f9b755114635baba929aeb6d	2017-12-12 18:53:13.806	159	1	f	embedded-dashboard	\N	1	50	6	\N
2586	\\x4cdd58ce635e28e4c4632ebf3524af71e4ea32d396bb6fedc1bd717999a95297	2017-12-12 18:53:13.937	51	10	f	embedded-question	\N	1	42	\N	\N
2587	\\x09ec3782572f315a26db4edbfeeb5929449aa44c1ee7632972ec3e9c66d651df	2017-12-12 18:53:13.901	121	45	f	embedded-question	\N	1	41	\N	\N
2588	\\xbcffe78744ab2241567e650bea687f68c7215ac8fd15891bc444ec2e4284317a	2017-12-12 18:53:13.832	187	3	f	embedded-question	\N	1	20	\N	\N
2589	\\xabf202a64060a604c55904bba5c66eac4490ceebb207a3c8910a5daa9108d1d3	2017-12-12 18:53:13.81	232	1	f	embedded-dashboard	\N	1	56	6	\N
2590	\\xfcc219a6d0c42d377ae36187ba641c3df2cb391dd5c55990b17176754a7d3dd3	2017-12-12 18:53:13.865	189	51	f	embedded-question	\N	1	24	\N	\N
2591	\\xca3df4c31d7d188a68482087b12819cf1511e5b41671aff86642afa9163ae7eb	2017-12-12 18:53:17.771	603	1	f	embedded-dashboard	\N	1	36	4	\N
2592	\\xb0c4e7f82ddfa522ab443e8039c97010c4911170ff3761100abbc7d1200ee858	2017-12-12 18:53:19.433	676	2	f	embedded-question	\N	1	51	\N	\N
2593	\\x717d5eb3ecbcf66e03cfdf86a5ed4c2f3d9782c07dc5d19da226844f18d8b124	2017-12-12 18:53:19.377	3470	6	f	embedded-question	\N	1	52	\N	\N
2594	\\xc346abd9fcf85f7d1e8a8c4fdb8708e47a185aa472f4fdf9f62814de5af77288	2017-12-12 18:53:17.781	6407	1	f	embedded-dashboard	\N	1	54	4	\N
2595	\\xfd4ebaffa5e24892e606e4d2afacd730afc8f976ad2c37bf4eea7997e3709336	2017-12-12 18:53:17.774	6719	1	f	embedded-dashboard	\N	1	37	4	\N
2596	\\x93fbeea1e8a7c96c5511a2fc3217f776ba748a9b3fa08913f5f55d4490b92758	2017-12-12 18:53:17.675	7133	267	f	embedded-question	\N	1	14	\N	\N
2597	\\x462cd990606ddbb416dd61ee4870769ad25fb73709e8a56c80aba92e4d4f3cd9	2017-12-12 18:53:19.283	5828	45	f	embedded-question	\N	1	15	\N	\N
2598	\\x22857619da3be9a5770e9568affe76f0cd06255f213e2987407e4041c7b81978	2017-12-12 18:53:20.203	4827	166	f	embedded-question	\N	1	17	\N	\N
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
1	2017-11-11 23:04:00.232+00	2017-11-13 23:32:25.016+00	Products	\N	line	{"database":1,"type":"query","query":{"source_table":1}}	{"graph.dimensions":["ID"],"graph.metrics":["PRICE"]}	1	1	1	query	f	\N	\N	\N	t	{}	\N	[{"base_type":"type/BigInteger","display_name":"ID","name":"ID","description":"The numerical product number. Only used internally. All external communication should use the title or EAN.","special_type":"type/PK"},{"base_type":"type/Text","display_name":"Category","name":"CATEGORY","description":"The type of product, valid values include: Doohicky, Gadget, Gizmo and Widget","special_type":"type/Category"},{"base_type":"type/DateTime","display_name":"Created At","name":"CREATED_AT","description":"The date the product was added to our catalog.","unit":"default"},{"base_type":"type/Text","display_name":"Ean","name":"EAN","description":"The international article number. A 13 digit number uniquely identifying the product.","special_type":"type/Category"},{"base_type":"type/Float","display_name":"Price","name":"PRICE","description":"The list price of the product. Note that this is not always the price the product sold for due to discounts, promotions, etc.","special_type":"type/Category"},{"base_type":"type/Float","display_name":"Rating","name":"RATING","description":"The average rating users have given the product. This ranges from 1 - 5","special_type":"type/Category"},{"base_type":"type/Text","display_name":"Title","name":"TITLE","description":"The name of the product as it should be displayed to customers.","special_type":"type/Category"},{"base_type":"type/Text","display_name":"Vendor","name":"VENDOR","description":"The source of the product.","special_type":"type/Category"}]
8	2017-11-14 14:12:47.594+00	2017-11-14 14:12:47.594+00	Space Data, Count, Grouped by Date (hour-of-day), Sorted by Date, (day) descending	\N	bar	{"database":2,"type":"query","query":{"source_table":12,"breakout":[["datetime-field",["field-id",501],"hour-of-day"]],"aggregation":[["count"]],"order_by":[[["datetime-field",["field-id",501],"hour-of-day"],"descending"]]}}	{}	1	2	12	query	f	\N	\N	\N	f	\N	\N	[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"hour-of-day"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
9	2017-11-14 14:13:59.746+00	2017-11-14 14:13:59.746+00	Space Data, Count, Grouped by Date (day-of-week)	\N	line	{"database":2,"type":"query","query":{"source_table":12,"breakout":[["datetime-field",["field-id",501],"day-of-week"]],"aggregation":[["count"]]}}	{}	1	2	12	query	f	\N	\N	\N	f	\N	\N	[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"day-of-week"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
36	2017-11-26 17:58:11.658+00	2017-11-26 18:11:32.369+00	Quantidade total de registros de eventos	\N	scalar	{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["count"]]}}	{}	1	2	18	query	f	2	\N	\N	t	{}	\N	[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
12	2017-11-18 01:19:39.314+00	2017-11-18 02:55:26.491+00	Porcentagem de Projetos que Aceitam Inscrições Online	\N	pie	{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"breakout":[["field-id",595]]}}	{"stackable.stack_type":"stacked","pie.show_legend":false}	1	2	16	query	f	1	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Online Subscribe","name":"_online_subscribe"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
7	2017-11-12 23:51:12.874+00	2017-12-10 10:50:25.109+00	Tipos por Instância	\N	bar	{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"breakout":[["field-id",500],["field-id",498]],"order_by":[[["aggregation",0],"descending"]],"limit":25}}	{"stackable.stack_type":"stacked","graph.x_axis.title_text":"Tipo de Espaço","graph.y_axis.scale":"linear","graph.y_axis.auto_split":true,"graph.x_axis.axis_enabled":true,"graph.y_axis.axis_enabled":true,"graph.y_axis.auto_range":true,"graph.y_axis.title_text":"Quantidade"}	1	2	12	query	f	\N	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Instance","name":"_instance","special_type":"type/Category"},{"base_type":"type/Text","display_name":"Space Type","name":"_space_type","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
6	2017-11-12 23:08:52.511+00	2017-12-10 10:51:03.697+00	Crescimento Cumulativo Mensal por Instância	\N	line	{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",501],"month"],["field-id",500]]}}	{"line.interpolate":"linear","line.marker_enabled":true,"graph.x_axis.title_text":"Data","graph.y_axis.title_text":"Quantidade"}	1	2	12	query	f	\N	\N	\N	t	{}	\N	[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
10	2017-11-18 01:16:53.944+00	2017-12-10 10:54:08.811+00	Registros por Mês	\N	bar	{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"breakout":[["field-id",598],["datetime-field",["field-id",599],"month"]]}}	{"stackable.stack_type":"stacked","graph.x_axis.title_text":"Data","graph.y_axis.title_text":"Quantidade"}	1	2	16	query	f	1	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
13	2017-11-18 01:22:09.721+00	2017-12-10 10:54:48.489+00	Tipos por Instancia	\N	bar	{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",598],["field-id",596]]}}	{"stackable.stack_type":"stacked","pie.show_legend":false,"graph.y_axis.title_text":"Quantidade","graph.x_axis.title_text":"Tipo de Projeto"}	1	2	16	query	f	1	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Project Type","name":"_project_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
30	2017-11-21 03:37:10.675+00	2017-11-21 03:46:40.438+00	Porcentagem por Tipo	\N	pie	{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["count"]],"breakout":[["field-id",635]]}}	{}	1	2	27	query	f	5	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Agents Type","name":"_agents_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
20	2017-11-20 23:06:35.749+00	2017-11-29 23:52:03.665+00	Porcentagem por Acessibilidade	\N	pie	{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",648]]}}	{}	1	2	22	query	f	3	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Accessibility","name":"_accessibility","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
18	2017-11-20 23:04:08.622+00	2017-11-29 23:56:31.789+00	Quantidade de Registros por Tipo	\N	bar	{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"breakout":[["field-id",619],["field-id",618]],"order_by":[[["aggregation",0],"descending"]]}}	{}	1	2	22	query	t	3	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Museum Type","name":"_museum_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
19	2017-11-20 23:05:38.349+00	2017-11-29 23:56:38.277+00	Quantidade de Registros por Temática	\N	bar	{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"breakout":[["field-id",619],["field-id",613]],"order_by":[[["aggregation",0],"descending"]]}}	{}	1	2	22	query	t	3	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Thematic","name":"_thematic"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
21	2017-11-20 23:07:18.266+00	2017-11-29 23:56:45.864+00	Porcentagem por Visita Guiada	\N	pie	{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",616]]}}	{}	1	2	22	query	t	3	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Guided Tu Or","name":"_guided_tuor"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
24	2017-11-20 23:10:58.259+00	2017-11-30 00:01:47.121+00	Crescimento Cumulativo Mensal	\N	line	{"database":2,"type":"query","query":{"source_table":22,"breakout":[["datetime-field",["field-id",620],"month"]],"aggregation":[["cum_count"]]}}	{"graph.y_axis.scale":"linear","graph.x_axis.title_text":"Data","graph.y_axis.title_text":"Quantidade"}	1	2	22	query	f	3	\N	\N	t	{}	\N	[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
34	2017-11-25 19:04:26.294+00	2017-11-25 19:05:02.992+00	Quantidade total de registros de agentes	\N	scalar	{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["count"]]}}	{}	1	2	27	query	f	5	\N	\N	t	{}	\N	[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
35	2017-11-25 19:06:12.384+00	2017-12-05 03:12:03.888+00	Quantidade de registros nos últimos 30 dias	\N	scalar	{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",637],-30,"day"]]}}	{}	1	2	27	query	f	5	\N	\N	t	{}	\N	[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
37	2017-11-26 18:12:18.112+00	2017-11-26 18:12:49.042+00	Quantidade de registros nos últimos 30 dias	\N	scalar	{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",605],-30,"day"]]}}	{}	1	2	18	query	f	2	\N	\N	t	{}	\N	[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
26	2017-11-20 23:47:00.348+00	2017-11-29 23:22:13.348+00	Porcentagem por Tipo	\N	pie	{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"breakout":[["field-id",641]],"order_by":[[["aggregation",0],"descending"]]}}	{}	1	2	25	query	f	4	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Library Type","name":"_library_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
25	2017-11-20 23:46:06.796+00	2017-11-29 23:22:45.061+00	Porcentagem por Acessibilidade	\N	pie	{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"breakout":[["field-id",640]],"order_by":[[["aggregation",0],"descending"]]}}	{}	1	2	25	query	f	4	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Accessibility","name":"_accessibility"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
15	2017-11-19 17:59:28.594+00	2017-12-10 10:44:51.517+00	Crescimento Cumulativo Mensal	\N	line	{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",605],"month"]]}}	{"stackable.stack_type":"stacked","graph.x_axis.title_text":"Data","graph.y_axis.title_text":"Quantidade"}	1	2	18	query	f	2	\N	\N	t	{}	\N	[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
31	2017-11-21 03:41:35.708+00	2017-12-10 10:51:44.022+00	Crescimento Cumulativo Mensal	\N	line	{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",637],"month"]]}}	{"stackable.stack_type":"stacked","graph.x_axis.title_text":"Data","graph.y_axis.title_text":"Quantidade"}	1	2	27	query	f	5	\N	\N	t	{}	\N	[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
33	2017-11-21 03:44:57.663+00	2017-12-10 10:52:29.043+00	Registros por Área	\N	bar	{"database":2,"type":"query","query":{"source_table":26,"aggregation":[["count"]],"breakout":[["field-id",633],["field-id",631]],"limit":100,"order_by":[[["aggregation",0],"descending"]]}}	{"stackable.stack_type":"stacked","graph.x_axis.title_text":"Área","graph.y_axis.title_text":"Quantidade"}	1	2	26	query	f	5	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Area","name":"_area"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
32	2017-11-21 03:42:30.518+00	2017-12-10 10:53:00.169+00	Registros por Mês	\N	bar	{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["count"]],"breakout":[["field-id",636],["datetime-field",["field-id",637],"month"]]}}	{"stackable.stack_type":"stacked","graph.x_axis.title_text":"Data","graph.y_axis.title_text":"Quantidade"}	1	2	27	query	f	5	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
11	2017-11-18 01:17:45.402+00	2017-12-10 10:53:35.635+00	Crescimento Cumulativo Mensal	\N	line	{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"],["cum_count"]],"breakout":[["datetime-field",["field-id",599],"month"]]}}	{"stackable.stack_type":"stacked","graph.x_axis.title_text":"Data","graph.y_axis.title_text":"Quantidade"}	1	2	16	query	f	1	\N	\N	t	{}	\N	[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
38	2017-11-29 23:31:40.372+00	2017-11-29 23:35:33.847+00	Quantidade total de registros de bibliotecas	\N	scalar	{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]]}}	{}	1	2	25	query	f	4	\N	\N	t	{}	\N	[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
22	2017-11-20 23:08:03.853+00	2017-11-29 23:51:23.931+00	Porcentagem por Tipo	\N	pie	{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",618]]}}	{}	1	2	22	query	f	3	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Museum Type","name":"_museum_type","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
40	2017-11-29 23:54:44.367+00	2017-11-29 23:55:25.678+00	Quantidade total de registros de museus	\N	scalar	{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]]}}	{}	1	2	22	query	f	3	\N	\N	t	{}	\N	[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
28	2017-11-20 23:48:24.569+00	2017-11-30 00:09:16.674+00	Crescimento Cumulativo Mensal	\N	line	{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",630],"month"]]}}	{"graph.x_axis.title_text":"Data","graph.y_axis.title_text":"Quantidade"}	1	2	25	query	f	4	\N	\N	t	{}	\N	[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
27	2017-11-20 23:47:48.605+00	2017-11-30 00:12:03.072+00	Top 10 tags	\N	row	{"database":2,"type":"query","query":{"source_table":29,"aggregation":[["count"]],"breakout":[["field-id",643]],"order_by":[[["aggregation",0],"descending"]],"limit":10}}	{"stackable.stack_type":"normalized"}	1	2	29	query	f	4	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Tag","name":"_tag","special_type":"type/URL"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
29	2017-11-20 23:50:00.67+00	2017-11-30 00:13:24.093+00	Quantidade de Registros por Área	\N	bar	{"database":2,"type":"query","query":{"source_table":23,"aggregation":[["count"]],"breakout":[["field-id",623],["field-id",621]],"order_by":[[["aggregation",0],"descending"]],"limit":25}}	{"graph.x_axis.title_text":"Área/Instância","graph.y_axis.title_text":"Quantidade"}	1	2	23	query	f	4	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Area","name":"_area"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
42	2017-11-30 00:03:31.731+00	2017-11-30 00:06:45.18+00	Top 10 tags	\N	row	{"database":2,"type":"query","query":{"source_table":31,"aggregation":[["count"]],"breakout":[["field-id",646]],"order_by":[[["aggregation",0],"descending"]],"limit":10}}	{}	1	2	31	query	f	3	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Tag","name":"_tag","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
43	2017-12-01 23:55:36.884+00	2017-12-01 23:55:36.884+00	Número de instancias	\N	scalar	{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["distinct",["field-id",604]]]}}	{}	1	2	18	query	f	\N	\N	\N	f	\N	\N	[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
44	2017-12-01 23:55:37.013+00	2017-12-01 23:56:42.36+00	Número de instancias	\N	scalar	{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["distinct",["field-id",604]]]}}	{}	1	2	18	query	f	2	\N	\N	t	{}	\N	[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
39	2017-11-29 23:32:53.46+00	2017-12-02 00:23:08.701+00	Quantidade de registros  nos últimos 30 dias	\N	scalar	{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",630],-30,"day"]]}}	{}	1	2	25	query	f	4	\N	\N	t	{}	\N	[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
46	2017-12-02 00:05:34.508+00	2017-12-02 00:14:20.338+00	Quantidade de registros no últimos 30 dias	\N	scalar	{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",501],-30,"day"]]}}	{}	1	2	12	query	f	6	\N	\N	t	{}	\N	[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
45	2017-12-02 00:04:47.773+00	2017-12-02 00:14:05.077+00	Quantidade total de registros de espaços	\N	scalar	{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]]}}	{}	1	2	12	query	f	6	\N	\N	t	{}	\N	[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
47	2017-12-02 00:18:13.385+00	2017-12-02 00:18:50.126+00	Quantidade total de registros de museus	\N	scalar	{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]]}}	{}	1	2	22	query	f	3	\N	\N	t	{}	\N	[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
48	2017-12-02 00:19:41.409+00	2017-12-02 00:20:57.987+00	Quantidade de registros nos últimos 30 dias	\N	scalar	{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",620],-30,"day"]]}}	{}	1	2	22	query	t	3	\N	\N	t	{}	\N	[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
23	2017-11-20 23:09:02.8+00	2017-12-02 00:21:32.978+00	Quantidade de registros  nos últimos 30 dias	\N	scalar	{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",620],-30,"day"]]}}	{}	1	2	22	query	f	3	\N	\N	t	{}	\N	[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
49	2017-12-05 01:43:19.659+00	2017-12-05 01:43:55.798+00	Quantidade Total de Registros	\N	scalar	{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]]}}	{}	1	2	16	query	f	1	\N	\N	t	{}	\N	[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
50	2017-12-05 01:45:20.146+00	2017-12-05 01:45:48.246+00	Quantidade de Registros nos Últimos 30 Dias	\N	scalar	{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",599],-30,"day"]]}}	{}	1	2	16	query	f	1	\N	\N	t	{}	\N	[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
51	2017-12-07 23:37:29.142+00	2017-12-07 23:39:22.911+00	Porcentagem de eventos em espaços acessiveis	\N	pie	{"database":2,"type":"query","query":{"source_table":35,"breakout":[["field-id",674]],"aggregation":[["count"]]}}	{}	1	2	35	query	f	2	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Accessible Space","name":"_accessible_space"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
41	2017-11-30 00:00:49.967+00	2017-12-10 10:42:54.569+00	Quantidade de Registros por Área	\N	bar	{"database":2,"type":"query","query":{"source_table":30,"aggregation":[["count"]],"breakout":[["field-id",649]],"order_by":[[["aggregation",0],"descending"]]}}	{"graph.y_axis.scale":"pow","graph.x_axis.axis_enabled":true,"graph.y_axis.title_text":"Quantidade","graph.x_axis.title_text":"Área"}	1	2	30	query	f	3	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Area","name":"_area","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
14	2017-11-19 17:58:14.276+00	2017-12-10 10:44:06.331+00	Quantidade de Registros por Mês	\N	bar	{"database":2,"type":"query","query":{"source_table":18,"breakout":[["field-id",604],["datetime-field",["field-id",605],"month"]],"aggregation":[["count"]]}}	{"stackable.stack_type":"stacked","graph.x_axis.title_text":"Data","graph.y_axis.title_text":"Quantidade"}	1	2	18	query	f	2	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
17	2017-11-19 18:03:50.473+00	2017-12-10 10:46:10.3+00	Linguagens por Instância	\N	bar	{"database":2,"type":"query","query":{"source_table":20,"aggregation":[["count"]],"breakout":[["field-id",610],["field-id",608]],"order_by":[[["aggregation",0],"descending"]]}}	{"stackable.stack_type":"stacked","graph.x_axis.title_text":"Linguagem","graph.y_axis.title_text":"Quantidade"}	1	2	20	query	f	2	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Instance","name":"_instance","special_type":"type/Category"},{"base_type":"type/Text","display_name":"Language","name":"_language","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
2	2017-11-12 21:42:36.767+00	2017-12-10 10:47:49.253+00	Áreas de Atuação por Instância	\N	bar	{"database":2,"type":"query","query":{"source_table":15,"aggregation":[["count"]],"breakout":[["field-id",594],["field-id",592]],"order_by":[[["aggregation",0],"descending"]]}}	{"stackable.stack_type":"stacked","graph.y_axis.title_text":"Quantidade","graph.x_axis.title_text":"Área de atuação"}	1	2	15	query	f	\N	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Instance","name":"_instance","special_type":"type/Category"},{"base_type":"type/Text","display_name":"Occupation Area","name":"_occupation_area","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
4	2017-11-12 23:05:39.061+00	2017-12-10 10:48:25.969+00	Crescimento Cumulativo Mensal	\N	line	{"database":2,"type":"query","query":{"source_table":12,"breakout":[["datetime-field",["field-id",501],"month"]],"aggregation":[["cum_count"]]}}	{"line.interpolate":"cardinal","line.marker_enabled":true,"graph.x_axis.title_text":"Data","graph.y_axis.title_text":"Quantidade"}	1	2	12	query	f	\N	\N	\N	t	{}	\N	[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
3	2017-11-12 23:01:23.161+00	2017-12-10 10:49:25.436+00	Quantidade de Registros por Mês	\N	bar	{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"breakout":[["datetime-field",["field-id",501],"month"],["field-id",500]]}}	{"stackable.stack_type":"stacked","graph.y_axis.title_text":"Quantidade","graph.x_axis.title_text":"Data"}	1	2	12	query	f	\N	\N	\N	t	{}	\N	[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
52	2017-12-10 12:02:39.26+00	2017-12-12 02:13:15.562+00	Classificação indicativa	\N	pie	{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["count"]],"breakout":[["field-id",680]]}}	{}	1	2	18	query	f	2	\N	\N	t	{}	\N	[{"base_type":"type/Text","display_name":"Age Range","name":"_age_range"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
56	2017-12-12 16:08:01.727+00	2017-12-12 16:08:11.959+00	Quantidade de registros nos últimos 7 dias	\N	scalar	{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",599],-7,"day"]]}}	{}	1	2	16	query	f	1	\N	\N	t	{}	\N	[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
53	2017-12-12 15:57:47.668+00	2017-12-12 15:59:00.276+00	Quantidade de registros nos últimos 7 dias	\N	scalar	{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",637],-7,"day"]]}}	{}	1	2	27	query	f	\N	\N	\N	t	{}	\N	[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
54	2017-12-12 16:03:34.901+00	2017-12-12 16:03:59.866+00	Quantidade de registros nos últimos 7 dias	\N	scalar	{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",605],-7,"day"]]}}	{}	1	2	18	query	f	\N	\N	\N	t	{}	\N	[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
55	2017-12-12 16:06:43.531+00	2017-12-12 16:07:02.787+00	Quantidade de registros nos últimos 7 dias	\N	scalar	{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",501],-7,"day"]]}}	{}	1	2	12	query	f	6	\N	\N	t	{}	\N	[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}]
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
2	2017-12-05 03:12:41.83+00	2017-12-05 03:14:47.003+00	números	\N	1	[]	\N	\N	f	\N	\N	t	{}	f	\N
3	2017-12-12 18:15:52.707+00	2017-12-12 18:20:20.383+00	Numeros Agentes	\N	1	[]	\N	\N	f	\N	\N	t	{}	f	\N
4	2017-12-12 18:41:42.985+00	2017-12-12 18:44:48.759+00	Numeros Eventos	\N	1	[]	\N	\N	f	\N	\N	t	{}	f	\N
5	2017-12-12 18:45:44.049+00	2017-12-12 18:46:15.923+00	Numeros Espaços	\N	1	[]	\N	\N	f	\N	\N	t	{}	f	\N
6	2017-12-12 18:47:27.496+00	2017-12-12 18:47:58.071+00	Numeros Projetos	\N	1	[]	\N	\N	f	\N	\N	t	{}	f	\N
7	2017-12-12 18:49:20.054+00	2017-12-12 18:51:06.51+00	Numeros Museus	\N	1	[]	\N	\N	f	\N	\N	t	{}	f	\N
8	2017-12-12 18:51:47.308+00	2017-12-12 18:52:34.333+00	Numeros Bibliotecas	\N	1	[]	\N	\N	f	\N	\N	t	{}	f	\N
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
11	2017-12-05 03:14:22.928+00	2017-12-05 03:14:23.069+00	6	4	0	6	35	2	[]	{}
10	2017-12-05 03:14:22.919+00	2017-12-05 03:14:23.106+00	6	4	0	0	34	2	[]	{}
9	2017-12-05 03:14:22.918+00	2017-12-05 03:14:23.173+00	6	4	0	12	44	2	[]	{}
14	2017-12-12 18:18:44.261+00	2017-12-12 18:18:44.519+00	6	4	0	0	34	3	[]	{}
13	2017-12-12 18:18:44.258+00	2017-12-12 18:18:44.647+00	6	4	0	6	35	3	[]	{}
12	2017-12-12 18:18:44.253+00	2017-12-12 18:18:44.715+00	6	4	0	12	53	3	[]	{}
17	2017-12-12 18:43:27.858+00	2017-12-12 18:43:28.089+00	6	4	0	6	37	4	[]	{}
15	2017-12-12 18:43:27.847+00	2017-12-12 18:43:28.118+00	6	4	0	0	36	4	[]	{}
16	2017-12-12 18:43:27.844+00	2017-12-12 18:43:28.13+00	6	4	0	12	54	4	[]	{}
20	2017-12-12 18:46:10.839+00	2017-12-12 18:46:10.956+00	6	4	0	0	45	5	[]	{}
18	2017-12-12 18:46:10.834+00	2017-12-12 18:46:10.985+00	7	4	0	6	46	5	[]	{}
19	2017-12-12 18:46:10.838+00	2017-12-12 18:46:11.006+00	5	4	0	13	55	5	[]	{}
21	2017-12-12 18:47:53.587+00	2017-12-12 18:47:53.859+00	6	4	0	0	49	6	[]	{}
22	2017-12-12 18:47:53.588+00	2017-12-12 18:47:53.876+00	6	4	0	6	50	6	[]	{}
23	2017-12-12 18:47:53.596+00	2017-12-12 18:47:54.043+00	6	4	0	12	56	6	[]	{}
24	2017-12-12 18:50:18.463+00	2017-12-12 18:50:50.38+00	6	4	0	12	43	7	[]	{}
25	2017-12-12 18:50:18.464+00	2017-12-12 18:50:50.412+00	6	4	0	0	47	7	[]	{}
26	2017-12-12 18:50:18.466+00	2017-12-12 18:50:50.423+00	6	4	0	6	23	7	[]	{}
27	2017-12-12 18:52:29.532+00	2017-12-12 18:52:29.662+00	6	4	0	0	38	8	[]	{}
29	2017-12-12 18:52:29.536+00	2017-12-12 18:52:29.819+00	6	4	0	6	39	8	[]	{}
28	2017-12-12 18:52:29.535+00	2017-12-12 18:52:29.83+00	6	4	0	12	43	8	[]	{}
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
315	Dashboard	3	1	2017-12-12 18:18:44.471+00	{"description":null,"name":"Numeros Agentes","cards":[{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":12,"card_id":53,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":13,"card_id":35,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":14,"card_id":34,"series":[]}]}	f	f	\N
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
316	Dashboard	3	1	2017-12-12 18:18:44.567+00	{"description":null,"name":"Numeros Agentes","cards":[{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":12,"card_id":53,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":13,"card_id":35,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":14,"card_id":34,"series":[]}]}	f	f	\N
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
322	Dashboard	4	1	2017-12-12 18:43:27.905+00	{"description":null,"name":"Numeros Eventos","cards":[{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":16,"card_id":54,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":15,"card_id":36,"series":[]}]}	f	f	\N
82	Card	10	1	2017-11-18 01:16:53.979+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"breakout":[["field-id",598],["datetime-field",["field-id",599],"month"]]}},"id":10,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	t	\N
83	Card	11	1	2017-11-18 01:17:45.437+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"],["cum_count"]],"breakout":[["datetime-field",["field-id",599],"month"]]}},"id":11,"display":"line","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	t	\N
84	Card	12	1	2017-11-18 01:19:39.341+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Text","display_name":"Online Subscribe","name":"_online_subscribe"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Porcentagem de Projetos que Aceitam Inscrições Online","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"breakout":[["field-id",595]]}},"id":12,"display":"pie","visualization_settings":{"stackable.stack_type":"stacked","pie.show_legend":false},"public_uuid":null}	f	t	\N
85	Card	13	1	2017-11-18 01:22:09.755+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Project Type","name":"_project_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Tipos por Instancia","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",598],["field-id",596]]}},"id":13,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked","pie.show_legend":false},"public_uuid":null}	f	t	\N
86	Card	11	1	2017-11-18 02:49:25.822+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":1,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"],["cum_count"]],"breakout":[["datetime-field",["field-id",599],"month"]]}},"id":11,"display":"line","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
87	Card	12	1	2017-11-18 02:49:36.67+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Text","display_name":"Online Subscribe","name":"_online_subscribe"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":1,"query_type":"query","name":"Porcentagem de Projetos que Aceitam Inscrições Online","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"breakout":[["field-id",595]]}},"id":12,"display":"pie","visualization_settings":{"stackable.stack_type":"stacked","pie.show_legend":false},"public_uuid":null}	f	f	\N
88	Card	10	1	2017-11-18 02:49:47.311+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":1,"query_type":"query","name":"Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"breakout":[["field-id",598],["datetime-field",["field-id",599],"month"]]}},"id":10,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
89	Card	13	1	2017-11-18 02:49:54.506+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Project Type","name":"_project_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":1,"query_type":"query","name":"Tipos por Instancia","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",598],["field-id",596]]}},"id":13,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked","pie.show_legend":false},"public_uuid":null}	f	f	\N
90	Card	13	1	2017-11-18 02:54:50.964+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Project Type","name":"_project_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":1,"query_type":"query","name":"Tipos por Instancia","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",598],["field-id",596]]}},"id":13,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked","pie.show_legend":false},"public_uuid":null}	f	f	\N
317	Dashboard	3	1	2017-12-12 18:18:44.763+00	{"description":null,"name":"Numeros Agentes","cards":[{"sizeX":6,"sizeY":4,"row":0,"col":12,"id":12,"card_id":53,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":6,"id":13,"card_id":35,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":14,"card_id":34,"series":[]}]}	f	f	\N
91	Card	13	1	2017-11-18 02:54:51.026+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Project Type","name":"_project_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":1,"query_type":"query","name":"Tipos por Instancia","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",598],["field-id",596]]}},"id":13,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked","pie.show_legend":false},"public_uuid":null}	f	f	\N
92	Card	10	1	2017-11-18 02:55:09.106+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":1,"query_type":"query","name":"Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"breakout":[["field-id",598],["datetime-field",["field-id",599],"month"]]}},"id":10,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
93	Card	10	1	2017-11-18 02:55:09.18+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":1,"query_type":"query","name":"Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"breakout":[["field-id",598],["datetime-field",["field-id",599],"month"]]}},"id":10,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
94	Card	12	1	2017-11-18 02:55:26.454+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Text","display_name":"Online Subscribe","name":"_online_subscribe"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":1,"query_type":"query","name":"Porcentagem de Projetos que Aceitam Inscrições Online","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"breakout":[["field-id",595]]}},"id":12,"display":"pie","visualization_settings":{"stackable.stack_type":"stacked","pie.show_legend":false},"public_uuid":null}	f	f	\N
95	Card	12	1	2017-11-18 02:55:26.506+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Text","display_name":"Online Subscribe","name":"_online_subscribe"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":1,"query_type":"query","name":"Porcentagem de Projetos que Aceitam Inscrições Online","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"breakout":[["field-id",595]]}},"id":12,"display":"pie","visualization_settings":{"stackable.stack_type":"stacked","pie.show_legend":false},"public_uuid":null}	f	f	\N
96	Card	11	1	2017-11-18 02:55:42.479+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":1,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"],["cum_count"]],"breakout":[["datetime-field",["field-id",599],"month"]]}},"id":11,"display":"line","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
97	Card	11	1	2017-11-18 02:55:42.525+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":1,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"],["cum_count"]],"breakout":[["datetime-field",["field-id",599],"month"]]}},"id":11,"display":"line","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
98	Card	14	1	2017-11-19 17:58:14.308+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Quantidade de Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"breakout":[["field-id",604],["datetime-field",["field-id",605],"month"]],"aggregation":[["count"]]}},"id":14,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	t	\N
99	Card	15	1	2017-11-19 17:59:28.616+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",605],"month"]]}},"id":15,"display":"line","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	t	\N
191	Card	36	1	2017-11-26 18:11:32.389+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":2,"query_type":"query","name":"Quantidade total de registros de eventos","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["count"]]}},"id":36,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
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
318	Dashboard	3	1	2017-12-12 18:18:44.894+00	{"description":null,"name":"Numeros Agentes","cards":[{"sizeX":6,"sizeY":4,"row":0,"col":12,"id":12,"card_id":53,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":6,"id":13,"card_id":35,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":14,"card_id":34,"series":[]}]}	f	f	\N
160	Card	29	1	2017-11-20 23:52:08.836+00	{"description":null,"archived":false,"table_id":23,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Area","name":"_area"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":4,"query_type":"query","name":"Quantidade de Registros por Área","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":23,"aggregation":[["count"]],"breakout":[["field-id",623],["field-id",621]],"order_by":[[["aggregation",0],"descending"]],"limit":25}},"id":29,"display":"bar","visualization_settings":{},"public_uuid":null}	f	f	\N
161	Card	27	1	2017-11-20 23:52:23.185+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":4,"query_type":"query","name":"Quantidade de Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"breakout":[["field-id",629],["datetime-field",["field-id",630],"month"]]}},"id":27,"display":"bar","visualization_settings":{},"public_uuid":null}	f	f	\N
163	Card	30	1	2017-11-21 03:37:10.694+00	{"description":null,"archived":false,"table_id":27,"result_metadata":[{"base_type":"type/Text","display_name":"Agents Type","name":"_agents_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Porcentagem por Tipo","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["count"]],"breakout":[["field-id",635]]}},"id":30,"display":"pie","visualization_settings":{},"public_uuid":null}	f	t	\N
164	Card	31	1	2017-11-21 03:41:35.718+00	{"description":null,"archived":false,"table_id":27,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",637],"month"]]}},"id":31,"display":"line","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	t	\N
165	Card	32	1	2017-11-21 03:42:30.533+00	{"description":null,"archived":false,"table_id":27,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Agents Data, Count, Grouped by Instance and Date (month)","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["count"]],"breakout":[["field-id",636],["datetime-field",["field-id",637],"month"]]}},"id":32,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	t	\N
166	Card	32	1	2017-11-21 03:42:56.213+00	{"description":null,"archived":false,"table_id":27,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["count"]],"breakout":[["field-id",636],["datetime-field",["field-id",637],"month"]]}},"id":32,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
167	Card	33	1	2017-11-21 03:44:57.685+00	{"description":null,"archived":false,"table_id":26,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Area","name":"_area"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Registros por Área","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":26,"aggregation":[["count"]],"breakout":[["field-id",633],["field-id",631]],"limit":100,"order_by":[[["aggregation",0],"descending"]]}},"id":33,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	t	\N
168	Card	31	1	2017-11-21 03:45:30.736+00	{"description":null,"archived":false,"table_id":27,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":5,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",637],"month"]]}},"id":31,"display":"line","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
169	Card	30	1	2017-11-21 03:45:39.806+00	{"description":null,"archived":false,"table_id":27,"result_metadata":[{"base_type":"type/Text","display_name":"Agents Type","name":"_agents_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":5,"query_type":"query","name":"Porcentagem por Tipo","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["count"]],"breakout":[["field-id",635]]}},"id":30,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
192	Card	37	1	2017-11-26 18:12:18.455+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Quantidade de registros nos últimos 30 dias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",605],-30,"day"]]}},"id":37,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	t	\N
170	Card	33	1	2017-11-21 03:45:49.324+00	{"description":null,"archived":false,"table_id":26,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Area","name":"_area"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":5,"query_type":"query","name":"Registros por Área","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":26,"aggregation":[["count"]],"breakout":[["field-id",633],["field-id",631]],"limit":100,"order_by":[[["aggregation",0],"descending"]]}},"id":33,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
171	Card	32	1	2017-11-21 03:45:59.383+00	{"description":null,"archived":false,"table_id":27,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":5,"query_type":"query","name":"Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["count"]],"breakout":[["field-id",636],["datetime-field",["field-id",637],"month"]]}},"id":32,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
172	Card	31	1	2017-11-21 03:46:20.082+00	{"description":null,"archived":false,"table_id":27,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":5,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",637],"month"]]}},"id":31,"display":"line","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
173	Card	31	1	2017-11-21 03:46:20.16+00	{"description":null,"archived":false,"table_id":27,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":5,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",637],"month"]]}},"id":31,"display":"line","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
174	Card	30	1	2017-11-21 03:46:40.38+00	{"description":null,"archived":false,"table_id":27,"result_metadata":[{"base_type":"type/Text","display_name":"Agents Type","name":"_agents_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":5,"query_type":"query","name":"Porcentagem por Tipo","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["count"]],"breakout":[["field-id",635]]}},"id":30,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
175	Card	30	1	2017-11-21 03:46:40.45+00	{"description":null,"archived":false,"table_id":27,"result_metadata":[{"base_type":"type/Text","display_name":"Agents Type","name":"_agents_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":5,"query_type":"query","name":"Porcentagem por Tipo","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["count"]],"breakout":[["field-id",635]]}},"id":30,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
176	Card	33	1	2017-11-21 03:46:52.871+00	{"description":null,"archived":false,"table_id":26,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Area","name":"_area"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":5,"query_type":"query","name":"Registros por Área","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":26,"aggregation":[["count"]],"breakout":[["field-id",633],["field-id",631]],"limit":100,"order_by":[[["aggregation",0],"descending"]]}},"id":33,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
177	Card	33	1	2017-11-21 03:46:52.946+00	{"description":null,"archived":false,"table_id":26,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Area","name":"_area"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":5,"query_type":"query","name":"Registros por Área","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":26,"aggregation":[["count"]],"breakout":[["field-id",633],["field-id",631]],"limit":100,"order_by":[[["aggregation",0],"descending"]]}},"id":33,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
178	Card	32	1	2017-11-21 03:47:04.739+00	{"description":null,"archived":false,"table_id":27,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":5,"query_type":"query","name":"Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["count"]],"breakout":[["field-id",636],["datetime-field",["field-id",637],"month"]]}},"id":32,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
193	Card	37	1	2017-11-26 18:12:35.41+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":2,"query_type":"query","name":"Quantidade de registros nos últimos 30 dias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",605],-30,"day"]]}},"id":37,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
179	Card	32	1	2017-11-21 03:47:04.832+00	{"description":null,"archived":false,"table_id":27,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":5,"query_type":"query","name":"Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["count"]],"breakout":[["field-id",636],["datetime-field",["field-id",637],"month"]]}},"id":32,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
180	Card	34	1	2017-11-25 19:04:26.353+00	{"description":null,"archived":false,"table_id":27,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Quantidade total de registros de agentes","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["count"]]}},"id":34,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	t	\N
181	Card	34	1	2017-11-25 19:04:44.036+00	{"description":null,"archived":false,"table_id":27,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":5,"query_type":"query","name":"Quantidade total de registros de agentes","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["count"]]}},"id":34,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
182	Card	34	1	2017-11-25 19:05:02.952+00	{"description":null,"archived":false,"table_id":27,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":5,"query_type":"query","name":"Quantidade total de registros de agentes","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["count"]]}},"id":34,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
183	Card	34	1	2017-11-25 19:05:03.012+00	{"description":null,"archived":false,"table_id":27,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":5,"query_type":"query","name":"Quantidade total de registros de agentes","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["count"]]}},"id":34,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
184	Card	35	1	2017-11-25 19:06:12.427+00	{"description":null,"archived":false,"table_id":27,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Quantidade de registros de agentes nos últimos 30 dias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",637],-30,"day"]]}},"id":35,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	t	\N
185	Card	35	1	2017-11-25 19:06:27.141+00	{"description":null,"archived":false,"table_id":27,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":5,"query_type":"query","name":"Quantidade de registros de agentes nos últimos 30 dias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",637],-30,"day"]]}},"id":35,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
186	Card	35	1	2017-11-25 19:06:44.333+00	{"description":null,"archived":false,"table_id":27,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":5,"query_type":"query","name":"Quantidade de registros de agentes nos últimos 30 dias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",637],-30,"day"]]}},"id":35,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
187	Card	35	1	2017-11-25 19:06:44.391+00	{"description":null,"archived":false,"table_id":27,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":5,"query_type":"query","name":"Quantidade de registros de agentes nos últimos 30 dias","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",637],-30,"day"]]}},"id":35,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
188	Card	36	1	2017-11-26 17:58:11.801+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Quantidade total de registros de eventos","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["count"]]}},"id":36,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	t	\N
189	Card	36	1	2017-11-26 18:11:08.697+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":2,"query_type":"query","name":"Quantidade total de registros de eventos","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["count"]]}},"id":36,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
190	Card	36	1	2017-11-26 18:11:32.333+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":2,"query_type":"query","name":"Quantidade total de registros de eventos","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["count"]]}},"id":36,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
194	Card	37	1	2017-11-26 18:12:48.991+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":2,"query_type":"query","name":"Quantidade de registros nos últimos 30 dias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",605],-30,"day"]]}},"id":37,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
195	Card	37	1	2017-11-26 18:12:49.063+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":2,"query_type":"query","name":"Quantidade de registros nos últimos 30 dias","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",605],-30,"day"]]}},"id":37,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
196	Card	25	1	2017-11-29 23:21:06.534+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/Text","display_name":"Accessibility","name":"_accessibility"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":4,"query_type":"query","name":"Porcentagem por Acessibilidade","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"breakout":[["field-id",640]]}},"id":25,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
197	Card	26	1	2017-11-29 23:21:49.761+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/Text","display_name":"Library Type","name":"_library_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":4,"query_type":"query","name":"Porcentagem por Tipo","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"breakout":[["field-id",641]]}},"id":26,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
198	Card	26	1	2017-11-29 23:22:13.414+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/Text","display_name":"Library Type","name":"_library_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":4,"query_type":"query","name":"Porcentagem por Tipo","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"breakout":[["field-id",641]],"order_by":[[["aggregation",0],"descending"]]}},"id":26,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
199	Card	25	1	2017-11-29 23:22:45.139+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/Text","display_name":"Accessibility","name":"_accessibility"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":4,"query_type":"query","name":"Porcentagem por Acessibilidade","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"breakout":[["field-id",640]],"order_by":[[["aggregation",0],"descending"]]}},"id":25,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
200	Card	27	1	2017-11-29 23:25:52.133+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance","special_type":"type/Category"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":4,"query_type":"query","name":"Quantidade de Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"breakout":[["field-id",629],["datetime-field",["field-id",630],"month"]],"order_by":[[["datetime-field",["field-id",630],"month"],"ascending"]]}},"id":27,"display":"bar","visualization_settings":{"stackable.stack_type":"normalized"},"public_uuid":null}	f	f	\N
201	Card	38	1	2017-11-29 23:31:40.443+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":4,"query_type":"query","name":"Quantidade total de registros de bibliotecas","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]]}},"id":38,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	t	\N
202	Card	39	1	2017-11-29 23:32:53.53+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":4,"query_type":"query","name":"Quantidade de registros de bibliotecas nos últimos 30 dias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",630],-30,"day"]]}},"id":39,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	t	\N
203	Card	38	1	2017-11-29 23:35:33.818+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":4,"query_type":"query","name":"Quantidade total de registros de bibliotecas","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]]}},"id":38,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
204	Card	38	1	2017-11-29 23:35:33.869+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":4,"query_type":"query","name":"Quantidade total de registros de bibliotecas","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]]}},"id":38,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
205	Card	39	1	2017-11-29 23:35:46.247+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":4,"query_type":"query","name":"Quantidade de registros de bibliotecas nos últimos 30 dias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",630],-30,"day"]]}},"id":39,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
206	Card	39	1	2017-11-29 23:35:46.293+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":4,"query_type":"query","name":"Quantidade de registros de bibliotecas nos últimos 30 dias","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",630],-30,"day"]]}},"id":39,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
207	Card	22	1	2017-11-29 23:51:24.015+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Museum Type","name":"_museum_type","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Porcentagem por Tipo","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",618]]}},"id":22,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
208	Card	20	1	2017-11-29 23:52:03.791+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Accessibility","name":"_accessibility","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Porcentagem por Acessibilidade","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",648]]}},"id":20,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
209	Card	23	1	2017-11-29 23:53:26.761+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]]}},"id":23,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
210	Card	23	1	2017-11-29 23:54:00.639+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Quantidade de registros de museus nos últimos 30 dias","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",620],-30,"day"]]}},"id":23,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
211	Card	40	1	2017-11-29 23:54:44.451+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":3,"query_type":"query","name":"Quantidade total de registros de museus","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]]}},"id":40,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	t	\N
212	Card	40	1	2017-11-29 23:55:25.641+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Quantidade total de registros de museus","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]]}},"id":40,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
213	Card	40	1	2017-11-29 23:55:25.714+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Quantidade total de registros de museus","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]]}},"id":40,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
214	Card	18	1	2017-11-29 23:56:31.879+00	{"description":null,"archived":true,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Museum Type","name":"_museum_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Quantidade de Registros por Tipo","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"breakout":[["field-id",619],["field-id",618]],"order_by":[[["aggregation",0],"descending"]]}},"id":18,"display":"bar","visualization_settings":{},"public_uuid":null}	f	f	\N
215	Card	19	1	2017-11-29 23:56:38.367+00	{"description":null,"archived":true,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Thematic","name":"_thematic"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Quantidade de Registros por Temática","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"breakout":[["field-id",619],["field-id",613]],"order_by":[[["aggregation",0],"descending"]]}},"id":19,"display":"bar","visualization_settings":{},"public_uuid":null}	f	f	\N
216	Card	21	1	2017-11-29 23:56:45.945+00	{"description":null,"archived":true,"table_id":22,"result_metadata":[{"base_type":"type/Text","display_name":"Guided Tu Or","name":"_guided_tuor"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Porcentagem por Visita Guiada","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",616]]}},"id":21,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
217	Card	41	1	2017-11-30 00:00:50.053+00	{"description":null,"archived":false,"table_id":30,"result_metadata":[{"base_type":"type/Text","display_name":"Area","name":"_area","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":3,"query_type":"query","name":"Quantidade de Registros por Área","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":30,"aggregation":[["count"]],"breakout":[["field-id",649]]}},"id":41,"display":"bar","visualization_settings":{"graph.y_axis.scale":"pow","graph.x_axis.axis_enabled":true,"graph.y_axis.title_text":"Quantidade","graph.x_axis.title_text":"Área"},"public_uuid":null}	f	t	\N
222	Card	41	1	2017-11-30 00:07:09.271+00	{"description":null,"archived":false,"table_id":30,"result_metadata":[{"base_type":"type/Text","display_name":"Area","name":"_area","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Quantidade de Registros por Área","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":30,"aggregation":[["count"]],"breakout":[["field-id",649]]}},"id":41,"display":"bar","visualization_settings":{"graph.y_axis.scale":"pow","graph.x_axis.axis_enabled":true,"graph.y_axis.title_text":"Quantidade","graph.x_axis.title_text":"Área"},"public_uuid":null}	f	f	\N
228	Card	29	1	2017-11-30 00:12:30.678+00	{"description":null,"archived":false,"table_id":23,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Area","name":"_area"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":4,"query_type":"query","name":"Quantidade de Registros por Área","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":23,"aggregation":[["count"]],"breakout":[["field-id",623],["field-id",621]],"order_by":[[["aggregation",0],"descending"]],"limit":25}},"id":29,"display":"bar","visualization_settings":{},"public_uuid":null}	f	f	\N
218	Card	24	1	2017-11-30 00:01:47.2+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"breakout":[["datetime-field",["field-id",620],"month"]],"aggregation":[["cum_count"]]}},"id":24,"display":"line","visualization_settings":{"graph.y_axis.scale":"linear","graph.x_axis.title_text":"Data","graph.y_axis.title_text":"Quantidade"},"public_uuid":null}	f	f	\N
219	Card	42	1	2017-11-30 00:03:31.82+00	{"description":null,"archived":false,"table_id":31,"result_metadata":[{"base_type":"type/Text","display_name":"Tag","name":"_tag","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":3,"query_type":"query","name":"Top 10 tags","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":31,"aggregation":[["count"]],"breakout":[["field-id",646]],"order_by":[[["aggregation",0],"descending"]],"limit":10}},"id":42,"display":"row","visualization_settings":{},"public_uuid":null}	f	t	\N
220	Card	42	1	2017-11-30 00:06:45.151+00	{"description":null,"archived":false,"table_id":31,"result_metadata":[{"base_type":"type/Text","display_name":"Tag","name":"_tag","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Top 10 tags","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":31,"aggregation":[["count"]],"breakout":[["field-id",646]],"order_by":[[["aggregation",0],"descending"]],"limit":10}},"id":42,"display":"row","visualization_settings":{},"public_uuid":null}	f	f	\N
221	Card	42	1	2017-11-30 00:06:45.204+00	{"description":null,"archived":false,"table_id":31,"result_metadata":[{"base_type":"type/Text","display_name":"Tag","name":"_tag","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Top 10 tags","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":31,"aggregation":[["count"]],"breakout":[["field-id",646]],"order_by":[[["aggregation",0],"descending"]],"limit":10}},"id":42,"display":"row","visualization_settings":{},"public_uuid":null}	f	f	\N
223	Card	41	1	2017-11-30 00:07:09.313+00	{"description":null,"archived":false,"table_id":30,"result_metadata":[{"base_type":"type/Text","display_name":"Area","name":"_area","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Quantidade de Registros por Área","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":30,"aggregation":[["count"]],"breakout":[["field-id",649]]}},"id":41,"display":"bar","visualization_settings":{"graph.y_axis.scale":"pow","graph.x_axis.axis_enabled":true,"graph.y_axis.title_text":"Quantidade","graph.x_axis.title_text":"Área"},"public_uuid":null}	f	f	\N
235	Card	44	1	2017-12-01 23:56:42.401+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":2,"query_type":"query","name":"Número de instancias","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["distinct",["field-id",604]]]}},"id":44,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
224	Card	41	1	2017-11-30 00:07:34.145+00	{"description":null,"archived":false,"table_id":30,"result_metadata":[{"base_type":"type/Text","display_name":"Area","name":"_area","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Quantidade de Registros por Área","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":30,"aggregation":[["count"]],"breakout":[["field-id",649]]}},"id":41,"display":"bar","visualization_settings":{"graph.y_axis.scale":"pow","graph.x_axis.axis_enabled":true,"graph.y_axis.title_text":"Quantidade","graph.x_axis.title_text":"Área"},"public_uuid":null}	f	f	\N
225	Card	41	1	2017-11-30 00:07:34.192+00	{"description":null,"archived":false,"table_id":30,"result_metadata":[{"base_type":"type/Text","display_name":"Area","name":"_area","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Quantidade de Registros por Área","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":30,"aggregation":[["count"]],"breakout":[["field-id",649]]}},"id":41,"display":"bar","visualization_settings":{"graph.y_axis.scale":"pow","graph.x_axis.axis_enabled":true,"graph.y_axis.title_text":"Quantidade","graph.x_axis.title_text":"Área"},"public_uuid":null}	f	f	\N
226	Card	28	1	2017-11-30 00:09:16.747+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":4,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",630],"month"]]}},"id":28,"display":"line","visualization_settings":{"graph.x_axis.title_text":"Data","graph.y_axis.title_text":"Quantidade"},"public_uuid":null}	f	f	\N
227	Card	27	1	2017-11-30 00:12:03.138+00	{"description":null,"archived":false,"table_id":29,"result_metadata":[{"base_type":"type/Text","display_name":"Tag","name":"_tag","special_type":"type/URL"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":4,"query_type":"query","name":"Top 10 tags","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":29,"aggregation":[["count"]],"breakout":[["field-id",643]],"order_by":[[["aggregation",0],"descending"]],"limit":10}},"id":27,"display":"row","visualization_settings":{"stackable.stack_type":"normalized"},"public_uuid":null}	f	f	\N
229	Card	29	1	2017-11-30 00:12:54.166+00	{"description":null,"archived":false,"table_id":23,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Area","name":"_area"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":4,"query_type":"query","name":"Quantidade de Registros por Área","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":23,"aggregation":[["count"]],"breakout":[["field-id",623],["field-id",621]],"order_by":[[["aggregation",0],"descending"]],"limit":25}},"id":29,"display":"bar","visualization_settings":{"graph.x_axis.title_text":"Área","graph.y_axis.title_text":"Quantidade"},"public_uuid":null}	f	f	\N
230	Card	29	1	2017-11-30 00:13:24.176+00	{"description":null,"archived":false,"table_id":23,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Area","name":"_area"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":4,"query_type":"query","name":"Quantidade de Registros por Área","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":23,"aggregation":[["count"]],"breakout":[["field-id",623],["field-id",621]],"order_by":[[["aggregation",0],"descending"]],"limit":25}},"id":29,"display":"bar","visualization_settings":{"graph.x_axis.title_text":"Área/Instância","graph.y_axis.title_text":"Quantidade"},"public_uuid":null}	f	f	\N
231	Card	43	1	2017-12-01 23:55:36.959+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Número de instancias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["distinct",["field-id",604]]]}},"id":43,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	t	\N
232	Card	44	1	2017-12-01 23:55:37.158+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Número de instancias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["distinct",["field-id",604]]]}},"id":44,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	t	\N
233	Card	44	1	2017-12-01 23:56:21.827+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":2,"query_type":"query","name":"Número de instancias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["distinct",["field-id",604]]]}},"id":44,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
234	Card	44	1	2017-12-01 23:56:42.276+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":2,"query_type":"query","name":"Número de instancias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["distinct",["field-id",604]]]}},"id":44,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
319	Dashboard	3	1	2017-12-12 18:20:20.33+00	{"description":null,"name":"Numeros Agentes","cards":[{"sizeX":6,"sizeY":4,"row":0,"col":12,"id":12,"card_id":53,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":6,"id":13,"card_id":35,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":14,"card_id":34,"series":[]}]}	f	f	\N
236	Card	45	1	2017-12-02 00:04:47.843+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Quantidade total de registros de espaços","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]]}},"id":45,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	t	\N
237	Card	46	1	2017-12-02 00:05:34.533+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Quantidade de registros no últimos 30 dias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",501],-30,"day"]]}},"id":46,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	t	\N
238	Card	46	1	2017-12-02 00:07:22.683+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Quantidade de registros no últimos 30 dias de Espaço","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",501],-30,"day"]]}},"id":46,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
239	Card	46	1	2017-12-02 00:11:20.683+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Quantidade de registros no últimos 30 dias de Espaço","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",501],-30,"day"]]}},"id":46,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
240	Card	46	1	2017-12-02 00:11:20.725+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Quantidade de registros no últimos 30 dias de Espaço","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",501],-30,"day"]]}},"id":46,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
244	Card	45	1	2017-12-02 00:14:05.121+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":6,"query_type":"query","name":"Quantidade total de registros de espaços","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]]}},"id":45,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
247	Card	47	1	2017-12-02 00:18:22.137+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Quantidade total de registros de museus","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]]}},"id":47,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
250	Card	48	1	2017-12-02 00:19:41.487+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Quantidade de registros nos últimos 30 dias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",620],-30,"day"]]}},"id":48,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	t	\N
251	Card	48	1	2017-12-02 00:19:47.782+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Quantidade de registros nos últimos 30 dias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",620],-30,"day"]]}},"id":48,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
252	Card	48	1	2017-12-02 00:19:47.832+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Quantidade de registros nos últimos 30 dias","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",620],-30,"day"]]}},"id":48,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
253	Card	48	1	2017-12-02 00:20:06.371+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Quantidade de registros nos últimos 30 dias","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",620],-30,"day"]]}},"id":48,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
241	Card	45	1	2017-12-02 00:12:10.46+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Quantidade total de registros de espaços","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]]}},"id":45,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
245	Card	46	1	2017-12-02 00:14:20.388+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":6,"query_type":"query","name":"Quantidade de registros no últimos 30 dias","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",501],-30,"day"]]}},"id":46,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
248	Card	47	1	2017-12-02 00:18:22.185+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Quantidade total de registros de museus","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]]}},"id":47,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
242	Card	45	1	2017-12-02 00:12:10.509+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Quantidade total de registros de espaços","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]]}},"id":45,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
243	Card	46	1	2017-12-02 00:13:57.273+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":6,"query_type":"query","name":"Quantidade de registros no últimos 30 dias de Espaço","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",501],-30,"day"]]}},"id":46,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
246	Card	47	1	2017-12-02 00:18:13.435+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Quantidade total de registros de museus","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]]}},"id":47,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	t	\N
249	Card	47	1	2017-12-02 00:18:50.178+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Quantidade total de registros de museus","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]]}},"id":47,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
254	Card	48	1	2017-12-02 00:20:58.04+00	{"description":null,"archived":true,"table_id":22,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Quantidade de registros nos últimos 30 dias","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",620],-30,"day"]]}},"id":48,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
255	Card	23	1	2017-12-02 00:21:33.004+00	{"description":null,"archived":false,"table_id":22,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Quantidade de registros  nos últimos 30 dias","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":22,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",620],-30,"day"]]}},"id":23,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
256	Card	39	1	2017-12-02 00:23:08.754+00	{"description":null,"archived":false,"table_id":25,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":4,"query_type":"query","name":"Quantidade de registros  nos últimos 30 dias","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":25,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",630],-30,"day"]]}},"id":39,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
257	Card	49	1	2017-12-05 01:43:19.705+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Quantidade Total de Registros","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]]}},"id":49,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	t	\N
258	Card	49	1	2017-12-05 01:43:40.026+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":1,"query_type":"query","name":"Quantidade Total de Registros","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]]}},"id":49,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
259	Card	49	1	2017-12-05 01:43:55.746+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":1,"query_type":"query","name":"Quantidade Total de Registros","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]]}},"id":49,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
260	Card	49	1	2017-12-05 01:43:55.808+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":1,"query_type":"query","name":"Quantidade Total de Registros","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]]}},"id":49,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
261	Card	50	1	2017-12-05 01:45:20.162+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":1,"query_type":"query","name":"Quantidade de Registros nos Últimos 30 Dias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",599],-30,"day"]]}},"id":50,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	t	\N
262	Card	50	1	2017-12-05 01:45:48.205+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":1,"query_type":"query","name":"Quantidade de Registros nos Últimos 30 Dias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",599],-30,"day"]]}},"id":50,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
263	Card	50	1	2017-12-05 01:45:48.257+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":1,"query_type":"query","name":"Quantidade de Registros nos Últimos 30 Dias","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",599],-30,"day"]]}},"id":50,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
264	Card	2	1	2017-12-05 03:04:59.453+00	{"description":null,"archived":false,"table_id":15,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Occupation Area","name":"_occupation_area"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Áreas de Atuação por Instância","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":15,"aggregation":[["count"]],"breakout":[["field-id",594],["field-id",592]]}},"id":2,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
265	Card	17	1	2017-12-05 03:07:37.256+00	{"description":null,"archived":false,"table_id":20,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Language","name":"_language"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":2,"query_type":"query","name":"Linguagens por Instância","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":20,"aggregation":[["count"]],"breakout":[["field-id",610],["field-id",608]]}},"id":17,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
266	Card	35	1	2017-12-05 03:12:03.926+00	{"description":null,"archived":false,"table_id":27,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":5,"query_type":"query","name":"Quantidade de registros nos últimos 30 dias","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",637],-30,"day"]]}},"id":35,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
267	Dashboard	2	1	2017-12-05 03:12:41.917+00	{"description":null,"name":"números","cards":[]}	f	t	\N
268	Dashboard	2	1	2017-12-05 03:14:22.983+00	{"description":null,"name":"números","cards":[{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":9,"card_id":44,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":10,"card_id":34,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":11,"card_id":35,"series":[]}]}	f	f	\N
269	Dashboard	2	1	2017-12-05 03:14:23.088+00	{"description":null,"name":"números","cards":[{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":9,"card_id":44,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":10,"card_id":34,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":11,"card_id":35,"series":[]}]}	f	f	\N
270	Dashboard	2	1	2017-12-05 03:14:23.12+00	{"description":null,"name":"números","cards":[{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":9,"card_id":44,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":10,"card_id":34,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":6,"id":11,"card_id":35,"series":[]}]}	f	f	\N
271	Dashboard	2	1	2017-12-05 03:14:23.206+00	{"description":null,"name":"números","cards":[{"sizeX":6,"sizeY":4,"row":0,"col":12,"id":9,"card_id":44,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":10,"card_id":34,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":6,"id":11,"card_id":35,"series":[]}]}	f	f	\N
272	Dashboard	2	1	2017-12-05 03:14:23.248+00	{"description":null,"name":"números","cards":[{"sizeX":6,"sizeY":4,"row":0,"col":12,"id":9,"card_id":44,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":10,"card_id":34,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":6,"id":11,"card_id":35,"series":[]}]}	f	f	\N
273	Dashboard	2	1	2017-12-05 03:14:46.928+00	{"description":null,"name":"números","cards":[{"sizeX":6,"sizeY":4,"row":0,"col":12,"id":9,"card_id":44,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":10,"card_id":34,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":6,"id":11,"card_id":35,"series":[]}]}	f	f	\N
274	Dashboard	2	1	2017-12-05 03:14:47.023+00	{"description":null,"name":"números","cards":[{"sizeX":6,"sizeY":4,"row":0,"col":12,"id":9,"card_id":44,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":10,"card_id":34,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":6,"id":11,"card_id":35,"series":[]}]}	f	f	\N
320	Dashboard	3	1	2017-12-12 18:20:20.416+00	{"description":null,"name":"Numeros Agentes","cards":[{"sizeX":6,"sizeY":4,"row":0,"col":12,"id":12,"card_id":53,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":6,"id":13,"card_id":35,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":14,"card_id":34,"series":[]}]}	f	f	\N
275	Card	51	1	2017-12-07 23:37:29.215+00	{"description":null,"archived":false,"table_id":35,"result_metadata":[{"base_type":"type/Text","display_name":"Accessible Space","name":"_accessible_space"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":2,"query_type":"query","name":"Porcentagem de eventos em espaços acessiveis","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":35,"breakout":[["field-id",674]],"aggregation":[["count"]]}},"id":51,"display":"pie","visualization_settings":{},"public_uuid":null}	f	t	\N
276	Card	51	1	2017-12-07 23:39:22.835+00	{"description":null,"archived":false,"table_id":35,"result_metadata":[{"base_type":"type/Text","display_name":"Accessible Space","name":"_accessible_space"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":2,"query_type":"query","name":"Porcentagem de eventos em espaços acessiveis","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":35,"breakout":[["field-id",674]],"aggregation":[["count"]]}},"id":51,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
277	Card	51	1	2017-12-07 23:39:22.929+00	{"description":null,"archived":false,"table_id":35,"result_metadata":[{"base_type":"type/Text","display_name":"Accessible Space","name":"_accessible_space"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":2,"query_type":"query","name":"Porcentagem de eventos em espaços acessiveis","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":35,"breakout":[["field-id",674]],"aggregation":[["count"]]}},"id":51,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
278	Card	17	1	2017-12-10 00:51:11.967+00	{"description":null,"archived":false,"table_id":20,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance","special_type":"type/Category"},{"base_type":"type/Text","display_name":"Language","name":"_language","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":2,"query_type":"query","name":"Linguagens por Instância","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":20,"aggregation":[["count"]],"breakout":[["field-id",610],["field-id",608]],"order_by":[[["aggregation",0],"descending"]]}},"id":17,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
279	Card	2	1	2017-12-10 00:52:09.464+00	{"description":null,"archived":false,"table_id":15,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance","special_type":"type/Category"},{"base_type":"type/Text","display_name":"Occupation Area","name":"_occupation_area","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Áreas de Atuação por Instância","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":15,"aggregation":[["count"]],"breakout":[["field-id",594],["field-id",592]],"order_by":[[["aggregation",0],"descending"]]}},"id":2,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
280	Card	2	1	2017-12-10 00:57:39.285+00	{"description":null,"archived":false,"table_id":15,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance","special_type":"type/Category"},{"base_type":"type/Text","display_name":"Occupation Area","name":"_occupation_area","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Áreas de Atuação por Instância","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":15,"aggregation":[["count"]],"breakout":[["field-id",594],["field-id",592]],"order_by":[[["aggregation",0],"descending"]]}},"id":2,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked"},"public_uuid":null}	f	f	\N
281	Card	41	1	2017-12-10 10:42:54.621+00	{"description":null,"archived":false,"table_id":30,"result_metadata":[{"base_type":"type/Text","display_name":"Area","name":"_area","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":3,"query_type":"query","name":"Quantidade de Registros por Área","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":30,"aggregation":[["count"]],"breakout":[["field-id",649]],"order_by":[[["aggregation",0],"descending"]]}},"id":41,"display":"bar","visualization_settings":{"graph.y_axis.scale":"pow","graph.x_axis.axis_enabled":true,"graph.y_axis.title_text":"Quantidade","graph.x_axis.title_text":"Área"},"public_uuid":null}	f	f	\N
282	Card	14	1	2017-12-10 10:44:06.357+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":2,"query_type":"query","name":"Quantidade de Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"breakout":[["field-id",604],["datetime-field",["field-id",605],"month"]],"aggregation":[["count"]]}},"id":14,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked","graph.x_axis.title_text":"Data","graph.y_axis.title_text":"Quantidade"},"public_uuid":null}	f	f	\N
283	Card	15	1	2017-12-10 10:44:51.573+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":2,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",605],"month"]]}},"id":15,"display":"line","visualization_settings":{"stackable.stack_type":"stacked","graph.x_axis.title_text":"Data","graph.y_axis.title_text":"Quantidade"},"public_uuid":null}	f	f	\N
321	Dashboard	4	1	2017-12-12 18:41:43.01+00	{"description":null,"name":"Numeros Eventos","cards":[]}	f	t	\N
329	Dashboard	5	1	2017-12-12 18:45:44.076+00	{"description":null,"name":"Numeros Espaços","cards":[]}	f	t	\N
284	Card	17	1	2017-12-10 10:46:10.368+00	{"description":null,"archived":false,"table_id":20,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance","special_type":"type/Category"},{"base_type":"type/Text","display_name":"Language","name":"_language","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":2,"query_type":"query","name":"Linguagens por Instância","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":20,"aggregation":[["count"]],"breakout":[["field-id",610],["field-id",608]],"order_by":[[["aggregation",0],"descending"]]}},"id":17,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked","graph.x_axis.title_text":"Linguagem","graph.y_axis.title_text":"Quantidade"},"public_uuid":null}	f	f	\N
286	Card	4	1	2017-12-10 10:48:26.055+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"breakout":[["datetime-field",["field-id",501],"month"]],"aggregation":[["cum_count"]]}},"id":4,"display":"line","visualization_settings":{"line.interpolate":"cardinal","line.marker_enabled":true,"graph.x_axis.title_text":"Data","graph.y_axis.title_text":"Quantidade"},"public_uuid":null}	f	f	\N
287	Card	3	1	2017-12-10 10:49:25.505+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Quantidade de Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"breakout":[["datetime-field",["field-id",501],"month"],["field-id",500]]}},"id":3,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked","graph.y_axis.title_text":"Quantidade","graph.x_axis.title_text":"Data"},"public_uuid":null}	f	f	\N
285	Card	2	1	2017-12-10 10:47:49.3+00	{"description":null,"archived":false,"table_id":15,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance","special_type":"type/Category"},{"base_type":"type/Text","display_name":"Occupation Area","name":"_occupation_area","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Áreas de Atuação por Instância","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":15,"aggregation":[["count"]],"breakout":[["field-id",594],["field-id",592]],"order_by":[[["aggregation",0],"descending"]]}},"id":2,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked","graph.y_axis.title_text":"Quantidade","graph.x_axis.title_text":"Área de atuação"},"public_uuid":null}	f	f	\N
288	Card	7	1	2017-12-10 10:50:25.165+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance","special_type":"type/Category"},{"base_type":"type/Text","display_name":"Space Type","name":"_space_type","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Tipos por Instância","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"breakout":[["field-id",500],["field-id",498]],"order_by":[[["aggregation",0],"descending"]],"limit":25}},"id":7,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked","graph.x_axis.title_text":"Tipo de Espaço","graph.y_axis.scale":"linear","graph.y_axis.auto_split":true,"graph.x_axis.axis_enabled":true,"graph.y_axis.axis_enabled":true,"graph.y_axis.auto_range":true,"graph.y_axis.title_text":"Quantidade"},"public_uuid":null}	f	f	\N
289	Card	6	1	2017-12-10 10:51:03.777+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Crescimento Cumulativo Mensal por Instância","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",501],"month"],["field-id",500]]}},"id":6,"display":"line","visualization_settings":{"line.interpolate":"linear","line.marker_enabled":true,"graph.x_axis.title_text":"Data","graph.y_axis.title_text":"Quantidade"},"public_uuid":null}	f	f	\N
290	Card	31	1	2017-12-10 10:51:44.078+00	{"description":null,"archived":false,"table_id":27,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":5,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["cum_count"]],"breakout":[["datetime-field",["field-id",637],"month"]]}},"id":31,"display":"line","visualization_settings":{"stackable.stack_type":"stacked","graph.x_axis.title_text":"Data","graph.y_axis.title_text":"Quantidade"},"public_uuid":null}	f	f	\N
291	Card	33	1	2017-12-10 10:52:29.087+00	{"description":null,"archived":false,"table_id":26,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Area","name":"_area"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":5,"query_type":"query","name":"Registros por Área","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":26,"aggregation":[["count"]],"breakout":[["field-id",633],["field-id",631]],"limit":100,"order_by":[[["aggregation",0],"descending"]]}},"id":33,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked","graph.x_axis.title_text":"Área","graph.y_axis.title_text":"Quantidade"},"public_uuid":null}	f	f	\N
292	Card	32	1	2017-12-10 10:53:00.205+00	{"description":null,"archived":false,"table_id":27,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":5,"query_type":"query","name":"Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["count"]],"breakout":[["field-id",636],["datetime-field",["field-id",637],"month"]]}},"id":32,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked","graph.x_axis.title_text":"Data","graph.y_axis.title_text":"Quantidade"},"public_uuid":null}	f	f	\N
293	Card	11	1	2017-12-10 10:53:35.675+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":1,"query_type":"query","name":"Crescimento Cumulativo Mensal","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"],["cum_count"]],"breakout":[["datetime-field",["field-id",599],"month"]]}},"id":11,"display":"line","visualization_settings":{"stackable.stack_type":"stacked","graph.x_axis.title_text":"Data","graph.y_axis.title_text":"Quantidade"},"public_uuid":null}	f	f	\N
294	Card	10	1	2017-12-10 10:54:08.863+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/DateTime","display_name":"Date","name":"_date","unit":"month"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":1,"query_type":"query","name":"Registros por Mês","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"breakout":[["field-id",598],["datetime-field",["field-id",599],"month"]]}},"id":10,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked","graph.x_axis.title_text":"Data","graph.y_axis.title_text":"Quantidade"},"public_uuid":null}	f	f	\N
295	Card	13	1	2017-12-10 10:54:48.745+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Text","display_name":"Instance","name":"_instance"},{"base_type":"type/Text","display_name":"Project Type","name":"_project_type"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":1,"query_type":"query","name":"Tipos por Instancia","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"order_by":[[["aggregation",0],"descending"]],"breakout":[["field-id",598],["field-id",596]]}},"id":13,"display":"bar","visualization_settings":{"stackable.stack_type":"stacked","pie.show_legend":false,"graph.y_axis.title_text":"Quantidade","graph.x_axis.title_text":"Tipo de Projeto"},"public_uuid":null}	f	f	\N
296	Card	52	1	2017-12-10 12:02:39.487+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Text","display_name":"Age Rage","name":"_age_rage","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":2,"query_type":"query","name":"Porcentagem de eventos por faixa etária","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["count"]],"breakout":[["field-id",602]]}},"id":52,"display":"pie","visualization_settings":{},"public_uuid":null}	f	t	\N
297	Card	52	1	2017-12-10 12:02:53.32+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Text","display_name":"Age Rage","name":"_age_rage","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":2,"query_type":"query","name":"Porcentagem de eventos por faixa etária","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["count"]],"breakout":[["field-id",602]]}},"id":52,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
298	Card	52	1	2017-12-10 12:02:53.4+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Text","display_name":"Age Rage","name":"_age_rage","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":2,"query_type":"query","name":"Porcentagem de eventos por faixa etária","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["count"]],"breakout":[["field-id",602]]}},"id":52,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
299	Card	52	1	2017-12-11 20:18:21.228+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Text","display_name":"Age Rage","name":"_age_rage","special_type":"type/Category"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":2,"query_type":"query","name":"Classificação indicativa","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["count"]],"breakout":[["field-id",602]]}},"id":52,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
300	Card	52	1	2017-12-12 02:13:15.595+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Text","display_name":"Age Range","name":"_age_range"},{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":2,"query_type":"query","name":"Classificação indicativa","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["count"]],"breakout":[["field-id",680]]}},"id":52,"display":"pie","visualization_settings":{},"public_uuid":null}	f	f	\N
301	Card	53	1	2017-12-12 15:57:47.715+00	{"description":null,"archived":false,"table_id":27,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Quantidade de registros nos últimos 7 dias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",637],-7,"day"]]}},"id":53,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	t	\N
302	Card	53	1	2017-12-12 15:59:00.142+00	{"description":null,"archived":false,"table_id":27,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Quantidade de registros nos últimos 7 dias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",637],-7,"day"]]}},"id":53,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
303	Card	53	1	2017-12-12 15:59:00.337+00	{"description":null,"archived":false,"table_id":27,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Quantidade de registros nos últimos 7 dias","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":27,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",637],-7,"day"]]}},"id":53,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
304	Card	54	1	2017-12-12 16:03:34.957+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Quantidade de registros nos últimos 7 dias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",605],-7,"day"]]}},"id":54,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	t	\N
305	Card	54	1	2017-12-12 16:03:59.747+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Quantidade de registros nos últimos 7 dias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",605],-7,"day"]]}},"id":54,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
306	Card	54	1	2017-12-12 16:03:59.934+00	{"description":null,"archived":false,"table_id":18,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":null,"query_type":"query","name":"Quantidade de registros nos últimos 7 dias","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":18,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",605],-7,"day"]]}},"id":54,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
307	Card	55	1	2017-12-12 16:06:43.702+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":6,"query_type":"query","name":"Quantidade de registros nos últimos 7 dias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",501],-7,"day"]]}},"id":55,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	t	\N
308	Card	55	1	2017-12-12 16:07:02.708+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":6,"query_type":"query","name":"Quantidade de registros nos últimos 7 dias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",501],-7,"day"]]}},"id":55,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
309	Card	55	1	2017-12-12 16:07:02.814+00	{"description":null,"archived":false,"table_id":12,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":6,"query_type":"query","name":"Quantidade de registros nos últimos 7 dias","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":12,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",501],-7,"day"]]}},"id":55,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
310	Card	56	1	2017-12-12 16:08:01.758+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":false,"collection_id":1,"query_type":"query","name":"Quantidade de registros nos últimos 7 dias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",599],-7,"day"]]}},"id":56,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	t	\N
311	Card	56	1	2017-12-12 16:08:11.839+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":1,"query_type":"query","name":"Quantidade de registros nos últimos 7 dias","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",599],-7,"day"]]}},"id":56,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
312	Card	56	1	2017-12-12 16:08:12.063+00	{"description":null,"archived":false,"table_id":16,"result_metadata":[{"base_type":"type/Integer","display_name":"count","name":"count","special_type":"type/Number"}],"database_id":2,"enable_embedding":true,"collection_id":1,"query_type":"query","name":"Quantidade de registros nos últimos 7 dias","creator_id":1,"made_public_by_id":null,"embedding_params":{},"cache_ttl":null,"dataset_query":{"database":2,"type":"query","query":{"source_table":16,"aggregation":[["count"]],"filter":["AND",["time-interval",["field-id",599],-7,"day"]]}},"id":56,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
313	Dashboard	3	1	2017-12-12 18:15:52.788+00	{"description":null,"name":"Numeros Agentes","cards":[]}	f	t	\N
314	Dashboard	3	1	2017-12-12 18:18:44.355+00	{"description":null,"name":"Numeros Agentes","cards":[{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":12,"card_id":53,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":13,"card_id":35,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":14,"card_id":34,"series":[]}]}	f	f	\N
323	Dashboard	4	1	2017-12-12 18:43:27.981+00	{"description":null,"name":"Numeros Eventos","cards":[{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":16,"card_id":54,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":15,"card_id":36,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":17,"card_id":37,"series":[]}]}	f	f	\N
324	Dashboard	4	1	2017-12-12 18:43:28.015+00	{"description":null,"name":"Numeros Eventos","cards":[{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":16,"card_id":54,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":15,"card_id":36,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":17,"card_id":37,"series":[]}]}	f	f	\N
325	Dashboard	4	1	2017-12-12 18:43:28.175+00	{"description":null,"name":"Numeros Eventos","cards":[{"sizeX":6,"sizeY":4,"row":0,"col":12,"id":16,"card_id":54,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":15,"card_id":36,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":6,"id":17,"card_id":37,"series":[]}]}	f	f	\N
326	Dashboard	4	1	2017-12-12 18:43:28.286+00	{"description":null,"name":"Numeros Eventos","cards":[{"sizeX":6,"sizeY":4,"row":0,"col":12,"id":16,"card_id":54,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":15,"card_id":36,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":6,"id":17,"card_id":37,"series":[]}]}	f	f	\N
327	Dashboard	4	1	2017-12-12 18:44:48.621+00	{"description":null,"name":"Numeros Eventos","cards":[{"sizeX":6,"sizeY":4,"row":0,"col":12,"id":16,"card_id":54,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":15,"card_id":36,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":6,"id":17,"card_id":37,"series":[]}]}	f	f	\N
328	Dashboard	4	1	2017-12-12 18:44:48.789+00	{"description":null,"name":"Numeros Eventos","cards":[{"sizeX":6,"sizeY":4,"row":0,"col":12,"id":16,"card_id":54,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":15,"card_id":36,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":6,"id":17,"card_id":37,"series":[]}]}	f	f	\N
330	Dashboard	5	1	2017-12-12 18:46:10.873+00	{"description":null,"name":"Numeros Espaços","cards":[{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":18,"card_id":46,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":19,"card_id":55,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":20,"card_id":45,"series":[]}]}	f	f	\N
331	Dashboard	5	1	2017-12-12 18:46:10.91+00	{"description":null,"name":"Numeros Espaços","cards":[{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":18,"card_id":46,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":19,"card_id":55,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":20,"card_id":45,"series":[]}]}	f	f	\N
332	Dashboard	5	1	2017-12-12 18:46:10.962+00	{"description":null,"name":"Numeros Espaços","cards":[{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":18,"card_id":46,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":19,"card_id":55,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":20,"card_id":45,"series":[]}]}	f	f	\N
333	Dashboard	5	1	2017-12-12 18:46:11.032+00	{"description":null,"name":"Numeros Espaços","cards":[{"sizeX":7,"sizeY":4,"row":0,"col":6,"id":18,"card_id":46,"series":[]},{"sizeX":5,"sizeY":4,"row":0,"col":13,"id":19,"card_id":55,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":20,"card_id":45,"series":[]}]}	f	f	\N
337	Dashboard	6	1	2017-12-12 18:47:27.534+00	{"description":null,"name":"Numeros Projetos","cards":[]}	f	t	\N
338	Dashboard	6	1	2017-12-12 18:47:53.652+00	{"description":null,"name":"Numeros Projetos","cards":[{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":22,"card_id":50,"series":[]}]}	f	f	\N
339	Dashboard	6	1	2017-12-12 18:47:53.82+00	{"description":null,"name":"Numeros Projetos","cards":[{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":21,"card_id":49,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":22,"card_id":50,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":23,"card_id":56,"series":[]}]}	f	f	\N
341	Dashboard	6	1	2017-12-12 18:47:54.078+00	{"description":null,"name":"Numeros Projetos","cards":[{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":21,"card_id":49,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":6,"id":22,"card_id":50,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":12,"id":23,"card_id":56,"series":[]}]}	f	f	\N
342	Dashboard	6	1	2017-12-12 18:47:54.117+00	{"description":null,"name":"Numeros Projetos","cards":[{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":21,"card_id":49,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":6,"id":22,"card_id":50,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":12,"id":23,"card_id":56,"series":[]}]}	f	f	\N
361	Dashboard	8	1	2017-12-12 18:52:34.309+00	{"description":null,"name":"Numeros Bibliotecas","cards":[{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":27,"card_id":38,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":12,"id":28,"card_id":43,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":6,"id":29,"card_id":39,"series":[]}]}	f	f	\N
334	Dashboard	5	1	2017-12-12 18:46:11.082+00	{"description":null,"name":"Numeros Espaços","cards":[{"sizeX":7,"sizeY":4,"row":0,"col":6,"id":18,"card_id":46,"series":[]},{"sizeX":5,"sizeY":4,"row":0,"col":13,"id":19,"card_id":55,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":20,"card_id":45,"series":[]}]}	f	f	\N
335	Dashboard	5	1	2017-12-12 18:46:15.886+00	{"description":null,"name":"Numeros Espaços","cards":[{"sizeX":7,"sizeY":4,"row":0,"col":6,"id":18,"card_id":46,"series":[]},{"sizeX":5,"sizeY":4,"row":0,"col":13,"id":19,"card_id":55,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":20,"card_id":45,"series":[]}]}	f	f	\N
336	Dashboard	5	1	2017-12-12 18:46:16.046+00	{"description":null,"name":"Numeros Espaços","cards":[{"sizeX":7,"sizeY":4,"row":0,"col":6,"id":18,"card_id":46,"series":[]},{"sizeX":5,"sizeY":4,"row":0,"col":13,"id":19,"card_id":55,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":20,"card_id":45,"series":[]}]}	f	f	\N
340	Dashboard	6	1	2017-12-12 18:47:53.842+00	{"description":null,"name":"Numeros Projetos","cards":[{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":21,"card_id":49,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":22,"card_id":50,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":23,"card_id":56,"series":[]}]}	f	f	\N
343	Dashboard	6	1	2017-12-12 18:47:57.986+00	{"description":null,"name":"Numeros Projetos","cards":[{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":21,"card_id":49,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":6,"id":22,"card_id":50,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":12,"id":23,"card_id":56,"series":[]}]}	f	f	\N
344	Dashboard	6	1	2017-12-12 18:47:58.092+00	{"description":null,"name":"Numeros Projetos","cards":[{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":21,"card_id":49,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":6,"id":22,"card_id":50,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":12,"id":23,"card_id":56,"series":[]}]}	f	f	\N
345	Dashboard	7	1	2017-12-12 18:49:20.155+00	{"description":null,"name":"Numeros Museus","cards":[]}	f	t	\N
346	Dashboard	7	1	2017-12-12 18:50:18.498+00	{"description":null,"name":"Numeros Museus","cards":[{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":24,"card_id":43,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":26,"card_id":23,"series":[]}]}	f	f	\N
347	Dashboard	7	1	2017-12-12 18:50:18.534+00	{"description":null,"name":"Numeros Museus","cards":[{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":24,"card_id":43,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":25,"card_id":47,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":26,"card_id":23,"series":[]}]}	f	f	\N
348	Dashboard	7	1	2017-12-12 18:50:18.592+00	{"description":null,"name":"Numeros Museus","cards":[{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":24,"card_id":43,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":25,"card_id":47,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":26,"card_id":23,"series":[]}]}	f	f	\N
349	Dashboard	7	1	2017-12-12 18:50:18.699+00	{"description":null,"name":"Numeros Museus","cards":[{"sizeX":4,"sizeY":6,"row":0,"col":12,"id":24,"card_id":43,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":25,"card_id":47,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":6,"id":26,"card_id":23,"series":[]}]}	f	f	\N
350	Dashboard	7	1	2017-12-12 18:50:18.738+00	{"description":null,"name":"Numeros Museus","cards":[{"sizeX":4,"sizeY":6,"row":0,"col":12,"id":24,"card_id":43,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":25,"card_id":47,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":6,"id":26,"card_id":23,"series":[]}]}	f	f	\N
351	Dashboard	7	1	2017-12-12 18:50:50.449+00	{"description":null,"name":"Numeros Museus","cards":[{"sizeX":6,"sizeY":4,"row":0,"col":12,"id":24,"card_id":43,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":25,"card_id":47,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":6,"id":26,"card_id":23,"series":[]}]}	f	f	\N
353	Dashboard	7	1	2017-12-12 18:51:06.476+00	{"description":null,"name":"Numeros Museus","cards":[{"sizeX":6,"sizeY":4,"row":0,"col":12,"id":24,"card_id":43,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":25,"card_id":47,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":6,"id":26,"card_id":23,"series":[]}]}	f	f	\N
354	Dashboard	7	1	2017-12-12 18:51:06.529+00	{"description":null,"name":"Numeros Museus","cards":[{"sizeX":6,"sizeY":4,"row":0,"col":12,"id":24,"card_id":43,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":25,"card_id":47,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":6,"id":26,"card_id":23,"series":[]}]}	f	f	\N
356	Dashboard	8	1	2017-12-12 18:52:29.575+00	{"description":null,"name":"Numeros Bibliotecas","cards":[{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":28,"card_id":43,"series":[]}]}	f	f	\N
357	Dashboard	8	1	2017-12-12 18:52:29.612+00	{"description":null,"name":"Numeros Bibliotecas","cards":[{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":27,"card_id":38,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":28,"card_id":43,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":29,"card_id":39,"series":[]}]}	f	f	\N
358	Dashboard	8	1	2017-12-12 18:52:29.64+00	{"description":null,"name":"Numeros Bibliotecas","cards":[{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":27,"card_id":38,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":28,"card_id":43,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":29,"card_id":39,"series":[]}]}	f	f	\N
359	Dashboard	8	1	2017-12-12 18:52:29.853+00	{"description":null,"name":"Numeros Bibliotecas","cards":[{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":27,"card_id":38,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":12,"id":28,"card_id":43,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":6,"id":29,"card_id":39,"series":[]}]}	f	f	\N
360	Dashboard	8	1	2017-12-12 18:52:29.883+00	{"description":null,"name":"Numeros Bibliotecas","cards":[{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":27,"card_id":38,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":12,"id":28,"card_id":43,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":6,"id":29,"card_id":39,"series":[]}]}	f	f	\N
362	Dashboard	8	1	2017-12-12 18:52:34.468+00	{"description":null,"name":"Numeros Bibliotecas","cards":[{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":27,"card_id":38,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":12,"id":28,"card_id":43,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":6,"id":29,"card_id":39,"series":[]}]}	f	f	\N
352	Dashboard	7	1	2017-12-12 18:50:50.51+00	{"description":null,"name":"Numeros Museus","cards":[{"sizeX":6,"sizeY":4,"row":0,"col":12,"id":24,"card_id":43,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":0,"id":25,"card_id":47,"series":[]},{"sizeX":6,"sizeY":4,"row":0,"col":6,"id":26,"card_id":23,"series":[]}]}	f	f	\N
355	Dashboard	8	1	2017-12-12 18:51:47.346+00	{"description":null,"name":"Numeros Bibliotecas","cards":[]}	f	t	\N
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
site-name	Quero Cultura
admin-email	querocultura61@gmail.com
anon-tracking-enabled	true
enable-embedding	true
embedding-secret-key	1798c3ba25f5799bd75538a7fe2896b79e24f3ec1df9d921558899dc690bbcd9
site-url	http://metabase:3000/metabase
version-info	{"latest":{"version":"v0.27.1","released":"2017-29-27T11:09:36.358Z","patch":true,"highlights":["Migration bug fix","Apply filters to embedded downloads"]},"older":[{"version":"v0.27.0","released":"2017-28-27T11:09:36.358Z","patch":false,"highlights":["Alerts","X-Ray insights","Charting improvements"]},{"version":"v0.26.2","released":"2017-09-27T11:09:36.358Z","patch":true,"highlights":["Update Redshift Driver","Support Java 9","Fix performance issue with fields listing"]},{"version":"v0.26.1","released":"2017-09-27T11:09:36.358Z","patch":true,"highlights":["Fix migration issue on MySQL"]},{"version":"v0.26.0","released":"2017-09-26T11:09:36.358Z","patch":true,"highlights":["Segment + Metric X-Rays and Comparisons","Better control over metadata introspection process","Improved Timezone support and bug fixes"]},{"version":"v0.25.2","released":"2017-08-09T11:09:36.358Z","patch":true,"highlights":["Bug and performance fixes"]},{"version":"v0.25.1","released":"2017-07-27T11:09:36.358Z","patch":true,"highlights":["After upgrading to 0.25, unknown protocol error.","Don't show saved questions in the permissions database lists","Elastic beanstalk upgrades broken in 0.25 "]},{"version":"v0.25.0","released":"2017-07-25T11:09:36.358Z","patch":false,"highlights":["Nested questions","Enum and custom remapping support","LDAP authentication support"]},{"version":"v0.24.2","released":"2017-06-01T11:09:36.358Z","patch":true,"highlights":["Misc Bug fixes"]},{"version":"v0.24.1","released":"2017-05-10T11:09:36.358Z","patch":true,"highlights":["Fix upgrades with MySQL/Mariadb"]},{"version":"v0.24.0","released":"2017-05-10T11:09:36.358Z","patch":false,"highlights":["Drill-through + Actions","Result Caching","Presto Driver"]},{"version":"v0.23.1","released":"2017-03-30T11:09:36.358Z","patch":true,"highlights":["Filter widgets for SQL Template Variables","Fix spurious startup error","Java 7 startup bug fixed"]},{"version":"v0.23.0","released":"2017-03-21T11:09:36.358Z","patch":false,"highlights":["Public links for cards + dashboards","Embedding cards + dashboards in other applications","Encryption of database credentials"]},{"version":"v0.22.2","released":"2017-01-10T11:09:36.358Z","patch":true,"highlights":["Fix startup on OpenJDK 7"]},{"version":"v0.22.1","released":"2017-01-10T11:09:36.358Z","patch":true,"highlights":["IMPORTANT: Closed a Collections Permissions security hole","Improved startup performance","Bug fixes"]},{"version":"v0.22.0","released":"2017-01-10T11:09:36.358Z","patch":false,"highlights":["Collections + Collections Permissions","Multiple Aggregations","Custom Expressions"]},{"version":"v0.21.1","released":"2016-12-08T11:09:36.358Z","patch":true,"highlights":["BigQuery bug fixes","Charting bug fixes"]},{"version":"v0.21.0","released":"2016-12-08T11:09:36.358Z","patch":false,"highlights":["Google Analytics Driver","Vertica Driver","Better Time + Date Filters"]},{"version":"v0.20.3","released":"2016-10-26T11:09:36.358Z","patch":true,"highlights":["Fix H2->MySQL/PostgreSQL migrations, part 2"]},{"version":"v0.20.2","released":"2016-10-25T11:09:36.358Z","patch":true,"highlights":["Support Oracle 10+11","Fix H2->MySQL/PostgreSQL migrations","Revision timestamp fix"]},{"version":"v0.20.1","released":"2016-10-18T11:09:36.358Z","patch":true,"highlights":["Lots of bug fixes"]},{"version":"v0.20.0","released":"2016-10-11T11:09:36.358Z","patch":false,"highlights":["Data access permissions","Oracle Driver","Charting improvements"]},{"version":"v0.19.3","released":"2016-08-12T11:09:36.358Z","patch":true,"highlights":["fix Dashboard editing header"]},{"version":"v0.19.2","released":"2016-08-10T11:09:36.358Z","patch":true,"highlights":["fix Dashboard chart titles","fix pin map saving"]},{"version":"v0.19.1","released":"2016-08-04T11:09:36.358Z","patch":true,"highlights":["fix Dashboard Filter Editing","fix CSV Download of SQL Templates","fix Metabot enabled toggle"]},{"version":"v0.19.0","released":"2016-08-01T21:09:36.358Z","patch":false,"highlights":["SSO via Google Accounts","SQL Templates","Better charting controls"]},{"version":"v0.18.1","released":"2016-06-29T21:09:36.358Z","patch":true,"highlights":["Fix for Hour of day sorting bug","Fix for Column ordering bug in BigQuery","Fix for Mongo charting bug"]},{"version":"v0.18.0","released":"2016-06-022T21:09:36.358Z","patch":false,"highlights":["Dashboard Filters","Crate.IO Support","Checklist for Metabase Admins","Converting Metabase Questions -> SQL"]},{"version":"v0.17.1","released":"2016-05-04T21:09:36.358Z","patch":true,"highlights":["Fix for Line chart ordering bug","Fix for Time granularity bugs"]},{"version":"v0.17.0","released":"2016-05-04T21:09:36.358Z","patch":false,"highlights":["Tags + Search for Saved Questions","Calculated columns","Faster Syncing of Metadata","Lots of database driver improvements and bug fixes"]},{"version":"v0.16.1","released":"2016-05-04T21:09:36.358Z","patch":true,"highlights":["Fixes for several time alignment issues (timezones)","Resolved problem with SQL Server db connections"]},{"version":"v0.16.0","released":"2016-05-04T21:09:36.358Z","patch":false,"highlights":["Fullscreen (and fabulous) Dashboards","Say hello to Metabot in Slack"]}]}
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
193	1	card	30	2017-11-21 03:37:10.687+00
194	1	card	31	2017-11-21 03:41:35.716+00
195	1	card	32	2017-11-21 03:42:30.528+00
196	1	card	33	2017-11-21 03:44:57.68+00
197	1	card	31	2017-11-21 03:46:14.1+00
198	1	card	30	2017-11-21 03:46:34.292+00
199	1	card	33	2017-11-21 03:46:46.883+00
200	1	card	32	2017-11-21 03:46:58.884+00
201	1	card	31	2017-11-21 03:51:19.93+00
202	1	card	32	2017-11-21 03:51:33.568+00
203	1	card	34	2017-11-25 19:04:26.344+00
204	1	card	34	2017-11-25 19:04:48.586+00
205	1	card	34	2017-11-25 19:04:56.091+00
206	1	card	34	2017-11-25 19:05:13.262+00
207	1	card	35	2017-11-25 19:06:12.419+00
208	1	card	35	2017-11-25 19:06:38.187+00
209	1	card	36	2017-11-26 17:58:11.724+00
210	1	card	36	2017-11-26 18:11:21.108+00
211	1	card	36	2017-11-26 18:11:27.839+00
212	1	card	36	2017-11-26 18:11:36.436+00
213	1	card	37	2017-11-26 18:12:18.454+00
214	1	card	37	2017-11-26 18:12:43.002+00
215	1	card	37	2017-11-26 19:03:50.412+00
216	1	card	28	2017-11-29 23:19:36.138+00
217	1	card	25	2017-11-29 23:19:46.054+00
218	1	card	25	2017-11-29 23:20:15.709+00
219	1	card	25	2017-11-29 23:21:09.603+00
220	1	card	26	2017-11-29 23:21:15.774+00
221	1	card	26	2017-11-29 23:21:38.344+00
222	1	card	25	2017-11-29 23:22:33.705+00
223	1	card	28	2017-11-29 23:23:08.137+00
224	1	card	29	2017-11-29 23:23:14.127+00
225	1	card	29	2017-11-29 23:23:47.207+00
226	1	card	27	2017-11-29 23:23:51.47+00
227	1	card	27	2017-11-29 23:25:56.475+00
228	1	card	29	2017-11-29 23:26:56.183+00
229	1	card	29	2017-11-29 23:29:05.546+00
230	1	card	27	2017-11-29 23:29:10.375+00
231	1	card	27	2017-11-29 23:29:43.904+00
232	1	card	27	2017-11-29 23:29:47.368+00
233	1	card	29	2017-11-29 23:29:49.45+00
234	1	card	26	2017-11-29 23:29:51.161+00
235	1	card	25	2017-11-29 23:29:55.758+00
236	1	card	28	2017-11-29 23:29:58.125+00
237	1	card	35	2017-11-29 23:30:46.238+00
238	1	card	34	2017-11-29 23:30:52.15+00
239	1	card	34	2017-11-29 23:31:18.296+00
240	1	card	38	2017-11-29 23:31:40.441+00
241	1	card	35	2017-11-29 23:31:56.836+00
242	1	card	39	2017-11-29 23:32:53.525+00
243	1	card	28	2017-11-29 23:34:12.68+00
244	1	card	38	2017-11-29 23:34:30.658+00
245	1	card	38	2017-11-29 23:35:29.306+00
246	1	card	39	2017-11-29 23:35:41.674+00
247	1	card	24	2017-11-29 23:50:27.562+00
248	1	card	22	2017-11-29 23:50:34.508+00
249	1	card	22	2017-11-29 23:51:25.302+00
250	1	card	22	2017-11-29 23:51:26.603+00
251	1	card	20	2017-11-29 23:51:32.027+00
252	1	card	22	2017-11-29 23:52:13.128+00
253	1	card	21	2017-11-29 23:52:16.941+00
254	1	card	19	2017-11-29 23:52:34.513+00
255	1	card	23	2017-11-29 23:53:03.308+00
256	1	card	40	2017-11-29 23:54:44.447+00
257	1	card	38	2017-11-29 23:54:54.284+00
258	1	card	40	2017-11-29 23:55:06.963+00
259	1	card	23	2017-11-29 23:55:30.449+00
260	1	card	18	2017-11-29 23:56:06.882+00
261	1	card	24	2017-11-29 23:57:01.811+00
262	1	card	29	2017-11-29 23:57:29.251+00
263	1	card	29	2017-11-29 23:57:43.69+00
264	1	card	41	2017-11-30 00:00:50.043+00
265	1	card	24	2017-11-30 00:01:02.484+00
266	1	card	20	2017-11-30 00:01:51.669+00
267	1	card	22	2017-11-30 00:02:12.225+00
268	1	card	23	2017-11-30 00:02:16.698+00
269	1	card	41	2017-11-30 00:02:20.416+00
270	1	card	40	2017-11-30 00:02:26.541+00
271	1	card	42	2017-11-30 00:03:31.812+00
272	1	card	24	2017-11-30 00:03:47.006+00
273	1	card	24	2017-11-30 00:03:58.22+00
274	1	card	24	2017-11-30 00:04:17.629+00
277	1	card	23	2017-11-30 00:04:47.775+00
279	1	card	24	2017-11-30 00:05:35.886+00
280	1	card	20	2017-11-30 00:05:36.633+00
283	1	card	42	2017-11-30 00:05:39.915+00
284	1	card	23	2017-11-30 00:05:42.008+00
285	1	card	40	2017-11-30 00:05:43.252+00
306	1	card	23	2017-11-30 00:13:52.634+00
307	1	card	41	2017-11-30 00:13:53.572+00
309	1	card	42	2017-11-30 00:13:54.766+00
275	1	card	20	2017-11-30 00:04:23.601+00
276	1	card	22	2017-11-30 00:04:35.064+00
278	1	card	41	2017-11-30 00:05:09.71+00
281	1	card	22	2017-11-30 00:05:37.098+00
286	1	card	41	2017-11-30 00:06:53.867+00
282	1	card	41	2017-11-30 00:05:38.619+00
295	1	card	29	2017-11-30 00:12:24.549+00
287	1	card	28	2017-11-30 00:08:33.277+00
288	1	card	25	2017-11-30 00:08:34.345+00
290	1	card	39	2017-11-30 00:08:35.643+00
289	1	card	26	2017-11-30 00:08:35.119+00
291	1	card	29	2017-11-30 00:08:36.39+00
292	1	card	27	2017-11-30 00:08:37.304+00
293	1	card	38	2017-11-30 00:08:37.636+00
294	1	card	28	2017-11-30 00:12:17.733+00
296	1	card	28	2017-11-30 00:13:30.441+00
297	1	card	25	2017-11-30 00:13:31.147+00
298	1	card	26	2017-11-30 00:13:32.283+00
299	1	card	39	2017-11-30 00:13:33.292+00
300	1	card	29	2017-11-30 00:13:34.65+00
301	1	card	38	2017-11-30 00:13:35.37+00
302	1	card	27	2017-11-30 00:13:36.018+00
303	1	card	24	2017-11-30 00:13:49.918+00
304	1	card	20	2017-11-30 00:13:50.57+00
305	1	card	22	2017-11-30 00:13:51.846+00
308	1	card	40	2017-11-30 00:13:54.185+00
310	1	card	43	2017-12-01 23:55:36.933+00
311	1	card	44	2017-12-01 23:55:37.083+00
312	1	card	44	2017-12-01 23:56:08.708+00
313	1	card	44	2017-12-01 23:56:29.037+00
314	1	card	44	2017-12-01 23:56:36.966+00
315	1	card	44	2017-12-01 23:58:35.627+00
316	1	card	45	2017-12-02 00:04:47.831+00
317	1	card	46	2017-12-02 00:05:34.528+00
318	1	card	46	2017-12-02 00:07:14.163+00
319	1	card	46	2017-12-02 00:10:23.228+00
320	1	card	45	2017-12-02 00:12:03.811+00
321	1	card	45	2017-12-02 00:12:28.129+00
322	1	card	46	2017-12-02 00:14:12.925+00
323	1	card	47	2017-12-02 00:18:13.432+00
324	1	card	47	2017-12-02 00:18:24.379+00
325	1	card	48	2017-12-02 00:19:41.484+00
326	1	card	48	2017-12-02 00:19:49.849+00
327	1	card	48	2017-12-02 00:20:40.3+00
328	1	card	23	2017-12-02 00:21:09.181+00
329	1	card	39	2017-12-02 00:22:55.96+00
330	1	card	49	2017-12-05 01:43:19.69+00
331	1	card	49	2017-12-05 01:43:49.181+00
332	1	card	49	2017-12-05 01:44:03.8+00
333	1	card	50	2017-12-05 01:45:20.159+00
334	1	card	50	2017-12-05 01:45:43.43+00
335	1	card	50	2017-12-05 01:46:54.069+00
336	1	card	33	2017-12-05 03:03:58.069+00
337	1	card	2	2017-12-05 03:04:24.401+00
338	1	card	13	2017-12-05 03:06:17.055+00
339	1	card	10	2017-12-05 03:06:20.564+00
340	1	card	12	2017-12-05 03:06:24.902+00
341	1	card	22	2017-12-05 03:06:32.824+00
342	1	card	41	2017-12-05 03:06:37.464+00
343	1	card	42	2017-12-05 03:06:42.708+00
344	1	card	17	2017-12-05 03:07:17.125+00
345	1	card	17	2017-12-05 03:07:46.203+00
346	1	card	33	2017-12-05 03:07:57.482+00
347	1	card	3	2017-12-05 03:08:28.406+00
348	1	card	7	2017-12-05 03:08:32.505+00
349	1	card	34	2017-12-05 03:11:21.475+00
350	1	card	35	2017-12-05 03:11:35.422+00
351	1	dashboard	2	2017-12-05 03:12:41.971+00
352	1	dashboard	2	2017-12-05 03:14:23.3+00
353	1	dashboard	2	2017-12-05 03:29:00.262+00
354	1	card	51	2017-12-07 23:37:29.199+00
355	1	card	51	2017-12-07 23:38:51.498+00
356	1	card	17	2017-12-10 00:50:29.042+00
357	1	card	17	2017-12-10 00:51:45.753+00
358	1	card	17	2017-12-10 00:51:46.805+00
359	1	card	2	2017-12-10 00:51:55.961+00
360	1	card	41	2017-12-10 10:41:48.475+00
361	1	card	14	2017-12-10 10:43:19.045+00
362	1	card	15	2017-12-10 10:44:26.451+00
363	1	card	17	2017-12-10 10:45:48.85+00
364	1	card	17	2017-12-10 10:46:43.163+00
365	1	card	17	2017-12-10 10:46:45.78+00
366	1	card	17	2017-12-10 10:46:46.446+00
367	1	card	15	2017-12-10 10:46:48.185+00
368	1	card	15	2017-12-10 10:46:49.017+00
369	1	card	15	2017-12-10 10:46:49.615+00
370	1	card	14	2017-12-10 10:46:51.042+00
371	1	card	14	2017-12-10 10:46:51.911+00
372	1	card	2	2017-12-10 10:47:13.835+00
373	1	card	4	2017-12-10 10:48:06.203+00
374	1	card	3	2017-12-10 10:48:43.485+00
375	1	card	7	2017-12-10 10:49:52.081+00
376	1	card	6	2017-12-10 10:50:43.04+00
377	1	card	31	2017-12-10 10:51:24.214+00
378	1	card	31	2017-12-10 10:51:46.736+00
379	1	card	31	2017-12-10 10:51:49.205+00
380	1	card	33	2017-12-10 10:52:03.357+00
381	1	card	32	2017-12-10 10:52:39.715+00
382	1	card	11	2017-12-10 10:53:22.069+00
383	1	card	12	2017-12-10 10:53:40.968+00
384	1	card	10	2017-12-10 10:53:45.781+00
385	1	card	13	2017-12-10 10:54:20.194+00
386	1	card	24	2017-12-10 10:55:12.16+00
387	1	dashboard	1	2017-12-10 11:59:55.72+00
388	1	card	15	2017-12-10 12:00:27.246+00
389	1	card	15	2017-12-10 12:00:52.175+00
390	1	card	52	2017-12-10 12:02:39.471+00
391	1	card	52	2017-12-11 20:17:56.203+00
392	1	card	31	2017-12-11 20:18:39.952+00
393	1	card	51	2017-12-12 02:12:53.143+00
394	1	card	52	2017-12-12 02:13:03.095+00
395	1	card	53	2017-12-12 15:57:47.702+00
396	1	card	53	2017-12-12 15:58:28.611+00
397	1	card	53	2017-12-12 16:01:11.359+00
398	1	card	54	2017-12-12 16:03:34.952+00
399	1	card	55	2017-12-12 16:06:43.696+00
400	1	card	56	2017-12-12 16:08:01.753+00
401	1	dashboard	3	2017-12-12 18:15:52.873+00
402	1	dashboard	3	2017-12-12 18:18:44.967+00
403	1	dashboard	4	2017-12-12 18:41:43.064+00
404	1	dashboard	4	2017-12-12 18:43:28.315+00
405	1	dashboard	4	2017-12-12 18:45:21.363+00
406	1	dashboard	5	2017-12-12 18:45:44.197+00
407	1	dashboard	5	2017-12-12 18:46:11.115+00
408	1	dashboard	5	2017-12-12 18:47:10.644+00
409	1	dashboard	6	2017-12-12 18:47:27.578+00
410	1	dashboard	6	2017-12-12 18:47:54.14+00
411	1	dashboard	6	2017-12-12 18:49:06.038+00
412	1	dashboard	7	2017-12-12 18:49:20.192+00
414	1	dashboard	7	2017-12-12 18:50:36.479+00
416	1	dashboard	7	2017-12-12 18:50:50.512+00
419	1	dashboard	8	2017-12-12 18:52:29.894+00
413	1	dashboard	7	2017-12-12 18:50:18.762+00
415	1	dashboard	7	2017-12-12 18:50:41.251+00
417	1	dashboard	7	2017-12-12 18:51:36.064+00
418	1	dashboard	8	2017-12-12 18:51:47.386+00
\.


--
-- Name: activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('activity_id_seq', 301, true);


--
-- Name: card_label_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('card_label_id_seq', 1, false);


--
-- Name: collection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('collection_id_seq', 6, true);


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

SELECT pg_catalog.setval('metabase_field_id_seq', 681, true);


--
-- Name: metabase_fieldvalues_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('metabase_fieldvalues_id_seq', 113, true);


--
-- Name: metabase_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('metabase_table_id_seq', 36, true);


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

SELECT pg_catalog.setval('query_execution_id_seq', 2598, true);


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

SELECT pg_catalog.setval('report_card_id_seq', 56, true);


--
-- Name: report_cardfavorite_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('report_cardfavorite_id_seq', 1, false);


--
-- Name: report_dashboard_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('report_dashboard_id_seq', 8, true);


--
-- Name: report_dashboardcard_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('report_dashboardcard_id_seq', 29, true);


--
-- Name: revision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('revision_id_seq', 362, true);


--
-- Name: segment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('segment_id_seq', 1, false);


--
-- Name: view_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: quero_cultura
--

SELECT pg_catalog.setval('view_log_id_seq', 419, true);


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
-- Name: metabase_field fk_field_ref_table_id; Type: FK CONSTRAINT; Schema: public; Owner: quero_cultura
--

ALTER TABLE ONLY metabase_field
    ADD CONSTRAINT fk_field_ref_table_id FOREIGN KEY (table_id) REFERENCES metabase_table(id);


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

