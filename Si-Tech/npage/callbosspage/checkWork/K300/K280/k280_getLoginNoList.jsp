
<%
  /**
   * 功能: 质检权限管理->分配质检权限->被检组信息树获取组内员工
　 * 版本: 1.0.0
　 * 日期: 2008/11/05
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@page import="java.util.HashMap"%>
<%!
//根据数据库里的集合 拼成in的子句
	public String[] returnStrSqlByArr(String[][] strTempArr){
	     String strTemp="";
	     String[] returnVal = null;
	     int dataLength = 0;
	     if(strTempArr.length>0){
	     		dataLength = strTempArr.length;
	     }    
	     int dataSize = dataLength%80>0?(dataLength/80+1):dataLength/80;
	     returnVal = new String[dataSize];
	     int m = 0;
	    strTemp = "'";
	     for (int i=1; i<dataLength+1; i++){
		    	strTemp += strTempArr[i-1][0];
		    	if(i==dataLength||i%80 == 0){
			    		strTemp += "'";
			    		returnVal[m] = strTemp;
			    		strTemp = "'";
			    		m++;
			    		continue;
		    	}else{
		    		
		    			strTemp += "','";
		    	} 
	     }
	     return returnVal;
	}
	public String returnStr(String[][] strTempArr){
	     String strTemp = "";
	     for (int i=0;i<strTempArr.length;i++){
	    	strTemp += strTempArr[i][0] + ",";
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

	String strSelfLoginNoSql = null;
	String selectedItemList = WtcUtil.repNull(request.getParameter("selectedItemList"));
	String [] selectedItemLists=selectedItemList.split("\\,");
	HashMap pMap=new HashMap();
	pMap.put("selectedItemLists", selectedItemLists);
	//String getCountSql = "select to_char(nvl(count(1),0)) from DqcCheckedSerialNos where login_group_id in(" + returnStrSql(selectedItemList) + ")";
	String tmpCount = (String)KFEjbClient.queryForObject("query_K280_getCountSql",pMap);
  String SelfLoginNoSql="Y";
/*
if(Integer.parseInt(tmpCount)>0){ 	
		strSelfLoginNoSql = "select t.serialNo from DqcCheckedSerialNos t where 1=1 and t.VALID_FLAG='Y' ";
}else{
		strSelfLoginNoSql="select t.LOGIN_NO from DQCLOGINGROUPLOGIN t where 1=1 and t.VALID_FLAG='Y' ";
}
*/
%>
<%
String strSql = "select  t.login_no,t.login_name,t1.boss_login_no from  dloginmsg t ,dloginmsgrelation t1 where t1.VALID_FLAG = 'Y' and t.login_no = t1.boss_login_no";
String strInTemp[] = null;
String strSerialTemp[] = null;
String strALLTemp = "";
String [][] strArr2 = new String[0][0];
String tmpStrSql = null;
if(Integer.parseInt(tmpCount)>0){ 	
  SelfLoginNoSql="N";
}
 pMap.put("SelfLoginNoSql", SelfLoginNoSql);


  List queryList =(List)KFEjbClient.queryForList("query_K280_strSelfLoginNoSql",pMap);     
   String[][] strTempArr = getArrayFromListMap(queryList ,0,1);           
		StringBuffer returnStr = new StringBuffer();
		returnStr.append("<TABLE id='dataTable' border='0' height='420' style='font-size:12px;'><tr>");
		int countNum = 0;

    strInTemp = returnStrSqlByArr(strTempArr);
    String tmpSavData = null;
    //被检组导入流水情况 zengzq 20091104
		 if(Integer.parseInt(tmpCount)>0){
		 		for(int i =0; i<strInTemp.length; i++){
		 				tmpSavData = strInTemp[i].replaceAll("','",",");
		 				tmpSavData = tmpSavData.replaceAll("'","");
		 				tmpSavData = tmpSavData.trim();
				 		strSerialTemp = tmpSavData.split(",");
				 		for (int j = 0; j < strSerialTemp.length; j++) {
								if(countNum == 0 || countNum%500 == 0){
										if(countNum != 0){
												returnStr.append("</td>");
										}	
										returnStr.append("<td vAlign='top' width='160px' class='title_zi' height='420'>");
								}
								returnStr.append("<input type='checkbox' checked='checked' onclick='checked=!checked'  name='loginNo'value='"+strSerialTemp[j]+"'/>"+strSerialTemp[j]+"<br/>");
								countNum++;
						}
				}
		 		
		 }else{
		 		//原工号显示
		    for(int i =0; i<strInTemp.length; i++){
		      String[]values=strInTemp[i].replaceAll("'","").split("\\,");
		      pMap=new HashMap();
	        pMap.put("values", values);
		      List queryLists =(List)KFEjbClient.queryForList("query_K280_strSql",pMap);
		      System.out.println(queryLists.size());      
          String[][] resultList = getArrayFromListMap(queryLists ,0,3);  
          //System.out.println(resultList.length);         
						for (int j = 0; j < resultList.length; j++) {
								if(countNum == 0 || countNum%500 == 0){
										if(countNum != 0){
												returnStr.append("</td>");
										}	
										returnStr.append("<td vAlign='top' width='160px' class='title_zi' height='420'>");
								}
								returnStr.append("<input type='checkbox' checked='checked' onclick='checked=!checked'  name='loginNo' value='"+resultList[j][2]+"'/>"+resultList[j][2]+""+resultList[j][1]+"<br/>");
								countNum++;
						}
				}
			}
		returnStr.append("</td>");
		returnStr.append("</tr></table>");
%>
var response = new AJAXPacket();
response.data.add("nodes","<%=returnStr.toString()%>");
core.ajax.receivePacket(response);
