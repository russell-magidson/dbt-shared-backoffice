{{ config(
    tags = ["ps_rna_bh_plac_stg"], 
    alias = "ps_rna_bh_plac_stg"
    )
}}

select *, current_timestamp() as insert_datetime
from {{ ref( 'stg_ps_rna_bh_plac_stg')}}
