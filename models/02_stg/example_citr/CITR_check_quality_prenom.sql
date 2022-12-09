{{ config(
    enabled=false,
    schema="referentiel_talent_marketing",
    materialized='table',
    tags = ["cit","marketing"]
    ) }}

WITH PRIMARY_STACK_prenom AS( 
select 
*,
length(prenom) as NUM_name_length,
if(TRIM(prenom)='',TRUE, FALSE) as STEST_isWhiteSpace,
case when lower(prenom) in ('sn', 'sans nom') then TRUE else FALSE end as STEST_no_name,
if(prenom is null, TRUE, FALSE) as STEST_isNull,
ifnull(regexp_contains(prenom, "^(-|\\s)"),FALSE) as STEST_hasBadFirstChar, 
ifnull(regexp_contains(prenom, "(-|\\s|')$"), FALSE) as STEST_hasBadLastChar,
ifnull(regexp_contains(prenom, "\\d"), FALSE) as STEST_isDigit,
ifnull(regexp_contains(replace(prenom,"\\","$"), "[!@#$%^&*()+=\\[\\]{};:+\"\\|,<>\\/?]"),FALSE) as STEST_hasSpecialChar,
case 
    when regexp_extract(prenom, "([- ']{2})")!='--' 
    and regexp_contains(prenom, "([- ']{2})") is TRUE then TRUE else FALSE 
end as STEST_repeated_char,
lower(prenom) as CAT_replicate, --tosolve replicatedChar(lower(prenom)) as CAT_replicate,
if(lower(Nomnaissance)=lower(prenom), TRUE, FALSE) as STEST_sameName,
ifnull(regexp_contains(lower(prenom), '^(monsieur|madame|mademoiselle|mr|mme|mlle|dr|sir)(\\s+\\w+|$)'), FALSE) as STEST_civilite
from (
    select Identitifiant as identifiant, prenom,nomnaissance,FlagInactif,statut,marque,si_source, Accounttypelb
    from {{ source('dwh_referentiel_talent_marketing', 'carte_identite_talent_cross_si_randstad') }}
)TB

)
select F0.*, 
if(PTEST_isValidFormat_prenom=FALSE or CAT_replicate!='less than 3 rep.' or STEST_sameName=TRUE,FALSE,TRUE) as PTEST_isConsistency_prenom,
if(F1.prenom is null, FALSE, TRUE) as STEST_isUnique
from(

	select *,
	if(STEST_isWhitespace or STEST_isNull, FALSE, TRUE) as PTEST_isCompleted_prenom,
	case when STEST_isWhiteSpace=FALSE
	and STEST_no_name=FALSE 
	and STEST_isNull=FALSE
	and STEST_hasBadFirstChar=FALSE 
	and STEST_hasBadLastChar=FALSE 
	and STEST_isDigit=FALSE
	and STEST_civilite=FALSE
    and STEST_hasSpecialChar=FALSE 
	then TRUE else FALSE
	end as PTEST_isValidFormat_prenom
	from PRIMARY_STACK_prenom

)F0 
left join 
(
    select marque,prenom 
    from (
        select marque,prenom, count(*) as nb_rows 
        from {{ source('dwh_referentiel_talent_marketing', 'carte_identite_talent_cross_si_randstad') }}
        group by marque,prenom
        order by count(*)
    )B 
    where nb_rows=1

)F1 
on F0.marque=F1.marque and F0.prenom=F1.prenom

