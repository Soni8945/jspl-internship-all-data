class ListNode:
    def __init__(self , val=0 , next =None):
        self.val = val
        self.next = next
        
def build_linked_list(numbers):
    head = ListNode()
    current = head
    for i in numbers:
        current.next = ListNode(i)
        current = current.next
    return head.next

def print_linked_list(node):
    while node:
        print(node.val, end=" -> " if node.next else "\n")
        node = node.next

# def addtwonumber(l1,l2):
#     dummy_head = ListNode()
#     current = dummy_head
#     carry = 0

#     while l1 or l2 or carry:
#         if l1:
#             val1 = l1.val
#         else: 0
#         if l2:
#             val2 = l2.val
#         else:
#             0
        
#         total = val1+val2+carry

#         carry = total//10
#         new_node = ListNode(total%10)
#         current.next = new_node

#         current = current.next
#         if l1:
#             l1 = l1.next
#         if l2:
#             l2 = l2.next
    
#     return dummy_head.next

def addTwoNumbers(l1, l2):
    dummy_head = ListNode()
    current = dummy_head
    carry = 0

    while l1 or l2 or carry:
        val1 = l1.val if l1 else 0
        val2 = l2.val if l2 else 0
        total = val1 + val2 + carry

        carry = total // 10
        current.next = ListNode(total % 10)
        current = current.next

        if l1: l1 = l1.next
        if l2: l2 = l2.next

    return dummy_head.next

l1 = build_linked_list([1,2,3])
l2 = build_linked_list([1,2,9])
result = addTwoNumbers(l1,l2)
print_linked_list(l1)
print_linked_list(l2)
print_linked_list(result)  