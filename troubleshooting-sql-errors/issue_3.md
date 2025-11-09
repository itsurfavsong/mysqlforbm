# Troubleshooting SQL Errors

## Issue 2: Foreign Key Mismatch Between Tables

**Problem:** <br>
I tried to add a foreign key from rankmanagement.userid to users.userid. <br>
However, MySQL returned an error when I executed the ALTER TABLE statement to add the foreign key. <br>
This prevented me from establishing the relationship between the tables.

### Original Query:
```sql
ALTER TABLE rankmanagement
ADD COLUMN userid INT;

ALTER TABLE rankmanagement
ADD CONSTRAINT FK_RANKMANAGEMENT_USERID
    FOREIGN KEY (userid)
    REFERENCES users(userid);
```

**⚠️ Why the Error Happens**
1. The column users.userid is defined as INT UNSIGNED.
2. The column rankmanagement.userid was defined as INT (signed by default).
3. MySQL requires the data types to match exactly for foreign keys.

**solution:** <br>
Make the rankmanagement.userid column INT UNSIGNED to match users.userid.

### Corrected Query:
```sql
-- If column does not exist yet
ALTER TABLE rankmanagement
ADD COLUMN userid INT UNSIGNED;

-- If column already exists as signed INT
ALTER TABLE rankmanagement
MODIFY COLUMN userid INT UNSIGNED;

-- Add the foreign key
ALTER TABLE rankmanagement
ADD CONSTRAINT FK_RANKMANAGEMENT_USERID
    FOREIGN KEY (userid)
    REFERENCES users(userid);
```
