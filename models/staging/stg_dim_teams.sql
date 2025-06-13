{{
  config(
    materialized = 'view',
    unique_key='sk_team'
    )
}}

WITH

SOURCE AS (
  SELECT
      {{ 
        generate_surrogate_key([
          'team_id',
        ])
      }} AS sk_team
    , CAST(team_id AS STRING) AS team_id
    , CAST(venue_id AS INT) AS venue_id
    , CAST(team_name AS STRING) AS team_name
    , CAST(team_founded AS INT) AS team_founded
    , CAST(is_national AS BOOLEAN) AS is_national
    , CAST(team_logo AS STRING) AS team_logo_url
  FROM {{ source('raw', 'teams') }} AS DIM_COUNTRIES
)

SELECT * FROM SOURCE