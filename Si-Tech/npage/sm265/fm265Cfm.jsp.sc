<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  String workNo = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");

  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
  String zr_phone = request.getParameter("zr_phone");
  
  
  String phonenos = request.getParameter("phonenos");
  String jinee = request.getParameter("jinee");
  String liushis = request.getParameter("liushis");
  String custnamess = request.getParameter("custnamess");
  String simstatuss = request.getParameter("simstatuss");


	String  inputParsm [] = new String[12];
	inputParsm[0] = liushis;
	inputParsm[1] = "01";
	inputParsm[2] = opCode;
	inputParsm[3] = workNo;
	inputParsm[4] = password;
	inputParsm[5] = phonenos;
	inputParsm[6] = "";
  String xinliushuis="";
	
%>
	<wtc:service name="sm265Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>

	</wtc:service>
	<wtc:array id="ret" scope="end"/>
<%
	if("000000".equals(retCode)){
		if(ret.length>0) {
			xinliushuis=ret[0][0];
			System.out.println("xinliushuis="+xinliushuis);
		}
%>	
    <script language="javascript">
 	      rdShowMessageDialog("补收SIM卡费冲正操作成功！",2);
 	      
 	          var  billArgsObj = new Object();
						$(billArgsObj).attr("10001","<%=workNo%>");       //工号
						$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
						$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
						$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
						$(billArgsObj).attr("10005","<%=custnamess%>"); //客户名称
						$(billArgsObj).attr("10006","补收SIM卡费冲正"); //业务类别
						$(billArgsObj).attr("10008","<%=phonenos%>"); //用户号码
						$(billArgsObj).attr("10015", "-<%=WtcUtil.formatNumber(jinee,2)%>");   //本次发票金额
						$(billArgsObj).attr("10016", "-<%=WtcUtil.formatNumber(jinee,2)%>");   //大写金额合计	
						$(billArgsObj).attr("10017","*"); //本次缴费现金
						$(billArgsObj).attr("10030","<%=xinliushuis%>"); //流水号--业务流水
						$(billArgsObj).attr("10036","m265"); //操作代码	
						$(billArgsObj).attr("10041","SIM卡"); //品名规格     
						$(billArgsObj).attr("10042","张"); //单位         
						$(billArgsObj).attr("10043","1"); //数量         
						$(billArgsObj).attr("10044","-<%=WtcUtil.formatNumber(jinee,2)%>"); //单价         
						$(billArgsObj).attr("10061","<%=simstatuss%>"); //sim卡型号
						$(billArgsObj).attr("10071","7"); //模版
						$(billArgsObj).attr("10072","2"); //模版
						var h=180;
						var w=350;
						var t=screen.availHeight/2-h/2;
						var l=screen.availWidth/2-w/2;
						var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
						
						var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=下面将打印发票！";
						var loginAccept = "<%=xinliushuis%>";
						var path = path + "&loginAccept="+loginAccept+"&opCode=m265&submitCfm=Single";
						var ret=window.showModalDialog(path, billArgsObj, prop);
						
 	          window.location="fm265.jsp?activePhone=<%=zr_phone%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%}else{

%>
  	<script language="javascript">
 	    rdShowMessageDialog("补收SIM卡费冲正操作失败！错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
 		  window.location="fm265.jsp?activePhone=<%=zr_phone%>&opCode=<%=opCode%>&opName=<%=opName%>";
 	  </script>
<%
	}
%>
