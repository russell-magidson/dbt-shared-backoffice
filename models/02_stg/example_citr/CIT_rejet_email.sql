{{ config(
    enabled=false,
    schema="referentiel_talent_marketing",
    materialized='table',
    tags = ["cit","marketing"]
    ) }}

select * from {{ source('stg_referentiel_talent_marketing', 'CIT_check_quality_email') }}
-- `fr-parisstg-dev-966b.referentiel_talent_marketing.CIT_check_quality_email`
where PTEST_isconsistency_email=False