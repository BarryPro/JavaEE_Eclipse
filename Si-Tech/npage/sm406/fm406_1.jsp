<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)2016-9-17 10:11:42------------------
 �����ʷ�ͬһ����Ч�Ż�����(ά�������)
 
 �ַ�Ҫ��9��20������ �����������ڿ�����
 -------------------------��̨��Ա�� wangzc --------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo    = (String)session.getAttribute("workNo");
  String password  = (String)session.getAttribute("password");
  String workName  = (String)session.getAttribute("workName");
  String orgCode   = (String)session.getAttribute("orgCode");
  String ipAddrss  = (String)session.getAttribute("ipAddr");
  String regionCode = (String)session.getAttribute("regCode");
	String currentDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	
	//7����׼�����
	String paraAray[] = new String[7];
	
	paraAray[0] = "";                                       //��ˮ
	paraAray[1] = "01";                                     //��������
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = (String)session.getAttribute("workNo");   //����
	paraAray[4] = (String)session.getAttribute("password"); //��������
	paraAray[5] = activePhone;                              //�û�����
	paraAray[6] = "";                                       //�û�����

	
%> 

  <wtc:service name="sOfferInsQry" outnum="7" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraAray[0]%>" />
		<wtc:param value="<%=paraAray[1]%>" />	
		<wtc:param value="<%=paraAray[2]%>" />	
		<wtc:param value="<%=paraAray[3]%>" />	
		<wtc:param value="<%=paraAray[4]%>" />	
		<wtc:param value="<%=paraAray[5]%>" />	
		<wtc:param value="<%=paraAray[6]%>" />						
	</wtc:service>
	<wtc:array id="result_s" scope="end"    />
<%

	System.out.println("------hejwa----code---------------------->"+code);
	System.out.println("------hejwa----activePhone----------------------->"+activePhone);
	System.out.println("------hejwa----result_s.length----------------------->"+result_s.length);

%>
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=JavaScript>



//��ѯ��̬չʾIMEI�����б�
function go_upd_this_offer(bt){
	var trObj = $(bt).parent().parent();
	var packet = new AJAXPacket("fm406_2.jsp","����ִ��,���Ժ�...");
			packet.data.add("opCode","<%=opCode%>");//
			packet.data.add("active_Phone","<%=activePhone%>");//
			packet.data.add("iOfferInsId",trObj.find("td:eq(0)").text().trim());//
			core.ajax.sendPacket(packet,do_upd_this_offer);
			packet = null; 
}
function do_upd_this_offer(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){// 
			 rdShowMessageDialog("�����ɹ�",2);
			 removeCurrentTab();
	}else{
		  rdShowMessageDialog("ʧ�ܣ�"+code+"��"+msg,0);
	}
}

function reSetThis(){
	location = location ;
}

</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	


<div class="title"><div id="title_zi"><%=opName%>-��ѯ����б�</div></div>
<TABLE cellSpacing="0" id="upgMainTab">
    <tr>
        <th width="12%">�ʷ�ʵ��id</th>
        <th width="8%">�ʷѴ���</th>
        <th width="24%">�ʷ�����</th>
        <th width="15%">��Чʱ��</th>	
        <th width="15%">ʧЧʱ��</th>
        <th width="8%">�ʷ�״̬</th>
        <th width="10%">��������</th>
        
        <th>����</th>	
    </tr>
<%
for(int i=0;i<result_s.length;i++){
%>
 <tr>
       <td><%=result_s[i][0]%></td>
       <td><%=result_s[i][1]%></td>
       <td><%=result_s[i][2]%></td>
       <td><%=result_s[i][3]%></td>
       <td><%=result_s[i][4]%></td>
       <td><%=result_s[i][5]%></td>
       <td><%=result_s[i][6]%></td>
       <td><input type="button" class="b_text" onclick="go_upd_this_offer(this)" value="�޸�" /></td>
    </tr>
<%	
}
%>    
</table>

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>