import pandas as pd
pd.set_option('mode.chained_assignment', None)
pd.set_option('display.max_rows', 600)
pd.set_option('display.max_columns', 100)
pd.set_option('display.width', 1000)

# 데이터 적재
borrowed_book = pd.read_csv('./데이터_단행본대출.csv', encoding='cp949', low_memory=False)
lib_book = pd.read_csv('./데이터_단행본도서.csv', encoding='cp949', low_memory=False)

# 불필요한 테이블(열) 삭제
borrowed_book.drop(columns=['대출일시', '반납일시', '등록번호', '연대출권수'], inplace=True)
lib_book.drop(columns=['등록번호', '등록일자', '수서구분', 'BIBLIO_ID'], inplace=True)
renewed_book = borrowed_book[(borrowed_book['대출연장구분'] == '연장')].index
borrowed_book.drop(renewed_book, inplace=True)

# 단행본 대출 데이터 결측치 확인 및 제거
#print(borrowed_book.isnull().sum())
borrowed_book.dropna(subset=['ISBN'], inplace=True)
borrowed_book.dropna(subset=['상위소속'], inplace=True)

# 단행본 도서 데이터 결측치 확인 및 제거 => fillna()을 사용해 missing으로 채우기
lib_book.fillna('missing', inplace=True)
print(lib_book.isnull().sum())


borrowed_book['rating'] = 1

'''
단행본 대출 및 도서 모양 확인(EDA)
'''
#print(borrowed_book.head())
print(borrowed_book.info())
print(borrowed_book.describe())
#print(lib_book.head())
print(lib_book.info())
print(lib_book.describe())


college = input('단과대를 입력하세요 : ')
department = input('학과를 입력하세요 : ')
student_ID = int(input('입학년도를 입력하세요 : '))

#option1 = borrowed_book[(borrowed_book['상위소속']!=college&)  (borrowed_book['소속']!=department)].index
# option2 = borrowed_book[borrowed_book['소속']!=department].index
# option3 = borrowed_book[borrowed_book['입학년도']!=student_ID].index


#borrowed_book.drop(option1, inplace= True)
# borrowed_book.drop(option2, inplace= True)
# borrowed_book.drop(option3, inplace= True)

u_college = borrowed_book['상위소속'] == college
u_department = borrowed_book['소속'] == department
u_student_ID = borrowed_book['입학년도'] == student_ID
u_borrowed_book = borrowed_book[u_college & u_department & u_student_ID]



print(u_borrowed_book.info())

print(u_borrowed_book['서명'].value_counts())

from collections import Counter

# rating 값을 같은 이름을 가진 책의 갯수를 세어서 대치
for i in u_borrowed_book.index:
    tmp = Counter(u_borrowed_book['서명'])[u_borrowed_book.loc[i,'서명']]
    u_borrowed_book['rating'][i] = tmp

# ISBN으로 중복 데이터를 drop 시킬려 했으나
# 다른 책인데 동일 ISBN을 갖고 있는 데이터가 있어서
# 서명으로 중복 데이터를 제거함
u_borrowed_book.drop_duplicates(['서명'], keep='first', inplace = True)
print(u_borrowed_book.sort_values(by=['rating'], ascending=False).head())
print(u_borrowed_book.info())

# 레이팅을 0과 1사이의 스케일링 처리
# (원래값 - min값) / (max - min) 값
u_borrowed_book['rating'] = u_borrowed_book['rating'].astype('float')
print(u_borrowed_book.info())
'''
max = u_borrowed_book['rating'].max()
min = u_borrowed_book['rating'].min()
for i in u_borrowed_book.index:
    u_borrowed_book['rating'][i] = (u_borrowed_book['rating'][i] - min) / (max - min)

'''

u_borrowed_book= u_borrowed_book.sort_values('rating', ascending=False)
random_book = u_borrowed_book.iloc[:5]
random_book = random_book.sample(n=1)
book_user_rating = u_borrowed_book.pivot_table('rating', index = '입학년도', columns='서명')
print(book_user_rating.head())

book_user_rating_T = book_user_rating.transpose()


from sklearn.metrics.pairwise import cosine_similarity
from sklearn.metrics.pairwise import euclidean_distances
import seaborn as sns
import matplotlib.pyplot as plt

'''
similarity_rate = cosine_similarity(book_user_rating_T, book_user_rating_T)
print(similarity_rate)

similarity_rate_df = pd.DataFrame(data = similarity_rate, index = book_user_rating.columns, columns= book_user_rating.columns)
for n in range(len(similarity_rate_df)):
  similarity_rate_df.iloc[n][n] = 0
print(similarity_rate_df.head())
'''

euclidean_distances(book_user_rating_T, book_user_rating_T)
euclidean_similarty = 1 / (euclidean_distances(book_user_rating_T, book_user_rating_T) +1e-5)
print(euclidean_similarty)
similarity_rate_df = pd.DataFrame(euclidean_similarty, index = book_user_rating.columns, columns= book_user_rating.columns)
print(similarity_rate_df.head())
print(random_book.head())
print(similarity_rate_df[random_book['서명'].values[0]].sort_values(ascending=True)[:6])
'''
print(similarity_rate_df['파우스트'].sort_values(ascending=True)[:6])
print(similarity_rate_df['선형대수학의 이해와 응용'].sort_values(ascending=True)[:6])
print(similarity_rate_df['이산수학'].sort_values(ascending=True)[:6])
print(similarity_rate_df['자바로 배우는 핵심 자료구조와 알고리즘'].sort_values(ascending=True)[:6])
print(similarity_rate_df['잠 :베르나르 베르베르 장편소설'].sort_values(ascending=True)[:6])
'''