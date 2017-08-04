 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-22 页面改造,修改样式
	********************/
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>

 <%
 	String opCode = "5283";	
	String opName = "批量打印发票";	//header.jsp需要的参数   
	String regionCode = (String)session.getAttribute("regCode"); 
	
	String workno=(String)session.getAttribute("workNo");    //工号 
        String workname =(String)session.getAttribute("workName");//工号名称  	        

	String agt_phone = request.getParameter("agt_phone");
    	String cust_phone = request.getParameter("cust_phone");
	String print_ym = request.getParameter("print_ym");
	String begin_date = request.getParameter("begin_date");
	String end_date = request.getParameter("end_date");
	String print_type = request.getParameter("print_type");

	String[] inParas = new String[6];
    	inParas[0] = agt_phone;
    	inParas[1] = cust_phone;
	inParas[2] = begin_date;
    	inParas[3] = end_date;
	inParas[4] = print_ym;
	inParas[5] = print_type;

	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
    	//ArrayList retList = new ArrayList();
    	//retList = impl.callFXService("s5283Init", inParas, "9");
    %>
    	<wtc:service name="s5283Init" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="9" >
		<wtc:param value="<%=inParas[0]%>"/>	
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
		<wtc:param value="<%=inParas[4]%>"/>
		<wtc:param value="<%=inParas[5]%>"/>	
	</wtc:service>
	<wtc:array id="result0" start="0" length="1" scope="end"/>
	<wtc:array id="result1" start="1" length="1" scope="end"/>
	<wtc:array id="result2" start="2" length="1" scope="end"/>
	<wtc:array id="result3" start="3" length="1" scope="end"/>
	<wtc:array id="result4" start="4" length="1" scope="end"/>
	<wtc:array id="result5" start="5" length="1" scope="end"/>
	<wtc:array id="result6" start="6" length="1" scope="end"/>
	<wtc:array id="result7" start="7" length="1" scope="end"/>
	<wtc:array id="result8" start="8" length="1" scope="end"/>
	
	
	
<%	
	/*for(int i=0;i<mainQryArr.length;i++){
		for(int j=0;j<mainQryArr[i].length;j++){
			System.out.println("mainQryArr["+i+"]["+j+"]="+mainQryArr[i][j]);
		}
}*/
%>
<%/*
	ArrayList retList = new ArrayList();	
	StringTokenizer resToken = null;
  	for(int i = 0; i<mainQryArr.length; i++){
  		for(int j=0;j<mainQryArr[i].length;j++){
  			String values;
	      		for(resToken = new StringTokenizer(mainQryArr[i][j], "|"); resToken.hasMoreElements(); retList.add(values)){
	          		values = (String)resToken.nextElement();
	      		}
  		}
  	} 
	*/
%>

<%
  	/*String[][] result0 = new String[][]{};
	String[][] result1 = new String[][]{};
	String[][] result2 = new String[][]{};
	String[][] result3 = new String[][]{};
	String[][] result4 = new String[][]{};
	String[][] result5 = new String[][]{};
	String[][] result6 = new String[][]{};
	String[][] result7 = new String[][]{};
	String[][] result8 = new String[][]{};
	*/

	String return_code=result0[0][0];


    double yingsou = 0.00;
    /*if (return_code.equals("000000")) {
	   result0 = (String[][])retList.get(0);
	   result1 = (String[][])retList.get(1);
	   result2 = (String[][])retList.get(2);
       	   result3 = (String[][])retList.get(3);
	   result4 = (String[][])retList.get(4);
	   result5 = (String[][])retList.get(5);
	   result6 = (String[][])retList.get(6);
	   result7 = (String[][])retList.get(7);
	   result8 = (String[][])retList.get(8);
	}*/
%>

<% if (!return_code.equals("000000")) {%>
	  <script language="JavaScript">
	    rdShowMessageDialog("空中充值批量打印发票查询失败! ");
	    window.location="s5283.jsp";
	  </script>

<% } else { 
%>
<HTML>
	<HEAD>
		<TITLE>空中充值批量打印发票</TITLE>
		<SCRIPT LANGUAGE="JavaScript">
		<!--
		function doPrintSubmit()
		{
		    document.form.acceptStr.value="";
		    <%int k = result2.length;
		      int j=0;
		    for(j=0;j<k;j++)
			{%>
				if (<%=k%>==1) 
				{
					if (document.form.unchange.checked == true)
						document.form.acceptStr.value="<%=result5[j][0]%>"+"|";
				}
				else if(document.form.unchange[<%=j%>].checked == true)
				{
					document.form.acceptStr.value=document.form.acceptStr.value + "<%=result5[j][0]%>"+"|";
				}
			<%}%>
			//alert(document.form.acceptStr.value);
			
			document.form.submit();
		}
		function allChoose()
		{   //复选框全部选中
		    var k = <%=result2.length%>;
		    for(i=0;i<k;i++)
		    {
		        if (k==1)
		        {
		        	if(document.form.unchange.type=="checkbox")
		        	{
		        		if(document.form.unchange.disabled == false)
		               document.form.unchange.checked = true;
		        	}
		        }
		        else if(document.form.unchange[i].type=="checkbox")
		        {    //判断是否是单选或复选框
		            if(document.form.unchange[i].disabled == false)
		               document.form.unchange[i].checked = true;
		        }
		    }
		}
		function cancelChoose()
		{   //取消复选框全部选中
			var k = <%=result2.length%>;
		    for(i=0;i<k;i++)
		    {
		        if (k==1)
		        {
		        	if(document.form.unchange.type=="checkbox")
		        	{
		        		if(document.form.unchange.disabled == false)
		               document.form.unchange.checked = false;
		        	}
		        }
		        else if(document.form.unchange[i].type =="checkbox")
		        {    //判断是否是单选或复选框
		            if(document.form.unchange[i].disabled == false)
		               document.form.unchange[i].checked = false;
		        }
		    }
		}
		//add by anln 2009.02.04
		function backMain(){
			window.location.href="s5283.jsp";
		}
		
		//-->
		</SCRIPT>
	</HEAD>
	<BODY>
	<FORM action="s5283print.jsp" method=post name=form>
		<input type="hidden" name="print_num"  value="">
		<input type="hidden" name="acceptStr"  value="">
		<input type="hidden" name="sel_type"  value="1">	       
		<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">批量打印发票</div>
		</div> 
		<table  cellspacing="0">
			  <tr>
			       <th width="8%">
				      <div align="center">选择</div>
			       </th>
			       <th width="10%">
				      <div align="center">用户名称</div>
			       </th>
			       <th width="14%">
				      <div align="center">手机号码</div>
			       </th>
			       <th width="14%">
				     <div align="center"> 帐户号码</div>
			       </th>
			       <th width="14%">
				      <div align="center">缴费流水</div>
				   </th>
			       <th width="8%">
				     <div align="center"> 缴费金额</div>
			       </th>
			       <th  width="13%">
				      <div align="center">缴费时间</div>
			       </th>
			       <th  width="10%">
				      <div align="center">已打印次数</div>
			       </th>
			   </tr>			  
			<% 
				for(int i=0; i < result2.length  ; i++){
			%>
				<tr>
				  <td>
					<div align="center">
					<% 

					if (result8[i][0].equals("0")){
					%>
					  <input type="checkbox" name="unchange" value="<%=result2[i][0].trim()%>,<%=result3[i][0].trim()%>,<%=result4[i][0].trim()%>,<%=result5[i][0].trim()%>,<%=result6[i][0].trim()%>,<%=result7[i][0].trim()%>" checked  >
					<%}
					else			{
					%>
					  <input type="checkbox" name="unchange" value="<%=result2[i][0].trim()%>,<%=result3[i][0].trim()%>,<%=result4[i][0].trim()%>,<%=result5[i][0].trim()%>,<%=result6[i][0].trim()%>,<%=result7[i][0].trim()%>" >
					<%}%>
					</div>
				  </td>
				  <td>
					<div align="center"><%=result2[i][0]%></div>
				  </td>                               
				   <td>                               
					<div align="center"><%=result3[i][0]%></div>
				  </td>                               
				   <td>                               
					<div align="center"><%=result4[i][0]%></div>
				  </td>                               
				  <td>                                
					<div align="center"><%=result5[i][0]%></div>
				  </td>                               
				  <td>                                
					<div align="center"><%=result6[i][0]%></div>
				  </td>                               
				  <td>                                
					<div align="center"><%=result7[i][0]%></div>
				  </td>                               
				  <td>                                
					<div align="center"><%=result8[i][0]%></div>
				  </td>
				</tr>
	    	<%}%>
		</table>
		<TABLE  cellSpacing="0">
		 <tbody>	  
			<tr>
				<td id="footer">
		             
			        <input  class="b_foot" name=allchoose type=button value=全选 onclick="allChoose()">
					&nbsp;
			        <input  class="b_foot" name=cancelAll type=button value=取消全选 onclick="cancelChoose()">
					&nbsp;
			        <input  class="b_foot" name=sure type=button value=打印 onclick="doPrintSubmit()">
					&nbsp;
			        <input  class="b_foot" name=reset type=reset value=返回 onclick="backMain()">
	       		
	       		</td>
	       		</tr>
	       	</tbody>
	        </table>	      
	        <input type="hidden" name="cust_phone" value="<%=cust_phone%>"/>
	         <input type="hidden" name="agt_phone" value="<%=agt_phone%>"/>
     		<%@ include file="/npage/include/footer.jsp" %>	  
	</FORM>
	</BODY>
	</HTML>
<% 
} %>

