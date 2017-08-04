<%
  /*
   * 功能: 资费与终端分离目标用户导入 g982
   * 版本: 1.0
   * 日期: 2013/9/17
   * 作者: diling
   * 版权: si-tech
   * update:
  */
%>
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
	String regionCode1 = WtcUtil.repStr(request.getParameter("regionCode"), "");
	String remark = "操作员："+workno+"进行了资费与终端分离目标用户导入-删除查询";
%>

	<wtc:service name="sg982Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg"  outnum="7" >
		<wtc:param value="0"/>
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
				<tr>
				  <th></th>
					<th>地市</th>
					<th>品牌</th>
					<th>机型</th>
					<th>开始时间</th>
					<th>结束时间</th>
				</tr>
<%
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='6'>");
					out.println("没有任何记录！");
					out.println("</td></tr>");
				}else if(ret.length>0){
					String tbclass = "";
					for(int i=0;i<ret.length;i++){
							tbclass = (i%2==0)?"Grey":"";
%>
					<tr align="center" id="row_<%=i%>">
					  <td class="<%=tbclass%>"><input type="radio" name="delQryRadio" value="" v_regionCode="<%=ret[i][0]%>" v_phoneBrand="<%=ret[i][1]%>" v_phoneType="<%=ret[i][3]%>" v_beginTime="<%=ret[i][5]%>" v_endTime="<%=ret[i][6]%>" ></td>
						<td class="<%=tbclass%>"><%=ret[i][0]%></td>
						<td class="<%=tbclass%>"><%=ret[i][2]%></td>
						<td class="<%=tbclass%>"><%=ret[i][4]%></td>
						<td class="<%=tbclass%>"><%=ret[i][5]%></td>
						<td class="<%=tbclass%>"><%=ret[i][6]%></td>
					</tr>
<%
					}
%>
          <tr> 
        		<td colspan="6" align="center" id="footer"> 
        			<input class="b_foot" type=button name="subDelBtn" id="subDelBtn" value="确定" index="2" onclick="subDelInfo()" />    
        			<input class="b_foot" type=button name="cloDelBtn" value="关闭" onClick="removeCurrentTab();" />
        		</td>
        	</tr>
<%
				}
%>
			</table>
	</div>
</div>
<%}%>
<input type="hidden" id="retCode" name="retCode" value="<%=retCode%>" />
<input type="hidden" id="retMsg" name="retMsg" value="<%=retMsg%>" />