<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * ����: ���ܹ�ϵά��
�� * �汾: 1.8.2
�� * ����: 2008/10/10
�� * ����: tancf
�� * ��Ȩ: sitech
	 *update:zhanghonga@2008-04-23
	 * update: yinzx 20090716 �ͷ����ܵ���
	 *                        1.�޸�opCode 2.�޸���ʽ
	 *                        3.�޸�ɽ������
	 *
��*/
%>
<%
		String opCode = "K095"  ;
		String opName = "���ܹ�ϵά��" ;

%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%   
		String    errCode ="";
		String    errMsg = " ";
		String return_sequence_no = "";
		String return_sequence_no1 = "";
%>	

	<wtc:service name="sRK160SelAll" outnum="7">
	</wtc:service>
	<wtc:array id="rows"  start="2"  length="2" scope="end"/>	
	<wtc:array id="rows1"  start="4"  length="3" scope="end"/>
	<%
 errCode=retCode;
 errMsg = retMsg;
   if((rows != null) && rows.length!=0)
  {
	return_sequence_no =rows[0][0];
	return_sequence_no1 =rows[0][1];  
  }
  
  %>
  


<html>
<head>
<title>����BOSS-���ܹ�ϵά��</title>
<script language="JavaScript">
	$(document).ready(
	function()
	{
		$("td").not("[input]").addClass("blue");
		$("td:not(#footer) input:button").addClass("b_text");
		$("#footer input:button").addClass("b_foot");
		$("input:text[@readonly]").addClass("InputGrey");
		}
	);
 
</script>

<script language="javaScript">
	 
	 function doProcess(packet)	 
	 {
	 	
	    var retType = packet.data.findValueByName("retType"); 
	    var retCode = packet.data.findValueByName("retCode"); 
	    var retMsg = packet.data.findValueByName("retMsg"); 
	    if(retType=="chkExample"){
	    	if(retCode=="000000"){
	    		//alert("����ɹ�!");
	    	}else{
	    		//alert("����ʧ��!");
	    		rdShowMessageDialog("����ʧ��!",1);
	    		return false;
	    	}
	    }
	 }
	 function doGenProcess(packet)	 
	 {
	 	
	    var retType = packet.data.findValueByName("retType"); 
	    var retCode = packet.data.findValueByName("retCode"); 
	    var retMsg = packet.data.findValueByName("retMsg"); 
	    if(retType=="chkExample"){
	    	if(retCode=="000000"){
	    		//alert("����ɹ�!");
	    		rdShowMessageDialog("���ܹ�ϵ������!",1);
	    	}else{
	    		//alert("����ʧ��!");
	    		rdShowMessageDialog("����ʧ��!",0);
	    		return false;
	    	}
	    }
	 }
	 
   function doCheck(box)
	 {   
	 var funcid = box.name;
	  var funcrel= box.value;
	  if(box.checked)
	 {
	 var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/config/systemRalation_save.jsp","���ڴ���,���Ժ�...");
	 }
	 else
	 {
	 var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/config/systemRalation_Del.jsp","���ڴ���,���Ժ�...");
	 }
     chkPacket.data.add("retType" ,  "chkExample");
     chkPacket.data.add("funcid" ,   funcid );
     chkPacket.data.add("funcrel" ,   funcrel );
     core.ajax.sendPacket(chkPacket,doProcess,true);
	 chkPacket =null;
		
	}
	
	function submitConfig()
	 {   
	   var chkPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/config/getRalationArray.jsp","���ڴ���,���Ժ�...");
       chkPacket.data.add("retType" ,  "chkExample");
       core.ajax.sendPacket(chkPacket,doGenProcess,true);
	   chkPacket =null;
	 }
	
</script>
</head>
<body>
<form action="" method=post name=form>
<%@ include file="/npage/include/header.jsp" %>
    <div class="title"><div id="title_zi">���ܹ�ϵά��</div></div>
 
    <table   cellspacing="0">
    <tr> 
      <td id="footer"  align=center> 
        	<input class="b_text" name="button1" type="button" value="����js�ļ�" onclick="submitConfig()">
   	 </td>
  	</tr>
   </table>
 
    <table cellspacing="0">
        
       <%
    	for(int i=0;i<rows.length;i++){
    	int k=0;
		%>
      <tr>
        <td width="1%" class="blue" ><%=rows[i][1] %></td>
        <td width="99%" class="blue">
			<table width="100%"   cellspacing="0" >
			<%
				 for(int j=i*(rows.length-1);j<(i+1)*(rows.length-1);j++){
					if(k%5==0){
			%>
			 <tr>
			<%
			}
			%>
				<td>
					<input type ="checkbox" name='<%=rows[i][0] %>' value='<%=rows1[j][0] %>' 
					<%if(rows1[j][2].equals("1")){%> checked<%}%>
					onclick="doCheck(this);" 
					> <%=rows1[j][1]%>
				</td>
			 <% 
			 k++;
			 if(k%5==0){
			 %>
			 </tr>
			 <%
						}
			} 
         %>
         </table>
        </td>
      </tr>
      <%
		}
	  %>
  </table>
</div>
<%@ include file="/npage/include/footer.jsp" %>
 </form>
</body>
</html>

