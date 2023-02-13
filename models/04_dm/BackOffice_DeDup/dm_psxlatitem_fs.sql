{{ config(
    tags = ["psxlatitem_fs", "psxlatitem", "backoffice"], 
    alias = "psxlatitem_fs"
    )
}}

select *
from {{ ref( 'dwh_psxlatitem_fs')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_psxlatitem_fs')}}
                        )
