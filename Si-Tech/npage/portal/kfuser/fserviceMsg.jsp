<%
   /*
   * ����: ��ѯ�û���ͨ������Ϣ
�� * �汾: v1.0
�� * ����: 2008��4��17��
�� * ����: wuln
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸����� 2009-05-19     �޸���  libina     �޸�Ŀ��  ����ҵ����ͳ�ƣ�����
   *          �޸����ݣ��������op_rflag��servicedes����ֵ��������
   * �޸����� 2009-05-21     �޸���  libina     �޸�Ŀ��  ����·����޸�ҳ��
   * �޸����� 2009-05-26     �޸���  libina     �޸�Ŀ��  ������־��Ϣ
   *          
 ��*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%
  String org_code = (String)session.getAttribute("orgCode");
  String regionCode=org_code.substring(0,2);
  String phone_no = (String)session.getAttribute("activePhone");
  
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
%>
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
 <script language="javascript">
	function doProcess(packet)
	{
	    var retCode1 = packet.data.findValueByName("retCode1");
			var retMsg1 = packet.data.findValueByName("retMsg1");	
	    if(retCode1=='999999'){
	        rdShowMessageDialog(retMsg1,1);
	    }
	
		  var retType = packet.data.findValueByName("retType");		
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");		
	    if(retType=='serviceCfm')
	    {
	    	if(retCode=='000000')
	    	{
	    		rdShowMessageDialog(retMsg + "[" + retCode + "]",2);
	    		if(window.parent!=null){
		    		//window.opener.$("#serviceMsg").load("fserviceMsg.jsp");
		    		//window.location.reload();
		    		window.location.reload();
		    	}else{
		    		//$("#serviceMsg").load("fserviceMsg.jsp");
		    	}		
	    		
	    	}
	    	else{
					rdShowMessageDialog(retMsg + "[" + retCode + "]",0);
	      }
	    }
	}
	
	
	function ConfirmJspa(x,y)
	{
		var op_note = "";
		var service_str = "";
		var op_rflag = "";
		var servicedes = y;
		if((document.all.srvSel.value != "0"&&x == "1")||x == "0")
		{
			if(x == 0){
				op_note = "�ͷ��ط�ȡ��";
				op_rflag = "2";
				service_str = "" + y + "^X^^^^^^0^^^";
			}else{
				op_note = "�ͷ��ط�����";
				op_rflag = "1";
				service_str = "" + y + "^^X^^^^^0^^^";
			}
			if(rdShowConfirmDialog("�Ƿ�ȷ���ύ��") == 1){
		    var myPacket = new AJAXPacket("/npage/portal/kfuser/serviceCfm.jsp","�����ύ�����Ժ�......");		    
		    myPacket.data.add("retType","serviceCfm");
				myPacket.data.add("phone_no","<%=phone_no%>");
				myPacket.data.add("login_no","<%=workNo%>");
				myPacket.data.add("passwd","<%=password%>");
				myPacket.data.add("op_code","1216");
				myPacket.data.add("op_note",op_note);				
				myPacket.data.add("service_str",service_str);

				myPacket.data.add("servicedes",servicedes);
				myPacket.data.add("op_rflag",op_rflag);
 
				core.ajax.sendPacket(myPacket,doProcess);
								
				myPacket=null;
			}
	  }else{
	  	 rdShowMessageDialog("��ѡ��������!",1);
	  	 document.all.srvSel.focus();
	  	 return false;
	  }
	} 	
	 $("#wait2").hide();	
 </script>

<link href="../../../nresources/default/css/portalet.css" rel="stylesheet" type="text/css">
<link href="../../../nresources/default/css/font_color.css" rel="stylesheet" type="text/css">

<wtc:service name="sServiceMsg" outnum="8" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=phone_no%>"/>
</wtc:service>
  <wtc:array id="result0" start="0" length="1" scope="end"/>
	<wtc:array id="result1" start="1" length="1" scope="end"/>
	<wtc:array id="result2" start="2" length="1" scope="end"/>
	<wtc:array id="result3" start="3" length="1" scope="end"/>
	<wtc:array id="result4" start="4" length="1" scope="end"/>
	<wtc:array id="result5" start="5" length="1" scope="end"/>
	<wtc:array id="result6" start="6" length="1" scope="end"/>
	<wtc:array id="result7" start="7" length="1" scope="end"/>
<div id="form">	
 <div class="table_biaoge" style="overflow-x:auto">
	<table width="150%" class="ctl" cellpadding="0" cellspacing="0">
  	<tr> 
    	<th width="15%">��������</th>
			<th width="25%">��ͨʱ��</th>
			<th width="25%">����ʱ��</th>
			<th width="10%">�����</th>
			<th width="10%">��  ��</th>
	  </tr>
	  
	  
	 <%
	   System.out.println("fserviceMsg.jsp��retCode��"+retCode);       
	   if("000000".equals(retCode)){
        System.out.println("���û��ѿ�ͨ�ط�������"+result0.length);       
		  	for (int i=0;i<result0.length;i++){
			 %>
			 <tr align="center"> 
			 <% 
			    if(i%2==0){
			%>
						<td class="Grey"><%=result1[i][0]%></td>
						<td class="Grey"><%=result2[i][0]%></td>            
            <td class="Grey"><%=result3[i][0]%></td>
            <td class="Grey"><%=result4[i][0]%></td>
      <%
          if("Y".equals(result5[i][0])){
      %>
            <td class="Grey"><a href="javascript:ConfirmJspa('0','<%=result0[i][0]%>');">[ȡ��]</a></td>
      <%}else{
      %>      
            <td class="Grey">&nbsp;</td>        			    
			<%  }   
			  }else{
			%>
					  <td><%=result1[i][0]%></td>
						<td><%=result2[i][0]%></td>            
            <td><%=result3[i][0]%></td>
            <td><%=result4[i][0]%></td>
      <%
          if("Y".equals(result5[i][0])){
      %>
            <td><a href="javascript:ConfirmJspa('0','<%=result0[i][0]%>');">[ȡ��]</a></td>
      <%  }else{
      %>      
            <td>&nbsp;</td>        			    
			<%  } 
			  }	   
		  %>
      </tr>
    <%}}%>
  </table>
</div>
  	 	<div style="margin:5px; text-align:right">
		   <select name="srvSel" id="srvSel">
		   	 <option value="0">--δ��ͨ����--</option> 
		   	 <!--
		   	 <option value="02">��������</option> 
		   	 <option value="34">�ֻ�����</option> 
		   	 <option value="35">�ֻ�����</option> 
		   	 <option value="36">�ֻ�����</option> 
		   	 <option value="37">��Ϣ����</option>
		   	 -->
			    <%
					if("000000".equals(retCode)){
					  System.out.println("���û��ɿ�ͨ�ط�������"+result6.length);      
						if(result6.length>0){
							for(int i=0;i<result6.length;i++){
						%>	    
						<option value="<%=result6[i][0]%>"><%=result7[i][0]%></option>
					 <%
						  }
						 }
					}
					%>			   	 
		  </select> 
		  <input type="button" class="b_text" name="sub" value="��ͨ" onclick="ConfirmJspa('1',document.all.srvSel.value)"/>
	</div>
</div>


 