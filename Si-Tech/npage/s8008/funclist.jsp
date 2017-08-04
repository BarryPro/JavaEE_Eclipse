
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-16
********************/
%>

<%
  String opCode = "8008";
  String opName = "注册新功能";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=gbk"%>

<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%
	String[][] result = new String[][]{};
	String loginNo = (String)session.getAttribute("workNo");
	String regionCode = (String)session.getAttribute("regCode");

	String roleCode = request.getParameter("roleCode");	//角色代码
	String roleName = request.getParameter("roleName");	//角色名称

	String popeDomCodeIn = request.getParameter("popeDomCode");	//权限代码
	String popeDomNameIn = request.getParameter("popeDomName");	//权限代码

	String parentFuncCode = "";	//父节点funccode
	String parentPdtCode = "";	//父节点权限类型代码
	String flag ="0"; //huangrong  add 标记是否选中左侧树的节点 0：未选中，1选中

	//输出参数
	String checkFlag   ="";				//选中标志
	String popeDomCode ="";				//权限代码
	String popeDomName ="";				//权限名称
	String reflectCode ="";				//操作代码
	String bakLeafFlag ="";				//备用

	//根据父权限代码取父funcode
	String sqlStr = "select reflect_code,pdt_code from sPopeDomCode where popedom_code = '"+popeDomCodeIn+"' ";
	System.out.println("------------- sqlStr----------------"+sqlStr);
	//acceptList = callView.sPubSelect("2",sqlStr);
%>

		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>

<%
	String[][] colNameArr = result_t1;

	if (colNameArr != null&&colNameArr.length>0)
	{
		if (colNameArr[0][0].equals(""))
		{
			colNameArr = null;
		}
	}

	if(colNameArr!=null&&colNameArr.length>0)
	{
		parentFuncCode=colNameArr[0][0];
		parentPdtCode=colNameArr[0][1];
	}

	//parentPdtCode="01";

	if(popeDomNameIn==null)
	{
		popeDomNameIn="全部权限";
	}
	//huangrong add 是否选中左侧树的节点
	if(popeDomCodeIn==null)
	{
		flag="0";
	}else
	{
		flag="1";	
	}	
	/****sunwt add 查询显示工号类型配置信息****/
	sqlStr = "select account_type, account_name from sAccType where account_type != '0' and account_type != '4' ";
	//acceptList = callView.sPubSelect("2",sqlStr,"region",regionCode);
%>

		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>

<%
	String[][] acctypeArr = result_t2;
	/******************************************/
	String op_name = "添加新功能";
	String note = "<b>"+popeDomNameIn+"</b>下的权限信息";
	System.out.println("-------------调用服务sQryRolePDOM----------------");

	String paramsIn[] = new String[4];

	paramsIn[0]=loginNo;
	paramsIn[1]="8008";
	paramsIn[2]=roleCode;
	paramsIn[3]=popeDomCodeIn;
		System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"+roleCode);
		System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"+popeDomCodeIn);
	//acceptList = callView.callFXService("sQryRolePDOM", paramsIn, "25","region",regionCode);
	//callView.printRetValue();
%>

    <wtc:service name="sQryRolePDOM" outnum="25" retmsg="msg3" retcode="code3" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />
		</wtc:service>
		<wtc:array id="result_t3" scope="end"   />

<%
	String errCode = code3;
	String errMsg = msg3;
	if(!errCode.equals("000000"))
	{
	%>
	  <script language='jscript'>
	     rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
	     document.location="blank.html";
	  </script>
	<%
	}
	if(errCode.equals("000000")&&result_t3.length>0)
	{

		checkFlag 	= result_t3[0][0];
		popeDomCode = result_t3[0][1];
		popeDomName = result_t3[0][2];
		reflectCode = result_t3[0][3];
		bakLeafFlag = result_t3[0][4];
	}
	%>
<html>
<head>
<title><%=op_name%></title>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<script language=javascript>
	onload=function()
	{
		 self.status="";
		 //huangrong add 新增优惠功能代码（以a开头四位代码）时，打开方式、密码验证、免密模块，全部隐藏 2011-6-21 
		 if("<%=flag%>"!="0")
		 {
			 if("<%=popeDomCodeIn%>"=="3012")
			 {
			 	document.all.open_way.disabled=true;
			 }
			 if(document.all.open_way.value=="0")
			 {
			 	document.all.pass_flag.disabled=true;
	  		document.all.pass_module.disabled=true;  		
			 }
		 }
	}

	//处理rpc返回结果
	function doProcess(packet)
	{
		self.status="";
		var rpcType=packet.data.findValueByName("rpcType");
		var errCode=packet.data.findValueByName("errCode");
		var errMsg=packet.data.findValueByName("errMsg");
		if(parseInt(errCode)!=0)
		{
			rdShowMessageDialog("错误代码"+errCode+"<br>错误信息"+errMsg, 0);
			return false;
		}

		if(rpcType=="checkfunc")
		{
				rdShowMessageDialog(errMsg);
				document.form1.subBtn.disabled=false;
				document.form1.func_code.readOnly=true;
				if(document.form1.func_code.value.length==5)
				{
					document.form1.form_name.value="#";
					document.form1.form_name.readOnly=true;
				}
				return;
		}

		if(rpcType=="checkReflect")
		{
				rdShowMessageDialog(errMsg);
				document.form1.subBtn.disabled=false;
				document.form1.func_code.readOnly=true;
				return;
		}
	}

	function doSubmit()
	{
		with(document.form1)
		{

			if(form_name.value=="")
			{
				rdShowMessageDialog("页面位置为必填项，请务必填写！",0);
				form_name.focus();
				return;
			}

			if(form_name.value.length>120)
			{
				rdShowMessageDialog("页面位置长度不正确！",0);
				form_name.focus();
				return;
			}
		}
/*		if(document.all.open_way.value=="0"){
				rdShowMessageDialog("请选择打开方式",0);
				document.all.open_way.focus();
				return;
		}
 */
		var i;
		var accTypeList="";
		for(i = 0; i < document.form1.chkaccType.length; i++)
		{
			if(document.form1.chkaccType[i].checked == true)
			{
				accTypeList = accTypeList + document.form1.chkaccType[i].value+"|";
			}
		}
		form1.action="f8008Cfm.jsp?accTypeList="+accTypeList+"&open_way="+document.all.open_way.value+"&pass_flag="+document.all.pass_flag.value+"&pass_module="+document.all.pass_module.value ;
		form1.submit();
	}

	function doSubmit1()
	{
		form1.action="f8008Cfm.jsp?open_way="+document.all.open_way.value+"&pass_flag="+document.all.pass_flag.value+"&pass_module="+document.all.pass_module.value ;
		form1.submit();
	}

	//显示增加业务信息表格
	function showAddBusiInfo()
	{
		tabBusiAdd.style.display="";
		tabInfo.style.display="";
		tabAddBtn.style.display="none";
	}

	function checkFunc()
	{
		with(document.form1)
		{
			//if(!forInt(func_code))
			//return;

			if(func_code.value.trim()==""||(func_code.value.trim().length!=4&&func_code.value.trim().length!=5))
			{
				rdShowMessageDialog("请输入4位或5位功能代码！",0);
				return false;
			}

			if(parentFuncCode.value.length!=5)
			{
				rdShowMessageDialog("父节点不是目录，不能建下一级功能！",0);
				return;
			}

/*
			if((func_code.value.length==5)&&(func_code.value.charAt(0)!=9))
			{
				rdShowMessageDialog("功能代码为5位时为目录,应以9开头！",0);
				func_code.focus();
				return;
			}
			*/
		}

		var myPacket = new AJAXPacket("f8008_checkfunc_rpc.jsp","正在提交，请稍候......");
		myPacket.data.add("rpcType","checkfunc");
		myPacket.data.add("func_code",document.form1.func_code.value);
		core.ajax.sendPacket(myPacket);
		myPacket = null;
	}

	function checkReflect()
	{
		//alert("checkReflect");
		with(document.form1)
		{

			if(!forInt(document.form1.func_code))

			return;

			if(func_code.value=="")
			{
				rdShowMessageDialog("请输入操作代码！",0);
				return false;
			}

			if(parentFuncCode.value.length>20)
			{
				rdShowMessageDialog("操作代码长度不正确！",0);
				return;
			}

		}
		//alert("aaa");
		var myPacket = new AJAXPacket("f8008_checkReflect_rpc.jsp","正在提交，请稍候......");
		myPacket.data.add("rpcType","checkReflect");
		myPacket.data.add("func_code",document.form1.func_code.value);
		core.ajax.sendPacket(myPacket);
		myPacket = null;
	}

	function clearFrm()
	{
		with(form1)
		{
			func_code.readOnly=false;
			func_code.value="";
			func_name.value="";
			main_code.value="1";
			order_id.value="0";
			form_name.value="";
			form_name.readOnly=false;
			note.value="";
			subBtn.disabled=true;
		}
	}


	function clearFrmReflect()
	{
		with(form1)
		{
			func_code.readOnly=false;
			func_code.value="";
			func_name.value="";
			subBtn.disabled=true;
		}
	}
	function changeOpenWay()
  {

  	//begin huangrong add   	“打开方式”为目录、外围系统时，密码验证、免密模块，全部隐藏。2011-6-15 
  	if(document.all.open_way.value=="0" || document.all.open_way.value=="4") 
  	{
  		document.all.pass_flag.value="000";
  		document.all.pass_flag.disabled=true;
  		document.all.pass_module.value="0";
  		document.all.pass_module.disabled=true;    		
  	}else
		{
  		document.all.pass_flag.value="001";
  		document.all.pass_flag.disabled=false;
  		document.all.pass_module.value="0";
  		document.all.pass_module.disabled=false;  			
		}
  	//end huangrong add   	“打开方式”为目录、外围系统时，密码验证、免密模块，全部隐藏。2011-6-15 
    if(document.all.open_way.value=="2"){
  	     document.all.pass_flag.value="001";
  	}else{
  		   document.all.pass_flag.value="000";
  		   document.all.pass_module.disabled=true;  
  	}
  }
  //begin huangrong add 	2011-6-15 
  //1,“是否可见”为不可见时，密码验证、免密模块，全部隐藏。（打开方式默认目录、密码验证默认不需要、免密模块默认非免密模块）
  function changeMainCode(bing)
  {
  	if(bing.value=="0")
  	{
  		document.all.open_way.value="0";
  		document.all.pass_flag.value="000";
  		document.all.pass_flag.disabled=true;
  		document.all.pass_module.value="0";
  		document.all.pass_module.disabled=true;  		
  	}else
		{
		  if("<%=popeDomCodeIn%>"=="3012")
		  {
		  	document.all.open_way.disabled=true;
		  }else
		  {
  			document.all.open_way.disabled=false;		  	
		  }	
  		document.all.open_way.value="0";
  		document.all.pass_flag.value="000";
  		document.all.pass_flag.disabled=true;
  		document.all.pass_module.value="0";
  		document.all.pass_module.disabled=true;  			
		}

  }
  //2,“密码验证”为不需要时，免密模块，隐藏。（免密模块默认非免密模块） 
  function changePassFlag(bing)
  {
  	if(bing.value=="000")
  	{
  		document.all.pass_module.disabled=true;   		
  	}else
  	{
  		document.all.pass_module.disabled=false;     		
  	}	
  		
  }
  //end huangrong add 
</script>
</head>
<body >

<FORM METHOD=POST ACTION="" name="form1">
	<%@ include file="/npage/include/header.jsp" %>


	<div class="title">
		<div id="title_zi"><%=note%></div>
	</div>
<input type="hidden" name="pdt_code" value="<%=parentPdtCode%>">



				<table  width="100%" align="center"  cellspacing="1" border="0" vColorTr='set'>
					<tr>
				  	<th align="center">功能代码</th>
				  	<th align="center">功能名称</th>
				  </tr>
				<%
					for(int i = 0; i < result_t3.length; i++)
					{

						if((i+1)%2==1)
						{
				%>
				      		<tr>
				      			<td align="center"   height="20"><%=result_t3[i][3]%></td>
								<td align="center"   height="20"><%=result_t3[i][2]%></td>
				<%
						}
						else
						{
				%>
							<tr>
								<td align="center" class=""  height="20"><%=result_t3[i][3]%></td>
								<td align="center" class=""   height="20"><%=result_t3[i][2]%></td>
				<%
						}
				%>

							</tr>
				<%
					}
				%>

		<%
		//优惠权限，模块操作权限
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>.."+parentPdtCode);
		if(parentPdtCode.equals("03")||parentPdtCode.equals("05"))
		{
		%>
	</table>

		<TABLE id="tabBusiAdd" style="display:none"  cellSpacing=0 >
		<input type="hidden" name="parentpopeDomCode" value="<%=popeDomCodeIn%>">
		<input type="hidden" name="parentFuncCode" value="<%=parentFuncCode%>">
		<input type="hidden" name="roleCode" value="<%=roleCode%>">
		<input type="hidden" name="roleName" value="<%=roleName%>">
			<TR  id="line_1">
				<TD colspan="4" height = 25 align="center" ><strong>新建业务信息</strong></TD>
	     </TR>
       <tr  height="22">
	  			<TD width="15%" class="blue">&nbsp;&nbsp;功能代码</TD>
	  			<TD width="35%">
	  					<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=5 v_name="功能代码"  name=func_code maxlength=5 >
	  					<font class="orange">*</font>
	  			</TD>
					<TD width="15%" class="blue">&nbsp;&nbsp;功能名称</TD>
				  <TD width="35%">
				    	<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=30 v_name="功能名称"  name=func_name maxlength=30 >
				 			<font class="orange">*</font>
				  </TD>
			</tr>
			
      <tr  height="22">
	  			<TD width="15%" class="blue">&nbsp;&nbsp;是否可见</TD>
	  			<TD width="35%">
	  				<select name="main_code" onclick="changeMainCode(this)"> <!--huangrong add “是否可见”为不可见时，密码验证、免密模块，全部隐藏。（打开方式默认目录、密码验证默认不需要、免密模块默认非免密模块）-->
	  					<option value="1">可见</option>
	  					<option value="0">不可见</option>
	  				</select>
	  			</TD>	
			  	<TD width="15%" class="blue">&nbsp;&nbsp;打开方式</TD>
					<TD width="35%">
					 <select name="open_way" onclick="changeOpenWay()">
						 		  <option value="0">目录</option>
			  					<option value="1">一级Tab</option>
			  					<option value="2">二级Tab</option>
			  					<option value="4">外围系统</option>
			  		</select>
					</TD>
			</tr>
			
      <tr  height="22">
	  			<TD width="15%" class="blue">&nbsp;&nbsp;密码验证</TD><!--huangrong add 	“密码验证”为不需要时，免密模块，隐藏。（免密模块默认非免密模块）-->
	  			<TD width="35%">
	  				<select name="pass_flag" onclick="changePassFlag(this)" >
	  					<option value="001">需要</option>
	  					<option value="000" selected>不需要</option>
	  				</select>
	  			</TD>
					<TD width="15%" class="blue">&nbsp;&nbsp;免密模块</TD><!--huangrong add 免密模块-->
					<TD width="35%">
					 	<select name="pass_module">
					 		  <option value="0">非免密模块</option>
		  					<option value="1">免密模块</option>
		  			</select>
					</TD>
		 </tr>
			
    <tr  height="22">
		   <TD width="15%" class="blue">&nbsp;&nbsp;排序位置</TD>
		   <TD width="35%">
			    	<input type=text  v_type="string" value="0" v_must=0 v_minlength=1 v_maxlength=1 v_name="排序位置"  name=order_id maxlength=1 >
		   </TD>
	     <TD colspan="2">&nbsp;&nbsp;<input type="button" name="checkFuncBtn" value="验证" onclick="checkFunc()" class="b_text"></TD>
	 </tr>
			
						
   <tr  height="22">
	  <TD width="15%" class="blue">&nbsp;&nbsp;工号类型互斥</TD>
	  <TD width="35%" colspan=3>
	<%
		for(int i = 0; i < acctypeArr.length; i++)
		{
	%>
			<input type="checkbox" name="chkaccType" value="<%=acctypeArr[i][0]%>" checked> <%=acctypeArr[i][1]%>
	<%
		}
	%>
	</TD>
</tr>
<!---->

	<tr  height="22">
				<TD width="15%" class="blue">&nbsp;&nbsp;APT名称</TD>
				<TD width="35%" colspan=3 >
					<input type=text  name=form_name maxlength=120  size="60">
					<font class="orange">*</font>
				</TD>
		</tr>
		<tr  height="22">
				<TD width="15%" class="blue">&nbsp;&nbsp;JSP名称</TD>
				<TD width="35%" colspan=3 >
					<input type=text name=note maxlength=120 size="60">
					<font class="orange">*</font>
				</TD>
		</tr>
</table>

<table id=tabInfo style="display:none"   cellSpacing=0>

				<TR >
					<td>
		      		 <font class="orange"> 说明新建目录时代码应为以"9"开头的五位数字；
        新建功能时代码应为四位数字；
						</font>
					</td>
	      </TR>
	      <TR >
	         	<TD align="center" colspan=5 id="footer">
	         	    <input name="subBtn" style="cursor:hand" type="button"  value="提  交" onClick="if(check(form1)) doSubmit()" disabled class="b_foot">&nbsp;&nbsp;
	         	     <input name="resetBtn" style="cursor:hand" type="button"  value="重  置" onClick="clearFrm()"   class="b_foot">&nbsp;&nbsp;
	         	    <input  name="doButton" type="button"  value="关  闭"   onclick="parent.parent.removeTab('8008')" class="b_foot">&nbsp;
			 			</TD>
	      </TR>
</table>

<TABLE id="tabAddBtn" style="display:''"   cellSpacing=0 >
			 <TR >
	         	<TD height="30" align="center" id="footer">
	         	    <input name="addBtn" style="cursor:hand" type="button"  value="添加新功能" onClick="showAddBusiInfo()" class="b_foot_long">
	         	    <input  name="doButton" type="button"  value="关  闭"  class="b_foot" onclick="parent.parent.removeTab('8008')">&nbsp;
	         	    &nbsp;
			 			</TD>
	      </TR>
</TABLE>
	    <%}
		else if(parentPdtCode.equals("01")||parentPdtCode.equals("02")||parentPdtCode.equals("04")||parentPdtCode.equals("06"))
		{//报表权限，数据查看权限，数据维护权限，其他
		%>
		<TABLE id="tabBusiAdd" style="display:none"  cellSpacing=0 >
		<input type="hidden" name="parentpopeDomCode" value="<%=popeDomCodeIn%>">
		<input type="hidden" name="parentFuncCode" value="<%=parentFuncCode%>">
		<input type="hidden" name="roleCode" value="<%=roleCode%>">
		<input type="hidden" name="roleName" value="<%=roleName%>">
		<TR  id="line_1">
			<TD colspan="4" height = 25 align="center" ><strong>新建权限</strong></TD>
		</TR>
		<tr  height="22">
	  		<TD width="15%" class="blue">&nbsp;&nbsp;操作代码</TD>
	  		<TD width="35%">
	  			<input type=text  v_type="int"  v_must=1 v_minlength=1 v_maxlength=20 v_name="操作代码"  name=func_code maxlength=20 >
	  			<input type="button" name="checkReflectBtn" value="验证" onclick="checkReflect()">
	  					<font class="orange">*</font>
	  		</TD>
			<TD width="15%" class="blue">&nbsp;&nbsp;权限名称</TD>
			<TD width="35%">
				<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=30 v_name="权限名称"  name=func_name maxlength=30 >
				 	<font class="orange">*</font>
			</TD>
		<tr  height="22">
			<TD width="15%" class="blue">&nbsp;&nbsp;工号类型互斥</TD>
			<TD width="35%" colspan=3>
			<%
				for(int i = 0; i < acctypeArr.length; i++)
				{
			%>
					<input type="checkbox" name="chkaccType" value="<%=acctypeArr[i][0]%>" checked> <%=acctypeArr[i][1]%>
			<%
				}
			%>
			</TD>
		</tr>
		</tr>
		</table>
		<table id=tabInfo style="display:none"  cellSpacing=0  >

 <TR >
	        <TD align="center" colspan=5 >
	         	    <input name="subBtn" style="cursor:hand" type="button"  value="提  交" onClick="if(check(form1)) doSubmit1()" disabled class="b_foot">&nbsp;&nbsp;
	         	     <input name="resetBtn" style="cursor:hand" type="button"  value="重  置" onClick="clearFrmReflect()" class="b_foot" >&nbsp;&nbsp;
	         	    <input  name="doButton" type="button"  value="关  闭" onclick="parent.parent.removeTab('8008')" class="b_foot">&nbsp;
			 			</TD>
	      </TR>
	    </table>
			<TABLE id="tabAddBtn" style="display:''"  width="100%" border=0 align="center" cellSpacing=0 >
			 <TR >
	         	<TD height="30" align="center">
	         	    <input name="addBtn" style="cursor:hand" type="button" class="b_foot" value="添加权限" onClick="showAddBusiInfo()">
	         	    <input name="doButton" type="button" value="关  闭" class="b_foot" onclick="parent.parent.removeTab('8008')">&nbsp;
	         	    &nbsp;
			 			</TD>
	      </TR>
	    </TABLE>
				<%
				}
	    %>

		 		</table>
		 		</TD>
			</TR>
		</table>
			     	<input type="hidden"  name="isFamilyBusi"  id="isFamilyBusi" value="0" />
		<%@ include file="/npage/include/footer.jsp" %>
</form>
</html>
