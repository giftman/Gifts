#coding  utf-8

class Node:
    def __init__(self,value):
        self._value = value
        self._children = []

    def __repr__(self):
        return 'Node({!r})'.format(self._value)

    def add_child(self,node):
        self._children.append(node)

    def __iter__(self):
        return iter(self._children)

    def depth_frist(self):
        yield self
        for c in self:
            yield from c.depth_frist()

if __name__ == '__main__':
    root = Node(0)
    child1 = Node(1)
    child2 = Node(2)
    child3 = Node(3)
    child4 = Node(4)
    child5 = Node(5)
    root.add_child(child1)
    root.add_child(child2)
    child1.add_child(child3)
    child1.add_child(child4)
    child2.add_child(child5)
    testt = root.depth_frist()
#yield from 内部调用了generator
#http://blog.csdn.net/gonux/article/details/42429751
    print(next(testt))
    print(next(testt))
    print(next(testt))
    print(next(testt))

