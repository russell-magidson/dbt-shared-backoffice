{{ config(
    tags = ["ps_jobcode_tbl"], 
    alias = 'ps_jobcode_tbl'
    )
}}

select *, current_timestamp() as insert_datetime
from {{ ref( 'stg_ps_jobcode_tbl')}}
