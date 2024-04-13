import pandas as pd

# Load the data from an Excel file in the same directory as the script
df = pd.read_excel('Books.xlsx')  # or 'latin1', 'iso-8859-1', 'cp1252' as needed

# Data cleaning steps

# 1. Remove rows with missing values in essential columns
essential_columns = ['Book Name', 'Author', 'Book_average_rating', 'genre', 'gross sales', 'publisher revenue', 'units sold']
df_cleaned = df.dropna(subset=essential_columns).copy()  # Use .copy() to avoid SettingWithCopyWarning

# 2. Clean the 'Publishing Year' column
# Convert 'Publishing Year' to integers, handle incorrect values
df_cleaned.loc[:, 'Publishing Year'] = pd.to_numeric(df_cleaned['Publishing Year'], errors='coerce')
df_cleaned = df_cleaned[df_cleaned['Publishing Year'] > 0]

# 3. Normalize column names to lowercase and replace spaces with underscores
df_cleaned.columns = [col.lower().replace(' ', '_') for col in df_cleaned.columns]

# 4. Handle  issues in the 'Book Name' column
pattern = r'[^\w\s:]'

df_cleaned = df_cleaned[~df_cleaned['book_name'].astype(str).str.contains(pattern, na=False)]
# 5. Convert numeric columns to appropriate data types
numeric_columns = ['author_rating', 'book_average_rating', 'book_ratings_count', 'gross_sales', 'publisher_revenue', 'sale_price', 'sales_rank', 'units_sold']
for col in numeric_columns:
    df_cleaned.loc[:, col] = pd.to_numeric(df_cleaned[col], errors='coerce')

# 6. Remove rows with negative or unrealistic sales figures
sales_columns = ['gross_sales', 'publisher_revenue', 'sale_price']
for col in sales_columns:
    df_cleaned = df_cleaned[df_cleaned[col] >= 0]

# Save the cleaned data to a new Excel file in the same directory
df_cleaned.to_excel('cleaned_books_data.xlsx', index=False)

print("Data cleaning is complete. The cleaned data has been saved to 'cleaned_books_data.xlsx'.")