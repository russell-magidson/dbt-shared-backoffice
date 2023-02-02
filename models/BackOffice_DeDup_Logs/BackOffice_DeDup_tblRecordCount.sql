{# Log the record counts for BI_DeDup #}
{{ log_record_count( 
    'BackOffice_DeDup'
    , "
        'psoprdefn', 
        'ps_assignment', 
        'ps_bi_hdr', 
        'ps_bi_hdr_line', 
        'ps_bi_line', 
        'ps_ca_contr_hdr', 
        'ps_cust_address', 
        'ps_cust_credit', 
        'ps_customer', 
        'ps_earnings_tbl', 
        'ps_item', 
        'ps_item_activity', 
        'ps_job', 
        'ps_jobcode_tbl', 
        'ps_names', 
        'ps_pay_check', 
        'ps_pay_earnings', 
        'ps_pay_trms_tbl', 
        'ps_personal_data', 
        'ps_project', 
        'ps_rdm_revcost_dtl', 
        'ps_rna_bh_plac_stg', 
        'ps_rna_cust_option', 
        'ps_rna_pymnt_term', 
        'ps_rs_assignment', 
        'ps_vi_ave_master', 
        'ps_vi_pay_earnings', 
        'ps_vi_v_expn_lines', 
        'ps_vi_v_time_card', 
        'psxlatitem_fs', 
        'psxlatitem_hr'
    "
) }}
