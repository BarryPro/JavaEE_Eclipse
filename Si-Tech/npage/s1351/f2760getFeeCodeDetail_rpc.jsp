<%
   /*
   * 功能: 个性帐单模板 rpc
　 * 版本: v1.0
　 * 日期: 2006/08/28
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
	String feeCode = request.getParameter("feeCode");   		//一级费用项		
	String iPos = request.getParameter("iPos");   		
                        
	SPubCallSvrImpl callView = new SPubCallSvrImpl();
	String[][] feeCodeDetailArr = new String[][]{};//二级费用项
	
	String sqlStr = "select detail_code ,detail_name from sFeeCodeDetail where fee_code = '?'";
	//feeCodeDetailArr = (String[][])callView.sPubSelect("2",sqlStr).get(0);
	%>
		<wtc:pubselect name="TlsPubSelBoss" retmsg="retMsg" retcode="retCode" outnum="2">
		<wtc:sql><%=sqlStr%></wtc:sql>
	  <wtc:param value="<%=feeCode%>"/>
		</wtc:pubselect>
		<wtc:array id="retList" scope="end" />
      <%
      feeCodeDetailArr =retList;
	//int errCode=callView.getErrCode();   
	//String errMsg=callView.getErrMsg(); 
	String errMsg=retMsg;
%>
		var fcd = new Array(); 
		var fcd_value = new Array();
		
		fcd[0] = '*';
    fcd_value[0] = '全部费用';
<%  	
			System.out.println("feeCode="+feeCode);
			for(int i=0; i< feeCodeDetailArr.length; i++)
			{				
%>  	
				fcd[<%=i+1%>] = '<%=feeCodeDetailArr[i][0]%>';
				fcd_value[<%=i+1%>] = '<%=feeCodeDetailArr[i][1]%>';
<%  	
			}
%>
 
   
	var response = new RPCPacket();
	response.guid = '<%= request.getParameter("guid") %>';
	response.data.add("retFlag","getFeeCodeDetail");
	response.data.add("errCode","0");
	response.data.add("errMsg","<%=errMsg%>");
	response.data.add("fcd",fcd);
	response.data.add("fcd_value",fcd_value);
	response.data.add("iPos",<%=iPos%>);
	core.rpc.receivePacket(response);
