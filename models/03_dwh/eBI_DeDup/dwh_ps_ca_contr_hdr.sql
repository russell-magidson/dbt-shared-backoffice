{{ config(
    tags = ["ps_ca_contr_hdr"], 
    alias = 'ps_ca_contr_hdr'
    )
}}

select *, current_timestamp() AS insert_datetime
from {{ ref( 'stg_ps_ca_contr_hdr')}}
