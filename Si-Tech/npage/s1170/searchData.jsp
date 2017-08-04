<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%
long l1 = new java.util.Date().getTime();
System.out.println("---mylog--searchData.jsp页面加载开始时间-------------------------------"+new java.util.Date());	
 /**
 *根据查询条件查询出所属客户订单的所有信息。
 * #inputparam
 * #utype
 * -paramType       string       传入的参数类型，服务号码 0 ,客户订单ID 1 ,客户订单子项ID  2  ,服务定单ID  3  ,或者冲正流水(服务定单流水)  4.
 * -paramValue      string       传入的参数  
 * -loginNO         string       操作工号 
 * -queryDate       string       查询的年月  只有当用服务号码和冲正流水时使用
 * #outputparam
 * #utype
 * -utype     # 2 客户信息
 * --custOrderId    string       客户订单ID
 * --custName       string       客户名称
 * --custIccid      string       客户证件号码
 
 * -utype    # 3 子项信息集
 * --utype   #子项信息1*
 * ---custArrayId    string       客户订单子项ID
 * ---custArrayName  string       客户订单子项名称
 * ---utype   #服务定单信息集
 * ----utype   #服务定单信息1
 * -----servOrderId    string       服务订单子项ID
 * -----actionName  string          动作名称
 * -----service_no  string          服务号码
 */
	String workNo          = (String) session.getAttribute("workNo"); //登陆工号
	String password = (String) session.getAttribute("password");
	String idType          = request.getParameter("idType");          //查询条件
	String condittionValue = request.getParameter("servno"); //条件值
	String modeFlag        = request.getParameter("modeFlag"); //条件值
	String selFlag         = request.getParameter("selFlag"); //条件值
	String searchDate      = request.getParameter("searchDate") == null?"":(String)request.getParameter("searchDate");  //查询日期
	String opCodeLimit     = request.getParameter("opCodeLimit");
	String saleSeq         = request.getParameter("saleSeq");
	String desabLimiStr    = "";
	if(!opCodeLimit.equals("g795")){
		desabLimiStr = "disabled";
	}
	
	//客户信息
	String custOrderId = "";
	String custName = "";
	String custIccid = "";
	
	/*
	UType sendInfo  = new UType();  
	sendInfo.setUe("STRING", idType);
	sendInfo.setUe("STRING", condittionValue);
	sendInfo.setUe("STRING", workNo);
	sendInfo.setUe("STRING", searchDate);
	*/
	long l2 = new java.util.Date().getTime();
	System.out.println("---mylog--searchData.jsp页面加载到调用服务sReveresQuery前的毫秒数------"+(l2-l1));	
	
%>
<wtc:utype name="sReveresQuery" id="retVal" scope="end" >
          <wtc:uparam value="<%= idType %>" type="String"/>      
          <wtc:uparam value="<%= condittionValue %>" type="String"/>      
          <wtc:uparam value="<%= workNo %>" type="String"/>      
          <wtc:uparam value="<%= searchDate %>" type="String"/>      
          <wtc:uparam value="<%= opCodeLimit %>" type="String"/>      	
          <wtc:uparam value="<%= saleSeq %>" type="long"/>  
          <wtc:uparam value="<%= password %>" type="String"/> 	
 </wtc:utype>
<%
long l3 = new java.util.Date().getTime();
System.out.println("------------------mylog--------调用服务sReveresQuery前后的毫秒数-------"+(l3-l2));	

	String retCode=retVal.getValue(0);
	String retMsg=retVal.getValue(1);
	System.out.println("retCode==mylog=======sReveresQuery================"+retCode);
	System.out.println("retMsg===mylog=======sReveresQuery================"+retMsg);
if("0".equals(retCode.trim())){
	
		//客户信息
		//custOrderId = retVal.getValue("2.0.0");
		//custName = retVal.getValue("2.0.1");
		//custIccid = retVal.getValue("2.0.2");
		int custArrayOrderSize = retVal.getSize("2");//子项信息个数；
		System.out.println("custArrayOrderSize=========mylog================"+custArrayOrderSize);
		
		StringBuffer logBuffer = new StringBuffer(80);
		WtcUtil.recursivePrint(retVal,1,"2",logBuffer);
		System.out.println("logBuffer.toString()"+logBuffer.toString());

%>

<div id="Operation_Table">
 
 
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">客户订单列表</div>
</div>
<table id="dataTable" cellspacing=0>
	<tr>
		<th>选择</th>
		<th>客户订单子项ID</th>
		<th>操作名称</th>
		<th style="display:none">服务定单</th>
		<th style="display:none">操作名称</th>
		<th>服务号码</th>
		<th>客户订单ID</th>
		<th>客户名称</th>
		<th  style="display:none">客户证件号码</th>
		
		<th>操作时间</th>
		<th>操作工号</th>
		<th>操作流水</th>
		
		
		
		
		<!--th>操作</th-->
	</tr>
<%
  String tempFlag = "";
	String custOrrayArrayId_new = "";
             String opCodeV1 ="";
	           String opCodeV2 = "";
	           String loginAccept = "";
	           String opNameV1 = "";
	           String opNameV2 = "";
	           //----------新增出参 hejwa add 2013年5月24日10:45:06------------
	           
	           int    idnoSize = 0;
	           
	          /*** tianyang add for pos start ***/
	          String payType = "";
	          String Response_time = "";
						String TerminalId = "";
						String Rrn = "";
						String Request_time = "";
						String returnMoney = "";
						String instNumStr  = "";
						/*** tianyang add for pos end ***/					
	           
	for(int i=0;i<custArrayOrderSize;i++){//客户订单个数
	 
	 // hejwa add 新业务权益赠送需求
	 String saleHitFlag = "";
	 
	 if(retVal.getSize("2."+i+".1")>0){
	 		if(retVal.getSize("2."+i+".1.0")>4){
			 		saleHitFlag = retVal.getValue("2."+i+".1.0.4");
	 		}
	 }
	 
	 custOrrayArrayId_new = retVal.getValue("2."+i+".1.0.0");
	 
	 opCodeV1 = retVal.getValue("2."+i+".1.0.2.0.0.3");
	 opNameV1 = retVal.getValue("2."+i+".1.0.2.0.0.4");
	 opCodeV2 = retVal.getValue("2."+i+".1.0.2.0.0.5");
	 
	 //----------新增出参 hejwa add 2013年5月24日10:45:06------------
	 String idnoStrs = "";
	 idnoSize = retVal.getSize("2."+i+".1.0.3");
	 for(int j = 0; j<idnoSize ; j++){
		 	idnoStrs += retVal.getValue("2."+i+".1.0.3"+"."+j)+",";
	 }
	 
	 String jttfflag="0";  /*0：代表普通,1：代表集团统付购机款*/
	 
	 if(retVal.getSize("2."+i+".1")>0){
	 		if(retVal.getSize("2."+i+".1.0")>5){
			 		jttfflag = retVal.getValue("2."+i+".1.0.5");
	 		}
	 }
	 

	 System.out.println(i+"-----------mylog---------------opCodeV2--------------------"+opCodeV2);
	 System.out.println(i+"-----------mylog---------------modeFlag--------------------"+modeFlag);
	 System.out.println(i+"-----------mylog---------------selFlag---------------------"+selFlag);
	 
	 
	 
	if(selFlag.equals("0")){
	 if(opCodeV2!=null&&opCodeV2.equals(modeFlag)){
	 tempFlag = "1";
	 opNameV2 = retVal.getValue("2."+i+".1.0.2.0.0.6");
	 loginAccept = retVal.getValue("2."+i+".1.0.2.0.0.7");
	
	System.out.println("-----------mylog-----------opCodeV1------------------"+opCodeV1);
	System.out.println("-----------mylog-----------opNameV1------------------"+opNameV1);
	System.out.println("-----------mylog-----------opCodeV2------------------"+opCodeV2);
	System.out.println("-----------mylog-----------opNameV2------------------"+opNameV2);
	System.out.println("-----------mylog-----------loginAccept---------------"+loginAccept);
	
	
	
	/*** tianyang add for pos start ***/
	 payType       = retVal.getValue("2."+i+".1.0.2.0.0.10");
	 Response_time = retVal.getValue("2."+i+".1.0.2.0.0.11");
	 TerminalId    = retVal.getValue("2."+i+".1.0.2.0.0.12");
	 Rrn           = retVal.getValue("2."+i+".1.0.2.0.0.13");
	 Request_time  = retVal.getValue("2."+i+".1.0.2.0.0.14");
	 returnMoney   = retVal.getValue("2."+i+".1.0.2.0.0.15");
	 instNumStr    = retVal.getValue("2."+i+".1.0.2.0.0.16");
	 System.out.println("-----------mylog---------------payType-----------------"+payType);
	 System.out.println("-----------mylog---------------Response_time-----------"+Response_time);
	 System.out.println("-----------mylog---------------TerminalId--------------"+TerminalId);
	 System.out.println("-----------mylog---------------Rrn---------------------"+Rrn);
	 System.out.println("-----------mylog---------------Request_time------------"+Request_time);
	 System.out.println("----------mylog----------------returnMoney-------------"+returnMoney);
	 /*** tianyang add for pos end ***/
	
	
	
	
	
	String hiddenStr = retVal.getValue("2."+i+".1.0.0")+"|"+retVal.getValue("2."+i+".1.0.1")+"|"+retVal.getValue("2."+i+".1.0.2.0.0.0")+"|"+retVal.getValue("2."+i+".1.0.2.0.0.1")+"|"+retVal.getValue("2."+i+".1.0.2.0.0.2")+"|"+retVal.getValue("2."+i+".0.0")+"|"+retVal.getValue("2."+i+".0.1")+"|"+retVal.getValue("2."+i+".0.2");
%>
				<tr style="cursor:pointer">
					<td><input type="radio" id="custOrderIds" vRowFlag="<%=i%>" value="<%=custOrrayArrayId_new%>"   v_servOrderId="<%=retVal.getValue("2."+i+".1.0.0")%>" onclick="sBindQuery(this,'<%=i%>')" name="custOrderIds"  <%=desabLimiStr%> ></td>
					<td onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=retVal.getValue("2."+i+".1.0.0")%></td>
					<td onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=retVal.getValue("2."+i+".1.0.1")%></td>
					<td style="display:none"><%=retVal.getValue("2."+i+".1.0.2.0.0.0")%>
						
						<%System.out.println("11111111111====="+retVal.getValue("2."+i+".1.0.2.0.0.0"));%>
						
						<input id="servId_<%=i%>" name="servId_<%=i%>" value="<%=retVal.getValue("2."+i+".1.0.2.0.0.0")%>" >
						</td>
					<td style="display:none"><%=retVal.getValue("2."+i+".1.0.2.0.0.1")%></td>
					<td onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=retVal.getValue("2."+i+".1.0.2.0.0.2")%>
						<input type="hidden" id="phoneNoHv<%=i%>" name="phoneNoHv<%=i%>" value="<%=retVal.getValue("2."+i+".1.0.2.0.0.2")%>">
						</td>
					<td onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=retVal.getValue("2."+i+".0.0")%></td>
					<td onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=retVal.getValue("2."+i+".0.1")%></td>
					<td  style="display:none"><%=retVal.getValue("2."+i+".0.2")%></td>
					
					<td onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"> <%=retVal.getValue("2."+i+".1.0.2.0.0.8")%></td>
					<td onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"> <%=retVal.getValue("2."+i+".1.0.2.0.0.9")%></td>
					<td onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=loginAccept%> </td>
					
					<td style="display:none"><input name="custAdd<%=i%>" id="custAdd<%=i%>" value="<%=retVal.getValue("2."+i+".0.3")%>"></td>
				 
					<td style="display:none"><input name="hiddenStrv<%=i%>" id="hiddenStrv<%=i%>" value="<%=hiddenStr%>"></td>
					<td style="display:none"><input name="opCode1Hv<%=i%>" id="opCode1Hv<%=i%>" value="<%=opCodeV1%>"></td>
					<td style="display:none"><input name="opName1Hv<%=i%>" id="opName1Hv<%=i%>" value="<%=opNameV1%>"></td>
					<td style="display:none"><input name="opCode2Hv<%=i%>" id="opCode2Hv<%=i%>" value="<%=opCodeV2%>"></td>
					<td style="display:none"><input name="opName2Hv<%=i%>" id="opName2Hv<%=i%>" value="<%=opNameV2%>"></td>
					<td style="display:none"><input name="loginAcceptHv<%=i%>" id="loginAcceptHv<%=i%>" value="<%=loginAccept%>"></td>					
					<!-- tianyang add at 20100201 for POS缴费需求*****start*****-->
					<td style="display:none"><input name="payTypeHv<%=i%>"       id="payTypeHv<%=i%>"       value="<%=payType%>"></td>
					<td style="display:none"><input name="Response_timeHv<%=i%>" id="Response_timeHv<%=i%>" value="<%=Response_time%>"></td>
					<td style="display:none"><input name="TerminalIdHv<%=i%>"    id="TerminalIdHv<%=i%>"    value="<%=TerminalId%>"></td>
					<td style="display:none"><input name="RrnHv<%=i%>"           id="RrnHv<%=i%>"           value="<%=Rrn%>"></td>
					<td style="display:none"><input name="Request_timeHv<%=i%>"  id="Request_timeHv<%=i%>"  value="<%=Request_time%>"></td>
					<td style="display:none"><input name="returnMoneyHv<%=i%>"   id="returnMoneyHv<%=i%>"   value="<%=returnMoney%>"></td>
					<td style="display:none"><input name="instNumStrHv<%=i%>"    id="instNumStrHv<%=i%>"   value="<%=instNumStr%>"></td>
					
					<!-- tianyang add at 20100201 for POS缴费需求*****end*****-->
					
					<td style="display:none"><input name="idnoStrs<%=i%>"   id="idnoStrs<%=i%>"   value="<%=idnoStrs%>"></td>
					
<%
	String servIdArrStr = "";
	int servIdNum = retVal.getSize("2."+i+".1.0.2");
	for(int hj=0;hj<servIdNum;hj++){
		servIdArrStr += retVal.getValue("2."+i+".1.0.2."+hj+".0.0")+",";
	}
%>
			<td style="display:none"><input name="servIdArrStrHv<%=i%>"   id="servIdArrStrHv<%=i%>"   value="<%=servIdArrStr%>"></td>
			
			<!-- hejwa add **********-->
			<td style="display:none"><input name="saleHitFlag<%=i%>"   id="saleHitFlag<%=i%>"   value="<%=saleHitFlag%>"></td>
			
			<td style="display:none"><input name="jttfflag<%=i%>"   id="jttfflag<%=i%>"   value="<%=jttfflag%>"></td>
			
				</tr>
<%
}
}else{
		 tempFlag = "1";
	 opNameV2 = retVal.getValue("2."+i+".1.0.2.0.0.6");
	 loginAccept = retVal.getValue("2."+i+".1.0.2.0.0.7");
	
	System.out.println("----------------------opCodeV1------------------"+opCodeV1);
	System.out.println("----------------------opNameV1------------------"+opNameV1);
	System.out.println("----------------------opCodeV2------------------"+opCodeV2);
	System.out.println("----------------------opNameV2------------------"+opNameV2);
	System.out.println("----------------------loginAccept---------------"+loginAccept);
	String hiddenStr = retVal.getValue("2."+i+".1.0.0")+"|"+retVal.getValue("2."+i+".1.0.1")+"|"+retVal.getValue("2."+i+".1.0.2.0.0.0")+"|"+retVal.getValue("2."+i+".1.0.2.0.0.1")+"|"+retVal.getValue("2."+i+".1.0.2.0.0.2")+"|"+retVal.getValue("2."+i+".0.0")+"|"+retVal.getValue("2."+i+".0.1")+"|"+retVal.getValue("2."+i+".0.2");
%>
				<tr style="cursor:pointer" >
					<td><input type="radio" id="custOrderIds" vRowFlag="<%=i%>" value="<%=custOrrayArrayId_new%>"   v_servOrderId="<%=retVal.getValue("2."+i+".1.0.0")%>" onclick="sBindQuery(this,'<%=i%>')" name="custOrderIds"  <%=desabLimiStr%>  ></td>
					<td  onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=retVal.getValue("2."+i+".1.0.0")%></td>
					<td  onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=retVal.getValue("2."+i+".1.0.1")%></td>
					<td  onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=retVal.getValue("2."+i+".1.0.2.0.0.0")%>
						
						<%System.out.println("11111111111====="+retVal.getValue("2."+i+".1.0.2.0.0.0"));%>
						
						<input id="servId_<%=i%>" name="servId_<%=i%>" value="<%=retVal.getValue("2."+i+".1.0.2.0.0.0")%>" >
						</td>
					<td  onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=retVal.getValue("2."+i+".1.0.2.0.0.1")%></td>
					<td  onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=retVal.getValue("2."+i+".1.0.2.0.0.2")%>
						<input type="hidden" id="phoneNoHv<%=i%>" name="phoneNoHv<%=i%>" value="<%=retVal.getValue("2."+i+".1.0.2.0.0.2")%>">
						</td>
					<td  onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=retVal.getValue("2."+i+".0.0")%></td>
					<td  onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=retVal.getValue("2."+i+".0.1")%></td>
					<td  onclick="showBaseInfo('<%=hiddenStr%>','<%=opCodeV1%>','<%=opCodeV2%>','<%=loginAccept%>')"><%=retVal.getValue("2."+i+".0.2")%></td>
					
					<td style="display:none"><input name="custAdd<%=i%>" id="custAdd<%=i%>" value="<%=retVal.getValue("2."+i+".0.3")%>"></td>
					<%
						
						
					%>
					<td style="display:none"><input name="hiddenStrv<%=i%>" id="hiddenStrv<%=i%>" value="<%=hiddenStr%>"></td>
					<td style="display:none"><input name="opCode1Hv<%=i%>" id="opCode1Hv<%=i%>" value="<%=opCodeV1%>"></td>
					<td style="display:none"><input name="opName1Hv<%=i%>" id="opName1Hv<%=i%>" value="<%=opNameV1%>"></td>
					<td style="display:none"><input name="opCode2Hv<%=i%>" id="opCode2Hv<%=i%>" value="<%=opCodeV2%>"></td>
					<td style="display:none"><input name="opName2Hv<%=i%>" id="opName2Hv<%=i%>" value="<%=opNameV2%>"></td>
					<td style="display:none"><input name="loginAcceptHv<%=i%>" id="loginAcceptHv<%=i%>" value="<%=loginAccept%>"></td>
					<!-- tianyang add at 20100201 for POS缴费需求*****start*****-->
					<td style="display:none"><input name="payTypeHv<%=i%>"       id="payTypeHv<%=i%>"       value="<%=payType%>"></td>
					<td style="display:none"><input name="Response_timeHv<%=i%>" id="Response_timeHv<%=i%>" value="<%=Response_time%>"></td>
					<td style="display:none"><input name="TerminalIdHv<%=i%>"    id="TerminalIdHv<%=i%>"    value="<%=TerminalId%>"></td>
					<td style="display:none"><input name="RrnHv<%=i%>"           id="RrnHv<%=i%>"           value="<%=Rrn%>"></td>
					<td style="display:none"><input name="Request_timeHv<%=i%>"  id="Request_timeHv<%=i%>"  value="<%=Request_time%>"></td>
					<td style="display:none"><input name="returnMoneyHv<%=i%>"   id="returnMoneyHv<%=i%>"   value="<%=returnMoney%>"></td>
					<!-- tianyang add at 20100201 for POS缴费需求*****end*****-->
					
					<td style="display:none"><input name="idnoStrs<%=i%>"   id="idnoStrs<%=i%>"   value="<%=idnoStrs%>"></td>
<%
	String servIdArrStr = "";
	int servIdNum = retVal.getSize("2."+i+".1.0.2");
	for(int hj=0;hj<servIdNum;hj++){
		servIdArrStr += retVal.getValue("2."+i+".1.0.2."+hj+".0.0")+",";
	}
%>
			<td style="display:none"><input name="servIdArrStrHv<%=i%>"   id="servIdArrStrHv<%=i%>"   value="<%=servIdArrStr%>"></td>					
						<!-- hejwa add **********-->
			<td style="display:none"><input name="saleHitFlag<%=i%>"   id="saleHitFlag<%=i%>"   value="<%=saleHitFlag%>"></td>
			
			<td style="display:none"><input name="jttfflag<%=i%>"   id="jttfflag<%=i%>"   value="<%=jttfflag%>"></td>
			
				</tr>
<%
	}
}



%>

</table>

</div>
<script>
	<%if(custArrayOrderSize>0&&tempFlag.equals("1")){%>
			var selObj = document.getElementsByName("custOrderIds");
			selObj[0].checked = true;
			sBindQuery(selObj[0],selObj[0].vRowFlag);
		<%}%>
		
</script>
<%
}else{
%>
<script>
	rdShowMessageDialog("[<%=retCode%>]:<%=retMsg%>",0);
</script>
<%}
long l4 = new java.util.Date().getTime();
System.out.println("------------------mylog--------调用服务完成到页面加载完成的毫秒数------"+(l4-l3));	
System.out.println("------------------mylog--------整个页面加载完成的毫秒数----------------"+(l4-l1));	
%>
