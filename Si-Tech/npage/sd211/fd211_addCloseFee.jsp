<%
  /*
   * ����: ������vpmn�պ�Ⱥ�ʷѹ��� d211
   * �汾: 1.8.2
   * ����: 2011/2/24
   * ����: huangrong
   * ��Ȩ: si-tech
   * update:
  */
%>

              
<%
  String opCode = "d211";
  String opName = request.getParameter("opName");
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.sitech.boss.RoleManage.wrapper.*"%>



<%

	String powerCode2=(String)session.getAttribute("powerCode");
	ArrayList arr = RoleManageWrapper.getPowerCode1(powerCode2);
	ArrayList powerRightArr = RoleManageWrapper.getPowerRight();
		String[][] powerRight = (String[][])powerRightArr.get(0);


	 String region_name = "";
	 String regionName="";
	 String regionNameSql = "";
	String region_code = request.getParameter("add_region_code");
	String provinceFlg = request.getParameter("provinceFlg");
	  if(region_code!=null && region_code.length()<2){
	   region_code = "0"+region_code;
    }
    
 /*   
	if("100".equals(region_code)){
		region_name = "ȫʡ����";
	}else{
    regionNameSql ="  select region_name from sregioncode where region_code = "+region_code+"";
  }
 
 */
 
 	if("1".equals(provinceFlg)){
		regionName="select region_code,region_name from sregioncode where region_code in('01','02','03','04','05','06','07','08','09','10','11','12','13') order by to_number(region_code)";
	}else{
		regionName="select region_code,region_name from sregioncode where region_code='"+region_code+"'";
	}
  

	 %>
	 
	    	

	
	
<html>
<head>
<base target="_self">
<title>���������vpmn�պ�Ⱥ�ʷ�</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript">   
	
	function iframeClose(){
		var div_body = document.getElementById("divBody");
			div_body.style.display="none";
	}
	function add_submit(){
	
		
		var closeFee_code = document.form1.closeFee_code.value;
		var closeFee_name = document.form1.closeFee_name.value;
		var stop_time = document.form1.stop_time.value;
		var region_code = document.form1.region_code.value;
		if(region_code=='$$$$$$'){
			rdShowMessageDialog("��ѡ����Ҫ��ӵĵ���!");
			return false;
		}
		if(closeFee_code==''){
			rdShowMessageDialog("�ʷѱ�Ų���Ϊ��,����������!");
			return false;
		}
		if(closeFee_name==''){
			rdShowMessageDialog("�ʷ����Ʋ��ܿ�,����������!");
			return false;
		}
					if(stop_time==''){
				rdShowMessageDialog("��������ʷѽ���ʱ��!")
			  return false;
			}else{
				if(isNaN(stop_time)){
					rdShowMessageDialog("�ʷѽ���ʱ�䲻������,������������");
					return false;
				}else{
					if(stop_time.length!=8){
						rdShowMessageDialog("�ʷѽ���ʱ��ĸ�ʽΪ:YYYYMMDD,������������!");
					  return false;
					}
				}
			}
		parent.add_submit11();
	}
</script>
</head>

<body>
	<div id="divBody">

  <form name="form1"  method="post" action="fd211_addCloseFee_submit.jsp">
     
	 
   <DIV id="Operation_Table">                     


	<div class="title">
		<div id="title_zi">���������VPMN���ʷ�</div>
	</div>


				<table cellspacing="0" >
					<tr  height="22">				
	  					<TD width="16%" class="blue">&nbsp;&nbsp;&nbsp;����</TD>
	  					<TD width="34%" >
	  							<select name="region_code" v_name="����">
	  							<option value="$$$$$$">��ѡ��</option>
	  							<%
	  							if("1".equals(provinceFlg)){
	  							%>
	  							<option value="00">������</option>
	  							<%
	  							}
	  							%>
	  							
	  						
	  						<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=regionName%></wtc:sql>
 	              </wtc:pubselect>
	             <wtc:array id="result_t" scope="end"/>
	             <%
 							
 								String[][] retListString = new String[][]{};
 								if(code.equals("000000")&&result_t.length>0)
 								retListString = result_t;
								for(int i=0;i < retListString.length;i ++)
								{
							%>
    		          				<option value='<%=retListString[i][0]%>'><%=retListString[i][1]%></option>
							<%		
								}
							%>
	  					</select>&nbsp;<font class="orange">*<font>
	  		
	  						
	  						</TD>
	  					<TD width="16%" class="blue">&nbsp;&nbsp;&nbsp;�ʷѱ��</TD>
	  					<TD width="34%" >
	  						<input type="text" name="closeFee_code"/>&nbsp;<font class="orange">*<font>
	  						&nbsp;</TD>
	  		 </tr>		
	  		 
	  		 <tr  height="22">				
	  					<TD width="16%" class="blue">&nbsp;&nbsp;&nbsp;�ʷ�����</TD>
	  					<TD width="34%" >
	  							<input type="text" name="closeFee_name"/>&nbsp;<font class="orange">*<font>
	  						&nbsp;</TD>
	  					<TD width="16%" class="blue">&nbsp;&nbsp;&nbsp;�ʷ�ֹͣʱ��</TD>
	  					<TD width="34%" >
	  						<input type="text" name="stop_time"/>&nbsp;<font class="orange">*(��ʽΪYYYYMMDD)<font>
	  						&nbsp;</TD>
	  		 </tr>
	  		  <tr  height="22">				
	  					<TD width="16%" class="blue">&nbsp;&nbsp;&nbsp;Ȩ��</TD>
	  					<TD width="34%" colspan="3">
	  							<select  name="power_right">
									<%
									for(int i = 0 ; i<powerRight.length; i ++)
									{ %>
										<option value="<%=powerRight[i][0]%>" > <%=powerRight[i][0]+"->"+powerRight[i][1]%> </option>
									<%
									}
									%>
								</select>
	  						&nbsp;</TD>
	  						
	  					
	  		 </tr>
	  		
				  
			
				</table>
				
				<TABLE cellSpacing="0">
    <TBODY>
        <TR>
        	  <TD id="footer">
                <input class='b_foot' name=back onClick="add_submit()" style="cursor:hand" type=button value=�ύ>
           
          
                <input class='b_foot' name=back style="cursor:hand" type=reset value=����>
            
          
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


