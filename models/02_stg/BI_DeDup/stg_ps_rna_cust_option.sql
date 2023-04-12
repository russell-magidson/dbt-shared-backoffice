{{ config(
    tags = ["ps_rna_cust_option"], 
    alias = "ps_rna_cust_option"
    )
}}

SELECT
        setid
        ,cust_id
        ,effdt
        ,rna_weekday
        ,last_maint_oprid
        ,date_last_maint
        ,length_min
        ,length_max
        ,po_format_mask
        ,validate_po
        ,rna_ot_factor
        ,rna_dt_factor
        ,vms_account
        ,rna_cal_bill_flg
        ,calendar_id
        ,rna_vol_discount
        ,rna_rebate_accrual
        ,rna_proc_fee_amt
        ,rna_proc_fee_pct
        ,rna_vol_fee_pct
        ,rna_vol_handling
        ,descr254
        ,rna_tool_fee_flg
        ,rna_tool_fee
        ,rna_tenure_dis
        ,rna_admin_accrual
        ,rna_vol_disc_flg
        ,rna_msp_fee_pct
        ,rna_msp_fee_flg
        ,rna_early_pay_dis
        ,rna_epd_flg
        ,currency_cd
        ,liquidate_flag
        ,expenses_flag
        ,rna_direct_hire_fl
        ,insert_datetime as source_insert_datetime

FROM {{ source( 'datalake-frontoffice-fs_bo', 'PS_RNA_CUST_OPTION')}} 

QUALIFY ROW_NUMBER() OVER (PARTITION BY setid, cust_id, effdt ORDER BY effdt DESC) = 1
