<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ͳһԤ������2289
   * �汾: 1.0
   * ����: 2008/12/30
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>ͳһԤ������</title>
<%
    //String opCode="2289";
	//String opName="ͳһԤ������";
	
  String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");	
	String phoneNo = (String)request.getParameter("activePhone");
  String workNo=(String)session.getAttribute("workNo");
  String regionCode=(String)session.getAttribute("regCode");
  String[][] favInfo=(String[][])session.getAttribute("favInfo");
	boolean workNoFlag=false;
	if(workNo.substring(0,1).equals("k"))
		workNoFlag=true;
%>

<%
  String sql = " select  unique sale_type,sale_type||'-->'||trim(sal_name) from sSaleType ";
  System.out.println("sql====="+sql);
%>
	<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="2">
		<wtc:sql><%=sql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="tempArr" scope="end" />
<%
//  String[][] agentCodeStr = (String[][])agentCodeArr.get(0);
%>

  </script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">
  onload=function()
  {
  	var opCode = "<%=opCode%>";
  	if(opCode=="2289"){
		document.all.opFlag[0].checked=true;
		opchange();		
  	}
  	if(opCode=="2293"){
		document.all.opFlag[1].checked=true;  
		opchange();			
  	}
  }

//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
	controlButt(subButton);			//��ʱ���ư�ť�Ŀ�����
//	if(!check(frm)) return false; 
	var radio1 = document.getElementsByName("opFlag");
	for(var i=0;i<radio1.length;i++)
	{
		if(radio1[i].checked)
		{
			var opFlag = radio1[i].value;
			//begin huangrong �޸Ĺ�������"ͳһԤ������Ӫ����ԤԼ����"������ 2010-11-05
			var flag=document.getElementById("flag");
			if(opFlag=="one"||opFlag=="three")
			{
				if(opFlag=="one")
				{
					flag.value='0';
				}else{
					flag.value='1';
				}
				frm.action="f2289_1.jsp";
				document.all.opcode.value="2289";
			
			}else if(opFlag=="two"||opFlag=="four")
			{
				if(opFlag=="two")
				{
					flag.value='0';
				}else{
					flag.value='1';
				}
				//end huangrong �޸Ĺ�������"ͳһԤ������Ӫ����ԤԼ����"������ 2010-11-05
				if(document.all.backaccept.value==""){
					rdShowMessageDialog("������ҵ����ˮ��",1)
					return;
				}
				frm.action="f2293_1.jsp";
				document.all.opcode.value="2293";
			}
		}
  }
	frm.submit();	
	return true;
}
 function controlButt(subButton){
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  }
function opchange(){	
	//begin huangrong �޸Ĺ�������"ͳһԤ������Ӫ����ԤԼ����"������ 2010-11-05
	 if(document.all.opFlag[0].checked==true||document.all.opFlag[2].checked==true) 
	 {	  
	//end huangrong �޸Ĺ�������"ͳһԤ������Ӫ����ԤԼ����"������ 2010-11-05	
	  	document.all.backaccept_id.style.display = "none";
	 }else {
	  	document.all.backaccept_id.style.display = "";	
	  }
}
</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
 	<input type="hidden" name="opcode" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">ѡ���������</div>
	</div>
<table cellspacing="0">
	<tr> 
		<td class="blue" width="20%">��������</td>
		<td>
			<q vType='setNg35Attr'>
			<input type="radio" name="opFlag" value="one" onclick="opchange()"/>����
		</q>
		</td>
		<td>
			<q vType='setNg35Attr'>
			<input type="radio" name="opFlag" value="two" onclick="opchange()"/>����
		</q>
			</td>
			<td>
			<!--begin huangrong �޸Ĺ�������"ͳһԤ������Ӫ����ԤԼ����"������ 2010-11-05-->
			<q vType='setNg35Attr'>
			<input type="radio" name="opFlag" value="three" onclick="opchange()"/>ԤԼ����
		</q>
		</td>
		<td>
			<q vType='setNg35Attr'>
			<input type="radio" name="opFlag" value="four" onclick="opchange()"/>ԤԼ����
		</q>
			<!--end huangrong �޸Ĺ�������"ͳһԤ������Ӫ����ԤԼ����"������ 2010-11-05-->
		</td>
	</tr>    
	<tr> 
		<td class="blue">�ֻ����� </td>
		<td colspan="5"> 
			<input type="text" size="12" name="srv_no" value="<%=activePhone%>" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0" class="InputGrey" readOnly>
			<!--begin huangrong �޸Ĺ�������"ͳһԤ������Ӫ����ԤԼ����"������ 2010-11-05-->
			<input type="hidden" name="flag" id="flag">
			<!--end huangrong �޸Ĺ�������"ͳһԤ������Ӫ����ԤԼ����"������ 2010-11-05-->
				<font color="orange">*</font>
		</td>
	</tr>
	<tr style="display:none" id="backaccept_id"> 
		<td class="blue">ҵ����ˮ</td>
		<td colspan="5">
			<input class="button" type="text" name="backaccept" v_must=1 >
				<font color="orange">*</font>
		</td>
	</tr>    
	<tr> 
		<td colspan="5" align="center" id="footer"> 
			<input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">    
			<input class="b_foot" type=button name=back value="���" onClick="frm.reset()">
			<input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
		</td>
	</tr>
</table>
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
