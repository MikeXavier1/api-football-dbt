{{
  config(
    materialized = 'table',
    unique_key='sk_team'
    )
}}


SELECT
  DIM_TEAMS.sk_team
  , DIM_TEAMS.team_id
  , DIM_TEAMS.venue_id
  , DIM_TEAMS.team_name
  , DIM_TEAMS.team_founded
  , DIM_TEAMS.is_national
  , DIM_TEAMS.team_logo_url
FROM {{ ref('stg_dim_teams') }} AS DIM_TEAMS
