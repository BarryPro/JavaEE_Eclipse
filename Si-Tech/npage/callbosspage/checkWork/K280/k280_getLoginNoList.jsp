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

<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>

<%!
		//�۰뷨���ң��޵ݹ飬δʹ��
		public boolean quickGetStaff(String[][] staff_list,String login_no){			
			  int end = staff_list.length-1;
			  int login_no_i = Integer.parseInt(login_no);
				if(end<0){
						return false;
				}
				int begin = 0;
				while(begin<=end){
					int mid = (begin+end)/2;
					int log_no = Integer.parseInt(staff_list[mid][0]);
					if(log_no==login_no_i){
							return true;
					}else if(log_no>login_no_i){
							end = mid-1;
							continue;
					}else{
							begin = mid+1;
							continue;
					}
				}
				return false;
		}
%>

<%
  /*midify by guozw 20091114 ������ѯ�����滻*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

String selectedItemId = WtcUtil.repNull(request.getParameter("selectedItemId"));
String checkBoxValue =  WtcUtil.repNull(request.getParameter("checkBoxValue"));
String radioValue =  WtcUtil.repNull(request.getParameter("radioValue"));
String strRadioSql="select t.LOGIN_NO from DQCLOGINGROUPLOGIN t where 1=1 and t.VALID_FLAG='Y' ";
String strSql="select  t.login_no,t.login_name,t1.boss_login_no from  dloginmsg t ,dloginmsgrelation t1 where t1.VALID_FLAG='Y' and t.login_no=t1.boss_login_no order by to_number(t1.kf_login_no)";

String[][] selectNos = {};


//����������Ϊ�գ���鲻����¼
if(!"".equalsIgnoreCase(checkBoxValue)){
//ѡ����ʾδѡ,��Ҫ��ѯ��ѡ���鹤�Ż������½ڵ㹤�ţ������˵���Щ������Ϣ

if("self".equalsIgnoreCase(radioValue)){
	  strRadioSql+=" and t.LOGIN_GROUP_ID = :selectedItemId";
	  myParams = "selectedItemId="+selectedItemId ;
}
if("selfAndSub".equalsIgnoreCase(radioValue)){
	  strRadioSql+=" and t.LOGIN_GROUP_ID like ''||:selectedItemId||'%'";
	  myParams = "selectedItemId="+selectedItemId ;
}

//����������ѯ������ڵ�����Ĺ���
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
	<wtc:param value="<%=strRadioSql%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="strTempArr" scope="end"/>
<%
selectNos=strTempArr;
System.out.println(selectNos.length+"======");

}
//��ԭ������û�Ϊejb����  zengzq add 20091111
List iDataList = (List)KFEjbClient.queryForList("selectPublic",strSql);
String[][] resultList = getArrayFromListMap(iDataList ,0,3);
%>
	
<%
  HashMap datamap = new HashMap();
  for(int j=0;j<selectNos.length;j++){
  		datamap.put(selectNos[j][0],selectNos[j][0]);
  }
  
  StringBuffer returnStr = new StringBuffer();
  returnStr.append("<TABLE id='dataTable' border='0' height='420' style='font-size:12px;'><tr>");
  int m = 0;
  int flag_ = 0;
  boolean hasTd = false;
  
	for (int i = 0; i < resultList.length; i++) {
	  boolean isSelect = false;
	  if(datamap.get(resultList[i][2])!=null){
	  //if(quickGetStaff(selectNos,resultList[i][2])){
	  	 isSelect = true;
	  }

	  //ֻѡ��ѡ
	  if("0".equalsIgnoreCase(checkBoxValue)&&!isSelect){
  			continue;
	  }
	  //ֻѡδѡ
	  if("1".equalsIgnoreCase(checkBoxValue)&&isSelect){
  			continue;
	  }
	m = flag_%500;
	if(flag_==0||m==0){
			if(flag_!=0){
					returnStr.append("</td>");
			}
			returnStr.append("<td vAlign='top' width='160px' class='title_zi' height='420'>");
			hasTd =true;
	}


  	if(isSelect){
  		returnStr.append("<input type='checkbox' checked='checked' isgroup='true' name='loginNo' isgroup='false'  value='"+resultList[i][2]+"'/><span class='item_a' onclick=\\\"showStaffInfo('"+resultList[i][2]+"');return false;\\\">"+resultList[i][2]+""+resultList[i][1]+"</span><br/>");
    }else{
  		returnStr.append("<input type='checkbox' name='loginNo' isgroup='false'  value='"+resultList[i][2]+"'/><span class='item_a' onclick=\\\"showStaffInfo('"+resultList[i][2]+"');return false;\\\">"+resultList[i][2]+""+resultList[i][1]+"</span><br/>");
  	}
  	flag_++;
	}
	if(hasTd){
		returnStr.append("</td>");
	}
	returnStr.append("</tr></TABLE>");
%>

var response = new AJAXPacket();
response.data.add("nodes","<%=returnStr.toString()%>");
core.ajax.receivePacket(response);
