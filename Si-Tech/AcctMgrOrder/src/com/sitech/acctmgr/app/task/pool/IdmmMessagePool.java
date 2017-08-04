package com.sitech.acctmgr.app.task.pool;

import com.sitech.crmpd.idmm2.client.MessageContext;
import com.sitech.crmpd.idmm2.client.pool.PooledMessageContextFactory;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.pool2.KeyedObjectPool;
import org.apache.commons.pool2.impl.GenericKeyedObjectPool;
import org.apache.commons.pool2.impl.GenericKeyedObjectPoolConfig;

/**
 * Created by zhangjp on 2015/8/12.
 */
public class IdmmMessagePool {
    private static Log log = LogFactory.getLog(IdmmMessagePool.class);

    //创建CONFIG对象
    private static GenericKeyedObjectPoolConfig CONFIG = new GenericKeyedObjectPoolConfig();
    private static KeyedObjectPool<String, MessageContext> pool;
    private static int startNum;
    private static String addr;
    private static int processingTime;

    /**
     * spring初始化方法
     */
    public void init(){
        //设置连接池大小
        CONFIG.setMaxTotalPerKey(startNum);
        //设置连接池返回的连接都经过检测可用
        CONFIG.setTestOnBorrow(true);

        pool = new GenericKeyedObjectPool<String, MessageContext>(
                new PooledMessageContextFactory(addr, processingTime), CONFIG);
    }

    public int getStartNum() {
        return startNum;
    }

    public void setStartNum(int startNum) {
        IdmmMessagePool.startNum = startNum;
    }

    public KeyedObjectPool<String, MessageContext> getPool() {
        return pool;
    }

    public void setPool(KeyedObjectPool<String, MessageContext> pool) {
        IdmmMessagePool.pool = pool;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public void setProcessingTime(int processingTime) {
        this.processingTime = processingTime;
    }

    /**
     * 这个方法不要随便用，不能在程序运行中做
     * 先封闭起来吧
     * @return
     */
    private KeyedObjectPool<String, MessageContext> regainPool(){
        pool.close();
        pool = new GenericKeyedObjectPool<String, MessageContext>(
                new PooledMessageContextFactory(addr, processingTime), CONFIG);

        return pool;
    }
}
