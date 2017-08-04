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
<%!
/*2014/10/08 10:03:04 gaopeng 关于完善BOSS和经分系统客户信息模糊化展示的函（201409） 
	模糊化公共方法 objType 1 客户名称 账户名称 2其他（各种地址等）
*/
private String vagueFunc(String objName,int objType){
	if(objName != null && !"".equals(objName) && !"NULL".equals(objName)){
		if(objType == 1){
			if(objName.length() == 2 ){
				objName = objName.substring(0,1)+"*";
			}
			if(objName.length() == 3 ){
				objName = objName.substring(0,1)+"**";
			}
			if(objName.length() == 4){
				objName = objName.substring(0,2)+"**";
			}
			if(objName.length() > 4){
				objName = objName.substring(0,2)+"******";
			}
		}else if(objType == 2){
			objName = "********";
		}
		
	}
	return objName;
}
%>
<%        
	
	String regionCode =  (String)session.getAttribute("regCode");
	
	String phone_no  = request.getParameter("phone_no");	
	String starttimes=request.getParameter("starttime");
	String banlitype=request.getParameter("banlitype");
	String endtimes=request.getParameter("endtime");
	String work_no = (String)session.getAttribute("workNo");
	
	String bus_realPath = request.getRealPath("npage/properties")
     +"/jfInfo.properties";

	
	String current_timeNAME=new SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());

	
	//add by diling for 安全加固修改服务列表
	String password = (String) session.getAttribute("password");
	
	String  inputParsm [] = new String[17];
	inputParsm[0] = "0";
	inputParsm[1] = "01";
	inputParsm[2] = "m184";
	inputParsm[3] = work_no;
	inputParsm[4] = password;
	inputParsm[5] = phone_no;
	inputParsm[6] = "";
	inputParsm[7] = banlitype;
	inputParsm[8] = starttimes;
	inputParsm[9] = endtimes;
	inputParsm[10] = "-9";	
	inputParsm[11] = "-9";

	
%>
     	
	<wtc:service name="sm184Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="20">
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

	</wtc:service>
	<wtc:array id="result2222" scope="end"  start="0"  length="1"/>
  <%
  System.out.println("返回数组长度="+result2222.length);
			if(result2222.length>0) {
	System.out.println("查询总共有多少条="+result2222[0][0]);		
					inputParsm[10] = "1";
	        inputParsm[11] = result2222[0][0];
	        
	        if("0".equals(result2222[0][0])) {
	        inputParsm[11] = "100";
	        }
	        
			}else {
					inputParsm[10] = "1";
	        inputParsm[11] = "100";				
			}
  %>
  	<wtc:service name="sm184Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="20">
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

	        <th>受让人手机号码</th>
	        <th>受让人姓名</th>
	        <th>有效证件类型</th>
	        <th>有效证件</th>
	        <th>生效日期</th>
	        <th>操作时间</th>
	        <th>操作类型</th>
	        <th>渠道标识</th>
	        <th>受让人状态</th>


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
						<td class="<%=tbClass%>"><%=result2[y][2]%></td>
						<td class="<%=tbClass%>"><%=vagueFunc(result2[y][3],1)%></td>
						<td class="<%=tbClass%>"><%=readValue(result2[y][4],"jf","ValidNumType",bus_realPath)%></td>	
						<td class="<%=tbClass%>"><%=result2[y][5]%></td>		
						<td class="<%=tbClass%>"><%=result2[y][6]%></td>			
						<td class="<%=tbClass%>"><%=result2[y][7]%></td>	
						<td class="<%=tbClass%>"><%=readValue(result2[y][8],"jf","optype",bus_realPath)%></td>
						<td class="<%=tbClass%>"><%=readValue(result2[y][9],"jf","OrgID",bus_realPath)%></td>
						<td class="<%=tbClass%>"><%=readValue(result2[y][10],"jf","AssigneeStatus",bus_realPath)%></td>

		</tr>
		<%
		    }
		  }else {
		%>
<tr height='25' align='center' ><td colspan='9'>查询信息为空！</td></tr>
<%}}else {
			%>
			<tr height='25' align='center'><td colspan='9'>查询失败：<%=retCode%>--<%=retMsg%></td></tr>

					<%
	}%>
		</table>

      


	</BODY>
</HTML>

