{{ config(
    tags = ["ps_earnings_tbl"], 
    alias = 'ps_earnings_tbl'
    )
}}

select *, current_timestamp() as insert_datetime
from {{ ref( 'stg_ps_earnings_tbl')}}
