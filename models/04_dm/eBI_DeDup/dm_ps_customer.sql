{{ config(
    tags = ["ps_customer"], 
    alias = "ps_customer"
    )
}}

select *
from {{ ref( 'dwh_ps_customer')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_customer')}}
                        )
