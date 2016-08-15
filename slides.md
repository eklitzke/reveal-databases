# Databases

### Evan Klitzke / evan@uber.com

---

## Outline

 * ACID
 * Indexes
 * SQL vs NoSQL

---

# ACID

Canonical term for the properties a database should provide; definitely coined
by hippies who understood the pun they were making.

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

By convention keywords are all caps, and table names and column names are
lowercase.

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

# Indexes

No, they're not *indices*.

---

## Querying

One of the important things that databases let you do is efficiently query data.
Examples of questions you might want to query:

 * How many trips has a given user taken?
 * What's the average fare in London over the last 30 days?
 * Which drivers have a rating less than 4.0?

---

## Trips Index

How many trips has a given user taken?

```
CREATE INDEX ix_trips ON trips (user_id);

SELECT COUNT(*) FROM trips WHERE user_id = 1;
```

---

## Fare Index

What's the average fare in London over the last 30 days?

```
CREATE INDEX ix_fare ON fares (city_id, when);

SELECT AVG(fare)
  FROM fares
 WHERE city_id = 100
    AND when >= NOW() - INTERVAL('30 days');
```

---

## Rating Index

Which drivers have an average rating less than 4.0?

```
CREATE INDEX ix_rating ON drivers (rating);

SELECT * FROM drivers WHERE rating < 4.0;
```

---

## Index Advantages

Indexes make it so that instead of examining *all* of the data in the database
to answer a query, you can instead just examine a small amount of data. Indexes
make queries fast.

---

## Index Disavantages

Every time a new row is inserted or updated any indexes on that data will have
to be updated. This takes up extra disk space and extra disk I/O.

Having too many indexes makes writes slower.

---

## Index Summary

The **good**: indexes **reduce read I/O**.

The **bad**: indexes **increase write I/O**.

---

# SQL vs. NoSQL

----

![My feelings on the matter...](./chosen-one.gif)

---

## Relational Databases

SQL databases are also called **relational databases**. They feature:

 * The SQL query language
 * Transactions
 * Full ACID semantics
 * Typically are not "distributed"

Popular examples include MySQL and Postgres.

---

## NoSQL Databases

NoSQL databases are **non-relational databases** that:

 * Do not use the SQL query language
 * May not have transactions
 * Typically sacrifice some ACID features
 * Typically are "distributed"

---

## Differences

The differences mostly come down to a difference in philosophies about:

 * How to scale reads and writes
 * How to do high availability

---

## Relational Scaling

Typically relational databases are scaled by having one "master" that can serve
reads and writes, and an arbitrary number of "slaves" that can only serve reads.

This is good if your application is read-heavy, less good if your application is
write-heavy.

---

## NoSQL Scaling

NoSQL databases typically are "masterless", meaning that writes can be
distributed across an arbitrary number of nodes.

This makes scaling writes easier, but typically comes at the cost of less
features, weaker transactionality, etc.

---

## My Opinion

Stick to relational databases if you can.

I personally think the scaling problems for relational databases are over-hyped.
But it really depends on your use case.

---

# The End

### Evan Klitzke / evan@uber.com

You can find this presentation on GitHub at:
**https://github.com/eklitzke/reveal-databases**
