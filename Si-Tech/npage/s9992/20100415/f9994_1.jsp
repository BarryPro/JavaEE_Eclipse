<%
/********************
 version v2.0
 ������: si-tech
 ����: dujl
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%
  request.setCharacterEncoding("GBK");
%>
<html>
<head>
<title>�ֻ�֧�����˻��ֽ��ֵ</title>
<%
	
//    String opCode = "9994";
//    String opName = "�ֻ�֧�����˻��ֽ��ֵ";
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
    String phoneNo = request.getParameter("activePhone");
    String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
    
    StringBuffer sql = new StringBuffer();
    sql.append(" select phone_no,pay_ed,login_accept from sphonepaymsg ");
    sql.append(" where op_date=to_char(sysdate,'yyyymmdd') and flag='0'");
    System.out.println("sql=========="+sql);
%>

<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="3">
<wtc:sql><%=sql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />

</script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
onload=function()
{
	var phoneNo = "<%=phoneNo%>";
	if(phoneNo==null||phoneNo=="")
	removeCurrentTab();
	var opCode = "<%=opCode%>";
	if(opCode=="9994")
	{
		document.all.opFlag[0].checked=true;	
	}else if(opCode=="9995")
	{
		document.all.opFlag[1].checked=true;
	} 
	opchange();
}

function controlButt(subButton)
{
	subButt2 = subButton;
	subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
}


//----------------��֤���ύ����-----------------
function check_HidPwd()
{
	if(document.frm.phoneNo.value=="")
	{
		 rdShowMessageDialog("�������ֻ�����!");
		 document.frm.phoneNo.focus();
		 return false;
	}

  	if( document.frm.phoneNo.value.length != 11 )
  	{
		rdShowMessageDialog("�ֻ�����ֻ����11λ!");
		document.frm.phoneNo.value = "";
		return false;
  	}
}

function doCfm(subButton)
{
	
  	controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
  	var radio1 = document.getElementsByName("opFlag");
  	for(var i=0;i<radio1.length;i++)
  	{
    	if(radio1[i].checked)
		{
	  		var opFlag = radio1[i].value;
	  		if(opFlag=="one")
	  		{
	    		if(document.frm.phoneNo.value=="")
			  	{
				     rdShowMessageDialog("�������ֻ�����!");
				     document.frm.phoneNo.focus();
				     return false;
			  	}
			  	
			  	if(document.frm.payEd.value=="")
			  	{
				     rdShowMessageDialog("�������ֵ���!");
				     document.frm.payEd.focus();
				     return false;
			  	}
			
			  	if( document.frm.phoneNo.value.length != 11 )
			  	{
				     rdShowMessageDialog("�ֻ�����ֻ����11λ!");
				     document.frm.phoneNo.value = "";
				     return false;
			  	}
	    		
	    		frm.action="f9994Cfm.jsp";
	    		document.all.opcode.value="9994";
		  	}
		  	else if(opFlag=="two")
		  	{
	    		if(document.frm.phoneNoPayEd.value=="")
	    		{
	    			rdShowMessageDialog("�����������Ϣ��");
				     document.frm.phoneNoPayEd.focus();
				     return false;
	    		}
	    		
	    		frm.action="f9995Cfm.jsp";
	    		document.all.opcode.value="9995";
		  	}
		}
 	}
  	
  	frm.submit();
}

function opchange()
{
	if(document.all.opFlag[0].checked==true) 
	{
		document.all.zhi.style.display="";
		document.all.zhi1.style.display="";
		document.all.zheng.style.display="none";
	}else 
	{
		document.all.zhi.style.display="none";
		document.all.zhi1.style.display="none";
		document.all.zheng.style.display="";
	}
}


</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %> 	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
      <table cellspacing="0">
	  <TR> 
		<TD class="blue" width="20%">��������</TD>
		<TD>
			<input type="radio" name="opFlag" value="one" onclick="opchange()" checked >��ֵ&nbsp;&nbsp;
			<input type="radio" name="opFlag" value="two" onclick="opchange()">����
		</TD>
		      <input type="hidden" name="opcode" >
         </TR>
         <tr id="zhi">
            <td class="blue" width="20%">�ֻ�����</div></td>
            <td> 
        		<input class="button"type="text" name="phoneNo" size="20" maxlength="11"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
      		</td>
         </tr>
         <TR id="zhi1">
	          <TD class="blue" width="20%">��ֵ��Ԫ��</TD>
	          <TD>
				<input class="button"type="text" name="payEd" size="20" maxlength="14" onKeyPress="return isKeyNumberdot(1)" onKeyDown="if(event.keyCode==13) doprint();">
	         </TD>
         </TR>
         <tr id="zheng">
         	<td class="blue" width="20%">������Ϣ</td>
         	<td>
         		<select class="button" type="select" name="phoneNoPayEd">
         			<option value="">--��ѡ��--</option>
         			<%
         			for(int i=0;i<result.length;i++)
         			{
         			%>
         				<option value="<%=result[i][0]%>~<%=result[i][1]%>~<%=result[i][2]%>"><%=result[i][0]%>--><%=result[i][1]%>--><%=result[i][2]%></option>
         			<%
         			}
         			%>
         		</select>
         	</td>
         </tr>
         
         <tr> 
            <td colspan="2" id="footer"> 
              <div align="center"> 
              <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="doCfm(this)" index="2">    
              <input class="b_foot" type=button name=back value="���" onClick="frm.reset()">
		      <input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
              </div>
           </td>
        </tr>
      </table>
   
<input type="hidden" name="opCode" value="<%=opCode%>" >
<input type="hidden" name="opName" value="<%=opName%>" >
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
   
</body>
</html>

