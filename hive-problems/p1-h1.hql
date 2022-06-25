create table if not exists lines (line string);
load data local inpath 'eBooks/*.txt' overwrite into table lines;
create view if not exists words as select explode(split(line,'\\s+')) as word from lines;
select word, count(*) as word_count from words 
group by word
having word_count>=49500
order by word_count desc;