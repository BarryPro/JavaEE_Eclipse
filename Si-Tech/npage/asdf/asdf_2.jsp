<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
<%
	String regionCode=(String)session.getAttribute("regCode");
	String opCode = "g088";
	String opName = "集团交费通知短信配置";
 	String[][] result = new String[][]{}; 
	String unitid = request.getParameter("unitid");	
    String workno = (String)session.getAttribute("workNo");
	  
	
%> 
<wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
String sysAccept = seq;
%> 
<wtc:service name="sgetGrpInfo" retcode="sRetCode" retmsg="sRetMsg" outnum="14">
    <wtc:param value="<%=unitid%>"/> 
	<wtc:param value="<%=workno%>"/>
</wtc:service>
<wtc:array id="ret_cust" scope="end" start="0"  length="5" />
<wtc:array id="ret_imp" scope="end" start="5"  length="9" />

<%
if((ret_cust==null||ret_cust.length==0) &&(ret_imp==null||ret_imp.length==0)  )
{
	%><HEAD><TITLE>重要客户查询</TITLE>
</HEAD>
<script language="javascript">
			
</script>
<body >
<FORM method=post name="form">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">集团交费通知短信配置</div>
	</div>
	<table cellspacing="0" id="tabList">
 
	<tr>
		<td colspan=6 align=center><font color=red border>无查询结果</font></td>
	</tr>


		<td align="center" id="footer" colspan="8">
		   <input class="b_foot" name=back onClick="window.location='asdf_1.jsp?opCode=asdf&opName=集团客户缴费通知'" type="button" value="返回">
		&nbsp;  
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<%
}
else if(sRetCode!="000000" &&!(sRetCode.equals("000000")))
{
	%>
		<script language="javascript">
			alert("查询失败");
		</script>
	<%
}
else  
{
	
	%>
	
 
	<body  >
	<FORM method=post name="form">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">集团交费通知短信配置</div>
	</div>
	<table cellspacing="0" id="tabList2">
	<tr colspan=6>
		<th nowrap>集团联系人姓名</th>
	 	<th nowrap colspan=3>集团联系人电话</th>
		<th nowrap colspan=2>操作 </th>
	<tr>
	<%
	 if(ret_cust!=null&&ret_cust.length>0)
	 {
		for(int i=0;i<ret_cust.length;i++)
		{
			%>
				<tr><script language="javascript">//alert("i is "+"<%=i%>");</script>
					<td>
					<input type="text" readonly class="InputGrey" id="jtname<%=i%>" value="<%=ret_cust[i][0]%>">
					</td>
					<td colspan=3>
					<input type="text" readonly class="InputGrey" id="jttel<%=i%>" value="<%=ret_cust[i][1]%>">
					</td>
					<%
						if(Integer.parseInt(ret_cust[i][4])>0)
						{
							%><td><input type="checkbox"  name="testcheck" disabled>  </td>
							<td><input type="button" value="取消" onclick="upgrp('<%=unitid%>','<%=ret_cust[i][2]%>')"></td>
							<%
						}
						else
						{
							%><td colspan=2><input type="checkbox" id="jtCheck<%=i%>" name="testcheck"></td>
							 
							<%
						}
					%>
				 
					
					<input type="hidden" id="jtflag<%=i%>" value="1" >
					<input type="hidden" id="impduty<%=i%>" value="null" >
					<input type="hidden" id="impdep<%=i%>" value="null" >
					<input type="hidden" id="grp_cust_id<%=i%>" value="<%=ret_cust[i][2]%>" >
				</tr>
			<%
		}
	 }
	 %>
	  <tr>
		<th nowrap>重要成员姓名</th>
		<th nowrap>职位</th>
		<th nowrap>部门</th>
		<th nowrap>联系电话</th>
		<th nowrap colspan=2>操作</th>
	 
	  </tr>
	  <script language="javascript">//alert("i去 is "+"<%=ret_imp.length%>");</script>
	  <%
        if(ret_imp!=null&&ret_imp.length>0)
	    {
		    int len_imp = Integer.parseInt(ret_imp[0][6]);
			int len_non = Integer.parseInt(ret_imp[0][7]);
		
			for(int j=0;j<ret_imp.length;j++)
			{
				%>
					<tr>
						<td>
						<input type="text" readonly class="InputGrey" id="impname<%=j+len_non%>" value="<%=ret_imp[j][0]%>">
						</td>
						<td><input type="text" readonly class="InputGrey" id="impduty<%=j+len_non%>" value="<%=ret_imp[j][1]%>"></td>
						<td><input type="text" readonly class="InputGrey" id="impdep<%=j+len_non%>" value="<%=ret_imp[j][2]%>"></td>
						<td><input type="text" readonly class="InputGrey" id="jttel<%=j+len_non%>" value="<%=ret_imp[j][3]%>"></td>
						 
						<%
							if(Integer.parseInt(ret_imp[j][8])>0)
							{
								%><td><input type="checkbox"   name="testcheck" disabled>  </td> 
								<td><input type="button" value="取消" onclick="upimp('<%=unitid%>','<%=ret_imp[j][5]%>','<%=ret_imp[j][4]%>')"></td>
								<%
							}
							else
							{
								%><td colspan=2><input type="checkbox" id="impCheck<%=j+len_non%>" name="testcheck">  </td> <%
							}
						%>
						
						<input type="hidden" id="jtflag<%=j+len_non%>" value="2" >
						 <input type="hidden" id="imp_id<%=j+len_non%>" value="<%=ret_imp[j][4]%>" >
						 <input type="hidden" id="imp_cust_id<%=j+len_non%>" value="<%=ret_imp[j][5]%>" >
					</tr>
				<%
			}
	    }
		
	 
	%>
	<tr>
		<td colspan=6 align=center><font color=red>非移动号码不发短信</font></td>
	</tr>
	</tr>
	<tr>
		<td align="center" id="footer" colspan="6">
		   <input class="b_foot" type="button" id="pltfId" name=pltf value="提交" onClick="docomm(this)">
		   &nbsp; &nbsp; &nbsp; &nbsp; 
		   <input class="b_foot" type="button" name=back value="返回" onClick="history.go(-1)">
		 
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
	<%
}
 
 
%>
<script language="javascript">
function upgrp(unit_id,cust_id)
{
	//alert("unit_id is "+unit_id+" and cust_id is "+cust_id);
	var url="asdf_update.jsp?unit_id="+unit_id+"&cust_id="+cust_id+"&imp=999999";
	var url_new =url;//URLencode(url);
	document.form.action=url_new;
	var	prtFlag = rdShowConfirmDialog("是否确定本次操作？");
	if (prtFlag==1)
	{
		//alert("bizcodeArrays is "+bizcodeArrays);
		document.form.submit();  
	}
	else
	{
		return false;
	}
}
function upimp(unit_id,cust_id,imp_id)
{
	//alert("unit_id is "+unit_id+" and cust_id is "+cust_id+" and imp_id is "+imp_id);
	var url="asdf_update.jsp?unit_id="+unit_id+"&cust_id="+cust_id+"&imp="+imp_id;
	var url_new =url;//URLencode(url);
	document.form.action=url_new;
	var	prtFlag = rdShowConfirmDialog("是否确定本次操作？");
	if (prtFlag==1)
	{
		//alert("bizcodeArrays is "+bizcodeArrays);
		document.form.submit();  
	}
	else
	{
		return false;
	}
}
function docomm(subButton)
	{
		//controlButt(subButton);//延时控制按钮的可用性
		var  jtnameArrays=[]; 
		var  jttelArrays=[];  
		var  flagArrays=[]; 
		var  dutyArrays=[]; 
		var  depArrays=[];
		var  impnameArrays=[];
		var  i_flag_imp=[];
		var  i_flag_grp=[];
		//add imp_id cust_id
		var  imp_cust_id=[];
		var  grp_cust_id=[];
		var  imp_imp_id=[];
		var  grp_imp_id=[];
		var len = "";
		len=document.form.testcheck.length;
  
		var check_flag=0;
		//alert("1ww "+len);
		if(len==undefined)
		{
			len=1;
			i=0
			    var i_flags = document.getElementById("jtflag"+i).value;//判断集团or重要的
				 //alert(" i_flags   is "+i_flags);
				 if(i_flags=="1")
				 {
					 var jtnames = document.getElementById("jtname"+i).value;	
					 var jttels = document.getElementById("jttel"+i).value;
					 //add jt cust_id imp_id=999999
					 var jt_custid=document.getElementById("grp_cust_id"+i).value;
					 var grp_imp_id1="999999";
					 //alert("集团的 jtnames is "+jtnames);
					 jtnameArrays.push(jtnames);
					 jttelArrays.push(jttels);
					 i_flag_grp.push(i_flags);
					 grp_cust_id.push(jt_custid);
					 grp_imp_id.push(grp_imp_id1);	
				 }
				 if(i_flags=="2")
				 {
					 var i_duty = document.getElementById("impduty"+i).value;
					 var i_dep = document.getElementById("impdep"+i).value;
					 //xl add 新增重要的name impnameArrays
					 var imp_name = document.getElementById("impname"+i).value;
					//alert("重要的 imp_name is "+imp_name);
					//add  
					 var imp_cust_id1=document.getElementById("imp_cust_id"+i).value;
					 var imp_imp_id1 = document.getElementById("imp_id"+i).value;
					 dutyArrays.push(i_duty);
					 depArrays.push(i_dep);
					 impnameArrays.push(imp_name);
					 i_flag_imp.push(i_flags);
					 imp_cust_id.push(imp_cust_id1);
					 imp_imp_id.push(imp_imp_id1);
				 }
				 
				 
				 //flagArrays.push(i_flags);
				 
				 check_flag=1;	
			 
			 
		}
		else
		{
			for (i = 0; i < len; i++) 
			{ 
				
				//alert(" 2 i is "+i);
				if (document.form.testcheck[i].checked == true) 
				{ 
					 var i_flags = document.getElementById("jtflag"+i).value;//判断集团or重要的
					 //alert(" i_flags   is "+i_flags);
					 if(i_flags=="1")
					 {
						 var jtnames = document.getElementById("jtname"+i).value;	
						 var jttels = document.getElementById("jttel"+i).value;
						 //add jt cust_id imp_id=999999
						 var jt_custid=document.getElementById("grp_cust_id"+i).value;
						 var grp_imp_id1="999999";
						 //alert("集团的 jtnames is "+jtnames);
						 jtnameArrays.push(jtnames);
						 jttelArrays.push(jttels);
						 i_flag_grp.push(i_flags);
						 grp_cust_id.push(jt_custid);
						 grp_imp_id.push(grp_imp_id1);	
					 }
					 if(i_flags=="2")
					 {
						 var i_duty = document.getElementById("impduty"+i).value;
						 var i_dep = document.getElementById("impdep"+i).value;
						 //xl add 新增重要的name impnameArrays
						 var imp_name = document.getElementById("impname"+i).value;
						//alert("重要的 imp_name is "+imp_name);
						//add  
						 var imp_cust_id1=document.getElementById("imp_cust_id"+i).value;
						 var imp_imp_id1 = document.getElementById("imp_id"+i).value;
						 dutyArrays.push(i_duty);
						 depArrays.push(i_dep);
						 impnameArrays.push(imp_name);
						 i_flag_imp.push(i_flags);
						 imp_cust_id.push(imp_cust_id1);
						 imp_imp_id.push(imp_imp_id1);
					 }
					 
					 
					 //flagArrays.push(i_flags);
					 
					 check_flag=1;	
				}
			}
		}
			
		
		//alert("test check_flag is "+check_flag);
		if(check_flag=="1")
		{
			 
			//alert("before jtnameArrays is "+jtnameArrays+" and jttel is "+jttelArrays+" and flagArrays is "+flagArrays+" and dutyArrays is "+dutyArrays+" and depArrays is "+depArrays+" and impnameArrays is "+impnameArrays);
			var url="asdf_Cfm.jsp?jtnameArrays="+jtnameArrays+"&jttelArrays="+jttelArrays+"&flagArrays="+flagArrays+"&dutyArrays="+dutyArrays+"&depArrays="+depArrays+"&impnameArrays="+impnameArrays+"&i_flag_grp="+i_flag_grp+"&i_flag_imp="+i_flag_imp+"&unitId="+"<%=unitid%>"+"&grp_cust_id="+grp_cust_id+"&grp_imp_id="+grp_imp_id+"&imp_cust_id="+imp_cust_id+"&imp_imp_id="+imp_imp_id;
			var url_new =url;//URLencode(url);
		 
			document.form.action=url_new;
			var	prtFlag = rdShowConfirmDialog("是否确定本次操作？");
			if (prtFlag==1)
			{
				//alert("bizcodeArrays is "+bizcodeArrays);
				document.form.submit();  
			}
			else
			{
				return false;
			}
			/*
			var url="e774_Cfm.jsp?bizcodeArrays="+bizcodeArrays+"&spidArrays="+spidArrays+"&serverArrays="+serverArrays+"&feeArrays="+feeArrays+"&beginDtsArrayss="+beginDtsArrayss+"&ivrflag="+ivrFlag;
			var url_new =url;//URLencode(url);
		 
			document.form.action=url_new;
			var	prtFlag = rdShowConfirmDialog("是否确定本次退费操作？");
			if (prtFlag==1)
			{
				//alert("bizcodeArrays is "+bizcodeArrays);
				//document.form.submit();  
			}
			else
			{
				return false;
			}*/
		}
		 
		
	 
		

	}
</script> 
 
