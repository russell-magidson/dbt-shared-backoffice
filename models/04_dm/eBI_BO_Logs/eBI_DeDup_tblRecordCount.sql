{# Wait until all of the dependencies are done before generating our record counts #}
-- depends_on: {{ ref( 'dm_psoprdefn') }} 
-- depends_on: {{ ref( 'dm_ps_assignment') }} 
-- depends_on: {{ ref( 'dm_ps_bi_hdr') }} 
-- depends_on: {{ ref( 'dm_ps_bi_hdr_line') }} 
-- depends_on: {{ ref( 'dm_ps_bi_line') }} 
-- depends_on: {{ ref( 'dm_ps_ca_contr_hdr') }} 
-- depends_on: {{ ref( 'dm_ps_cust_address') }} 
-- depends_on: {{ ref( 'dm_ps_cust_credit') }} 
-- depends_on: {{ ref( 'dm_ps_customer') }} 
-- depends_on: {{ ref( 'dm_ps_earnings_tbl') }} 
-- depends_on: {{ ref( 'dm_ps_item') }} 
-- depends_on: {{ ref( 'dm_ps_item_activity') }} 
-- depends_on: {{ ref( 'dm_ps_job') }} 
-- depends_on: {{ ref( 'dm_ps_jobcode_tbl') }} 
-- depends_on: {{ ref( 'dm_ps_names') }} 
-- depends_on: {{ ref( 'dm_ps_pay_check') }} 
-- depends_on: {{ ref( 'dm_ps_pay_earnings') }} 
-- depends_on: {{ ref( 'dm_ps_pay_trms_tbl') }} 
-- depends_on: {{ ref( 'dm_ps_personal_data') }} 
-- depends_on: {{ ref( 'dm_ps_project') }} 
-- depends_on: {{ ref( 'dm_ps_rdm_revcost_dtl') }} 
-- depends_on: {{ ref( 'dm_ps_rna_bh_plac_stg') }} 
-- depends_on: {{ ref( 'dm_ps_rna_cust_option') }} 
-- depends_on: {{ ref( 'dm_ps_rna_pymnt_term') }} 
-- depends_on: {{ ref( 'dm_ps_rs_assignment') }} 
-- depends_on: {{ ref( 'dm_ps_vi_ave_master') }} 
-- depends_on: {{ ref( 'dm_ps_vi_pay_earnings') }} 
-- depends_on: {{ ref( 'dm_ps_vi_v_expn_lines') }} 
-- depends_on: {{ ref( 'dm_ps_vi_v_time_card') }} 
-- depends_on: {{ ref( 'dm_psxlatitem_fs') }} 
-- depends_on: {{ ref( 'dm_psxlatitem_hr') }}

{{ config( tags = ["recordcount", "backoffice"] 
    ) 
}}

{# Log the record counts for eBI_DeDup #}
{{ log_record_count( 
    'eBI_DeDup'
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
