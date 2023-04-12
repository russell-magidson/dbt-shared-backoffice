{{ config(
    tags = ["ps_rs_assignment", "po_assignments"], 
    alias = "ps_rs_assignment"
    )
}}

select *, current_timestamp() as insert_datetime
from {{ ref( 'stg_ps_rs_assignment')}}
