use excelr_project;
alter table brokerage change `Exe Name` Exe_Name text(30);
alter table brokerage change `Account Exe ID` Accont_Exe_id text(30);
alter table fees change `Account Exe ID` Account_Exe_id text(30);
alter table target change `New_Budget` New_Budget double;
alter table target change `Cross sell bugdet` cross_sell_Budget double;
alter table target change `Renewal Budget` Renewal_Budget double;
alter table meeting change `Account Executive` Account_Exe text(30);
desc target;
rename table `individual budgets` to `Target`;
select *from brokerage;

#count Active and inactive policy_status;
select count(policy_status) from brokerage
where Policy_status='Active';
select count(policy_status) from brokerage
where Policy_status='Inactive';

# cALCULATE the amount with respect to Product_group
select product_group,sum(amount) from brokerage
group by product_group
order by sum(amount) desc;

#cALCULATE the amount with respect to Exe_Name
select Exe_Name,sum(amount) As Amount from brokerage
group by Exe_name
order by Amount desc;

# calculate Achieved amount of cross sell , Renewal, new 
select *from brokerage;
select *from fees;
select b.income_class,f.income_class,(sum(b.amount+f.amount )) as achieved_amount from brokerage as b join fees as f
 on b.Accont_Exe_id=f.Account_Exe_id
 where b.income_class = 'cross sell' and f.income_class='cross sell'
 group by b.income_class and f.income_class;
 
 select b.income_class,sum(b.amount+f.amount)as achieved_amount from brokerage as b join fees as f
 on b.Accont_Exe_id=f.Account_Exe_id
 where b.income_class='Renewal' and f.income_class='Renewal'
 group by b.income_class and f.income_class;
 
  select b.income_class,sum(b.amount+f.amount)as achieved_amount from brokerage as b join fees as f
 on b.Accont_Exe_id=f.Account_Exe_id
 where b.income_class='New' and f.income_class='New'
 group by b.income_class and f.income_class;
 
 # calculate target amount of cross_sell,Renewal,New
 select *from target;
 select sum(cross_sell_budget) as Target from target;
 select sum(Renewal_budget) as Target from target;
 select sum(New_budget) as Target from target;
 
 # calculate invoice amount of cross_sell, renewal, new
 select *from invoice;
 select income_class , sum(amount) from invoice
 group by income_class having income_class  in ('New','Renewal','cross sell');
 
 # calculate number of meeting by account execute
 select *from meeting;
select Account_Exe,count(meeting_date)as no_of_meeting from meeting
group by Account_Exe 
order by no_of_meeting desc;

# count  total and open opportunity 
select *from opportunity;
select count(stage) as Total_oppor,(select count(stage) from opportunity
where stage not in ('Propose Solution')) as open_oppor from opportunity;

# claculate open_oppor revenue by Product_group
select product_group,Sum(revenue_amount) as Revenue from opportunity
where stage not in ('propose solution')
group by product_group
order by Revenue desc;











