#/bin/sh
docker exec -i evocc_mysql_1 sh -c 'exec mysql asterisk -uroot -p"HgdYujt18"' < dump_all.sql
