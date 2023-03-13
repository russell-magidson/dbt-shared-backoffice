{{ config(
    tags = ["psxlatitem_fs", "psxlatitem", "po_assignments"], 
    alias = 'psxlatitem_fs'
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( 'stg_psxlatitem_fs')}}
