<%
  /*
   * ����: ���ʷѱ��1270
   * �汾: 1.8.2
   * ����: 2005/12/17
   * ����: libin
   * ��Ȩ: si-tech
   * update:wuln@2008-4-12
  */
%>

              
<%
  String opCode = "d211";
  String opName = request.getParameter("opName");
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=GBK"%>

<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.text.*"%>
<%@ page import="com.sitech.boss.RoleManage.wrapper.*"%>

<%

		String powerCode2=(String)session.getAttribute("powerCode");
	ArrayList arr = RoleManageWrapper.getPowerCode1(powerCode2);
	ArrayList powerRightArr = RoleManageWrapper.getPowerRight();
		String[][] powerRight = (String[][])powerRightArr.get(0);

	
	//��ȡ�û�session��Ϣ
	String region_code = request.getParameter("regionCode");
	String work_no = (String)session.getAttribute("workNo");
  String closeFee_code = request.getParameter("closeFeeCode");
   if(region_code!=null && region_code.length()<2){
	 region_code = "0"+region_code;
  }
  String regionNameSql="  select region_name from sregioncode where region_code = '"+region_code+"'";
  String closeFeeNameSql = "  select trim(feeindex_name),to_char(stop_time,'YYYYMMDD'),trim(power_right) from sclosefeeindex where region_code = '"+region_code+"' and feeindex ='"+closeFee_code+"'";
 
  String region_name = "";
  String closeFee_name = "";
  String stop_time = "";
  String power_right = "";
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
	 <wtc:pubselect name="sPubSelect" outnum="3" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	           <wtc:sql><%=closeFeeNameSql%></wtc:sql>
 	    </wtc:pubselect>
	    <wtc:array id="result_closeFee_name" scope="end"/>
	 <%
		if(code.equals("000000")&&result_closeFee_name.length>0) {   	
	   	 	closeFee_name = result_closeFee_name[0][0];
	   	 	stop_time = result_closeFee_name[0][1];
	   	 	power_right = result_closeFee_name[0][2];
	   }
	 %>
	
	
<html>
<head>
<base target="_self">
<title>������vpmn�պ�Ⱥ�ʷ�������ϸ���</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript">   
	
	
	function iframeClose(){
		var div_body = document.getElementById("divBody");
			div_body.style.display="none";
	}
	
	function update_submit(){
			var stop_time = document.form1.stop_time.value;
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
			document.form1.submit();
	}
	
</script>
</head>

<body>
	<div id="divBody">

  <form name="form1"  method="post" action="fd211_updateCloseFee_submit.jsp">
     
	 
   <DIV id="Operation_Table">                     


	<div class="title">
		<div id="title_zi">������vpmn�պ�Ⱥ�ʷ��޸�</div>
	</div>


				<table cellspacing="0" >
					<tr  height="22">
												
	  					<TD width="15%" class="blue">&nbsp;&nbsp;&nbsp;����</TD>
	  					<TD width="35%" class="blue">&nbsp;&nbsp;&nbsp;<%=region_name%></TD>
	  					<TD width="15%" class="blue">&nbsp;&nbsp;&nbsp;�ʷ�����</TD>
	  					<TD width="35%" class="blue">&nbsp;&nbsp;&nbsp;<%=closeFee_name%></TD>	    
				  </tr>	
	 
	 			<tr height="22">
	 				   <TD width="15%" class="blue">&nbsp;&nbsp;&nbsp;����ʱ��</TD>
	  					<TD width="35%" class="blue">&nbsp;&nbsp;
	  					  <input type="text" name="stop_time" value="<%=stop_time%>"/>&nbsp;<font class="orange">*(��ʽΪYYYYMMDD)<font>
	  						</TD>
	  					<TD width="15%" class="blue">&nbsp;&nbsp;&nbsp;Ȩ��ֵ</TD>
	  					<TD width="35%" class="blue">&nbsp;&nbsp;&nbsp;
	  							<select  name="power_right">
									<%
									for(int i = 0 ; i<powerRight.length; i ++)
									{ 
										String strTemp = "";
										if(power_right.equals(powerRight[i][0])){
											strTemp = "selected";
									  }else{
									  	strTemp = "";
									  	}
									%>
										<option value="<%=powerRight[i][0]%>" <%=strTemp%> > <%=powerRight[i][0]+"->"+powerRight[i][1]%> </option>
									<%
									}
									%>
								</select>
	  						&nbsp;
	  						<input type="hidden" name = "region_code" value="<%=region_code%>"/>
	  						<input type="hidden" name = "closeFee_code" value="<%=closeFee_code%>"/>
	  						<input type="hidden" name = "closeFee_name" value="<%=closeFee_name%>"/>
	  						</TD>
	 				
	 			</tr>
				  
				</table>
				
				<TABLE cellSpacing="0">
    <TBODY>
        <TR>
            <TD id="footer">
                <input class='b_foot' name=back onClick="update_submit()" style="cursor:hand" type=button value=�ύ>
           
          
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


