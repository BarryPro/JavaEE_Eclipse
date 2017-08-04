<%
   /*
   * 功能: 集团客户销户
　 * 版本: v1.0
　 * 日期: 2007/08/20
　 * 作者: baixf
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   * 2009-1-19      qidp       修改样式
 　*/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
 

<%
	
	//读取用户session信息
	String workNo   = (String)session.getAttribute("workNo");                //工号
	String ip_Addr  = (String)session.getAttribute("ipAddr");
	String nopass  = (String)session.getAttribute("password");               //登陆密码
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);
	String ret_code="";
	String retMessage="";
	Logger logger = Logger.getLogger("f1994_del.jsp");
	
	String unit_id = request.getParameter("cust_id"); 
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	//ArrayList acceptList = new ArrayList();
	
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept"/>
<%
	String paraArr[] = new String[5];
	paraArr[0] = workNo;
	paraArr[1] = nopass;
	paraArr[2] = "1994";
	paraArr[3] = unit_id;
	paraArr[4] = ip_Addr;
	
	//acceptList = impl.callFXService("sGrpCustMsgDele",paraArr,"2");
	%>
    <wtc:service name="sGrpCustMsgDele" routerKey="region" routerValue="<%=regionCode%>" retcode="sGrpCustMsgDeleCode" retmsg="sGrpCustMsgDeleMsg" outnum="2" >
    	<wtc:param value="<%=paraArr[0]%>"/>
    	<wtc:param value="<%=paraArr[1]%>"/> 
        <wtc:param value="<%=paraArr[2]%>"/>
        <wtc:param value="<%=paraArr[3]%>"/>
        <wtc:param value="<%=paraArr[4]%>"/>
    </wtc:service>
    <wtc:array id="sGrpCustMsgDeleArr" scope="end"/>
    <%
	String errCode=sGrpCustMsgDeleCode;
	String errMsg=sGrpCustMsgDeleMsg;
//-------modify by qidp-------
 System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
    String url = "/npage/contact/onceCnttInfo.jsp?opCode="+"1994"+"&retCodeForCntt="+errCode+"&retMsgForCntt="+errMsg
    +"&opName="+"集团客户销户"+"&workNo="+workNo+"&loginAccept="+loginAccept+"&pageActivePhone="+""+"&opBeginTime="+opBeginTime+"&contactId="+unit_id+"&contactType=grp";
%>
    <jsp:include page="<%=url%>" flush="true" />
<%
    System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");
    System.out.println("url=========="+url);
//----------------------------


		if(errCode.equals("000000")){
		
  %>
             <script language='jscript'>
                rdShowMessageDialog("集团客户销户操作成功！",2);
				        
            </script>                  
<%		}else
        {
%>
            <script language='jscript'>
                rdShowMessageDialog("<%=errMsg%>" + "[" + "<%=errCode%>" + "]" ,0);
                
            </script>
<%        
        }
%>
		      
        