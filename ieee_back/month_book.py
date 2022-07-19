def month(y, m):
    import pandas as pd
    pd.set_option('mode.chained_assignment', None)
    
    # 데이터 적재
    borrowed_book = pd.read_csv('./데이터_단행본대출.csv', encoding='cp949', low_memory=False)
    lib_book = pd.read_csv('./데이터_단행본도서.csv', encoding='cp949', low_memory=False)
    
    # 불필요한 테이블(열) 삭제
    borrowed_book.drop(columns=['반납일시', '등록번호', '연대출권수'], inplace=True)
    lib_book.drop(columns=['등록번호', '등록일자', '수서구분', 'BIBLIO_ID'], inplace=True)
    renewed_book = borrowed_book[(borrowed_book['대출연장구분'] == '연장')].index
    borrowed_book.drop(renewed_book, inplace=True)
    
    
    # 단행본 대출 데이터 결측치 확인 및 제거
    print(borrowed_book.isnull().sum())
    borrowed_book.dropna(subset=['ISBN'], inplace=True)
    borrowed_book.dropna(subset=['상위소속'], inplace=True)
    print(borrowed_book.isnull().sum())
    
    
    # 단행본 도서 데이터 결측치 확인 및 제거 => fillna()을 사용해 missing으로 채우기
    print(lib_book.isnull().sum())
    lib_book.fillna('missing', inplace=True)
    print(lib_book.isnull().sum())
    
    # borrowed_book에 'rating' 열 추가 및 전부 1로 초기화
    # rating 수치는 대출수이며, 뒤에 유클리디언 유사도에서 사용함
    borrowed_book['rating'] = 1
    borrowed_book.drop(columns=['대출연장구분', '입학년도', '소속', '상위소속'], inplace=True)
    year = y
    month = m
    borrowed_book['대출일시'] = (borrowed_book.대출일시.str.split('/').str[0] == year) & (borrowed_book.대출일시.str.split('/').str[1] == month)
    print(borrowed_book.head())
    false_year = borrowed_book[(borrowed_book['대출일시'] == False)].index
    borrowed_book.drop(false_year, inplace=True)
    
    
    print(borrowed_book.head())
    print(borrowed_book.info())
    
    
    from collections import Counter
    
    # rating 값을 같은 이름을 가진 책의 갯수를 세어서 대치함
    for i in borrowed_book.index:
        tmp = Counter(borrowed_book['서명'])[borrowed_book.loc[i,'서명']]
        borrowed_book['rating'][i] = tmp
    
    print("===========================")
    print("===========================")
    # ISBN으로 중복 데이터를 drop 시킬려 했으나
    # 다른 책인데 동일 ISBN을 갖고 있는 데이터가 있어서
    # 서명으로 중복 데이터를 제거함
    borrowed_book.drop_duplicates(['서명'], keep='first', inplace = True)
    ranking_book = borrowed_book.sort_values(by=['rating'], ascending=False).head(10)
    print(borrowed_book.info())
    ranking_book.reset_index(inplace=True)
    ranking_book.drop(columns='index', inplace=True)
    print(ranking_book.head(10))
    info_book_df = pd.DataFrame()
    
    
    print("-----")
    #print(ranking_book.loc[[0],['ISBN']])
    for i in range(0,10):
        con = lib_book.ISBN == ranking_book.loc[i].ISBN
        info_book_df = pd.concat([info_book_df, lib_book[con].iloc[:1]])
    
    info_book_df.reset_index(inplace=True)
    info_book_df.drop(columns='index', inplace=True)
    print(info_book_df.head(10))
    
    info_book_dict = info_book_df.to_dict()
    print(info_book_dict)
    return info_book_dict
