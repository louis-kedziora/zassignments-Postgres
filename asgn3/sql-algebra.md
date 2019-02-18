# Assignment 3, CSC-370, Daniel German
#### Louis Kedziora, V00820695, October 10th, 2018

---

#1.
>SELECT id, year FROM productions WHERE year > 2011 AND title ~ 'Harry Potter' and attr is null;

##$\prod_{\;id,year}\sigma_{\;year<2011\; and, \;title \;\sim\; 'Harry Potter'\; and, \;attr = null}$Productions

---

#2.
>SELECT id,character FROM roles WHERE pid = 'Streep, Meryl' AND id IN (SELECT id FROM productions WHERE year < 1980 AND attr is null);

##$\prod_{\;id,character}\sigma_{\;pid='Streep,\;Meryl'\;and,\;id\;IN\;(\prod_{year}\sigma_{year<1980\;and,\;attr = null}Productions)}$Roles

---

#3.
>SELECT id, character, billing FROM roles WHERE pid = 'Eastwood, Clint' AND id IN (SELECT id FROM directors WHERE pid = 'Leone, Sergio (I)');

##$\prod_{\;id,character,billing}\sigma_{\;pid='Eastwood,\;Clint'\;and,\;id\;IN\;(\prod_{id}\sigma_{pid='Leone,\;Sergio\;(I)'}Directors)}$Roles

---

#4.
>(SELECT id FROM productions WHERE id IN (SELECT id FROM roles WHERE pid='Nimoy, Leonard')) INTERSECT (SELECT id FROM productions WHERE id IN (SELECT id FROM roles WHERE pid='Hawking, Stephen'));

##($\prod_{\;id}\sigma_{\;id\;IN\;(\prod_{id}\sigma_{pid='Nimoy,\;Leonard\;(I)'}Roles)}$Productions) $\bigcap$ ($\prod_{\;id}\sigma_{\;id\;IN\;(\prod_{id}\sigma_{pid='Hawking,\;Stephen\;(I)'}Roles)}$Productions)

---
$\;$
$\;$
$\;$
$\;$
$\;$
#5.
>SELECT id, pid, character FROM roles WHERE pid IN ((SELECT pid FROM roles WHERE id = 'The Matrix (1999)') INTERSECT (SELECT pid FROM roles WHERE id = 'The Matrix Reloaded (2003)')) AND (id = 'The Matrix (1999)' OR id = 'The Matrix Reloaded (2003)');


####$\prod_{\;id,pid,character}\sigma_{\;pid\;IN\;[(\prod_{\;pid}\sigma_{\;id=('The\;Matrix\;(1999)')}Roles)\bigcap(\prod_{\;pid}\sigma_{\;id=('The\;Matrix\;Reloaded\;(2003)')}Roles)]\;and,\;(id='The\;Matrix\;(1999)'\;OR\;id='The\;Matrix\;Reloaded(2003)')}$Roles
