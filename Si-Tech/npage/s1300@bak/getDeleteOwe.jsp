<%
/********************
 version v2.0
 开发商: si-tech
 模块：陈帐.死帐回收
 update zhaohaitao at 2008.12.29
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>	
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.util.MoneyUtil"%>
 
<%@ page import="java.text.*" %

<script language="JavaScript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>

<%		
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arr.get(0);
	String work_no = baseInfo[0][2];                               //工号
	String org_code = baseInfo[0][16];                             //机构代码  
	String region_code = org_code.substring(0,2);                  //市级
	String district_code = org_code.substring(2,4);                //区级
	
	String phoneNo = request.getParameter("phone_no");
    String idNo = request.getParameter("id_no");
    String returnPage = request.getParameter("returnPage");
	
	String[] inParas = new String[]{""};
	String[][] result_new = new String[][]{};
	String[][] result_new1 = new String[][]{};
 
	 
 

	String sm_code = "";
	String row_count = "0";
	String error_no = "000000";
	String error_message = "";
	
	//联系信息
    String region_name = "";
    String district_name = "";
	String owner_name = "";
	String use_time = "";
	String delete_time = "";
	String owner_idno = "";
	String owner_phone = "";
	String owner_unit = "";
	String owner_address = "";
	String owner_zip = "";
	String contact_person = "";
	String contact_phone = "";
	String contact_idno = "";
    
	if (phoneNo.startsWith("9")) {
	   sm_code="tn";
	} else if (phoneNo.startsWith("13")  || phoneNo.startsWith("15")  || phoneNo.startsWith("20")
		/*xl 20110308 申告需求*/
		|| phoneNo.startsWith("18")
		) {
	   sm_code="gn";
	}
	
	if (sm_code.equals("gn")) {
	    inParas[0] = "select to_char(count(*)) from  tnd_delete_owe"+
                     " where phone_no='"+phoneNo+"'";
	} else if (sm_code.equals("tn")) {
	    inParas[0] = "select to_char(count(*)) from  tna_delete_owe"+
                     " where phone_no='"+phoneNo+"'";
	}
   %>
   <wtc:service name="TlsPubSelBoss" retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:param value="<%=inParas[0]%>"/>
	</wtc:service>
	<wtc:array id="result2" scope="end" />

   <%
 
    
	if (result2.length != 0) {
	   row_count = result2[0][0];
	}

	if (row_count.equals("0")) {
       error_no = "0";
       error_message = "该用户欠费信息不存在,请在确认后重新输入";
    } else {
         if (sm_code.equals("gn")) {
	        inParas[0] = "select region_name,\n" +
                         "       district_name,\n" + 
                         "       owner_name,\n" + 
                         "       to_char(use_time,'YYYY-MM-DD HH24:MI:SS'),\n" + 
                         "       to_char(delete_time,'YYYY-MM-DD'),\n" + 
                         "       owner_idno,\n" + 
                         "       owner_phone,\n" + 
                         "       owner_unit,\n" + 
                         "       owner_address,\n" + 
                         "       owner_zip,\n" + 
                         "       contact_person,\n" + 
                         "       contact_phone,\n" + 
                         "       contact_idno\n" + 
                         "from  tnd_delete_owe\n" + 
                         "where phone_no='"+ phoneNo +"'\n" + 
                         "      and id_no= "+ idNo +"\n" + 
                         "group by  region_name,district_name,owner_name,use_time,delete_time,\n" + 
                         "          owner_idno,owner_phone,owner_unit,owner_address,owner_zip,\n" + 
                         "          contact_person,contact_phone,contact_idno";
	      } else if (sm_code.equals("tn")) {
	         inParas[0] = "select region_name,\n" +
                          "       district_name,\n" + 
                          "       owner_name,\n" + 
                          "       to_char(use_time,'YYYY-MM-DD HH24:MI:SS'),\n" + 
                          "       to_char(delete_time,'YYYY-MM-DD'),\n" + 
                          "       owner_idno,\n" + 
                          "       owner_phone,\n" + 
                          "       owner_unit,\n" + 
                          "       owner_address,\n" + 
                          "       owner_zip,\n" + 
                          "       contact_person,\n" + 
                          "       contact_phone,\n" + 
                          "       contact_idno\n" + 
                          "from  tna_delete_owe\n" + 
                          "where phone_no='"+ phoneNo +"'\n" + 
                          "      and id_no="+ idNo +"\n" + 
                          "group by region_name,district_name,owner_name,use_time,delete_time,owner_idno,owner_phone,\n" + 
                          "         owner_unit,owner_address,owner_zip,contact_person,contact_phone,contact_idno";
	      }
%>
		<wtc:service name="TlsPubSelBoss" retcode="retCode2" retmsg="retMsg2" outnum="13">
			<wtc:param value="<%=inParas[0]%>"/> 
		</wtc:service>
		<wtc:array id="result3" scope="end" />


<%
 
		  
		  if (result3.length != 0) {
		      region_name = result3[0][0];
              district_name = result3[0][1];
	          owner_name = result3[0][2];
	          use_time = result3[0][3];
	          delete_time = result3[0][4];
	          owner_idno = result3[0][5];
	          owner_phone = result3[0][6];
	          owner_unit = result3[0][7];
	          owner_address = result3[0][8];
	          owner_zip = result3[0][9];
	          contact_person = result3[0][10];
	          contact_phone = result3[0][11];
	          contact_idno = result3[0][12];
          }
          
		  if (sm_code.equals("gn")) {
			   inParas[0] = "select to_char(a.bill_year),   --欠费年\n" +
                            "       to_char(a.bill_month),  --欠费月\n" + 
                            "       to_char(a.owe_money),   --欠费金额\n" + 
                            "       to_char(nvl(b.cash_pay,0.00)),    --已收回金额\n" + 
                            "       case a.payed_status when '0' then '欠费' else '不欠费' end --欠费状态\n" + 
                            "from tnd_delete_owe a,tnd_delete_pay b\n" + 
                            "where a.phone_no = '"+ phoneNo +"'\n" + 
                            "      and a.id_no = "+ idNo +"\n" + 
                            "      and a.phone_no = b.phone_no(+)\n" + 
                            "      and a.id_no = b.id_no(+)\n" + 
                            "      and a.bill_year = b.bill_year(+)\n" + 
                            "      and a.bill_month = b.bill_month(+)\n" + 
                            "order by a.payed_status,a.bill_year,a.bill_month";
          } else if (sm_code.equals("tn")) {
		        inParas[0] = "select to_char(a.bill_year),   --欠费年\n" +
                             "       to_char(a.bill_month),  --欠费月\n" + 
                             "       to_char(a.owe_money),   --欠费金额\n" + 
                             "       to_char(nvl(b.cash_pay,0.00)),    --已收回金额\n" + 
                             "       case a.payed_status when '0' then '欠费' else '不欠费' end --欠费状态\n" + 
                             "from tna_delete_owe a,tna_delete_pay b\n" + 
                             "where a.phone_no = '"+ phoneNo +"'\n" + 
                             "      and a.id_no = "+ idNo +"\n" + 
                             "      and a.phone_no = b.phone_no(+)\n" + 
                             "      and a.id_no = b.id_no(+)\n" + 
                             "      and a.bill_year = b.bill_year(+)\n" + 
                             "      and a.bill_month = b.bill_month(+)\n" + 
                             "order by a.payed_status,a.bill_year,a.bill_month";
		 }
%>
		<wtc:service name="TlsPubSelBoss" retcode="retCode4" retmsg="retMsg4" outnum="5">
			<wtc:param value="<%=inParas[0]%>"/> 
		</wtc:service>
		<wtc:array id="result" scope="end" />

<%		  
		result_new = result;
		 if(sm_code.equals("gn")){
			inParas[0] = "select " +  
                             "case when floor(sysdate-add_months(to_date(a.bill_year*10000+a.bill_month*100+1+20,'YYYYMMDD'),14))>=0 then to_char(round(floor(add_months(to_date(a.bill_year*10000+a.bill_month*100+1+20,'YYYYMMDD'),14)-add_months(to_date(a.bill_year*10000+a.bill_month*100+1+20,'YYYYMMDD'),2))*a.owe_money*0.003,2)) else to_char(round(((sign(sign(floor(sysdate-add_months(to_date(a.bill_year*10000+a.bill_month*100+1+20,'YYYYMMDD'),2)))-1)+1)*floor(sysdate-add_months(to_date(a.bill_year*10000+a.bill_month*100+1+20,'YYYYMMDD'),2))*0.003*a.owe_money),2)) end  --欠费合计\n" + 
                             "from tnd_delete_owe a,tna_delete_pay b\n" + 
                             "where a.phone_no = '"+ phoneNo +"'\n" + 
                             "      and a.id_no = "+ idNo +"\n" + 
                             "      and a.phone_no = b.phone_no(+)\n" + 
                             "      and a.id_no = b.id_no(+)\n" + 
                             "      and a.bill_year = b.bill_year(+)\n" + 
                             "      and a.bill_month = b.bill_month(+)\n" + 
                             "order by a.payed_status,a.bill_year,a.bill_month";
		 }else if(sm_code.equals("tn")){
			inParas[0] = "select case when floor(sysdate-add_months(to_date(a.bill_year*10000+a.bill_month*100+1+20,'YYYYMMDD'),14))>=0 then to_char(round(floor(add_months(to_date(a.bill_year*10000+a.bill_month*100+1+20,'YYYYMMDD'),14)-add_months(to_date(a.bill_year*10000+a.bill_month*100+1+20,'YYYYMMDD'),2))*a.owe_money*0.003,2)) else to_char(round(((sign(sign(floor(sysdate-add_months(to_date(a.bill_year*10000+a.bill_month*100+1+20,'YYYYMMDD'),2)))-1)+1)*floor(sysdate-add_months(to_date(a.bill_year*10000+a.bill_month*100+1+20,'YYYYMMDD'),2))*0.003*a.owe_money),2)) end   --欠费合计\n" + 
                             "from tna_delete_owe a,tna_delete_pay b\n" + 
                             "where a.phone_no = '"+ phoneNo +"'\n" + 
                             "      and a.id_no = "+ idNo +"\n" + 
                             "      and a.phone_no = b.phone_no(+)\n" + 
                             "      and a.id_no = b.id_no(+)\n" + 
                             "      and a.bill_year = b.bill_year(+)\n" + 
                             "      and a.bill_month = b.bill_month(+)\n" + 
                             "order by a.payed_status,a.bill_year,a.bill_month";
		 }
	%>
		<wtc:service name="TlsPubSelBoss" retcode="retCode6" retmsg="retMsg6" outnum="1">
			<wtc:param value="<%=inParas[0]%>"/> 
		</wtc:service>
		<wtc:array id="result1" scope="end" />

	<%	 
		result_new1 = result1;
   } 
%>
<SCRIPT type="text/javascript">
function ifprint(){
     <%if (error_no.equals("000000")){%>
           document.mainForm.submit();
	 <%} else if (error_no.equals("0")) {%>
           rdShowMessageDialog("<%=error_message%>");
	       document.location.replace("s1378.jsp");
     <%}%>
} 						
</SCRIPT>
<html>
<body onload="ifprint()">   
<form action='<%=returnPage%>' method="post" name='mainForm'>
  <%if (!row_count.equals("0")) {%>
     <input type="hidden" name="phone_no"  value="<%=phoneNo%>">
     <input type="hidden" name="id_no"  value="<%=idNo%>">
     <input type="hidden" name="region_name"  value="<%=region_name%>">
     <input type="hidden" name="district_name"  value="<%=district_name%>">
     <input type="hidden" name="owner_name"  value="<%=owner_name%>">
     <input type="hidden" name="use_time"  value="<%=use_time%>">
     <input type="hidden" name="delete_time"  value="<%=delete_time%>">
     <input type="hidden" name="owner_idno"  value="<%=owner_idno%>">
     <input type="hidden" name="owner_phone"  value="<%=owner_phone%>">
     <input type="hidden" name="owner_unit"  value="<%=owner_unit%>">
     <input type="hidden" name="owner_address"  value="<%=owner_address%>">
     <input type="hidden" name="owner_zip"  value="<%=owner_zip%>">
     <input type="hidden" name="contact_person"  value="<%=contact_person%>">
     <input type="hidden" name="contact_phone"  value="<%=contact_phone%>">
     <input type="hidden" name="contact_idno"  value="<%=contact_idno%>">
     <input type="hidden" name="sm_code"  value="<%=sm_code%>">
	 <input type="hidden" name="delete_own_count"  value="<%=result_new.length%>">
     <%
		 System.out.println("aaaaaaaaaaaaaaaaaaaaa result_new.length is "+result_new.length+" and result_new1.length is "+result_new1.length+" and result_new[0][4] is "+result_new[0][4]+" result_new[0][2] is "+result_new[0][2]);
		 for (int i = 0; i < result_new.length; i++) {
		 //for (int i = 0; i < result_new1.length; i++) {
		 String aa=(new DecimalFormat("0.00")).format(Double.parseDouble(result_new1[i][0])+Double.parseDouble(result_new[i][2]));
		 System.out.println("test 11111111111111111111111111 result_new[i][2] is "+ result_new[i][2]+" and i is "+i);
	 %>
		
		<input type="hidden" name="bill_year<%=i%>"  value="<%=result_new[i][0]%>">
         <input type="hidden" name="bill_month<%=i%>"  value="<%=result_new[i][1]%>">
         <input type="hidden" name="owe_money<%=i%>"  value="<%=result_new[i][2]%>">
	     <input type="hidden" name="late_fee<%=i%>"  value="<%=result_new1[i][0]%>">
		 <input type="hidden" name="owe_money_total<%=i%>"  value="<%=aa%>">
	     <input type="hidden" name="cash_pay<%=i%>"  value="<%=result_new[i][3]%>">
	     <input type="hidden" name="payed_status<%=i%>"  value="<%=result_new[i][4]%>">
     <%}%>  
  <%}%>
</form>
</body>
</html>
