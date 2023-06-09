{{ config(
    tags = ["ps_project"], 
    alias = "ps_project"
    )
}}

SELECT
    business_unit
    ,project_id
    ,last_activity_id
    ,eff_status
    ,in_use_sw
    ,integration_tmpl
    ,descr
    ,project_type
    ,business_unit_am
    ,asset_id
    ,profile_id
    ,system_source
    ,template_id
    ,template_sw
    ,afudc_proj_sw
    ,target_proj_sw
    ,sales_tax_proj_sw
    ,docket_number
    ,project_function
    ,last_criteria_id
    ,currency_cd
    ,rt_type
    ,cur_effdt_type
    ,percent_complete
    ,pc_act_option
    ,project_user1
    ,project_user2
    ,project_user3
    ,project_user4
    ,project_user5
    ,project_user_dt1
    ,project_user_dt2
    ,pc_user_currency
    ,project_useramt1
    ,project_useramt2
    ,project_useramt3
    ,an_grp_actv_bud
    ,an_grp_tot_costs
    ,set_override
    ,dttm_stamp
    ,pc_msp_usr1
    ,pc_msp_usr2
    ,pc_msp_proj_id
    ,pc_rev_activity
    ,enforce
    ,enforce_type
    ,tolerance
    ,pc_sch_product
    ,pc_sch_field1
    ,pc_sch_field2
    ,pc_sch_field3
    ,pc_sch_field4
    ,pc_sch_field5
    ,pc_sch_field6
    ,pc_sch_field7
    ,pc_sch_field8
    ,pc_indent_level
    ,proj_grant_status
    ,grant_flg
    ,gm_primary_flag
    ,pc_template_id
    ,pc_fnd_dist_sw
    ,setid
    ,start_dt
    ,end_dt
    ,baseline_start_dt
    ,baseline_finish_dt
    ,early_start_dt
    ,early_finish_dt
    ,actual_start_dt
    ,actual_finish_dt
    ,late_start_dt
    ,late_finish_dt
    ,pc_duration
    ,summary_prj
    ,pc_chc_sw
    ,pc_chc_template
    ,pc_calculate_sw
    ,pc_prj_def_calc_mt
    ,pc_act_def_calc_mt
    ,pc_hours_per_day
    ,pc_calc_method
    ,pc_sum_method
    ,pm_auto_review
    ,pm_auto_pop
    ,forecast_aut_app
    ,forecast_level
    ,forecast_rate
    ,forecast_src
    ,proj_request_id
    ,ppk_proj_version
    ,pgm_sched_method
    ,pc_percent_dttm
    ,holiday_list_id
    ,fms_dttm_stamp
    ,fms_oprid
    ,fms_lastupddttm
    ,fms_lastupdoprid
    ,constraint_dt_flg
    ,charging_level
    ,charging_level_tr
    ,rate_plan
    ,budget_approver
    ,scen_adjust_pct_tm
    ,scen_adjust_pct_ex
    ,template_types
    ,proj_tmpl_filter
    ,last_cbud_type
    ,last_rbud_type
    ,fna_requested
    ,managed_by_wo
    ,release
    ,category_ind
    ,application_area
    ,application
    ,rate_select
    ,pc_rev_bud_an_grp
    ,an_grp_tot_rev
    ,an_grp_eac
    ,retain_history
    ,an_grp_frev
    ,anltc_act_cost
    ,anltc_act_rev
    ,anltc_fc_cost
    ,anltc_fc_rev
    ,one_target_sw
    ,p6_incl_intgrtn
    ,p6_template_id
    ,p6_wbs_lvl
    ,insert_datetime as source_insert_datetime

FROM {{ source( 'datalake-frontoffice-fs_bo', 'PS_PROJECT')}}

QUALIFY ROW_NUMBER() OVER (PARTITION BY  business_unit, project_id ORDER BY fms_lastupddttm DESC) = 1
