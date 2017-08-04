<%
  /*
   * 功能:客户订单缴费处理
　 * 版本: 
　 * 日期: 2009-01-15 10:00
　 * 作者: wanglj
　 * 版权: sitech
　*/
%>  
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="java.util.*"%>


<%   
    String opCode = request.getParameter("opCode");
    System.out.println("# From fq025_cfm.jsp -> opCode="+opCode);
	String sCustOrderId = request.getParameter("sCustOrderId");
	String gCustId =  request.getParameter("gCustId");
	String  array_order = request.getParameter("array_order");
	System.out.println("....................arrayOrderStr"+array_order);
	String[]  arrayOrderStr = request.getParameterValues(array_order);
	System.out.println("....................arrayOrderStr"+arrayOrderStr);
	String workNo = (String) session.getAttribute("workNo");
	String workPwd = (String) session.getAttribute("password");
	String sIpAddress =  request.getRemoteAddr();//IP	
	String sOprGroupId = (String) session.getAttribute("groupId");
	String sOpTime = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date());
	String orgCode = (String) session.getAttribute("orgCode");	
	String sRegionCode   = orgCode.substring(0,2);
	String sOpNote = "订单审核";//request.getParameter("op_note");
	//String sSiteId = (String) session.getAttribute("siteId"); //处理点
	String sSiteId = (String) session.getAttribute("groupId"); //处理点
	//String sObjectId = (String) session.getAttribute("objectId"); //处理局
	String sObjectId = (String) session.getAttribute("groupId"); //处理局
  UType TOprInfo = new UType();
          TOprInfo.setUe("LONG","0");
          TOprInfo.setUe("STRING",opCode);
          TOprInfo.setUe("STRING",workNo);  
          TOprInfo.setUe("STRING",workPwd);        
          TOprInfo.setUe("STRING",sIpAddress);
          TOprInfo.setUe("STRING",sOprGroupId);
          TOprInfo.setUe("STRING",sOpTime);
          TOprInfo.setUe("STRING",sRegionCode);
					TOprInfo.setUe("STRING",sOpNote);                    // 备注 
					TOprInfo.setUe("STRING",sSiteId);                    //  处理点 
					TOprInfo.setUe("STRING",sObjectId);                    //  处理局
   if(arrayOrderStr == null || arrayOrderStr.length == 0 ){
%>
          <script>
               alert("您没有选择缴费科目信息!");
               window.history.go(-1);
          </script>	
<%    
     }
     UType u1 = new UType();
     for(int i = 0 ; i < arrayOrderStr.length;i++){
     	u1.setUe("STRING",arrayOrderStr[i].split("\\|")[0]);
     }
     UType u2 = new UType();
     u2.setUe("STRING","通过");
     StringBuffer logBuffer = new StringBuffer(80);
	WtcUtil.recursivePrint(u1,1,"2",logBuffer);		
	System.out.println(logBuffer.toString());
%>

   <wtc:utype name="sCustOrderAudit" id="retVal" scope="end">
     <wtc:uparam value="<%=TOprInfo%>" type="UTYPE"/> 
     <wtc:uparam value="<%=u1%>" type="UTYPE"/>  
     <wtc:uparam value="<%=u2%>" type="UTYPE"/>  
	</wtc:utype>

<%
     String ret_code = retVal.getValue(0);
     String retMessage = retVal.getValue(1).replace('\n',' ');
     if(ret_code.equals("0"))
     {
     	  logBuffer = new StringBuffer(80);
				WtcUtil.recursivePrint(retVal,1,"2",logBuffer);		
				System.out.println(logBuffer.toString());
				UType uu = retVal.getUtype(2);
				int retSize =  uu.getSize();
				if ( retSize == 0){
     %>
     <script>
     	rdShowMessageDialog("审核成功!",2);			
     	parent.parent.removeTab("custid<%=gCustId%>");
     </script>
    <%}else {
    	  StringBuffer sb = new StringBuffer();
    	  sb.append("[");
    		for(int i = 0 ; i< retSize; i++ ){
    			sb.append(uu.getValue(i)).append("<br>");
    		}
    		sb.append("]");    		
     %>
     <script>
     	rdShowMessageDialog("订单<%=sb.toString()%>已经被审核!",1);			
     	parent.parent.removeTab("custid<%=gCustId%>");
     </script>
    <%	
     }
     }else{%>    	
     <script>
        	rdShowMessageDialog("审核失败!",1);
          window.history.go(-1);
     </script>			
    <%}%>
 