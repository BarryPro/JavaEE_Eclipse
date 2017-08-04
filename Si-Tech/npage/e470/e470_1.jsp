<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 赠送预存款 8379
   * 版本: 1.0
   * 日期: 2010/3/12
   * 作者: sunaj
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
	request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>赠送预存款</title>
<%
    //String opCode="8379";
	//String opName="赠送预存款";

    String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");	
	String phoneNo = (String)request.getParameter("activePhone");
    String workNo=(String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
 
%>
<%
  /****得到打印流水****/
  String printAccept="";
  printAccept = getMaxAccept();

 
%>
 		
 
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

</head>  
<body onload="checkRight()">
<form action="" name="frm" method="POST">
 	<input type="hidden" name="opcode" value = "e470" >
	<input type="hidden" name="opname" value = "集团手工充值" >
	<%@ include file="/npage/include/header.jsp" %>

<div id="Operation_Table0"> 
<div class="title">
	<div id="title_zi">集团客户充值卡手工充值</div>
</div>	 
	<table cellspacing="0" id="tabList">
	   
		<tr >
			<td class="blue" >卡&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号 <input type="text" name="kahao"> 
	 &nbsp;&nbsp;&nbsp;
			 密&nbsp;&nbsp;&nbsp;&nbsp;码 <input type="password" name="kamima"    maxlength="18">
			 &nbsp;&nbsp;&nbsp;
			 面&nbsp;&nbsp;&nbsp;&nbsp;值 <input type="text" name="kamianzhi">
			 </td>
		</tr>
		<tr > 
			<td class="blue" colspan=2>手机号码 <input type="text" name="phoneNo">&nbsp;&nbsp;&nbsp;  
			 集团代码 <input type="text" name="uid">  
				 &nbsp;&nbsp;&nbsp;集团名称 <input type="text" name="grpName" readonly > <input type=button class="b_foot" name="check2" value="查询" onclick="getName()" >
			</td>
		
		</tr>
		<tr>
			<td class=blue>开始年月 <input type="text" name="beginDt" maxlength=6  >&nbsp;&nbsp;&nbsp;&nbsp;结束年月 <input type="text" name="endDt" maxlength=6  >(YYYYMM)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=button class="b_foot" value="报表查询" id="bbcx" onclick="doQuery2(document.all.beginDt.value,document.all.endDt.value)" ></td>
		</tr>
		<tr>
			<td align=center><input type=button class="b_foot" name="check2" value="充值" id="cz" onclick="docfm()" >
			<!--
			<input type=button class="b_foot" value="生成报表" onclick="printTable(tabList)" >
			-->
			
			<input type=reset class="b_foot" value="重置" >
			</td>
		<tr>
		</tr>
		
	</table>
</div>
<div id="showResult">
	<table cellspacing="0">
		<!--地市 工号 充值时间 充值手机号码 营销案名称 归属集团代码 归属集团名称 充值金额-->
		<tr><th>地市</th><th>工号</th><th>充值时间</th><th>充值手机号码</th><th>营销案名称</th><th>归属集团代码</th><th>归属集团名称</th><th>充值金额</th><tr> 
	</table>
</div>
 
 
</table>
 
 
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
<script language="javascript">
	function doQuery2(d1,d2)
	{
		 var year1 =  d1.substr(0,4);
		  var year2 =  d2.substr(0,4); 
		  var month1 = d1.substr(4,2);
		  var month2 = d2.substr(4,2);
		  var myDate = new Date(); 
		  var year31 =  myDate.getFullYear();
		 // alert("year31 is "+year31);
		  //var year3 =  year31.substr(0,4);   
		  var month31=myDate.getMonth();
		 // alert("month31 is "+month31);
		 // var month3=month31.substr(4,2);
		//  var len=(year2-year1)*12+(month2-month1);
		var len=(year31-year1)*12+(month31-month1+1);
		 if(document.all.beginDt.value=="" ||document.all.endDt.value=="")
		 {
			rdShowMessageDialog("请输入查询的开始和结束时间！时间格式为YYYYMM。");
			return false;
		 }
		 
			// alert("year1 is "+year1);
			  
              if(len<0)
			  {
				  rdShowMessageDialog("查询起始月份不能比查询终止月份大!");
				  return false;
			  }
			  if(len>6)
			  {
				  rdShowMessageDialog("只可以查询近6个月的记录!");
				  return false;
			  }			
				
		 	
		 var actions = "e470_show.jsp?beginDt="+document.all.beginDt.value+"&endDt="+document.all.endDt.value;
		 document.all.frm.action=actions;
		 document.all.frm.submit();
	}
	function doQuery()
	{
		 if(document.all.beginDt.value=="" ||document.all.endDt.value=="")
		 {
			rdShowMessageDialog("请输入查询的开始和结束时间！时间格式为YYYYMM。");
			return false;
		 }
		 document.getElementById("showResult").innerHTML="";
		 var myPacket = new AJAXPacket("e470_query.jsp","正在提交，请稍候......");
		 myPacket.data.add("beginDt",document.all.beginDt.value);
		 myPacket.data.add("endDt",document.all.endDt.value);
		 core.ajax.sendPacket(myPacket);
    	 myPacket=null;
	}
	function getName()
	{
		/*if(document.all.phoneNo.value=="")
		{
			rdShowMessageDialog("请输入集团手机号码！");
			return false;
		}*/
		if(document.all.uid.value=="")
		{
			rdShowMessageDialog("请输入集团代码！");
			return false;
		}
		//alert("unitId is "+document.all.uid.value);
		var myPacket = new AJAXPacket("e470_getName.jsp","正在提交，请稍候......");
		myPacket.data.add("phoneNo",document.all.phoneNo.value);
		myPacket.data.add("unitId",document.all.uid.value);
		core.ajax.sendPacket(myPacket);
    	myPacket=null;
	}
	function checkRight()
	{
		document.getElementById("bbcx").disabled=true;
		document.getElementById("cz").disabled=true;
		document.getElementById("showResult").style.display="none";
		var myPacket = new AJAXPacket("e470_check.jsp","正在提交，请稍候......");
		myPacket.data.add("loginNo","<%=workNo%>");
		core.ajax.sendPacket(myPacket);
    	myPacket=null;
	}
	
	function doProcess(packet)
	{
		var flagConfirm =  packet.data.findValueByName("flag1");
		 
		if(flagConfirm==2 )
		{
			rdShowMessageDialog("工号操作失败");
			return false;
		}
		if(flagConfirm==1 )
		{
			rdShowMessageDialog("工号不具备操作权限!");
			return false;
		}
		if(flagConfirm==0 )
		{
			//rdShowMessageDialog("ok! 维护手册还要新增一个权限表~");
			document.getElementById("bbcx").disabled=false;
			document.getElementById("cz").disabled=false;
			return true;
		}
		var flagName =  packet.data.findValueByName("flagName");  
		var grpName =  packet.data.findValueByName("grpName"); 
		if(flagName==1)
		{
			rdShowMessageDialog("查询集团名称出错!");
			return false;
		}
		if(flagName==0)
		{
			document.all.grpName.value=grpName;
			
		}
		//xl add for 报表查询
		var flag_show =packet.data.findValueByName("flag_show"); 
		if(flag_show==1)
		{
			rdShowMessageDialog("报表数据不存在!");
			return false;
		}
		if(flag_show==1)
		{
			rdShowMessageDialog("报表查询出错!");
			return false;
		}
		if(flag_show==0)
		{
			document.getElementById("showResult").style.display="block";
			var counts = packet.data.findValueByName("count_is");
			document.getElementById("showResult").innerHTML+="<table id='showIds'><tr><th>地市</th><th>工号</th><th>充值时间</th><th>充值手机号码</th><th>营销案名称</th><th>归属集团代码</th><th>归属集团名称</th><th>充值金额</th></tr> "; 
			for(i =0;i<counts;i++)
			{
				var region_name = packet.data.findValueByName("region_name"+i);
				var phone_No1 = packet.data.findValueByName("phone_No1"+i);
				//document.getElementById("showResult").innerHTML+="<tr><td>"+region_name+"</td><td>"+phone_No1 +"</td></tr>";
				document.getElementById("showResult").innerHTML+="<table id='table'"+i+"><tr><td>"+region_name+"</td><td>"+phone_No1+"</td></tr></table>";
		 
			}
			document.getElementById("showResult").innerHTML+=" <tr><td><input type='button' class='b_foot' value='导出报表' onclick='printTable(showIds,)'></td><tr></table>"; 
		}
	}
	function docfm()
	{
		var groupName = document.all.grpName.value;
		if(groupName=="")
		{
			rdShowMessageDialog("请输入集团代码,并单击查询按钮,加载集团名称!");
			return false;
		}
		else if(document.all.kamima.value=="" ||document.all.kahao.value==""||document.all.kamianzhi.value=="")
		{
			rdShowMessageDialog("请输入充值卡号、卡面值和充值卡密码!");
			return false;
		}	
		else
		{
			var	prtFlag = rdShowConfirmDialog("是否确定充值？");
			if (prtFlag==1)
			{
				var actions = "e470_2.jsp?phoneNo="+document.all.phoneNo.value+"&cardNo="+document.all.kahao.value+"&kmm="+document.all.kamima.value+"&grpName="+document.all.grpName.value+"&grpId="+document.all.uid.value+"&kmz="+document.all.kamianzhi.value;
				document.all.frm.action=actions;
				document.all.frm.submit();
			}
			
		}
		
		
	}

	
function printTable(obj){
	var excelObj;
	var excelObj2;
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	if(document.all.tabList.length > 1)	
	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
		excelObj.WorkBooks.Add;
		for(a=0;a<document.all.tabList.length;a++)
		{
			rows=obj[a].rows.length;
			if(rows>0)
			{
 				try
				{
					for(i=0;i<rows;i++)					{
						cells=obj[a].rows[i].cells.length;
						for(j=0;j<cells;j++)
							excelObj.Cells(i+1+(total_row),j+1).Value=obj[a].rows[i].cells[j].innerText;
					}
				}
				catch(e)
				{
					//alert('生成excel失败!');
				}
			}
			else
			{
				alert('no data');
 			}
 			total_row = eval(total_row+rows);
		}
		alert("1");
		//new
		for(a=0;a<document.all.tabList.length;a++)
		{
			alert("2");
			rows2=obj2[a].rows.length;
			if(rows2>0)
			{
 				try
				{
					for(i=0;i<rows2;i++)					{
						cells2=obj2[a].rows2[i].cells.length;
						for(j=0;j<cells2;j++)
							excelObj.Cells(i+1+(total_row),j+1).Value=obj2[a].rows2[i].cells2[j].innerText;
					}
				}
				catch(e)
				{
					//alert('生成excel失败!');
				}
			}
			else
			{
				alert('no data');
 			}
 			total_row = eval(total_row+rows);
		}
		//end new
	}
	else
	{
		 
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
		excelObj.WorkBooks.Add;
		rows=obj.rows.length;
	 
		if(rows>0)
		{
 			try
			{
				for(i=0;i<rows;i++)
				{
					cells=obj.rows[i].cells.length;
					for(j=0;j<cells;j++)
						excelObj.Cells(i+1,j+1).Value=obj.rows[i].cells[j].innerText;
				}
			}
			catch(e)
			{
				//alert('生成excel失败!');
			}
			total_row = eval(total_row+rows);
		}
		else
		{
			alert('no data');
		}
		 
	}
}
 

</script>
 
 