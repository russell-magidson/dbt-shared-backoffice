{{ config(
    tags = ["psoprdefn"], 
    alias = "psoprdefn"
    )
}}

select *
from {{ ref( 'dwh_psoprdefn')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_psoprdefn')}}
                        )
