{{ config(
    tags = ["ps_personal_data", "po_assignments"], 
    alias = "ps_personal_data"
    )
}}

select *, current_timestamp() as insert_datetime
from {{ ref( 'stg_ps_personal_data')}}
