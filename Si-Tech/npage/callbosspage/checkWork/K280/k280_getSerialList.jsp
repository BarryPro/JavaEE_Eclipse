<%
  /*
   * ����: �ʼ�Ȩ�޹���->ά�����칤�ź���->��ȡ��ˮ��
�� * �汾: 1.0.0
�� * ����: 2009/11/04
�� * ����: zengzq
�� * ��Ȩ: sitech
   * update:
   *
�� */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
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
String strRadioSql="select t.serialNo from DqcCheckedSerialNos t where 1=1 and t.VALID_FLAG='Y' ";
String[][] selectNos = {};


//����������Ϊ�գ���鲻����¼
if(!"".equalsIgnoreCase(checkBoxValue)){
//ѡ����ʾδѡ,��Ҫ��ѯ��ѡ���鹤�Ż������½ڵ㹤�ţ������˵���Щ������Ϣ

if("self".equalsIgnoreCase(radioValue)){
	  strRadioSql+=" and t.LOGIN_GROUP_ID = :selectedItemId";
	  myParams = "selectedItemId="+selectedItemId ;
}
if("selfAndSub".equalsIgnoreCase(radioValue)){
	  strRadioSql+=" and t.LOGIN_GROUP_ID like ''||:selectedItemId||'%' ";
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


}
%>

<%

  HashMap datamap = new HashMap();
  /*
  for(int j=0;j<selectNos.length;j++){
  		datamap.put(selectNos[j][0],selectNos[j][0]);
  }
  */
  StringBuffer returnStr = new StringBuffer();
  returnStr.append("<TABLE id='dataTable' border='0' height='420' style='font-size:12px;'><tr>");
  int m = 0;
  int flag_ = 0;
  boolean hasTd = false;
	for (int i = 0; i < selectNos.length; i++) {
	m = flag_%500;
	if(flag_==0||m==0){
			if(flag_!=0){
					returnStr.append("</td>");
			}
			returnStr.append("<td vAlign='top' width='160px' class='title_zi' height='420'>");
			hasTd =true;
	}

  		returnStr.append("<input type='checkbox' checked='checked' isgroup='true' name='serialNo'  value='"+selectNos[i][0]+"' onclick='checked=!checked' /><span class='item_a'>"+selectNos[i][0]+"</span><br/>");
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
