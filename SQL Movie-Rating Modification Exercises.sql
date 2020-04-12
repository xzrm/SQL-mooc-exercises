--1. Add the reviewer Roger Ebert to your database, with an rID of 209.

insert into Reviewer values (209, 'Roger Ebert')

--2. Insert 5-star ratings by James Cameron for all movies in the database. Leave the review date as NULL.

insert into Rating
select Reviewer.rID , Movie.mID, 5, null from Movie
join Reviewer
where Reviewer.name='James Cameron'

--3. For all movies that have an average rating of 4 stars or higher, add 25 to the release year. (Update the existing tuples; don't insert new tuples.)

update Movie
set year = year + 25
where miD in (select mID
from Rating
group by mID
having avg(stars) >= 4)

--4. Remove all ratings where the movie's year is before 1970 or after 2000, and the rating is fewer than 4 stars.

delete from Rating
where mID in (select Rating.mID
from Rating join Movie on Rating.mID = Movie.mID
where (Movie.year < 1970 or Movie.year > 2000)) and Rating.stars < 4

