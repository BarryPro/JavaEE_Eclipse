<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: �ı���������״̬����ͣ��ָ�
�� * �汾: v1.0
�� * ����: 2009��03��04��
�� * ����: wuxy
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib uri="weblogic-tags.tld" prefix="wl" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*" %>
<%@ page import="java.text.*"%>
<%
	String opCode = "e539";	
	String opName = "������������״̬";	//header.jsp��Ҫ�Ĳ���   
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
		String loginNo=(String)session.getAttribute("workNo"); 
	String workName = (String)session.getAttribute("workName");
	String ipAddr = (String)session.getAttribute("ipAddr");
	String orgCode = (String)session.getAttribute("orgCode");	
	String workPwd = (String)session.getAttribute("password");

	String queryInfo = request.getParameter("ecsiid");	
  String ecsiname = request.getParameter("ecsiname");	
	String phone_no = request.getParameter("phone_no");	
	String regionCode = orgCode.substring(0,2);
	
	String  currentYear= (String)session.getAttribute("currentYear");
	 String[][] result = new String[][]{};
%>

<head>
	<script language="JavaScript">
	//��ͣ
	function  queryMod(v_id)
	{		
		var alterCodeProp;		
		alterCodeProp=document.form1["operId" +v_id].value+"|";
		document.all.OprCode.value="e540";
		document.all.alterCode.value=document.getElementById("operId1"+v_id).value;
		                             
		var OprCode=document.all.OprCode.value;
		var alterCode=document.all.alterCode.value+"|";
		
		var packet = new AJAXPacket("fe539_modCfm.jsp","���Ժ�......");
 		packet.data.add("OprCode",OprCode);
 		packet.data.add("queryName",document.all.queryName.value);
 		packet.data.add("queryValue",document.all.queryValue.value);
 		packet.data.add("phone_no",document.all.phone_no.value);
 		packet.data.add("alterCodeProp",alterCodeProp);
 		packet.data.add("alterCode",alterCode);
 		packet.data.add("v_id",v_id);
 		packet.data.add("retype","z");
    core.ajax.sendPacket(packet);
		packet =null;	
	}
   //�ָ� 
	function  queryMod1(v_id)
	{				
		var alterCodeProp;		
		alterCodeProp=document.form1["operId" +v_id].value+"|";
		document.all.OprCode.value="e541";
		document.all.alterCode.value=document.getElementById("operId1"+v_id).value;
		var OprCode=document.all.OprCode.value;
		var alterCode=document.all.alterCode.value+"|";
		
		var packet = new AJAXPacket("fe539_modCfm.jsp","���Ժ�......");
 		packet.data.add("OprCode",OprCode);
 		packet.data.add("queryName",document.all.queryName.value);
 		packet.data.add("queryValue",document.all.queryValue.value);
 		packet.data.add("phone_no",document.all.phone_no.value);
 		packet.data.add("alterCodeProp",alterCodeProp);
 		packet.data.add("alterCode",alterCode);
 		packet.data.add("v_id",v_id);
 		packet.data.add("retype","h");

    	core.ajax.sendPacket(packet);
		packet =null;
		
	}
		function doProcess(myPacket)
	{
		var errCode    =myPacket.data.findValueByName("retCode2")
		var retMessage = myPacket.data.findValueByName("retMsg2");//�������ص���Ϣ
		var retFlag    = myPacket.data.findValueByName("retFlag");
		var retype    = myPacket.data.findValueByName("retype");
		var v_id    = myPacket.data.findValueByName("v_id");
		
		
		
		//alert (errCode);
		//alert (retFlag);
		//alert(v_id);
		//alert("v_id1="+v_id1);
		
		
		
		if(retFlag=="1")
		{
				rdShowMessageDialog(retMessage);
	
				if(retype.trim()=="h")
				{
				  
				  document.getElementById('description'+v_id.trim()).innerHTML="����";
				  document.getElementById('operator1'+v_id.trim()).disabled=false;
				  document.getElementById('operator'+v_id.trim()).disabled=true;

				}
				else 
				{
					
				  document.getElementById('description'+v_id.trim()).innerHTML="��ͣ";
				  document.getElementById('operator1'+v_id.trim()).disabled=true;
				  document.getElementById('operator'+v_id.trim()).disabled=false;
				}
		}
		else
		{
			rdShowMessageDialog(retMessage);
			window.location.replace("fe539.jsp");
		}
				
		
	}
				
		
	
	function refresh() 
   { 
���� window.location.reload(); 
   } 
	</script>
</head>
<body>
<form name="form1" method="post">
	<input type="hidden" name="pageOpCode" value="<%=opCode%>">
	<input type="hidden" name="pageOpName" value="<%=opName%>">
<%@ include file="/npage/include/header.jsp" %>

<div id="productList" >
<div class="title"><div id="title_zi">�����������Ϣ�б�</div></div>

<table cellspacing="0" id="productTab" >
    <tr align="center">
        <th nowrap>���������</th>
        <th nowrap>���� </th>
        <th nowrap>״̬</th>   
        <th nowrap>����</th>   
        
    </tr>
 <wtc:service name="se539Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="5" >
            	<wtc:param value=""/>
            	<wtc:param value=""/>
              <wtc:param value="e541"/>
              <wtc:param value="<%=loginNo%>"/>
              <wtc:param value="<%=workPwd%>"/>
              <wtc:param value=""/>
              <wtc:param value=""/>
              <wtc:param value="<%=queryInfo%>"/>
              <wtc:param value="1"/>
              <wtc:param value=""/>
   </wtc:service>
   <wtc:array id="rows"  scope="end" />
	<%
  		    if (retCode.equals("000000")){
  		        result = rows;
  		    }else{
  		        %>
  		            <script type=text/javascript>
  		                rdShowMessageDialog("������룺<%=retCode%>��������Ϣ��<%=retMsg%>",0);
  		                window.close();
  		            </script>
  		        <%
  		    }  	
       for(int i=0;i<result.length;i++){

       System.out.println(result[i][0]);
       System.out.println(result[i][1]);
       System.out.println(result[i][2]);
       
    %>
    <tr align="center">

        <td nowrap class="blue" >
        	<input type="hidden" name="operId<%=i+1%>" value="<%=result[i][1].trim()%>">
			<input type="hidden" name="operId1<%=i+1%>" value="<%=result[i][0].trim()%>">			
				<a><%=result[i][0].trim()%></a></td>
        </td>
<%      if("01".equals(result[i][1].trim()))
        {
%>
        <td nowrap class="blue">����</td>
<%      }
        else if("02".equals(result[i][1].trim()))
        {
%>
				<td nowrap class="blue">����</td>
<%      }
   			else  {
%>
				<td nowrap class="blue">WAPPush</td>
<%      }
%>
<%      
		String stopFlag="";  
		String resumeFlag="";
		if("1".equals(result[i][2].trim()))
        {
          resumeFlag="disabled";
%>
          <td nowrap class="blue" id="description<%=i+1 %>" value="2w">����</td>   
<%      }
        else if("3".equals(rows[i][2].trim()))
        {
           stopFlag="disabled";
%>
        <td nowrap class="blue" id="description<%=i+1 %>">��ͣ</td> 
<%
        }
%>
        <td class="blue">
        <input id="operator1<%=i+1%>"  <%=stopFlag%> style="cursor:hand" type="button" value="��ͣ" class="b_text" onclick="queryMod(<%=i+1%>)">
		<input id="operator<%=i+1%>" <%=resumeFlag%> style="cursor:hand" type="button" value="�ָ�" class="b_text" onclick="queryMod1(<%=i+1%>)">	
	    </td>	
        	
        
    </tr>
    <%
       }
    %>
</table>
</div>

<table cellSpacing=0> 
  <tr>
    <td align="center" id="footer" colspan="4">
      <input class="b_foot" name=back onClick="window.location='fe539.jsp'" style="cursor:hand" type=button value=����>
      <input class="b_foot" name=reset type=button value="�ر�" onClick="parent.removeTab('<%=opCode%>')">
    </td>
  </tr>
</table>
   <input type="hidden" name="alterCodeProp" type="text" class="button" id="alterCodeProp" value="" size=7 >
   <input type="hidden" name="alterCode" type="text" class="button" id="alterCode" value="" size=18 >
   <input type="hidden" name="OprCode" type="text" class="button" id="OprCode" value="" size=7 >
   <input type="hidden" name="queryValue" type="text" class="button" id="queryValue" value="<%=queryInfo%>" size=18 >
   <input type="hidden" name="queryName" type="text" class="button" id="queryName" value="<%=ecsiname%>" size=18 >
   <input type="hidden" name="phone_no" type="text" class="button" id="phone_no" value="<%=phone_no%>" size=18 >
   
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>