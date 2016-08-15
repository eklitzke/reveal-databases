# Databases
### Evan Klitzke / evan@uber.com

---

## About Me

---

## What Is A Database?

Broadly speaking, a database is a system for storing and querying data. There
are a bunch of kinds:

 * Relational (SQL)
 * Embedded
 * NoSQL

We'll explore what a database **does** to understand the differences.

---

## ACID

 * Atomicity
 * Consistency
 * Isolation
 * Durability

These properties are understood in the context of database transactions.

---

## Transactions

In databases a **transaction** refers to a unit of work done by a database. Most
of the ACID properties are understood in the context of transactions.

The basic idea is: you connect to the database, do one or more transactions, and
then disconnect.

---

## Transactional Model

Transactions in a SQL database:

 * `BEGIN`
 * any # of queries
 * `COMMIT` or `ROLLBACK`

The final operation is `COMMIT` when the results of the transaction should be
saved; or `ROLLBACK` when the results should be discarded.

---

## Queries

The statements run during a transaction are called **queries**. Note that
queries can be things that **read** data from the database, but they can also be
things that **write** data.

---

## ACID Examples

We'll briefly define the terms in ACID. Don't worry if the definitions seem
unclear, they'll make sense once we look at some examples.

---

## Atomicity

Atomicity refers to the idea that everything in a transaction is either
persisted, or isn't. If a transaction updates multiple rows then either **all**
of the rows will be updated or **none** of them will be.

---

## Consistency

Consistency refers to the idea that transactions have consistent views of the
database. This means that during a transaction it appears that the database
isn't changing, even if other transactions are modifying it.

---

## Isolation

Isolation refers to the idea that transactions are isolated from each other.
From the point of view of each transaction it appears that no one else is
modifying the database.

---

## Durability

Durability refers to the idea that data is stored reliably on disk. Unlike with
regular files on your computer, if a database server suddenly loses power (or if
the database itself crashes) the state of the database on disk will be in a well
known state.

---

## SQL

SQL is a really funny programming language. It was designed in the 1970s around
the same time as COBOL, when people though programming languages should look
like spoken English.

---

## Atomicity Example

```
BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE user_id = 1;
UPDATE accounts SET balance = balance + 100 WHERE user_id = 2;
COMMIT;  -- or ROLLBACK
```

---

## Consistency / Isolation Example

Here's an example demonstrating the ideas of **consistency** and **isolation**:

```
T1:   SELECT COUNT(*) FROM accounts;
T2:   INSERT INTO accounts (first_name) VALUES ('evan');
T1:   SELECT COUNT(*) FROM accounts;  -- returns original value
```

Even though *T2* inserts a row into `accounts`, *T1* will not observe the row.
Magic!

---

# The End
### Evan Klitzke / evan@uber.com
