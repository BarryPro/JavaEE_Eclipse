/**
 *
 */
package com.sitech.acctmgr.inter.query;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * 区县接口类
 *
 * @author wangyla
 */
public interface IDistrictRegion {

    /**
	 * @param inParam
	 *            .GROUP_ID： 组织机构代码<br/>
	 * @paramType
	 * @return <br/>
	 *         DIS_LIST 区县代码列表<br/>
	 *         GROUP_ID 区县代码<br/>
	 *         GROUP_NAME 区县名称<br/>
	 *         REGION_NAME 归属地市名称<br/>
	 *         REGION_CODE 归属地市行政代码<br/>
	 */
    OutDTO query(InDTO inParam);
    
    /**
	 * 名称：批量查询获取地市
	 * 
	 * @param
	 * @param
	 * 
	 * @return
	 * 
	 * @throws Exception
	 */
    OutDTO getRegionList(InDTO inParam);
    
    /**
	 * 名称：批量查询获取区县
	 * 
	 * @param
	 * @param
	 * 
	 * @return
	 * 
	 * @throws Exception
	 */
    OutDTO getDistrictList(InDTO inParam);

	/**
	 * 名称：查询区县下的所有营业厅
	 * 
	 * @param inParam
	 * @return
	 */
	OutDTO getGroupList(InDTO inParam);
}
