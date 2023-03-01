{{ config(
    tags = ["ps_cust_address"], 
    alias = 'ps_cust_address'
    )
}}

select *
from {{ ref( 'dwh_ps_cust_address')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_cust_address')}}
                        )
