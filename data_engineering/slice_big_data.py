import pandas as pd

# 1. Указываем путь к огромному файлу
big_file_path = '2019-Oct.csv' 

# 2. Читаем первые 500 000 строк
print("Читаем данные...")
df_chunk = pd.read_csv(big_file_path, nrows=500000)

# 3. Оставляем только успешные покупки
df_purchases = df_chunk[df_chunk['event_type'] == 'purchase'].copy()

# 4. Сохраняем чистый, легкий файл для нашей базы данных
output_file = 'ecom_purchases_clean.csv'
df_purchases.to_csv(output_file, index=False)

print(f"Готово! Создан легкий файл '{output_file}'.")
print(f"В нем {len(df_purchases)} строк успешных покупок. Идеально для SQL!")
