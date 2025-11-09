-- Using a previous created DB 'Economic_Growth'


-- Creating a table
CREATE TABLE japan_economy (
    date DATE,
    cpi FLOAT,
    unemployment_rate FLOAT,
    interest_rate FLOAT,
    exchange_rate FLOAT,
    imports FLOAT,
    exports FLOAT
);


-- Importing csv data into my table
BULK INSERT japan_economy
FROM 'D:\9. Self Projects\4. Econometrics Project\Economy of a Country\japan_data_2000_2025.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

select * from japan_economy;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Creating a permanent table with a new columns
go
create view Japan as
select
    date,
    cpi,
    unemployment_rate,
    interest_rate,
    exchange_rate,
    imports,
    exports,
    round((cpi - lag(cpi) over (order by date)) / lag(cpi) over (order by date) * 100, 2) as inflation_rate,
    round(exports - imports,2) AS trade_balance
from japan_economy;   -- Created 'trade balance' col by substract imports from exports
go      -- Created 'Inflation rate' col by (present cpi - past cpi) / past cpi * 100

-------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- To export this as a csv table :
   -- Step 1: Query (Menu Bar) -> Results To -> Results To Grid ten
   -- Step2: Execute the query to see the table
      select * from Japan;
   -- Step3: Right click on the executed table -> Save Result As -> name it.
-- [ Make sure 'include colomn name is ticked' before export to have col name, go to Tools -> Options -> Query result -> SQL Server -> Grid -> Tick it ]

------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Converting data to Quarterly format so that I can merge with GDP

-- Changing the date colomn to 'yyyy-mm-dd' from 'yyyy-dd-mm'  [ Step1 ]
UPDATE japan_economy
SET [date] = TRY_CONVERT(date, 
              CONCAT(
                  LEFT(CONVERT(varchar(10), [date], 120), 4), '-', 
                  RIGHT(CONVERT(varchar(10), [date], 120), 2), '-', 
                  SUBSTRING(CONVERT(varchar(10), [date], 120), 6, 2)
              ));

-- Checking if it works   
SELECT [date], MONTH([date]) AS month_num, CEILING(MONTH([date]) / 3.0) AS quarter
FROM japan_economy
ORDER BY [date];

-- Printing the Quarterly table as a cte table, so that I can update it later  
go
create view Quarerly as  -- Together storing it in a permanent table, for export purposes  [ Step 2 ]
WITH quarterly_data AS (                                                            --     [ Step 3 ]
    SELECT
        YEAR([date]) AS year,
        CEILING(MONTH([date])/3.0) AS quarter,
        AVG(cpi) AS avg_cpi,
        AVG(unemployment_rate) AS avg_unemployment,
        AVG(interest_rate) AS avg_interest,
        AVG(exchange_rate) AS avg_exchange,
        SUM(exports) AS total_exports,
        SUM(imports) AS total_imports
    FROM japan_economy
    GROUP BY YEAR([date]), CEILING(MONTH([date])/3.0)
)
SELECT        -- Now merging both datasets (as condition of CTE)                          [ Step 4 ]
    qd.year as Year,
    qd.quarter as Quarter_No,
    jq.GDP_Trillion,
    qd.avg_cpi as Cpi,
    qd.avg_unemployment as Unemployment,
    qd.avg_interest as Interest_Rate,
    qd.avg_exchange as Exchange_Rate,
    qd.total_exports as Exports,
    qd.total_imports as Imports
FROM quarterly_data AS qd
JOIN japan_quarterly_gdp AS jq
    ON qd.year = jq.date
   AND qd.quarter = jq.Quarter
go 

-- To see the merged table
select * from Quarerly;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Earlier saved Mothly data with calculating new colomns(Infaltion and Trade balance), now to save them as a Quartely data :

go
create view Nippon as
select
    Year,
    Quarter_No,
    GDP_Trillion,
    cpi,
    Unemployment,
    Interest_Rate,
    Exchange_Rate,
    Imports,
    Exports,
    round((cpi - lag(cpi) over (order by Year)) / lag(cpi) over (order by Year) * 100, 2) as inflation_rate,
    round(exports - imports,2) AS trade_balance
from Quarerly;   -- Created 'trade balance' col by substract imports from exports
go      -- Created 'Inflation rate' col by (present cpi - past cpi) / past cpi * 100


-- To see the table
select * from Nippon;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Now export the new dataset.
