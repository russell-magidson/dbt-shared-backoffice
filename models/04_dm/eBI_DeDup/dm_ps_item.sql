{{ config(
    tags = ["ps_item"], 
    alias = "ps_item"
    )
}}

select *
from {{ ref( 'dwh_ps_item')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_item')}}
                        )
