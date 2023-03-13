{{ config(
    tags = ["psxlatitem_fs", "psxlatitem", "po_assignments"], 
    alias = 'psxlatitem_fs'
    )
}}

with source_psxlatitem_fs as (
    select *
    from {{ source( 'datalake-frontoffice-fs_bo', 'PSXLATITEM') }} 
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
    from source_psxlatitem_fs
    QUALIFY ROW_NUMBER() OVER (PARTITION BY fieldname, fieldvalue, effdt ORDER BY lastupddttm DESC) = 1
)

SELECT *
from final
