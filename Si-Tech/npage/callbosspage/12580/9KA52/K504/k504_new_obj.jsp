
<%
	 /*
	 * ����: 12580���˵绰��
	 * �汾: 1.0.0
	 * ����: 2009/01/08
	 * ����: xingzhan
	 * ��Ȩ: sitech
	 * update:
	 */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="javax.servlet.http.HttpServletRequest,com.sitech.crmpd.core.wtc.util.*,java.util.*,java.io.OutputStream,com.sitech.boss.util.excel.*,java.text.SimpleDateFormat"%>


<%
    
	String opCode = "K504";
	String opName = "���˵绰��ά��";
	String org_code = (String)session.getAttribute("orgCode");
	String workNo = (String)session.getAttribute("workNo");
	
	String phone_name = "";
	String phone_mainnum = "";
	String phone_fax = "";
	String phone_qq = "";
	String phone_email = "";
	String phone_sxe = "";
	String phone_yeas = "";
	String phone_month = "";
	String phone_date = "";
	String phone_unit = "";
	String phone_note = "";
	String phone_birth = "";
	String ACCEPT_NO = request.getParameter("ACCEPT_NO");
	String daterusalt[][] = new String[][]{};
	
	String strINType = "button";
	String strUPType = "hidden";
	String sxeMCheck = "checked";
	String sxeFCheck = "";
	
	String sqlGRPStr = "select ACCEPT_NO,GRP_NAME,SERIAL_NO from DMSGGRP where ACCEPT_NO = '"+ACCEPT_NO+"' and grp_type='1'";
	%>
	
<wtc:service name="s151Select" outnum="10">
	<wtc:param value="<%=sqlGRPStr%>" />
</wtc:service>
<wtc:array id="queryList1" scope="end" />
	<%
	String objID = (String)request.getParameter("obj_id");
    if(objID==null||"".equals(objID)){
    }else{
       
       strINType = "hidden";
	   strUPType = "button";
       String sqlStr = "select PERSON_NAME,PERSON_PHONE,PERSON_FAX,PERSON_QQ,PERSON_EMAIL,PERSON_SEX,PERSON_BIRTH,PERSON_UNIT,PERSON_DESCR FROM DPHONLIST  WHERE SERIAL_NO = '"+objID+"' AND PERSON_TYPE = '1' AND ACCEPT_NO ='"+ACCEPT_NO+"' ";    
       
       String strSql = "select GRP_SERIAL_NO FROM DPHONLIST a left join DMSGGRPPHONLIST b on b.LIST_SERIAL_NO = a.SERIAL_NO where a.SERIAL_NO='"+objID+"'"; 
       
%>

<wtc:service name="s151Select" outnum="3">
	<wtc:param value="<%=strSql%>" />
</wtc:service>
<wtc:array id="queryList2" scope="end" />

<wtc:service name="s151Select" outnum="25">
	<wtc:param value="<%=sqlStr%>" />
</wtc:service>
<wtc:array id="queryList" scope="end" />
<% 
     
       daterusalt = queryList2;
       
       phone_name = (queryList[0][0].length() != 0) ? queryList[0][0]: "";
       phone_mainnum = (queryList[0][1].length() != 0) ? queryList[0][1]: "";
       phone_fax = (queryList[0][2].length() != 0) ? queryList[0][2]: "";
       phone_qq = (queryList[0][3].length() != 0) ? queryList[0][3]: "";
       phone_email = (queryList[0][4].length() != 0) ? queryList[0][4]: "";
       phone_sxe = (queryList[0][5].length() != 0) ? queryList[0][5]: "";
       phone_birth = (queryList[0][6].length() != 0) ? queryList[0][6]: "";
       phone_unit = (queryList[0][7].length() != 0) ? queryList[0][7]: "";
       phone_note = (queryList[0][8].length() != 0) ? queryList[0][8]: "";
       
       if("F".equalsIgnoreCase(phone_sxe)){
       
           sxeMCheck = "";
		   sxeFCheck = "checked";
       }
       
       if(!"".equals(phone_birth)){
           
           String Time[] = phone_birth.split("-");
           if(Time.length>0){
	           phone_yeas = Time[0];
	           phone_month = Time[1];
	           phone_date = Time[2];
           }
       }
    }
%>

<html>
	<head>
		<title>���˵绰��ά��</title>
		<script language="JavaScript" type="text/JavaScript" src="../../inputops.js"></script>
		<script language=javascript>
		    function setObjID(idvalue)
			{
			    
			    document.getElementById("checkid").value = idvalue;
			}
		    function modCfm()
			{
			    var phone_name = document.getElementById("phone_name").value;
			    var phone_mainnum = document.getElementById("phone_mainnum").value;
			    var phone_fax = document.getElementById("phone_fax").value;
			    var phone_qq = document.getElementById("phone_qq").value;
			    var phone_email = document.getElementById("phone_email").value;
			    var phone_sxe = document.getElementById("checkid").value;
			   
			    var phone_yeas = document.getElementById("phone_yeas").value;
			    var phone_month = document.getElementById("phone_month").value;
			    var phone_date = document.getElementById("phone_date").value;
			    var phone_unit = document.getElementById("phone_unit").value;
			    var phone_note = document.getElementById("phone_note").value;
			    var objArray = new Array();
			    var SERIAL_NO = document.getElementsByName("SERIAL_NO");
			 
			    for(var i = 0;i<SERIAL_NO.length;i++){
			    	
			    	if(SERIAL_NO[i].checked){
			    		
			    		objArray.push(SERIAL_NO[i].value);
			    	}
			    }
			    
			    
			    if(phone_mainnum == ""){
			    	  showTip(document.sitechform.phone_mainnum,"�����벻��Ϊ�գ������ѡ�������");
			        sitechform.phone_mainnum.focus();
			        return;
			    }
			    
			    if(!f_check_mobile(phone_mainnum)){;
						showTip(document.sitechform.phone_mainnum,"�������ʽ����ȷ�������ѡ�������");
				    sitechform.phone_mainnum.focus();
						return;
					}
			    
			    var phone_age = phone_yeas+"-"+phone_month+"-"+phone_date;
			
			    
			  var myPacket = new AJAXPacket("k504_newsave_obj.jsp","�����ύ�����Ժ�......");
				myPacket.data.add("phone_name",phone_name);
				myPacket.data.add("phone_mainnum",phone_mainnum);
				myPacket.data.add("phone_fax",phone_fax);
				myPacket.data.add("phone_qq",phone_qq);
				myPacket.data.add("phone_email",phone_email);
				myPacket.data.add("phone_sxe",phone_sxe);
				myPacket.data.add("phone_age",phone_age);
				myPacket.data.add("phone_note",phone_note);
				myPacket.data.add("phone_unit",phone_unit);
				myPacket.data.add("ACCEPT_NO",<%=ACCEPT_NO%>);
				myPacket.data.add("objArray",objArray.toString());
			
				core.ajax.sendPacket(myPacket,doProcess,true);
				myPacket=null;
			}
			function modCfmUP()
			{
			    var phone_name = document.getElementById("phone_name").value;
			    var phone_mainnum = document.getElementById("phone_mainnum").value;
			    var phone_fax = document.getElementById("phone_fax").value;
			    var phone_qq = document.getElementById("phone_qq").value;
			    var phone_email = document.getElementById("phone_email").value;
			    var phone_sxe = document.getElementById("checkid").value;
			   
			    var phone_yeas = document.getElementById("phone_yeas").value;
			    var phone_month = document.getElementById("phone_month").value;
			    var phone_date = document.getElementById("phone_date").value;
			    var phone_unit = document.getElementById("phone_unit").value;
			    var phone_note = document.getElementById("phone_note").value;
			    var obj_id = <%=objID%>
			    
			    var objArray = new Array();
			    var SERIAL_NO = document.getElementsByName("SERIAL_NO");
			 
			    
			    for(var i = 0;i<SERIAL_NO.length;i++){
			    
			    	if(SERIAL_NO[i].checked){
			    		
			    		objArray.push(SERIAL_NO[i].value);
			    	}
			    }
			    if(phone_mainnum == ""){
			    	  showTip(document.sitechform.phone_mainnum,"�����벻��Ϊ�գ������ѡ�������");
			        sitechform.phone_mainnum.focus();
			        return;
			    }
			    
			    if(!f_check_mobile(phone_mainnum)){;
						showTip(document.sitechform.phone_mainnum,"�������ʽ����ȷ�������ѡ�������");
				    sitechform.phone_mainnum.focus();
						return;
					}
			    
			    var phone_age = phone_yeas+'-'+phone_month+'-'+phone_date
			    
			    var myPacket = new AJAXPacket("k504_editsave_obj.jsp","�����ύ�����Ժ�......");
				myPacket.data.add("phone_name",phone_name);
				myPacket.data.add("phone_mainnum",phone_mainnum);
				myPacket.data.add("phone_fax",phone_fax);
				myPacket.data.add("phone_qq",phone_qq);
				myPacket.data.add("phone_email",phone_email);
				myPacket.data.add("phone_sxe",phone_sxe);
				myPacket.data.add("phone_age",phone_age);
				myPacket.data.add("phone_note",phone_note);
				myPacket.data.add("phone_unit",phone_unit);
				myPacket.data.add("obj_id",obj_id);
				myPacket.data.add("objArray",objArray.toString());
				myPacket.data.add("ACCEPT_NO",<%=ACCEPT_NO%>);
			
				core.ajax.sendPacket(myPacket,doProcess,true);
				myPacket=null;
			}
			function doProcess(myPacket)
			{
			
			    var retType = myPacket.data.findValueByName("retType");
				var retCode = myPacket.data.findValueByName("retCode");
				var retMsg = myPacket.data.findValueByName("retMsg");
				var GRP_NAME = myPacket.data.findValueByName("GRP_NAME");
					if(retCode=="000000"){
						//alert("����ɹ�");
						//rdShowMessageDialog("�ɹ�",2);
						window.dialogArguments.submitMe('2');
					    window.close();
					}else if(retCode == "22222"){
						rdShowMessageDialog("ʧ��,�˺����Ѵ��ڵ绰����",0);
						return false;
					}else if(retCode == "55555"){
						rdShowMessageDialog("ʧ��,"+GRP_NAME+"Ⱥ���е绰��������20��",0);
						return false;
					}else{
						//alert("����ʧ��!");
						rdShowMessageDialog("ʧ��",0);
						return false;
					}
			}
        </script>
	</head>
	<body >
		<%@ include file="/npage/include/header.jsp"%>
		<form name="sitechform" id="sitechform">
			<div id="Operation_Table">
				<div class="title">
					��������ϸ��Ϣ
				</div>
				<table cellspacing="0" style="width:650px">
				    <tr>
				        <td nowrap="nowrap">
				            ����
				        </td>
				      <td nowrap="nowrap">
				          <input type="hidden" name="ACCEPT_NO" id="ACCEPT_NO" value="<%=ACCEPT_NO %>" style="height:21px"/>
				          <input type="text" name="phone_name" id="phone_name" value="<%=phone_name %>" style="height:21px"/>
				        </td>
				       <td nowrap="nowrap">
				            ������
				        </td>
				       <td nowrap="nowrap">
				          <input type="text" name="phone_mainnum" id="phone_mainnum" value="<%=phone_mainnum %>" style="height:21px"/><font color="orange">*</font>
				        </td>
				        <td rowspan="4" nowrap="nowrap" valign="top">
				        
				          <div id="">
				          ����Ⱥ��:<br/>
				          <%for(int i =0;i<queryList1.length;i++){ %>
				           <input type="checkbox" name="SERIAL_NO" value="<%=queryList1[i][2] %>"
				            <%for(int x = 0;x<daterusalt.length;x++){
				            if(daterusalt[x][0].equalsIgnoreCase(queryList1[i][2])){%>checked="checked"<% break;}} %>><%=queryList1[i][1] %><br/>
				          <%} %> 
				          </div>
				        </td>
				    </tr>
				    <tr>
				    ������<td nowrap="nowrap">
				           ����
				        </td>
				        <td>
				          <input type="text" name="phone_fax" id="phone_fax" value="<%=phone_fax %>" style="height:21px"/>
				        </td>
				        <td nowrap="nowrap">
				           QQ/BP
				        </td>
				        <td nowrap="nowrap">
				          <input type="text" name="phone_qq"  id="phone_qq" value="<%=phone_qq %>" style="height:21px"/>
				        </td>
				    </tr>
				    <tr>
				        <td nowrap="nowrap">
				            ����
				        </td>
				        <td nowrap="nowrap">
				          <input type="text" name="phone_email"  id="phone_email" value="<%=phone_email %>" style="height:21px"/>
				        </td>
				        <td nowrap="nowrap">
				           �Ա�
				        </td>
				        <td nowrap="nowrap">
				          <input type="hidden" name="checkid" id ="checkid" value="<%=("".equals(phone_sxe)?"M":phone_sxe )%>">
				          <input type="radio" name="phone_sxe" id="phone_sxe" value="M" style="height:21px" <%=sxeMCheck %> onclick="setObjID(this.value);" />��
				          &nbsp;
				          <input type="radio" name="phone_sxe" id="phone_sxe" value="F" style="height:21px" <%=sxeFCheck %> onclick="setObjID(this.value);" />Ů
				        </td>
				    </tr>
				    <tr>
				        <td nowrap="nowrap">
				           ���գ�
				        </td>
				        <td nowrap="nowrap" colspan="3"> 
				             
				           <select name="phone_yeas" id="phone_yeas" size="1">
				           <%for(int i = 0;i<40;i++){ %>
				               <option value="<%=i+1970 %>"  <%if((""+(i+1970)).equals(phone_yeas)){ %>selected <%} %>><%=i+1970 %></option>
				           <%} %>   
				           </select>��
				           <select name="phone_month" id="phone_month" size="1">
				           <%for(int i = 0;i<12;i++){ %>
				               <option value="<%=i+1 %>"  <%if((""+(i+1)).equals(phone_month)){ %>selected <%} %>><%=i+1 %></option>
				           <%} %>   
				           </select>��
				           <select name="phone_date" id="phone_date" size="1">
				           <%for(int i = 0;i<31;i++){ %>
				               <option value="<%=i+1 %>"  <%if((""+(i+1)).equals(phone_date)){ %>selected <%} %>><%=i+1 %></option>
				           <%} %> 
				           </select>��
				        </td>
				    </tr>
				    <tr>
				        <td nowrap="nowrap">
				        ��λ��Ϣ
				        </td>
				        <td colspan="4" nowrap="nowrap">
				         <input type="text" name="phone_unit" id="phone_unit" value="<%=phone_unit %>" size="90%" style="height:21px"/>
				        </td>
				    </tr>
				    <tr>
				         <td nowrap="nowrap">
				       ��ע
				        </td>
				        <td colspan="4" nowrap="nowrap">
				         <input type="text" name="phone_note" id="phone_note" value="<%=phone_note %>" size="90%" style="height:21px"/>
				        </td>
				    </tr>
				</table>
				<br/>
				 <div id="" align="right">
				     <input type="<%=strINType %>" name="cfm" class="b_foot" value="ȷ��" onclick="modCfm();"/>
				     <input type="<%=strUPType %>" name="cfm" class="b_foot" value="ȷ��" onclick="modCfmUP();"/>
					 <input type="button" name="clo" class="b_foot" value="�ر�" onclick="javascript:window.close();"/>
				 </div>
				
			</div>
		</form>
		<%@ include file="/npage/include/footer.jsp"%>
	</body>
</html>
