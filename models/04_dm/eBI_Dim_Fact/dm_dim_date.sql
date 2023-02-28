{{ config(
    tags = ["dim_date", "backoffice"]
    , alias = "dim_date"
    , enables = false
    )
}}

select *
from {{ ref( 'dwh_dim_date')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_dim_date')}}
                        )
