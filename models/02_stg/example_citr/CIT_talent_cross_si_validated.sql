{{ config(
    enabled=false,
    schema="referentiel_talent_marketing",
    materialized='table',
    tags = ["cit","marketing"]
) }}


select A.*
from {{ source('dwh_referentiel_talent_marketing', 'carte_identite_talent_cross_si_randstad') }} A
-- `fr-parisdwh-dev-8dcb.referentiel_talent_marketing.carte_identite_talent_cross_si_randstad`A
inner join {{ source('stg_referentiel_talent_marketing', 'CIT_check_quality_email') }} B
-- `fr-parisstg-dev-966b.referentiel_talent_marketing.CIT_check_quality_email`B
ON A.Identitifiant = B.Identifiant 
inner join {{ source('stg_referentiel_talent_marketing', 'CIT_check_quality_prenom') }} C
-- `fr-parisstg-dev-966b.referentiel_talent_marketing.CIT_check_quality_prenom`
ON A.Identitifiant = C.Identifiant
where PTEST_isConsistency_email=TRUE and PTEST_isConsistency_prenom=TRUE