import pandas as pd
from sqlalchemy import create_engine

df = pd.read_csv('D:\\Data_set\\Data_Set_4\\Data\\movies.csv')

engine = create_engine(
    "mysql+pymysql://root:Vivek%40123@localhost:3306/movies_data")

df.to_sql(
    name='movies_data',
    con=engine,
    if_exists='replace', 
    index=False
)

print("Data inserted successfully!")