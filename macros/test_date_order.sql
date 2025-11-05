{%test date_order(model, date_start_column, date_end_column)%}
    SELECT *
    FROM {{model}}
    WHERE {{date_start_column}} > {{date_end_column}}
{%endtest%}