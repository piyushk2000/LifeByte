-- these are all the sql queries i came up with for data analysis




select * from trades order by open_time desc
select* from users


select server_hash, count (login_hash) as no_of_user_per_machine , sum(volume) as vol , sum(contractsize) as cs from trades 
group by server_hash
order by no_of_user_per_machine;
-- here there are only 3 server which means two thing either date is flawed 
-- or a bot is trading in server using all the logins we can take a action based on that
-- it can also be an orgnization but thats unlikely based on no. of login per machine and timeframe

select a.server_hash as machine, count(distinct(b.country_hash)) as no_of_country
from trades as a inner join users as b
on a.login_hash = b.login_hash
group by a.server_hash
-- one machine present in many country dosent seem possible they are probably using a vpn too       


select symbol,sum(contractsize) as total_size, sum(volume) as vol from trades
group by symbol 
order by vol desc;
-- we can provide make reserves and provide leverage trading for highest vol trading paring to increase our customer attraction and also to increase profit by charging money on leverage 



select a.country_hash,sum(b.volume) as vol,
sum(b.contractsize) as total_size,
count(b.login_hash) as no_of_users
from users as a 
inner join trades as b
on a.login_hash = b.login_hash
group by country_hash
order by vol;
-- we can see country with least volume and maybe less focus on that part because its not working there and we can focus more on avg performing country to increase our trade volume 





create view user_enable as
select a.login_hash ,sum(a.enable) as enabled, count(b.login_hash) as no_of_trades,sum(b.volume) as vol
from users as a inner join trades as b
on a.login_hash = b.login_hash
group by a.login_hash
order by vol desc;

select * from user_enable
where enabled=0
order by vol desc;
--users who used to trade but are now disabled we can targate high volume trading users and convince them to join the platform again or ask them the problem and fix it


select cmd , sum(volume) as vol,count(login_hash) as no_of_orders from trades group by cmd
--total volume an no_of_orders in buy and sell

select count(distinct(login_hash)) , a.enable from users as a group by a.enable
--total number of enaled and disabled users


select count(distinct(login_hash)) , currency from users group by currency
--number of users using per type of curruncy


-- rest analysis is available in python file









