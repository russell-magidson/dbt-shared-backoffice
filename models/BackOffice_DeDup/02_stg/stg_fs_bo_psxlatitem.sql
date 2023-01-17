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

FROM {{ source( 'datalake-frontoffice-fs_bo', 'PSXLATITEM') }} 
