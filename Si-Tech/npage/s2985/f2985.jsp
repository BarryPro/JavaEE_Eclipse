 <%
   /*
   * 功能: 参数集明细配置
　 * 版本: v1.0
　 * 日期: 2008/04/21
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期:2009/05/14      修改人:leimd      修改目的:适应新需求
 　*/
%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%

	String opCode = "2985";
	String opName = "参数集明细配置";
	String regionCode=(String)session.getAttribute("regCode");
     
	int len=0;
	String sqlStr = "select Param_Code,Param_Name,type_name,param_length,param_note from sBizParamCode a,sBizParamType b where a.PARAM_TYPE=b.PARAM_TYPE order by param_code";

%> 
 
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="5" retcode="retCode" retmsg="retMessage">
	<wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="rows" scope="end"/>
	
<%		
	if(retCode.equals("000000"))
	{	
	    //System.out.println("rows.length="+rows.length);
         for(int i=0;i<rows.length;i++){
             //System.out.println("rows["+i+"][0]"+rows[i][0]);
             //System.out.println("rows["+i+"][1]"+rows[i][1]);
       }	
        len=rows.length;
      }
	else{
%>    
		<script language=javascript>	
			rdShowMessageDialog("查询业务参数表出错！!",0);
			document.location.replace("<%=request.getContextPath()%>/npage/s2985/f2985.jsp");
		</script>
<%
		}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<script language=javascript>   
	onload=function() {
		self.status="";
	 	core.ajax.onreceive = doProcess;
	}
	
//处理rpc返回结果
function doProcess(packet) {	
	  self.status="";	

	 var qryType=packet.data.findValueByName("rpcType");
	 var errCode=packet.data.findValueByName("errCode");
	 var errMsg=packet.data.findValueByName("errMsg");
	
 if(qryType == "checkParamSet"){	 
	 if(errCode == "000000")
	    {
		  rdShowMessageDialog("校验成功！",2);
		  document.form1.AddBtn.disabled=false; 
		  document.form1.allSelectt.disabled=false;
		  document.form1.noSelectt.disabled=false;
		  $("#param_set").attr("readOnly",true);
	   }else
	   	   {		   	   	
	   	   rdShowMessageDialog("错误信息："+errMsg + "<br>错误代码："+errCode, 0);
	        }
      }	
}	  
//校验参数代码
function checkParamSet()
{
	if(document.form1.param_set.value=="")
	{
		rdShowMessageDialog("请输入参数集代码！");
		document.form1.param_set.focus();
		return false;
	}
	var myPacket = new AJAXPacket("fcheckParamSet_rpc.jsp","正在提交，请稍候......"); 
	myPacket.data.add("param_set",document.form1.param_set.value);
	myPacket.data.add("rpcType","checkParamSet");
	core.ajax.sendPacket(myPacket);
	myPacket=null;	
} 
function checkParamSet1()
{
	if(document.form1.param_set.value=="")
	{
		rdShowMessageDialog("请输入参数集代码！");
		document.form1.param_set.focus();
		return false;
	}
	form1.action="f2985_search.jsp?param_set="+document.form1.param_set.value;
	form1.target = "framerightb";
	form1.submit();
} 

//选择不同参数类类型
function showTab(){
	if(document.form1.param_type.value=="10"){
		tabSelect.style.display="";
		tabSql.style.display="none";
	}
	else if(document.form1.param_type.value=="20"){
		tabSelect.style.display="none";
		tabSql.style.display="";
	}
}
//提交
function addParam(){
	   if(document.all.set_name.value=="")
	   {
		rdShowMessageDialog("请输入参数集名称！");
		document.all.set_name.focus();
		return false;
	   }
	  var objYN; //是否有選擇
    var i;
    objYN=false;
    for (i = 0;i< document.all.check.length;i++){
    if (document.all.check[i].checked==true) {
    objYN= true;
    break;
      }
    }
	   
	   if(objYN==false)
		{
			rdShowMessageDialog("没选任何参数代码！");
			return;
		}
		  document.form1.target = "";
		  document.form1.action="f5630_2.jsp"; 
		  document.form1.submit();
}
 //全选
	function allSelect()
	{
		var i = 0;
	
		//一行都没有
		if(document.all.check==undefined)
		{
			rdShowMessageDialog("此目录下没有权限,无法全部选中！");
			return;
		}
		//只有一行
		if(document.all.check.length==undefined)
		{
			document.all.check.checked=true;	
		}
		
		for(i=0;i<document.all.check.length;i++)
		{
			document.all.check[i].checked=true;	
		}
	
		
	}
	
	//全部去掉
	function noSelect()
	{
		var i = 0;
		
		//一行都没有	
		if(document.all.check==undefined)
		{
			rdShowMessageDialog("此目录下没有权限,无法全部取消！");
			return;
		}
	
		//只有一行
		if(document.all.check.length==undefined)
		{
			document.all.check.checked=false;	
		}
			
		for(i=0;i<document.all.check.length;i++)
		{
			document.all.check[i].checked=false;
		}
		
	}	
	
	function doReset(){
	    window.location.reload();
	}
</script>
</head>
<body>
<FORM method=post action="" name="form1">  
	 <%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">参数集明细配置</div>
</div>
<table cellspacing="0">
	<tr>
		<TD class="blue">参数集代码 </TD>
		<TD colspan="2">	
			<input type=text v_type="string" class="button" v_must=1 v_minlength=4  v_maxlength=4 v_name="参数代码" name=param_set id='param_set' value="" maxlength=4 ></input>
			<font color="orange">*</font>
			<input type="button" class="b_text" name="checkP" onClick="checkParamSet()" value="校验"  >   
			<input type="button" class="b_text" name="search" onClick="checkParamSet1()" value="查询" > 
			<input type="button" class="b_text"  name="reset" id="reset" onClick="doReset()" value="重置"  >                 	              
		</TD>
		<TD class="blue">参数集名称 </TD>
		<TD colspan="2">
			<input type=text v_type="string" class="button" v_must=1 v_minlength=8  v_maxlength=30 v_name="参数名称"  name=set_name value="" maxlength=30  ></input>
			<font color="orange">*</font>
		</TD>	                
	</tr>
	
	<TR align="center"> 
		<TD><strong><font color="green">备选参数</font></TD>
		<TH>参数代码 </TH> 
		<TH>参数名称 </TH>
		<TH>参数类型 </TH>               	              
		<TH>参数长度 </TH>               	              
		<TH>备注信息 </TH>               	                             	              
	</TR>
		<%
	  for(int i = 0; i < len; i++)
		{
        %>
	    <TR align="center">
        	<td class="blue"> <input type="checkbox" name="check" value="<%=i%>" ></td>				  
	   		<TD>	
		  		<%=rows[i][0].trim()%>
		   		<input type ="hidden" name="ParamCode" value=<%=rows[i][0].trim()%>>         
          	</TD>
			<TD class="blue">
	      		<%=rows[i][1].trim()%>   
	      		<input type ="hidden" name="ParamName" value=<%=rows[i][1].trim()%>>     
			</TD>	
			<TD class="blue">
		      	<%=rows[i][2].trim()%>   
			</TD>	
	    	<TD class="blue">
		      	<%=rows[i][3].trim()%>   
			</TD>
		 	<TD class="blue">
		     	<%=rows[i][4].trim()%>   
			</TD>	 	                
		</TR>
        <%
		}
        %>
	</table>
	
	<TABLE>
		<tr>
			<td colspan="1">		     	
				<Iframe name="framerightb" src="#" frameborder="0" marginwidth="0" marginheight="0" scrolling="auto" width=98%></Iframe>
			</td>	
		</tr>
	</TABLE>
		      	
	<TABLE cellSpacing="0" >
		<TR>
			<TD id="footer" align="center">
				<input class="b_foot" name=allSelectt type=button   value="全部选中" onclick="allSelect();"  disabled>
				<input class="b_foot" name=noSelectt  type=button   value="全部取消" onclick="noSelect();" disabled >
				<input name="AddBtn" type="button" class="b_foot" value="下一步"   onClick="addParam();"  disabled>
				<input name="close"  type="button" class="b_foot" value="关闭"   onClick="removeCurrentTab();">
			</TD>
			<TD></TD>
		</TR>
	</table>
	  <%@ include file="/npage/include/footer.jsp" %>
	    </form>
	 </body>
	</html>
		