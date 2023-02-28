{{ config(
    tags = ["ps_item_activity", "dedup", "backoffice"], 
    alias = 'ps_item_activity'
    )
}}

select *
from {{ ref( 'dwh_ps_item_activity')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_ps_item_activity')}}
                        )
