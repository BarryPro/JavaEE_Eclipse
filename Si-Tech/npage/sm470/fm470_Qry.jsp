<%
/********************
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------duming 2017.4.13------------------
 �����¹̻���Ʒ���ڵ���������ִ����ⱨ���ĺ�  �ں�ͨ����ͣ��ָ�ҵ��
 
 
 -------------------------��̨��Ա��gudd--------------------------------------------
 
********************/
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));
	String opName         = WtcUtil.repNull(request.getParameter("opName"));
	String unitid         = WtcUtil.repNull(request.getParameter("unitid"));		                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	
	//��׼�����
	String paraAray[] = new String[8];
	
	paraAray[0] = "";                                       //��ˮ
	paraAray[1] = "";                                     //��������
	paraAray[2] = opCode;                                   //��������
	paraAray[3] = (String)session.getAttribute("workNo");   //����
	paraAray[4] = (String)session.getAttribute("password"); //��������
	paraAray[5] = "";                                	 	 //�ֻ�����
	paraAray[6] = "";                                       //��������
	paraAray[7] = unitid;                                       //���ű���
	

	String serverName = "sm470Qry";

%>
		<wtc:service name="<%=serverName%>" outnum="9" retcode="sRetCode" retmsg="sRetMsg" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----duming-------------paraAray["+i+"]------["+serverName+"]-------------->"+paraAray[i]);
%>
				<wtc:param value="<%=paraAray[i]%>" />
<%					
			}
%>									
		</wtc:service>
		<wtc:array id="result_t1" scope="end"   />
<%

	if(result_t1.length>0){
		retCode = result_t1[0][7];
		retMsg  = result_t1[0][8];
	}

%> 	
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE></TITLE>
<SCRIPT language=JavaScript>

function chose(){
	
	
	
		var recode = $("input[name='radio_b']:checked").attr('v_code');
		var remsg = $("input[name='radio_b']:checked").attr('v_msg');
		//alert(recode);
		//alert(remsg);
		
	
		var obj = $("input[name='radio_b']:checked").parent().parent();
		var iccid= obj.find("th:eq(0)").text().trim();//֤������
		var unit_name = obj.find("th:eq(1)").text().trim();//��������
		var unit_id = obj.find("th:eq(2)").text().trim();//���ű���
		var id_no = obj.find("th:eq(3)").text().trim();//��Ʒ����
		var user_name = obj.find("th:eq(4)").text().trim();//��Ʒ����
		var account_id = obj.find("th:eq(5)").text().trim();//��Ʒ�˺�
		var run_code = obj.find("th:eq(6)").text().trim();//ҵ��״̬
				
				var myarray=new Array();
				myarray[0]=iccid;
				myarray[1]=unit_name;
				myarray[2]=unit_id;
				myarray[3]=id_no;
				myarray[4]=user_name;
				myarray[5]=account_id;
				myarray[6]=run_code;
		
		
		//alert(myarray);
		window.opener.tableshow();
		window.opener.doreturn(myarray);
		//alert(myarray.length);
		//alert(myarray[0]);
		//if(){
			
		//	}
		
		window.close();
	
		
		
	}


</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>
<div class="title"><div id="title_zi">��Ϣ�б�</div></div>
<TABLE cellSpacing="0" id="upgMainTab">
    <tr>
        <th width="15%">֤������</th>
        <th width="25%">���ſͻ�����</th>
        <th width="15%">����ecid</th>
        <th width="15%">��Ʒ����</th>	
        <th width="15%">��Ʒ����</th>	
        <th width="15%" >�˻�id</th>
        <th width="5%" >ҵ��״̬</th>		
    </tr>
    
   <%
   if(result_t1.length>0){
   	for(int i=0;i<result_t1.length;i++){
 	 %>  	
   	  <tr>
        <th width="15%"><input type="radio" name="radio_b" id="radio" v_code=<%=result_t1[0][7]%> v_msg=v_code=<%=result_t1[0][8]%> /><%=result_t1[i][0]%></th>
        <th width="25%"><%=result_t1[i][1]%></th>
        <th width="15%"><%=result_t1[i][2]%></th>
        <th width="15%"><%=result_t1[i][3]%></th>	
        <th width="15%"><%=result_t1[i][4]%></th>	
        <th width="15%"><%=result_t1[i][5]%></th>
        <th width="5%" ><%=result_t1[i][6]%></th>		
   	 </tr>
   <%	
   	}
		}
   %>
</table>


<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="ȷ��" onclick="chose()"          />
			<input type="button" class="b_foot" value="�ر�" onclick="window.close();"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>