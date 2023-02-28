{{ config(
    tags = ["dim_customer", "backoffice", "rand-rusaweb"], 
    alias = "dim_customer"
    )
}}

{# SELECT *
FROM {{ ref( 'dm_dim_customer')}} #}

select *
from {{ ref( 'dwh_dim_customer')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_dim_customer')}}
                        )
