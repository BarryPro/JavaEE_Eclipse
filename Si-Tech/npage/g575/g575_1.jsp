<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-07
 ********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="java.util.*"%>
<%@ include file="../../npage/common/pwd_comm.jsp" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
 <%
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arr.get(0);
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String nopass = (String)session.getAttribute("password");	
	String orgCode = (String)session.getAttribute("orgCode");
    String opCode = "g575";   
    String opName = "�������ɷѲ�ѯ";
    
    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String[] mon = new String[6] ;

    Calendar cal = Calendar.getInstance(Locale.getDefault());
	cal.set(Integer.parseInt(dateStr.substring(0,4)),
                      (Integer.parseInt(dateStr.substring(4,6)) - 1),Integer.parseInt(dateStr.substring(6,8)));
	for(int i=0;i<=5;i++)
      {
              if(i!=5)
              {
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
                cal.add(Calendar.MONTH,-1);
              }
              else
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
      }        
                                              
      boolean pwrf = false;                                        
	  String pubOpCode ="1231";
	//  pwrf = true;  
%>
<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>������Ϣ��ѯ</TITLE>
</HEAD>

<body>
<SCRIPT language="JavaScript">
function doCheck2()
{
    
	if (!<%=pwrf%>)//������Ȩ�� ��Ҫ��������
	{
	//	alert(<%=pwrf%>);
		if (document.getElementById("cus_pass").value == "") 
		{
			rdShowMessageDialog("�������û�����", 1);
			return;
		}
		else
		{
			var checkPwd_Packet = new AJAXPacket("pubCheckPwd_wlw.jsp","���ڽ�������У�飬���Ժ�......");
			//dcustmsgdead������У�� ���ҳ����ܵû�
			checkPwd_Packet.data.add("custType", "01");						//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
			checkPwd_Packet.data.add("phoneNo", document.frm1527.phoneNo.value);		//�ƶ�����,�ͻ�id,�ʻ�id
			checkPwd_Packet.data.add("custPaswd", document.getElementById("cus_pass").value);//�û�.�ͻ�.�ʻ�����
			checkPwd_Packet.data.add("idType", "");							//en ����Ϊ���ģ�������� ����Ϊ����
			checkPwd_Packet.data.add("idNum", "");							//����
			checkPwd_Packet.data.add("loginNo", "<%=workNo%>");				//����
			core.ajax.sendPacket(checkPwd_Packet, doCheckPwd);
			checkPwd_Packet=null;
		}
	}
	else
	{
		var h=480;
		var w=650;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight "+300+"px; dialogWidth "+500+"px; dialogLeft "+l+"px; dialogTop "+t+"px;toolbar no; menubar no; scrollbars yes; resizable no;location no;status no";
		var str = window.showModalDialog('getCount.jsp?phoneNo='+document.frm1527.phoneNo.value,"",prop);
		alert(str);
		if(str == null ){
		   rdShowMessageDialog("�˺���û���ҵ���Ӧ���ʺţ�");
		   document.frm1527.contractNo.value="";
		   document.frm1527.phoneNo.focus();
		   return false;
		} 
		
		if(str.length == 0) {
			rdShowMessageDialog("��û��ѡ���Ӧ���ʺţ�" );
			document.frm1527.contractNo.value="";
			document.frm1527.phoneNo.focus();
			return false;
		 }
		// var s_run_code =  str[3];
		 var s_run_code =  "a";
	 //    alert("11 :"+s_run_code);
		 if(s_run_code=="s")
		 {
			rdShowMessageDialog("�û���ǰ״̬�������ѯ�ɷ���ʷ��Ϣ!" );
			return false;
		 }
		 else
		 {
			 document.frm1527.contractNo.value = str[0];
			 document.frm1527.userType.value = str[1];
			 document.frm1527.newPhone.value = str[2];
			 // ����hidden ������������
			 document.getElementById("doQuery").disabled=false;
			 return true;
		 }
		 
	}
	
}
 

function doCheckPwd(packet) 
{
		var retResult = packet.data.findValueByName("retResult");
		var msg = packet.data.findValueByName("msg");
		//alert("here? "+retResult+"msg is "+msg);
		if (retResult != "000000") {
			rdShowMessageDialog(msg);
			pwdIsRight = "0";
		} 
		else 
		{
			var h=480;
			var w=650;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight "+300+"px; dialogWidth "+500+"px; dialogLeft "+l+"px; dialogTop "+t+"px;toolbar no; menubar no; scrollbars yes; resizable no;location no;status no";
			//alert("document.frm1527.phoneNo.value is"+document.frm1527.phoneNo.value);
			var str = window.showModalDialog('getCount.jsp?phoneNo='+document.frm1527.phoneNo.value,"",prop);
			//alert(str);
			if(str == null ){
			   rdShowMessageDialog("�˺���û���ҵ���Ӧ���ʺţ�");
			   document.frm1527.contractNo.value="";
			   document.frm1527.phoneNo.focus();
			   return false;
			} 
			
			if(str.length == 0) {
				rdShowMessageDialog("��û��ѡ���Ӧ���ʺţ�" );
				document.frm1527.contractNo.value="";
				document.frm1527.phoneNo.focus();
				return false;
			 }
			 var s_run_code =  str.split(",")[3];
			 //alert(s_run_code);
			 if(s_run_code=="s")
			 {
				rdShowMessageDialog("�û���ǰ״̬�������ѯ�ɷ���ʷ��Ϣ!" );
				return false;
			 }
			 else
			 {
				 document.frm1527.contractNo.value = str.split(",")[0];
				 document.frm1527.userType.value = str.split(",")[1];
				 document.frm1527.newPhone.value = str.split(",")[2];
				 document.getElementById("doQuery").disabled=false;
				 return true;
			 } 	
			 
		}
	
		 
	
}	
	
function doCheck()
{	
	  var decmonth = document.frm1527.endTime.value.substring(2,6)- document.frm1527.beginTime.value.substring(2,6); 
	
    var otherFlag = document.frm1527.otherFlag[document.frm1527.otherFlag.selectedIndex].value;
    //if (otherFlag == 0) {
      /* if( document.frm1527.phoneNo.value.length<11) 
	   {	
		  rdShowMessageDialog("�������ѯ������룡");
		  document.frm1527.phoneNo.select();
		  return false;
	    }
		*/
	//}
   
 	if( document.frm1527.contractNo.value=="") 
	{	
		rdShowMessageDialog("�������ѯ�ʺţ�");
		document.frm1527.phoneNo.select();
		return false;
	}

  if ( document.frm1527.beginTime.value >= '200201'&& (  ( 0 <= decmonth && decmonth<= 5 ) || ( 89 <= decmonth && decmonth<= 93 ) ))
	{
			document.frm1527.action="g575_2.jsp";
			document.frm1527.conPass.value = document.all.cus_pass.value;
			frm1527.submit();
	}	
	else	
	{
			rdShowMessageDialog("ֻ�ܲ�ѯ��ʼʱ��ͽ���ʱ��Ϊ�������ڣ���ʱ�����2002��1�µ����ݣ�");
			return false;
	}
  
	return true;
}

function query()
{
	 if(!doCheck())
		 return false;

	 return true;
}

function changsearchtype() {
   var otherFlag = document.frm1527.otherFlag[document.frm1527.otherFlag.selectedIndex].value;
   if (otherFlag == 0) {
      document.frm1527.contractNo.readOnly = true;
   } else if (otherFlag == 1){
      document.frm1527.contractNo.readOnly = false;
   }
}
</SCRIPT>

<FORM method=post name="frm1527" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">������Ϣ��ѯ</div>
</div>
<input type="hidden" name="opCode"  value="1528">
<input type="hidden" name="userType"  value="0">
<input type="hidden" name="conPass" >

<TABLE cellSpacing=0>
    <TR> 
        <TD class=blue>��ѯ��ʽ</TD>
        <TD>
            <select size="1" name="otherFlag" onchange="changsearchtype()">
                <option class=button value=0>����������</option>
     
            </select>
        </TD>
        <TD class=blue>�ʺ�����</TD>
          <TD>
          	<jsp:include page="/npage/common/pwd_one.jsp">
				      <jsp:param name="width1" value="16%"  />
				      <jsp:param name="width2" value="34%"  />
				      <jsp:param name="pname" value="cus_pass"  />
				      <jsp:param name="pwd" value="12345"  />
	 	   	</jsp:include>
          </TD>  
    </TR>
    <TR> 
        <TD class=blue>����������</TD>
        <TD>
            <input type="text" name="phoneNo" size="20" maxlength="13" onKeyDown="if(event.keyCode==13){ return query() }"   onKeyPress="return isKeyNumberdot(0)"  >
            <input type="button" class="b_text" name="Button1" value="��ѯ�ʺ�" onclick="doCheck2()">
        </TD>
        <TD class=blue>�ʻ�����</TD>
        <TD><input type="text" name="contractNo" readOnly size="20" maxlength="20"></TD>  
    </TR>
    <TR> 
        <TD class=blue>��ʼʱ��</TD>
        <TD>
            <input v_type=int type="text"  name="beginTime" size="20" maxlength="6" value=<%=mon[3]%>>
        </TD>
        <TD class=blue>����ʱ��</TD>
        <TD>
            <input v_type=int type="text" name="endTime" size="20" maxlength="6" value=<%=dateStr.substring(0,6)%>>
        </TD>
    </TR>
    <input type="hidden" name="newPhone">
    <tr id="footer" > 
        <td colspan=4>
            <input class="b_foot" name=Button2 id="doQuery"  type="button" onClick="query()" value="  �� ѯ  " disabled>
            <input class="b_foot" name=reset  type=reset onClick="" value="  �� ��  ">
            <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value="  �� ��  ">
        </td>
    </tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>

</BODY></HTML>
<!--***********************************************************************-->

