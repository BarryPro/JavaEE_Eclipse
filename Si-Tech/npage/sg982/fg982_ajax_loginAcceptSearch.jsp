<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String opCode = "g982";
    String opName = "资费与终端分离目标用户导入 ";
    String workno = (String)session.getAttribute("workNo");
	String nopass =(String)session.getAttribute("password");
	String ipAddr =(String)session.getAttribute("ipAddr");
	String phone_brand = WtcUtil.repStr(request.getParameter("phone_brand"), "");
	String phone_type = WtcUtil.repStr(request.getParameter("phone_type"), "");
	String regionCode = (String)session.getAttribute("regCode");
	String regionCode1 = request.getParameter("region_code");
	String remark = "操作员："+workno+"进行了资费与终端分离目标用户导入流水查询";
	String loginAccept = WtcUtil.repStr(request.getParameter("loginAccept"), "");
	
	
	System.out.println(" zhouby xxx " + regionCode1);
%>

	<wtc:service name="sg982Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg"  outnum="10" >
		<wtc:param value="<%=loginAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/> 
		<wtc:param value="q"/>   <%/*操作标识 q 查询 0 增加 1 删除*/%>
		<wtc:param value="<%=phone_brand%>"/>
		<wtc:param value="<%=phone_type%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=remark%>"/>
		<wtc:param value="<%=ipAddr%>"/>
		<wtc:param value="<%=regionCode1%>"/> <%/*地市代码 删除有值*/%>
	</wtc:service>
	
	<wtc:array id="ret" scope="end" />
<%
    if("000000".equals(retCode)){
%>

  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">查询结果</div>
			</div>
			<table cellspacing="0" name="t1" id="t1">
<%
				if(ret.length>0){
				
                    if("0".equals(ret[0][8])){
                        
%>
    					<tr align="center">
        					<td><%=ret[0][9]%></td>
    					</tr>
<%
                    } else{
%>
                        <tr>
                            <th>地市</th>
        					<th>品牌</th>
        					<th>机型</th>
        					<th>开始时间</th>
        					<th>结束时间</th>
        					<th>条数</th>
                        </tr>
                        
                        <tr>
                            <td><%=ret[0][0]%></td>
    						<td><%=ret[0][2]%></td>
    						<td><%=ret[0][4]%></td>
    						<td><%=ret[0][5]%></td>
    						<td><%=ret[0][6]%></td>
    						<td>成功<%=ret[0][7]%>条</td>
                        </tr>
                        <tr>
                            <td><%=ret[0][0]%></td>
    						<td><%=ret[0][2]%></td>
    						<td><%=ret[0][4]%></td>
    						<td><%=ret[0][5]%></td>
    						<td><%=ret[0][6]%></td>
    						<td>失败<%=ret[0][9]%>条</td>
                        </tr>
<%
				    }
				}
%>
			</table>
	</div>
</div>
<%
}
%>
<input type="hidden" id="retCode" name="retCode" value="<%=retCode%>" />
<input type="hidden" id="retMsg" name="retMsg" value="<%=retMsg%>" />