--1. It's time for the seniors to graduate. Remove all 12th graders from Highschooler.

delete from highschooler
where grade = 12

--2. If two students A and B are friends, and A likes B but not vice-versa, remove the Likes tuple.

delete from Likes
where exists ( select 1 from (
select L1.ID1 as ID1, L1.ID2 as ID2 from Friend F join Likes L1
on L1.ID1 = F.ID1 and L1.ID2 = F.ID2
left outer join Likes L2 
on L1.ID2 = L2.ID1 and  L1.ID1 = L2.ID2
where L2.ID1 is null ) Res
where Likes.ID1 = Res.ID1 and Likes.ID2 = Res.ID2
)


