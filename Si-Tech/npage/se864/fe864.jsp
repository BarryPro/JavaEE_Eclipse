<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
	<%
   response.setHeader("Pragma","No-cache");
  // response.setHeader("Cache-Control","no-cache");
   response.setHeader("cache-control","public");
   response.setDateHeader("Expires", 0);
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		String regionCode= (String)session.getAttribute("regCode");
		String workNo = (String)session.getAttribute("workNo");
		String groupId = (String)session.getAttribute("groupId");
		 String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
        String[] mon = new String[]{"", "", "", "", "", ""};
        String account="";

        Calendar cal = Calendar.getInstance(Locale.getDefault());
        cal.set(Integer.parseInt(dateStr.substring(0, 4)),
                (Integer.parseInt(dateStr.substring(4, 6)) - 1), Integer.parseInt(dateStr.substring(6, 8)));
        for (int i = 0; i <= 5; i++) {
            if (i != 5) {
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
                //cal.add(Calendar.MONTH, -2);
            } else
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
        }
        
			  String[] inParamsss1 = new String[2];
				inParamsss1[0] = "SELECT count(*) FROM shighlogin a where a.op_code =:opcode and login_no=:loginno";
				inParamsss1[1] = "opcode="+opCode+", loginno="+workNo; 
				 String smzflag ="0";
				 String[] inParamsss2 = new String[1];
				 String[] inParamsss3 = new String[2];
        
		%>
			<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
			<wtc:param value="<%=inParamsss1[0]%>"/>
			<wtc:param value="<%=inParamsss1[1]%>"/>	
			</wtc:service>	
		  <wtc:array id="dcust" scope="end" />
<%
			if(dcust.length>0) {
				smzflag=dcust[0][0];
			}
			if(smzflag.equals("0")) {/*������Ų������⹤�ű���*/				
				
				inParamsss3[0] = "SELECT region_code, region_name FROM sregioncode WHERE use_flag = 'Y' and group_id=:groupid";
				inParamsss3[1] = "groupid="+groupId; 			
		}else {				
			  inParamsss2[0] = "SELECT region_code, region_name FROM sregioncode WHERE use_flag = 'Y'";
		}
			
%>	
		<script language="javascript">
			var checkflag="<%=smzflag%>";
			  $(function() {
        init();
       });
       
       
		 function init() {	 	
			document.getElementById('gongdtype').checked = true;
			var radio1 = document.getElementsByName("opFlag");
				   for(var i=0;i<radio1.length;i++)
				  {
					    if(radio1[i].checked)
						{
						  var opFlag = radio1[i].value;
								  if(opFlag=="one")
								{	
												$("#gongds").slideDown(400, function() {
												$("#ecels").slideUp(400, function() {
			                 });
			                 });
						    }
				    }
		     }
			}
						function opchange() {
					 var radio1 = document.getElementsByName("opFlag");
							  for(var i=0;i<radio1.length;i++)
				  {
				    if(radio1[i].checked)
					{
					  var opFlag = radio1[i].value;
									  if(opFlag=="one")
									  {							
                   
                    $("#ecels").slideUp(400, function() {
                    	 $("#gongds").slideDown(400, function() {
			                  });
				             });					    	
									  }else if(opFlag=="two")
									  {
									 $("#gongds").slideUp(400, function() {
									 	$("#ecels").slideDown(400, function() {
			              });
									 	});

									  }
								//�ҵ���ӱ���div
								var markDiv=$("#gongdans"); 
								//���ԭ�б��
								markDiv.empty();
									}
								}
							}
							

					function checkSMZValue(packet) {
						document.all.smzvalue.value="";
						var smzvalue = packet.data.findValueByName("smzvalue");
					  document.all.smzvalue.value=smzvalue;								      
					}
					
					function quechoosee() {
											
					var radio1 = document.getElementsByName("opFlag");
				   for(var i=0;i<radio1.length;i++)
				  {
					    if(radio1[i].checked)
						{
						  var opFlag = radio1[i].value;
								  if(opFlag=="one")
								{	//�����ѯ
								var phoneNOs = document.all.phoneNo.value.trim();	
								var beginTimegds = document.frm.beginTimegd.value.trim();
					      var endTimegds = document.frm.endTimegd.value.trim();
					      
					     if(phoneNOs=="" && beginTimegds=="" && endTimegds=="") {
									rdShowMessageDialog("���в�ѯ�������ܶ�Ϊ�գ���������дһ�",0);
									return false;
					     }
					     	if(phoneNOs=="") {
									rdShowMessageDialog("�ֻ����벻��Ϊ�գ�",0);
									return false;
					     }
					     	 if(beginTimegds=="") {
									rdShowMessageDialog("��ʼʱ�䲻��Ϊ�գ�",0);
									return false;
					     }
					     		if(endTimegds=="") {
									rdShowMessageDialog("����ʱ�䲻��Ϊ�գ�",0);
									return false;
					     }
						if(parseInt(beginTimegds)>parseInt(endTimegds)) {
						rdShowMessageDialog("����ʱ��Ӧ�ô��ڵ��ڿ�ʼʱ�䣡",0);
						return false;
							}			      
								    document.all.quchoose.disabled = true;
										var myPacket = new AJAXPacket("fe864_qry.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
										myPacket.data.add("PhoneNo",phoneNOs);
										myPacket.data.add("opCode","<%=opCode%>");
										myPacket.data.add("opName","<%=opName%>");
										myPacket.data.add("beginTimegds",beginTimegds);
										myPacket.data.add("endTimegds",endTimegds);
										myPacket.data.add("iQryFlag","0");
										core.ajax.sendPacketHtml(myPacket,gongdanquery,true);
										getdataPacket = null;

						    }
						    else {//���в�ѯ
						    
						       var dishi = $("#dishi").val();
						       var excelquery = $("#excelquery").val();
						    var beginTimegds = document.frm.beginTimegd1.value.trim();
					      var endTimegds = document.frm.endTimegd1.value.trim();
						       
						       if(dishi=="nn") {
						       		rdShowMessageDialog("��ѡ��Ҫ��ѯ�ĵ��У�",0);
											return false;
						       }
						       
						   if(beginTimegds=="") {
									rdShowMessageDialog("��ʼʱ�䲻��Ϊ�գ�",0);
									return false;
					     }
					     		if(endTimegds=="") {
									rdShowMessageDialog("����ʱ�䲻��Ϊ�գ�",0);
									return false;
					     }
						    
						    		document.all.quchoose.disabled = true;
										var myPacket = new AJAXPacket("fe864_qry.jsp","���ڲ�ѯ��Ϣ�����Ժ�......");
										myPacket.data.add("opCode","<%=opCode%>");
										myPacket.data.add("opName","<%=opName%>");
										myPacket.data.add("dishi",dishi);
										myPacket.data.add("iQryFlag","1");
										myPacket.data.add("iRegionFlag",excelquery);
										myPacket.data.add("beginTimegds",beginTimegds);
										myPacket.data.add("endTimegds",endTimegds);
										core.ajax.sendPacketHtml(myPacket,gongdanquery,true);
										getdataPacket = null;

						    }

		       }

					}
				}
					
				function gongdanquery(data){
				document.all.quchoose.disabled = false;
				//�ҵ���ӱ���div
				var markDiv=$("#gongdans"); 
				//���ԭ�б��
				markDiv.empty();
				markDiv.append(data);
				
		   }
		   
		function doReset(){
			window.location.href = "fe864.jsp?opCode=<%=opCode%>&opName=<%=opName%>"
		}

		</script>
		<body>
		<form name="frm" method="POST" action="">
	<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	
	<table>
							<tr>
				<td class="blue" width="15%">��ѯ����</td>
				<td colspan="3"><input type="radio" name="opFlag" id="gongdtype" value="one"
					onclick="opchange()">�����ѯ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="opFlag" id="exceltype" value="two"
					onclick="opchange()">���в�ѯ</td>
			</tr>
	</table>

    

			<div  id="gongds" name="gongds" class="itemContent">
					<table >
			 <tr>
		    <td class="blue" width="15%">�ֻ�����</td>
		    <td colspan="3">
		  <input name="phoneNo" type="text"   id="phoneNo" value=""   onblur="checkElement(this)" >
		</td>

			
	</tr>

					<tr >
          <TD class="blue" >��ʼ����</TD>
          <TD >
            <input type="text" class="button" name="beginTimegd" style="width:127px;" size="20" maxlength="8" value=<%=mon[1]+"01"%>></TD>
          <TD class="blue" >��������</TD>
          <TD >
             <input type="text" class="button" name="endTimegd" style="width:127px;" size="20" maxlength="8" value=<%=dateStr%>></TD>
		</tr>
	
		</table>
		</div>
		<div id="ecels" name="ecels" class="itemContent">
			<table >
						<tr >
			    <td class="blue" width="15%">��ѯ��ʽ</td>
		    <td colspan="3">
		 				<select id="excelquery" name="excelquery" style="width:130px;" >						
						<option value="0">�������в�ѯ</option>
						<option value="1">������в�ѯ</option>
						</select>
						
		 
		</td>		  
	 </tr >
	 						<tr >
			    <td class="blue" width="15%">����</td>
		    <td colspan="3" id="ssss">
		 				<select id="dishi" name="dishi" style="width:130px;" >
		 					<option value="nn">--��ѡ��--</option>
                <%
                if(smzflag.equals("0")) {
                 %>
					      <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode3ss" retmsg="retMsg3ss" outnum="2">			
								<wtc:param value="<%=inParamsss3[0]%>"/>
								<wtc:param value="<%=inParamsss3[1]%>"/>	
								</wtc:service>	
							  <wtc:array id="dcust3" scope="end" />
							  <%
                	for(int i = 0 ; i < dcust3.length ; i ++){
                	%>             
                <option value="<%=dcust3[i][0]%>"><%=dcust3[i][1]%></option>
                	<%
                 }                                       
                }
                  else {               	
                %>                
					      <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2ss" retmsg="retMsg2ss" outnum="2">			
								<wtc:param value="<%=inParamsss2[0]%>"/>
								</wtc:service>	
							  <wtc:array id="dcust2" scope="end" /> 
							  <option value="00">ȫʡ</option>
		  	        <%		  	        
                for(int i = 0 ; i < dcust2.length ; i ++){%>
                %>               
                <option value="<%=dcust2[i][0]%>"><%=dcust2[i][1]%></option>
                <%
                	}
                	}              
                %>
						</select>
						
		 
		</td>		  
	 </tr >
					<tr >
          <TD class="blue" >��ʼ����</TD>
          <TD >
            <input type="text" class="button" name="beginTimegd1" style="width:127px;" size="20" maxlength="8" value=<%=mon[1]+"01"%>></TD>
          <TD class="blue" >��������</TD>
          <TD >
             <input type="text" class="button" name="endTimegd1" style="width:127px;" size="20" maxlength="8" value=<%=dateStr%>></TD>
		</tr>
			</table>
		</div>
 
	 	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
					<input type="button" id="quchoose" name="quchoose" class="b_foot" value="��ѯ" onclick="quechoosee()" />		
				&nbsp;
								<input name="back" onClick="doReset()" type="button" class="b_foot"  value="���">
				&nbsp;
				<input type="button" name="close" class="b_foot" value="�ر�" onClick="removeCurrentTab();"/>
			</div>
			</td>
		</tr>
	</table>
   <br></br>
		<div id="gongdans">
		</div>

	    <input type="hidden" name="workNo" value="<%=workNo%>">
      <input type="hidden" id="smzvalue" name="smzvalue" value="<%=smzflag%>">

 <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>