{{ config(
    tags = ["ps_rna_pymnt_term", "dedup", "backoffice"], 
    alias = "ps_rna_pymnt_term"
    )
}}

select *, current_timestamp() as insert_datetime
from {{ ref( 'stg_ps_rna_pymnt_term')}}
