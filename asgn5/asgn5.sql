#1
WITH series(id) AS
    (SELECT id FROM productions WHERE attr='TV-series'),
  rated(episodeof, season, id, rank, votes, epnumber) AS
    (SELECT episodeof, season, ratings.id, rank, votes, epnumber
      FROM ratings LEFT JOIN episodes ON ratings.id = episodes.id
      WHERE episodeof IN (SELECT episodeof FROM ratings LEFT JOIN episodes ON ratings.id = episodes.id
      GROUP BY episodeof HAVING max(season) > 3))
  SELECT episodeof, avg(rank) as arank, avg(votes) as avotes, count(epnumber) as cepisodes, max(season) as cseasons
    FROM rated LEFT JOIN series ON rated.episodeof = series.id
    GROUP BY episodeof HAVING avg(rank) > 8.5 AND avg(votes) >= 1000 ORDER BY arank DESC;

          episodeof           |      arank       |        avotes         | cepisodes | cseasons
-------------------------------+------------------+-----------------------+-----------+----------
"Person of Interest" (2011)   | 9.13980582524272 | 2047.6310679611650485 |       103 |        5
"Breaking Bad" (2008)         | 9.01935483870968 |    11124.709677419355 |        62 |        5
"Game of Thrones" (2011)      | 8.99833333333333 |    19718.333333333333 |        60 |        6
"Sherlock" (2010)             | 8.94166666666667 |    15931.333333333333 |        12 |        4
"Suits" (2011)                | 8.85357142857143 | 1318.0000000000000000 |        84 |        6
"The Wire" (2002)             | 8.84333333333333 | 1422.1166666666666667 |        60 |        5
"House of Cards" (2013)       | 8.72884615384615 | 2628.5000000000000000 |        52 |        4
"Supernatural" (2005)         | 8.71611570247935 | 2059.5123966942148760 |       242 |       11
"House M.D." (2004)           | 8.69318181818182 | 1439.4602272727272727 |       176 |        8
"Sons of Anarchy" (2008)      | 8.69239130434783 | 1145.6195652173913043 |        92 |        7
"Prison Break" (2005)         | 8.68395061728395 | 1629.8518518518518519 |        81 |        4
"Lost" (2004)                 | 8.67692307692307 | 2819.5811965811965812 |       117 |        6
"The Sopranos" (1999)         | 8.67209302325582 | 1574.4186046511627907 |        86 |        6
"Dexter" (2006)               | 8.64166666666667 | 2802.8750000000000000 |        96 |        8
"Luther" (2010)               | 8.59411764705882 | 1103.4705882352941176 |        16 |        4
"Boardwalk Empire" (2010)     | 8.55087719298246 | 1095.0877192982456140 |        57 |        5
"Friends" (1994)              | 8.54152542372881 | 1642.8898305084745763 |       236 |       10
"Vikings" (2013)              | 8.53589743589744 | 1740.2051282051282051 |        39 |        4
"Mad Men" (2007)              | 8.53152173913044 | 1100.8804347826086957 |        92 |        7
"Arrow" (2012)                | 8.52717391304348 | 3053.7934782608695652 |        92 |        4
"Once Upon a Time" (2011)     |  8.5212389380531 | 1000.0530973451327434 |       113 |        5
"Arrested Development" (2003) | 8.51470588235294 | 1062.6176470588235294 |        68 |        4
(22 rows)

#2
WITH goodM(title, year, rank, votes) AS
  (SELECT title, year, rank, votes FROM ratings NATURAL JOIN productions
    WHERE attr is null AND votes >= 50000)
  SELECT title, year, rank, votes FROM goodM
    WHERE rank IN (SELECT max(rank) as rank FROM goodM);

          title           | year | rank |  votes
--------------------------+------+------+---------
 The Shawshank Redemption | 1994 |  9.3 | 1698604
(1 row)

#3
WITH goodM(id, rank) AS
  (SELECT ratings.id, rank FROM ratings NATURAL JOIN productions
    WHERE attr is null AND votes >= 50000 AND rank >= 8)
  SELECT pid, count(id) as num_movies, avg(rank) as avg_rank
    FROM goodM NATURAL JOIN roles GROUP BY pid
    HAVING count(id) >= 10 ORDER BY avg(rank);

    pid           | num_movies |     avg_rank
------------------------+------------+------------------
Tovey, Arthur          |         11 | 8.21818181818182
McGowan, Mickie        |         10 |             8.23
Flowers, Bess          |         12 | 8.25833333333333
Lynn, Sherry (I)       |         12 | 8.25833333333333
Ratzenberger, John (I) |         12 | 8.28333333333333
Oliveira, Joseph (III) |         10 |             8.38
(6 rows)

#4
WITH goodM(id) AS
  (SELECT id FROM ratings NATURAL JOIN productions
    WHERE rank >= 8 AND votes >= 50000 AND attr IS NULL),
  roles_goodM(pid, id, billing, character) AS
    (SELECT pid, roles.id, billing, character FROM goodM NATURAL JOIN roles),
  max_pid(pid, c_id) AS
  (SELECT pid, count(id) AS c_id FROM roles_goodM GROUP BY pid)
  SELECT pid, id, billing, character FROM roles_goodM WHERE pid IN
    (SELECT pid FROM max_pid NATURAL JOIN roles_goodM WHERE c_id IN
      (SELECT max(c_id) FROM max_pid)) ORDER BY pid;

          pid           |                          id                           | billing |                        character
------------------------+-------------------------------------------------------+---------+----------------------------------------------------------
 Flowers, Bess          | The Big Sleep (1946)                                  |         | Woman with Bumped Man
 Flowers, Bess          | North by Northwest (1959)                             |         | Hotel Lounge Patron
 Flowers, Bess          | Notorious (1946)                                      |         | Party Guest
 Flowers, Bess          | Witness for the Prosecution (1957)                    |         | Courtroom Spectator
 Flowers, Bess          | Singin' in the Rain (1952)                            |         | Audience Member
 Flowers, Bess          | Rear Window (1954)                                    |         | Songwriter's Party Guest with Poodle
 Flowers, Bess          | Vertigo (1958)                                        |         | Diner at Ernie's
 Flowers, Bess          | All About Eve (1950)                                  |         | Sarah Siddons Awards Well-Wisher
 Flowers, Bess          | The Manchurian Candidate (1962)                       |         | Gomel's Lady Counterpart
 Flowers, Bess          | It Happened One Night (1934)                          |         | Agnes - Gordon's Secretary
 Flowers, Bess          | Dial M for Murder (1954)                              |         | Woman Departing Ship
 Flowers, Bess          | Double Indemnity (1944)                               |         | Norton's Secretary
 Lynn, Sherry (I)       | Sen to Chihiro no kamikakushi (2001)                  |      59 |
 Lynn, Sherry (I)       | Beauty and the Beast (1991)                           |      40 |
 Lynn, Sherry (I)       | Inside Out (2015/I)                                   |      46 | Additional Voices
 Lynn, Sherry (I)       | Mononoke-hime (1997)                                  |      13 | Woman in Iron Town/Emishi Village Girl/Additional voices
 Lynn, Sherry (I)       | Monsters, Inc. (2001)                                 |      34 | Additional Voices
 Lynn, Sherry (I)       | Oldeuboi (2003)                                       |         | Mi-do
 Lynn, Sherry (I)       | Aladdin (1992)                                        |      18 | Additional Voices
 Lynn, Sherry (I)       | The Iron Giant (1999)                                 |      23 | Additional Voices
 Lynn, Sherry (I)       | Toy Story (1995)                                      |      27 | Mom
 Lynn, Sherry (I)       | Toy Story 3 (2010)                                    |         |
 Lynn, Sherry (I)       | Up (2009)                                             |      25 | Additional Voices
 Lynn, Sherry (I)       | WALL·E (2008)                                         |      17 | Axiom Passenger #5
 Ratzenberger, John (I) | Up (2009)                                             |       7 | Construction Foreman Tom
 Ratzenberger, John (I) | Inside Out (2015/I)                                   |      17 | Fritz
 Ratzenberger, John (I) | Gandhi (1982)                                         |     124 | American Lieutenant
 Ratzenberger, John (I) | Toy Story (1995)                                      |       6 | Hamm
 Ratzenberger, John (I) | Finding Nemo (2003)                                   |      24 | Fish School
 Ratzenberger, John (I) | Toy Story 3 (2010)                                    |       8 | Hamm
 Ratzenberger, John (I) | WALL·E (2008)                                         |       6 | John
 Ratzenberger, John (I) | Sen to Chihiro no kamikakushi (2001)                  |      56 | Assistant Manager
 Ratzenberger, John (I) | Ratatouille (2007)                                    |      12 | Mustafa
 Ratzenberger, John (I) | Star Wars: Episode V - The Empire Strikes Back (1980) |      31 | Rebel Force Major Derlin
 Ratzenberger, John (I) | Monsters, Inc. (2001)                                 |       8 | The Abominable Snowman
 Ratzenberger, John (I) | The Incredibles (2004)                                |      21 | Underminer
(36 rows)

#5
WITH movies(id, rank) AS
    (SELECT id, rank FROM productions NATURAL JOIN ratings WHERE attr IS NULL AND votes >= 40000),
  g_movies(pid, id, rank) AS
    (SELECT pid, id, rank FROM movies NATURAL JOIN directors WHERE rank > 8.4),
  b_movies(pid, id, rank) AS
    (SELECT pid, id, rank FROM movies NATURAL JOIN directors WHERE rank <= 8.4),
  d_pool(pid, id, rank) AS
    (SELECT pid, id, rank FROM movies NATURAL JOIN directors WHERE pid IN
      (SELECT pid FROM movies NATURAL JOIN directors GROUP BY pid HAVING count(id) >= 8)
    AND pid IN
      (SELECT pid FROM g_movies NATURAL JOIN directors GROUP BY pid HAVING count(id) >= 1)),
  count_g_movies(pid, goodones) AS
    (SELECT pid, count(id) as goodones FROM g_movies GROUP BY pid),
  count_b_movies(pid ,rest) AS
    (SELECT pid, count(id) as rest FROM b_movies GROUP BY pid),
  avg_g(pid, avggoodones) AS
    (SELECT pid, avg(rank) as avggoodones FROM g_movies GROUP BY pid),
  avg_b(pid, avgrest) AS
    (SELECT pid, avg(rank) as avgrest FROM b_movies GROUP BY pid)
  SELECT DISTINCT d_pool.pid, to_char((cast(goodones as decimal) / (goodones + rest))*100, '999.9%') AS prop, (goodones + rest) AS total,
    goodones, to_char(avggoodones, '9.9') avggoodones, rest, to_char(avgrest, '9.9') avgrest, to_char(avggoodones - avgrest, '9.9') diff
    FROM d_pool NATURAL JOIN count_g_movies NATURAL JOIN count_b_movies NATURAL JOIN avg_g
      NATURAL JOIN avg_b;
