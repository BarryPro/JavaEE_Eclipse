<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/validate_class.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/product/autocomplete_ms.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/product/product.js"></script>
<%

    String opCode = request.getParameter("opCode");
    String opName = "产品变更";
    
	String servId =request.getParameter("servId");
	String proName=request.getParameter("proName");
	String GROUP_TYPE_ID="";
	String GROUP_TYPE_NAME="";
	String ProdId=request.getParameter("ProdId");
	String proTemp="";
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
  			}
	  	}	
	  	else
	  	{
		%>
		<script language="javascript" >
		//rdShowMessageDialog("查询产品实例化属性信息失败",0);
		alert("查询产品实例化属性信息失败!");

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
	    var packet = new AJAXPacket("GetProdAttr2.jsp","请稍后...");
			packet.data.add("servId" ,"<%=servId%>"); 	
			packet.data.add("flag" ,"0");	
			packet.data.add("ProdId" ,"<%=proTemp%>");
			packet.data.add("isNew" ,"<%=isNew%>");
			core.ajax.sendPacketHtml(packet,doGetAttrHtml);
			packet =null;
  })
function doGetAttrHtml(data)
{
	$("#attrlist").html(data);
	$("#attrlist :input").not(":button").each(chkDyAttribute);
	$("#attrlist :input").not(":button").keyup(function stopSpe(){
					var b=this.value;
					if(/[^0-9a-zA-Z\u4E00-\u9FA5]/.test(b)) this.value=this.value.replace(/[^0-9a-zA-Z\u4E00-\u9FA5]/g,'');
			});
	/*zhangyan add 国际漫游流量提醒*/

	if (typeof (document.form1.s_60002.value)=="undefined"||document.form1.s_60002.value=="")
	{
		document.form1.s_60002.value="5";
	}
	
}  
</script>	
<html xmlns="http://www.w3.org/1999/xhtml">
	<title>产品信息设置</title>
	<body>
		<form name="form1">
		<%@ include file="/npage/include/header_pop.jsp" %>
		<div class="title">
	<div id="title_zi">产品基本信息</div>
</div>
	<table cellspacing=0>
			<tr>
			<td class='blue' nowrap>产品标识</td>
			<td><%=proTemp%></td>
			<td class='blue' nowrap>产品名称</td>
			<td><%=proName%></td></tr>
		</table>
		</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">附加产品属性</div>
</div>
		<div id="attrlist"></div>

	<div id="footer">
		<input type="button"  class="b_foot" value="确定" onclick="fn()"  />
		<input type="button"  class="b_foot" value="关闭" onclick="shut()"  />
	</div>
	<%@ include file="/npage/include/footer_pop.jsp" %>
	</form>	
	</body>	
</html>	
<script language="javascript">
	function fn()
	{
		//if(!checksubmit(document.form1))return false;
			var attrCode = [];				//群组属性ID
  		var attrValue = [];		//群组属性value
<%
			if(isNew.equals("1"))
			{
%>
  				$("#attrlist :input").each(function(){
							attrCode.push(this.name.substring(2));
							if(this.value==""||typeof(this.value)=="undefined"||this.value==null)
							{
								
								if (attrCode=="60002")
								{
									attrValue.push("5");
								}
								else
								{
									attrValue.push("M^");	
								}
							}else
							{
								attrValue.push(this.value);
							}	
					});
					for(var i=0;i<attrCode.length;i++)
					{
						tempAttr=tempAttr+attrCode[i]+"~"+attrValue[i]+",";
					}
<%					
			}else
			{

					for(int i=0;i<attrVal.length;i++)
					{
							String[] attTmp=attrVal[i].split("~");
							String attrid=attTmp[0];
							String attrval=attTmp[1];
							
							if(attrval.equals("M^"))
							{
								attrval="";
							}
%>
							$("#attrlist :input").each(function(){					
							  if(this.name.substring(2)=="<%=attrid%>"&&this.value!="<%=attrval%>")
							  {
									tempAttr=tempAttr+"<%=attrid%>"+"~"+this.value+",";
								}	
							});
<%							
					}
			}	
%>				
			if (tempAttr=="60002~,")
			{
				tempAttr="60002~5,";
			}
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