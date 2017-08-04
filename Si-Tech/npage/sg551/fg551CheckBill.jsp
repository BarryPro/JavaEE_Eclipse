<%
  /* *********************
   * 功能: 检测用户账单
   * 版本: 1.0
   * 日期: 2013/03/11
   * 作者: zhouby
   * 版权: si-tech
   * *********************/
%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String inLoginNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		
		String phoneNo = (String)request.getParameter("phoneNo");
		String date = (String)request.getParameter("date");
		String value = (String)request.getParameter("value");
		/**
		System.out.println("zhouby opCode " + opCode);
		System.out.println("zhouby inLoginNo " + inLoginNo);
		System.out.println("zhouby password " + password);
		System.out.println("zhouby phoneNo " + phoneNo);
		*/
		System.out.println("zhouby date " + date);
%>
		
		<wtc:service name="se610" routerKey="region" routerValue="<%=regionCode%>"
			 retcode="retCode" retmsg="retMsg" outnum="43">
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value="<%=date%>"/>
				<wtc:param value="<%=inLoginNo%>"/>
				<wtc:param value="<%=value%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
			
		var array = [];
<%
 		String test[][] = result;

        System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++");
        for(int outer=0 ; test != null && outer< test.length; outer++)
        {
                for(int inner=0 ; test[outer] != null && inner< test[outer].length; inner++)
                {
                        System.out.print(" | "+test[outer][inner]);
                }
                System.out.println(" | ");
        }
        System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++");
		/**
		 * 输入参数：
		    1	手机号码	字符串	15		按帐户号码查询时，为空
			2	帐单年月	字符串	6		格式为”YYYYMM”
			3	操作工号	字符串	6		
			4	消费额度	字符串			格式为“a,b,c” 2012/11/26新增

		 * 返回参数：
		  SVC_ERR_NO32	返回代码	单行	字符串	6		
			SVC_ERR_MSG32	返回提示信息	单行	字符串	30		
			GPARM32_0	返回代码	单行	字符串	6		
			GPARM32_1	客户名称	单行	字符串	60		
			GPARM32_2	品牌名称	单行	字符串	20		
			GPARM32_3	服务号码	单行	字符串	15		
			GPARM32_4	计费开始日期	单行	字符串	8		日期格式为yyyyMMdd
			GPARM32_5	计费结束日期	单行	字符串	8		日期格式为yyyyMMdd
			GPARM32_6	邮递姓名	单行	字符串	60		如果没有邮寄帐单信息，则该传出参数为空
			GPARM32_7	邮编	单行	字符串	6		如果没有邮寄帐单信息，则该传出参数为空
			GPARM32_8	邮编地址	单行	字符串	100		如果没有邮寄帐单信息，则该传出参数为空
			GPARM32_9	帐户项目	多行	字符串	30		关键信息区
			GPARM32_10	帐户项目金额	多行	字符串	10		关键信息区
			GPARM32_11	项目级别	多行	字符串	10		关键信息区
			GPARM32_12	费用项目	多行	字符串	60		如有代他人付费，包括代他人付费项；如有优惠，包括优惠项目
			GPARM32_13	费用项目金额	多行	字符串	10		
			GPARM32_14	费用级别	多行	字符串	1		1、一级2、二级
			GPARM32_15	近6个月月份	多行	字符串	6		格式为yyyyMM
			GPARM32_16	近6个月消费金额	多行	字符串	10		
			GPARM32_17	套餐及固定费	单行	字符串	10		当月费用结构图
			GPARM32_18	语音通信费	单行	字符串	10		
			GPARM32_19	可视电话通信费	单行	字符串	10		
			GPARM32_20	上网费	单行	字符串	10		
			GPARM32_21	短信及彩信费	单行	字符串	10		
			GPARM32_22	自有增值业务费（A类）	单行	字符串	10		
			GPARM32_23	自有增值业务费（B类）	单行	字符串	10		
			GPARM32_24	集团业务费	单行	字符串	10		
			GPARM32_25	代收业务费用	单行	字符串	10		
			GPARM32_26	其他费用	单行	字符串	10		
			GPARM32_27	帐户项目	多行	字符串	30		账户概要信息区
			GPARM32_28	上期结余	多行	字符串	10		
			GPARM32_29	本期收入	多行	字符串	10		
			GPARM32_30	本期返还	多行	字符串	10		
			GPARM32_31	本期退费	多行	字符串	10		
			GPARM32_32	本期可用	多行	字符串	10		
			GPARM32_33	消费支出	多行	字符串	10		
			GPARM32_34	其它支出	多行	字符串	10		
			GPARM32_35	余额	多行	字符串	10		
			GPARM32_36	积分值	多行	字符串	10		
			GPARM32_37	关键信息区father_id	多行	字符串	10		自助终端使用
			GPARM32_38	宣传语	单行	字符串	1024		全球通随行计划优惠信息
			GPARM32_39	信息验证标识	单行	字符串	2		0 成功 ，1 失败
			GPARM32_40	近3个月消费金额	多行	字符串	10		上月消费金额
			GPARM32_41	近3个月消费金额	多行	字符串	10		前第二个月消费金额
			GPARM32_42	近3个月消费金额	多行	字符串	10		前第三个月消费金额

		 */
		if ("000000".equals(retCode) && result.length > 0){
				for(int i = 0; i < result.length; i++){
%>
						var t = [];
<%
						for(int j = 0; j < result[i].length; j++){
						//System.out.println("zhouby result [" + i +"][" + j + "] = " + result[i][j]);
%>					
								t[<%=j%>] = "<%=result[i][j]%>";
<%
						}
%>
						array[<%=i%>] = t;
<%
				}
		}
		//System.out.println("zhouby retCode  " +retCode);
%>
		var response = new AJAXPacket();
		response.data.add("retCode", "<%=retCode%>");
		response.data.add("retMsg", "<%=retMsg%>");
		response.data.add("value", "<%=value%>");
		response.data.add("result", array);
		core.ajax.receivePacket(response);