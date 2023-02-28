{{ config(
    tags = ["ps_cust_credit", "dedup", "backoffice"], 
    alias = 'ps_cust_credit'
    )
}}

SELECT
        setid
        ,cust_id
        ,effdt
        ,eff_status
        ,cr_limit
        ,cr_limit_range
        ,cr_limit_dt
        ,cr_limit_corp
        ,cr_lim_corp_range
        ,cr_limit_corp_dt
        ,cr_limit_rev_dt
        ,dispute_status
        ,dispute_dt
        ,dispute_amount
        ,collection_status
        ,collection_dt
        ,risk_code
        ,risk_score
        ,credit_class
        ,credit_check
        ,cr_chk_alg_profile
        ,cr_sum_profile
        ,max_order_amt
        ,custcr_pct_ovr
        ,corpcr_pct_ovr
        ,currency_cd
        ,rt_type
        ,last_maint_oprid
        ,date_last_maint
        ,aging_category
        ,aging_id
        ,backlog_days
        ,rna_sugg_cr_limit
        ,ar_1099c
        ,bankrupt_flg
        ,market_value
        ,ar_1099c_bu
        ,personally_liable
        ,descrlong
        ,insert_datetime as source_insert_datetime

FROM {{ source( 'datalake-frontoffice-fs_bo', 'PS_CUST_CREDIT') }} 
    
QUALIFY ROW_NUMBER() OVER (PARTITION BY cust_id, setid ORDER BY effdt DESC) = 1
