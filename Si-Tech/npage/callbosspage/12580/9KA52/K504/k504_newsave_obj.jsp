<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*,java.text.SimpleDateFormat"%>

<%!
public String getCurrDateStr(){
   
   Calendar c = Calendar.getInstance();
   Date date = c.getTime();
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd' 'HH:mm:ss");
   String  startTime = sdf.format(date);
   
   return startTime;   
}

%>
<% 
  String sqlStr = "select SEQ_12580.nextval from dual"; 
%>
<wtc:service name="s151Select" outnum="1">
	<wtc:param value="<%=sqlStr%>"/>
</wtc:service>
<wtc:array id="queryList"  scope="end"/>
<%
  String workNo = (String)session.getAttribute("workNo");

  String phone_name=request.getParameter("phone_name")==null?"":request.getParameter("phone_name");
  String phone_mainnum=request.getParameter("phone_mainnum")==null?"":request.getParameter("phone_mainnum");
  String phone_fax=request.getParameter("phone_fax")==null?"":request.getParameter("phone_fax");
  String phone_qq=request.getParameter("phone_qq")==null?"":request.getParameter("phone_qq");
  String phone_email=request.getParameter("phone_email")==null?"":request.getParameter("phone_email");
  String phone_sxe=request.getParameter("phone_sxe")==null?"":request.getParameter("phone_sxe");
  String phone_age=request.getParameter("phone_age")==null?"":request.getParameter("phone_age");
  String phone_unit=request.getParameter("phone_unit")==null?"":request.getParameter("phone_unit");
  String phone_note=request.getParameter("phone_note")==null?"":request.getParameter("phone_note");
  String ACCEPT_NO = request.getParameter("ACCEPT_NO")==null?"":request.getParameter("ACCEPT_NO");
  String objArray = request.getParameter("objArray")==null?"":request.getParameter("objArray");
  
  String ssSql = "select 'x' from DPHONLIST where ACCEPT_NO = '"+ACCEPT_NO+"' and PERSON_PHONE ='"+phone_mainnum+"' and PERSON_TYPE = '1'";
  %>
  <wtc:service name="s151Select" outnum="1">
	<wtc:param value="<%=ssSql%>" />
	</wtc:service>
	<wtc:array id="queryList5" scope="end" />
  <%
  if(queryList5.length>0){
  
  %>
  	var response = new AJAXPacket();
		response.data.add("retCode","22222");
		core.ajax.receivePacket(response);
  <%
  }else{
  
  String arySql[] = new String[]{};
  List arrayList = new ArrayList();  
  String GRP_SERIAL_NO[] = objArray.split(",");//群组流水号
  
  String nowTime = getCurrDateStr();
  //DPHONLIST个人电话本表
  String strInSql = "insert into DPHONLIST (ACCEPT_NO,PERSON_NAME,PERSON_PHONE,PERSON_FAX,PERSON_QQ,PERSON_EMAIL,PERSON_SEX,PERSON_BIRTH,PERSON_UNIT,PERSON_DESCR,CREATE_TIME,SERIAL_NO,PERSON_TYPE,CREATE_LOGIN_NO,SOURCE_FLAG) " 
                   +" values('"+ACCEPT_NO+"','"+phone_name+"','"+phone_mainnum+"','"+phone_fax+"','"+phone_qq+"','"+phone_email+"','"+phone_sxe+"','"+phone_age+"','"+phone_unit+"','"+phone_note+"','"+nowTime+"','"+queryList[0][0]+"','1','"+workNo+"','B')";
  
  arrayList.add(strInSql);
  
  if(GRP_SERIAL_NO.length>0){
  //DMSGGRPPHONLIST群组电话本表
  	String strDELSQL = "delete from DMSGGRPPHONLIST where LIST_SERIAL_NO = '"+queryList[0][0]+"'";
  	arrayList.add(strDELSQL);
  	for(int i =0;i<GRP_SERIAL_NO.length;i++){
  		
  		//String aSql = "select nvl(count(LIST_SERIAL_NO),0),b.GRP_NAME from DMSGGRPPHONLIST a left join DMSGGRP b on b.SERIAL_NO =a.GRP_SERIAL_NO where GRP_SERIAL_NO = '"+GRP_SERIAL_NO[i]+"' group by b.GRP_NAME";
      //chengh 修改sql
      //String aSql = "select nvl(count(LIST_SERIAL_NO),0),b.GRP_NAME from DMSGGRPPHONLIST a right join DMSGGRP b on b.SERIAL_NO =a.GRP_SERIAL_NO where b.GRP_NAME =(select grp_name from DMSGGRP where serial_no='"+GRP_SERIAL_NO[i]+"') group by b.GRP_NAME";
      String aSql = "select count(*) from (select a.LIST_SERIAL_NO aa,b.GRP_NAME bb from DMSGGRPPHONLIST a left join DMSGGRP b on b.SERIAL_NO =a.GRP_SERIAL_NO where b.serial_no='"+GRP_SERIAL_NO[i]+"') c";
%>
<wtc:service name="s151Select" outnum="2">
	<wtc:param value="<%=aSql%>" />
</wtc:service>
<wtc:array id="queryLista" scope="end" />
<% 
    
	//新建个人电话本选中群组而在群组信息表中有数据 chengh 屏蔽该判断
	if(queryLista.length>0){
    if(Integer.parseInt(queryLista[0][0])>=20){
	
				%>
				var response = new AJAXPacket(); 
				response.data.add("retCode","55555");
				response.data.add("GRP_NAME","有");
				core.ajax.receivePacket(response);
				<%    
        return;
    }
    //新建个人电话本选中群组而在群组信息表中有数据 chengh 屏蔽该判断
    else {
    	
  		   if(GRP_SERIAL_NO[i]!=null&&!"".equals(GRP_SERIAL_NO[i])){
	  		    String strInGRPSql = "insert into DMSGGRPPHONLIST (LIST_SERIAL_NO,GRP_SERIAL_NO,CREATE_TIME,CREATE_LOGIN_NO) values('"+queryList[0][0]+"','"+GRP_SERIAL_NO[i]+"','"+nowTime+"','"+workNo+"')";
	  		    arrayList.add(strInGRPSql);
  		   }
 		  }
 		 }
 		}     
  }
             
  arySql = (String [])arrayList.toArray(new String[arrayList.size()]);
  
  
%>
<wtc:service name="sKFModify"  outnum="2">
<wtc:params value="<%=arySql%>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>
var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);
<%} %>
