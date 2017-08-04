<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/product/product.js"></script>
<%
	String servId =request.getParameter("servId");
System.out.println("===servId==="+servId);	
	String proName=request.getParameter("proName");
	String GROUP_TYPE_ID="";
	String GROUP_TYPE_NAME="";
	String ProdId=request.getParameter("ProdId");
	String proTemp="";
	String attrInfo=request.getParameter("attrInfo")==null?"":request.getParameter("attrInfo");
	String groupIdIns="";
	String memPowerIns="";
	String shortNoIns="";
	if(ProdId.indexOf("A") != -1){
			proTemp = ProdId.split("A")[1];
		}else{
			proTemp  = ProdId;
		}		
	String isNew=request.getParameter("isNew");
  String[] attrVal=null;
  int num=0;
	if(isNew.equals("新购"))
	{
		isNew="1";
	}
System.out.println("=====isNew===="+isNew);	
	if(!isNew.equals("1"))
	{
%>	
<wtc:utype name="sQProdIntAtr" id="retVal1" scope="end" >
	<wtc:uparam value="0" type="int" />
	<wtc:uparam value="<%=servId%>" type="long" />	
</wtc:utype>
<%
		String retCode1 = retVal1.getValue(0);
		if(retCode1.equals("0"))
		{
System.out.println("属性数量===="+retVal1.getUtype(2).getSize());		
				attrVal=new String[retVal1.getUtype(2).getSize()];
  			for(int i=0;i<retVal1.getUtype(2).getSize();i++)
  			{		
  				if(retVal1.getValue("2."+i+".4").equals(""))
  				{
  					attrVal[i]=retVal1.getValue("2."+i+".3")+"~M^";
  				}else
  				{
  					attrVal[i]=retVal1.getValue("2."+i+".3")+"~"+retVal1.getValue("2."+i+".4");
  				}
  				if(retVal1.getValue("2."+i+".3").equals("90011"))
  				{
  					groupIdIns=retVal1.getValue("2."+i+".4");
  				}else if(retVal1.getValue("2."+i+".3").equals("90012"))
  				{
  					memPowerIns=retVal1.getValue("2."+i+".4");
  				}else if(retVal1.getValue("2."+i+".3").equals("90013"))
  				{
  					shortNoIns=retVal1.getValue("2."+i+".4");
  				}
  			}
  	}	
  	else
  	{
%>
	<script>
		 rdShowMessageDialog("查询产品实例化属性信息失败");
		 window.close();
	</script>	
<%  	
			return;
  	}	
	}
%>
<script language="javascript">
	var tempAttr="";
	$(document).ready(function () {
		$("#tb :input").not(":button").keyup(function stopSpe(){
					var b=this.value;
					if(/[^0-9a-zA-Z\u4E00-\u9FA5]/.test(b)) this.value=this.value.replace(/[^0-9a-zA-Z\u4E00-\u9FA5]/g,'');
			});
		var isNew="<%=isNew%>";
	if(isNew!="1")
	{
			document.all.but.disabled=true;
	}		
		var attributeInfo = "";
	attributeInfo = "<%=attrInfo%>";
	if(attributeInfo !="undefined" && attributeInfo != ""){
		$.each(strtemp.split(","),function(i,n){
			var temp = n.split("~");
			if(typeof(temp[1]) != "undefined"){
				if(temp[0]=="90011")
				{
					document.all.groupId.value=temp[1].trim();
				}else if(temp[0]=="90013")	
				{
					document.all.shortNo.value=temp[1].trim();
				}	
			}	
		});	
	}	
  })
 
</script>	
<html>
	<title>产品信息设置</title>
	<body>
		<div id="operation">
		<form name="form1">
		<%@ include file="/npage/include/header.jsp" %>
		<div id="operation_table">
				<DIV class="title"><div class="text">属性信息</div></DIV>	
		<div class="input" id="attrInfo" >
			<table id="tb">
				<tr>
				<th>群组ID：</th>
				<td><input type="text" name="groupId" <%if(!isNew.equals("1")){%> value="<%=groupIdIns%>" <%}%> class="required" readonly> <input id="but" type="button" class="b_text" value="查询" onclick="queryInfo();"></td>
				</tr>
			<!--		<tr>
			<th>成员权限：</th>
				<td><input type="text" name="MemberPower" class="required" <%if(!isNew.equals("1")){%> value="<%=memPowerIns%>" <%}%> ></td>
				</tr> -->
				<tr>
				<th>成员短号：</th>
				<td><input type="text" name="shortNo" id="shortNo" class="posInt required" <%if(!isNew.equals("1")){%> value="<%=shortNoIns%>" <%}%> onKeyPress="return isKeyNumberdot(0)" onblur="validate();" ></td>
				</tr>
			</table>
		</div>
	</div>
	<div id="operation_button">
		<input type="button"  class="b_foot" value="确定" onclick="fn()"  />
		<input type="button"  class="b_foot" value="关闭" onclick="shut()"  />
	</div>
	<%@ include file="/npage/include/footer.jsp" %>
	</form>	
</div>
	</body>	
</html>	
<script language="javascript">
	function validate(){
			var shortNo = document.all.shortNo.value.trim();
			if(shortNo.length>8 || shortNo.length<4){
				rdShowMessageDialog("短号长度只能在4~8位之间");
				document.all.shortNo.value="";
				return false;
			}
			}
	function queryInfo(){
			var h=300;
			var w=500;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px;dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;status:no;help:no";
			var ret=window.showModalDialog("queryGroupInfo.jsp","",prop);
			if(typeof(ret)!="undefined" && ret!=null && ret!=""){
					document.all.groupId.value=ret;
				}
			}
	function chkLimit()
{
	var retList="";
	var shortNo = document.all.shortNo.value;
	var groupId = document.all.groupId.value;
	var senddata={};
	senddata["shortNo"] = shortNo;
	senddata["groupId"] = groupId;
		$.ajax({
		  url: 'ajax_checkShortNo.jsp',
		  type: 'POST',
		  data: senddata,
		  async: false,//同步
		  error: function(data){
				if(data.status=="404")
				{
				  alert( "文件不存在!");
				}
				else if (data.status=="500")
				{
				  alert("文件编译错误!");
				}
				else{
				  alert("系统错误!");  					
				}
		  },
		  success: function(data)
		  {		   
		          retList = data;
		  }
		});
		senddata = null;
		return  retList;
}		
	function fn()
	{
		if(!checksubmit(document.form1))return false;
		var retArr=chkLimit();
		if(retArr=="Y")
		{
			rdShowMessageDialog("该短号已经存在，请重新输入");
			document.all.shortNo.value="";
			document.all.shortNo.focus();
			return false;
		}
			var attrCode = [];				//群组属性ID
  		var attrValue = [];		//群组属性value
<%
			if(isNew.equals("1"))
			{
%>
				
						tempAttr="90011"+"~"+document.all.groupId.value+","+"90013"+"~"+document.all.shortNo.value+",";
<%					
			}else
			{

					for(int i=0;i<attrVal.length;i++)
					{
System.out.println("=======attrVal["+i+"]======"+attrVal[i]);					
							String[] attTmp=attrVal[i].split("~");
System.out.println("======attTmp.length====="+attTmp.length);							
							String attrid=attTmp[0];
							String attrval=attTmp[1];
							if(attrval.equals("M^"))
							{
								attrval="";
							}
%>
							  if("90011"=="<%=attrid%>"&& document.all.groupId.value!="<%=attrval%>")
							  {
									tempAttr=tempAttr+"90011"+"~"+document.all.groupId.value+",";
								}else if("90013"=="<%=attrid%>"&& document.all.shortNo.value!="<%=attrval%>")	
								{
									tempAttr=tempAttr+"90013"+"~"+document.all.shortNo.value+",";
								}		
					
<%							
					}
			}	
%>				
			o =new Object();
			o.newVal=tempAttr;
			o.newFlag="<%=isNew%>";
			window.returnValue =o;
			window.close();
	}
	function shut()
	{
			window.close();
	}
</script>	