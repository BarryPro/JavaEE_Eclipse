<%
/*
 * 功能: 省内携号
 * 版本: 1.0
 * 日期: 2012/3/9 14:19:13
 * 作者: zhangyan
 * 版权: si-tech
 * update:
*/
	//-------------------------查询用户当前订购关系--------------------
  StringBuffer sb = new StringBuffer(80);
  sb.append("<table id='userHadOfferTab'>"
  	+"<tr><td class='blue'>销售品ID</td>"
  	+"<td class='blue'>销售品名称</td>"
  	+"<td class='blue'>销售品分类</td>"
  	+"<td class='blue'>类型</td>"
  	+"<td class='blue'>状态</td>"
  	+"<td class='blue'>生效时间</td>"
  	+"<td class='blue'>失效时间</td>"
  	+"<td class='blue'>操作</td></tr>");
%>

<script language = "javascript">
		
/*zhangyan*/
function btcGetMidPrompt(classCode , classValue , id111 , smCode)
{
	var packet = new AJAXPacket("/npage/include/btcGetMidPrompt.jsp","请稍后...");
	packet.data.add("opCode" ,"<%=opCode%>");
	packet.data.add("classCode" ,classCode);
	packet.data.add("classValue" ,classValue);
	packet.data.add("id" ,id111);
	packet.data.add("smCode" ,smCode);
	core.ajax.sendPacket(packet,doBtcGetMidPrompt,true);//异步
	packet =null;
	
}
/*zhangyan*/
function doBtcGetMidPrompt(packet)
{

	var retCode 		=packet.data.findValueByName("retCode"); 
	var retMsg 			=packet.data.findValueByName("retMsg"); 
	var strId 			=packet.data.findValueByName("strId"); 
	var id1s 			=packet.data.findValueByName("id1s"); 
	var promptContent	=packet.data.findValueByName("promptContent"); 
	var dispIds 			=( strId.substring(0,strId.length-1)).split("|");
	for ( var i=0;	i<dispIds.length; i	++ )
	{
		for ( var j=0; j<id1s.length; j++ )
		{
			if (dispIds[i].indexOf(id1s[j]) > 0)
			{
				document.getElementById(dispIds[i]).className = "promptBlue";
				$("#"+dispIds[i]).attr("title",promptContent[j]);
				$("#"+dispIds[i]).tooltip();	
			}
		}
	}
}
function showdesc(offid,offidInt)
{	
	var h=380;
	var w=480; 
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px;"
		+"dialogWidth:"+w+"px; dialogLeft:"+l+"px; "
		+"dialogTop:"+t+"px;toolbar:no; menubar:no; "
		+"scrollbars:no; scroll:no; resizable:no;location:no;status:no;help:no";

	var ret=window.showModalDialog("fE687ShowOfferDesc.jsp?offidInt="+offidInt
		+"&offid="+offid
		+"&msType=0&"
		+"id_no=<%=stPMid_no%>"
		+"&opCode=<%=opCode%>"
		+"&opName=<%=opName%>","",prop);
}

</script>
<wtc:utype name="sQryOfferInst" id="retVal" scope="end">
     <wtc:uparam value="<%=servId%>" type="LONG"/>
     <wtc:uparam value="<%=workNo%>" type="string"/>
     <wtc:uparam name="<%=opCode%>" type="string"/>	
     <wtc:uparam value="0" type="LONG"/>
     <wtc:uparam value="0" type="LONG"/>			
</wtc:utype>

<%
String retrunCode =retVal.getValue(0);
String returnMsg  =retVal.getValue(1).replaceAll("\\n"," ");
String curOfferId	="";
String curOfferNm	="";
StringBuffer logBuffer = new StringBuffer(80);
WtcUtil.recursivePrint(retVal,1,"2",logBuffer);
	
if(retrunCode.equals("0"))
{
	int lineNum=retVal.getSize(2);
	int  n=0; 
	String midOfferIds="";
	String midOfferIdDivIds="";
	for(int i=0;i<lineNum;i++)
	{
		String  actionStr = "";
		String offerInstId = retVal.getUtype("2."+i).getValue(0);
		String offerId = retVal.getUtype("2."+i).getValue(1);
		String offerName = retVal.getUtype("2."+i).getValue(2);
		String offerTypeId = retVal.getUtype("2."+i).getValue(3);
		String offerTypeName = retVal.getUtype("2."+i).getValue(4);
		String effTime = retVal.getUtype("2."+i).getValue(5);
		String expTime = retVal.getUtype("2."+i).getValue(6);
		String stateName = retVal.getUtype("2."+i).getValue(8);
		String action = retVal.getUtype("2."+i).getValue(10);
		String attrTypeName = retVal.getUtype("2."+i).getValue(14);
		String paramVal = offerId+"|"+offerInstId+"|"+offerName;
		
		midOfferIds+=offerId+"|";//zhangyan
		midOfferIdDivIds+="promot"+offerId+"|";//zhangyan
		
		sb.append("<tr><td><input type='text' name='oOfferId' class='InputGrey'"
			+" readOnly id='oOfferId' value="+offerId+"></td>");
		sb.append("<td  id='promot"+offerId+"' style='' >"
			+"<input type='text' name='oOfferName' class='InputGrey'"
			+" readOnly id='oOfferName' value="+offerName+"></td>");
		sb.append("<td><input type='text' name='oOfferTypeName' class='InputGrey'"
			+" readOnly id='oOfferTypeName' value="+offerTypeName+"></td>");			
		sb.append("<td><input type='text' name='oAttrTypeName' class='InputGrey'"
			+" readOnly id='oAttrTypeName' value="+attrTypeName+"></td>");			
		sb.append("<td><input type='text' name='oStateName' class='InputGrey'"
			+" readOnly id='oStateName' value="+stateName+"></td>");
		sb.append("<td><input type='text' name='oEffTime' class='InputGrey'"
			+" readOnly id='oEffTime' value="+effTime.substring(0,8)+"></td>");				
		sb.append("<td><input type='text' name='oExpTime' class='InputGrey'"
			+" readOnly id='oExpTime' value="+expTime.substring(0,8)+"></td>");			
		sb.append("<td>"+actionStr
			+"<input type='button' value='详情' class='b_text' name='del"+offerId
			+"' onClick='showdesc("+offerId+","+offerInstId+")'></td></tr>");
		
		if(offerTypeId.equals("10")){		//基本销售品
			curOfferId=offerId;
			curOfferNm=offerName;
			sb.append("<script>thisMonthOfferIdArr["+n+"] = "+offerId+"; </script>");	
		  n++;
		}
	}
	sb.append("<script>btcGetMidPrompt('10442','"+midOfferIds+"','"
		+midOfferIdDivIds+"');</script>");	//注意事项
	//zhangyan add 
		sb.append("<script>thisMonthOfferId = thisMonthOfferIdArr[0];</script>");	//取当月销售品ID
}

	sb.append("</table>");
%>
<input type="hidden" name="curOfferId" id="curOfferId" value="<%=curOfferId%>">
<input type="hidden" name="curOfferNm" id="curOfferNm" value="<%=curOfferNm%>">
<%=sb%>
