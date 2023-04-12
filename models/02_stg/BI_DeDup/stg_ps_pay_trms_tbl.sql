{{ config(
    tags = ["ps_pay_trms_tbl"], 
    alias = "ps_pay_trms_tbl"
    )
}}

SELECT
        setid
        , pymnt_terms_cd
        , effdt
        , eff_status
        , descr50
        , descrshort
        , pymnt_terms_dt
        , pymnt_terms_amt
        , ps_system
        , insert_datetime as source_insert_datetime

FROM {{ source( 'datalake-frontoffice-fs_bo', 'PS_PAY_TRMS_TBL' )}} 

WHERE eff_status = 'A'

QUALIFY ROW_NUMBER() OVER (PARTITION BY setid, pymnt_terms_cd ORDER BY effdt DESC) = 1
