{{ config(
    tags = ["ps_vi_ave_master", "po_assignments"], 
    alias = "ps_vi_ave_master"
    )
}}

SELECT vi_aveid
    ,effdt
    ,effseq
    ,national_id
    ,last_name_srch
    ,first_name_srch
    ,setid
    ,vendor_id
    ,vndr_loc
    ,name
    ,descr
    ,vi_ave_status
    ,email_addr
    ,lastupddttm
    ,lastupdoprid
    ,insert_datetime as source_insert_datetime

FROM {{ source( 'datalake-frontoffice-fs_bo', 'PS_VI_AVE_MASTER')}}

QUALIFY ROW_NUMBER() OVER (PARTITION BY vi_aveid ORDER BY effdt DESC) = 1
