{{ config(
    tags = ["ps_assignment", "backoffice"], 
    alias = "ps_assignment"
    )
}}

select *
from {{ ref( 'dwh_ps_assignment')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_assignment')}}
                        )
