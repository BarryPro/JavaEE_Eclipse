<%
    /*************************************
    * ��  ��: Ӫ���������� g366
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2012-12-24
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
	String opName = "Ӫ����������";
	String offerId = WtcUtil.repNull((String)request.getParameter("offerId"));//�ʷѴ���
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
      rdShowMessageDialog("������룺<%=retCode1%><br>������Ϣ��<%=retMsg1%>",0);
      window.close();
    </SCRIPT>
<%
    }else{
%>
<HTML>
<HEAD>
<TITLE>�ʷѷ����ĵ��С��ʷ�Ȩ����Ϣ</TITLE>
<script language="javascript" type="text/javascript" src="../fe743_mainScript.js"></script>
</HEAD>
<BODY>
<FORM method=post name="">
	<%@ include file="/npage/include/header.jsp" %>
		<div class="title" style="margin-top:20px;">
			<div id="title_zi">�ʷѷ����ĵ��С��ʷ�Ȩ����Ϣ</div>
		</div>
		<table style="width:96.8%">
			<tr align="center">
				<th>�ʷѷ����ĵ���</th>
				<th>�ʷ�Ȩ��</th>
			</tr>
			<%
				if(ret.length==0){
		  %>
		      <SCRIPT type=text/javascript>
  					rdShowMessageDialog("û�л�ȡ��������ݣ�",1);
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
					<input type="button" class="b_foot" onclick="window.close()" value="�ر�" />
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