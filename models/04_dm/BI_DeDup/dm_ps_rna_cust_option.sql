{{ config(
    tags = ["ps_rna_cust_option"], 
    alias = "ps_rna_cust_option"
    )
}}

select *, current_timestamp() as insert_datetime
from {{ ref( 'stg_ps_rna_cust_option')}}
