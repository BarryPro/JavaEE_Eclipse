<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">   
<!-------------------------------------------->
<!---����   2008-7-7                     	---->
<!---����   zhouzy                        ---->
<!---����   f1500_qryCnttCfm           		---->
<!---����   �ͻ�ͳһ�Ӵ���ѯ          		---->
<!-------------------------------------------->  	
<%request.setCharacterEncoding("GB2312");%>
<%@ page contentType="text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp"%>

<%
	String sContactId  = request.getParameter("sContactId");
	String sCallersPhone  = request.getParameter("sCallersPhone");
	String sRecipientPhone  = request.getParameter("sRecipientPhone");
	String sPhoneType  = request.getParameter("sPhoneType");
	String sPhoneNo  = request.getParameter("sPhoneNo");
	String sChnCode  = request.getParameter("sChnCode");
	String sChnName  = request.getParameter("sChnName");
	String sInterfaceCode  = request.getParameter("sInterfaceCode");
	String sInterfaceName  = request.getParameter("sInterfaceName");
	String sInteractiveCode  = request.getParameter("sInteractiveCode");
	String sInteractiveName  = request.getParameter("sInteractiveName");
	String sLoginNo  = request.getParameter("sLoginNo");
	String sContactBeginTime  = request.getParameter("sContactBeginTime");
	String sContactEndTime  = request.getParameter("sContactEndTime");
	String sContactStatus  = request.getParameter("sContactStatus");
	String sContactStatusName  = request.getParameter("sContactStatusName");
	String sContactIp  = request.getParameter("sContactIp");
	String sContactIdOld  = request.getParameter("sContactIdOld");
	String sOpCodeOld  = request.getParameter("sOpCodeOld");
	String sOpAcceptOld  = request.getParameter("sOpAcceptOld");
	String sOpCode  = request.getParameter("sOpCode");
	String sOpName  = request.getParameter("sOpName");
	String sOpAccept  = request.getParameter("sOpAccept");
	String sOpTime  = request.getParameter("sOpTime");
	String sOpResult  = request.getParameter("sOpResult");
	String sOpNotes  = request.getParameter("sOpNotes");
	String sOpPhoneNo  = request.getParameter("sOpPhoneNo");
	
	
    
	String opCode = "3793";
	String opName="�����û��ĽӴ���Ϣ";

%>
<SCRIPT language="JavaScript">
function doCheck()
{
   submit_1();
}

function submit_1()
{
       document.frm3792.action="f3792_cfm.jsp";
		frm3792.submit();
	return true;
}
function init(){
	
	 document.all.sChnCode.value='<%=sChnCode%>';
	 document.all.sInterfaceCode.value='<%=sInterfaceCode%>';
	 document.all.sInteractiveCode.value='<%=sInteractiveCode%>';
	 document.all.sContactStatus.value='<%=sContactStatus%>';
	
	}
</SCRIPT>
<HTML><HEAD><TITLE>�����û��ĽӴ���Ϣ</TITLE>
</HEAD>
<body onload= "init()">
	 <FORM method=post name="frm3792" >
<%@ include file="/npage/include/header.jsp" %>
 <div class="title"><div id="title_zi">�����û��ĽӴ���Ϣ</div></div>

    <TABLE cellSpacing=0>
    	 <tr align="center">
        <td width="17%" class="blue">�Ӵ� ID</td>
        <td  align="left" ><%=sContactId%></td>
        <td width="17%" class="blue">����Ա����ʶ</td>
        <td align="left" ><%=sLoginNo%></td>
     	</tr>
       <tr align="center">
        <td width="17%" class="blue">�ͻ���ʶ</td>
        <td  align="left" ><input type="text" name="sPhoneNo"  id = "sPhoneNo"  value="<%=sPhoneNo%>" ></td>
        <td width="17%" class="blue">������ʶ</td>
        <td align="left" >
        	         <select name="sChnCode" id= "sChnCode">	            		
	              		<option value="01">Ӫҵǰ̨</option>
	              		<option value="02">����Ӫҵ��</option>
	              		<option value="03">����Ӫҵ��</option>
	              		<option value="04">����Ӫҵ��</option>
	              		<option value="05">��ý��Ӫҵ��</option>
	              		<option value="06">10086�ͷ�</option>
	              		<option value="07">12580</option>
	              		<option value="08">���</option>
	              	</select>
        	</td>
     	</tr>
     	 <tr align="center">
        <td width="17%" class="blue">�����������</td>
        <td align="left" > 
        	           <select name="sInterfaceCode" id = "sInterfaceCode">	            		
	              		<option value="00">Ĭ��</option>
	              		<option value="01">�˹�����</option>
	              		<option value="02">�Զ�����</option>
	              		<option value="03">��ý��</option>
	              	</select></td>
        <td width="17%" class="blue">�Ӵ�������ʽ</td>
        <td align="left" >
        	          <select name="sInteractiveCode" id = "sInteractiveCode">	            		
	              		<option value="i">����</option>
	              		<option value="f">����</option>
	              	</select></td>
     	</tr>
     	 <tr align="center">
        <td width="17%" class="blue">�Ӵ���ʼʱ��</td>
        <td align="left" ><input type="text" name=""  id = ""  value="<%=sContactBeginTime%>" ></td>
        <td width="17%" class="blue">�Ӵ�����ʱ��</td>
        <td align="left" ><input type="text" name=""  id = ""  value="<%=sContactEndTime%>" ></td>
     	</tr>
     	 <tr align="center">
        <td width="17%" class="blue">���к���</td>
        <td align="left" ><input type="text" name="sCallersPhone"  id = "sCallersPhone"  value="<%=sCallersPhone%>" ></td>
        <td width="17%" class="blue">���к���</td>
        <td align="left" ><input type="text" name="sRecipientPhone"  id = "sRecipientPhone"  value="<%=sRecipientPhone%>" ></td>
     	</tr>
     	 <tr align="center">
        <td width="17%" class="blue">�Ӵ�״̬</td>
        <td align="left" >
        	          <select name="sContactStatus" id ="sContactStatus">	            		
	              		<option value="E">�Ӵ�����</option>
	              		<option value="N">�Ӵ�δ����</option>
	              	</select></td>
        	</td>
        <td width="17%" class="blue">��ע</td>
        <td align="left" ><input type="text" name="sNote"  id = "sNote"  value="<%=sOpNotes%>" ></td>
     	</tr>
     	</table>
     	<TABLE cellSpacing=0>
          <tr> 
      	    <td id="footer">
      	    	  &nbsp; <input class="b_foot" name=back onClick="doCheck()" type=button value=�ύ>
    	      &nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����> 
    	    
    	      &nbsp; 
    	    </td>
          </tr>
      </table>
      <input type="hidden" name="sContactId" id = "sContactId" value ="<%=sContactId%>">
       <input type="hidden" name="sContactIdOld" id = "sContactIdOld" value ="<%=sContactIdOld%>">
       <input type="hidden" name="sOpCode" id = "sOpCode" value ="<%=sOpCode%>">
        <input type="hidden" name="sLoginAccept" id = "sLoginAccept" value ="<%=sOpAccept%>">
         <input type="hidden" name="sLoginNo" id = "sLoginNo" value ="<%=sLoginNo%>">
          <input type="hidden" name="sNote1" id = "sNote1" value ="<%=sOpNotes%>">
<%@ include file="/npage/include/footer.jsp" %>
</Form>
</body>
</html>

