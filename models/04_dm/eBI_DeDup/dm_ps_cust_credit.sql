{{ config(
    tags = ["ps_cust_credit"], 
    alias = "ps_cust_credit"
    )
}}

select *
from {{ ref( 'stg_ps_cust_credit')}}
{# where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_cust_credit')}}
                        ) #}
