   
<%
/********************
 version v2.0
 ������ si-tech
 create wanghlc@2009-8-26
********************/
%>
              
<%
  String opCode = "4515";
  String opName = request.getParameter("opName");
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*"%>



<%
   String dateStr = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date());

	
	//��ȡ�û�session��Ϣ
	String region_code = request.getParameter("regionCode");
  String pkg_code = request.getParameter("pkgCode");
  String regionNameSql="  select region_name from sregioncode where region_code = "+region_code+"";
 // String pkgNameSql = "  select trim(pkg_name) from svpmnpkgcode where region_code = "+region_code+" and pkg_code ='"+pkg_code+"'";
  String pkgNameSql="select trim(offer_name) from product_offer where offer_id="+pkg_code;
  String region_name = "";
  String pkg_name = "";
  if(region_code!=null && region_code.length()<2){
	region_code = "0"+region_code;
}
	 %>
	 <wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=regionNameSql%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_region_name" scope="end"/>
	    	
	  <%
		if(code.equals("000000")&&result_region_name.length>0) {   	
	   	 	region_name = result_region_name[0][0];
	   }
	  %>
	 <wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=pkgNameSql%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_pkg_name" scope="end"/>
	 <%
		if(code.equals("000000")&&result_pkg_name.length>0) {   	
	   	 	pkg_name = result_pkg_name[0][0];
	   	 
	   }
	 %>
	
<html>
<head>
<base target="_self">
<title>���������VPMN����</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript">   
	var oXmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	var region_code = <%=region_code%>;
	var pkg_code = <%=pkg_code%>;
	 function submit_add(){
	 	
	 		var start_year  = document.form1.start_year.value;
	 		var end_year    = document.form1.end_year.value;
	 		var start_month = document.form1.start_month.value;
	 		var end_month   = document.form1.end_month.value;
	 		var start_day  = document.form1.start_day.value;
	 		var end_day     = document.form1.end_day.value;
	 		var start_hours  = document.form1.start_hours.value;
	 		var end_hours   = document.form1.end_hours.value;
	 	    var start_minute   = document.form1.start_minute.value;
	 		var end_minute   = document.form1.end_minute.value;
	 		 /*** diling add@2011/10/1 ���ӿ�ʼ�֣������ֵ�У�� start ***/
	 		if(start_year==""&&end_year==""&&start_month==""&&end_month==""&&start_day==""&&end_day==""&&start_hours==""&&end_hours==""&&start_minute==""&&end_minute==""){
	 			rdShowMessageDialog("���е����Ʋ��ܶ�Ϊ��,����������д!")
	 			return false;
	 		}
	 		/*** diling add@2011/10/1 ���ӿ�ʼ�֣������ֵ�У��  end ***/
	 		
	 	if(start_year!=""){
	 		if(isNaN(start_year)){
	 				rdShowMessageDialog("��ʼ�겻������,����������!");
	 				return false;
	 		}else if(start_year.length!=4){
	 			   rdShowMessageDialog("��ʼ��Ӧ��Ϊ4λ,����������!!");
	 				return false;
	 		}
	 	}
	 	if(end_year!=""){
	 		if(isNaN(end_year)){
	 				rdShowMessageDialog("�����겻������,����������!");
	 				return false;
	 		}else if(end_year.length!=4){
	 			   rdShowMessageDialog("������Ӧ��Ϊ4λ,����������!!");
	 				return false;
	 		}
	 	}
	 	if(start_month!=""){
	 		if(isNaN(start_month)){
	 				rdShowMessageDialog("��ʼ�²�������,����������!");
	 				return false;
	 		}else if(start_month.length!=1&&start_month.length!=2){
	 			  rdShowMessageDialog("��ʼ��Ӧ��Ϊ1λ��2λ,����������!!");
	 				return false;
	 		}else if(start_month<1||start_month>12){
	 			 rdShowMessageDialog("��ʼ��Ӧ��Ϊ1--12,����������!!");
	 				return false;
	 		}
	 	}
	 	if(end_month!=""){
	 		if(isNaN(end_month)){
	 				rdShowMessageDialog("�����²�������,����������!");
	 				return false;
	 		}else if(end_month.length!=1&&end_month.length!=2){
	 			  rdShowMessageDialog("������Ӧ��Ϊ1λ��2λ,����������!!");
	 				return false;
	 		}else if(end_month<1||end_month>12){
	 			 rdShowMessageDialog("������Ӧ��Ϊ1--12,����������!!");
	 				return false;
	 		}
	 	}
	 	 if(start_day!=""){
	 		if(isNaN(start_day)){
	 				rdShowMessageDialog("��ʼ�첻������,����������!");
	 				return false;
	 		}else if(start_day.length!=1&&start_day.length!=2){
	 			  rdShowMessageDialog("��ʼ��Ӧ��Ϊ1λ��2λ,����������!!");
	 				return false;
	 		}else if(start_day<1||start_day>31){
	 			 rdShowMessageDialog("��ʼ��Ӧ��Ϊ1--31,����������!!");
	 				return false;
	 		}
	 	}
	 	
	 	if(end_day!=""){
	 		if(isNaN(end_day)){
	 				rdShowMessageDialog("�����첻������,����������!");
	 				return false;
	 		}else if(end_day.length!=1&&end_day.length!=2){
	 			  rdShowMessageDialog("������Ӧ��Ϊ1λ��2λ,����������!!");
	 				return false;
	 		}else if(end_day<1||end_day>31){
	 			 rdShowMessageDialog("������Ӧ��Ϊ1--31,����������!!");
	 				return false;
	 		}
	 	}

	 	 if(start_hours!=""){
	 		if(isNaN(start_hours)){
	 				rdShowMessageDialog("��ʼʱ��������,����������!");
	 				return false;
	 		}else if(start_hours.length!=1&&start_hours.length!=2){
	 			  rdShowMessageDialog("��ʼʱӦ��Ϊ1λ��2λ,����������!!");
	 				return false;
	 		}else if(start_hours<0||start_hours>23){
	 			 rdShowMessageDialog("��ʼʱӦ��Ϊ0--23,����������!!");
	 				return false;
	 		}
	 	}
	 	
        if(end_hours!=""){
    	 		if(isNaN(end_hours)){
    	 				rdShowMessageDialog("����ʱ��������,����������!");
    	 				return false;
    	 		}else if(end_hours.length!=1&&end_hours.length!=2){
    	 			  rdShowMessageDialog("����ʱӦ��Ϊ1λ��2λ,����������!!");
    	 				return false;
    	 		}else if(end_hours<0||end_hours>23){                 // diling update@2011/10/1 ����ʱӦ��Ϊ1��24 ��Ϊ��0��23
    	 			 rdShowMessageDialog("����ʱӦ��Ϊ0--23,����������!!");
    	 				return false;
    	 		}
    	 	}
	 	
	 	/*** diling add@2011/10/1 ���ӿ�ʼ�֣������ֵ�У�� start ***/
	 	if(start_minute!=""){
	 		if(isNaN(start_minute)){
	 				rdShowMessageDialog("��ʼ�ֲ�������,����������!");
	 				return false;
	 		}else if((start_minute.length!=1)&&(start_minute.length!=2)){
	 			   rdShowMessageDialog("��ʼ��Ӧ��Ϊ1λ��2λ,����������!!");
	 				return false;
	 		}else if(start_minute<0||start_minute>59){
	 			 rdShowMessageDialog("��ʼ��Ӧ��Ϊ0--59,����������!!");
	 				return false;
	 		}
	 	}
	 	
	 	if(end_minute!=""){
	 		if(isNaN(end_minute)){
	 				rdShowMessageDialog("�����ֲ�������,����������!");
	 				return false;
	 		}else if((start_minute.length!=1)&&(start_minute.length!=2)){
	 			   rdShowMessageDialog("������Ӧ��Ϊ1λ��2λ,����������!!");
	 				return false;
	 		}else if(end_minute<1||end_minute>60){
	 			 rdShowMessageDialog("������Ӧ��Ϊ1--60,����������!!");
	 				return false;
	 		}
	 	}
	 	
	 /*** diling add@2011/10/1 ���ӿ�ʼ�֣������ֵ�У��  end ***/
	 	
	 	
	  if(start_year!=""&&end_year!=""&&(parseInt(start_year)>parseInt(end_year))){
	 		 rdShowMessageDialog("��ʼ�겻Ӧ�ô��ڽ�����,����������!");
	 		 return false;
	 	}else if(start_month!=""&&end_month!=""&&(parseInt(start_month)>parseInt(end_month))){
	 		 rdShowMessageDialog("��ʼ�²�Ӧ�ô��ڽ�����,����������!");
	 		 return false;
	 	}else if(start_day!=""&&end_day!=""&&(parseInt(start_day)>parseInt(end_day))){
	 		 rdShowMessageDialog("��ʼ�첻Ӧ�ô��ڽ�����,����������!");
	 		 return false;
	 	}else if(start_hours!=""&&end_hours!=""&&(parseInt(start_hours)>parseInt(end_hours))){  //diling update@2011/10/1 ��ʼʱӦ��С�ڽ���ʱ ��Ϊ:��ʼʱ��Ӧ�ô��ڽ���ʱ
	 		 rdShowMessageDialog("��ʼʱ��Ӧ�ô��ڽ���ʱ,����������!");
	 		 return false;
	 	}else if(start_minute!=""&&end_minute!=""&&(parseInt(start_minute)>=parseInt(end_minute))){ //diling add
	 		 rdShowMessageDialog("��ʼ��Ӧ��С�ڽ�����,����������!");
	 		 return false;
	 	}
	 	
	 	if(start_year==""&&end_year!=""){
	 		 start_year ='<%=dateStr%>';
	 		 
	 	}else if(start_year!=""&&end_year==""){
	 		 end_year='2050';
	 	}
	 	
	 	if(start_month==""&&end_month!=""){
	 		 start_month='1';
	 	}else if(start_month!=""&&end_month==""){
	 		 end_month='12';
	 	}
	 	
	 	if(start_day==""&&end_day!=""){
	 		 start_day = '1';
	 	}else if(start_day!=""&&end_day==""){
	 		end_day='31';
	 	}
	 	
	 	if(start_hours==""&&end_hours!=""){
	 		 start_hours = '0';
	 		 
	 	}else if(start_hours!=""&&end_hours==""){  //diling update@2011/10/1 ���ý���ʱΪ�գ���ʼʱ��Ϊ��ʱ�������ֱ���ֵΪ23
	 		  end_hours='23';
	 	}
	 	
	 	
	 	if(start_minute==""&&end_minute!=""){ //diling add
	 		 start_minute = '0';
	 		 
	 	}else if(start_minute!=""&&end_minute==""){
	 		 end_minute='60';
	 	}
	 	
	 	
	
	 		var toURL = "f4515_add_submit.jsp?start_year="+start_year+"&end_year="+end_year+"&start_month="+start_month+"&end_month="+end_month+"&start_day="+start_day+"&end_day="+end_day+"&start_hours="+start_hours+"&end_hours="+end_hours+"&region_code="+region_code+"&pkg_code="+pkg_code+"&start_minute="+start_minute+"&end_minute="+end_minute; //diling add ���ӿ�ʼ�֣������ֲ���
		
      connectToSpec11(toURL,waitingDataSpec1);
			}
			
  function connectToSpec11(toURL,var_func1){
	oXmlHttp.Open("POST", toURL, true);
	oXmlHttp.onreadystatechange = var_func1;	
	try{
		oXmlHttp.Send();
	}catch(err){
		rdShowMessageDialog("�޷�������WWW��������");		
	}
}

function waitingDataSpec1(){
	var state = oXmlHttp.readyState;
	if(state == 4){
		
		if(oXmlHttp.status!="200"){
			rdShowMessageDialog(oXmlHttp.statusText);
			rdShowMessageDialog("�޷���ȡ������Ҫ�����ݣ������Ƿ�����æ��ϵͳ��������\r\n\r\n���������µ�¼һ�κ��ظ��˲��������������ɣ����֪����Ա��");			
		}else{
			var xmldoc = new ActiveXObject("Msxml.DOMDocument");
			xmldoc.async = false;
			xmldoc.load(oXmlHttp.responseXML);
			if(xmldoc.parseError.errorCode != 0){
				rdShowMessageDialog("error: " + xmldoc.parseError.reason);
			}else{
				   var xx=xmldoc.selectSingleNode("//rows/f1");
			      var yy=xmldoc.selectSingleNode("//rows/f2");			
    			  if  (xx!=null){ 
    		    }
    			   if(yy!=null){ 
    				  rdShowMessageDialog(yy.text);
    				  window.close();
    				  opener.location.href="f4515_main.jsp?regionCode="+region_code+"&pkgCode="+pkg_code;
    				  
    		    }	
    	 }
			}		
		}
	}	


	
</script>
</head>

<body>
	<div id="divBody">

  <form name="form1"  method="post" action="f4515_add_submit.jsp">
     
	 
   <DIV id="Operation_Table">                     


	<div class="title">
		<div id="title_zi">���������VPMN����</div>
	</div>


				<table cellspacing="0" >
					<tr  height="22">				
	  					<TD width="16%" class="blue">&nbsp;&nbsp;&nbsp;����</TD>
	  					<TD width="34%" ><%=region_name%>&nbsp;</TD>
	  					<TD width="16%" class="blue">&nbsp;&nbsp;&nbsp;�����ʷ�����</TD>
	  					<TD width="34%" ><%=pkg_name%>&nbsp;</TD>
	  		 </tr>		
	  					
	  		 <tr>
	  					<TD width="16%" class="blue">&nbsp;&nbsp;&nbsp;��ʼ��</TD>
	  					<TD width="34%" class="blue"><input type="text" name="start_year"/>&nbsp; <font class="orange">(��ʽΪYYYY)<font></TD>
	  					<TD width="16%" class="blue">&nbsp;&nbsp;&nbsp;������</TD>
	  				  <TD width="34%" class="blue"><input type="text" name="end_year"/>&nbsp; <font class="orange">(��ʽΪYYYY)<font></TD>    
				  </tr>	
				  
				   <tr>
	  					<TD width="16%" class="blue">&nbsp;&nbsp;&nbsp;��ʼ��</TD>
	  					<TD width="34%" class="blue"><input type="text" name="start_month"/>&nbsp; <font class="orange">(��ʽΪ1~12)<font>  </TD>
	  					<TD width="16%" class="blue">&nbsp;&nbsp;&nbsp;������</TD>
	  				  <TD width="34%" class="blue"><input type="text" name="end_month"/>&nbsp; <font class="orange">(��ʽΪ1~12)<font></TD>    
				  </tr>
				  
				   <tr>
	  					<TD width="16%" class="blue">&nbsp;&nbsp;&nbsp;��ʼ��</TD>
	  					<TD width="34%" class="blue"><input type="text" name="start_day"/>&nbsp; <font class="orange">(��ʽΪ1~31)<font></TD>
	  					<TD width="16%" class="blue">&nbsp;&nbsp;&nbsp;������</TD>
	  				  <TD width="34%" class="blue"><input type="text" name="end_day"/>&nbsp; <font class="orange">(��ʽΪ1~31)<font></TD>    
				  </tr>
				  
				   <tr>
	  					<TD width="16%" class="blue">&nbsp;&nbsp;&nbsp;��ʼʱ</TD>
	  					<TD width="34%" class="blue"><input type="text" name="start_hours"/>&nbsp; <font class="orange">(��ʽΪ0~23)<font></TD>
	  					<TD width="16%" class="blue">&nbsp;&nbsp;&nbsp;����ʱ</TD>
	  				  <TD width="34%" class="blue"><input type="text" name="end_hours"/>&nbsp; <font class="orange">(��ʽΪ0~23)<font></TD>    <%//diling update@2011/10/1 ����ʱӦ��Ϊ1��24 ��Ϊ��0��23 %>
				  </tr>
				    <%/** diling add @2011/10/1 ���ӿ�ʼ�֣������ֵ�չʾ start  **/%>
				  <tr>
	  					<TD width="16%" class="blue">&nbsp;&nbsp;&nbsp;��ʼ��</TD>
	  					<TD width="34%" class="blue"><input type="text" name="start_minute"/>&nbsp; <font class="orange">(��ʽΪ0~59)<font></TD>
	  					<TD width="16%" class="blue">&nbsp;&nbsp;&nbsp;������</TD>
	  				  <TD width="34%" class="blue"><input type="text" name="end_minute"/>&nbsp; <font class="orange">(��ʽΪ1~60)<font></TD>    
				  </tr>
				    <%/** diling add @2011/10/1 ���ӿ�ʼ�֣������ֵ�չʾ end  **/%>
				  <input type="hidden" name="region_code" value="<%=region_code%>"/>
				  <input type="hidden" name="pkg_code" value="<%=pkg_code%>"/>
				</table>
				
				<TABLE cellSpacing="0">
    <TBODY>
        <TR>
        	  <TD id="footer">
                <input class='b_foot' name=back onClick="submit_add()" style="cursor:hand" type=button value=�ύ>
           
          
                <input class='b_foot' name=back style="cursor:hand" type=reset value=����>
            
          
                <input class='b_foot' name=back onClick="window.close()" style="cursor:hand" type=button value=�ر�>
            </TD>
        </TR>
    </TBODY>
</TABLE>	

	 <%@ include file="/npage/include/footer.jsp" %>
	  </form>
 </div>
</body>
</html>

