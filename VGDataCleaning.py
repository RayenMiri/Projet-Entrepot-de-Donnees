import pandas as pd

# Make sure you have these packages installed:
# pip install pandas openpyxl

# Load the data from an Excel file in the same directory as the script
df = pd.read_excel('Movies.xlsx')

# Data cleaning steps

# 1. Remove rows with missing values
df_cleaned = df.dropna()

# 2. Convert years to integers and handle incorrect or outlier values
# Assuming all years should be after 1980 and before the current year
current_year = pd.Timestamp.now().year
df_cleaned['Year'] = pd.to_numeric(df_cleaned['Year'], errors='coerce')  # Convert to numeric, coerce non-numeric to NaN
df_cleaned = df_cleaned[df_cleaned['Year'].between(1980, current_year)]

# 3. Normalize column names to lowercase
df_cleaned.columns = [col.lower() for col in df_cleaned.columns]

# 4. Remove rows with negative or unrealistic sales figures
columns_sales = ['na_sales', 'eu_sales', 'jp_sales', 'other_sales', 'global_sales']
for col in columns_sales:
    df_cleaned = df_cleaned[df_cleaned[col] >= 0]

# Save the cleaned data to a new Excel file in the same directory
df_cleaned.to_excel('cleaned_data.xlsx', index=False)

print("Data cleaning is complete. The cleaned data has been saved to 'cleaned_data.xlsx'.")