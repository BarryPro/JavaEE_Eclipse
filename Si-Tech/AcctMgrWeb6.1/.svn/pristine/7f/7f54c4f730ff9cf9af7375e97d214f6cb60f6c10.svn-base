package com.sitech.acctmgr.common;

import com.sitech.common.AppErrorConstants;
import com.sitech.jcfx.error.AppError;

/**
 * 
* <p>Title: 账务管理错误码类  </p>
* <p>Description: 定义了帐管的错误码取值方法  </p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @author zhangjp
* @version 1.0
 */
public class AcctMgrError extends AppError {

	/**
	 * 获取错误编号
	 * @param opCode 操作编码
	 * @param seq 错误序列号
	 * @return
	 */
	public static String getErrorCode(String opCode, String seq) {
		return AppError.getErrorCode(AppErrorConstants.ChannelType.BOSS,
				AppErrorConstants.ErrorType.BUSI_ERROR,
				AppErrorConstants.SystemCode.ACCTMGR, opCode, seq);
	}
	
	/**
	 * 获取积分处理错误编号
	 * @param opCode 操作编码
	 * @param seq 错误序列号
	 * @return
	 */
	public static String getMarkErrorCode(String opCode, String seq) {
		return AppError.getErrorCode(AppErrorConstants.ChannelType.BOSS,
				AppErrorConstants.ErrorType.BUSI_ERROR,
				AppErrorConstants.SystemCode.SCOREDEAL, opCode, seq);
	}

	/**
	 * 获取错误编号
	 * @param opCode 操作编码
	 * @param seq 错误序列号
	 * @param errorType 错误类别
	 * @return
	 */
	public static String getErrorCode(String opCode, String seq,
			String errorType) {
		return AppError.getErrorCode(AppErrorConstants.ChannelType.BOSS,
				errorType, AppErrorConstants.SystemCode.ACCTMGR, opCode, seq);
	}

}
