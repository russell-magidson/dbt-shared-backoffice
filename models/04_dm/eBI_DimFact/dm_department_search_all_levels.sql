{{ config(
    tags = ["department_search_all_levels"], 
    alias = "department_search_all_levels"
    )
}}

select *
from {{ ref( 'dwh_department_search_all_levels')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_department_search_all_levels')}}
                        )

