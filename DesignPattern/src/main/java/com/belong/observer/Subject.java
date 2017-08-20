package com.belong.observer;

import java.util.ArrayList;
import java.util.List;

/// ����������
/// </summary>
public abstract class Subject{
    private List<Observer> observers = new ArrayList<Observer>();

    /// <summary>
    /// ���ӹ۲���
    /// </summary>
    /// <param name="observer"></param>
    public void Attach(Observer observer)  {
        observers.add(observer);
    }

    /// <summary>
    /// �Ƴ��۲���
    /// </summary>
    /// <param name="observer"></param>
    public void Detach(Observer observer) {
        observers.remove(observer);
    }

    /// <summary>
    /// ��۲��ߣ��ǣ�����֪ͨ
    /// </summary>
    public void Notify()
    {
        for (Observer o : observers){
            o.Update();
        }
    }
}
