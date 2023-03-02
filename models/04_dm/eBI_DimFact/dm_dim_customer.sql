{{ config(
    tags = ["dim_customer"], 
    alias = "dim_customer"
    )
}}

select *
from {{ ref( 'dwh_dim_customer')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_dim_customer')}}
                        )
