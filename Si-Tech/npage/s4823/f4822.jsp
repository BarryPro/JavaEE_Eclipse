<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-------------------------------------------->
<!---����:  2008-08-25                    ---->
<!---����:  zhouzy                        ---->
<!---����:  fsalebase.jsp          	  		---->
<!---���ܣ� Ӫ��ִ�з�������              ---->
<!---�޸ģ� wanglei 2008-11-25            ---->
<!-------------------------------------------->

<%request.setCharacterEncoding("GB2312");%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.ArrayList"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String phoneNo=request.getParameter("phoneNo");
	String saleCode=request.getParameter("saleCode");
	String reFlag=request.getParameter("reFlag");

String sql_yetao="";
	String teamId="";
	String sql="";
	System.out.println("reFlag:"+reFlag);
	if(reFlag.equals("0")){
	  sql="select cust_group_id from dbsalesadm.dFndCustomerInfo where phone_no like '%"+phoneNo+"%'";
	  System.out.println("sql:"+sql);
	%>
	 <wtc:pubselect name="sPubSelect" outnum="1">
	    <wtc:sql><%=sql%></wtc:sql>
	  </wtc:pubselect>
	  <wtc:array id="feeStr4" scope="end"/>
	<%
	System.out.println("feeStr4.length:"+feeStr4.length);
	if(feeStr4.length==0){
	%>
	 <script language="JavaScript">
			rdShowMessageDialog("ȡ�ͻ���Ӧ����Ϣ����",0);
			parent.removeTab('4822');
	</script>
	<%
	return;
	}
	teamId=feeStr4[0][0];
	System.out.println("feeStr4[0][0]:"+feeStr4[0][0]);
	}
	sql="select action_name,action_type_name,to_char(PLAN_START_DATE,'yyyymmdd')||'--'||to_char(PLAN_END_DATE,'yyyymmdd'),sale_diction,service_explain_caliber,sale_product_desc,priority_code,action_desc from dbsalesadm.dFndSaleAction where action_id='"+saleCode+"'";
	if(reFlag.equals("0")){
		sql+=" and cust_group_id='"+teamId+"'";
		System.out.println("sql11:"+sql);
	}
	
%>
  <wtc:pubselect name="sPubSelect" outnum="8">
    <wtc:sql><%=sql%></wtc:sql>
  </wtc:pubselect>
  <wtc:array id="feeStr" scope="end"/>
<%
if(feeStr.length==0){
%>
 <script language="JavaScript">
		rdShowMessageDialog("ȡ���Ϣ����",0);
		parent.removeTab('4822');
</script>
<%
return;
}
	sql="select b.cust_name,a.id_no from dcustmsg a,dcustdoc b where a.cust_id=b.cust_id and a.phone_no='"+phoneNo+"'";
%>
  <wtc:pubselect name="sPubSelect" outnum="2">
    <wtc:sql><%=sql%></wtc:sql>
  </wtc:pubselect>
  <wtc:array id="feeStr2" scope="end"/>
<%
if(feeStr2.length==0){
%>
 <script language="JavaScript">
		rdShowMessageDialog("ȡ�ͻ���Ϣ����",0);
		parent.removeTab('4822');
</script>
<%
return;
}
	String opCode="4822";
	String opName="Ӫ������";
	sql=" select b.region_code,b.region_name,a.sm_code from dcustmsg a,sregioncode b where substr(a.belong_code,0,2) = b.region_code and a.phone_no='"+phoneNo+"'";
%>
  <wtc:pubselect name="sPubSelect" outnum="3">
    <wtc:sql><%=sql%></wtc:sql>
  </wtc:pubselect>
  <wtc:array id="feeStr3" scope="end"/>
	<HEAD>
		<TITLE>������BOSS-Ӫ��ִ�з���</TITLE>
		<META content=no-cache http-equiv=Pragma>
		<META content=no-cache http-equiv=Cache-Control>
	</HEAD>
	<BODY bgColor=#FFFFFF leftmargin="0" topmargin="0">
<SCRIPT type=text/javascript>

function getBackInfo() 
{ 
		  url='s4822Check.jsp?phone_no='+document.getElementById("phone_no").value; 
	      if(window.XMLHttpRequest) {xmlhttp_request = new XMLHttpRequest();} 
	      else if(window.ActiveXObject) {xmlhttp_request = new ActiveXObject("Microsoft.XMLHTTP");} 
	      else {return;}	
			xmlhttp_request.onreadystatechange = doContents;
			xmlhttp_request.open('GET', url, true); 
			xmlhttp_request.send(null); 
			return;
} 
function doContents()
{ 
	if (xmlhttp_request.readyState == 4) 
	{ 
		if (xmlhttp_request.status == 200) 
		{ 
		  document.getElementById("CheckResult").innerHTML=xmlhttp_request.responseText;
		} 
		else 
		{alert(xmlhttp_request.status);} 
	}
}
function saveTo()
{
	if(!check(frm)){return false;}
	getBackInfo();
	var flag = document.getElementById("CheckResult").innerHTML;
	if(document.all.select_type.selectedIndex != 0 && flag==0)
	{rdShowMessageDialog("ҵ��δ��ͨ��");}
	else if(document.all.select_type.selectedIndex == 0 && flag==1)
	{rdShowMessageDialog("ҵ���Ѿ���ͨ��");}
	else{
		rdShowMessageDialog("ҵ���뷴����������ϣ�����ѡ���������");
		return false;
		}
	frm.submit();
	
	
	
	
	/*if(parseInt(frm.isPresent.value) == 0){
		if(frm.presentCode.value==""){
			rdShowMessageDialog("��ѡ�����͵���Ʒ");
			return false;
		}
		frm.presentAllCount.value=frm.presentCode.value;
		frm.presentAllCountText.value=frm.presentAllCount.options[frm.presentAllCount.selectedIndex].text;
		
		if(parseInt(frm.presentCount.value)>parseInt(frm.presentAllCountText.value)){
			rdShowMessageDialog("��Ʒ��������,Ŀǰ����"+frm.presentAllCountText.value+"ʣ�࣡",0);
			return false;
		}
	}*/
}
function fisPresent(){
	if(parseInt(frm.isPresent.value)!=0){
		 document.all.isPre.style.display="none";
	}else{
		document.all.isPre.style.display="";
	}
}
function checkSel(){
	if(parseInt(frm.transactCode.value)==0){
		if(frm.resultCode.value!="01"&&frm.resultCode.value!="02"){
			rdShowMessageDialog("����ȷ��д�ͻ������");
			frm.resultCode.value="01";
		}
	}else{
		if(frm.resultCode.value=="01"||frm.resultCode.value=="02"){
			rdShowMessageDialog("����ȷ��д�ͻ������");
			frm.resultCode.value="03";
		}
	}
}	
</SCRIPT>
	<BODY>
			<form name="frm"  method=post action="s4822Cfm.jsp">
		<%@ include file="/npage/include/header.jsp" %>
	</div>

				<div id="Line_Table">
					<div class="title"><div id="title_zi">���Ϣ</div></div>
					<table cellSpacing=5>
						<tr>
							<td width="11%" class="Blue">
								�����
							</td>
							<td width="22%">
								<%=feeStr[0][0]%>
							</td>
							<td width="11%" class="Blue">
								���������
							</td>
							<td width="22%">
								<%=feeStr[0][1]%>
							</td>
							<td width="11%" class="Blue">
								�ʱ��
							</td>
							<td width="23%">
								<%=feeStr[0][2]%>
							</td>
						</tr>
						<tr>
							<td class="Blue">
								�����
							</td>
							<td width="22%">
								<%=feeStr[0][7]%>&nbsp;
							</td>
							<td class="Blue">
								����Ͷ�߽���
							</td>
							<td>
								<%=feeStr[0][4]%>&nbsp;
							</td>
							<!--<td class="Blue">
								����Ʒ
							</td>
							<td>
								<%for(int i=0;i<feeStr.length;i++){%>
									<%=feeStr[i][5]%>&nbsp;
								<%}%>
							</td>-->
							<td>.&nbsp;</td>
							<td>.&nbsp;</td>
							
						</tr>
						<tr>
						<td class="Blue">
								Ӫ������
							</td>
							<td colspan=5>
								<%=feeStr[0][3]%>&nbsp;
							</td>
						</tr>
					</table>
				</div>
 <div id="Operation_Table"> 
 <div class="title"><div id="title_zi">�ͻ���Ϣ</div></div>
 <table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td class="Blue">
								�ͻ�����
							</td>
							<td>
								<input type="text" name="phoneNo" id="phone_no" value="<%=phoneNo%>" readOnly>
							</td>
							<td class="Blue">
								�ͻ�����
							</td>
							<td>
								<input type="text" name="custName" value="<%=feeStr2[0][0]%>" readOnly>
							</td>
							<td class="Blue">
								�ͻ�����
							</td>
							<td>
								<input type="text" value="<%=feeStr3[0][1]%>" readOnly>
							</td>
							</tr>
						<tr>
							<td class="Blue">
								�Ƿ񵱳�����
							</td>
							<td>
								<select name="transactCode" onchange="checkSel()">
									<%String sqlStr ="select is_transact_code,is_transact_name from dbsalesadm.sFndISTransact";%>
									 <wtc:qoption name="sPubSelect" outnum="2">
										 <wtc:sql><%=sqlStr%></wtc:sql>
									 </wtc:qoption>
								</select>
								<font class="orange">*</font>
							</td>
							<td class="Blue">
								�ͻ��������
							</td>
							<td>
								<select name="resultCode" onchange="checkSel()" id="select_type">
									 <%sqlStr ="select back_result_code,back_result_name from dbsalesadm.sFndBackResult";%>
									 <wtc:qoption name="sPubSelect" outnum="2">
										 <wtc:sql><%=sqlStr%></wtc:sql>
									 </wtc:qoption> 
								</select>
								<font class="orange">*</font>
							</td>
							<!-- <td class="Blue">
								�Ƿ�������Ʒ
							</td>
							<td>
								<select name="isPresent" onchange="fisPresent()">
									 <option value="1">��</option>
									 <option value="0">��</option> 
								</select>
							</td>-->
							<td colspan="2">&nbsp;</td>
						  

						<tr id="isPre" style="display:none">
							<td class="Blue">
								��Ʒ����
							</td>
							<td>
							   <select name="presentCode">
							   	<option value="">��</option>
									 <%sqlStr ="select present_id,present_name from dbsalesadm.dFndlPresent";%>
									 <wtc:qoption name="sPubSelect" outnum="2">
										 <wtc:sql><%=sqlStr%></wtc:sql>
									 </wtc:qoption> 
								</select>
							</td>
							<td style="display:none">
							   <select name="presentAllCount">
									 <%sqlStr ="select present_id,present_count from dbsalesadm.dFndlPresent";%>
									 <wtc:qoption name="sPubSelect" outnum="2">
										 <wtc:sql><%=sqlStr%></wtc:sql>
									 </wtc:qoption> 
								</select>
							</td>
							<td class="Blue">
								��Ʒ����
							</td>
							<td>
								<input type="text" name="presentCount" value="" v_type="0_9"  v_must="0" onblur="checkElement(this)">
							</td>
							<td class="Blue">
								��������
							</td>
							<td>
								<input type="text" name="otherCount" value="" v_type="cfloat"  v_must="0" onblur="checkElement(this)">
								<font class="orange">(Ԫ)</font>
							</td>
						</tr>
						
						<tr>
							<td class="Blue">
								�ͻ�������Ϣ
							</td>
							<td colspan=5>
								<input type="text" name="feedbackInfo" value="" size=60>
							</td>
						</tr>
						<tr>
							<td class="Blue">
								��ע
							</td>
							<td colspan=5>
								<input type="text" name="backInfo" value="" size=60>
							</td>
						</tr>
					</TABLE>
				<table width="100%" border="0" cellpadding="0" cellspacing="0">	
						<tr>
							<TD align="center" id="footer">
									<input class="b_foot" name=commit onClick="saveTo()" type=button value=�ύ>
									&nbsp;
							</TD>
					 </tr>
				</table>
				  <input type="hidden" id="CheckResult"/>
				  
				  <input type="hidden" name="activeId" value="<%=saleCode%>">
					<input type="hidden" name="reFlag" value="<%=reFlag%>">
					<input type="hidden" name="teamId" value="<%=teamId%>">
					<input type="hidden" name="regionCode" value="<%=feeStr3[0][0]%>">
					<input type="hidden" name="idNo" value="<%=feeStr2[0][1]%>">
					<input type="hidden" name="conFlag" value="0">
					<input type="hidden" name="backFail" value="">
					<input type="hidden" name="presentAllCountText" value="0">
<%
if(reFlag.equals("0"))
{
	sql="select commend_busi_type,commend_busi_code,main_fee_flag from dbsalesadm.dFndActCommendRel where action_id='"+saleCode+"' and cust_group_id='"+teamId+"' order by commend_busi_type asc";
	System.out.println(sql);
%>
<wtc:pubselect name="sPubSelect" outnum="3">
   <wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="commendResult" scope="end"/>
	
</div>	
<div id="Operation_Table"> 
 <div class="title"><div id="title_zi">�ҵ����ϸ</div></div>
 <table width="100%" border="0" cellpadding="0" cellspacing="0">
 	<tr>
 		<th>�Ƽ�ҵ������</th>
	 	<th>�����</th>
	 	<th>ҵ������</th>
	 	<th>ҵ������</th>
	 	<th>��ͨ</th>
	  </tr>
<%

for(int i=0;i<commendResult.length;i++)
	{
	  System.out.println("commend_busi_type"+commendResult[i][0]+"@@@@@@@@@@");
		System.out.println("commend_busi_code"+commendResult[i][1]+"@@@@@@@@@@");
		System.out.println("main_fee_flag"+commendResult[i][2]+"@@@@@@@@@@");
		if(commendResult[i][0].trim().equals("1"))
		{
		
		for(int j=0;j<commendResult[i][1].trim().split("&").length;j++)
		{
			sql="select function_name from sfunclist where function_code='"+commendResult[i][1].trim().split("&")[j]+"' and region_code='"+feeStr3[0][0]+"' and sm_code='"+feeStr3[0][2]+"'";
%>
<wtc:pubselect name="sPubSelect" outnum="1">
		<wtc:sql><%=sql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="clistResult" scope="end"/>
		
<%	
	String clistFlag="δ֪";
	if(clistResult.length>0)
	{
		clistFlag=clistResult[0][0];
	}
%>
	<tr>
		<%
		if("1".equals(commendResult[i][2]))
		{
		%>
		<td style="color:red">���ʷ�</td>
		<td style="color:red"><%=feeStr[0][0]%></td>
	 	<td style="color:red"><%=clistFlag%></td>
	 	<td style="color:red">�ط�</td>
	 	<td><input type="button" class="b_text" value="��ͨ���ʷ�" onclick="parent.parent.openPage('2','1219','�ط����','s1210/s1219Login.jsp','000')"></td>
		<%}else{%>
		<td>���ʷ�</td>
		<td><%=feeStr[0][0]%></td>
	 	<td><%=clistFlag%></td>
	 	<td>�ط�</td>
	 	<td><input type="button" class="b_text" value="��ͨ���ʷ�" onclick="parent.parent.openPage('2','1219','�ط����','s1210/s1219Login.jsp','000')"></td>
		<%}%>
	 	</tr>
<%
	}
		}
		else if(commendResult[i][0].trim().equals("2"))
			{
				/**/
				
				for(int j=0;j<commendResult[i][1].trim().split("&").length;j++)
				{
					System.out.println("wanglei======="+commendResult[i][1].trim().split("&")[j]);
					sql="select mode_name from sbillmodecode where mode_code='"
					+commendResult[i][1].trim().split("&")[j]+"' and region_code='"+feeStr3[0][0]+"'";
					System.out.println("want to * "+sql);
%>

	
<wtc:pubselect name="sPubSelect" outnum="1">
   <wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="modeResult" scope="end"/>	
<%
	String modeFlag="δ֪";
	if(modeResult.length>0)
	{
		modeFlag=modeResult[0][0];
	}
  
%>

	<tr>
		<%
		if("1".equals(commendResult[i][2]))
		{
		%>
		<td style="color:red">���ʷ�</td>
		<td style="color:red"><%=feeStr[0][0]%></td>
	 	<td style="color:red"><%=modeFlag%></td>
	 	<td style="color:red">�ײ�</td>
	 	<td><input type="button" class="b_text" value="��ͨ���ʷ�" onclick="parent.parent.openPage('2','1272','��ѡ�ʷѱ��','change/f1272_2.jsp','000')"></td>
		<%}else{%>
		<td>���ʷ�</td>
		<td><%=feeStr[0][0]%></td>
	 	<td><%=modeFlag%></td>
	 	<td>�ײ�</td>
	 	<td><input type="button" class="b_text" value="��ͨ���ʷ�" onclick="parent.parent.openPage('2','1272','��ѡ�ʷѱ��','change/f1272_2.jsp','000')"></td>
		
		<%}%>
	 	
	 </tr>
<%
	}
		}
		else if(commendResult[i][0].trim().equals("3"))
			{
				for(int j=0;j<commendResult[i][1].trim().split("&").length;j++){
				sql="select mode_name from sbillmodecode where mode_code='"
				+commendResult[i][1].trim().split("&")[j]+"' and region_code='"+feeStr3[0][0]+"'";
%>
<wtc:pubselect name="sPubSelect" outnum="1">
   <wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="modeResult" scope="end"/>	
<%
	String modeFlag="δ֪";
	if(modeResult.length>0)
	{
		modeFlag=modeResult[0][0];
	}
%>
	<tr >
		<%
		if("1".equals(commendResult[i][2]))
		{
		%>
		<td style="color:red">���ʷ�</td>
		<td style="color:red"><%=feeStr[0][0]%></td>
	 	<td style="color:red"><%=modeFlag%></td>
	 	<td style="color:red">�ײ�</td>
	 	<td><input type="button" class="b_text" value="��ͨ���ʷ�" onclick="parent.parent.openPage('2','1272','��ѡ�ʷѱ��','change/f1272_2.jsp','000')"></td>
		<%}else{%>
		<td>���ʷ�</td>
		<td><%=feeStr[0][0]%></td>
	 	<td><%=modeFlag%></td>
	 	<td>�ײ�</td>
	 	<td><input type="button" class="b_text" value="��ͨ���ʷ�" onclick="parent.parent.openPage('2','1272','��ѡ�ʷѱ��','change/f1272_2.jsp','000')"></td>
		<%}%>
	 	</tr>
	 <%
	 }
}
}
}
%>

<%@ include file="/npage/include/footer.jsp" %>	
	</form>
	</body>
</html>