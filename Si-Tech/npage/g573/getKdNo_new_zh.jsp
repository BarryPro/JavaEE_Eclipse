<%
/********************
 version v2.0
开发商: si-tech
*******************
xl 新增修改操作
增加对输入宽带号码 -->phone_no的判断 并将phone_no对应的contract_no输出

*/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
            //得到输入参数
    String contractNo= "";
    String phone_kd  = WtcUtil.repStr(request.getParameter("contractNo")," "); 
	
	String busy_type = WtcUtil.repStr(request.getParameter("busyType")," ");
   	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	//String sql_kd = "select trim(to_char(new_phoneno)) from dbbillprg.s_rs_iot_phonenoswitch_info where old_phoneno = '?' ";
	//上线时得改成带属主的
	//增加判断品牌 非PB不可以办理 得用union 判断转义和非转义的
	String sql_kd = "";
	String s_sm_code="";
	String s_run_code=""; 
	String return_page = WtcUtil.repStr(request.getParameter("return_page")," ");
	System.out.println("TAAAAAAAAAAAAAAAAATTTTTTTTTTTTTTT sql_kd is "+sql_kd+" and phone_kd is "+phone_kd);
	//lidsa 进行转换 通过phone_kd进行转换；
	/*
		10648开头号码将以205开头形式存在dcustres等相关号码表中，用来将13位号码转换成11位号码。 例如：物联网号码：1064801234567 ---》  20501234567
		147开头号码将以206开头形式存在dcustres等相关号码表中，用来和已有147号码进行区分。 例如：物联网号码：14701234567 ---》  20601234567
	*/
	String[] inParas1 =new String[2];
	inParas1[0]="select trim(to_char(a.phone_no)),trim(to_char(c.old_phoneno)),trim(a.sm_code),substr(run_code,2,1) from dcustmsg a,dconusermsg b,dbbillprg.s_rs_iot_phonenoswitch_info c where a.id_no=b.id_no and b.contract_no=:s_no and trim(c.new_phoneno)=trim(a.phone_no) union all select trim(d.phone_no), trim(d.phone_no), trim(d.sm_code) ,substr(d.run_code,2,1)  from dcustmsg d,dconmsg e,dconusermsg f  where d.id_no = f.id_no and e.contract_no = f.contract_no  and e.contract_no = :s_contract_now  "; 
	inParas1[1]="s_no="+phone_kd+",s_contract_now="+phone_kd;
%>
	<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode12" retmsg="retMsg12" outnum="4">
		<wtc:param value="<%=inParas1[0]%>"/>
		<wtc:param value="<%=inParas1[1]%>"/>
	</wtc:service> 
	<wtc:array id="result12" scope="end" />
<%
	String phone_new="";
	String phone_old=""; 
	      
	if(result12!=null&&result12.length>0){
		        phone_new= (result12[0][0]).trim();
				phone_old= (result12[0][1]).trim();
				s_sm_code= (result12[0][2]).trim();
				s_run_code=(result12[0][3]).trim();
				%>
					//alert("q");
				<%
	 }else{
		      
	     %>
				    //alert("2");
					window.location.href="<%=return_page%>"; 
				 
		 <%
		 }

%>	
<%

    String retResult = "";   
    String sqlStr = "";
    String returnCode="";
	System.out.println("aaaaaaaaaaaaacontractNo is "+contractNo+" and phone_new is "+phone_new);
	System.out.println("bbbbbbbbbbbbb"+busy_type);

    String Pwd0 = "";
	  String Pwd1 = "";
	  String Pwd2 = "";
	  String Pwd3 = "";
	
	  String phone_out = "";
	  String contract_out = "";
	  System.out.println("eeeeeeeeeeeeeeeeeeeeeee"+busy_type+" and phone_new is "+phone_new);
	
	  retResult = "true" ;

%>
var response = new AJAXPacket  ();
var retResult = "<%=retResult%>";
var s_run_code = "<%=s_run_code%>";
var phone_new = "<%=phone_new%>";
var contract_out = "<%=contract_out%>";
var phone_old  = "<%=phone_old%>";
var s_sm_code = "<%=s_sm_code%>"; 
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("phone_old",phone_old);
response.data.add("retResult",retResult);
response.data.add("phone_new",phone_new);
response.data.add("contract_out",contract_out);
response.data.add("s_sm_code",s_sm_code);
response.data.add("s_run_code",s_run_code);
core.ajax .receivePacket(response);
<%System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");%>


 
