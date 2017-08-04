<%
/********************
 version v2.0
������: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="java.text.*"%>
 
<%
	String opCode="1556";
	String opName="��ϸ�ʵ���ѯ";
    String workno =  (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
	String belongName = (String)session.getAttribute("orgCode");
	String regionCode = belongName.substring(0,2);
	
	Calendar calendar = new GregorianCalendar();
	int year = calendar.get(Calendar.YEAR);
	int month = calendar.get(Calendar.MONTH);
    int day = 1;
        
    Date date = new Date();
	String todayyearmonth = new java.text.SimpleDateFormat("yyyyMMdd").format(date);

	date.setYear(year - 1900);
	date.setMonth(month);
	date.setDate(day-1);
		
	String yearmonth = new java.text.SimpleDateFormat("yyyyMMdd").format(date);
	activePhone=(String)request.getParameter("activePhone"); 
	
%>
<HEAD>
<TITLE>������BOSS-��ϸ�ʵ���ѯ</TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<script language="JavaScript"  src="/npage/s1300/common_1300.js"></script>
 
<script language="JavaScript">

function docheck() {
	if (document.form.phone_no.value.length == 0) {
       rdShowMessageDialog("������벻��Ϊ�գ�");
       return false;
    } else if (document.form.phone_no.value.length < 11){
        rdShowMessageDialog("������벻��С��11λ��");
        return false;
    }

	
       if (isValidYYYYMMDD(document.form.begin_time.value) != 0)
       {
		  rdShowMessageDialog("��ʼʱ���ʽ����! <br>ӦΪ��YYYYMMDD ");
		  document.form.begin_time.focus();
		  return false;
        }

		if (isValidYYYYMMDD(document.form.end_time.value) != 0)
        {
		  rdShowMessageDialog("����ʱ���ʽ����! <br>ӦΪ��YYYYMMDD ");
		  document.form.end_time.focus();
		  return false;
        }
		if (document.form.bill_type.value=="1")
		{
		    document.form.action="s1556_1.jsp";    
		}
		
		if (document.form.bill_type.value=="2")
		{
		    document.form.action="s1556_2.jsp";    
		}
		

		form.submit();
		
}

function doProcess(packet)
{
	//RPC������findValueByName
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode"); 
	var retMessage = packet.data.findValueByName("retMessage"); 
	var retFlag = packet.data.findValueByName("retFlag");
	self.status="";
 	if((retCode).trim()=="")
	{
      rdShowMessageDialog("����"+retType+"����ʱʧ�ܣ�");
      return false;
	}

    if(retType == "checkPwd")
    {
         //��������У��
		var chkPassFlag=false;
        var retResult = packet.data.findValueByName("retResult");
		form.checkPwd_Flag.value = retResult; 
		
/* ���� 2008��1��7�� ���Է��Դ����,��Ҫ�ָ�*/
		
 	    if(form.checkPwd_Flag.value == "false")
	    {
	    	rdShowMessageDialog("�ͻ�����У��ʧ�ܣ����������룡",0);
	    	form.custPwd.value = "";
	    	form.custPwd.focus();
	    	form.checkPwd_Flag.value = "false";	    	
	    	return false;	        	
	    }
		else
		{
 		   rdShowMessageDialog("�ͻ�����У��ɹ���");
		   
		   chkPassFlag=true;
		}

		if("09" == "<%=regionCode%>"){
			if(document.form.custPwd.value == "000000"||document.form.custPwd.value == "111111"||document.form.custPwd.value == "222222"
		 	 ||document.form.custPwd.value == "333333"||document.form.custPwd.value == "444444"||document.form.custPwd.value == "555555"
		 	 ||document.form.custPwd.value == "666666"||document.form.custPwd.value == "777777"||document.form.custPwd.value == "888888"
		 	 ||document.form.custPwd.value == "999999"||document.form.custPwd.value == "123456")
	   		{
	   			rdShowMessageDialog("������ڼ򵥣����޸ĺ��ٰ���ҵ��");
	   		}
	   	}else{	
			if(document.form.custPwd.value == "000000"||document.form.custPwd.value == "001234"||document.form.custPwd.value == pass)
	   		{
	         	rdShowMessageDialog("������ڼ򵥣��뼰ʱ�޸ģ�");
	    	}
	    }

     }	
     
     if(retType == "getPwd")
		{
			if(retCode == "000000" && retFlag != "1")
			{
			   rdShowMessageDialog("������֤�ɹ���");
			   document.all.sure.disabled=false;
			}	        
			else
			{
			  retMessage = retMessage + "������ȷ�ϣ�";
			  document.form.passwd.value="";
			  document.form.passwd.focus(); 
			  document.all.sure.disabled=true;
  			rdShowMessageDialog(retMessage,0);
				return false;
			}
		}		
}

function change_custPwd()
{   //��֤���루���룩
     check_HidPwd(form.custPwd.value,"show","1","1");
}

function check_HidPwd(Pwd1,Pwd1Type,Pwd2,Pwd2Type)
{
    var checkPwd_Packet = new AJAXPacket("checkPwd.jsp","���ڽ�������У�飬���Ժ�......");
    checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	checkPwd_Packet.data.add("Pwd1Type",Pwd1Type);
	checkPwd_Packet.data.add("Pwd2",Pwd2);
	checkPwd_Packet.data.add("Pwd2Type",Pwd2Type);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet=null;
}

function Do_Change() {
    var selectedBillType = document.form.bill_type.options[document.form.bill_type.selectedIndex].value;
    if (selectedBillType == 1) {
        document.form.begin_time.value = "<%=yearmonth.substring(0,6) + "01"%>";
		document.form.end_time.value = "<%=yearmonth%>";
		document.form.query_type.options[0].selected = true;
        
		document.form.begin_time.disabled = false;
		document.form.end_time.disabled = false;
		document.form.query_type.disabled = false;
	} else if (selectedBillType == 2){
	    document.form.begin_time.value = "<%=todayyearmonth.substring(0,6) + "01"%>";
		document.form.end_time.value = "<%=todayyearmonth%>";
		document.form.query_type.options[2].selected = true;
        
		document.form.begin_time.disabled = true;
		document.form.end_time.disabled = true;
        document.form.query_type.disabled = true;
	}
}

function searchAccount() {
   if (document.form.phone_no.value.length == 0) {
       rdShowMessageDialog("������벻��Ϊ�գ�");
   } else if (document.form.phone_no.value.length < 11){
       rdShowMessageDialog("������벻��С��11λ��");
   } else {
      var h=480;
      var w=650;
      var t=screen.availHeight/2-h/2;
      var l=screen.availWidth/2-w/2;

      var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
      var returnValue=window.showModalDialog('getUserCount.jsp?phoneno='+document.form.phone_no.value,"",prop);
      
	  if(returnValue==null) {
           rdShowMessageDialog("��û��ѡ���ʻ���");
      } else {
		   document.form.contract_no.value = returnValue;
	  }
   }
}
</script>

</HEAD>
 <BODY>
<FORM action="s1556_1.jsp" method=post name="form">
	 <%@ include file="/npage/include/header.jsp" %> 
<INPUT TYPE="hidden" name="busyType" value="1">
		<div class="title">
			<div id="title_zi">��ϸ�ʵ���ѯ </div>
		</div>
              <table cellspacing="0">
                <tbody> 
                <tr class="blue"> 
                    <td width="15%">��������</td>
	            	<td width="35%">��ϸ�ʵ���ѯ</td>
	                <td width="15%">����</td>
	                <td width="35%"><%=belongName%></td>
                </tr>
                </tbody> 
              </table>
              <table cellspacing="0">
                <tr> 
				  <td class="blue"  width="15%">�������</td>
                  <td width="35%"> 
                    <input type="text" name="phone_no" maxlength="11" class="button" onKeyPress="return isKeyNumberdot(0)" value="<%=activePhone%>" readOnly >
                    <font class="orange"> *</font>
					<input class="b_text" name=sure22 type=button value=��ѯ onClick="searchAccount();"> 
				  </td>  
				  <td class="blue"  width="15%" >�ʻ�����</td>
                  <td  width="35%" colspan="3"> 
                     <input type="text" name="contract_no" maxlength="20" class="button" onKeyPress="return isKeyNumberdot(0)">
                     <font class="orange"> *</font>
				  </td>  
				</tr>
                <tr> 
                  <td class="blue">��ʼʱ��</td>
                  <td> 
                    <input type="text" name="begin_time" value="<%=yearmonth.substring(0,6) + "01"%>" maxlength="8" class="button" onKeyPress="return isKeyNumberdot(0)">
					<font class="orange"> *</font>
                  </td>
                  <td class="blue">����ʱ��</td>
                  <td > 
                    <input type="text" name="end_time" maxlength="8" value="<%=yearmonth%>" class="button" onKeyPress="return isKeyNumberdot(0)">
					<font class="orange"> *</font>
                  </td>
                </tr>
                <tr> 
                  <td class="blue">�ʵ�����</td>
                  <td> 
                     <select name="bill_type" onchange='Do_Change();'>
                       <option class=button value="1">�ʵ���ϸ</option>
                       <option class=button value="2">δ������ϸ</option>
                     </select>
                  </td>
                  <td class="blue">��ѯ��ʽ</td>
                  <td>
				    <select name="query_type">
                       <option class=button value="0">�ط���</option>
                       <option class=button value="1">��Ϣ��</option>
		               <option class=button value="2">���з���</option>
                    </select>
				  </td>
                </tr>
              </table>
             
              <table width="100%" border=0 align=center cellpadding="4" cellspacing=1>
                <tbody> 
                <tr > 
                  <td align=center width="100%" id="footer"> 
                    <input class="b_foot" name=sure type="button" value="ȷ��" onclick="docheck()" >
                    &nbsp;
                    <input class="b_foot" name=reset type=reset value="�ر�" onclick="removeCurrentTab()">
                  </td>
                </tr>
                </tbody> 
              </table>
              <%@ include file="/npage/include/footer_simple.jsp" %> 
</FORM>
 </BODY>
 </HTML>
