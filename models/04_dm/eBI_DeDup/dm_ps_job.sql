{{ config(
    tags = ["ps_job"], 
    alias = "ps_job"
    )
}}

select *, current_timestamp() as insert_datetime
from {{ ref( 'stg_ps_job')}}
