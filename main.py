import pandas as pd
from sqlalchemy import create_engine
import matplotlib.pyplot as plt
from datetime import datetime


Database_URL = "postgresql+psycopg2://kelhuh:root@localhost:5432/postgres"

engine = create_engine(Database_URL, echo=False)

df = pd.read_sql("select sale_date, sum(quantity), sum(total_amount), count(*) from sales group by sale_date", engine)

df['sale_date'] = pd.to_datetime(df['sale_date'])
df = df.set_index('sale_date')

daily_sales = df.resample('D').sum()

print(daily_sales)


print("\n")
print("2 тапсырма")
print("\n")


df1 = pd.read_sql("select sale_date, sum(total_amount) as total_amount from sales group by sale_date", engine)

df1['sale_date'] = pd.to_datetime(df1['sale_date'])

df1.set_index('sale_date')

df1['all_total'] = df1["total_amount"].cumsum()

print(df1['all_total'])

print("\n")
print("3 тапсырма ")
print("\n")

df2 = pd.read_sql("select sale_date, sum(total_amount) as total_amount from sales group by sale_date", engine)

df2['sale_date'] = pd.to_datetime(df2['sale_date'])

df2.set_index('sale_date')

df2['7days'] = df2['total_amount'].rolling(7).mean()

print(df2['7days'])

# matplot
print("\n")
print("5 Бөлім")
print("\n")


query = """
    SELECT 
        sale_date,
        SUM(total_amount) as daily_revenue
    FROM sales 
    GROUP BY sale_date 
    ORDER BY sale_date
"""

df = pd.read_sql(query, engine)
df['sale_date'] = pd.to_datetime(df['sale_date'])
df = df.set_index('sale_date')

df['rolling_7'] = df['daily_revenue'].rolling(window=7).mean()
df['cumulative_revenue'] = df['daily_revenue'].cumsum()


plt.figure(figsize=(14, 10))


plt.subplot(2, 1, 1) 


plt.bar(df.index, df['daily_revenue'], alpha=0.6, label='Күнделікті түсім', color='skyblue')


plt.plot(df.index, df['rolling_7'], color='red', linewidth=2.5, 
         label='7 күндік тренд (скользящее среднее)')

plt.title('Күнделікті түсім және 7 күндік тренд', fontsize=16, fontweight='bold')
plt.xlabel('Күні', fontsize=12)
plt.ylabel('Түсім (теңге)', fontsize=12)
plt.legend()
plt.grid(True, alpha=0.3)


plt.subplot(2, 1, 2)  

plt.plot(df.index, df['cumulative_revenue'], color='green', linewidth=2.5, 
         label='Жинақталған түсім')

plt.fill_between(df.index, df['cumulative_revenue'], color='green', alpha=0.3)

plt.title('Барлық уақыттағы жинақталған түсім', fontsize=16, fontweight='bold')
plt.xlabel('Күні', fontsize=12)
plt.ylabel('Жалпы түсім (теңге)', fontsize=12)
plt.legend()
plt.grid(True, alpha=0.3)

plt.tight_layout()

plt.suptitle(f'Дүкен Analytics Dashboard\n{datetime.now().strftime("%Y-%m-%d")}', 
             fontsize=18, fontweight='bold', y=1.02)

plt.savefig('dashboard.png', dpi=300, bbox_inches='tight')