{{ config(
    tags = ["ps_vi_pay_earnings"], 
    alias = "ps_vi_pay_earnings"
    )
}}

SELECT
    vipayearn.company
    , vipayearn.paygroup
    , vipayearn.pay_end_dt
    , vipayearn.off_cycle
    , vipayearn.page_num
    , vipayearn.line_num
    , vipayearn.addl_nbr
    , vipayearn.sepchk
    , vipayearn.project_id
    , vipayearn.vi_v_time_card
    , vipayearn.bill_to_cust_id
    , vipayearn.rna_pay_to_proj_st
    , vipayearn.dttime_added
    , vipayearn.dttime_last_maint
    , vipayearn.insert_datetime as source_insert_datetime

FROM {{ ref( 'dm_ps_pay_earnings')}} as payearn

LEFT OUTER JOIN {{ source( 'datalake-frontoffice-fs_bo', 'PS_VI_PAY_EARNINGS')}} as vipayearn
    ON payearn.company = vipayearn.company
    AND payearn.paygroup = vipayearn.paygroup
    AND payearn.pay_end_dt = vipayearn.pay_end_dt
    AND payearn.off_cycle = vipayearn.off_cycle
    AND payearn.page_num = vipayearn.page_num
    AND payearn.line_num = vipayearn.line_num
    AND payearn.addl_nbr = vipayearn.addl_nbr
    AND payearn.sepchk = vipayearn.sepchk

WHERE EXTRACT(YEAR FROM vipayearn.pay_end_dt) >= 2021

QUALIFY ROW_NUMBER() OVER (PARTITION BY vipayearn.company, vipayearn.paygroup, vipayearn.pay_end_dt, vipayearn.off_cycle
                            , vipayearn.page_num, vipayearn.line_num, vipayearn.addl_nbr 
                            ORDER BY payearn.UPDATE_DT DESC, vipayearn.DTTIME_LAST_MAINT desc) = 1
