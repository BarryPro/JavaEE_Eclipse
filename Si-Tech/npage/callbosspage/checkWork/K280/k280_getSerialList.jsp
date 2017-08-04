<%
  /*
   * 功能: 质检权限管理->维护被检工号和组->获取流水号
　 * 版本: 1.0.0
　 * 日期: 2009/11/04
　 * 作者: zengzq
　 * 版权: sitech
   * update:
   *
　 */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%!
		//折半法查找，无递归，未使用
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
  /*midify by guozw 20091114 公共查询服务替换*/
 String myParams="";
 String org_code = (String)session.getAttribute("orgCode");
 String regionCode = org_code.substring(0,2);

String selectedItemId = WtcUtil.repNull(request.getParameter("selectedItemId"));
String checkBoxValue =  WtcUtil.repNull(request.getParameter("checkBoxValue"));
String radioValue =  WtcUtil.repNull(request.getParameter("radioValue"));
String strRadioSql="select t.serialNo from DqcCheckedSerialNos t where 1=1 and t.VALID_FLAG='Y' ";
String[][] selectNos = {};


//如果这个条件为空，则查不到记录
if(!"".equalsIgnoreCase(checkBoxValue)){
//选择显示未选,需要查询已选本组工号或本组以下节点工号，并过滤掉这些工号信息

if("self".equalsIgnoreCase(radioValue)){
	  strRadioSql+=" and t.LOGIN_GROUP_ID = :selectedItemId";
	  myParams = "selectedItemId="+selectedItemId ;
}
if("selfAndSub".equalsIgnoreCase(radioValue)){
	  strRadioSql+=" and t.LOGIN_GROUP_ID like ''||:selectedItemId||'%' ";
	  myParams = "selectedItemId="+selectedItemId ;
}

//按照条件查询出该组节点下面的工号
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
