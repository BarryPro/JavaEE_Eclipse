<%
/********************
 version v2.0
������: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">	
	
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  request.setCharacterEncoding("GBK");
%>

<head>
<title>���ſͻ�Ԥ������</title>
<%
	String opCode = (String)request.getParameter("opCode");
	String opName="���ſͻ�Ԥ������";	
	
	String work_no = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String org_Code = (String)session.getAttribute("orgCode");
	
	String[][] temfavStr = (String[][])session.getAttribute("favInfo");
	String[] favStr=new String[temfavStr.length];
	for(int i=0;i<favStr.length;i++)
		favStr[i]=temfavStr[i][0].trim();
	boolean pwrf=false;
	if(WtcUtil.haveStr(favStr,"a272"))
		pwrf=true;
	/*
	comImpl co=new comImpl();
  String[][]high = new String [][]{};
  String SqlStr1 = "select count(*) from shighlogin where op_code ='8023' and login_no ='" + work_no +"'" ;
  System.out.println(SqlStr1);
  ArrayList arrhig = co.spubqry32("1", SqlStr1);
  if(arrhig.size() != 0)
  {
  	high = (String[][])arrhig.get(0); 
  	System.out.println("power="+high[0][0]);
  }
  */
  String high = "";
  String SqlStr1 = "select count(*) from shighlogin where op_code ='8023' and login_no ='" + work_no +"'" ;
  
%>

<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=activePhone%>" outnum="1">
	<wtc:sql><%=SqlStr1%></wtc:sql>
	<wtc:param value="<%=work_no%>"/>
</wtc:pubselect>
<wtc:array id="arrhig" scope="end"/>
<%
if(arrhig.length != 0)
{
	high = arrhig[0][0]; 
	System.out.println("power="+high);
}
%>

<script language=javascript>
	onload=function()
  {
    if("<%=opCode%>" == "h024"){
       
        
    }else{
        
        
    }
    opchange();
  }

//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
	var radio1 = document.getElementsByName("opFlag");
	
	/*if(<%=high%> ==0){
		rdShowMessageDialog("�˹���û�в���Ȩ�ޣ�");
		return;
	}*/
	for(var i=0;i<radio1.length;i++)
	{
		if(radio1[i].checked)
		{
			var opFlag = radio1[i].value;
			if(opFlag=="one")
			{			
				frm.action="f8023_1.jsp";
				document.all.opcode.value="8023";			
			}else if(opFlag=="two"){
				if(document.all.backaccept.value==""){
					rdShowMessageDialog("������ҵ����ˮ��");
					return;
				}
			frm.action="f8024_1.jsp";
			document.all.opcode.value="8024";			
			}
		}
	}
	
	frm.submit();	
	return true;
}
function opchange(){	
	
		document.all.backaccept_id.style.display = "";
	
}
</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">Ԥ�滰������</div>
	</div>
	<table cellspacing="0">
		<TR > 
			<TD class="blue">��������</TD>
			<TD colspan="3">
		
			<input type="radio" name="opFlag" value="two" onclick="opchange()" checked>����
			</TD>
			<input type="hidden" name="opcode" >
		</TR>    
		<tr> 
			<td class="blue"> 
			<div align="left">�������</div>
			</td>
			<td colspan="3"> 
			<div align="left">
			<input class="InputGrey"  type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone"  v_name="�������" maxlength="11" index="0" value="<%=activePhone%>">
			</div>
			</td>
		</tr>
		<TR  style="display:none" id="backaccept_id"> 
			<TD class="blue">ҵ����ˮ</TD>
			<TD colspan="3">
			<input class="button" type="text" name="backaccept" v_must=1 >
			<font class="orange">*</font>
			</TD>
		</TR> 
		<tr>   
		<td class=Lable  nowrap colspan="4">&nbsp;</td>
		</tr>
		<tr> 
			<td colspan="4" id="footer"> 
			<div align="center"> 
			<input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">    
			<input class="b_foot" type=button name=back value="���" onClick="frm.reset()">
			<input class="b_foot" type=button name=qryP value="�ر�" onClick="parent.removeTab('<%=opCode%>');">
			</div>
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
</form>
</body>
</html>