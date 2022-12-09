{{ config(
    enabled=false,
    schema="referentiel_talent_marketing",
    materialized='table',
    tags = ["cit","marketing"]
    ) }}


{% call set_sql_header(config) %}
    CREATE TEMP FUNCTION replicatedChar(str STRING)
    RETURNS STRING 
    LANGUAGE js AS r"""
        var res=0;
        switch (true)
        {
        case /^(.)\1+$/.test(str):
            res='full rep.';
            break;    
        case /(.)\1{3,}/.test(str): 
            res='4 rep.'; 
            break;
        case /(.)\1{2,}/.test(str): 
            res='3 rep.'; 
            break;

        default: 
            res='less than 3 rep.';
        }
        return res;
    """;
{%- endcall %}

WITH PRIMARY_STACK_email AS (
select *,
replicatedChar(CAT_user_name) as CAT_replicate,
case when CAT_domain='N/A' then FALSE 
else REGEXP_CONTAINS(concat(CAT_user_name,CAT_domain), "[!@#$%^&*()+=°£€¤\\[\\]{};:+\"\\|<>\\/?]")
end as STEST_special_char,
ifnull(REGEXP_CONTAINS(CAT_domain, r"(hr-cp|randstad|expectrasearch|expectra|appelmedicalsearch|jbm-medical|appel-medical|randstadsearch)"), FALSE)  as STEST_isRandstad,
ifnull(regexp_contains(CAT_user_name, '(inconnu|pasdemail|fauxmail|^nomail|^noemail|exemple)'), FALSE) as STEST_hasBadWord,
if(CAT_user_name='N/A',-1, length(CAT_user_name)) as NUM_username_length
from (
    SELECT *,
    case 
        when email like '%@%' then TRUE else FALSE 
    end as STEST_at, 
    if(email is null,TRUE,FALSE) as STEST_isNull,
    if(TRIM(email)='',TRUE, FALSE) as STEST_isWhitespace,
    ifnull(REGEXP_EXTRACT(lower(email), r"(^[a-zA-Z0-9_.-]+)@"),'N/A') AS CAT_user_name,
    ifnull(REGEXP_EXTRACT(lower(email), r"@([a-zA-Z0-9_.-]+$)"),'N/A') AS CAT_domain, 
    ifnull(NET.REG_DOMAIN(lower(email)), 'N/A') AS CAT_reg_domain,
    ifnull(NET.PUBLIC_SUFFIX(lower(email)),'N/A') AS CAT_suffix_domain,
    length(email) as NUM_email_length
    from (
        SELECT identitifiant as identifiant,email, FlagInactif, statut, si_source, marque,Accounttypelb
        FROM  {{ source('dwh_referentiel_talent_marketing', 'carte_identite_talent_cross_si_randstad') }}

    )T0
    
)T1

)
select 
F0.*,
if (PTEST_isValidFormat_email=FALSE or STEST_hasBadWord=TRUE or NUM_username_length<=1, FALSE, TRUE) as PTEST_isConsistency_email, 
if(F1.CAT_occurence="unique", TRUE, FALSE) as STEST_isUnique, 
ifnull(CAT_occurence,'N/A') as CAT_occurence, 
from(

  SELECT *, --,email, identifiant,
  if(STEST_isWhitespace or STEST_isNull, FALSE, TRUE) as PTEST_isCompleted_email,
  case 
  when 
  STEST_at=True and CAT_reg_domain!='N/A'
  and CAT_user_name!='N/A'
  and STEST_isRandstad=FALSE
  and CAT_replicate!='full rep.' then TRUE 
  else False end AS PTEST_isValidFormat_email
  from PRIMARY_STACK_email

)F0 
left join 
(
  select marque,email,
  case 
      when nb_rows=1 then 'unique'
      when nb_rows=2 then '2 times'
      when nb_rows=3 then '3 times'
      else 'more than 3 times'
end as CAT_occurence  
  from (
      select marque, email, count(*) as nb_rows 
      FROM {{ source('dwh_referentiel_talent_marketing', 'carte_identite_talent_cross_si_randstad') }}
      group by marque,email
      order by count(*)
  )B 

)F1 
on F0.marque=F1.marque and F0.email=F1.email