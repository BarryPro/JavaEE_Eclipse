 <%
	/********************
	 version v2.0
	������: si-tech
	add:wuxy@2009-03-03 ��������Ź���
	********************/
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd>
<HTML xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/public/pubSASql.jsp" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.s1900.config.productCfg" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.text.*"%>
<%
	String opCode = "e539";	
	String opName = "EC��������Ź���";	//header.jsp��Ҫ�Ĳ���   
	
           
        String loginNo=(String)session.getAttribute("workNo");    //���� 
        String loginName =(String)session.getAttribute("workName");//��������  	
        String  powerRight= (String)session.getAttribute("powerRight");          
        String orgCode = (String)session.getAttribute("orgCode");        
        String ip_Addr = request.getRemoteAddr();       
        String regionCode = (String)session.getAttribute("regCode");       
        String  GroupId = (String)session.getAttribute("groupId");       
        String  OrgId = (String)session.getAttribute("orgId");
        
         

        int recordNum = 0;
        
       
	String dateStr = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String  insql = "select to_char(last_day(sysdate)+1,'YYYY-MM-DD')  from  dual";

		
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:sql><%=insql%></wtc:sql>
	</wtc:pubselect>
<wtc:array id="result" scope="end" />
<%
	dateStr=result[0][0];
%>

<html>	
	<head>
  <title>��������Ź���</title>
  <meta content=no-cache http-equiv=Pragma>
  <meta content=no-cache http-equiv=Cache-Control>
	</head>
		
<script language="JavaScript">			
		function getCustomerNumber(){
		var pageTitle = "EC��Ϣ";
	    var fieldName = "���ű���|���ſͻ�����|��ϵ�绰|";
	    var sqlStr = "";
	    var selType = "S";    //'S'��ѡ��'M'��ѡ
	    var retQuence = "3|0|1|2|";
	    var flag="";
	    
	    var retToField = "ecsiid|ecsiname|linkphone|";
	    
	    var ecsiname = document.all.ecsiname.value;
		  var ecsiid = document.all.ecsiid.value;
	    if((ecsiname=="")&&(ecsiid==""))
	    {	 
	    	 	
	    	rdShowMessageDialog("�����뼯�ű�Ż��ſͻ����ƽ��в�ѯ��");
        document.frm.ecsiid.focus();
        return false;
	    }
	    
	    if((ecsiid!="")&&(isNaN(ecsiid)==true))
			{			
				rdShowMessageDialog("���ű���ֻ�������֣�");
				return false;
			 
			}			
			
	
	    var path = "<%=request.getContextPath()%>/npage/se539/fe539_getEcInfo.jsp";
	    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	    path = path + "&fieldName="+fieldName;
	    path = path + "&selType="+selType;
	    path = path + "&retQuence="+retQuence;
	    path = path + "&retToField="+retToField;
	    path = path + "&s_ecsiid=" +document.all.ecsiid.value;
	    path = path + "&s_ecsiname="   +document.all.ecsiname.value;
	    
	    retInfo = window.open(path,
	                          "newwindow",
	                          "height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	    return true;
		
	}	
	function document_onkeydown()
	{
	
	    if (window.event.srcElement.type!="button" && window.event.srcElement.type!="textarea")
	    {
	
	        if (window.event.keyCode == 13)
	        {
	            window.event.keyCode = 9;
	        }
	    }
	}
    function windowClear()
    {
    	document.all.ecsiid.readOnly=false;
    	document.all.ecsiid.value="";
    	document.all.ecsiname.value="";
    	document.all.nextoper.disabled=true;
    	
    	
    }
    
    function toNextPage()
    {
	    
	    
			var doType = document.all.doType.value;
			if(doType=="a"){
				document.frm.action="fe539_1.jsp?&ecsiid="+document.all.ecsiid.value+"&ecsiname="+document.all.ecsiname.value+"&phone_no="+document.all.phone_no.value;
				document.frm.submit();
			}
			else if(doType=="c"){
				document.frm.action="fe539_2.jsp?&ecsiid="+document.all.ecsiid.value+"&ecsiname="+document.all.ecsiname.value;
				document.frm.submit();
			}
			else if(doType=="z"){
				document.frm.action="fe539_3.jsp?&ecsiid="+document.all.ecsiid.value+"&ecsiname="+document.all.ecsiname.value+"&phone_no="+document.all.phone_no.value;
				document.frm.submit();
			}
			else if(doType=="d"){
				document.frm.action="fe539_4.jsp?&ecsiid="+document.all.ecsiid.value+"&ecsiname="+document.all.ecsiname.value+"&phone_no="+document.all.phone_no.value;
				document.frm.submit();
			}	
			
	   
	}	
			
	</script>

	<body>
		<form name="frm" method="post" action="" onKeyDown="document_onkeydown()" ENCTYPE="multipart/form-data">
			<input type="hidden" name="pageOpCode" value="<%=opCode%>">
			<input type="hidden" name="pageOpName" value="<%=opName%>">
			<input type="hidden" name="phone_no" id="phone_no" value="">
			<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
						    <div id="title_zi">��ѡ���������</div>
						</div>
						<TABLE cellSpacing="0">
							<tr>
								<TD width=12% class="blue">
									<div align="left">��������</div>
								</TD>
								<TD width="32%" >
									<SELECT name="doType" id="doType" >
										<option value="a">���� </option>
										<option value="d">��ֹ</option>
										<option value="z">���״̬</option>
										<option value="c">��ѯ </option>
									</SELECT>
									<font class="orange">*</font>
								</TD>
								<TD width=12% class="blue">
									<div align="left">��ѯ��������</div>
								</TD>
								<TD width="32%" >	EC(MAS)								
								</TD>
							</TR>
							<tr>
								<TD width=12% class="blue">
									<div align="left">���ű���</div>
								</TD>
								<TD width="32%">
									<input name="ecsiid" id="ecsiid" size="24" maxlength="18" v_type="0_9" v_must=1 index="1" value="">
									<input name=custQuery type=button class="b_text" id="custQuery" onMouseUp="getCustomerNumber();" onKeyUp="if(event.keyCode==13)getCustomerNumber();" style="cursor��hand" value=��ѯ>
									
								</TD>
								<TD class="blue">���ſͻ�����</TD>
								<TD width="32%">
									<input type="text" name="ecsiname" id="ecsiname" size="20" maxlength="50" v_type="string" v_must=1 index="2" value="" >
									
								</TD>
								
							</TR>	
					 
	<tr>
    	<td align="center" id="footer" colspan="4">
      		<input class="b_foot" name=next id=nextoper type=button value="��һ��" onclick="toNextPage()" disabled>
      		<input class="b_foot" name=clear type=button value="���" onClick="windowClear()">
      		<input class="b_foot" name=reset type=button value="�ر�" onClick="removeCurrentTab()">
    	</td>
	</tr>	

			</table>
			<%@ include file="/npage/include/footer.jsp" %>
			
	</form>
	</body>
</html>