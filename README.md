### Dirty Read

A dirty read occurs when a transaction retrieves
a row that has been updated by another transaction that is not yet committed.

<table>
<tr>
<th> Transaction 1 </th>
<th> Transaction 2 </th>
</tr>
<tr>
<td>

```sql
START TRANSACTION;
select age
from users
WHERE name = "Alice";
-- retrieves 25
```

</td>
<td>
</td>
</tr>
<tr>
<td></td>
<td>

```sql
START TRANSACTION;
UPDATE users
SET age = 42
WHERE name = "Alice";
```

</td>
</tr>
<tr>
<td>

```sql
START TRANSACTION;
select age
from users
WHERE name = "Alice";
-- retrieves 42 in Read Uncommitted even it is not committed by Transaction 2
```

</td>
<td>
</td>
</tr>
</table>

### Non-repeatable Reads
A non-repeatable read occurs when a transaction retrieves a row twice and that
row is updated by another transaction that is committed in between.

<table>
<tr>
<th> Transaction 1 </th>
<th> Transaction 2 </th>
</tr>
<tr>
<td>

```sql
START TRANSACTION;
select age
from users
WHERE name = "Alice";
-- retrieves 25
```

</td>
<td>
</td>
</tr>
<tr>
<td></td>
<td>

```sql
START TRANSACTION;
UPDATE users
SET age = 42
WHERE name = "Alice";
COMMIT;
```

</td>
</tr>
<tr>
<td>

```sql
START TRANSACTION;
select age
from users
WHERE name = "Alice";
-- retrieves 42 in Read Uncommitted and Read Committed
COMMIT;
```

</td>
<td>
</td>
</tr>
</table>

### Phantom reads
A phantom read occurs when a transaction retrieves a set of rows twice and new rows are inserted into or removed from
that set by another transaction that is committed in between.

<table>
<tr>
<th> Transaction 1 </th>
<th> Transaction 2 </th>
</tr>
<tr>
<td>

```sql
START TRANSACTION;
SELECT name
FROM users
WHERE age > 18;
-- retrieves Alice and Bob
```

</td>
<td>
</td>
</tr>
<tr>
<td></td>
<td>

```sql
START TRANSACTION;
INSERT INTO users(name, age)
VALUES ("Carl", 27);
COMMIT;
```

</td>
</tr>
<tr>
<td>

```sql
START TRANSACTION;
SELECT name
FROM users
WHERE age > 18;
-- retrieves Alice, Bob and Carl when Phantom Reads reproduced 
COMMIT;
```

</td>
<td>
</td>
</tr>
</table>

### MySQL

|                  | Dirty Read                                    | Non-repeatable Reads                          | Phantom Reads                                 |
|------------------|-----------------------------------------------|-----------------------------------------------|-----------------------------------------------|
| Read Uncommitted | <span style="color:red">**reproduced**</span> | <span style="color:red">**reproduced**</span> | <span style="color:red">**reproduced**</span> |
| Read Committed   | <span style="color:green">avoided</span>      | <span style="color:red">**reproduced**</span> | <span style="color:red">**reproduced**</span> |
| Repeatable Read  | <span style="color:green">avoided</span>      | <span style="color:green">avoided</span>      | <span style="color:green">avoided</span>      |
| Serializable     | <span style="color:green">avoided</span>      | <span style="color:green">avoided</span>      | <span style="color:green">avoided</span>      |

> Phantom Reads not reproduced in Mysql 8 on Repeatable Read isolation level
