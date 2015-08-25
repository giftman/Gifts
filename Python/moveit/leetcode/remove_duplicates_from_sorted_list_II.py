class ListNode:
     def __init__(self, x):
         self.val = x
         self.next = None

class Solution:
    # @param {ListNode} head
    # @return {ListNode}
    def deleteDuplicates(self, head):
        # create dummy node
        dummy = ListNode(0)
        prev, current = dummy, head
        while current is not None:
            next = current.next
            # check if reaching end of list or current has unique value
            if (next is None) or (current.val != next.val):
                # attach current to prev and set prev to current
                prev.next = current
                prev = current
            else:
                # iterate through list till different value appears
                while (next is not None) and (next.val == current.val):
                    next = next.next
                    # attach next to prev, but keep prev untouched
                prev.next = next
        current = next
        return dummy.next
##  尼码  22行用的是while....
dummy = ListNode(1)
nextone = ListNode(2)
nextone2 = ListNode(3)
pre = dummy
#直接赋值变化的也会变化，类的变量则是多了一个
print(dummy.next)
pre.next = nextone
print(dummy.next.val)
print(nextone.val)
nextone = nextone2
print(dummy.next.val)
print(nextone.val)

