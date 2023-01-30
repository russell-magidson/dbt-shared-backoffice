{{ config(
    tags = ["psxlatitem_hr", "psxlatitem", "backoffice"], 
    alias = 'psxlatitem_hr'
    )
}}

SELECT
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

FROM {{ source( 'datalake-frontoffice-hr_bo', 'PSXLATITEM') }}
QUALIFY ROW_NUMBER() OVER (PARTITION BY fieldname, fieldvalue, effdt ORDER BY lastupddttm DESC) = 1
