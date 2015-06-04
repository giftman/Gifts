import urllib.request
url = "http://xueqiu.com/cubes/rebalancing/history.json?cube_symbol=ZH010389&count=20&page=1"
headers = {
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:35.0) Gecko/20100101 Firefox/35.0',
           'cookie':'s=iadtmc95.1pg2m9i; xq_a_token=524c078138a2ef9ad2b351fb2cd61e68bffc033c; xq_r_token=aa5bbf5c67d5227ca31f03a48879ef3ff2150924; __utma=1.1838413040.1433158589.1433158589.1433158589.1; __utmb=1.6.10.1433158589; __utmc=1; __utmz=1.1433158589.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); __utmt=1; Hm_lvt_1db88642e346389874251b5a1eded6e3=1433158590; Hm_lpvt_1db88642e346389874251b5a1eded6e3=1433158767; xq_token_expire=Fri%20Jun%2026%202015%2019%3A36%3A37%20GMT%2B0800%20(CST); xq_is_login=1; bid=eb8a43ed3501b1ad4c797224513a468a_iadtmjn7'
           }
req = urllib.request.Request(url,headers= headers)
html = urllib.request.urlopen(req).read().decode('utf-8')
print(html)
