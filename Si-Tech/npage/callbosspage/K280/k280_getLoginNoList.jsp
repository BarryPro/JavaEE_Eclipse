<%
  /*
   * ����: �ʼ�Ȩ�޹���->ά�����칤�ź���->��ȡ����
�� * �汾: 1.0.0
�� * ����: 2008/11/05
�� * ����: donglei
�� * ��Ȩ: sitech
   * update:
   *          
�� */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%!
//�������ݿ���ļ��� ƴ��in���Ӿ�
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
	 * @param strShort ���ַ���
	 * @param strLong  ���ַ���
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
String selectedItemId = WtcUtil.repNull(request.getParameter("selectedItemId"));
String checkBoxValue =  WtcUtil.repNull(request.getParameter("checkBoxValue"));
String radioValue =  WtcUtil.repNull(request.getParameter("radioValue"));
String strRadioSql="select t.LOGIN_NO from DQCLOGINGROUPLOGIN t where 1=1 and t.VALID_FLAG='Y' ";
String strSelfLoginNoSql="select t.LOGIN_NO from DQCLOGINGROUPLOGIN t where 1=1 and t.VALID_FLAG='Y' ";
String strSql="select  t.login_no,t.login_name,t1.kf_login_no from  dloginmsg t ,dloginmsgrelation t1 where t1.VALID_FLAG='Y' and t.login_no=t1.boss_login_no";
String strInTemp="";
String strALLTemp="";
String strSelectLogin="false";
String strSelfLoginNo="";
String [][] strArr2= new String[0][0];
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String params = "";
String params1 = "";


//����������Ϊ�գ���鲻����¼
if(!"".equalsIgnoreCase(checkBoxValue)){
//ѡ����ʾδѡ,��Ҫ��ѯ��ѡ���鹤�Ż������½ڵ㹤�ţ������˵���Щ������Ϣ

//ѡ����ʾ��ѡ����ʾ���鹤�Ż���һ�½ڵ㹤����Ϣ  
 if("0".equalsIgnoreCase(checkBoxValue)){
   if("self".equalsIgnoreCase(radioValue)){
	  strRadioSql+=" and t.LOGIN_GROUP_ID = :selectedItemId1";
	  params+=",selectedItemId1="+selectedItemId;
	  } 
	 if("selfAndSub".equalsIgnoreCase(radioValue)){
	  strRadioSql+=" and t.LOGIN_GROUP_ID like :selectedItemId2||'%'";
	  params+=",selectedItemId2="+selectedItemId;
	  }
   }
//ͬʱѡ����ʾ��ѡ����ʾδѡ����ʾ���鹤�Ż���һ�½ڵ㹤�ź�δѡ������Ϣ   
 if("0,1".equalsIgnoreCase(checkBoxValue)){
//��ѯ����δ��ѡ�񹤺�
if("self".equalsIgnoreCase(radioValue)){
	strRadioSql+=" and t.LOGIN_GROUP_ID <> :selectedItemId3";
	params+=",selectedItemId3="+selectedItemId;
	strSelfLoginNoSql+=" and t.LOGIN_GROUP_ID = :selectedItemId";
	params1+=",selectedItemId="+selectedItemId;
} 
if("selfAndSub".equalsIgnoreCase(radioValue)){
	strRadioSql+=" and t.LOGIN_GROUP_ID  not like :selectedItemId4'%'";
	params+=",selectedItemId4="+selectedItemId;
	strSelfLoginNoSql+=" and t.LOGIN_GROUP_ID   like :selectedItemId1'%'";
	params1+=",selectedItemId1="+selectedItemId;
}

//���� mixh add begin 20090402
strRadioSql += " ORDER BY t.login_no";
strSelfLoginNoSql += " ORDER BY t.login_no";
//���� mixh add end 20090402
 %>
 <wtc:service name="TlsPubSelCrm" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
 <wtc:param value="<%=strSelfLoginNoSql%>"/>
 	<wtc:param value="<%=params1%>"/>
 </wtc:service>
 <wtc:array id="strTempArr1" scope="end"/>
 <%
   //�õ�����Ĺ��ż���
	 strSelfLoginNo=returnStr(strTempArr1);
   }  
//����������ѯ������ڵ�����Ĺ���
%>
<wtc:service name="TlsPubSelCrm" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=strRadioSql%>"/>
		<wtc:param value="<%=params%>"/>
</wtc:service>
<wtc:array id="strTempArr" scope="end"/>
<%
strInTemp=returnStrSql(strTempArr);

 //��ʾ����δ��ѡ�еĹ���
 if("1".equalsIgnoreCase(checkBoxValue)&&!"".equalsIgnoreCase(strInTemp)){
    strSql+=" and t1.kf_login_no not in("+strInTemp+")";
    strSelfLoginNo=returnStr(strTempArr);
  }
 //��ʾ����������½ڵ㹤��
 if("0".equalsIgnoreCase(checkBoxValue)){
    strSql+=" and t1.kf_login_no in("+strInTemp+")";
    strSelfLoginNo=returnStr(strTempArr);
  }
 //��ʾ��ѡ���ź�����δ��ѡ�еĹ���
 if("0,1".equalsIgnoreCase(checkBoxValue)&&!"".equalsIgnoreCase(strInTemp)){
    strSql+=" and t1.kf_login_no not in("+ strInTemp +")";
   }  
}

//���� mixh add begin 20090402
strSql += " ORDER BY  t.login_no";
//���� mixh add end 20090402
%>
<wtc:service name="TlsPubSelCrm" outnum="3" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=strSql%>" />
</wtc:service>
<wtc:array id="resultList" scope="end"/>


<%
	if(strSelfLoginNo==null){
		strSelfLoginNo = "";
	}
  String[] selectNos = strSelfLoginNo.split(",");
  StringBuffer returnStr = new StringBuffer();
  returnStr.append("<TABLE id='dataTable' border='0' height='420' style='font-size:12px;'><tr>");
  int m = 0;
	for (int i = 0; i < resultList.length; i++) {
	
		m = i%300;
		if(i==0||m==0){
      if(i!=0){
      	returnStr.append("</td>");
      }
      returnStr.append("<td vAlign='top' width='160px' class='title_zi' height='420'>");     
  	}
  	//�ж��Ƿ���ѡ
  	boolean isSelect = false;
  	for(int j=0;j<selectNos.length;j++){
  		if(resultList[i][2].equals(selectNos[j])){
  				isSelect = true;
  				break;
  		}
  	}
  	if(isSelect){
  		returnStr.append("<input type='checkbox' checked='checked' isgroup='true' name='loginNo' isgroup='false'  value='"+resultList[i][2]+"'/>"+resultList[i][2]+""+resultList[i][1]+"<br/>");
    }else{
  		returnStr.append("<input type='checkbox' name='loginNo' isgroup='false'  value='"+resultList[i][2]+"'/>"+resultList[i][2]+""+resultList[i][1]+"<br/>");
  	}
	}
	if(resultList.length>0){
		returnStr.append("</td>");
	}
	returnStr.append("</tr></TABLE>");
	
%>

var response = new AJAXPacket();
response.data.add("nodes","<%=returnStr.toString()%>");
core.ajax.receivePacket(response);
