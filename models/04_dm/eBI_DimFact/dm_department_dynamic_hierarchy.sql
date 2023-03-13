{{ config(
    tags = ["department_dynamic_hierarchy"], 
    alias = "department_dynamic_hierarchy"
    )
}}

select *
from {{ ref( 'dwh_department_dynamic_hierarchy')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_department_dynamic_hierarchy')}}
                        )
