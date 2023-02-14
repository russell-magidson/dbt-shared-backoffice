{{ config(
    tags = ["psxlatitem_hr", "backoffice"], 
    alias = "psxlatitem_hr"
    )
}}

select *
from {{ ref( 'dwh_psxlatitem_hr')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_psxlatitem_hr')}}
                        )
