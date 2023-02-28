{{ config(
    tags = ["dim_date", "backoffice", "rand-rusaweb"], 
    alias = "dim_date"
    )
}}

{# SELECT *
FROM {{ ref( 'dm_dim_date')}} #}

select *
from {{ ref( 'dwh_dim_date')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_dim_date')}}
                        )
