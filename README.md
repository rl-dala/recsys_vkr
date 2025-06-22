# Применение машинного обучения в рекомендательных системах (Дипломная работа)
Представленные код включает алгоритмы машинного обучения и является частью Выпускной Квалификационной Работы за 2025 год бакалавра студента по направлению "Управление в технических системах" факультета Инженерная академия университета РУДН.

Изученные модели:
- User-k Nearest Neighbors
- Item-k Nearest Neighbors
- Singular Vector Decomposition
- Alternating Least Squares
- Term Frequency - Inverse Document Frequency
- Bidirectional Encoder Representations from Transformers
- Two-Tower Embedding

Модели обучены на базе данных [MovieLens10M](https://grouplens.org/datasets/movielens/10m/). 

Файл movies.dat был модифицирован с помощью TMDb API для обогащения датасета:

Датафрейм movies до:
| movieId | title | genres |
|:---:|:---:|:---:|
|1 | Toy Story (1995) | Adventure/Animation/Children/Comedy/Fantasy|

После:
|movieId|title|genres|year|clean_title|Overview|Actors|Director|Rated|PosterURL|TMDB_ID|Rated_code|
|---|---|---|---|---|---|---|---|---|---|---|---|
|1|Toy Story (1995)|['Adventure',...]|1995|Toy Story|Led by Woody...|Tom Hanks...|John Lasseter|G|https://image.tmdb.org/t/p/w500/uXDfjJbdP4ijW5hWSBrPrlKpxab.jpg|862|0|

"Rated code" обозначает на каком месте находится возрастной рейтинг фильма в списке в коде: 

["G", "PG", "PG-13", "R", "NC-17", "Unknown"]

Для пользователей, которые смотрели хоть раз NC-17 фильм могут быть показаны фильмы с G рейтингом, но для пользователей, которые смотрели **только** фильмы с G рейтингом фильмы с NC-17 рейтингом не долнжы в быть рекомендациях.
