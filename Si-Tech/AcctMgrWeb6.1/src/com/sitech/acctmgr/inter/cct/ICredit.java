package com.sitech.acctmgr.inter.cct;

import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

public interface ICredit {
	/**
	 * 用户信用度信息查询
	 * @param phone_no
	 * 	      id_no
	 * @return  CREDIT_SCORE:信用度分值
	 *          PHONE_NO：服务号码
	 *          CREDIT_GRADE：信用度等级名称
	 *          CREDIT_CODE:信用度等级代码
	 *          OVER_FEE：透支额度
	 *          REGION_ID：归属地市
	 *          CONSUME：月均消费
	 *          ONLINE_TIME：在线时长
	 *          LIMIT_DAYS：可透支天数
	 *          SINGLESTOP_DAYS：单停天数
	 *          NOTICE_MSG：提示信息
	 *          CREDIT_CODE2：为crm侧提供，将credit_code转为数字
	 */
	OutDTO query(final InDTO inParam);
	
	/**
	 * 
	 * 名称：用户星级评分明细查询
	 * @param PHONE_NO  手机号码
	 *        LOGIN_NO  操作工号
	 *        CHN_CODE  渠道代码 01-营业，02-网厅，04-短信，05-自助终端
	 *        OP_CODE   操作代码
	 *        
	 * @return
	 *       ONLINE_LEV  网龄分层
	 *       COMM_FLAG   通信用户标识
	 *       AVG_ARPU    月均ARPU
	 *       AVGARPU_SCORE 月均ARPU得分
	 *       USER_ONLINE 网龄
	 *       ONLINE_SCORE 网龄得分
	 *       EXTFAMILY_FLAG 亲情号码标识 
	 *       EXTFAMILY_SCORE 亲情号码得分
	 *       VPMNBINE_FLAG 集团V网标识
	 *       VPMNBIND_SCORE  集团V网得分
	 *       HAPPYFAMILY_FLAG 幸福家庭标识
	 *       HAPPYFAMILY_SCORE 幸福家庭得分
	 *       TERMBINE_MONTHS  终端捆绑时长
	 *       PAYBACK_MONTHS  缴费回馈时长
	 *       BIND_SCORE 合约捆绑得分
	 *       BANKPAY_CNTS 银行卡绑定缴费次数
	 *       ENTTS_FLAG 集团托收客户标识 
	 *       PAYBIND_SCORE 是否绑定付费得分
	 *       REALNAME_FLAG 实名制标识
	 *       REALNAME_SCORE 实名制得分
	 *       STOP_CNTS 双停(即全停)次数
	 *       STOP_SCORE 双停得分
	 *       BASE_SCORE 基础得分
	 *       ADD_SCORE 加分值
	 *       LESS_SCORE 减分值
	 *       ALL_SCORE 总分
	 *       STAR_LEV 客户星级 
	 *       DESC_REASON  描述
	 *       B 评级生效时间
	 *       END_TIME 评级到期时间
	 *       ADJ_FLAG 用户是否手工调整星级标识(Y-是, N-否)
	 * @author liuhl_bj
	 */
	OutDTO queryDetail(final InDTO inParam);
	
	/**
	 * 星级客户信誉度修改
	 */
	OutDTO cfm(final InDTO inParam);
	
	OutDTO queryForCrm(final InDTO inParam);
}
