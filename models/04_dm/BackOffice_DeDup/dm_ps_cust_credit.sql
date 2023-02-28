{{ config(
    tags = ["ps_cust_credit", "backoffice"], 
    alias = "ps_cust_credit"
    )
}}

select *
from {{ ref( 'dwh_ps_cust_credit')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_cust_credit')}}
                        )
