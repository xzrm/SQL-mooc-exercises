--1. Find the titles of all movies directed by Steven Spielberg.

select title
from Movie
where director = 'Steven Spielberg'


--2. Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order.

select distinct year
from Movie, Rating
where Movie.mID = Rating.mID and stars >= 4
order by year ASC

--3. Find the titles of all movies that have no ratings.

select title
from Movie
where Movie.mID not in (select mID from Rating)

--4. Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date.

select name
from Reviewer
where Reviewer.rID in (select rID from Rating where ratingDate is null)

--5. Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars.

select name, title, stars, ratingDate
from Movie, Reviewer, Rating
where Movie.mID = Rating.mID and Reviewer.rID = Rating.rID
order by name, title, stars

--6. For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie.

select name, title
from Reviewer, Movie
where rID in (select distinct R1.rID
                from Rating R1, Rating R2
                where R2.rID = R1.rID and R2.mID = R1.mID 
               and R2.ratingDate > R1.ratingDate and R2.stars > R1.stars)
and mID in (select distinct R1.mID
                from Rating R1, Rating R2
                where R2.rID = R1.rID and R2.mID = R1.mID 
               and R2.ratingDate > R1.ratingDate and R2.stars > R1.stars)
			   
--7. For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. Sort by movie title.

select title, max(stars)
from (select title, stars
from Movie, Rating
where Movie.mID = Rating.mID)
group by title

--8. For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title.

select title, max(stars) - min(stars) as spread
from (select title, stars
from Movie, Rating
where Movie.mID = Rating.mID)
group by title
order by spread DESC

--9. Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after. Don't just calculate the overall average rating before and after 1980.)

select max(A) - min(A)
from
(select avg(titleAvg) as A
from (
select title, avg(stars) as titleAvg, year
from (select title, stars,  year
        from Movie, Rating
        where Movie.mID = Rating.mID)
        group by title)
where year < 1980
union
select avg(titleAvg1) as A
from (
select title, avg(stars) as titleAvg1, year
from (select title, stars,  year
        from Movie, Rating
        where Movie.mID = Rating.mID)
        group by title)
where year > 1980)


