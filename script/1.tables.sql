CREATE TABLE "public"."osm_nodes" (
   "id" bigint NOT NULL,
   "timestamp" timestamptz NOT NULL,
   "lat" double precision NOT NULL,
   "lon" double precision NOT NULL,
   "uid" int NOT NULL,
   "user" character varying(256) NOT NULL,
   "version" int NOT NULL,
   "tags" jsonb NOT NULL,
   "timestamp_update" timestamptz DEFAULT NOW(),
   "timestamp_creation" timestamptz DEFAULT NOW()
) WITH (oids = false);

CREATE TABLE "public"."osm_sequence" (
   "seq" bigint NOT NULL,
   "timestamp" timestamptz NOT NULL
) WITH (oids = false);

CREATE FUNCTION update_modified_column()   
RETURNS TRIGGER AS $$
BEGIN
    NEW.timestamp_update = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_osm_nodes_modtime BEFORE UPDATE ON osm_nodes FOR EACH ROW EXECUTE PROCEDURE update_modified_column();
