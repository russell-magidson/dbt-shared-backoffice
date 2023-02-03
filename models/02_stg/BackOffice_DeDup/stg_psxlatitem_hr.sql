{{ config(
    tags = ["psxlatitem_hr", "stg_psxlatitem_hr", "psxlatitem", "backoffice"], 
    alias = 'psxlatitem_hr'
    )
}}

with source_psxlatitem_hr as (
    select *
    from {{ source( 'datalake-frontoffice-hr_bo', 'PSXLATITEM') }}
)

, final as (
    select 
      fieldname
      , fieldvalue
      , effdt
      , eff_status
      , xlatlongname
      , xlatshortname
      , lastupddttm
      , lastupdoprid
      , syncid
      , insert_datetime as source_insert_datetime
    from source_psxlatitem_hr
    QUALIFY ROW_NUMBER() OVER (PARTITION BY fieldname, fieldvalue, effdt ORDER BY lastupddttm DESC) = 1
)

select *
from final
