{{ config(
    tags = ["ext_holidays", "backoffice"], 
    alias = "ext_holidays"
    )
}}

SELECT date_key, date_value, is_holiday_usa, holiday_usa
from {{ source( 'rand-rusaweb-federated-tables', 'Accounting_Holidays')}}

/* Use the value of 'Yes' in case a holiday should change. This would allow the name to remain for comparison to the past */
WHERE is_holiday_usa = 'Yes'
