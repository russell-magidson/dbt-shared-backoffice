{# create or replace table raw.rand_rusaweb.BI_DeDup.ps_assignment as #}
{{ config(
    tags = ["psxlatitem_hr", "backoffice"]
    )
}}

select *
from {{ ref( 'dwh_psxlatitem_hr')}}
where insert_datetime = ( SELECT max( insert_datetime)
                        from {{ ref( 'dwh_psxlatitem_hr')}}
                        )
