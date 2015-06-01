#coding  utf-8
#enumerate 增加数数序列 要算数要想起它

#parse string
from itertools import islice
ips = '74.125.237.60|64.233.188.154|64.233.188.136|64.233.188.86|64.233.188.82|64.233.188.197|64.233.188.139|74.125.237.33|64.233.188.115|74.125.237.59|64.233.188.199|64.233.188.191|74.125.237.0|74.125.237.57|64.233.188.194|64.233.188.198|74.125.237.30|64.233.188.145|64.233.188.112|64.233.188.138|64.233.188.102|74.125.237.10|64.233.188.196|74.125.237.8|64.233.188.118|64.233.188.90|74.125.237.9|64.233.188.155|74.125.237.42|64.233.188.152|74.125.237.46|74.125.237.25|74.125.237.12|74.125.237.14|64.233.188.132|74.125.237.31|74.125.237.63|64.233.188.98|74.125.237.39|74.125.237.11|64.233.188.95|64.233.188.103|64.233.188.133|64.233.188.87|64.233.188.164|74.125.237.44|74.125.237.5|64.233.188.122|74.125.237.28|74.125.237.58|74.125.237.61|64.233.188.97|64.233.188.189|74.125.237.7|64.233.188.143|64.233.188.96|64.233.188.193|74.125.237.32|64.233.188.147|64.233.188.137|64.233.188.117|64.233.188.201|64.233.188.113|64.233.188.176|64.233.188.141|64.233.188.85|74.125.237.35|74.125.237.38|64.233.188.190|74.125.237.26|74.125.237.15|64.233.188.104|74.125.237.2|64.233.188.124|64.233.188.81|64.233.188.156|64.233.188.84|64.233.188.93|64.233.188.157|64.233.188.99|64.233.188.91|64.233.188.167|64.233.188.100|64.233.188.83|64.233.188.101|64.233.188.195|74.125.237.37|74.125.237.45|74.125.237.1|74.125.237.40|74.125.237.3|173.194.200.156|173.194.201.99|173.194.200.166|173.194.200.117|173.194.201.124|173.194.200.191|173.194.200.101|173.194.201.122|173.194.201.143|173.194.200.145|173.194.201.105|173.194.201.133|173.194.201.94|173.194.201.142|173.194.200.100|173.194.200.123|173.194.200.165|173.194.200.133|173.194.200.167|173.194.201.106|173.194.200.114|173.194.200.139|173.194.200.193|173.194.201.117|173.194.201.141|173.194.200.146|173.194.201.120|173.194.200.152|173.194.200.149|173.194.200.118|64.233.162.86|173.194.201.101|173.194.200.196|173.194.200.105|173.194.201.132|173.194.201.96|173.194.201.139|173.194.201.113|64.233.162.81|64.233.188.106|173.194.200.148|173.194.200.154|173.194.200.106|173.194.201.123|173.194.200.144|173.194.200.113|173.194.200.104|173.194.200.136|173.194.200.132|173.194.201.102|173.194.200.164|173.194.201.138|173.194.200.143|173.194.200.124|173.194.200.138|64.233.188.146|64.233.162.83|173.194.201.118|173.194.200.147|173.194.200.102|173.194.200.112|173.194.201.116|173.194.201.95|173.194.201.136|173.194.201.137|173.194.200.90|173.194.201.100|64.233.162.87|64.233.162.85|64.233.162.84|173.194.201.90|64.233.162.82|173.194.200.17|64.233.188.123|173.194.201.149|173.194.201.87|173.194.200.82|173.194.201.19|173.194.201.156|173.194.200.94|173.194.201.193|173.194.200.93|173.194.218.83|173.194.201.189|173.194.200.19|173.194.200.96|173.194.200.198|173.194.201.152|173.194.201.93|173.194.201.165|173.194.200.115|173.194.201.17|173.194.201.83|173.194.201.114|173.194.201.164|173.194.200.199|173.194.201.31|173.194.201.81|173.194.201.84|173.194.200.86|173.194.200.85|173.194.201.82|173.194.201.148|173.194.200.83|173.194.201.115|173.194.201.201|173.194.218.95|173.194.218.115|173.194.201.85|64.233.188.148|173.194.218.157|173.194.218.86|74.125.237.6|173.194.218.17|173.194.218.152|173.194.218.147|173.194.218.176|173.194.218.149|173.194.218.82|173.194.218.194|173.194.218.155|173.194.218.81|173.194.218.133|173.194.218.193|173.194.218.146|173.194.218.123|173.194.218.91|173.194.218.156|173.194.218.190|173.194.218.31|173.194.218.165|173.194.218.117|173.194.201.98|173.194.200.122|173.194.200.137|173.194.201.97|173.194.201.112|173.194.200.103|173.194.200.141|173.194.200.116|173.194.200.157'
listip = ips.split('|')
for lineno,line in enumerate(islice(listip,None,100),1) :
    print(lineno,line)

#parse file
def parse_data(filename):
    with open(filename,'rt') as f:
        for lineno,line in enumerate(f,1):
            fields=line.split()
            try:
                #do your test or parse
            except ValueError as e:
                print('Line {}:Parse error:{}'.format(lineno,e))

#remember the situation like this
data = [(1,3),(3,4),(5,6),(7,8)]
form n,(x,y) in enumerate(data):
    ...



