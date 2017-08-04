 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-14 页面改造,修改样式
	********************/
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String regionCode=(String)session.getAttribute("regCode");
	//ArrayList retArray = new ArrayList();
	//ArrayList retArray1 = new ArrayList();
	String[][] result = new String[][]{};
	String[][] result1= new String[][]{};
	
	String tmpStr = "";
	String iGrpId = request.getParameter("grpId");
  	StringBuffer strbuf = new StringBuffer();
    	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	//SPubCallSvrImpl callView1 = new SPubCallSvrImpl();
	String sqlStr = "select group_no, group_name, province_code, servarea, scp_code, group_type, contact, address, telephone, To_char (start_time, 'YYYYMMDD'), To_char (end_time, 'YYYYMMDD'), substate, funcflags, interfee, outfee, outgrpfee, normalfee, admno, transno, display, maxclnum, maxnumcl, pmaxclose, maxoutnum, maxusers, pkgtype, To_char (pkgday, 'YYYYMMDD'), discount, lmtfee,outside_groupnum,fee_rate,busi_type,use_status,cover_region,chg_flag,group_id from dVpmnGrpMsg where group_no = " + iGrpId;
  	String sqlStr1= "select trim(field_value) from dgrpusermsgadd where id_no=(select group_id from dvpmngrpmsg where group_no = '" + iGrpId+ "') and field_code='ZHWW0' and busi_type='1000' and field_order=0";
	int   recordNum1=0;
	//retArray = callView.sPubSelect("36",sqlStr);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="36">
		<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="retArray" scope="end" />
<%
	
    	//result = (String[][])retArray.get(0);    	
    	result=retArray;    	
    	int recordNum = 0;
    	if(result!=null&&result.length>0){
    		recordNum=result.length;
    	}
    	if (result!=null&&result.length>0&&result[0][0].trim() == ""){
        	recordNum = 0;
       	}
       	System.out.println("recordNum=========="+recordNum);
  	//retArray1 = callView1.sPubSelect("1",sqlStr1);
 %>
 	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:sql><%=sqlStr1%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="retArray1" scope="end" />
 <%
    	//result1=(String[][])retArray1.get(0);   
    	result1=retArray1;
    	//recordNum1 = result1[0].length;
    	if(result1!=null&&result1.length>0){
    		recordNum1=result1[0].length;
    	}
    	
    	if (result1!=null&&result1.length>0&&result1[0][0].trim() == ""){
        	recordNum1 = 0;
       }

	if (recordNum == 0 ){
%>
	<script language="JavaScript">
			window.returnValue="0";
			window.close();
	</script>
<%
	}
	else{
		
		for ( int i=0; i < result[0].length ; i++ ){
			strbuf.append(result[0][i].trim());
			strbuf.append(",");
		}
		tmpStr = strbuf.toString();		
		if(recordNum1==0)
		{
		 tmpStr=tmpStr+"0,";
		}
	 else
	 	{
	 	   
	 	   if("vm".equals(result1[0][0].trim()))
	 	   {
	 	       tmpStr=tmpStr+"1,";
	 	      
	 	   }
	 	   if("vt".equals(result1[0][0].trim()))
	 	   {
	 	       tmpStr=tmpStr+"2,";
	 	   }
	 	}
%>
	<script language="JavaScript">
			window.returnValue="<%=tmpStr%>";	
			window.close();
	</script> 
<%}
%>
