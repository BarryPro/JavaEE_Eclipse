<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="/npage/callbosspage/public/constants.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String myParams="";
	String serialnum = WtcUtil.repNull(request.getParameter("serialnum"));
	String flag = WtcUtil.repNull(request.getParameter("flag"));
	String staffno = WtcUtil.repNull(request.getParameter("staffno"));	
	String evterno = WtcUtil.repNull(request.getParameter("evterno"));	  	    
	String loginNo = WtcUtil.repNull((String)session.getAttribute("kfWorkNo"));//�ʼ�/����/�鳤����
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));//�ʼ�/����/�鳤kf����
	String object_id = WtcUtil.repNull(request.getParameter("object_id"));
	String content_id = WtcUtil.repNull(request.getParameter("content_id"));
	//String rights="";//Y���ʼ�Ա��YY������Ա��YYY���鳤
	String pass="N";
	String swapLogin="";
	//BOSS����
	String bossLoginNo = "";
	
	String strSql = "select boss_login_no from dloginmsgrelation where kf_login_no =:loginNo and valid_flag='Y'";
	myParams = "loginNo="+loginNo;
%>	
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
			<wtc:param value="<%=strSql%>"/>
			<wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="temp" scope="end"/>
<%
    if(temp.length>0){
      bossLoginNo=temp[0][0];
    }
    //�Ƿ����ʼ�Աguozw
    strSql = "SELECT to_char(count(*)) FROM sLoginRoalrelation " +
             "WHERE trim(role_code) in :role_code AND login_no=:login_no";
   
   	String zhijianyuanID = "(";
		for(int j=0; j<ZHIJIANYUAN_ID.length; j++){
			zhijianyuanID += "'" + ZHIJIANYUAN_ID[j] + "',";
		}
		zhijianyuanID = zhijianyuanID.substring(0,zhijianyuanID.length()-1);
		zhijianyuanID = zhijianyuanID + ")";
   
    myParams = "role_code="+zhijianyuanID+",login_no="+bossLoginNo;
    
%>
	<wtc:service name="TlsPubSelCrm" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=strSql%>"/>
	  <wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="queryList" scope="end"/>	
<%  
	//�����ǰ����Ϊ�ʼ�Ա�����жϸü�¼���ʼ�Ա�Ƿ�Ϊ��ǰ����
    if(queryList.length > 0 && Integer.parseInt(queryList[0][0]) > 0){
        System.out.println("\n\n\n===queryList==="+queryList[0][0]);
       if(evterno.equals(workNo)){
           pass="Y";
       }
    }
     //�Ƿ��Ǹ���Ա
      strSql = "SELECT to_char(count(*)) FROM sLoginRoalrelation " +
               "WHERE trim(role_code)=':role_code and login_no=:login_no";
      myParams = "role_code="+FUHEYUAN_ID+",login_no="+bossLoginNo;
%>	
	<wtc:service name="TlsPubSelCrm" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=strSql%>"/>
			<wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="queryList1" scope="end"/>	
<%  
	//�����ǰ����Ϊ����Ա�������޸��������ʼ��¼
	if(queryList1.length>0&&Integer.parseInt(queryList1[0][0])>0){
		System.out.println("\n\n\n===queryList1==="+queryList1[0][0]);
		pass="Y";
	} 
     //�Ƿ����ʼ��鳤
      strSql = "SELECT to_char(count(*)) from sLoginRoalrelation "+
               "WHERE trim(role_code) in :role_code AND login_no=:login_no";
               
   	String zhijianzuzhangID = "(";
		for(int j=0; j<ZHIJIANZUZHANG_ID.length; j++){
			zhijianzuzhangID += "'" + ZHIJIANZUZHANG_ID[j] + "',";
		}

		zhijianzuzhangID = zhijianzuzhangID.substring(0,zhijianzuzhangID.length()-1);
		zhijianzuzhangID = zhijianzuzhangID + ")";
		
    myParams = "role_code="+zhijianzuzhangID+",login_no="+bossLoginNo;
%>	
	<wtc:service name="TlsPubSelCrm" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=strSql%>"/>
		<wtc:param value="<%=myParams%>"/>
	</wtc:service>
	<wtc:array id="queryList2" scope="end"/>	
<%  
    //�����ǰ����Ϊ�ʼ��鳤�������޸��������ʼ��¼
    if(queryList2.length > 0 && Integer.parseInt(queryList2[0][0]) > 0){
		pass="Y";
    }
 %>
      var response = new AJAXPacket();
      response.data.add("serialnum","<%=serialnum%>");
      response.data.add("flag","<%=flag%>");
      response.data.add("staffno","<%=staffno%>");
      response.data.add("object_id","<%=object_id%>");
      response.data.add("content_id","<%=content_id%>");
      response.data.add("pass","<%=pass%>");      
      core.ajax.receivePacket(response);