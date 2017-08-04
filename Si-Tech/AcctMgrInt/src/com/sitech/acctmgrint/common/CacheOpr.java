package com.sitech.acctmgrint.common;

import java.util.List;

import com.sitech.acctmgrint.common.utils.CacheUtils;
import com.sitech.acctmgrint.common.utils.JedisUtils;

public class CacheOpr {
	private CacheUtils utils;
	public CacheOpr(){
	}
	
	public CacheOpr(CacheUtils utils){
		this.utils = utils;
	}
	
	public void setValueToCache(String key, Object value){
		utils.set(key, value);
	}
	
	public <T> T getCachedValue(String key, Class<T> clazz){
		return utils.get(key, clazz);
	}
	
	public void deleteCachedValue(String key){
		utils.remove(key);
	}
	
	public void setCacheUtils(CacheUtils utils) {
		this.utils = utils;
	}

	public boolean exists(String key){
        return utils.exists(key);
    }

    public List<String> getDetail(String key){
        return utils.getDetail(key);
    }

	public void setCacheUtils(String tools){
        if(tools.equals("jedis")){
            this.setCacheUtils(new JedisUtils());
        }
    }
}
