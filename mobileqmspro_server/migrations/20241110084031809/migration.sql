BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "profile_user" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "profile_user" (
    "id" bigserial PRIMARY KEY,
    "username" text,
    "email" text NOT NULL,
    "phone" text,
    "passcode" text NOT NULL,
    "verified" boolean,
    "membership" text NOT NULL,
    "ipAddress" text,
    "birthDate" timestamp without time zone,
    "gender" text,
    "createdDate" timestamp without time zone NOT NULL,
    "modifiedDate" timestamp without time zone
);


--
-- MIGRATION VERSION FOR mobileqmspro
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('mobileqmspro', '20241110084031809', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20241110084031809', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
