<%
  /*************************************
  * 功  能: APN代码维护 修改操作 3474
  * 版  本: version v1.0
  * 开发商: si-tech
  * 创建者: @ 2012-2-28
  **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

  System.out.println("----------3440----------");
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
  
  String regCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	String region_code_upt = request.getParameter("region_code_upt");
  String loginNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String apn_code_upt = request.getParameter("apn_code_upt");
	
	System.out.println("----------3440----query------opCode="+opCode);
  System.out.println("----------3440----------region_code_upt="+region_code_upt);
  System.out.println("----------3440----------apn_code_upt="+apn_code_upt);
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

	<wtc:service name="s3440Qry" routerKey="region" routerValue="<%=regCode%>" 
		retcode="retCode" retmsg="retMsg" outnum="9">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=region_code_upt%>"/>  
		<wtc:param value="<%=apn_code_upt%>"/> 
	</wtc:service>
	<wtc:array id="ret"  scope="end"/>
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
					<th>APN名称</th>
					<th>有效标志</th>
					<th>是否可重用</th>
					<th>当前APN标志</th>
				  <th>操作</th>
				</tr>
<%
				if(ret.length==0){
					out.println("<tr height='25' align='center'><td colspan='8'>");
					out.println("没有任何记录！");
					out.println("</td></tr>");
				}else if(ret.length>0){
					for(int i=0;i<ret.length;i++){
%>
					<tr align="center" id="row_<%=i%>" >
						<td ><input id="info_1_<%=i%>" name="info_1_<%=i%>" value="<%=ret[i][2]%>" class="InputGrey" readonly /></td>
						<td height = 20>
						   <select id="info_2_<%=i%>" name="info_2_<%=i%>" disabled >
<%                 
                if("0".equals(ret[i][5])){
%>
                  <option class='button' value='0' selected='selected'>无效</option>
                  <option class='button' value='1'>有效</option>
<%
                }else{
%>
                  <option class='button' value='0' >无效</option>
                  <option class='button' value='1' selected='selected'>有效</option>
<%
                }
%>
                </select>
						</td>
						<td >
						  <select id="info_3_<%=i%>" name="info_3_<%=i%>"  disabled >
<%                 
                if("0".equals(ret[i][6])){
%>
                  <option class='button' value='0' selected='selected'>否</option>
                  <option class='button' value='1'>是</option>
<%
                }else{
%>
                  <option class='button' value='0' >否</option>
                  <option class='button' value='1' selected='selected'>是</option>
<%
                }
%>
                </select>
						
						</td>
						
						
					<td   v_apn_is_change="0"  >
						
  		 			
                   
						  <select   onchange="check_this_change(this)"  disabled>
<%                 
                if("0".equals(ret[i][8])){
%>
                  <option   class='button' value='0' selected='selected'>2/3G</option>
                  <option   class='button' value='1'>2/3/4G</option>
<%
                }else{
%>
                  <option  class='button'  value='0' >2/3G</option>
                  <option  class='button'  value='1' selected='selected'>2/3/4G</option>
<%
                }
%>
                </select>
						
						</td>
						
						
						<td >
						  <input class="b_foot" type="button" id="uptInfoBtn" name="uptInfoBtn" value="修改" onclick="uptQryInfo(this)" />
						</td>
					</tr>
<%
					}
				}
%>

			</table>
	</div>
</div>
<%}%>
<input type="hidden" id="retCode" name="retCode" value="<%=retCode%>" />
<input type="hidden" id="retMsg" name="retMsg" value="<%=retMsg%>" />