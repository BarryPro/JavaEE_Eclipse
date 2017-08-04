<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%!
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

//根据数据库里的集合 拼成in的子句
	public String returnStrSql(String[][] strTempArr){
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
String class_id = WtcUtil.repNull(request.getParameter("class_id"));
String strSql=" select kf_no,kf_name from dstaffstatus where class_id=:class_id ";
myParams = "class_id="+class_id ;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="2">
	<wtc:param value="<%=strSql%>"/>
	<wtc:param value="<%=myParams%>"/>
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
