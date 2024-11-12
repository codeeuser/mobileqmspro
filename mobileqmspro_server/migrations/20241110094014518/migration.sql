BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "token_issued" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "token_issued" (
    "id" bigserial PRIMARY KEY,
    "tokenLetter" text NOT NULL,
    "tokenNumber" bigint NOT NULL,
    "statusName" text NOT NULL,
    "statusCode" bigint NOT NULL,
    "statusAcronym" text NOT NULL,
    "isOnWait" boolean NOT NULL,
    "isOnQueue" boolean NOT NULL,
    "isRecall" boolean NOT NULL,
    "isCompleted" boolean NOT NULL,
    "reset" boolean NOT NULL,
    "createdDate" timestamp without time zone NOT NULL,
    "assignedDate" timestamp without time zone,
    "modifiedDate" timestamp without time zone,
    "queueWindowId" bigint NOT NULL,
    "queueServiceId" bigint NOT NULL,
    "profileUserId" bigint NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "token_issued"
    ADD CONSTRAINT "token_issued_fk_0"
    FOREIGN KEY("queueWindowId")
    REFERENCES "queue_window"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "token_issued"
    ADD CONSTRAINT "token_issued_fk_1"
    FOREIGN KEY("queueServiceId")
    REFERENCES "queue_service"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "token_issued"
    ADD CONSTRAINT "token_issued_fk_2"
    FOREIGN KEY("profileUserId")
    REFERENCES "profile_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR mobileqmspro
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('mobileqmspro', '20241110094014518', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20241110094014518', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();


COMMIT;
