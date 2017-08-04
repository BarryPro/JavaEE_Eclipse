<%
  /*
   * 功能: 查询客户名称
   * 版本: 1.0
   * 日期: 20130610
   * 作者: diling
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

System.out.println("-------hejwa-----------------queryJTaccept.jsp-------->"+"");

	      String regCode = (String)session.getAttribute("regCode");	
        String loginNo = (String)session.getAttribute("workNo");
        String loginNoPass = (String)session.getAttribute("password");
        String ipAddrss = (String)session.getAttribute("ipAddr");
        String phoneNo = request.getParameter("selNumValue");
        String beizhussdese="根据phoneNo=["+phoneNo+"]进行查询";
        String dateStr22 = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
        String IccId="";
        String acceptjts="";

%>
<wtc:service name="sUserCustInfo" outnum="100"  routerKey="region" routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg">
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="1104" />	
			<wtc:param value="<%=loginNo%>" />
			<wtc:param value="<%=loginNoPass%>" />
			<wtc:param value="<%=phoneNo%>" />
			<wtc:param value="" />
			<wtc:param value="<%=ipAddrss%>" />
			<wtc:param value="<%=beizhussdese%>" />
</wtc:service>
<wtc:array id="baseArr" scope="end"/>
<%
    if(baseArr!=null&&baseArr.length>0){
    
    	if(baseArr[0][0].equals("00")) {
    	
    			String iccidtypes=baseArr[0][12].trim();
    			System.out.println("iccidtypes----1104---------------iccidtypes="+iccidtypes+"===========");
    			if("0".equals(iccidtypes) || "00".equals(iccidtypes)) {/*判断如果是身份证才去下发工单表里查询集团流水*/
          IccId = baseArr[0][13];
          }

          System.out.println("hljinnet----1104---------------IccId="+IccId);

          }
    }
 
 if(IccId!=null) {
 		if(!"".equals(IccId)) {
		String[] inParamsss1 = new String[2];
	  inParamsss1[0] = "select  transaction_id from  (select transaction_id from wcustordercolmsg where id_iccid =:iccidstr and op_time >= to_date(:todaydates,'yyyymmdd') and op_time <= to_date(:todaydates2,'yyyymmdd hh24:mi:ss') and update_type in ('U','J') and length(pic_namez)>5 order by op_time desc ) where    rownum = 1";
	  inParamsss1[1] = "iccidstr="+IccId.trim()+",todaydates="+dateStr22+",todaydates2="+dateStr22+" 23:59:59";
	  
	  System.out.println("-------hejwa-----------inParamsss1[0] -------------->"+inParamsss1[0] );
	  System.out.println("-------hejwa-----------inParamsss1[1] -------------->"+inParamsss1[1] );
	  
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1ss" retmsg="retMsg1ss" outnum="1">			
		<wtc:param value="<%=inParamsss1[0]%>"/>
		<wtc:param value="<%=inParamsss1[1]%>"/>	
		</wtc:service>	
	  <wtc:array id="dcustarry" scope="end" />   
<%

		if(dcustarry.length>0) {
			acceptjts=dcustarry[0][0];
		}
		
   }   
 }  
 System.out.println("acceptjts======hejwa============="+acceptjts);
%>
var response = new AJAXPacket();
response.data.add("errCode","<%=retCode%>");
response.data.add("errMsg","<%=retMsg%>");
response.data.add("acceptjts","<%=acceptjts%>");
core.ajax.receivePacket(response);
 