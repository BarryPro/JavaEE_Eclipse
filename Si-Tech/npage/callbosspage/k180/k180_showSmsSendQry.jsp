<%
  /*
   * ����: ���ŷ��Ͳ�ѯ����¼��Ϣ
�� * �汾: 1.0
�� * ����: 2008/11/04
�� * ����: hanjc
�� * ��Ȩ: sitech
   *  
 ��*/
 %>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>

<%
    String opCode="k180";
    String opName="���ŷ��Ͳ�ѯ-����¼��Ϣ";
	  String loginNo = (String)session.getAttribute("workNo");  
	  	    /*midify by yinzx 20091113 ������ѯ�����滻*/
    String myParams="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
	  String user_phone = (String)request.getParameter("user_phone");
	  String serial_no = (String)request.getParameter("serial_no");
 
	  String[][] dataRows = new String[][]{};
    String sqlStr = "select to_char(SERIAL_NO),SERV_NO,OUT_GATEWAY_ID,USER_PHONE,LONG_SERV_NO,SERV_CODE,to_char(INSERT_TIME,'yy-MM-dd hh24:mi:ss'),to_char(VALID_TIME,'yy-MM-dd hh24:mi:ss'),to_char(SEND_TIME,'yy-MM-dd hh24:mi:ss'),decode(trim(serv_type),'01','��ͨ����','03','WAP PUSH����'),SEND_FLAG,SEND_CONTENT,SEND_URL from sms_push_rec_log where serial_no=:vserial_no";
    myParams="vserial_no="+serial_no;
        %>		           
           <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="15">
						<wtc:param value="<%=sqlStr%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
				<wtc:array id="queryList" start="0" length="15" scope="end"/>
				<%
				dataRows = queryList;
	//for(int i=0;i<dataRows[0].length;i++){
  //  	System.out.println("======dataRows[0]["+i+"]====="+dataRows[0][i]);
	//}
	
	
	sqlStr="select region_name from scallregioncode";
	%>		           
           <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
						<wtc:param value="<%=sqlStr%>"/>
					</wtc:service>
				<wtc:array id="queryList" scope="end"/>
	<%
		for(int i=0;i<queryList[0].length;i++){
    	System.out.println("======queryList[0]["+i+"]====="+queryList[0][i]);
	}
	
%>

<html>
<head>
<title>���ŷ���</title>
<script language=javascript>
	$(document).ready(
		function()
		{
	    $("td").not("[input]").addClass("blue");
			$("#footer input:button").addClass("b_foot");
			$("td:not(#footer) input:button").addClass("b_text");
			$("input:text[@v_type]").blur(checkElement2);	
		
			$("a").hover(function() {
				$(this).css("color", "orange");
			}, function() {
				$(this).css("color", "blue");
			});
		}
	);

	function checkElement2() { 
				checkElement(this); 
		}	
		
 function winClose(){
   window.close();	
 }

</script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
</head>

<body >
<form id=sitechform name=sitechform>
<%@ include file="/npage/include/header.jsp"%>
		<table cellspacing="0" border ="0"> 
		    <!-- THE FIRST LINE OF THE CONTENT -->
      <tr >
	     <td > ��ˮ�� </td>
	     <td >
				<input id="serial_no" name="serial_no" type="text" value="<%=(dataRows.length==0||(dataRows.length!=0&&dataRows[0][0]==null))?"":dataRows[0][0]%>">
	     </td>
	     <td > ҵ�����ͺ��� </td>
	     <td >
			  <input name="serv_no" id="serv_no" type="text" value="<%=(dataRows.length==0||(dataRows.length!=0&&dataRows[0][1]==null))?"":dataRows[0][1]%>">
	     </td>
	     <td > ����ID </td>
	     <td >
			  <input name="out_gateway_id" id="out_gateway_id" type="text" value="<%=(dataRows.length==0||(dataRows.length!=0&&dataRows[0][2]==null))?"":dataRows[0][2]%>">
	     </td>
	   </tr>
	   <!-- THE SECOND LINE OF THE CONTENT -->
	   <tr >
	     <td > �û����� </td>
	     <td colspan="5">
			  <textarea name="user_phone" id="user_phone" rows="1" cols="115" STYLE="overflow:hidden" ><%=(dataRows.length==0||(dataRows.length!=0&&dataRows[0][3]==null))?"":dataRows[0][3]%></textArea>
		  </td>     
   
	    </tr>
	    
	    	   <!-- THE THIRD LINE OF THE CONTENT -->
	   <tr >
	     <td > �·����� </td>
	     <td colspan="5">
			  <textarea name="long_serv_no" id="long_serv_no" rows="1" cols="115" STYLE="overflow:hidden" ><%=(dataRows.length==0||(dataRows.length!=0&&dataRows[0][4]==null))?"":dataRows[0][4]%></textArea>
		  </td>     
	    </tr>
	    
	    	   <!-- THE FOURTH LINE OF THE CONTENT -->
	   <tr >
	     <td > ������� </td>
	     <td>
			  <input name ="serv_code" type="text" id="serv_code"  value="<%=(dataRows.length==0||(dataRows.length!=0&&dataRows[0][5]==null))?"":dataRows[0][5]%>">
		  </td>     
		  <td> ��ʼʱ��</td>
	     <td>
			  <input name ="insert_time" type="text" id="insert_time" value="<%=(dataRows.length==0||(dataRows.length!=0&&dataRows[0][6]==null))?"":dataRows[0][6]%>">
		  </td>  
		  <td> ʧЧʱ��</td>
	     <td>
			  <input name ="valid_time" type="text" id="valid_time" value="<%=(dataRows.length==0||(dataRows.length!=0&&dataRows[0][7]==null))?"":dataRows[0][7]%>">
		  </td>      
	    </tr>
	    
	    	   <!-- THE FIFTH LINE OF THE CONTENT -->
	   <tr >
	     <td > ����ʱ�� </td>
	     <td>
			  <input name ="send_time" type="text" id="send_time" value="<%=(dataRows.length==0||(dataRows.length!=0&&dataRows[0][8]==null))?"":dataRows[0][8]%>">
		  </td>     
		  <td > ��������</td>
	     <td>
			  <input name ="serv_type" type="text" id="serv_type" value="<%=(dataRows.length==0||(dataRows.length!=0&&dataRows[0][9]==null))?"":dataRows[0][9]%>">
		  </td>  
		  <td  colspan="2"> &nbsp;</td>
   
	    </tr>
	    
		<br>
    <br> 
    	<tr>
    		<td>��������</td>
    		<td colspan="5">
    	 <p><textarea name="send_content" id="send_content" rows="3" cols="115"><%=(dataRows.length==0||(dataRows.length!=0&&dataRows[0][11]==null))?"":dataRows[0][11]%></textArea></p>
    	</td>
      </tr>
      
    <br> 
    	<tr>
    		<td>�·�URL��ַ</td>
    		<td colspan="5">
    	 <textarea name="send_url" id="send_url" rows="3" cols="115" ><%=(dataRows.length==0||(dataRows.length!=0&&dataRows[0][12]==null))?"":dataRows[0][12]%></textArea>
    	</td>
      </tr>
      
          <tr >
      <td colspan="6" align="right" id="footer" style="width:420px">
       <input name="ok" type="button"  value="ȷ��" onClick="winClose()"> 
       <input name="cancle" type="button" value="ȡ��" onClick="winClose()">
      </td>
    </tr>
		</table>
		
		<br>
</form>
<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>

