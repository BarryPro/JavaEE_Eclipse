<%
   /*
   * ����: �û���Ʒʵ���б� 
�� * �汾: v1.0
�� * ����: 2009-03-06 14:37
�� * ����: kangjia
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      		�޸���      �޸�Ŀ��
 ��*/
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
//if(document.all.allSelBtn.value=="ȫѡ")
if(document.all.allSelBtn.checked==true)
{		
	for(i=0;i<chbArr.length;i++)
	{
		chbArr[i].checked=true;	
	}
	//document.all.allSelBtn.value="ȡ��";
}else
	{
	for(i=0;i<chbArr.length;i++)
	{
		chbArr[i].checked=false;	
	}
	//document.all.allSelBtn.value="ȫѡ";		
	}		
}

function showAll(){
		var s = document.getElementById("showAllDiv").innerHTML;
	if(s.indexOf("��ʾȫ��") >= 0){
		for(i=0;i<chbArr.length;i++)
		{
			document.getElementById("idNo" + i).style.display="";
		}
		document.getElementById("showAllDiv").innerText="ȡ��ȫ�� >>";
	}else if (s.indexOf("ȡ��ȫ��") >= 0) {
		for(i=0;i<chbArr.length;i++)
		{
			if (i!=<%=choiceNo%>){
				document.getElementById("idNo" + i).style.display="none";
			}
		}
		document.getElementById("showAllDiv").innerText="��ʾȫ�� >>";
	}
}
</script>
	<div class="list">
	<table cellspacing="0" id="customerInfo">
							<tr>
								<!--th style='text-align:center'><input type="button" class="b_text" name="allSelBtn" value="ȫѡ" onclick=selAll()></th-->		
								<th style='text-align:center'><input type="checkbox" name="allSelBtn" value="" onclick=selAll()></th>		
								<th style='text-align:center'>���</th>
								<th style='text-align:center'>ҵ�����</th>					
								<th style='text-align:center'>����Ʒ����</th>
								<th style='text-align:center'>��������Ʒ����</th>
								<th style='text-align:center'>Ʒ������</th>
								<th style='text-align:center'>װ����ַ</th>
							</tr>

<!--ȡ�ͻ���Ʒ��Ϣ-->
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
				<!--�û�������Ϣ-->
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
		<a href="#" id="allShow"onClick="showAll()"><div id="showAllDiv" >��ʾȫ�� >></div></a>			
  </div>