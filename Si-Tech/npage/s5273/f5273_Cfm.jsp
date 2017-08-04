<%
  /*
　 * 作者: wangwei
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
　*/
%>
<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.25
********************/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%

    String myretFlag="",myretMsg="";//用于判断页面刚进入时的正确性
   
	String loginNo = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
	
	String region_code = request.getParameter("sales_region");
	String reward_rate = request.getParameter("reward_rate");
	String awake_fee = request.getParameter("awake_fee");
	String min_prepay = request.getParameter("min_prepay");
	String reason= request.getParameter("reason");
	String retMsg = null;
	
	/****************调用  sDemoGetMsg  ***********************/
   
	String[] paraStrIn = new String[7];
	paraStrIn[0] = loginNo;                 //工号
	paraStrIn[1] = nopass;                  //工号密码
	paraStrIn[2] = region_code;             //地市代码
	paraStrIn[3] = reward_rate;             //酬金比例
	paraStrIn[4] = awake_fee;               //代理商催缴阀值
	paraStrIn[5] = min_prepay;              //代理商充值阀值
	paraStrIn[6] = reason;              	//修改原因

	String srvName = "s5273Cfm"; //服务名1
	String outParaNums = "0"; //输出参数个数

	//impl.callFXService(srvName, paraStrIn,outParaNums,"region",regionCode);
%>
	<wtc:service name="s5273Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2">			
	<wtc:params value="<%=paraStrIn%>"/>	
	</wtc:service>	
	<wtc:array id="result1"  scope="end"/>
<% 
	String returnCode = retCode1; //错误代码
	String returnMsg = retMsg1; //错误信息

	if(returnCode.equals("000000")){
		retMsg = "佣金比例配置设置成功";
%>
		<script language="JavaScript">
		    rdShowMessageDialog("<%=retMsg%>",2);
		    removeCurrentTab();
		</script>
<%
	}else{
		retMsg = returnMsg;
%>
		<script language="JavaScript">
		    rdShowMessageDialog("<%=retMsg%>",0);
		    history.go(-1);
		</script>
<%
	}
%>
