<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%!
//根据数据库里的集合 拼成in的子句
	public String returnStrSqlByArr(String[][] strTempArr){
	     String strTemp="";
	     for (int i=0;i<strTempArr.length;i++){
	    	strTemp+="'"+strTempArr[i][0];
	    	if(i==strTempArr.length-1){
	    		strTemp+="'";
	    	}else{
	    		strTemp+="',";
	    	} 
	     }
	     return strTemp;
	}
	public String returnStr(String[][] strTempArr){
	     String strTemp="";
	     for (int i=0;i<strTempArr.length;i++){
	    	strTemp+=strTempArr[i][0]+",";
	     }
	     return strTemp;
	}
	public String returnStrSql(String strNodeIdList){
		String [] strTempArr = new String[0];
		if(strNodeIdList!=null&&!"".equalsIgnoreCase(strNodeIdList)){
			strTempArr=strNodeIdList.split(",");
		}
	     String strTemp="";
	     for (int i=0;i<strTempArr.length;i++){
	    	strTemp+="'"+strTempArr[i];
	    	if(i==strTempArr.length-1){
	    		strTemp+="'";
	    	}else{
	    		strTemp+="',";
	    	} 
	     }
	     return strTemp;
	}
		/**
	 * @param strShort 短字符串
	 * @param strLong  长字符串
	 * @return
	 */
	public static String  returnSqlByArrFilter(String[][] strShort,String[][] strLong){
		  String str =""; 
		  String strTemp="";
		  if(strShort==null||strLong==null){
			  return strTemp;
		   }
		  for(int j=0;j<strShort.length;j++){
		       str+=strShort[j][0];     
		    }    
		for (int i = 0; i < strLong.length; i++) {                  
		    if(str.indexOf(strLong[i][0])==-1) {    
		    	strTemp+="'"+strLong[i][0];
		    	if(i==strLong.length-1){
		    		strTemp+="'";
		    	}else{
		    		strTemp+="',";
		    	} 
		    }
		 }
		 return strTemp;
	}
%>
<%
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

String selectedItemList = WtcUtil.repNull(request.getParameter("selectedItemList"));
String strSelfLoginNoSql="select t.LOGIN_NO from DQCLOGINGROUPLOGIN t where 1=1 and t.VALID_FLAG='Y' ";
String strSql="select  t.login_no,t.login_name,t1.kf_login_no from  dloginmsg t ,dloginmsgrelation t1 where t1.VALID_FLAG='Y' and t.login_no=t1.boss_login_no";
String strInTemp="";
String strALLTemp="";
String [][] strArr2= new String[0][0];
strSelfLoginNoSql+= "and t.login_group_id in("+returnStrSql(selectedItemList)+")";
%>
 <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
 <wtc:param value="<%=strSelfLoginNoSql%>"/>
 </wtc:service>
 <wtc:array id="strTempArr" scope="end"/>
<%
    strInTemp=returnStrSqlByArr(strTempArr);
    strSql+=" and t1.kf_login_no in("+strInTemp+")";
%>
<wtc:service name="sPubSelect" outnum="3">
	<wtc:param value="<%=strSql%>" />
</wtc:service>
<wtc:array id="resultList" scope="end"/>

var nodes = new Array();
<%
	for (int i = 0; i < resultList.length; i++) {
%>
    var tmpArr = new Array();
	<%
		for (int j = 0; j < resultList[i].length; j++) {
	%>
		tmpArr[<%=j%>] = '<%=resultList[i][j]%>';
	<%
		}
	%>
	nodes[<%=i%>] = tmpArr;
<%
	}
%>

var response = new AJAXPacket();
response.data.add("nodes",nodes);
core.ajax.receivePacket(response);
