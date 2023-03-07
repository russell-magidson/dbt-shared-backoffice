{{ config(
    tags = ["ps_item_activity"], 
    alias = 'ps_item_activity'
    )
}}

select *
from {{ ref( 'stg_ps_item_activity')}}
{# where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_item_activity')}}
                        ) #}
