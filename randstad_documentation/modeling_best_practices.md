# List of modeling and development best practices and guidelines

The following is a non-exhaustive list of modeling and development best practices and guidelines. 
This is a living document, and should be treated as such. 
Guidelines and best practices are subject to change due to new insights.
Feel free to propose changes, updates or improvements wherever you see fit.

## General style and config:
- Project-wide, layer-specific or area-specific config goes into `dbt_project.yml`.
- Model- or table-specific config goes into `properties.yml` in the relevant models folder.
- Keep `config()` blocks out of the SQL files. Put all this config into `properties.yml`.
- Use helper models whenever your code becomes too complex or repetitive to handle in a single model. Use `hlp_<model name>` to indicate it's a helper model. Helper models should normally always be materialized as `ephemeral`, except when they are too big. In that case, they can also be `incremental`.

## SQL style guide:
- DO NOT OPTIMIZE FOR FEWER LINES OF CODE.
New lines are cheap, brain time is expensive; new lines should be used within reason to produce code that is easily read.
- Use trailing commas.
- Indents should use four spaces. Never use tabs.

## CTEs:
- CTEs are Common Table Expressions. Use them instead of subqueries! For example:
```sql
-- good
WITH cte AS (
  SELECT stuff FROM table
)
SELECT more_stuff FROM cte

-- bad
SELECT a.a AS b FROM ( SELECT c.a FROM (SELECT d.b AS a FROM table AS d) AS c) AS a 
```
- All `{{ ref() }}` or `{{ source() }}` statements should be placed within import CTEs so that dependent model references are easily seen and located.
- SQL should end with a simple select statement. All other logic should be contained within CTEs to make stepping through logic easier while troubleshooting. Example: `select * from final`


## Naming conventions:
- Use lower-case column names everywhere. Only the data mart layer can use a different casing for legibility. If a source uses `camelCase` columns, rename them to `snake_case` format in the _staging_ layer. Avoid `CAPITALIZED_COLUMN_NAME` columns.
- SQL keywords can be upper-case or lower-case, but try to stay consistent. Upper-case is preferred.
- Any timestamp should follow the naming convention `<event>_ts`; i.e. `created_ts`.
- Any date should follow the naming convention `<event>_date`, i.e. `created_date`.
- The column indicating when a record was created should be a timestamp and should be named `created_ts`.
- Similarly, the column indicating when a record was last updated should be a timestamp and should be named `modified_ts`.
- The column indicating which user created a record should be called `created_user`.
- Similarly, the column indicating which user modified a record should be called `modified_user`.
- The above can be prefixed by an application or purpose to prevent ambiguity, i.e. `perfect_match_created_user`.
- Use `dim_<noun>s` and `fct_<nouns>s` for dimensions and facts respectively; i.e. `dim_contracts` or `fct_orders`.
- Dimensions use `bsns_key` as the primary key for an entity. `dim_key` is used for each _version_ of an entity.
- Facts use `<noun>_key` naming convention for the primary key of the fact.

## DRY:
- Don't repeat yourself.
- Don't repeat yourself ;)
- Whenever you find yourself writing the same code more than once, consider making that code a macro.
- If some model breaks a consistent pattern, document the exception in `properties.yml` and optionally via an in-line comment.

## Raw:
- Organize data lake models in a `sources_<source>.yml` file per source system.
- Rename source tables into entities in each YAML file. 
- Add a source 'freshness' block that defines how often each source should be loaded. Ensure that this check fails / warns if a data ingestion (i.e. Dataflow) pipeline has failed or hasn't run.

## Data lake: 
- Organize data lake models in a folder per sourcesystem.
- Use the following filename format for staging models within each folder: `stg_<source>__[entity]s`. Make the entity plural!
- Use a macro to generate the data lake layer. Currently, we use `generic.datalake_append_records` for the generic case.
- If a data lake table does not follow the standard, document it separately and clearly explain why this decision was made.
- We're currently considering making a model that's a short-hand for the latest version of the data lake. When this decision is finalized, the convention will be added here.
- Use an `incremental` materialization for the data lake models to ensure we build source history efficiently.
- Ensure we _always_ configure `full_refresh=false` so that we can never delete data lake tables by accident!

## Staging:
- Organize staging models in a folder per source system. 
- Use the following filename format for staging models within each folder: `stg_<source>__[entity]s`. Make the entity plural!
- Where possible, materialize staging models as views for optimization. Staging is simply a layer where we 'stage' all our changes, we shouldn't need to write this to disk.
- See also [dbt best practices](https://docs.getdbt.com/guides/best-practices/how-we-structure/2-staging).

## Data warehouse:
- Organize data warehouse models in folders per 'business case' or use-case.
- Use intermediate tables whenever logic becomes too complex for a single model, but each part is not a dimension or fact in itself. 

### Intermediate or helper models:
- Use intermediate models whenever a single model is too big to hold all the required logic.
- Intermediate models should be materialized as ephemeral unless performance dictates otherwise.
- Use the following naming convention for intermediate models: `int_[entity]s_[verbs]`. Don't be afraid to use slightly longer (4-5 words) filenames here!
- See also [dbt best practices](https://docs.getdbt.com/guides/best-practices/how-we-structure/3-intermediate).
