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
		String rpt_right = (String)session.getAttribute("rptRight");
	  String org_code = (String)session.getAttribute("orgCode");
		String regionCode= (String)session.getAttribute("regCode");
		String workNo = (String)session.getAttribute("workNo");
		String sqlsl ="select id_type,id_name from sidtype";
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
        
        
     String sqlsss ="select group_id from dloginmsg where login_no='"+workNo+"'";   
     String groupssid="";
        
		%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="Recd" retmsg="RetMs" outnum="1">
			<wtc:sql><%=sqlsss%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="retsgroupid" scope="end" />
		
		<%
		if(Recd.equals("000000")) {
		if(retsgroupid.length>0) {
		 groupssid=retsgroupid[0][0];
		 
		}
	  else {
	  	%>
	  	<script language="javascript">
	  		 rdShowMessageDialog("��ѯ���ŵ�groupidΪ�գ�",0);	
	  		 
	  	</script>
	  	
	  	<%
	  	return;
		}
	 }else {
	 		  	%>
	  	<script language="javascript">
	  		 rdShowMessageDialog("��ѯ���ŵ�groupid��������ϵ����Ա��",0);	
	  		
	  	</script>
	  	<%
	  	 return;
		}
		
		%>
		
		
		
		
		
		
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode3" retmsg="RetMsg3" outnum="2">
			<wtc:sql><%=sqlsl%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="rets1" scope="end" />
		<script language="javascript">
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
									 					//�ҵ���ӱ���div
				var markDiv=$("#gongdans"); 
				//���ԭ�б��
				markDiv.empty();
									  }
									}
								}
							}
							
							function excelonch() {
								var si =document.frm.excelquery.value;
							if(si=="0") {
			       document.all.datetj.style.display = "block";
	  	       document.all.datemx.style.display = "none";
	  	      }if(si=="1") {
	  	       document.all.datetj.style.display = "none";
	  	       document.all.datemx.style.display = "block";
	  	      	}
								}
								function cardchanges() {
							var si =document.frm.renzhengtype.value;
							var sse = document.all.idcard.value.trim();
								alert(sse.length);
							if(si=="0") {
								if(sse.length!=15 ) {
									rdShowMessageDialog("���֤�����λ������ȷ�����������룡",0);
									return false;
									}
									if(isNaN(sse)){
									rdShowMessageDialog("���֤���������֣����������룡",0);
									return false;
									}

	  	        }if(si=="1") {

	  	      	}
								}
					function quechoosee() {
											
					var radio1 = document.getElementsByName("opFlag");
				   for(var i=0;i<radio1.length;i++)
				  {
					    if(radio1[i].checked)
						{
						  var opFlag = radio1[i].value;
								  if(opFlag=="one")
								{	//������ѯ
					var phonesno = document.frm.phoneNo.value;
					var ykh_workNos = document.frm.ykh_workNo.value;
					var renzhengtypes = document.frm.renzhengtype.value;
					var beginTimegds = document.frm.beginTimegd.value;
					var endTimegds = document.frm.endTimegd.value;
					
					
					if(phonesno=="" && ykh_workNos=="" && renzhengtypes=="" &&beginTimegds=="" && endTimegds=="") {
									rdShowMessageDialog("���в�ѯ�������ܶ�Ϊ�գ���������дһ�",0);
									return false;
					}
					if(beginTimegds.substring(0,4)==endTimegds.substring(0,4)) {
						if(beginTimegds.substring(4,6)==endTimegds.substring(4,6)) {
							if(parseInt(beginTimegds.substring(6,8))>parseInt(endTimegds.substring(6,8))) {
						rdShowMessageDialog("������������Ӧ�ô��ڿ�ʼ����������",0);
						return false;
							}
							
						}
						 else {
						rdShowMessageDialog("��������·ݲ�ѯ��",0);
						return false;
					}
						
					}
					else {
						rdShowMessageDialog("���������ݲ�ѯ��",0);
						return false;
					}
					//document.frm.beginTimegd.value=document.frm.beginTimegd.value+"000000";
					//document.frm.endTimegd.value=document.frm.endTimegd.value+"235959";
					var beginTimegdgai = document.frm.beginTimegd.value+"000000";
					var endTimegdgai = document.frm.endTimegd.value+"235959";
					
					
					var getdataPacket = new AJAXPacket("fe413_query.jsp","���ڻ�����ݣ����Ժ�......");
					getdataPacket.data.add("phoneNo",phonesno);
					getdataPacket.data.add("ykh_workNo",ykh_workNos);
					getdataPacket.data.add("renzhengtype",renzhengtypes);
					getdataPacket.data.add("beginTimegd",beginTimegdgai);
					getdataPacket.data.add("endTimegd",endTimegdgai);
					getdataPacket.data.add("opCode","<%=opCode%>");
					core.ajax.sendPacketHtml(getdataPacket,gongdanquery,true);
					getdataPacket = null;
						    }
						    else {//�����ѯ
						    var excelquery = document.frm.excelquery.value;
									    
									    if(excelquery=="0") {//ͳ�Ʋ�ѯ
									    
											var beginTimetjssss = document.frm.beginTimetj.value;
											var endTimetjssss = document.frm.endTimetj.value;
											
									    if(beginTimetjssss=="" && endTimetjssss=="") {
									rdShowMessageDialog("���в�ѯ�������ܶ�Ϊ�գ���������дһ�",0);
									return false;
					            }
					if(beginTimetjssss.substring(0,4)==endTimetjssss.substring(0,4)) {
						if(beginTimetjssss.substring(4,6)==endTimetjssss.substring(4,6)) {
							if(parseInt(beginTimetjssss.substring(6,8))>parseInt(endTimetjssss.substring(6,8))) {
						rdShowMessageDialog("������������Ӧ�ô��ڿ�ʼ����������",0);
						return false;
							}
							
						}
						 else {
						rdShowMessageDialog("��������·ݲ�ѯ��",0);
						return false;
					}
						
					}
					else {
						rdShowMessageDialog("���������ݲ�ѯ��",0);
						return false;
					}
									    
									    
									    select_crmtj(document.frm);
									    }else {//��ϸ��ѯ
									    
									    var beginTimemxssss = document.frm.beginTimemx.value;
											var endTimemxssss = document.frm.endTimemx.value;
											
									    if(beginTimemxssss=="" && endTimemxssss=="") {
									rdShowMessageDialog("���в�ѯ�������ܶ�Ϊ�գ���������дһ�",0);
									return false;
					            }
					if(beginTimemxssss.substring(0,4)==endTimemxssss.substring(0,4)) {
						if(beginTimemxssss.substring(4,6)==endTimemxssss.substring(4,6)) {
							if(parseInt(beginTimemxssss.substring(6,8))>parseInt(endTimemxssss.substring(6,8))) {
						rdShowMessageDialog("������������Ӧ�ô��ڿ�ʼ����������",0);
						return false;
							}
							
						}
						 else {
						rdShowMessageDialog("��������·ݲ�ѯ��",0);
						return false;
					}
						
					}
					else {
						rdShowMessageDialog("���������ݲ�ѯ��",0);
						return false;
					}
									    
									    
									    select_crmmx(document.frm);
									    }
 
						    }
				    }
		     }

					}
					
				function gongdanquery(data){
				//�ҵ���ӱ���div
				var markDiv=$("#gongdans"); 
				//���ԭ�б��
				markDiv.empty();
				markDiv.append(data);
				
		   }
		   

		 		 function select_crmtj(statement)
    {
				if(statement)
				{
					with(statement) 
					{

				hTableName.value="rbo006";
				hParams1.value= "prc_e413_tj_upg('"+document.frm.workNo.value+"','<%=groupssid%>','0','0','"+document.frm.beginTimetj.value+"','"+document.frm.endTimetj.value+"' ";
				//hParams1.value= "prc_2149_313_upg('"+document.frm.workNo.value+"','<%=groupssid%>','0','0','"+document.frm.beginTimetj.value+"','"+document.frm.endTimetj.value+"' ";
				action="<%=request.getContextPath()%>/npage/rpt/print_rpt_crm.jsp";
				frm.submit();  
				  }
				}
		 }
		 
		 		  function select_crmmx(statement)
    {
				if(statement)
				{
					with(statement) 
					{

				hTableName.value="rbo006";
				hParams1.value= "prc_e413_mx_upg('"+document.frm.workNo.value+"','<%=groupssid%>','0','0','"+document.frm.beginTimemx.value+"','"+document.frm.endTimemx.value+"' ";
				//hParams1.value= "prc_2148_311_upg('"+document.frm.workNo.value+"','','0','0','"+document.frm.beginTimetj.value+"','"+document.frm.endTimetj.value+"' ";
				action="<%=request.getContextPath()%>/npage/rpt/print_rpt_crm.jsp";
				frm.submit();  
				  }
				}
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
					onclick="opchange()">������ѯ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="opFlag" id="exceltype" value="two"
					onclick="opchange()">�����ѯ</td>
			</tr>
	</table>

    

			<div  id="gongds" name="gongds" class="itemContent">
					<table >
			 <tr>
		    <td class="blue" width="15%">Ԥ�����ֻ�����</td>
		    <td colspan="3">
		  <input name="phoneNo" type="text"   id="phoneNo" value=""  v_type="mobphone" onblur="checkElement(this)" >
		</td>

			
	</tr>
	<tr>
						    <td class="blue" width="15%">Ԥ��������</td>
            <td colspan="3">
			  <input name="ykh_workNo" type="text"   id="ykh_workNo" value=""  >
			  
	</tr>
		<tr >
			    <td class="blue" width="15%">֤������</td>
		    <td colspan="3">

						<input name="renzhengtype" type="text"   id="renzhengtype"  value="">

		 
		</td>		  
	 </tr >
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
			    <td class="blue" width="15%">�����ѯ����</td>
		    <td colspan="3">
		 				<select id="excelquery" name="excelquery" style="width:130px;" onChange="excelonch()">
						<option value="0">ͳ�Ʋ�ѯ</option>
						<option value="1">��ϸ��ѯ</option>
						</select>
						
		 
		</td>		  
	 </tr >
	 					<tr id="datetj" >
          <TD class="blue" >��ʼ����</TD>
          <TD >
            <input type="text" class="button" name="beginTimetj" style="width:127px;" size="20" maxlength="8" value=<%=mon[1]+"01"%>></TD>
          <TD class="blue" >��������</TD>
          <TD >
             <input type="text" class="button" name="endTimetj" style="width:127px;" size="20" maxlength="8" value=<%=dateStr%>></TD>
		</tr>
			 					<tr id="datemx" style="display:none">
          <TD class="blue" >��ʼ����</TD>
          <TD >
            <input type="text" class="button" name="beginTimemx" style="width:127px;" size="20" maxlength="8" value=<%=mon[1]+"01"%>></TD>
          <TD class="blue" >��������</TD>
          <TD >
             <input type="text" class="button" name="endTimemx" style="width:127px;" size="20" maxlength="8" value=<%=dateStr%>></TD>
		</tr>
			</table>
		</div>
 
	 	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
					<input type="button"  name="quchoose" class="b_foot" value="��ѯ" onclick="quechoosee()" />		
				&nbsp;
								<input name="back" onClick="history.go(-1)" type="button" class="b_foot"  value="����">
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
      <input type="hidden" name="org_code" value="<%=org_code%>">
      <input type="hidden" name="hDbLogin" value ="dbchange">
      <input type="hidden" name="rptright" value="D">
      <input type="hidden" name="hParams1" value="">
      <input type="hidden" name="hTableName" value="">
 <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>