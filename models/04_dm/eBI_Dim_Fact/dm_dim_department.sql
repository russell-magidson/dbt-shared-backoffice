{{ config(
    tags = ["dim_department", "backoffice"]
    , alias = "dim_department"
    , enabled = false
    )
}}

select *
from {{ ref( 'dwh_dim_department')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_dim_department')}}
                        )
