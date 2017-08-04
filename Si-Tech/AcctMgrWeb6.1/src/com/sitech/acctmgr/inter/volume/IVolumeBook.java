package com.sitech.acctmgr.inter.volume;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
/**
 * 
 * @author liangrui
 * 
 * 流量(帐本)查询接口 query
 * 流量充入接口 pay
 * 流量冲正接口 rollback
 * 流量预占接口 preholding
 * 流量预占扣减接口 preholdingDeduct
 * 流量预占释放接口 preholdingRelease
 * 流量扣减接口 deduct
 * 流量转移接口 transfer
 * 流量延期请求接口 delay
 * 流量共享请求接口 share
 * 共享关系创建 shareCreate
 * 共享关系变更 shareChange
 * 流量自定义提醒接口
 * 群组成员同步
 * 流量溯源
 * 流量转换
 *
 */
public interface IVolumeBook {

	/**
	 * 流量充入 <br>
	 * 业务类型为 01 <br>
	 * com.sitech.acctmgr.inter.volume.IVolumeBook.pay
	 * @param inDTO
	 * @return
	 */
	OutDTO pay(InDTO inDTO);
	/**
	 * 流量冲正 <br>
	 * 业务类型 ff <br>
	 * com.sitech.acctmgr.inter.volume.IVolumeBook.rollback()
	 * @return
	 */
	OutDTO rollback(InDTO inDTO);
	
	/**
	 * 流量扣减 <br>
	 * 业务类型 02 <br>
	 * com.sitech.acctmgr.inter.volume.IVolumeBook.deduct
	 * @param inDTO
	 * @return
	 */
	OutDTO deduct(InDTO inDTO);
	
	/**
	 * 流量预占 <br>
	 * 业务类型 20 <br>
	 * com.sitech.acctmgr.inter.volume.IVolumeBook.preholding
	 * @param inDTO
	 * @return
	 */
	OutDTO preholding(InDTO inDTO);
	/**
	 * 流量预占扣减 <br>
	 * 业务类型 21 <br>
	 * com.sitech.acctmgr.inter.volume.IVolumeBook.preholdingDeduct
	 * @param inDTO
	 * @return
	 */
	OutDTO preholdingDeduct(InDTO inDTO);
	
	/**
	 * 流量预占释放 <br>
	 * 业务类型 22 <br>
	 * com.sitech.acctmgr.inter.volume.IVolumeBook.preholdingReleas
	 * @param inDTO
	 * @return
	 */
	OutDTO preholdingRelease(InDTO inDTO);
	
	/**
	 * 流量转移 <br>
	 * 业务类型 10 <br>
	 * com.sitech.acctmgr.inter.volume.IVolumeBook.transfer
	 * @param inDTO
	 * @return
	 */
	OutDTO transfer(InDTO inDTO);
	/**
	 * 流量共享 创建<br>
	 * @param inDTO
	 * @return
	 */
	OutDTO shareCreate(InDTO inDTO);
	
	/**
	 * 流量共享 变更<br>
	 * @param inDTO
	 * @return
	 */
	OutDTO shareChange(InDTO inDTO);
	
	/**
	 * 流量延期 <br>
	 * 业务类型 31
	 * @param inDTO
	 * @return
	 */
	OutDTO delay(InDTO inDTO);
	
	/**
	 * 流量查询 <br>
	 * 业务类型 40
	 * @param inDTO
	 * @return
	 */
	OutDTO query(InDTO inDTO);

	/**
	 * 流量收支查询 <br>
	 * 业务类型 42
	 * @param inDTO
	 * @return
     */
	OutDTO inAndOutQuery(InDTO inDTO);
}
