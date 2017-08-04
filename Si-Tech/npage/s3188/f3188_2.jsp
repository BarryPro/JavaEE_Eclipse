<%
   /*
   * 功能: 集团统付历史查询
　 * 版本: v1.0
　 * 日期: 2006/11/07
　 * 作者: xiening
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   * 2009-09-09    qidp        新版集团产品改造
 　*/
 %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@page contentType="text/html;charset=GBK"%>
<%
	//读取用户session信息
	String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));              //工号
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));          	//工号姓名
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
			
	//错误信息，错误代码
	int errCode = 0;
	String errMsg = "";
	
	String contract_Pay = request.getParameter("contract_Pay");
	String contract_Pay2 = request.getParameter("contract_Pay2");
	String totalDate = request.getParameter("totalDate");
	String phoneNo = request.getParameter("phoneNo");
	String opType = request.getParameter("opType");
	System.out.println("phoneNo:"+phoneNo);
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	ArrayList retList2 = new ArrayList();  
	
	String[][] retListString2 = new String[][]{};
	%>
  		<wtc:service name="s3188EXC" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="8" >
        	<wtc:param value="3188"/>
        	<wtc:param value="<%=workNo%>"/> 
            <wtc:param value="<%=contract_Pay%>"/> 
            <wtc:param value="<%=contract_Pay2%>"/> 
            <wtc:param value="<%=totalDate%>"/> 
            <wtc:param value="<%=opType%>"/> 
            <wtc:param value="<%=phoneNo%>"/> 
        </wtc:service>
        <wtc:array id="retArr1" scope="end"/>
    <%
    if("000000".equals(retCode1) && retArr1.length>0){
        retListString2 = retArr1;
    }
	
	//String[][] retListString2 = (String[][])retList2.get(0);
	
	//errCode=impl.getErrCode();   
	//errMsg=impl.getErrMsg(); 
	errCode = Integer.parseInt(retCode1);
	errMsg = retMsg1;
	System.out.println("errCode:"+errCode);
	System.out.println("errMsg:"+errMsg);
%>

	var contract_pay= new Array(); 
	var contract_no= new Array();
	var total_date= new Array(); 
	var login_accept= new Array();  
	var pay_type= new Array(); 
	var pay_money= new Array(); 
	var login_no= new Array();
	var op_time= new Array();
	var response = new AJAXPacket();
	//response.guid = '<%= request.getParameter("guid") %>';
<%
	if(errCode==0)
	{
		for(int i=0;i<retListString2.length;i++){
%>
			contract_pay[<%=i%>]="<%=retListString2[i][0]%>";
			contract_no[<%=i%>]="<%=retListString2[i][1]%>";
			total_date[<%=i%>]="<%=retListString2[i][2]%>";
			login_accept[<%=i%>]="<%=retListString2[i][3]%>";
			pay_type[<%=i%>]="<%=retListString2[i][4]%>";
			pay_money[<%=i%>]="<%=retListString2[i][5]%>";
			login_no[<%=i%>]="<%=retListString2[i][6]%>";
			op_time[<%=i%>]="<%=retListString2[i][7]%>";
<%
		}
%>
		response.data.add("contract_pay",contract_pay);
		response.data.add("contract_no",contract_no);
		response.data.add("total_date",total_date);
		response.data.add("login_accept",login_accept);
		response.data.add("pay_type",pay_type);
		response.data.add("pay_money",pay_money);
		response.data.add("login_no",login_no);
		response.data.add("op_time",op_time);
		response.data.add("num","<%=retListString2.length%>");
		response.data.add("errCode","<%=errCode%>");
		response.data.add("errMsg","<%=errMsg%>");
		core.ajax.receivePacket(response);
<%
	
	}
	else
	{
	System.out.println("return erro");
%>
		response.data.add("errCode","<%=errCode%>");
		response.data.add("errMsg","<%=errMsg%>");
		core.ajax.receivePacket(response);
<%	
	}
%>
