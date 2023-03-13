{{ config(
    tags = ["ps_vi_v_time_card"], 
    alias = "ps_vi_v_time_card"
    )
}}

SELECT
    business_unit
    , vi_v_batch_id
    , vi_v_time_card
    , seq_nbr
    , pay_end_dt
    , vi_v_grand_total
    , vi_v_total_reg
    , vi_v_total_ot
    , vi_v_total_dt
    , vi_sep_chk_flg
    , vi_empl_sig_flg
    , vi_auth_sig_flg
    , vi_ot_ok_flg
    , vi_pay_period_end
    , vi_v_batch_type
    , vi_v_tc_type
    , bi_distrib_status
    , vi_pc_distrib_st
    , vi_ap_distrib_st
    , vi_py_distrib_st
    , vi_v_tc_status
    , oprid_entered_by
    , oprid_last_updt
    , dttime_added
    , dttime_last_maint
    , dttm_closed
    , dttm_complete
    , national_id
    , emplid
    , vi_job
    , project_id
    , activity_id
    , process_instance
    , vi_re_status
    , vi_core_status
    , descr254_mixed
    , insert_datetime as source_insert_datetime

FROM {{ source( 'datalake-frontoffice-fs_bo', 'PS_VI_V_TIME_CARD')}}

WHERE EXTRACT(YEAR FROM pay_end_dt) >= 2021

QUALIFY ROW_NUMBER() OVER (PARTITION BY business_unit, vi_v_batch_id, vi_v_time_card ORDER BY DTTIME_ADDED , DTTIME_LAST_MAINT DESC) = 1
