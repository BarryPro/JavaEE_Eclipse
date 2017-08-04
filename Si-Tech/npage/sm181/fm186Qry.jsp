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
<%@ include file="/npage/properties/getRDMessage.jsp" %>

<%        
	
	String regionCode =  (String)session.getAttribute("regCode");
	String work_no = (String)session.getAttribute("workNo");
	
	String zr_phone  = request.getParameter("zr_phone");	
	String sr_phone  = request.getParameter("sr_phone");	
	String starttime=request.getParameter("starttime");
	String endtime=request.getParameter("endtime");
	String jyls=request.getParameter("jyls");

	String bus_realPath = request.getRealPath("npage/properties")
     +"/jfInfo.properties";

	String current_timeNAME=new SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());

	
	//add by diling for 安全加固修改服务列表
	String password = (String) session.getAttribute("password");
	
	String  inputParsm [] = new String[17];
	inputParsm[0] = "0";
	inputParsm[1] = "01";
	inputParsm[2] = "m186";
	inputParsm[3] = work_no;
	inputParsm[4] = password;
	inputParsm[5] = zr_phone;
	inputParsm[6] = "";
	inputParsm[7] = "0003";
	inputParsm[8] = sr_phone;
	inputParsm[9] = starttime;
	inputParsm[10] = endtime;
	inputParsm[11] = "-9";
	inputParsm[12] = "-9";
	inputParsm[13] = jyls;

	
%>
     	
	<wtc:service name="sm186Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="20">
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

	</wtc:service>
		<wtc:array id="result2222" scope="end"  start="0"  length="1"/>
  <%
  System.out.println("返回数组长度="+result2222.length);
			if(result2222.length>0) {
	System.out.println("查询总共有多少条="+result2222[0][0]);		
					inputParsm[11] = "1";
	        inputParsm[12] = result2222[0][0];
	        
	        if("0".equals(result2222[0][0])) {
	        inputParsm[12] = "100";
	        }
	        	        
			}else {
					inputParsm[11] = "1";
	        inputParsm[12] = "100";				
			}
  %>
	<wtc:service name="sm186Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="20">
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

	</wtc:service>
   <wtc:array id="result2" scope="end"  start="1"  length="19"/>
	
<HTML><HEAD><TITLE></TITLE>
</HEAD>
<body>
    	
	
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">查询信息</div>
			</div>
	    <table cellspacing="0" name="t1" id="t1">
	      <tr align="center"> 
            
          <th>集团积分平台交易流水号</th>
          <th>交易请求时间</th>
          <th>渠道标识</th>
	        <th>转让人手机号码</th>
	        <th>受让人手机号码</th>
	        <th>转赠积分值</th>
	        <th>处理状态</th>
	        <th>处理结果描述</th>


	      </tr>
		<%
		if(retCode.equals("000000")) {
		System.out.println(result2.length);

		if(result2.length>0) {
			String tbClass="";
			for(int y=0;y<result2.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
		%>
						<tr align="center">
						<td class="<%=tbClass%>"><%=result2[y][0]%></td>
						<td class="<%=tbClass%>"><%=result2[y][1]%></td>
						<td class="<%=tbClass%>"><%=readValue(result2[y][2],"jf","OrgID",bus_realPath)%></td>	
						<td class="<%=tbClass%>"><%=result2[y][3]%></td>		
						<td class="<%=tbClass%>"><%=result2[y][4]%></td>			
						<td class="<%=tbClass%>"><%=result2[y][5]%></td>	
						<td class="<%=tbClass%>"><%=readValue(result2[y][6],"jf","TradeStatus",bus_realPath)%></td>
						<td class="<%=tbClass%>"><%=result2[y][8]%></td>

		</tr>
		<%
		    }
		   }else {
		%>
<tr height='25' align='center' ><td colspan='8'>查询信息为空！</td></tr>
<%}}else {
			%>
			<tr height='25' align='center'><td colspan='8'>查询失败：<%=retCode%>--<%=retMsg%></td></tr>

					<%
	}%>
		</table>

      


	</BODY>
</HTML>

