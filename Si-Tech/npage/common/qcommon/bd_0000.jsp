<%
   /*
   * 功能: 用户产品实例列表 
　 * 版本: v1.0
　 * 日期: 2009-03-06 14:37
　 * 作者: kangjia
　 * 版权: sitech
   * 修改历史
   * 修改日期      		修改人      修改目的
 　*/
%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%
 String idNo_old=request.getParameter("offerSrvId");
 String idNo="";
 String flag="";
 String proSvcId="";
 String	addrId="";
 String statusRunCode="";
 String branchNo ="";
 String printAddrInfo="";
 String[] idNos=null;
 int choiceNo = 0;
%>
<script type="text/javascript"> 
var chbArr =document.getElementsByName("chbUser");
var choiceNo;

function selAll()
{
//if(document.all.allSelBtn.value=="全选")
if(document.all.allSelBtn.checked==true)
{		
	for(i=0;i<chbArr.length;i++)
	{
		if(chbArr[i].disabled==false)
		{
		 chbArr[i].checked=true;
		 selrow0000(chbArr[i]);	
		}
	}
	//document.all.allSelBtn.value="取消";
}else
	{
	for(i=0;i<chbArr.length;i++)
	{
		chbArr[i].checked=false;	
		selrow0000(chbArr[i]);	
	}
	//document.all.allSelBtn.value="全选";		
	}		
}
	function selrow0000(obj){
		if("<%=opCode%>" == "q010")	{
			var srcObj = obj;
			var objValue = srcObj.value;
			var selPhoneNo = objValue.split("~")[3];
			if(srcObj.checked == false){
				 g("tbl"+selPhoneNo.trim()).outerHTML = "";
				 return false;
			}
			getPreFeeHtml(selPhoneNo);	
		} 
	}
function showAll(){
		var s = document.getElementById("showAllDiv").innerHTML;
	if(s.indexOf("显示全部") >= 0){
		for(i=0;i<chbArr.length;i++)
		{
			document.getElementById("idNo" + i).style.display="";
		}
		document.getElementById("showAllDiv").innerText="取消全显 >>";
	}else if (s.indexOf("取消全显") >= 0) {
		for(i=0;i<chbArr.length;i++)
		{
			if (i!= choiceNo){
				document.getElementById("idNo" + i).style.display="none";
			}
			else
			{
			  document.getElementById("idNo" + i).style.display="";
			}
		}
		document.getElementById("showAllDiv").innerText="显示全部 >>";
	}
}
</script>
	<div class="list">
	<table cellspacing="0" id="customerInfo">
	<tr>	
		<th style='text-align:center'>
			<input type="checkbox" name="allSelBtn" value="" onclick="selAll()">
		</th>		
		<th style='text-align:center'>序号</th>
		<th style='text-align:center'>业务号码</th>					
		<th style='text-align:center'>主产品名称</th>
		<th style='text-align:center'>基本销售品名称</th>
		<th style='text-align:center'>品牌名称</th>
		<th style='text-align:center'>装机地址</th>
	</tr>
 

<%

System.out.println("---------------------------regionCode---------------------------"+regionCode);
System.out.println("---------------------------opCode---------------------------"+opCode);
System.out.println("---------------------------gCustId---------------------------"+gCustId);

%>
<wtc:utype name="sQryOffer" id="retConsOffer" scope="end" routerKey="region" routerValue="<%=regionCode%>">
     <wtc:uparam value="<%=regionCode%>" type="STRING"/>
     <wtc:uparam value="<%=opCode%>" type="STRING"/>
     <wtc:uparam value="1" type="STRING"/>
     <wtc:uparam value="<%=gCustId%>" type="LONG"/>
     <wtc:uparam value="1" type="INT"/>
</wtc:utype>	

	<%
				String retConsOfferRetCode =retConsOffer.getValue(0);
				StringBuffer logBuffer_wanglj = new StringBuffer(80);
				WtcUtil.recursivePrint(retConsOffer,1,"2",logBuffer_wanglj);		
				System.out.println(logBuffer_wanglj.toString());
			   if(retConsOfferRetCode.equals("0"))
				{
				int xsize = retConsOffer.getSize("2");
			    idNos=new String[xsize];
								
				for(int i=0; i<xsize ;i++)		
			          {
			          idNo=retConsOffer.getValue("2."+i+".0");
			          flag=retConsOffer.getValue("2."+i+".23");
			          idNos[i]=idNo;
	%>
				<!--用户基本信息-->
						<wtc:utype name="sQUserBaseInfo" id="retCustBaseInfo" scope="end"  routerKey="region" routerValue="<%=regionCode%>">
						     <wtc:uparam value="<%=idNo%>" type="LONG"/>
						     <wtc:uparam value="<%=regionCode%>" type="STRING"/>
						</wtc:utype>		
				<%
						   	 String bd0016_retCode = retCustBaseInfo.getValue(0);
						     String bd0016_retMsg  = retCustBaseInfo.getValue(1); 
						     
						   if(bd0016_retCode.equals("0"))
						   {
						   	proSvcId = retCustBaseInfo.getValue("2.9");
								addrId = retCustBaseInfo.getValue("2.8");
								statusRunCode = retCustBaseInfo.getValue("2.12");
								branchNo = retCustBaseInfo.getValue("2.11");
								printAddrInfo = retCustBaseInfo.getValue("2.5");
								if(idNo.equals(idNo_old))
								{
									choiceNo = i;
									out.println("<script>choiceNo = "+choiceNo+"; </script>");
				%>
								<tr id="idNo<%=i%>">
								<td style='text-align:center'><input onclick="selrow0000(this)" type="checkbox" <%if("N".equals(flag)) out.println("disabled"); else out.println("checked");%> id="chbUser<%=i%>" name="chbUser" value="<%=idNo%>~<%=proSvcId%>~<%=addrId%>~<%=retConsOffer.getValue("2."+i+".21")%>~<%=retConsOffer.getValue("2."+i+".24")%>")~statusRunCode~branchNo;></td>
				<%
							     }
							    else
							    {
				%>				
								<tr id="idNo<%=i%>" style="display:none">
								<td style='text-align:center'><input type="checkbox" onclick="selrow0000(this)" <%if("N".equals(flag)) out.println("disabled");%> id="chbUser<%=i%>" name="chbUser" value="<%=idNo%>~<%=proSvcId%>~<%=addrId%>~<%=retConsOffer.getValue("2."+i+".21")%>~<%=retConsOffer.getValue("2."+i+".24")%>")~statusRunCode~branchNo;></td>
				<%}%>
									<td style='text-align:center'><%=i+1%></td>
									<td style='text-align:center'><%=retConsOffer.getValue("2."+i+".21")%></td>
									<td style='text-align:center'><%=retConsOffer.getValue("2."+i+".2")%></td>
									<td style='text-align:center'><%=retConsOffer.getValue("2."+i+".8")%></td>
									<td style='text-align:center'><%=retConsOffer.getValue("2."+i+".14")%></td>
									<td style='text-align:center'><%=retCustBaseInfo.getValue("2.5")%></td>
								</tr>
							   <%
							   System.out.println("基本销售品名称="+retConsOffer.getValue("2."+i+".8"));
							   }
						  else
							  {
							  System.out.println("基本销售品名称error="+retConsOffer.getValue("2."+i+".8"));
							  %>
									<tr id="idNo<%=i%>" style="display:none">
									<td style='text-align:center'><input type="checkbox" onclick="selrow0000(this)" <%if("N".equals(flag)) out.println("disabled");%> id="chbUser<%=i%>" name="chbUser" value="<%=idNo%>~~~<%=retConsOffer.getValue("2."+i+".21")%>~<%=retConsOffer.getValue("2."+i+".24")%>")~~;></td>
									<td style='text-align:center'><%=i+1%></td>
									<td style='text-align:center'><%=retConsOffer.getValue("2."+i+".21")%></td>
									<td style='text-align:center'><%=retConsOffer.getValue("2."+i+".2")%></td>
									<td style='text-align:center'><%=retConsOffer.getValue("2."+i+".8")%></td>
									<td style='text-align:center'><%=retConsOffer.getValue("2."+i+".14")%></td>
									<td style='text-align:center'></td>			
								</tr>			
						<%	
							}
								}
							}
						%>	
						<tr><td colspan=7 class='orange'><a href="#" id="allShow"onClick="showAll()"><div id="showAllDiv" >显示全部 >></div></a></td></tr>
		</table>		
		<!-- <a href="#" id="allShow"onClick="showAll()"><div id="showAllDiv" >显示全部 >></div></a> -->
  </div>