{{ config(
    tags = ["ps_rdm_revcost_dtl"], 
    alias = "ps_rdm_revcost_dtl"
    )
}}

SELECT 
    rna_report_date
    ,business_unit
    ,invoice
    ,line_seq_num
    ,adj_nbr
    ,accounting_dt
    ,fiscal_year
    ,accounting_period
    ,rna_weekno
    ,rna_quarter
    ,bill_to_cust_id
    ,address_seq_num
    ,corporate_cust_id
    ,cust_name
    ,rna_new_customer
    ,rna_new_cust_dm
    ,deptid
    ,rna_branch_type
    ,rna_branch
    ,rna_unit
    ,rna_unit_type
    ,rna_specialty_type
    ,rna_unit_age
    ,order_id
    ,emplid
    ,date_wrk
    ,rna_talent_worked
    ,rna_talent_wrk_dm
    ,rna_dir_hire_count
    ,qty
    ,rna_reg_bill_hrs
    ,rna_ovt_bill_hrs
    ,rna_dbl_bill_hrs
    ,rna_oth_bill_hrs
    ,rna_tot_bnp_hrs
    ,rna_bnp_ppf_hrs
    ,rna_bnp_liq_hrs
    ,rna_bnp_oth_hrs
    ,rna_reg_pay_hrs
    ,rna_ovt_pay_hrs
    ,rna_dbl_pay_hrs
    ,rna_oth_pay_hrs
    ,rna_averegbill_hrs
    ,rna_aveovtbill_hrs
    ,rna_avedblbill_hrs
    ,rna_aveothbill_hrs
    ,rna_1099regbil_hrs
    ,rna_1099ovtbil_hrs
    ,rna_1099dblbil_hrs
    ,rna_1099othbil_hrs
    ,rna_averegpay_hrs
    ,rna_aveovtpay_hrs
    ,rna_avedblpay_hrs
    ,rna_aveothpay_hrs
    ,rna_1099regpay_hrs
    ,rna_1099ovtpay_hrs
    ,rna_1099dblpay_hrs
    ,rna_1099othpay_hrs
    ,unit_amt
    ,rna_ave_bill_rt
    ,rna_1099_bill_rt
    ,rna_regbill_rt
    ,rna_ovt_bill_rt
    ,rna_dbl_bill_rt
    ,rna_oth_bill_rt
    ,rna_avereg_bill_rt
    ,rna_aveovt_bill_rt
    ,rna_avedbl_bill_rt
    ,rna_aveoth_bill_rt
    ,rna_1099regbill_rt
    ,rna_1099ovtbill_rt
    ,rna_1099dblbill_rt
    ,rna_1099othbill_rt
    ,pay_rate
    ,rna_ave_pay_rt
    ,rna_1099_pay_rt
    ,rna_regpay_rt
    ,rna_ovt_pay_rt
    ,rna_dbl_pay_rt
    ,rna_oth_pay_rt
    ,rna_avereg_pay_rt
    ,rna_aveovt_pay_rt
    ,rna_avedbl_pay_rt
    ,rna_aveoth_pay_rt
    ,rna_1099regpay_rt
    ,rna_1099ovtpay_rt
    ,rna_1099dblpay_rt
    ,rna_1099othpay_rt
    ,time_rptg_cd
    ,unit_of_measure
    ,service_area
    ,rna_service_descr
    ,gross_extended_amt
    ,rna_tot_bill_amt
    ,rna_manual_rev
    ,rna_weekly_rev
    ,rna_biweekly_rev
    ,rna_monthly_rev
    ,rna_weeklyave_rev
    ,rna_biweekave_rev
    ,rna_monthlyave_rev
    ,rna_weekly1099_rev
    ,rna_biweek1099_rev
    ,rna_monthly1099rev
    ,rna_flexible_rev
    ,rna_reg_bill_amt
    ,rna_ovt_bill_amt
    ,rna_dbl_bill_amt
    ,rna_oth_bill_amt
    ,rna_reg_pay_amt
    ,rna_ovt_pay_amt
    ,rna_dbl_pay_amt
    ,rna_oth_pay_amt
    ,rna_avetot_bil_amt
    ,rna_1099totbil_amt
    ,rna_avetot_pay_amt
    ,rna_1099totpay_amt
    ,rna_averegbill_amt
    ,rna_aveovtbill_amt
    ,rna_avedblbill_amt
    ,rna_aveothbill_amt
    ,rna_1099regbil_amt
    ,rna_1099ovtbil_amt
    ,rna_1099dblbil_amt
    ,rna_1099othbil_amt
    ,rna_averegpay_amt
    ,rna_aveovtpay_amt
    ,rna_avedblpay_amt
    ,rna_aveothpay_amt
    ,rna_1099regpay_amt
    ,rna_1099ovtpay_amt
    ,rna_1099dblpay_amt
    ,rna_1099othpay_amt
    ,rna_tot_pnb_amt
    ,rna_tot_bnp_amt
    ,rna_bnp_ppf_amt
    ,rna_bnp_liq_amt
    ,rna_bnp_oth_amt
    ,net_extended_amt
    ,tax_amt
    ,rna_avetax_amt
    ,rna_1099tax_amt
    ,tot_discount_amt
    ,rna_avetotdisc_amt
    ,rna_1099totdsc_amt
    ,tot_surcharge_amt
    ,rna_avetotsur_amt
    ,rna_1099totsur_amt
    ,resource_quantity
    ,resource_amount
    ,labor_cost
    ,other_cost
    ,rna_tot_pay_amt
    ,rna_burden_amount
    ,rna_projave_payrt
    ,business_unit_pc
    ,vendor_id
    ,rna_vendor_name
    ,vndr_loc
    ,csf_id
    ,rna_biline_adddttm
    ,date_added
    ,account
    ,rna_account_exp
    ,rna_account_disc
    ,rna_account_av_rev
    ,rna_account_av_exp
    ,rna_acct_1099_rev
    ,rna_acct_1099_exp
    ,account_p
    ,account_r
    ,account_i
    ,account_u
    ,entry_type
    ,entry_reason
    ,post_dt
    ,cust_id
    ,journal_id
    ,journal_date
    ,source
    ,rna_transact_type
    ,project_id
    ,activity_id
    ,contract_num
    ,contract_line_num
    ,contract_type
    ,resource_id_from
    ,resource_sub_cat
    ,rna_ff_analysis_ty
    ,rna_vendor_type
    ,rna_burden_account
    ,insert_datetime as source_insert_datetime

FROM {{ source( 'datalake-frontoffice-wh_bo', 'PS_RDM_REVCOST_DTL')}}

WHERE EXTRACT(YEAR FROM rna_report_date) >= 2021

QUALIFY ROW_NUMBER() OVER (PARTITION BY rna_report_date, business_unit, invoice, line_seq_num, adj_nbr ORDER BY insert_datetime DESC) = 1
