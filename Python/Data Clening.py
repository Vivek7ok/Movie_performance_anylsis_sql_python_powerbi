import pandas as pd
import numpy as np

# Load the dataset
df = pd.read_csv(r"d:\Data_set\4_movies_metadata_analysis\Data\movies.csv")

# Display initial information about the dataset
print(df.head(10))
print(df.info())
print(df.isnull().sum())
print(df.describe())
print(df['index'].count())

# Handle missing values
df['genres'] = df['genres'].fillna('Missing')

df['homepage'] = df['homepage'].fillna('Missing')

df['keywords'] = df['keywords'].fillna('Missing')

df['overview'] = df['overview'].fillna('Missing')

df['director'] = df['director'].fillna('Missing')

df['cast'] = df['cast'].fillna('Missing')

df['runtime'] = df['runtime'].fillna(df['runtime'].mean()).round().astype(int)

df['release_date'] = pd.to_datetime(df['release_date'],errors="coerce").ffill()

df['tagline'] = df['tagline'].fillna('Missing')

print(pd.unique(df['production_companies']))

# Save the cleaned dataset to a new CSV file
print(df.head(10))
print(df.info())
print(df.isnull().sum())
print(df.describe())
print(df['index'].count())

# Save the cleaned dataset to a new CSV file
df.to_csv(r"d:\Data_set\4_movies_metadata_analysis\Data\Movie Data.csv", index=False)




