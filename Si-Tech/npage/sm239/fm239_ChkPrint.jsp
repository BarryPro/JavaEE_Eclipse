<%
/*
* 功能: 
* 版本: 1.0
* 日期: liangyl 2017/01/01 关于物联卡功能优化的需求
* 作者: liangyl
* 版权: si-tech
*/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%
		System.out.println("===liangylSeeLog========= fm110.jsp ==========");

		String regionCode = (String)session.getAttribute("regCode");
		
		String iLoginAccept = request.getParameter("iLoginAccept");
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMM");
		String biaoTime=sdf1.format(new Date());
		
		String  inParamsMigu [] = new String[2];
	    inParamsMigu[0] = "select commit_flag from dServOrderPrt"+biaoTime+" where op_code = 'm110' and login_accept =:login_accept order by op_time desc";
	    inParamsMigu[1] = "login_accept="+iLoginAccept;
	    
		String retCode11 = "";
		String retMsg11 = "";
		String dayinFlag = "N";
		
try{		
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1"> 
	    <wtc:param value="<%=inParamsMigu[0]%>"/>
	    <wtc:param value="<%=inParamsMigu[1]%>"/> 
  	</wtc:service>  
  <wtc:array id="result_dayin"  scope="end"/>
		
	
<%
		retCode11 = retCode;
		retMsg11 = retMsg;
		if("000000".equals(retCode)){
			if(result_dayin.length>0){
				System.out.println("liangylLog-----------------------------"+ result_dayin[0][0]);
        		dayinFlag = result_dayin[0][0];
        	}
			else{
				dayinFlag = "N";
			}
		}else{
			System.out.println("============ fm110.jsp 失败==========");
			dayinFlag = "N";
		}
		}catch(Exception e){
			retCode11 = "444444";
			retMsg11 = "服务未启动或不正常，请联系管理员！";
			%>
				var infoArray = new Array();
			<%
		}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode11 %>");
response.data.add("retMsg","<%=retMsg11 %>");
response.data.add("dayinFlag","<%=dayinFlag %>");

core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         