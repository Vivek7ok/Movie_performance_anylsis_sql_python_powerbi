import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

# ----------------------------------
# Load Dataset
# ----------------------------------
df = pd.read_csv(
    r'd:\Data_set\4_movies_metadata_analysis\Data\Movie Data.csv'
)

# ----------------------------------
# Create Budget Categories
# ----------------------------------
df['Budget_category'] = df['budget'].apply(
    lambda x: 'Zero' if x == 0
    else ('Low' if x < 10000000
    else ('Medium' if x < 50000000
    else ('High' if x < 100000000
    else 'Very High')))
)

# ----------------------------------
# Create Runtime Categories
# ----------------------------------
df['Runtime_category'] = df['runtime'].apply(
    lambda x: 'Short' if x < 90
    else ('Medium' if x < 120
    else ('Long' if x < 150
    else 'Very Long'))
)

# ----------------------------------
# Create Revenue Categories
# ----------------------------------
df['Revenue_category'] = df['revenue'].apply(
    lambda x: 'Zero' if x == 0
    else ('Low' if x < 10000000
    else ('Medium' if x < 50000000
    else ('High' if x < 100000000
    else 'Very High')))
)

# ----------------------------------
# Basic Analysis
# ----------------------------------
print("\nTop 5 Genres")
print(df['genres'].value_counts().head(5))

print("\nTop 5 Production Companies")
print(df['production_companies'].value_counts().head(5))

# ==================================
# 1. Budget Category vs Revenue Category
# ==================================
plt.figure(figsize=(10, 6))

sns.countplot(
    data=df,
    x='Budget_category',
    hue='Revenue_category',
    palette='viridis'
)

plt.title('Revenue Distribution Across Budget Categories',
          fontsize=14,
          fontweight='bold')

plt.xlabel('Budget Category')
plt.ylabel('Number of Movies')

plt.grid(axis='y', linestyle='--', alpha=0.5)

plt.tight_layout()
plt.show()

# ==================================
# 2. Average Revenue by Runtime Category
# ==================================
plt.figure(figsize=(10, 6))

sns.barplot(
    data=df,
    x='Runtime_category',
    y='revenue',
    errorbar=None,
    palette='magma'
)

plt.title('Average Revenue by Runtime Category',
          fontsize=14,
          fontweight='bold')

plt.xlabel('Runtime Category')
plt.ylabel('Average Revenue')

plt.grid(axis='y', linestyle='--', alpha=0.5)

plt.tight_layout()
plt.show()

# ==================================
# 3. Runtime vs Revenue
# ==================================
plt.figure(figsize=(10, 6))

sns.scatterplot(
    data=df,
    x='runtime',
    y='revenue',
    hue='Budget_category',
    palette='Set2',
    alpha=0.7
)

plt.title('Runtime vs Revenue',
          fontsize=14,
          fontweight='bold')

plt.xlabel('Runtime (Minutes)')
plt.ylabel('Revenue')

plt.grid(True, linestyle='--', alpha=0.4)

plt.tight_layout()
plt.show()

# ==================================
# 4. Revenue Distribution by Budget Category
# ==================================
plt.figure(figsize=(10, 6))

sns.boxplot(
    data=df,
    x='Budget_category',
    y='revenue',
    palette='coolwarm'
)

plt.title('Revenue Distribution by Budget Category',
          fontsize=14,
          fontweight='bold')

plt.xlabel('Budget Category')
plt.ylabel('Revenue')

plt.tight_layout()
plt.show()

# ==================================
# 5. Revenue Distribution by Runtime Category
# ==================================
plt.figure(figsize=(10, 6))

sns.boxplot(
    data=df,
    x='Runtime_category',
    y='revenue',
    palette='Set3'
)

plt.title('Revenue Distribution by Runtime Category',
          fontsize=14,
          fontweight='bold')

plt.xlabel('Runtime Category')
plt.ylabel('Revenue')

plt.tight_layout()
plt.show()