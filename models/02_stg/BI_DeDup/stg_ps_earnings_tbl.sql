{{ config(
    tags = ["ps_earnings_tbl"], 
    alias = 'ps_earnings_tbl'
    )
}}

SELECT
    erncd
    , effdt
    , eff_status
    , descr
    , descrshort
    , ern_sequence
    , maintain_balances
    , budget_effect
    , allow_empltype
    , payment_type
    , hrly_rt_maximum
    , perunit_ovr_rt
    , earn_flat_amt
    , add_gross
    , subject_fwt
    , subject_fica
    , subject_fut
    , subject_cit
    , subject_cui
    , subject_cui_hours
    , subject_cpp
    , subject_qit
    , subject_qpp
    , subject_true_t4grs
    , subject_true_rvgrs
    , subject_pay_tax
    , subject_reg
    , withhold_fwt
    , hrs_only
    , shift_diff_elig
    , tax_grs_compnt
    , spec_calc_rtn
    , factor_mult
    , factor_rate_adj
    , factor_hrs_adj
    , factor_ern_adj
    , gl_expense
    , subtract_earns
    , dedcd_payback
    , tax_method
    , earn_ytd_max
    , based_on_type
    , based_on_erncd
    , based_on_acc_erncd
    , amt_or_hours
    , pna_use_sgl_empl
    , elig_for_retropay
    , used_to_pay_retro
    , effect_on_flsa
    , flsa_category
    , reg_pay_included
    , tips_category
    , add_de
    , subject_t4a
    , subject_rv2
    , gvt_benefits_rate
    , gvt_cpdf_erncd
    , gvt_oth_pay
    , gvt_pay_cap
    , gvt_prem_pay
    , gvt_ot_pay_ind
    , gvt_add_to_sf50_52
    , gvt_include_loc
    , gvt_irr_reportable
    , gvt_irr_lwop
    , gvt_sf113a_lumpsum
    , gvt_sf113a_wages
    , gvt_feffla
    , gvt_fmla
    , gvt_lv_earn_type
    , income_cd_1042
    , permanency_nld
    , tax_class_nld
    , hrs_dist_sw
    , hp_adminstip_flag
    , subject_qpip
    , rs_erncd_gtn_cd
    , insert_datetime as source_insert_datetime

FROM {{ source( 'datalake-frontoffice-hr_bo', 'PS_EARNINGS_TBL' )}} 

QUALIFY ROW_NUMBER() OVER (PARTITION BY erncd ORDER BY effdt DESC) = 1
