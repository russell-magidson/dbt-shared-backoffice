{{ config(
    tags = ["department_search"], 
    alias = "department_search"
    )
}}

select *
from {{ ref( 'dwh_department_search')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_department_search')}}
                        )
