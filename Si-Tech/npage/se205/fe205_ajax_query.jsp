<%
    /*************************************
    * 功  能: 集团规模等级修改 e205
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2011-8-16
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String regCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
    String loginNo= (String)session.getAttribute("workNo");
    String password = (String)session.getAttribute("password");
	String unitNo = WtcUtil.repStr(request.getParameter("unitNo"), "");
	String unitName = WtcUtil.repStr(request.getParameter("unitName"), "");
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String _getUnitId = "";
	String _getUnitName = "";
	String[] NowUnitMode=new String[]{"A1","A2","B1","B2","C1","C2","C4","D","E"}; 
%>

	<wtc:service name="se205Qry" routerKey="regionCode" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg" outnum="7">
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=opCode%>"/> 
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=password%>"/> 
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=unitNo%>"/>
		<wtc:param value="<%=unitName%>"/>
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
<%
    if("000000".equals(retCode)){
%>
  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">集团规模等级查询结果</div>
			</div>
			<table cellspacing="0" name="t1" id="t1">
				<tr>
					<th>集团编码</th>
					<th>集团名称</th>
					<th>客户经理</th>
					<th>目前集团规模</th>
					<th>集团规模评定时间</th>
					<th>新集团规模</th>
				</tr>
<%
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='11'>");
					out.println("没有任何记录！");
					out.println("</td></tr>");
				}else if(ret.length>0){
					String tbclass = "";
					for(int i=0;i<ret.length;i++){
							tbclass = (i%2==0)?"Grey":"";
							_getUnitId = ret[i][2];
							_getUnitName = ret[i][3];
%>
					<tr align="center" id="row_<%=i%>">
						<td class="<%=tbclass%>"><%=ret[i][2]%></td>
						<td class="<%=tbclass%>"><%=ret[i][3]%></td>
						<td class="<%=tbclass%>"><%=ret[i][4]%></td>
						<td class="<%=tbclass%>"><%=ret[i][5]%></td>
						<td class="<%=tbclass%>"><%=ret[i][6]%></td>
						<td class="<%=tbclass%>">
						    <select name="newUnitOwner" id="newUnitOwner" >  
						       <%
						            for(int j=0;j<NowUnitMode.length;j++){
						                if((NowUnitMode[j].equals(ret[i][5]))){
						                  out.print("<option value="+j+" selected >"+NowUnitMode[j]+"</option>");
						                }else{
						                	out.print("<option value="+j+">"+NowUnitMode[j]+"</option>");
						                }
						            }
						       %> 
                 </select> 
						</td>
					</tr>
<%
					}
				}
%>
                <tr>
                    <td colspan="6" align="center" id="footer">
                        <input type="button" id="submitBtn" name="submitBtn" class="b_foot" value="确定" onClick="submitUpdate()" />   
                        <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="关闭" onClick="removeCurrentTab();" />
                    </td>
                </tr>
			</table>
	</div>
</div>
<%}%>
<input type="hidden" id="retCode" name="retCode" value="<%=retCode%>" />
<input type="hidden" id="retMsg" name="retMsg" value="<%=retMsg%>" />
<input type="hidden" id="_getUnitId" name="_getUnitId" value="<%=_getUnitId%>" />
<input type="hidden" id="_getUnitName" name="_getUnitName" value="<%=_getUnitName%>" />