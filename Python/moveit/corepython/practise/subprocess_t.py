#!/usr/bin/python
# -*- coding: utf-8 -*-
#!/usr/bin/python
# author: weisu.yxd@taobao.com
# subprocess  pip.stdin
#stdin stdout have PIPE will return an object,else None
# p= Popen(['python','test1.py'],stdin=PIPE,stdout=PIPE)
#p.write('test')
#p.communicate()[0] cause in&out is PIPE so only communicate can flush to stout
#如果是ls -al 这种命令，则直接运行完毕并关闭pip 已无法再操作in,out
#Both subprocess and os.popen* only allow input and output one time, and the output to be read only when the process terminates.
from subprocess import Popen, PIPE
import fcntl, os
import time
class Server(object):
  def __init__(self, args, server_env = None):
    if server_env:
      self.process = Popen(args, stdin=PIPE, stdout=PIPE, stderr=PIPE, env=server_env)
    else:
      self.process = Popen(args, stdin=PIPE, stdout=PIPE, stderr=PIPE)
    flags = fcntl.fcntl(self.process.stdout, fcntl.F_GETFL)
    fcntl.fcntl(self.process.stdout, fcntl.F_SETFL, flags | os.O_NONBLOCK)
  def send(self, data, tail = '\n'):
    self.process.stdin.write(data + tail)
    self.process.stdin.flush()
  def recv(self, t=.1, e=1, tr=5, stderr=0):
    time.sleep(t)
    if tr < 1:
        tr = 1
    x = time.time()+t
    r = ''
    pr = self.process.stdout
    if stderr:
      pr = self.process.stdout
    while time.time() < x or r:
        r = pr.read()
        if r is None:
            if e:
                raise Exception('error')
            else:
                break
        elif r:
            return r.rstrip()
        else:
            time.sleep(max((x-time.time())/tr, 0))
    return r.rstrip()
if __name__ == "__main__":
  ServerArgs = ['python', 'test1.py']
  server = Server(ServerArgs)
  test_data = '在云端', '云梯', '摩萨德', 'Alisa', 'iDB', '阿里大数据'
  for x in test_data:
    server.send(x)
    print x, server.recv()
