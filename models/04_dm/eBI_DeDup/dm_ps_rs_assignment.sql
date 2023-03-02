{{ config(
    tags = ["ps_rs_assignment"], 
    alias = "ps_rs_assignment"
    )
}}

select *
from {{ ref( 'dwh_ps_rs_assignment')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_rs_assignment')}}
                        )
