{{ config(
    tags = ["ps_job"], 
    alias = 'ps_job'
    )
}}

SELECT
        emplid
        ,empl_rcd
        ,effdt
        ,effseq
        ,per_org
        ,deptid
        ,jobcode
        ,position_nbr
        ,supervisor_id
        ,position_override
        ,posn_change_record
        ,empl_status
        ,action
        ,action_dt
        ,action_reason
        ,location
        ,tax_location_cd
        ,job_entry_dt
        ,dept_entry_dt
        ,position_entry_dt
        ,shift
        ,reg_temp
        ,full_part_time
        ,company
        ,paygroup
        ,bas_group_id
        ,elig_config1
        ,elig_config2
        ,elig_config3
        ,elig_config4
        ,elig_config5
        ,elig_config6
        ,elig_config7
        ,elig_config8
        ,elig_config9
        ,ben_status
        ,bas_action
        ,cobra_action
        ,empl_type
        ,holiday_schedule
        ,std_hours
        ,std_hrs_frequency
        ,officer_cd
        ,empl_class
        ,sal_admin_plan
        ,grade
        ,grade_entry_dt
        ,step
        ,step_entry_dt
        ,gl_pay_type
        ,acct_cd
        ,earns_dist_type
        ,comp_frequency
        ,comprate
        ,change_amt
        ,change_pct
        ,annual_rt
        ,monthly_rt
        ,daily_rt
        ,hourly_rt
        ,annl_benef_base_rt
        ,shift_rt
        ,shift_factor
        ,currency_cd
        ,business_unit
        ,setid_dept
        ,setid_jobcode
        ,setid_location
        ,setid_salary
        ,reg_region
        ,directly_tipped
        ,flsa_status
        ,eeo_class
        ,function_cd
        ,tariff_ger
        ,tariff_area_ger
        ,perform_group_ger
        ,labor_type_ger
        ,spk_comm_id_ger
        ,hourly_rt_fra
        ,accdnt_cd_fra
        ,value_1_fra
        ,value_2_fra
        ,value_3_fra
        ,value_4_fra
        ,value_5_fra
        ,ctg_rate
        ,paid_hours
        ,paid_fte
        ,paid_hrs_frequency
        ,union_full_part
        ,union_pos
        ,matricula_nbr
        ,soc_sec_risk_code
        ,union_fee_amount
        ,union_fee_start_dt
        ,union_fee_end_dt
        ,exempt_job_lbr
        ,exempt_hours_month
        ,wrks_cncl_function
        ,interctr_wrks_cncl
        ,currency_cd1
        ,pay_union_fee
        ,union_cd
        ,barg_unit
        ,union_seniority_dt
        ,entry_date
        ,labor_agreement
        ,empl_ctg
        ,empl_ctg_l1
        ,empl_ctg_l2
        ,setid_lbr_agrmnt
        ,wpp_stop_flag
        ,labor_facility_id
        ,lbr_fac_entry_dt
        ,layoff_exempt_flag
        ,layoff_exempt_rsn
        ,gp_paygroup
        ,gp_dflt_elig_grp
        ,gp_elig_grp
        ,gp_dflt_currttyp
        ,cur_rt_type
        ,gp_dflt_exrtdt
        ,gp_asof_dt_exg_rt
        ,adds_to_fte_actual
        ,class_indc
        ,encumb_override
        ,fica_status_ee
        ,fte
        ,prorate_cnt_amt
        ,pay_system_flg
        ,border_walker
        ,lump_sum_pay
        ,contract_num
        ,job_indicator
        ,wrks_cncl_role_che
        ,benefit_system
        ,work_day_hours
        ,hr_status
        ,appt_type
        ,main_appt_num_jpn
        ,reports_to
        ,force_publish
        ,job_data_src_cd
        ,estabid
        ,supv_lvl_id
        ,setid_supv_lvl
        ,absence_system_cd
        ,poi_type
        ,hire_dt
        ,last_hire_dt
        ,termination_dt
        ,asgn_start_dt
        ,lst_asgn_start_dt
        ,asgn_end_dt
        ,ldw_ovr
        ,last_date_worked
        ,expected_return_dt
        ,expected_end_date
        ,auto_end_flg
        ,lastupddttm
        ,lastupdoprid
        ,insert_datetime as source_insert_datetime

from {{ source( 'datalake-frontoffice-hr_bo', 'PS_JOB') }} 
       
QUALIFY ROW_NUMBER() OVER (PARTITION BY  emplid, empl_rcd, effdt, effseq ORDER BY lastupddttm DESC) = 1
