<%
/********************
 version v2.0
 ������: si-tech
 update sunaj at 2009.9.16
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
<title>��TD����̻���ͨ�ŷ�</title>
<%

    String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    String phoneNo = request.getParameter("activePhone");
    String PhoneHead = phoneNo.substring(0, 3);
    String count="";
    /*
    String sqlStr="select count(*) from dgrpmemberusermsg a,dgrpusermsg b,dcustmsg c  "+
				  " where a.id_no=b.id_no and b.sm_code='TG'    "+
				  "and a.member_id=c.id_no and c.phone_no='"+phoneNo+"'";
				  */
	 String sqlStr = "select count(1)  from group_instance_member a, product_offer_instance b, dgrpusermsg c, dcustmsg d where a.group_id = b.group_id " +
    				" and b.serv_id = c.id_no   and c.sm_code = 'TG'  and a.serv_id = d.id_no   and d.phone_no ='"+phoneNo+"'";
%>

<wtc:pubselect name="sPubSelect" outnum="1"  routerKey="phone" retcode="retCode2" retmsg="retMsg2" routerValue="<%=phoneNo%>">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="retArray" scope="end"/>
<%
	System.out.println("--sql=" + sqlStr);
	if(retArray!=null&& retArray.length > 0)
	{
		count = retArray[0][0];
	}
%>
<%  String num="";
/*
	String SqlStr="select count(*) from dvpmnusrmsg a,dcustmsg b where a.id_no=b.id_no and b.phone_no='"+phoneNo+"'";
	*/
	String SqlStr = "select count(1) from group_instance_member a, dcustmsg b where a.serv_id = b.id_no and b.phone_no = '"+phoneNo+"' and a.member_role_id = 10335";
%>
<wtc:pubselect name="sPubSelect" outnum="1"  routerKey="phone" retcode="retCode1" retmsg="retMsg1" routerValue="<%=phoneNo%>">
	<wtc:sql><%=SqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="retArray1" scope="end"/>
<%
	System.out.println("--sql=" + sqlStr);
	if(retArray1!=null && retArray1.length > 0)
	{
		num = retArray1[0][0];
	}
%>
<%  String number="";
	/*String sqlstr="select count(*)  from dvpmnusrmsg a,dcustmsg b ,svpmnpkgcodetglimit c where a.id_no=b.id_no  "+
                  "and substr(b.belong_code,1,2)=c.region_code and (a.curpkgtype!=c.pkg_code or a.pkgtype!=c.pkg_code) and b.phone_no='"+phoneNo+"'";
                  */

   String sqlstr = "SELECT COUNT (1) FROM dcustmsgadd a, dcustmsg b, svpmnpkgcodetglimit c ,svpmnpkgcodetglimit d,dcustmsgadd e "+
					"WHERE a.id_no = b.id_no and b.id_no=e.id_no AND SUBSTR (b.belong_code, 1, 2) = c.region_code               "+
					"and SUBSTR (b.belong_code, 1, 2) =d.region_code AND a.field_code ='80003' and trim(a.field_value) = trim(c.pkg_code) "+
           			"and e.field_code = '80004' and trim(e.field_value) = trim(d.pkg_code) AND b.phone_no ='"+phoneNo+"'";
%>
<wtc:pubselect name="sPubSelect" outnum="1"  routerKey="phone" retcode="retCode1" retmsg="retMsg1" routerValue="<%=phoneNo%>">
	<wtc:sql><%=sqlstr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="retArray2" scope="end"/>
<%
	System.out.println("--sql=" + sqlStr);
	if(retArray2!=null && retArray2.length > 0)
	{
		number = retArray2[0][0];
	}
%>
<%  String number1="";
	String sql_str="select count(*) from wphonesaleopr a,dcustmsg b where a.id_no=b.id_no and a.back_flag in ('0','2')  "+
				  "and a.op_code='g122' and b.phone_no='"+phoneNo+"'";
%>
<wtc:pubselect name="sPubSelect" outnum="1"  routerKey="phone" retcode="retCode1" retmsg="retMsg1" routerValue="<%=phoneNo%>">
	<wtc:sql><%=sql_str%></wtc:sql>
</wtc:pubselect>
<wtc:array id="retArray3" scope="end"/>
<%
	System.out.println("--sql=" + sqlStr);
	if(retArray3!=null && retArray3.length > 0)
	{
		number1 = retArray3[0][0];
	}
%> 
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
    if(opCode=="g123"){
    	document.all.opFlag[1].checked=true;
    }
    opchange();
  }

 function controlButt(subButton){
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  }


//----------------��֤���ύ����-----------------
function doCfm(subButton)
{
	var phoneHead = <%=PhoneHead%>;
  	
  //==================weigp

  if(phoneHead !='157'){
  		if(phoneHead == '147'){
  			check147SuperTD("<%=phoneNo%>");
  		}
  		if(flagTD == "false"){
  			rdShowMessageDialog("147�Ŷ�ֻ��TD����������ܰ����ҵ��");
  			return false;
 		}
 		else if(phoneHead !='147' )
      	{
			rdShowMessageDialog("ֻ��157 �Ŷκ�147�Ŷ�TD����������ܰ����ҵ��");
  			return false;
      	}  
  }
  //====================
  	if("<%=count%>" <= 0 )
  	{
  		rdShowMessageDialog("���û�����TD����̻���Ʒ���û������ܰ����ҵ��!");
  		return false;
	}

	if("<%=num%>" > 0)
  	{
  		if("<%=number%>" <= 0 )
  		{
  			rdShowMessageDialog("TD����̻��û�ֻ����ʹ�ù涨�������������ʷѣ����û��������ʷѲ�����ҵ��涨!");
  			return false;
  		}
  	}
  	
	controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
	var radio1 = document.getElementsByName("opFlag");
  for(var i=0;i<radio1.length;i++)
  {
	if(radio1[i].checked)
	{
	  var opFlag = radio1[i].value;
	  if(opFlag=="one")
	  {     
	    	frm.action="fg122_1.jsp";
	    	document.all.opcode.value="g122";
	  }else if(opFlag=="two")
	  {
	    if(document.all.backaccept.value==""){
	    	rdShowMessageDialog("������ҵ����ˮ��");
	    	return;
	    }
	    	frm.action="fg123_1.jsp";
	    	document.all.opcode.value="g123";
	  }
	
	 /*else if(opFlag=="three")
	  {
	  		if("<%=number1%>" <= 0)
  			{
  				rdShowMessageDialog("�û�û�а������Ӫ�������ѳ����������������ʷѱ��!");
  				return false;
  			}
	    	frm.action="f8687_1.jsp";
	    	document.all.opcode.value="8687";
	  }*/
	}
  }
  frm.submit();
  return true;
}
function opchange(){
	 if(document.all.opFlag[0].checked==true)
	  {
			document.all.backaccept_id.style.display = "none";
	  }
	  else if(document.all.opFlag[1].checked==true)
	  {
			document.all.backaccept_id.style.display = "";
	  }
	  else if(document.all.opFlag[2].checked==true)
	  {
			document.all.backaccept_id.style.display = "none";
	  }
}

//============weigp
function check147SuperTD(phoneNo){
		var phoneHead = phoneNo.substring(0,3);
		var check_Packet = new AJAXPacket("check147SuperTD.jsp","���ڽ���У�飬���Ժ�......");
		check_Packet.data.add("phoneNo",phoneNo);
		core.ajax.sendPacket(check_Packet,getResult);
		check_Packet=null;
}
var flagTD = "true";
function getResult(packet){
	var result=packet.data.findValueByName("result");
	if("false"==result){
		//rdShowMessageDialog("147�Ŷ�ֻ��TD����������ܰ����ҵ��");
		//return false;
		flagTD = "false";
	}else{
		flagTD = "true";
	}
}
//============
</script>
</head>
<body>

<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table cellspacing="0">
	<tr>
		<TD class="blue">��������</TD>
		<TD>
			<input type="hidden" name="opFlag" value="one" onclick="opchange()"  >
			<input type="radio" name="opFlag" value="two" onclick="opchange()" checked>����&nbsp;&nbsp;
			<!--<input type="radio" name="opFlag" value="three" onclick="opchange()" >TD����̻����ʷѱ��-->
		</TD>
			<input type="hidden" name="opcode" >
	</tr>
	<tr>
		<td class="blue">
		<div align="left">�ֻ�����</div>
		</td>
		<td>
		<div align="left">
			<input class="InputGrey"  type="text" name="srv_no" id="srv_no" value="<%=phoneNo%>" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 index="0">
		</td>
	</tr>
	<tr  id="backaccept_id">
		<TD class="blue">ҵ����ˮ</TD>
 		<TD>
			<input type="text" name="backaccept" v_must=1 >
			<font color="orange">*</font>
		</TD>
	</TR>
	<TR>
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
<input type="hidden" name="iOpCode" value="<%=opCode%>">
 <%@ include file="/npage/include/footer_simple.jsp" %>
   </form>

</body>
</html>