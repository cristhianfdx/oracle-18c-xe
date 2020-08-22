README 
------

 Name: SQL Developer SQLcl
 Desc: Oracle SQL Developer Command Line (SQLcl) is a free command line 
       interface for Oracle Database. It allows you to interactively or 
       batch execute SQL and PL/SQL. SQLcl provides in-line editing, statement
       completion, and command recall for a feature-rich experience, all while
       also supporting your previously written SQL*Plus scripts.
 Version: 20.2.0
 Build: 20.2.0.174.1557

Release Notes
=============

Ansiconsole as default SQLFormat
--------------------------------
From SQLcl 20.2, AnsiConsole Format is on by default.  This means that certain 
features will not work as expect until the format is set to default.

These include the SQL\*Plus features
  * HEADING
  * TTITLE
  * BREAK
  * COMPUTE

SQL> set sqlformat default. 

If you have extensive use of SQL\*Plus style reports, you need to unset
sqlformat via login.sql or add it to your reports
