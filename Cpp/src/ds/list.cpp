//linklist.cpp：链表方法的实现。

#include "list.h"
using namespace std;

//构造函数
LinkList::LinkList()
{
    head = NULL;
    length = 0;
}

//析构函数
LinkList::~LinkList()
{
    Node *temp;
    for(int i=0;i<length;i++)
    {
        temp=head;
        head=head->next;
        delete temp;
    }
}

//得到链表长度
int LinkList::Length()
{
    return length;
}

//在链表头部插入结点
void LinkList::InsertHead(Info val)
{
    Insert(val,0);
}

//插入结点
void LinkList::Insert(Info val,int pos)
{
    if(pos<0)
    {
        cout<<"pos must be greater than zero"<<endl;
        return;
    }
    int index = 1;
    Node *temp = head;
    Node *node = new Node(val);
    if(pos == 0)
    {
        node->next = temp;
        head = node;
        length++;
        return;
    }
    while(temp!=NULL && index<pos)
    {
        temp=temp->next;
        index++;
    }
    if(temp == NULL)
    {
        cout<<"Insert failed"<<endl;
        return;
    }
    node->next = temp->next;
    temp->next = node;
    length++;
}

//删除结点
void LinkList::Remove(Info val)
{
    int pos = Find(val);
    if(pos == -1)
    {
        cout<<"Delete failed"<<endl;
        return;
    }
    if(pos == 1)
    {
        head = head->next;
        length--;
        return;
    }
    int index = 2;
    Node *temp = head;
    while(index < pos)
        temp = temp->next;
    temp->next = temp->next->next;
    length--;
}

//查找结点位置
int LinkList::Find(Info val)
{
    Node *temp = head;
    int index = 1;
    while(temp!=NULL)
    {
        if(temp->val.name == val.name && temp->val.id == val.id)
            return index;
        temp = temp->next;
        index ++;
    }
    return -1; //不存在返回-1
}

//链表反序
void LinkList::Reverse()
{
    if(head==NULL)
        return;
    Node *curNode=head,*nextNode=head->next,*temp;
    while(nextNode!=NULL)
    {
        temp=nextNode->next;
        nextNode->next=curNode;
        curNode=nextNode;
        nextNode=temp;
    }
    head->next=NULL;
    head=curNode;
}

//打印链表
void LinkList::Print()
{
    if(head == NULL)
    {
        cout<<"LinkList is empty"<<endl;
        return;
    }
    Node *temp = head;
    while(temp!=NULL)
    {
        cout<<temp->val.name<<","<<temp->val.id<<endl;
        temp=temp->next;
    }
    cout<<endl;
}

