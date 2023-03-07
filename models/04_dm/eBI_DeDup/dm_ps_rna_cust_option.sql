{{ config(
    tags = ["ps_rna_cust_option"], 
    alias = "ps_rna_cust_option"
    )
}}

select *
from {{ ref( 'stg_ps_rna_cust_option')}}
{# where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_rna_cust_option')}}
                        ) #}
