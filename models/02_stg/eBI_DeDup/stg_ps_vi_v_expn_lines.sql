{{ config(
    tags = ["ps_vi_v_expn_lines"], 
    alias = "ps_vi_v_expn_lines"
    )
}}

SELECT
        expnln.business_unit
    , expnln.vi_v_batch_id
    , expnln.vi_v_time_card
    , expnln.seq_nbr
    , expnln.date_wrk
    , expnln.project_id
    , expnln.time_rptg_cd
    , expnln.vi_time_rptg_cdb
    , expnln.vi_v_total_units
    , expnln.vi_pay_rate
    , expnln.rate_amount
    , expnln.vi_v_total_amount
    , expnln.billing_action
    , expnln.markup_multiplier
    , expnln.descr
    , expnln.dttime_added
    , expnln.dttime_last_maint
    , expnln.insert_datetime as source_insert_datetime

from {{ source( 'datalake-frontoffice-fs_bo', 'PS_VI_V_TIME_CARD')}} as tcard

inner join {{ source( 'datalake-frontoffice-fs_bo', 'PS_VI_V_EXPN_LINES')}} as expnln
    ON tcard.business_unit = expnln.business_unit
    AND tcard.vi_v_batch_id = expnln.vi_v_batch_id
    AND tcard.vi_v_time_card = expnln.vi_v_time_card

QUALIFY ROW_NUMBER() OVER (PARTITION BY expnln.business_unit
                                        , expnln.vi_v_batch_id
                                        , expnln.vi_v_time_card
                                        , expnln.seq_nbr
                                        , expnln.date_wrk
                                        , expnln.project_id
                                        , expnln.time_rptg_cd
                                        , expnln.vi_time_rptg_cdb     
                            ORDER BY DTTIME_ADDED , expnln.DTTIME_LAST_MAINT DESC) = 1
