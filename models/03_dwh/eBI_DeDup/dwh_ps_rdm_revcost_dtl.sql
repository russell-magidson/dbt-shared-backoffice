{{ config(
    tags = ["ps_rdm_revcost_dtl"], 
    alias = "ps_rdm_revcost_dtl"
    )
}}

select *, current_timestamp() as insert_datetime
from {{ ref( 'stg_ps_rdm_revcost_dtl')}}
