{{ config(
    tags = ["dim_employee"], 
    alias = "dim_employee"
    )
}}

select *
from {{ ref( 'dwh_dim_employee')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_dim_employee')}}
                        )
