<%
    /*************************************
    * 功  能: 营销限制配置 g366
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-12-24
    **************************************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
%>
<%
	String opCode = "g366";
	String opName = "营销限制配置";
	String offerId = WtcUtil.repNull((String)request.getParameter("offerId"));//资费代码
  String regCode = (String)session.getAttribute("regCode");
  
  String  inParams [] = new String[2];
  inParams[0] =  "select region_name,right_limit from region where offer_id=:offerid";
  inParams[1] = "offerid="+offerId;
  
%>
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="4"> 
    <wtc:param value="<%=inParams[0]%>"/>
    <wtc:param value="<%=inParams[1]%>"/> 
  </wtc:service>  
  <wtc:array id="ret"  scope="end"/>
<%
  if(!"000000".equals(retCode1)){
%>
    <SCRIPT type=text/javascript>
      rdShowMessageDialog("错误代码：<%=retCode1%><br>错误信息：<%=retMsg1%>",0);
      window.close();
    </SCRIPT>
<%
    }else{
%>
<HTML>
<HEAD>
<TITLE>资费发布的地市、资费权限信息</TITLE>
<script language="javascript" type="text/javascript" src="../fe743_mainScript.js"></script>
</HEAD>
<BODY>
<FORM method=post name="">
	<%@ include file="/npage/include/header.jsp" %>
		<div class="title" style="margin-top:20px;">
			<div id="title_zi">资费发布的地市、资费权限信息</div>
		</div>
		<table style="width:96.8%">
			<tr align="center">
				<th>资费发布的地市</th>
				<th>资费权限</th>
			</tr>
			<%
				if(ret.length==0){
		  %>
		      <SCRIPT type=text/javascript>
  					rdShowMessageDialog("没有获取到相关内容！",1);
  					window.close();
					</SCRIPT>
		  <%
				}else if(ret.length>0){
   					String tbclass = "";
  					for(int i=0;i<ret.length;i++){
  							tbclass = (i%2==0)?"Grey":"";
  %>
  					<tr align="center" id="row_<%=i%>">
  						<td class="<%=tbclass%>"><%=ret[i][0]%></td>
  						<td class="<%=tbclass%>"><%=ret[i][1]%></td>
  					</tr>
  <%
  					} 
				}
%>
		</table>
		<table style="width:96.8%">
			<TR id="footer">
				<TD align=center>
					<input type="button" class="b_foot" onclick="window.close()" value="关闭" />
				</TD>
			</TR>
		</table>

	<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<%
}
%>