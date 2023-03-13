{{ config(
    tags = ["ps_personal_data"], 
    alias = "ps_personal_data"
    )
}}

select *
from {{ ref( 'dwh_ps_personal_data')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_personal_data')}}
                        )
