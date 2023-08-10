# node structure
class Node:
  def __init__(self, data):
    self.data = data
    self.next = None

#class Linked List
class LinkedList:
  def __init__(self):
    self.head = None

  #Add new element at the end of the list
  def push_back(self, newElement):
    
    newNode = Node(newElement)
    if(self.head == None):
      self.head = newNode
      return

    if(self.head.data > newElement):
        newNode.next = self.head
        self.head = newNode
        return

    else:
      temp = self.head
      insertMedium = False
      while(temp.next != None):
        if(newElement > temp.data and newElement < temp.next.data):
            insertMedium = True
            break
        temp = temp.next
      
      if(insertMedium):
        newNode.next = temp.next
        temp.next = newNode
      else:
         temp.next = newNode 

  def PrintList(self):
    temp = self.head
    if(temp != None):
      print("The list contains:", end=" ")
      while (temp != None):
        print(temp.data, end=" ")
        temp = temp.next
      print()
    else:
      print("The list is empty.")

  def pop_front(self):
    
    if(self.head != None):
      temp = self.head
      data = temp.data
      self.head = self.head.next
      temp = None 
  
    return data

# test the code                 
MyList = LinkedList()

#Add four elements in the list.
MyList.push_back(100)
MyList.push_back(99)
MyList.push_back(10)
MyList.push_back(30)
MyList.push_back(40)
MyList.PrintList()


print(MyList.pop_front())
MyList.PrintList()