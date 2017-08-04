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
 String proSvcId="";
 String	addrId="";
 String statusRunCode="";
 String branchNo ="";
 String[] idNos=null;
 int choiceNo = 0;
%>
<script type="text/javascript"> 
var chbArr =document.getElementsByName("chbUser");


function selAll()
{
//if(document.all.allSelBtn.value=="全选")
if(document.all.allSelBtn.checked==true)
{		
	for(i=0;i<chbArr.length;i++)
	{
		chbArr[i].checked=true;	
	}
	//document.all.allSelBtn.value="取消";
}else
	{
	for(i=0;i<chbArr.length;i++)
	{
		chbArr[i].checked=false;	
	}
	//document.all.allSelBtn.value="全选";		
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
			if (i!=<%=choiceNo%>){
				document.getElementById("idNo" + i).style.display="none";
			}
		}
		document.getElementById("showAllDiv").innerText="显示全部 >>";
	}
}
</script>
	<div class="list">
	<table cellspacing="0" id="customerInfo">
							<tr>
								<!--th style='text-align:center'><input type="button" class="b_text" name="allSelBtn" value="全选" onclick=selAll()></th-->		
								<th style='text-align:center'><input type="checkbox" name="allSelBtn" value="" onclick=selAll()></th>		
								<th style='text-align:center'>序号</th>
								<th style='text-align:center'>业务号码</th>					
								<th style='text-align:center'>主产品名称</th>
								<th style='text-align:center'>基本销售品名称</th>
								<th style='text-align:center'>品牌名称</th>
								<th style='text-align:center'>装机地址</th>
							</tr>

<!--取客户产品信息-->
<wtc:utype name="sCustOffer" id="retConsOffer" scope="end" routerKey="region" routerValue="<%=regionCode%>">
     <wtc:uparam value="<%=gCustId%>" type="LONG"/>
     <wtc:uparam value="0" type="STRING"/>
</wtc:utype>		
	<%
							String retConsOfferRetCode =retConsOffer.getValue(0);
							if(retConsOfferRetCode.equals("0"))
							{
								int xsize = retConsOffer.getSize("2");
			          idNos=new String[xsize];
								
								for(int i=0; i<xsize ;i++)		
			          {
			          idNo=retConsOffer.getValue("2."+i+".0");
			          idNos[i]=idNo;
	%>
				<!--用户基本信息-->
						<wtc:utype name="sQUserBaseInfo" id="retCustBaseInfo" scope="end"  routerKey="region" routerValue="<%=regionCode%>">
						     <wtc:uparam value="<%=idNo%>" type="LONG"/>
						     <wtc:uparam value="<%=regionCode%>" type="STRING"/>
						</wtc:utype>		
				<%
						   	 String bd0016_retCode =retCustBaseInfo.getValue(0);
						     String bd0016_retMsg  =retCustBaseInfo.getValue(1); 
						     
						   if(bd0016_retCode.equals("0"))
						   {
						   	proSvcId=retCustBaseInfo.getValue("2.9");
								addrId=retCustBaseInfo.getValue("2.8");
								statusRunCode=retCustBaseInfo.getValue("2.12");
								branchNo=retCustBaseInfo.getValue("2.11");
								if(idNo.equals(idNo_old)){
									choiceNo = i;
				%>
								<tr id="idNo<%=i%>">
								<td style='text-align:center'><input type="checkbox"  checked id="chbUser<%=i%>" name="chbUser" value="<%=idNo%>~<%=proSvcId%>~<%=addrId%>~<%=retConsOffer.getValue("2."+i+".21")%>")~statusRunCode~branchNo;></td>
				<%
							}else{
				%>				
								<tr id="idNo<%=i%>" style="display:none">
								<td style='text-align:center'><input type="checkbox" id="chbUser<%=i%>" name="chbUser" value="<%=idNo%>~<%=proSvcId%>~<%=addrId%>~<%=retConsOffer.getValue("2."+i+".21")%>")~statusRunCode~branchNo;></td>
				<%}%>
									<td style='text-align:center'><%=i+1%></td>
									<td style='text-align:center'><%=retConsOffer.getValue("2."+i+".21")%></td>
									<td style='text-align:center'><%=retConsOffer.getValue("2."+i+".2")%></td>
									<td style='text-align:center'><%=retConsOffer.getValue("2."+i+".8")%></td>
									<td style='text-align:center'><%=retConsOffer.getValue("2."+i+".14")%></td>
									<td style='text-align:center'><%=retCustBaseInfo.getValue("2.5")%></td>
								</tr>
							<%}else{%>
									<tr id="idNo<%=i%>" style="display:none">
									<td style='text-align:center'><input type="checkbox" id="chbUser<%=i%>" name="chbUser" value="<%=idNo%>~~~<%=retConsOffer.getValue("2."+i+".21")%>")~~;></td>
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
		</table>		
		<a href="#" id="allShow"onClick="showAll()"><div id="showAllDiv" >显示全部 >></div></a>			
  </div>