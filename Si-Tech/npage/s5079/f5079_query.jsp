<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="org.apache.log4j.Logger"%>
<%
	Logger logger = Logger.getLogger("f5079_query.jsp");
	ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
	 
	String loginName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String loginNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));
	String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	String formtype = request.getParameter("formtype");
	String QryFlag = request.getParameter("QryFlag");
	String QryValues = request.getParameter("QryValues");
	System.out.println("--------------5079-------QryValues="+QryValues);   
	System.out.println("--------------5079-------QryFlag="+QryFlag);  
	//统付查询使用
	String huaboym = request.getParameter("huaboym");
	String tongulb = request.getParameter("tongulb");
	
	String opName = "统付产品查询";
	
	ArrayList acceptList = new ArrayList();
	
	String paraArr[] = new String[6];
	paraArr[0] = "5079";
	paraArr[1] = "";
	paraArr[2] = loginNo;
	paraArr[3] = nopass;
	paraArr[4] = QryFlag;
	paraArr[5] = QryValues;
	
	//acceptList = impl.callFXService("s5079Qry",paraArr,"8");
	
	String errCode = "";
	String errMsg = "";
	try{
    %>
        <wtc:service name="s5079QryEXC" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="11" >
        	<wtc:param value="<%=paraArr[0]%>"/>
        	<wtc:param value="<%=paraArr[1]%>"/> 
            <wtc:param value="<%=paraArr[2]%>"/> 
            <wtc:param value="<%=paraArr[3]%>"/> 
            <wtc:param value="<%=paraArr[4]%>"/> 
            <wtc:param value="<%=paraArr[5]%>"/> 
        </wtc:service>
        <wtc:array id="retArr1" scope="end"/>
    <%
    
	//int errCode=impl.getErrCode();   
	//String errMsg=impl.getErrMsg(); 
	
	    errCode = retCode1;
        errMsg = retMsg1;
	    if("000000".equals(retCode1)){
	        if(retArr1.length>0){
	            result = retArr1;
	        }else{
	            %>
    	            <script type=text/javascript>
    	                rdShowMessageDialog("没有相关数据!",0);
    	                window.close();
    	            </script>
    	        <%
	        }
	    }else{
	        %>
	            <script type=text/javascript>
	                rdShowMessageDialog("错误代码：<%=errCode%>,错误信息：<%=errMsg%>",0);
	                window.close();
	            </script>
	        <%
        	System.out.println("# return from f5079_query.jsp by s5079QryEXC -> retCode = " + retCode1);
        	System.out.println("# return from f5079_query.jsp by s5079QryEXC -> retMsg  = " + retMsg1);
    	}
	}catch(Exception e){
	    %>
            <script type=text/javascript>
                rdShowMessageDialog("调用服务s5079QryEXC失败！",0);
                window.close();
            </script>
        <%
	    e.printStackTrace();
	}
/*
			String[][] tmpresult0=(String[][])acceptList.get(0);
			String[][] tmpresult1=(String[][])acceptList.get(1);
			String[][] tmpresult2=(String[][])acceptList.get(2);
			String[][] tmpresult3=(String[][])acceptList.get(3);
			String[][] tmpresult4=(String[][])acceptList.get(4);
			String[][] tmpresult5=(String[][])acceptList.get(5);
			String[][] tmpresult6=(String[][])acceptList.get(6);
			String[][] tmpresult7=(String[][])acceptList.get(7);
*/
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>信息列表</title>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<SCRIPT LANGUAGE=javascript FOR=document EVENT=onkeydown>
window.onkeydown(window.event) 
</SCRIPT>
</head>
<body>
<form name="frm" method="POST" >
<%@ include file="/npage/include/header_pop.jsp" %>
<div class="title">
	<div id="title_zi">信息列表</div>
</div>
<table id="tab1" cellpadding="0">
	<tr>
		<th>选择</th>
		<th>客户ID</th>
		<th>集团编号</th>
		<th>集团名称</th>
		<th>用户ID</th>
		<th>产品代码</th>
		<th>产品名称</th>
		<th>帐号</th>
		<th>运行状态</th>
		
	</tr>
</table>
<table cellspacing="0">
	<tr id="footer">
		<td>
	      <input type="button" class="b_foot" name="commit" onClick="doCommit();" value="确定">
	      <input type="button" class="b_foot" name="back" onClick="doClose();" value="关闭">
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>

<script>
var formtype='<%=formtype%>';  
	<%
		if("000000".equals(errCode))
		{
			for(int i=0;i < result.length;i++)
			{ 
	%>
			var str='<input type="hidden" name="cust_id" value="<%=result[i][0]%>">';
			str+='<input type="hidden" name="unit_id" value="<%=result[i][1]%>">';
			str+='<input type="hidden" name="unit_name" value="<%=result[i][2]%>">';
			str+='<input type="hidden" name="id_no" value="<%=result[i][3]%>">';
			str+='<input type="hidden" name="product_code" value="<%=result[i][4]%>">';
			str+='<input type="hidden" name="product_name" value="<%=result[i][5]%>">';
			str+='<input type="hidden" name="account_id" value="<%=result[i][6]%>">';
			str+='<input type="hidden" name="run_code" value="<%=result[i][7]%>">';

						
			var rows = document.getElementById("tab1").rows.length;
			var newrow = document.getElementById("tab1").insertRow(rows);

			newrow.insertCell(0).innerHTML ='<input type="radio" name="num" value="<%=i%>">'+str;
		  	newrow.insertCell(1).innerHTML = '<%=result[i][0]%>';
		  	newrow.insertCell(2).innerHTML = '<%=result[i][1]%>';
		  	newrow.insertCell(3).innerHTML = '<%=result[i][2]%>';
		  	newrow.insertCell(4).innerHTML = '<%=result[i][3]%>';
		  	newrow.insertCell(5).innerHTML = '<%=result[i][4]%>';
		  	newrow.insertCell(6).innerHTML = '<%=result[i][5]%>';
		  	newrow.insertCell(7).innerHTML = '<%=result[i][6]%>';
		  	newrow.insertCell(8).innerHTML = '<%=result[i][7]%>';
	<%
			}
		}
		else
		{
	%>

				rdShowMessageDialog("<br>没有符合条件的数据");
				window.close();

	<%	
		}	
		
	%>

		function doCommit()
		{
			if("<%=result.length%>"=="0")
			{
				rdShowMessageDialog("请选择一条信息！");
				return false;
			}
			else if("<%=result.length%>"=="1")
			{//值为一条时不需要用数组
				if(document.all.num.checked)
				{
					
					if(formtype=="form1" )
					{
						window.opener.form1.turnValue.value=document.all.account_id.value;
						window.opener.showList1();
						window.close();
					}
					else if(formtype=="form2" )
					{
						window.opener.form2.turnValue.value=document.all.id_no.value;
						window.opener.showList2();
						window.close();
					}
					else if(formtype=="form3")
					{
						window.opener.form3.turnValue.value=document.all.account_id.value;
						window.opener.showList3();
						window.close();
					}
					else if(formtype=="form4")
					{
					
						window.opener.form4.turnValue.value=document.all.account_id.value;
						window.opener.showList4();
						window.close();
					}
					/*begin diling add for 新增集团按账目项付费查询 @2012/5/26 */
					else if(formtype=="form5")
					{
						window.opener.form5.turnValue.value=document.all.account_id.value;
						window.opener.form5.idNo.value=document.all.id_no.value;
						window.opener.showList5();
						window.close();
					}
					/*end diling add*/
				}
				else
				{
					rdShowMessageDialog("请选择一条信息！");
					return false;
				}
			}
			else
			{//值为多条时需要用数组
				var a=-1;
				for(i=0;i<document.all.num.length;i++)
				{
					if(document.all.num[i].checked)
					{
						a=i;
						break;
					}
				}
				if(a!=-1)
				{
					if(formtype=="form1")
					{
						window.opener.form1.turnValue.value=document.all.account_id[a].value;
						window.opener.showList1();
						window.close();
					}
					else if(formtype=="form2")
					{
						window.opener.form2.turnValue.value=document.all.id_no[a].value;
						window.opener.showList2();
						window.close();
					}
					else if(formtype=="form3")
					{
						window.opener.form3.turnValue.value=document.all.account_id[a].value;
						window.opener.showList3();
						window.close();
					}
					else if(formtype=="form4")
					{
						window.opener.form4.turnValue.value=document.all.account_id[a].value;
						window.opener.showList4();
						window.close();
					}
					/*begin diling add for 新增集团按账目项付费查询 @2012/5/26 */
					else if(formtype=="form5")
					{
						window.opener.form5.turnValue.value=document.all.account_id[a].value;
						window.opener.form5.idNo.value=document.all.id_no[a].value;
						window.opener.showList5();
						window.close();
					}
					/*end diling add*/
				}
				else
				{
					rdShowMessageDialog("请选择一条信息！");
					return false;
				}
			}
		}
	
	function doClose()
	{
		window.close();
	}
</script>