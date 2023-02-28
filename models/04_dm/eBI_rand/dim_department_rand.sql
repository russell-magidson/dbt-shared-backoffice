{{ config(
    tags = ["dim_department", "backoffice", "rand-rusaweb"], 
    alias = "dim_department"
    )
}}

{# SELECT *
FROM {{ ref( 'dm_dim_department')}} #}

select *
from {{ ref( 'dwh_dim_department')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_dim_department')}}
                        )
