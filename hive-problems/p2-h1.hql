create table if not exists lines (line string);
load data local inpath 'eBooks/*.txt' overwrite into table lines;
create view if not exists words as select explode(split(line,' ')) as word from lines;
create view if not exists word_size_view as select length(word) as word_size from words;
select word_size, count(*) as count_word_size from word_size_view
group by word_size
having count_word_size>=495000
order by word_size desc;