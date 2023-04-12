{{ config(
    tags = ["ext_table_refresh_schedule", "backoffice"], 
    alias = "ext_table_refresh_schedule"
    )
}}

select *
from {{ source( 'rand-rusaweb-federated-tables', 'Table_Refresh_Schedule')}}
