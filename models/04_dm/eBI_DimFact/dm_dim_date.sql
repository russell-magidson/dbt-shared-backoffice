{{ config(
    tags = ["dim_date"], 
    alias = "dim_date"
    )
}}

select *
from {{ ref( 'stg_dim_date')}}
{# where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_dim_date')}}
                        ) #}
