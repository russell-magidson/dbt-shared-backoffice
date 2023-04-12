{{ config(
    tags = ["ps_pay_earnings"], 
    alias = 'ps_pay_earnings'
    )
}}

SELECT
    payearn.company
    , payearn.paygroup
    , payearn.pay_end_dt
    , payearn.off_cycle
    , payearn.page_num
    , payearn.line_num
    , payearn.addl_nbr
    , payearn.sepchk
    , payearn.emplid
    , payearn.empl_rcd
    , payearn.benefit_rcd_nbr
    , payearn.earns_end_dt
    , payearn.earns_begin_dt
    , payearn.addlpay_reason
    , payearn.disable_dir_dep
    , payearn.grossup
    , payearn.pay_line_status
    , payearn.ok_to_pay
    , payearn.job_pay
    , payearn.single_check_use
    , payearn.acct_cd
    , payearn.gl_pay_type
    , payearn.deptid
    , payearn.jobcode
    , payearn.position_nbr
    , payearn.shift
    , payearn.shift_rt
    , payearn.hourly_rt
    , payearn.flsa_rt
    , payearn.rate_used
    , payearn.flsa_required
    , payearn.erncd_reg_hrs
    , payearn.erncd_ot_hrs
    , payearn.reg_pay_hrs
    , payearn.reg_hrs
    , payearn.ot_hrs
    , payearn.reg_hrly_earns
    , payearn.ot_hrly_earns
    , payearn.erncd_reg_earns
    , payearn.reg_pay
    , payearn.reg_earns
    , payearn.reg_earn_hrs
    , payearn.ded_taken
    , payearn.ded_subset_id
    , payearn.ded_taken_genl
    , payearn.ded_subset_genl
    , payearn.state
    , payearn.locality
    , payearn.pay_frequency
    , payearn.tax_periods
    , payearn.tax_method
    , payearn.addl_taxes
    , payearn.override_hourly_rt
    , payearn.tl_source
    , payearn.pay_sheet_src
    , payearn.business_unit
    , payearn.ei_prior_pd_corr
    , payearn.comp_ratecd_reg
    , payearn.comp_ratecd_ot
    , payearn.comprate_used_reg
    , payearn.comprate_used_ot
    , payearn.fica_status_ee
    , payearn.paid_prds_per_year
    , payearn.flsa_end_dt
    , payearn.orig_paygroup
    , payearn.flsa_status
    , payearn.xref_num
    , payearn.union_cd
    , payearn.ben_ded_status
    , payearn.genl_ded_status
    , payearn.hdm_id
    , payearn.hp_contract_num
    , payearn.hp_contract_seq
    , payearn.py_jur_code
    , payearn.update_dt
    , payearn.insert_datetime as source_insert_datetime

FROM {{ source( 'datalake-frontoffice-hr_bo', 'PS_PAY_CHECK')}}  as paycheck

INNER JOIN {{ source( 'datalake-frontoffice-hr_bo', 'PS_PAY_EARNINGS')}} as payearn
    ON paycheck.company = payearn.company
    AND paycheck.paygroup = payearn.paygroup
    AND paycheck.pay_end_dt = payearn.pay_end_dt
    AND paycheck.off_cycle = payearn.off_cycle
    AND paycheck.page_num = payearn.page_num
    AND paycheck.line_num = payearn.line_num
    AND paycheck.sepchk = payearn.sepchk

WHERE 1=1
    AND payearn.pay_line_status = 'F'
    
QUALIFY ROW_NUMBER() OVER (PARTITION BY paycheck.company, paycheck.paygroup, paycheck.pay_end_dt, paycheck.off_cycle, paycheck.page_num, paycheck.line_num, payearn.addl_nbr ORDER BY paycheck.UPDATE_DT DESC) = 1
