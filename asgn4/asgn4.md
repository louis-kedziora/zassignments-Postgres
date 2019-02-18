## Assignment 4, CSC-370, Daniel German
#### Louis Kedziora, V00820695, October 17th, 2018
#1.

SELECT DISTINCT country FROM episodes, locations WHERE episodeof = '"Game of Thrones" (2011)' AND locations.id = '"Game of Thrones" (2011)';
<br><br><br><br><br><br><br><br><br>
#2.

SELECT title, year, rank FROM ratings, productions WHERE ratings.id IN (SELECT id FROM directors WHERE pid= 'Hitchcock, Alfred (I)') AND votes>50000 AND attr is null AND ratings.id = productions.id;

<br><br><br><br><br><br><br><br><br><br>
#3.

SELECT title, year, rank, rolesp.character as paulchar, rolesp.billing as paulbilling, rolesr.character as robchar, rolesr.billing as robbilling
  FROM productions, ratings,
    (SELECT id, character, billing FROM roles WHERE pid ='Redford, Robert (I)' AND character!~'Himself') as rolesr,
    (SELECT id, character, billing FROM roles WHERE pid ='Newman, Paul (I)' AND character!~'Himself') as rolesp
  WHERE attr is null AND rolesr$.$id = rolesp$.$id AND productions$.$id = ratings$.$id
    AND productions$.$id = rolesr$.$id AND productions$.$id = rolesp$.$id;

<br><br><br><br><br><br><br><br><br><br>
#4.

 SELECT at.pid, at$.$id, rank
 FROM
 (SELECT pid, id FROM directors WHERE id IN (SELECT id FROM languages NATURAL JOIN productions WHERE attr is NULL and language='English')
  AND pid IN (SELECT pid FROM episodes NATURAL JOIN directors WHERE episodeof='"Hora Marcada" (1986)' GROUP BY pid)) as at
  LEFT JOIN
  ratings
  ON at$.$id = ratings$.$id;

<br><br><br><br><br><br><br><br><br><br>
#5.

SELECT id as LucasProduction, idlinkedto as KurosawaProduction, relationship
FROM directors NATURAL JOIN links
WHERE pid='Lucas, George (I)'
AND idlinkedto IN (SELECT id as idlinkedto FROM directors WHERE pid='Kurosawa, Akira');
