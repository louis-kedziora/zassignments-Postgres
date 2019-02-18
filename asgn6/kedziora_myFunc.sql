PART I

Create Function kedziora_myFunc(dirc varchar, OUT id varchar, OUT year integer,OUT rank float, OUT votes integer) Returns setof record AS '
  WITH movies(pid, id, year) AS
    (SELECT pid, directors.id, year
      FROM directors LEFT JOIN productions ON productions.id = directors.id
      WHERE pid=dirc AND attr is null)
    SELECT movies.id, year, rank, votes
      FROM movies LEFT JOIN ratings ON movies.id = ratings.id
      ORDER BY year;
'LANGUAGE SQL;

              id               | year | rank |  votes
-------------------------------+------+------+---------
 Doodlebug (1997)              | 1997 |  7.1 |   11415
 Following (1998)              | 1998 |  7.6 |   66121
 Memento (2000)                | 2000 |  8.5 |  849849
 Insomnia (2002)               | 2002 |  7.2 |  219782
 Batman Begins (2005)          | 2005 |  8.3 |  986936
 The Prestige (2006)           | 2006 |  8.5 |  849119
 The Exec (2006) {{SUSPENDED}} | 2006 |      |
 The Dark Knight (2008)        | 2008 |    9 | 1685825
 Inception (2010)              | 2010 |  8.8 | 1476746
 The Dark Knight Rises (2012)  | 2012 |  8.5 | 1151061
 Interstellar (2014)           | 2014 |  8.6 |  937348
 Quay (2015)                   | 2015 |    8 |     357
 Dunkirk (2017)                | 2017 |      |
(13 rows)

PART II

CREATE TABLE parts (
  pid integer,
  pname varchar(40),
  color varchar(20)
);

INSERT INTO parts (pid, pname, color)
  VALUES (1, 'spark_plug', 'silver');
INSERT INTO parts (pid, pname, color)
    VALUES (2, 'rims', 'black');
INSERT INTO PARTS(pid,pname,color)
  VALUES(3, 'airbag', 'white');


CREATE TABLE partshistory (
  pid integer,
  pname varchar(40),
  color varchar(20),
  operation char,
  opwhen TIMESTAMP,
  opuser char(20)
);

CREATE OR REPLACE FUNCTION history_log() RETURNS TRIGGER AS $parts_trigger$
  BEGIN
      IF (TG_OP = 'DELETE') THEN
        INSERT INTO partshistory VALUES(new.pid,new.pname,new.color,'D',current_timestamp,current_user);
      ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO partshistory VALUES(new.pid,new.pname,new.color,'U',current_timestamp,current_user);
      ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO partshistory VALUES(new.pid,new.pname,new.color,'I',current_timestamp,current_user);
      END IF;
      RETURN NULL;
  END;
$parts_trigger$ LANGUAGE plpgsql;

CREATE TRIGGER parts_trigger AFTER UPDATE OR INSERT OR DELETE
  ON parts
  FOR EACH ROW
  EXECUTE PROCEDURE history_log();
