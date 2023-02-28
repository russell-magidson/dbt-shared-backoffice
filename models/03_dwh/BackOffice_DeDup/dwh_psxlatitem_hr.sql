{{ config(
    tags = ["psxlatitem_hr", "psxlatitem", "backoffice"], 
    materialized = 'incremental', 
    alias = 'psxlatitem_hr'
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( 'stg_psxlatitem_hr')}}
