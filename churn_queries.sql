CREATE DATABASE churn_project;
use churn_project;
CREATE TABLE customer_churn (
    customerID VARCHAR(20),
    gender VARCHAR(10),
    SeniorCitizen INT,
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    tenure INT,
    PhoneService VARCHAR(5),
    MultipleLines VARCHAR(20),
    InternetService VARCHAR(20),
    OnlineSecurity VARCHAR(20),
    OnlineBackup VARCHAR(20),
    DeviceProtection VARCHAR(20),
    TechSupport VARCHAR(20),
    StreamingTV VARCHAR(20),
    StreamingMovies VARCHAR(20),
    Contract VARCHAR(20),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(50),
    MonthlyCharges DECIMAL(10,2),
    TotalCharges DECIMAL(10,2),
    Churn VARCHAR(5)
);
select count(*) from customer_churn;

select count(distinct customerID) from customer_churn;

select count(case when churn = 'Yes' then 1 end) * 100.0 / count(*) as churn_rate from customer_churn;
select contract, count(*) as  total_customers,
count(case when churn='Yes' then 1 end) as churned_customers,
count(case when churn='Yes' then 1 end) * 100.0 / COUNT(*) as churn_percentage
from customer_churn
group by contract 
order by churn_percentage DESC;

select sum(TotalCharges) as historical_revenue,
sum(case when churn='Yes' then TotalCharges else 0 end) as churned_revenue,
sum(case when churn ='Yes' then MonthlyCharges else 0 end) as monthly_revenue_at_risk
from customer_churn;

Select case when tenure <= 12 then '0-1 year'
when tenure <=24 then '1-2 years'
when tenure <=48 then '2-4 years'
else '4+ years'
end as TenureGroup,
count(case when churn='Yes' then 1 end) *100.0 / count(*) as churn_percentage
from customer_churn
group by TenureGroup
order by churn_percentage desc;



