--CREATE DATABASE bankapp;

CREATE TABLE "accounts" (
  "id" bigserial PRIMARY KEY,
  "balance" bigint,
  "user_id" bigserial,
  "currency" varchar,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "user_accounts" (
  "id" bigserial PRIMARY KEY,
  "account_type" varchar,
  "account_id" bigserial,
  "user_id" bigserial
);

CREATE TABLE "entries" (
  "id" bigserial PRIMARY KEY ,
  "account_id" bigint,
  "amount" bigint NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "transfers" (
  "id" bigserial PRIMARY KEY ,
  "from_account_id" bigint,
  "to_account_id" bigint,
  "amount" bigint,
  "created_at" timestamptz DEFAULT (now())
);

CREATE TABLE "users" (
  "id" bigint PRIMARY KEY,
  "firstname" varchar NOT NULL,
  "lastname" varchar NOT NULL,
  "telephone" bigint,
  "date_of_birth" date NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now()),
  "from_transfers_id" bigint,
  "from_account_id" bigint,
  "from_entries_id" bigint
);

CREATE INDEX ON "accounts" ("user_id");

CREATE INDEX ON "entries" ("account_id");

CREATE INDEX ON "transfers" ("from_account_id", "to_account_id");

CREATE INDEX ON "transfers" ("from_account_id", "to_account_id");

CREATE INDEX ON "users" ("id", "from_transfers_id", "from_account_id", "from_entries_id");

ALTER TABLE "accounts" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "user_accounts" ADD FOREIGN KEY ("account_id") REFERENCES "accounts" ("id");

ALTER TABLE "user_accounts" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "entries" ADD FOREIGN KEY ("account_id") REFERENCES "accounts" ("id");

ALTER TABLE "transfers" ADD FOREIGN KEY ("from_account_id") REFERENCES "accounts" ("id");

ALTER TABLE "transfers" ADD FOREIGN KEY ("to_account_id") REFERENCES "accounts" ("id");

ALTER TABLE "users" ADD FOREIGN KEY ("from_transfers_id") REFERENCES "transfers" ("id");

ALTER TABLE "users" ADD FOREIGN KEY ("from_account_id") REFERENCES "accounts" ("id");

ALTER TABLE "users" ADD FOREIGN KEY ("from_entries_id") REFERENCES "entries" ("id");
