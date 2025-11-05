# Vue d'ensemble des marts

Ce projet dbt contient plusieurs tables de faits (marts) consolidant les données ODS pour faciliter l'analyse métier.

## Marts

### 1. Mart des avis clients (`fct_orders_reviews`)
- Contient les avis et évaluations laissés par les clients sur leurs commandes.
- Permet d'analyser :
  - la satisfaction client,
  - les tendances par produit et vendeur,
  - les proportions d'avis positifs et négatifs.
- Métriques clés : `avg_review_score`, `total_review`, `pct_positive_reviews`, `pct_negative_reviews`.

### 2. Mart des clients (`fct_customers`)
- Contient les données consolidées des clients.
- Permet d'analyser :
  - le nombre de commandes par client,
  - les montants dépensés et la valeur moyenne des commandes,
  - les comportements d'achat et taux d'annulation.
- Métriques clés : `total_orders`, `total_spent`, `avg_order_value`, `pct_canceled_orders`.

### 3. Mart des ventes (`fct_sales`)
- Contient les données de vente détaillées par produit, client et vendeur.
- Permet d'analyser :
  - le chiffre d'affaires total et par commande,
  - le fret, les annulations et les livraisons à temps,
  - les paiements associés aux commandes.
- Métriques clés : `total_orders`, `total_value`, `avg_order_value`, `pct_delivered_on_time`.

### 4. Mart des livraisons (`fct_delivery`)
- Contient les données consolidées sur les livraisons par vendeur et produit.
- Permet d'analyser :
  - les délais moyens de livraison,
  - le pourcentage de commandes livrées à temps,
  - le nombre de commandes annulées et livrées.
- Métriques clés : `avg_delai_livraison`, `pct_delivered_on_time`, `canceled_orders`, `delivered_orders`.

## Notes techniques
- Les données proviennent des tables ODS et des dimensions (`dim_customers`, `dim_products`, `dim_sellers`, `dim_date`).
- Les marts sont calculés en SQL et testés via dbt tests et dbt-expectations.
- Tous les marts sont documentés dans `schema.yml` avec tests de qualité des données.

