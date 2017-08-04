<%@ page contentType="text/html;charset=GBK"%>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<script language="JavaScript">
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
	
	//xl add for zlc 安全加固 第二批
	String inParas[] = new String[24];
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String region_code = org_code.substring(0,2);
	String nopass = (String)session.getAttribute("password");

	String in_print_type1 = request.getParameter("in_print_type1");
	String phone_no = request.getParameter("phone_no");
	
	System.out.println("in_print_type1="+in_print_type1);
	
	String sqlStr = "";
	SPubCallSvrImpl callView = new SPubCallSvrImpl();
	ArrayList arlist = new ArrayList();
	String result[][] = new String[][]{};
	String result1[][] = new String[][]{};
	String checkflag ="";
	System.out.println("cccccccccccc in_print_type1 is "+in_print_type1);			
	in_print_type1="1";
	String s_note="";
	s_note="根据手机号码"+phone_no+"进行查询";
	if(in_print_type1.equals("0"))
	{
		System.out.println("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
	//	sqlStr="SELECT to_char(contract_no),bank_cust FROM   dConMsg "+
		//			"where account_type in ('1')  "+
		  // 		"and contract_no in "+
  		  //  "(select distinct(b.contract_no) from dCustMsg a,dConUserMsg b where a.phone_no='?' and a.id_no=b.id_no) group by  contract_no,bank_cust ";
      sqlStr="select to_char(contract_no),to_char(id_no) from dcustmsg where phone_no='"+phone_no+"'";
       
       System.out.println("--------------"+sqlStr);

		//add begin
		System.out.println(sqlStr);
		
		 
			
		//arlist = callView.sPubSelect("2",sqlStr);

		//result1 = (String[][])arlist.get(0);
	  %>
			<wtc:pubselect name="TlsPubSelBoss"  outnum="2">
			<wtc:sql><%=sqlStr%></wtc:sql>
			
			</wtc:pubselect>
			<wtc:array id="retList" scope="end" />
	  <%
		result1 =retList;
		int retval=result1.length;
		
		
			
		if ( retval == 0 )
		{
	%>
			window.returnValue="0";
			window.close();
	<%
		}
		else{
			System.out.println("retval="+retval);
			if ( retval==1 ){
	%>
				window.returnValue="<%=result1[0][0].trim()%>";
				window.close(); 
	<%		}
		}
	//add end
	}
	else
	{
		//sqlStr="select to_char(a.cust_id),b.cust_name from dCustMsg a,dcustdoc b  where phone_no='?' and a.cust_id=b.cust_id group by a.cust_id,b.cust_name ";
		//xl add for zlc
		System.out.println("fffffffffffffffffffffffffffff 2222");
		%>
			<wtc:service name="sGrpCustQry" retcode="code1" retmsg="msg1" outnum="2">
				<wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value="d003"/>
				<wtc:param value="<%=workNo%>"/>
				<wtc:param value="<%=nopass%>"/>
				<wtc:param value="<%=phone_no%>"/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value="d003"/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value="2"/>
				<wtc:param value=""/>
				<wtc:param value="2"/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value="<%=s_note%>"/>

			</wtc:service>
		<wtc:array id="retList" scope="end" />
		<%

		//add begin
		System.out.println(sqlStr);
		
		
			
		
		result1 =retList;
		int retval=result1.length;
		
		
			
		if ( retval == 0 )
		{
	%>
			window.returnValue="0";
			window.close();
	<%
		}
		else{
			System.out.println("retval="+retval);
			if ( retval==1 ){
	%>
				window.returnValue="<%=result1[0][0].trim()%>";
				window.close(); 
	<%		}
		}
	//add end
	}				
	
%>
    
</script>

<HTML><HEAD><TITLE>吉林BOSS-帐号查询</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet" type="text/css" />

<script language="JavaScript">
	
function save_to(){	

      for(i=0;i<document.frm.elements.length;i++) 
		      if (document.frm.elements[i].name=="radio1"){
				   if (document.frm.elements[i].checked==true){
					 window.returnValue=document.frm.elements[i].value;     
               }
			   }
		window.close(); 
	}

	function quit(){
		window.close(); 
	}
</script>

</head>

<BODY leftmargin="0" topmargin="0" background="<%=request.getContextPath()%>/images/jl_background_2.gif">
<form name="frm" method="post" action="">
 <div id="Operation_Table">
 <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" >
    <tr > 
      <td> 
  		<table width="100%" border="0"  align="center" >
		<tr > 
		  	<td> </td>
		  	<td>号码</td>
		  	<td>名称</td>
		</tr>
		<% for(int i=0; i <result1.length; i++){
		
			System.out.println("result length is  "+result1.length);
		
			if (i==0) {
				checkflag="checked";
			}
			else {checkflag="";}
			%>
			<tr > 
			  <td ><input type="radio" name="radio1" value="<%=result1[i][0].trim()%>" <%=checkflag%>></td>
			  <td > <%=result1[i][0]%></td>
			  <td > <%=result1[i][1]%></td>
			
			</tr>
		<%}%>
		<tr > 
		  <td colspan="5"> 
			  <input class="textclass" type="button" name="Button" value="确定" onClick="save_to()">
			  <input class="textclass" type="button" name="return" value="返回" onClick="quit()">
		 </td>
		</tr>

  </table>
</td>
	</tr>
  </table>
</div>
<%@ include file="../public/foot.jsp" %>

</form>
</body>
</html>

