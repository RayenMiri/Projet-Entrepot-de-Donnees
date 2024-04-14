import pandas as pd
#test test master
# Charger les données à partir d'un fichier Excel dans le même répertoire que le script
df = pd.read_excel('Movies.xlsx')

# Étapes de nettoyage des données

# 1. Supprimer les lignes avec des valeurs manquantes
df_cleaned = df.dropna()

# 2. Convertir 'Release Date' en datetime et gérer les dates incorrectes
df_cleaned['Release Date'] = pd.to_datetime(df_cleaned['Release Date'], errors='coerce')

# 3. Convertir les objets datetime en objets date
df_cleaned['Release Date'] = df_cleaned['Release Date'].dt.date

# 4. Normaliser les noms de colonnes en minuscules et remplacer les espaces par des tirets du bas
df_cleaned.columns = [col.lower().replace(' ', '_') for col in df_cleaned.columns]

# 5. Supprimer les lignes avec des chiffres de ventes négatifs ou irréalistes
sales_columns = ['domestic_sales_(in_$)', 'international_sales_(in_$)', 'world_sales_(in_$)']
for col in sales_columns:
    df_cleaned[col] = pd.to_numeric(df_cleaned[col], errors='coerce')  # Convertir en numérique, convertir les non-numériques en NaN
    df_cleaned = df_cleaned[df_cleaned[col] >= 0]

# 6. Convertir 'Movie Runtime' en une valeur numérique (en supposant qu'il est en minutes)
# Enregistrer les données nettoyées dans un nouveau fichier Excel dans le même répertoire
df_cleaned.to_excel('cleaned_movies_data.xlsx', index=False)

print("Le nettoyage des données est terminé. Les données nettoyées ont été enregistrées dans 'cleaned_movies_data.xlsx'.")