{{ config(
    tags = ["ps_rna_cust_option", "dedup", "backoffice"], 
    alias = "ps_rna_cust_option"
    )
}}

select *
from {{ ref( 'dwh_ps_rna_cust_option')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_rna_cust_option')}}
                        )
