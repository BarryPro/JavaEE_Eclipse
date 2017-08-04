<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String  custOrderId =  request.getParameter("custOrderId");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	
	System.out.println("---------------------------custOrderId----------------------------"+custOrderId);
%>
<wtc:utype name="sShowMainPlan" id="retVal" scope="end" routerKey="region" routerValue="<%=regionCode%>">
      <wtc:uparam value="<%=custOrderId%>" type="String"/>
</wtc:utype>
<%
	  String retCode=retVal.getValue(0);
	  String retMsg=retVal.getValue(1);
		
		if(retCode.equals("0"))
		{
			String phoneNo="";
			String funciton_name="";
			String num="";
			String flag="";
			String offerSrvId="";
			String offerId="";
			String funciton_code="";
			String servBusiId="";
			String status = "";//状态
			String orderArrayId = "";	//客户订单子项ID
			
		  int size = retVal.getSize("2.1.0");
		  for(int i=0;i<size;i++)
		  {
		  	status=retVal.getValue("2.1.0."+i+".0");
		  	System.out.println("status=="+status);
		  	phoneNo=retVal.getValue("2.1.0."+i+".9");
		  	funciton_name=retVal.getValue("2.1.0."+i+".2");
		  	num=retVal.getValue("2.1.0."+i+".7");
		  	funciton_code=retVal.getValue("2.1.0."+i+".1");
		  	if(funciton_code.equals("q001")||funciton_code.equals("q002"))
		  	{
		  		flag="N";
		  	}else
		  	{
		  		flag="Y";
		  	}
		  	offerSrvId=retVal.getValue("2.1.0."+i+".4");
		  	offerId=retVal.getValue("2.1.0."+i+".5");
				servBusiId=retVal.getValue("2.1.0."+i+".11");
				orderArrayId=retVal.getValue("2.1.0."+i+".8");
					System.out.println("sCustArrOrderId=="+orderArrayId);
				%>
				var idNo="<%=offerSrvId%>";
				var offerId ="<%=offerId%>";
				var opcode="<%=funciton_code%>";
				var servBusiId = "<%=servBusiId%>";
				var phoneNo = "<%=phoneNo%>";
				var num = "<%=num%>";
				var functionName = "<%=funciton_name%>";
				var orderArrayId="<%=orderArrayId%>";
				
				var tabID = "shoppingCarList";
				var tabRowNum ="<%=i+1%>";
				var offerInfoCode = "";
				var offerInfoValue = "";
				var dealNum = "<input type='text' style='border:1px solid #FFF' name=test onKeyUp=chkInt(this) onafterpaste=chkInt(this) readonly value='"+num+"'  size='3'>";
				var delBut="<span style='display:none'>Y|"+idNo+"|"+offerId+"|"+opcode+"|"+servBusiId+"|"+offerInfoCode+"|"+offerInfoValue+"</span>";
				
				<%
				if(status.equals("10")){
				%>
				   delBut=delBut+"<input  type='button' value='删除' class='b_text'  onclick='delTr()'  onmousedown='delTrOver()'><input type='hidden' value='"+orderArrayId+"'>";
				<%
			    }else if(status.equals("13")){
				%>
				    rdShowMessageDialog("正在服务开通中，如果长时间不能开通请提供订单号给系统管理员处理！");	
				    $("#nextBtn")[0].disabled = true;
				<%}else{
				%>
				    delBut=delBut+"<input  type='button' value='删除' class='b_text' disabled id=''>";
				<%}%>
				var arrTdCon=new Array(phoneNo,functionName,dealNum,delBut);
				addTr(tabID,tabRowNum,arrTdCon,"0|1");
			<%
		  }
	  }else
	  {
	  	
	  }
%>