<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>

<%
String opName = WtcUtil.repNull(request.getParameter("opName"));
	String opCode = WtcUtil.repNull(request.getParameter("opCode"));
	String bd0001_orgCode = (String)session.getAttribute("orgCode");
	String bd0001_regionCode = bd0001_orgCode.substring(0,2);
	String gCustId = request.getParameter("gCustId");
	String mytemp=request.getParameter("mytemp");
%>

<!--ȡ�ͻ���ϸ��Ϣ-->
<wtc:utype name="sQryCustInfo" id="retCustInfos" scope="end"  routerKey="region" routerValue="<%=bd0001_regionCode%>">
     <wtc:uparam value="<%=gCustId%>" type="LONG"/>    
</wtc:utype>
<%
     
     String retCode_0001 =retCustInfos.getValue(0);
     String retMsg_0001  =retCustInfos.getValue(1);     
     if(retCode_0001.equals("0")){   
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>������BOSS-���ſͻ���ѯ</TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<BODY>
<FORM method=post name="fPubSimpSel">  
<%@ include file="/npage/include/header_pop.jsp" %> 
<div class="title">
	<div id="title_zi">��������</div>
</div>
			<%if(retCustInfos.getSize("2.0")!= 0){%>
			<table cellspacing=0>
				<tr>
					<td class="blue">�ͻ�����</td>
					<td>
							<input type="hidden" class="required" name="cust_name" value="<%=retCustInfos.getValue("2.0.4")%>"/><%=retCustInfos.getValue("2.0.4")%>
					</td>
					<td class="blue">�ͻ�״̬</td>
					<td><input type="hidden" name="cust_status" value="<%=retCustInfos.getValue("2.0.6")%>"/><%=retCustInfos.getValue("2.0.6")%></td>
				</tr>
				<tr>
					<td class="blue">��������</td>
					<td>
							<input type="hidden" name="cust_owner" value="<%=retCustInfos.getValue("2.0.2")%>"/><%=retCustInfos.getValue("2.0.2")%>
					</td>
					<td class="blue">��ͻ���־</td>
					<td><input type="hidden" name="cust_level" value="<%=mytemp%>"/><%=mytemp%></td>
				</tr>
				<tr>
					<td class="blue">�ͻ�����</td>
					<td>
							<input type="hidden"  name="cust_type" value="<%=retCustInfos.getValue("2.0.9")%>"/><%=retCustInfos.getValue("2.0.9")%>
					</td>
					<td class="blue">֤������</td>
					<td><input type="hidden" name="iccd_type" value="<%=retCustInfos.getValue("2.0.11")%>"/><%=retCustInfos.getValue("2.0.11")%></td>
				</tr>
				<tr>
					<td class="blue">֤������</td>
					<td>
							<input type="hidden" name="iccd_no" value="<%=retCustInfos.getValue("2.0.12")%>" /><%=retCustInfos.getValue("2.0.12")%>
					</td>
					<td class="blue">�ͻ���ַ</td>
					<td><input type="hidden" name="cust_addr" value="<%=retCustInfos.getValue("2.0.10")%>" /><%=retCustInfos.getValue("2.0.10")%></td>
				</tr>		
				<tr>
					<td class="blue">����</td>
					<td>
							<input type="hidden" name="iccd_no" value="<%=retCustInfos.getValue("2.0.37")%>" /><%=retCustInfos.getValue("2.0.37")%>
					</td>
					<td class="blue"> </td>
					<td> </td>
				</tr>				 
			</table>
			<%}%>
		<%
			if(retCustInfos.getSize(2) >=2 && retCustInfos.getUtype("2.1") !=null){	
					for(int i = 0;i<retCustInfos.getSize("2.1");i++){
		%>
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">��ϵ��<%=i+1%>��Ϣ</div>
</div>

			<table cellspacing=0>
				<tr>
					<td class="blue">��ϵ������</td>
					<td>
							<input type="hidden" name="contactor" value="<%=retCustInfos.getValue("2.1."+i+".2")%>" /><%=retCustInfos.getValue("2.1."+i+".2")%>
					</td>
					<td class="blue">֤������</td>
					<td><input type="hidden" name="contact_iccdType" value="<%=retCustInfos.getValue("2.1."+i+".5")%>" /><%=retCustInfos.getValue("2.1."+i+".5")%></td>
				</tr>
				<tr>
					<td class="blue"> ֤������</td>
					<td>
							<input type="hidden" name="contact_iccdNo" value="<%=retCustInfos.getValue("2.1."+i+".6")%>" /><%=retCustInfos.getValue("2.1."+i+".6")%>
					</td>
					<td class="blue">��ϵ�̶��绰</td>
					<td><input type="hidden" name="contact_phone" value="<%=retCustInfos.getValue("2.1."+i+".3")%>"/><%=retCustInfos.getValue("2.1."+i+".3")%></td>
				</tr>
				<tr>
					<td class="blue">�ֻ�����</td>
					<td>
							<input type="hidden" name="contact_mobile" value="<%=retCustInfos.getValue("2.1."+i+".4")%>"/><%=retCustInfos.getValue("2.1."+i+".4")%>
					</td>
					<td class="blue">��ϵ�˵�ַ</td>
					<td><input type="hidden" name="contact_addr" value="<%=retCustInfos.getValue("2.1."+i+".8")%>"/><%=retCustInfos.getValue("2.1."+i+".8")%></td>
				</tr>
				<tr>
					<td class="blue">��ַ�ʱ�</td>
					<td>
							<input type="hidden" name="contact_zip" value="<%=retCustInfos.getValue("2.1."+i+".7")%>"/><%=retCustInfos.getValue("2.1."+i+".7")%>
					</td>
					<td class="blue">��ϵ��E_Mail</td>
					<td><input type="hidden" name="contact_email" value="<%=retCustInfos.getValue("2.1."+i+".9")%>"/><%=retCustInfos.getValue("2.1."+i+".9")%></td>
				</tr>				 
			</table>
			
		<%
		}
		if(retCustInfos.getSize(2) >=3 && retCustInfos.getUtype("2.2") !=null && retCustInfos.getSize("2.2")!=0){%>
		</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">���˸�����Ϣ</div>
</div>
			<table cellspacing=0>
				<tr>
					<td class="blue">�ͻ��Ա�</td>
					<td>
							<input type="hidden" name="cust_gender" value="<%=retCustInfos.getValue("2.2.5")%>"/><%=retCustInfos.getValue("2.2.5")%>
					</td>
					<td class="blue">��������</td>
					<td><input type="hidden" name="cust_birthday" value="<%=retCustInfos.getValue("2.2.4").substring(0,8)%>"/><%=retCustInfos.getValue("2.2.4").substring(0,8)%></td>
				</tr>
				<tr>
					<td class="blue"> �ͻ�����</td>
					<td>
							<input type="hidden" name="cust_hobbies" value="<%=retCustInfos.getValue("2.2.1")%>"/><%=retCustInfos.getValue("2.2.1")%>
					</td>
					<td class="blue">�ͻ�ϰ��</td>
					<td><input type="hidden" class="cust_habit" value="<%=retCustInfos.getValue("2.2.0")%>"/><%=retCustInfos.getValue("2.2.0")%></td>
				</tr>
				<!--update by qiansheng 20091027
				<tr>
					<td class="blue">��ͥ�绰</td>
					<td>
							<input type="hidden" name="home_phone" value="<%=retCustInfos.getValue("2.2.8")%>"/><%=retCustInfos.getValue("2.2.8")%>
					</td>
					<td class="blue">�ʱ����</td>
					<td><input type="hidden" name="iccd_addr" value="<%=retCustInfos.getValue("2.2.7")%>"/><%=retCustInfos.getValue("2.2.7")%></td>
				</tr>
				-->
				<tr>
					<td class="blue">�����̶�</td>
					<td>
							<input type="hidden" name="study_level" value="<%=retCustInfos.getValue("2.2.2")%>"/><%=retCustInfos.getValue("2.2.2")%>
					</td>
					<td class="blue">ְҵ����</td>
					<td><input type="hidden" class="career_type" value="<%=retCustInfos.getValue("2.2.3")%></td>"/><%=retCustInfos.getValue("2.2.3")%></td>
				</tr>	
				<!--update by qiansheng 20091027
				<tr>
					<td class="blue">����</td>
					<td colspan="3">
							<input type="hidden" name="study_level" value="<%=retCustInfos.getValue("2.2.9")%>"/><%=retCustInfos.getValue("2.2.9")%>
					</td>					
				</tr>			
				-->	 
			</table>
		<%}
		}
		if(retCustInfos.getSize(2) >=4 && retCustInfos.getUtype("2.3") !=null && retCustInfos.getSize("2.3")!=0){
		%>
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">���Ÿ�����Ϣ</div>
</div>
			<table cellspacing=0>
				<tr>
					<td class="blue">��λ����</td>
					<td>
							<input type="hidden" name="unit_name" value="<%=retCustInfos.getValue("2.3.3")%>"/><%=retCustInfos.getValue("2.3.3")%>
					</td>
					<td class="blue">��ҵ����</td>
					<td><input type="hidden" name="corp_type" value="<%=retCustInfos.getValue("2.3.6")%>" /><%=retCustInfos.getValue("2.3.6")%></td>
				</tr>
				<tr>
					<td class="blue"> ���ŵ�������</td>
					<td>
							<input type="hidden" name="group_zoneType" value="<%=retCustInfos.getValue("2.3.9")%>"/><%=retCustInfos.getValue("2.3.9")%>
					</td>
					<td class="blue">������ҵ���</td>
					<td><input type="hidden" name="group_industryType" value="<%=retCustInfos.getValue("2.3.5")%>"/><%=retCustInfos.getValue("2.3.5")%></td>
				</tr>
				<tr>
					<td class="blue">���ű��</td>
					<td>
							<input type="hidden" name="group_no" value="<%=retCustInfos.getValue("2.3.0")%>"/><%=retCustInfos.getValue("2.3.0")%>
					</td>
					<td class="blue">��������</td>
					<td><input type="hidden" name="group_type" value="<%=retCustInfos.getValue("2.3.8")%>"/><%=retCustInfos.getValue("2.3.8")%></td>
				</tr>
				<tr>
					<td class="blue">���Ź�ģ</td>
					<td>
							<input type="hidden" name="group_level" value="<%=retCustInfos.getValue("2.3.7")%>"/><%=retCustInfos.getValue("2.3.7")%>
					</td>
					<td class="blue">���Ź�����</td>
					<td><input type="hidden" name="group_owner" value="<%=retCustInfos.getValue("2.3.4")%>"/><%=retCustInfos.getValue("2.3.4")%></td>
				</tr>
			</table>
		     <%}%>
	     <div id="footer">
	    <input class="b_foot" type="button" value="�ر�" onclick="window.close();"/>
     </div>
<%}else{%> 
<script>
	rdShowMessageDialog("��ѯ�ͻ���ϸ����ʧ��[<%=retCode_0001%>]!");
	window.close();
</script>
<%}%>
<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY>
</HTML>   