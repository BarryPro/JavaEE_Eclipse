package com.sitech.acctmgrint.common.utils;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.sitech.acctmgrint.common.AcctMgrError;
import com.sitech.jcf.core.exception.BusiException;
import redis.clients.jedis.HostAndPort;
import redis.clients.jedis.JedisCluster;

import java.io.IOException;
import java.util.*;


public class JedisUtils extends CacheUtils {
	
	private static final JedisCluster cluster ;
	
	private static final GsonBuilder builder = new GsonBuilder();

    private static final Properties props = new Properties();

    private static int expire = 300;

	static{
		Set<HostAndPort> hosts = new HashSet<HostAndPort>();

        try {
            props.load(JedisUtils.class.getClassLoader().getResourceAsStream("config.properties"));
        } catch (IOException e) {
            e.printStackTrace();
            throw new BusiException(AcctMgrError.getErrorCode("0000", "00101"), "未找到config.properties配置文件");
        }

        String sHostNum = props.getProperty("redis.host.num");

        String sExpire = props.getProperty("redis.expire");

        if(null != sExpire){
            expire = Integer.parseInt(sExpire);
        }
        int hostNum = 8;

        if(null != sHostNum) {
            hostNum = Integer.parseInt(sHostNum);
        }

        for (int i = 1; i <= hostNum; i++) {
            String h = props.getProperty("redis.host" + i);
            String p = props.getProperty("redis.port" + i);

            String host = null;
            int port = 0;

            if(null != h && null != p) {
                host = h.trim();
                port = Integer.parseInt(p.trim());
                HostAndPort hp = new HostAndPort(host, port);
                hosts.add(hp);
            }
        }

        if (hosts.size() == 0){
            throw new BusiException(AcctMgrError.getErrorCode("0000", "00102"), "未找到缓存主机");
        }

		cluster = new JedisCluster(hosts);

	}
	
	public JedisUtils(){
		
	}
	
	public void set(String key, Object value){
		Gson gson = builder.create();
        String json = gson.toJson(value);
		cluster.set(key, json);

        cluster.expire(key, expire);
	}
	
	public <T> T get(String key, Class<T> clz){
		Gson gson = builder.create();
		String json = cluster.get(key);

		T obj = gson.fromJson(json, clz);
		return obj;
	}

    public boolean exists(String key){
        return cluster.exists(key);
    }

    public List<String> getDetail(String key){
        long start = System.currentTimeMillis();

        String json = cluster.get(key);

        Gson gson = builder.create();
        List<String> result = gson.fromJson(json, List.class);

        long fend = System.currentTimeMillis();
        System.out.println("duration : " + (fend - start) + "millis");

        return result ;
    }

	public void remove(String key){
		cluster.del(key);
	}
}
