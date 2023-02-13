{{ config(
    tags = ["dim_date", "backoffice"], 
    alias = "dim_date"
    )
}}

with 
  rawDateData as ( 
    select *
    from {{ source( 'rand-rusaweb-dims', 'DIM_DATE')}}
  )
, minFY as ( 
    select min( FISCAL_YEAR_VALUE) as minFiscalYear
        , min( parse_date( '%Y%m%d', cast( DATE_ID as string))) as minExactDate
        , min( YEAR_VALUE) as minCalendarYear
    from rawDateData
  )

, raw_data as (
    select 
        DATE_ID as date_key, parse_date( '%Y%m%d', cast( DATE_ID as string)) as exact_date
        , FISCAL_YEAR_VALUE as fiscal_year, FISCAL_QUARTER_VALUE as fiscal_quarter, FISCAL_MONTH_VALUE as fiscal_month, initcap( FISCAL_MONTH_NAME) as fiscal_month_name, FISCAL_WEEK as fiscal_week
        , ( FISCAL_YEAR_VALUE - minFiscalYear + 1) as fiscal_year_running, ((( FISCAL_YEAR_VALUE - minFiscalYear) * 12) + FISCAL_MONTH_VALUE ) as fiscal_month_running
        , CASE WHEN LAG( QUARTER_VALUE) OVER (ORDER BY date_id) <> QUARTER_VALUE THEN 1 ELSE 0 END as newCalendarQuarter 
        , CASE WHEN LAG( FISCAL_QUARTER_VALUE) OVER (ORDER BY date_id) <> FISCAL_QUARTER_VALUE THEN 1 ELSE 0 END as newFiscalQuarter 
        , CASE WHEN LAG( FISCAL_WEEK) OVER (ORDER BY date_id) <> FISCAL_WEEK THEN 1 ELSE 0 END as newFiscalWeek 
        , (( FISCAL_YEAR_VALUE - minFiscalYear) * 52) as fiscal_week_running
        , YEAR_VALUE as calendar_year, cast( QUARTER_VALUE as int) as calendar_quarter, MONTH_VALUE as calendar_month, initcap( MONTH_NAME) as calendar_month_name
        , WEEK_OF_YEAR as calendar_week, initcap( DAY_NAME) as calendar_day_name, cast( substring( DATE_VALUE, 9,2) as int) as calendar_day_of_month
        , DAY_OF_WEEK as calendar_day_of_week, DAY_OF_YEAR as calendar_day_of_year
        , YEAR_VALUE - minCalendarYear + 1  as calendar_year_running
        , (date_diff( parse_date( '%Y%m%d', cast( DATE_ID as string)), minExactDate, MONTH) ) + 1 as calendar_month_running
        , cast( trunc(date_diff( parse_date( '%Y%m%d', cast( DATE_ID as string)), minExactDate, DAY) / 7) + 1 as INT) as calendar_week_running
        , (date_diff( parse_date( '%Y%m%d', cast( DATE_ID as string)), minExactDate, DAY) ) + 1 as calendar_day_running
    from rawDateData
    left join minFY on 1=1 
  )
    
, final_data as ( 
    select 
        date_key, exact_date, calendar_year, calendar_quarter, calendar_month, calendar_month_name, calendar_week, calendar_day_name, calendar_day_of_month, calendar_day_of_week, calendar_day_of_year
        , calendar_year_running, sum( newCalendarQuarter) over ( order by date_key ) + 1 as calendar_quarter_running, calendar_month_running, calendar_week_running, calendar_day_running
        , fiscal_year, fiscal_quarter, fiscal_month, fiscal_month_name, fiscal_week,  row_number() over (partition by fiscal_year order by date_key) as fiscal_day
        , fiscal_year_running, sum( newFiscalQuarter) over ( order by date_key ) + 1 as fiscal_quarter_running, fiscal_month_running, sum( newFiscalWeek) over ( order by date_key ) + 1 as fiscal_week_running
        , row_number() over ( order by date_key) as fiscal_day_running
    from raw_data
  )
    
select date_key, exact_date, calendar_year, calendar_quarter, calendar_month, calendar_month_name, calendar_week, calendar_day_name, calendar_day_of_month, calendar_day_of_week, calendar_day_of_year
        , calendar_year_running, calendar_quarter_running, calendar_month_running, calendar_week_running, calendar_day_running
        , fiscal_year, fiscal_quarter, fiscal_month, fiscal_month_name, fiscal_week, fiscal_day
        , fiscal_year_running, fiscal_quarter_running, fiscal_month_running, fiscal_week_running
        , fiscal_day_running
from final_data
/* any WHERE criteria must be here, not in the above queries, otherwise the row_number() calcs won't work */
/* eg. where fiscal_year = 2023 */

UNION ALL

SELECT 
    -1 as date_key, null as exact_date, -1 as calendar_year, -1 as calendar_quarter, -1 as calendar_month, 'N/A' as calendar_month_name, -1 as calendar_week, 'N/A' as calendar_day_name, -1 as calendar_day_of_month, -1 as calendar_day_of_week, -1 as calendar_day_of_year
    , -1 as calendar_year_running, -1 as calendar_quarter_running, -1 as calendar_month_running, -1 as calendar_week_running, -1 as calendar_day_running
    , -1 as fiscal_year, -1 as fiscal_quarter, -1 as fiscal_month, 'N/A' as fiscal_month_name, -1 as fiscal_week,  -1 as fiscal_day
    , -1 as fiscal_year_running, -1 as fiscal_quarter_running, -1 as fiscal_month_running, -1 as fiscal_week_running
    , -1 as fiscal_day_running

order by date_key

