   
<%
/********************
 version v2.0
 ������ si-tech
 create huangrong 2010-10-29 17:32
********************/
%>
              
<%
  String opCode = "b809";
  String opName = request.getParameter("opName");
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=GBK"%>

<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.text.*"%>

<%


	
	//��ȡ�û�session��Ϣ
	String region_code = request.getParameter("regionCode");
	String work_no = (String)session.getAttribute("workNo");
  String feeIndex_code = request.getParameter("feeIndexCode");
   if(region_code!=null && region_code.length()<2){
	region_code = "0"+region_code;
}
  String regionNameSql="  select region_name from sregioncode where region_code = '"+region_code+"'";
  String feeIndexNameSql = "  select trim(offer_name) from product_offer where offer_id = '"+feeIndex_code+"'";
  String feeIndexDetail=" select nvl(start_year, ''), nvl(end_year, ''), nvl(start_month, ' '),nvl(end_month, ' '),nvl(start_day, ' '),nvl(end_day, ' '),nvl(start_hours, ' '),nvl(end_hours, ' ') , nvl (start_minute ,' ' ) , nvl ( end_minute , ' ')  ,fee_id  from svpmnfeeindexconfig  where region_code = '"+region_code+"'  and feeindex = '"+feeIndex_code+"'  order by fee_id";
  System.out.println("feeIndexDetail=====================================================||||||||||||||||||||||||||||");
 System.out.println("feeIndexDetail="+feeIndexDetail);
 
  String region_name = "";
  String feeIndex_name = "";
  String feeIndex_detail[][] = new String[][]{};
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
  	           <wtc:sql><%=feeIndexNameSql%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_feeIndex_name" scope="end"/>
	 <%
		if(code.equals("000000")&&result_feeIndex_name.length>0) {   	
	   	 	feeIndex_name = result_feeIndex_name[0][0];
	   }
	 %>
	
	
<html>
<head>
<base target="_self">
<title>���������VPMN���ײ���ϸ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript">   
	function addConfig(){
		var regionCode = <%=region_code%>;
		var feeIndexCode = <%=feeIndex_code%>;
		window.open("fb809_add.jsp?regionCode="+regionCode+"&feeIndexCode="+feeIndexCode,"","width="+(screen.availWidth*1-500)+",height="+(screen.availHeight*1-540) +",left=350,top=200,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no");    		
	}
	function deleteConfig(p){
		var code = p;
		var feeIndex_code = <%=feeIndex_code%>;
		var region_code = <%=region_code%>;
		
		window.open("fb809_delete.jsp?feeIndex_id="+code+"&region_code="+region_code+"&feeIndex_code="+feeIndex_code,"","width="+(screen.availWidth*1-500)+",height="+(screen.availHeight*1-540) +",left=350,top=200,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no");    	
		
		
	}
	function iframeClose(){
		var div_body = document.getElementById("divBody");
			div_body.style.display="none";
	}
	
</script>
</head>

<body>
	<div id="divBody">

  <form name="form1"  method="post">
     
	 
   <DIV id="Operation_Table">                     


	<div class="title">
		<div id="title_zi">���������VPMN���ײ���ϸ����</div>
	</div>


				<table cellspacing="0" >
					<tr  height="22">
							<TD width="" class="blue">&nbsp;&nbsp;&nbsp;���</TD>						
	  					<TD width="" class="blue">&nbsp;&nbsp;&nbsp;����</TD>
	  					<TD width="" class="blue">&nbsp;&nbsp;&nbsp;�ʷ���������</TD>
	  					<TD width="" class="blue">&nbsp;&nbsp;&nbsp;��ʼ��</TD>
	  					<TD width="" class="blue">&nbsp;&nbsp;&nbsp;������</TD>
	  					<TD width="" class="blue">&nbsp;&nbsp;&nbsp;��ʼ��</TD>
	  					<TD width="" class="blue">&nbsp;&nbsp;&nbsp;������</TD>
	  					<TD width="" class="blue">&nbsp;&nbsp;&nbsp;��ʼ��</TD>
	  					<TD width="" class="blue">&nbsp;&nbsp;&nbsp;������</TD>
	  					<TD width="" class="blue">&nbsp;&nbsp;&nbsp;��ʼʱ</TD>
	  					<TD width="" class="blue">&nbsp;&nbsp;&nbsp;����ʱ</TD>
	  					<TD width="" class="blue">&nbsp;&nbsp;&nbsp;��ʼ��</TD> <%//diling add@2011/10/1 %>
	  					<TD width="" class="blue">&nbsp;&nbsp;&nbsp;������</TD>
	  					<TD width="" class="blue">&nbsp;&nbsp;&nbsp;����</TD>    
				  </tr>	
	  <wtc:pubselect name="sPubSelect" outnum="11" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=feeIndexDetail%></wtc:sql>
 	  </wtc:pubselect>
	  <wtc:array id="result_feeIndex_detail" scope="end"/> 	
				  <%
				  		if(code.equals("000000")&&result_feeIndex_detail.length>0){
				  			feeIndex_detail = result_feeIndex_detail;
				  			for(int i=0;i<feeIndex_detail.length;i++){
				  			%>
								  <tr  height="22">
								  <TD align="center" class="blue"><%=i+1%>&nbsp;</TD>
								  <TD align="center"><%=region_name%>&nbsp;</TD>	<TD align="center"><%=feeIndex_name%>&nbsp;</TD>
								  <TD align="center"><%=feeIndex_detail[i][0]%>&nbsp;</TD>	<TD align="center"><%=feeIndex_detail[i][1]%>&nbsp;</TD>
								  <TD align="center"><%=feeIndex_detail[i][2]%>&nbsp;</TD>	<TD align="center"><%=feeIndex_detail[i][3]%>&nbsp;</TD>
								  <TD align="center"><%=feeIndex_detail[i][4]%>&nbsp;</TD>	<TD align="center"><%=feeIndex_detail[i][5]%>&nbsp;</TD>
								  <TD align="center"><%=feeIndex_detail[i][6]%>&nbsp;</TD>	<TD align="center"><%=feeIndex_detail[i][7]%>&nbsp;</TD>
								  <TD align="center"><%=feeIndex_detail[i][8]%>&nbsp;</TD>	<TD align="center"><%=feeIndex_detail[i][9]%>&nbsp;</TD> <%//diling add@2011/10/1 ���ӿ�ʼ�֣������ֵ�չʾ %>
								  <TD align="center">
								  	<input  style="cursor:hand" type="button" value="ɾ��" class="b_text"  onclick="deleteConfig('<%=feeIndex_detail[i][10]%>')"/><%//diling update %>
								  	</TD>
								  </tr>	
							  <%
				  			}
				  		}else{%>
				  			
				  			<tr  height="22">
				  			<TD align="center" colspan="14">���ʷ�û��������Ϣ!&nbsp;</TD>
				  			</tr>
				  			<%
				  			}
				  %>
				  <tr  height="22">
				  		<TD align="right" colspan="14">
				  			<input  style="cursor:hand" type="button" value="�������" class="b_text" onclick="addConfig()"/>
				  			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				  			</TD>
				  </tr>
				  
				</table>
				
				<TABLE cellSpacing="0">
    <TBODY>
        <TR>
            <TD id="footer">
                <input class='b_foot' name=back onClick="iframeClose()" style="cursor:hand" type=button value=�ر�>
            </TD>
        </TR>
    </TBODY>
</TABLE>	


	 <%@ include file="/npage/include/footer.jsp" %>
	  </form>
 </div>
</body>
</html>


