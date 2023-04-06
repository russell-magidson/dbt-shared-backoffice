{{ config(
    tags = ["fact_active_po_assignments", "po_assignments"], 
    alias = "fact_active_po_assignments"
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( 'stg_fact_active_po_assignments')}}
