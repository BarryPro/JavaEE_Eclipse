<%
  /*
   * 功能: IVR流程->转IVR后，插ManToIVR表
　 * 版本: 1.0.0
　 * 日期: 2008/2/23
　 * 作者: fangyuan
　 * 版权: sitech
   * update: yinzx 20091003 修改name 为~连接
　 */
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String retType = WtcUtil.repNull(request.getParameter("retType"));
    String loginNo = (String)session.getAttribute("workNo");  //取login_no
    String loginName = (String)session.getAttribute("workName"); //取login_name
	  
    String callerno = WtcUtil.repNull(request.getParameter("callerno"));
    String switcher = WtcUtil.repNull(request.getParameter("switcher"));
    String mediatype = WtcUtil.repNull(request.getParameter("mediatype"));
    String transtype = WtcUtil.repNull(request.getParameter("transtype"));
    String digitcode = WtcUtil.repNull(request.getParameter("digitcode"));
    String cityid = WtcUtil.repNull(request.getParameter("cityid")); //transType
    String citycode = WtcUtil.repNull(request.getParameter("citycode")); //op_code
    String accesscode = WtcUtil.repNull(request.getParameter("accesscode")); //is_success
    String usergrade = WtcUtil.repNull(request.getParameter("usergrade")); //is_success  
    String servicename = WtcUtil.repNull(request.getParameter("servicename"));
    String autoserviceid = WtcUtil.repNull(request.getParameter("autoserviceid"));
    String successflag = WtcUtil.repNull(request.getParameter("successflag"));	
    String contactId = WtcUtil.repNull(request.getParameter("contactId"));		
    String serviceType = WtcUtil.repNull(request.getParameter("serviceType"));	
    String orgCode = (String)session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0,2);
    //lijin 20090720增加
    	
    String tableNameEnd = new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
    String tableName="DMANTOIVR"+tableNameEnd;
    System.out.println("-------------tableName--------:"+tableName);
    //截取servicename 
    
    if (servicename.indexOf(",")==0)
			servicename = servicename.substring(1);
		String[] t = servicename.split(",");
		String d="";
		for(int i=0;i<t.length;i++){
			t[i] = t[i].substring(t[i].indexOf("→")+1);
			if(i!=0){
				d+="~";
			}
			d+=t[i];
		}
    servicename = d;
    

	String sql= "insert into "+tableName+" (serialno,callerno,switchtime,switcher,mediatype,transtype,digitcode,cityid,citycode,accesscode,usergrade,servicename,autoserviceid,successflag,contact_id,servicetype)"+
	            " values(lpad(SEQ_MANTOIVR.nextval,14,'0'),:v1,sysdate,:v2,:v3,:v4,:v5,:v6,:v7,:v8,:v9,:v10,:v11,:v12,:v13,:v14)";
		      // " select lpad(SEQ_MANTOIVR.nextval,14,'0'),'"+callerno+"',sysdate,'"+switcher+"','"+mediatype+"','"+transtype+"','"+digitcode+"','"+cityid+"','"+citycode+"','"+accesscode+"','"+usergrade+"','"+servicename+"','"+autoserviceid+"','"+successflag+"','"+contactId+"','"+serviceType+"' from dual";
 	//String sel_sql="Select t.id, t.servicename from DSCETRANSFERTAB t where t.accesscode ='"+accesscode+"' and t.citycode = substr('"+citycode+"',2) and t.userclass='"+usergrade+"' and t.digitcode = '"+digitcode+"'";
 
 
 
		//System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++");
System.out.println("+++++++++AAAAAAAAAAAAAAAAAA+++++++++++++++++++   sql" +sql);
		//System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++");
		
%>

	<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=sql%>"/>
			<wtc:param value="dbchange"/>
			<wtc:param value="<%=callerno%>"/>
			<wtc:param value="<%=switcher%>"/>
			<wtc:param value="<%=mediatype%>"/>
			<wtc:param value="<%=transtype%>"/>
			<wtc:param value="<%=digitcode%>"/>
			<wtc:param value="<%=cityid%>"/>
			<wtc:param value="<%=citycode%>"/>
			<wtc:param value="<%=accesscode%>"/>
			<wtc:param value="<%=usergrade%>"/>
			<wtc:param value="<%=servicename%>"/>
			<wtc:param value="<%=autoserviceid%>"/>
			<wtc:param value="<%=successflag%>"/>
			<wtc:param value="<%=contactId%>"/>
			<wtc:param value="<%=serviceType%>"/>
	</wtc:service>
	<wtc:array id="rows"  scope="end"/>
	<%
	  if(rows[0][0].equals("000001")){
	     retCode = "000001";
	     retMsg = "保存关系失败";
	     out.print("000001");
	  }
	else
		{
				out.print("000000");
		}
	%>





