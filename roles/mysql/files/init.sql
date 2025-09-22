-- Enable Group Replication plugin
INSTALL PLUGIN group_replication SONAME 'group_replication.so';

-- Create replication user
CREATE USER IF NOT EXISTS 'repl'@'%' IDENTIFIED BY '{{ repl_password }}';
GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%';
FLUSH PRIVILEGES;
