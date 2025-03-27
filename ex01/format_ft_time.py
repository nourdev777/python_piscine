# python_piscine/ex01/format_ft_time.py
import time
from datetime import datetime


# Получаем текущее время в секундах с эпохи Unix
seconds_since_epoch = time.time()

# Форматируем строку с секундами
seconds_str = f"Seconds since January 1, 1970: {seconds_since_epoch:,} or {seconds_since_epoch:.2e} in scientific notation"

# Получаем текущую дату и форматируем её
current_date = datetime.fromtimestamp(seconds_since_epoch).strftime("%b %d %Y")

# Выводим результат
print(seconds_str)
print(current_date)
