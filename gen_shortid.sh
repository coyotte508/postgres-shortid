#!/bin/bash
set -e

# Add function gen_shortid()

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  -- For gen_random_bytes()
  CREATE EXTENSION IF NOT EXISTS "pgcrypto";

	CREATE OR REPLACE FUNCTION gen_shortid(bytes integer DEFAULT 7) RETURNS text AS 
	\$\$
	DECLARE key TEXT;
	BEGIN
		-- Generate our string bytes and re-encode as a base64 string.
		-- Random collision chance: on average once after 268 M records in the table: Math.sqrt(Math.pow(256, 7))
    key := encode(gen_random_bytes(bytes), 'base64');

    -- Base64 encoding contains 2 URL unsafe characters by default.
    -- The URL-safe version has these replacements.
    key := replace(key, '/', '_'); -- url safe replacement
    key := replace(key, '+', '-');

		RETURN key;
	END;
	\$\$ 
	LANGUAGE "plpgsql";
EOSQL
