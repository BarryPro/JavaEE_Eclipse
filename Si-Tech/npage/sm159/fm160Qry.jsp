<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-13 页面改造,修改样式
*
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%        
	
	String regionCode =  (String)session.getAttribute("regCode");
	String work_no=(String)session.getAttribute("workNo");
	String phone_no  = request.getParameter("phone_no");
	
	String starttimes=request.getParameter("starttimes");
	String endtimes=request.getParameter("endtimes");
	String current_timeNAME=new SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());

	
	//add by diling for 安全加固修改服务列表
	String password = (String) session.getAttribute("password");
	
	String  inputParsm [] = new String[17];
	inputParsm[0] = "";
	inputParsm[1] = "01";
	inputParsm[2] = "m160";
	inputParsm[3] = work_no;
	inputParsm[4] = password;
	inputParsm[5] = phone_no;
	inputParsm[6] = "";
	inputParsm[7] = "ZY";
	inputParsm[8] = "045106";
	inputParsm[9] = "ZY0601";
	inputParsm[10] = "09";
	inputParsm[11] = current_timeNAME;
	inputParsm[12] = "20501230000000";
	inputParsm[13] = current_timeNAME;
	inputParsm[14] = "二维码身份标识状态查询";
	inputParsm[15] = starttimes;
	inputParsm[16] = endtimes;
	
%>
     	
	<wtc:service name="sProWorkFlowCfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="3">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=inputParsm[7]%>"/>
			<wtc:param value="<%=inputParsm[8]%>"/>
			<wtc:param value="<%=inputParsm[9]%>"/>
			<wtc:param value="<%=inputParsm[10]%>"/>
			<wtc:param value="<%=inputParsm[11]%>"/>
			<wtc:param value="<%=inputParsm[12]%>"/>
			<wtc:param value="<%=inputParsm[13]%>"/>
			<wtc:param value="<%=inputParsm[14]%>"/>
			<wtc:param value="<%=inputParsm[15]%>"/>
			<wtc:param value="<%=inputParsm[16]%>"/>

	</wtc:service>

        <wtc:array id="MarkExchArr" scope="end"/>
	
<HTML><HEAD><TITLE></TITLE>
</HEAD>
<body>
    	
	
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">查询信息</div>
			</div>
	    <table cellspacing="0" name="t1" id="t1">
	      <tr align="center"> 

	        <th>操作时间</th>
	        <th>身份标识状态</th>
	        <th>操作来源</th>

	      </tr>
		<%
		System.out.println(MarkExchArr.length);
		if(retCode.equals("000000")) {
		if(MarkExchArr.length>0) {
			 String[] optimestr1=MarkExchArr[0][0].split("\\|");
			 String[] shenfenbiaozhistr1=MarkExchArr[0][1].split("\\|");
			 String[] caozuolaiyuanstr1=MarkExchArr[0][2].split("\\|");
			String tbClass="";
			for(int y=0;y<optimestr1.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
		%>
		
				<tr align="center">
					<td class="<%=tbClass%>"><%=optimestr1[y]%>&nbsp;</td>
					<td class="<%=tbClass%>"><%if(shenfenbiaozhistr1[y].equals("01")){out.print("新生成");}else if(shenfenbiaozhistr1[y].equals("02")){out.print("补发");}else if(shenfenbiaozhistr1[y].equals("03")){out.print("重置");}else if(shenfenbiaozhistr1[y].equals("04")){out.print("冻结");}else if(shenfenbiaozhistr1[y].equals("05")){out.print("解冻");}else if(shenfenbiaozhistr1[y].equals("06")){out.print("启用消费密码");}else if(shenfenbiaozhistr1[y].equals("07")){out.print("关闭消费密码");}else if(shenfenbiaozhistr1[y].equals("08")){out.print("未生成");}else if(shenfenbiaozhistr1[y].equals("09")){out.print("其他状态");}%>&nbsp;</td>
					<td class="<%=tbClass%>"><%=caozuolaiyuanstr1[y]%>&nbsp;</td>

				</tr>
		<%
		    }
		  }else {
		%>
<tr height='25' align='center' ><td colspan='3'>查询信息为空！</td></tr>
<%}}else {
			%>
			<tr height='25' align='center'><td colspan='3'>查询失败：<%=retCode%>--<%=retMsg%></td></tr>

					<%
	}%>
		</table>

      


	</BODY>
</HTML>

