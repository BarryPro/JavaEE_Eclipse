 <%
	/********************
	 version v2.0
	������: si-tech
	update:zhangshuaia@2009-08-10 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page language="java" import="java.sql.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>

<html>
	<head> 
	<title>Ͷ���˷ѹ���</title>
	<%@ include file="../../npage/s4140/head_4141_1_javascript.htm" %>
<%
  	String opCode = "4141";		
	String opName = "Ͷ���˷ѹ���";	//header.jsp��Ҫ�Ĳ���
	
	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
	
	String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);
	//xl add for ����
//	regionCode="13";
    String groupId = (String)session.getAttribute("groupId");
    //xl add for 800001
	String region_code_new="";
	//work_no="aaa831";
	//work_no="800187";
	//regionCode="90";
	/*
	if((work_no=="800001" ||work_no.equals("800001")) ||(work_no=="800232" ||work_no.equals("800232")) ||(work_no=="800193" ||work_no.equals("800193")) ||(work_no=="800138" ||work_no.equals("800138")) ||(work_no=="800219" ||work_no.equals("800219")) ||(work_no=="800190" ||work_no.equals("800190"))||(work_no=="800200" ||work_no.equals("800200"))||(work_no=="800187" ||work_no.equals("800187"))||(work_no=="800195" ||work_no.equals("800195")) )
	{
		region_code_new="01";
	}
	else
	{
		region_code_new=regionCode;
	}*/
	region_code_new=regionCode;
	//xl add ��ѯ�����޶� begin
	int i_login_count=0;
	String[] inPara2 = new String[2];
	inPara2[0]="select to_char(count(*)) from shighlogin_boss where login_no=:s_login_no and op_code='zgau' ";
	inPara2[1]="s_login_no="+work_no;
	%>
	<wtc:service name="TlsPubSelBoss" retcode="retCode1count" retmsg="retMsg1count" outnum="1">
		<wtc:param value="<%=inPara2[0]%>"/>
		<wtc:param value="<%=inPara2[1]%>"/>
	</wtc:service>
	<wtc:array id="ret_val_count" scope="end" />
	<%
	if(ret_val_count.length>0)
	{
		i_login_count=Integer.parseInt(ret_val_count[0][0]);
	}
	//end of ��ѯ�����޶�
	//region_code_new="90";
	//xl add find . -type f -name "*.jsp"| xargs grep -i getRealPath
	String str_path = request.getRequestURL().toString()    ;
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa str_path is "+str_path);
	String path = str_path.replaceAll("s4140","zg96");
	path = path.replaceAll("f4141.jsp","zg96_1.jsp");
	System.out.println("afterfffffffffffffffffffffffffffffff str_path is "+path);

    String str1 = "39";
	String str1_param="s_code="+regionCode;
	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa "+str1);
	//String time_sql = "select to_char(sysdate,'YYYYMMDD hh24:mi:ss') from dual";
	String time_sql = "40";
%>
	 <wtc:service name="sBossDefSqlSel"  routerKey="region" routerValue="<%=regionCode%>" outnum="2">
		<wtc:param value="<%=str1%>"/> 
		<wtc:param value="<%=str1_param%>"/>
	  </wtc:service>
	<wtc:array id="returnStr1" scope="end" /> 
	
   	<wtc:service name="sBossDefSqlSel"  routerKey="region" routerValue="<%=regionCode%>" outnum="1">
		<wtc:param value="<%=time_sql%>"/> 
	  </wtc:service>
  	<wtc:array id="returnTime" scope="end" /> 
  		
  

	<wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
    String sysAccept = seq;
    System.out.println("sysAccept="+sysAccept);

//String checkSql = "select root_distance from dChnGroupMsg where group_id = '"+groupId+"'";
    String checkSql ="41";
	String checkSql_param="s_group_id="+groupId;
%>
		<wtc:service name="sBossDefSqlSel" routerKey="region"  routerValue="<%=regionCode%>" outnum="1"> 
			<wtc:param value="<%=checkSql%>"/> 
			<wtc:param value="<%=checkSql_param%>"/>
		</wtc:service>
		<wtc:array  id="sVerifyTypeArr"  scope="end"/>
<%
		/**����loginRootDistance���жϹ���Ȩ������**/
		int loginRootDistance = 999999;
		if(retCode.equals("000000")){
			if(sVerifyTypeArr!=null&&sVerifyTypeArr.length>0){
				loginRootDistance = sVerifyTypeArr[0][0].equals("")?loginRootDistance:Integer.parseInt(sVerifyTypeArr[0][0]);
			}
		}		
%>
<%
	String sqlCheckType = "42";
	String sqlBillType="43";
	//new ��������
	//String sqlIvrCheck="select first_code,first_name from sivrcheck where valid_flag='0'";
%>
	<wtc:service name="sBossDefSqlSel"  outnum="2" >
		<wtc:param value="<%=sqlCheckType%>"/> 
	  </wtc:service>
	<wtc:array id="sCheckTypeStr" scope="end"/>
	
	<wtc:service name="sBossDefSqlSel"  outnum="2" >
		<wtc:param value="<%=sqlBillType%>"/> 
	  </wtc:service>
	<wtc:array id="sBillTypeStr" scope="end"/>
<!--20091220 begin -->
	<!--��������-->
 
<%
	String contextPath = request.getContextPath();
%>
<!--xl add for zhangshuo-->
<%
		String[] inParas2 = new String[2];
		inParas2[0]="44";
		inParas2[1]="login_no="+work_no;
%>
		<wtc:service name="sBossDefSqlSel" retcode="retCode1" retmsg="retMsg1" outnum="1">
			<wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>
		</wtc:service>
		<wtc:array id="ret_val" scope="end" />
<%
	    String[] inParas2_new = new String[1];
		inParas2_new[0]="45";

		String[] inParas2_region = new String[1];
		inParas2_region[0]="";
%>

		<wtc:service name="sBossDefSqlSel" retcode="retCode2" retmsg="retMsg2" outnum="2">
			<wtc:param value="<%=inParas2_new[0]%>"/> 
		</wtc:service>
		<wtc:array id="ret_val_new" scope="end" />
<link href="<%= contextPath %>/css/sc.css" rel="stylesheet" type="text/css">
<SCRIPT language="JavaScript" src="<%= contextPath %>/js/common/date/iOffice_Popup.js"></SCRIPT>
<SCRIPT language="JavaScript" src="<%= contextPath %>/js/common/redialog_res/redialog.js"></SCRIPT>
<SCRIPT language="JavaScript" src="<%= contextPath %>/js/common/common_check.js"></SCRIPT>
<SCRIPT language="JavaScript" src="<%= contextPath %>/js/common/common_util.js"></SCRIPT>

<script language=javascript>
//xl add for fanyan sp��ѯ�굥
function getxdMsg()
{
		var phone_no=document.all.phoneno1.value;
		//alert("phone_no is "+phone_no);
		if(phone_no=="")
		{
			rdShowMessageDialog("������Ʒ��û�����!");
			return false;
		}
		else
		{
			/*
			win=parent.addTab(true,'zg96','����������ҵ���굥��ѯ','10.110.0.121:11000/npage/zg96/zg96_1.jsp?opCode=zg96&opName=����������ҵ���굥��ѯ&crmActiveOpCode=zg96&activePhone='+phone_no+'&broadPhone=');
			parent.removeTab("zg96");
			win=parent.addTab(true,'zg96','����������ҵ���굥��ѯ','10.110.0.121:11000/npage/zg96/zg96_1.jsp?opCode=zg96&opName=����������ҵ���굥��ѯ&crmActiveOpCode=zg96&activePhone='+phone_no+'&broadPhone=');
			*/
			win=parent.addTab(true,'zg96','����������ҵ���굥��ѯ','<%=path%>?opCode=zg96&opName=����������ҵ���굥��ѯ&crmActiveOpCode=zg96&activePhone='+phone_no+'&broadPhone=');
			parent.removeTab("zg96");
			win=parent.addTab(true,'zg96','����������ҵ���굥��ѯ','<%=path%>?opCode=zg96&opName=����������ҵ���굥��ѯ&crmActiveOpCode=zg96&activePhone='+phone_no+'&broadPhone=');
			//win.reload();
			//alert("end"+"<%=path%>");
		}
		
}
function fPopUpCalendarDlg(ctrlobj)
{
	if(N)
	{
		showx = 220 ; // + deltaX;
		showy = 220; // + deltaY;
	}
	else
	{
		showx = event.screenX - event.offsetX - 4 - 210 ; // + deltaX;
		showy = event.screenY - event.offsetY + 18; // + deltaY;
	}
	newWINwidth = 210 + 4 + 18;
	if(N)
	{
		window.top.captureEvents (Event.CLICK|Event.FOCUS);
		window.top.onclick=IgnoreEvents;
		window.top.onfocus=HandleFocus;
		winPopupWindow.args = ctrlobj;
		winPopupWindow.returnedValue = new Array();
		winPopupWindow.args = ctrlobj;
		newWINwidth = 202;
		winPopupWindow.win = window.open("/js/common/date/CalendarDlg.htm","CalendarDialog","dependent=yes,left="+showx + ",top=" + showy + ",width="+newWINwidth + ",height=182px" )
		winPopupWindow.win.focus()
		return winPopupWindow;
	}
	else
	{
		retval = window.showModalDialog("/js/common/date/CalendarDlg.htm", "", "dialogWidth:197px; dialogHeight:210px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:no; directories:yes;scrollbars:no;Resizable=no; ");
	}
	if(retval != null)
	{
		ctrlobj.value = retval;
	}
	else
	{
		//alert("canceled");
	}
}
</script>
<!--20091220 end -->


<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
<script language=javascript>
onload=function()
{
//	document.all.confirm.focus();
	self.status="";
	document.all.ivrcheck.disabled=true;
 
}	
	
function qryChg()
{
	if(document.all.qryFlag[0].checked==true)
	{
		//alert("1");
		document.getElementById("qryValue").value="1";
	}
	else
	{
		//alert("2");
		document.getElementById("qryValue").value="2";
	}
}
		//----------------��֤���ύ����-----------------
function opchange()
{
	if(document.all.opFlag[0].checked==true) 
	{
		document.all.inputinfo_id.style.display = "none";
		
		document.all.add_no.style.display = "";
		document.all.add_type.style.display = "";
		document.all.add_FirstClass.style.display = "";
		document.all.add_SecondClass.style.display = "";
		document.all.add_mon.style.display = "";
		document.all.add_note.style.display = "";
		
		document.all.add_no3.style.display = "none";
		document.all.add_time3.style.display = "none";
		document.all.add_3.style.display = "none";
		document.all.khyy_note.style.display = "none";
		if(document.all.backMoney.value == "")
		{
			document.all.confirm.disabled=true;
		}
		//��������
		document.all.sptime6.style.display = "none";
		//zhangshuo
		document.all.query_all.style.display = "none";
		document.all.query_all_new.style.display = "none";
		document.all.check_all.style.display = "none";
		document.all.check_all_new.style.display = "none";
		//xl add for gongjian
		document.all.spname_show.style.display = "none";
		
		
	}
	else if(document.all.opFlag[1].checked==true)
	{
	//	alert("1");//800107 801001 800227 800219 800294 800236   ֻ���80��ͷ�Ĺ��Ų���������
		if("<%=work_no.substring(0,2)%>"==80)
		{
			//alert("�ͷ������ж�");
			if("<%=work_no%>"=="801001"||"<%=work_no%>"=="800107" ||"<%=work_no%>"=="800227" ||"<%=work_no%>"=="800219" ||"<%=work_no%>"=="800294" ||"<%=work_no%>"=="800236")
			{
				document.all.inputinfo_id.style.display = "block";
			
				document.all.add_no.style.display = "none";
				document.all.add_type.style.display = "none";
				document.all.add_FirstClass.style.display = "none";
				document.all.add_SecondClass.style.display = "none";
				document.all.spinfo.style.display = "none";
				document.all.sptime1.style.display = "none";
				document.all.sptime2.style.display = "none";
				document.all.add_mon.style.display = "none";
				document.all.add_note.style.display = "none";
				
				document.all.add_no3.style.display = "none";
				document.all.add_time3.style.display = "none";
				document.all.add_3.style.display = "none";
				
				document.all.confirm.disabled=false;
				//new xl
				document.all.sptime3.style.display = "none";
				document.all.sptime4.style.display = "none";
				document.all.sptime5.style.display = "none";
				//��������
				document.all.sptime6.style.display = "none";
				//zhangshuo
				document.all.query_all.style.display = "none";
				document.all.query_all_new.style.display = "none";
				document.all.check_all.style.display = "none";
				document.all.check_all_new.style.display = "none";
				//xl add for gongjian
				document.all.spname_show.style.display = "none";
				document.all.khyy_note.style.display = "none";
			}
			else
			{
				rdShowMessageDialog("��ָ�����Ų����Խ����˷ѳ���!");
				var radio_oj=document.all.opFlag;
				for(var i=0;i<radio_oj.length;i++)  
				{
					//alert("test "+radio_oj[i].value);
					if(radio_oj[i].value=="zero")  
					{ 
						radio_oj[i].checked=true; 
						opchange();
						break;  
					}
				}
			}
		}
		else
		{
			document.all.inputinfo_id.style.display = "block";
		
			document.all.add_no.style.display = "none";
			document.all.add_type.style.display = "none";
			document.all.add_FirstClass.style.display = "none";
			document.all.add_SecondClass.style.display = "none";
			document.all.spinfo.style.display = "none";
			document.all.sptime1.style.display = "none";
			document.all.sptime2.style.display = "none";
			document.all.add_mon.style.display = "none";
			document.all.add_note.style.display = "none";
			
			document.all.add_no3.style.display = "none";
			document.all.add_time3.style.display = "none";
			document.all.add_3.style.display = "none";
			
			document.all.confirm.disabled=false;
			//new xl
			document.all.sptime3.style.display = "none";
			document.all.sptime4.style.display = "none";
			document.all.sptime5.style.display = "none";
			//��������
			document.all.sptime6.style.display = "none";
			//zhangshuo
			document.all.query_all.style.display = "none";
			document.all.query_all_new.style.display = "none";
			document.all.check_all.style.display = "none";
			document.all.check_all_new.style.display = "none";
			//xl add for gongjian
			document.all.spname_show.style.display = "none";
			document.all.khyy_note.style.display = "none";
		}
		
		 
	}
	else if(document.all.opFlag[2].checked==true)
	{
		document.all.inputinfo_id.style.display = "none";
		
		document.all.add_no.style.display = "none";
		document.all.add_type.style.display = "none";
		document.all.add_FirstClass.style.display = "none";
		document.all.add_SecondClass.style.display = "none";
		document.all.spinfo.style.display = "none";
		document.all.sptime1.style.display = "none";
		document.all.sptime2.style.display = "none";
		document.all.add_mon.style.display = "none";
		document.all.add_note.style.display = "none";
		
		document.all.add_no3.style.display = "";
		document.all.add_time3.style.display = "";
		document.all.add_3.style.display = "";
		
		document.all.confirm.disabled=false;
		//new xl
		document.all.sptime3.style.display = "none";
		document.all.sptime4.style.display = "none";
		document.all.sptime5.style.display = "none";
		//��������
		document.all.sptime6.style.display = "none";
		//zhangshuo
		document.all.query_all.style.display = "none";
		document.all.query_all_new.style.display = "none";
		document.all.check_all.style.display = "none";
		document.all.check_all_new.style.display = "none";
		//test zhangshuo
		document.all.qryOprInfoFrame.style.display = "none";
		//xl add for gongjian
		document.all.spname_show.style.display = "none";
		document.all.khyy_note.style.display = "none";
		 
	}
	//zhangshuo
	else if(document.all.opFlag[3].checked==true)
	{
		//alert(" test is "+"<%=ret_val[0][0]%>");
		if("<%=ret_val[0][0]%>">=1)
		{
			document.all.inputinfo_id.style.display = "none";
		
			document.all.add_no.style.display = "none";
			document.all.add_type.style.display = "none";
			document.all.add_FirstClass.style.display = "none";
			document.all.add_SecondClass.style.display = "none";
			document.all.spinfo.style.display = "none";
			document.all.sptime1.style.display = "none";
			document.all.sptime2.style.display = "none";
			document.all.add_mon.style.display = "none";
			document.all.add_note.style.display = "none";
			
			document.all.query_all.style.display = "";
			document.all.query_all_new.style.display = "";
			document.all.add_no3.style.display = "";
			
			document.all.confirm.disabled=false;
			//new xl
			document.all.sptime3.style.display = "none";
			document.all.sptime4.style.display = "none";
			document.all.sptime5.style.display = "none";
			//��������
			document.all.sptime6.style.display = "none";
			document.all.add_time3.style.display = "none";
			document.all.check_all.style.display = ""; 
			document.all.check_all_new.style.display = "";

			//test zhangshuo
			document.all.qryOprInfoFrame.style.display = "none";
			//xl add for gongjian
			document.all.spname_show.style.display = "none";
			document.all.khyy_note.style.display = "none";
		}
		else
		{
			rdShowMessageDialog("�������ù��Ų�����������ѯ!");
			//document.all.opFlag[0].checked;
			var radio_oj=document.all.opFlag;
			for(var i=0;i<radio_oj.length;i++)  
			{
				//alert("test "+radio_oj[i].value);
				if(radio_oj[i].value=="zero")  
				{ 
					radio_oj[i].checked=true; 
					opchange();
					break;  
				}
			}
			//document.all.opFlag[0].checked;
			//return false;
		}
		//window.location.href="f4141_query.jsp";
		
	}
}
function docomm(subButton)
{
	controlButt(subButton);//��ʱ���ư�ť�Ŀ�����
//	if(!check(frm)) return false; 
	
	if(document.all.opFlag[0].checked==true)
	{
		if (document.all.phoneno1.value == "")
		{
			rdShowMessageDialog("������Ʒ��û�����!");
			return;
		}
		
		if (document.all.acceptno.value == "")
		{
			rdShowMessageDialog("������Ͷ�ߵ�����ˮ!");
			return;
		}
		
		if (document.all.UnPayLevel.value == 0)
		{
			rdShowMessageDialog("����ѡ���˷�����!");
			return;
		}
		
		if (document.all.UnPayKind.value == 0)
		{
			rdShowMessageDialog("��ѡ���˷�����!");
			return;
		}
		
		if (document.all.FirstClass.value == 0)
		{
			rdShowMessageDialog("��ѡ���˷�һ��ԭ��!");
			return;
		}
		if (document.all.SecondClass.value == 0)
		{
			rdShowMessageDialog("��ѡ���˷Ѷ���ԭ��!");
			return;
		}  
		if (document.all.ThirdClass.value == 0)
		{
			rdShowMessageDialog("��ѡ���˷�����ԭ��!");
			return;
		}
		
		if (document.all.backMoney.value == "")
		{
			rdShowMessageDialog("�������˷ѽ��!");
			return;
		}
		
  
		// xl add new begin
		var FirstClass_new = document.all.FirstClass[document.all.FirstClass.selectedIndex].value;
		var FirstClass_new_text = document.all.FirstClass[document.all.FirstClass.selectedIndex].text;
		//alert("FirstClass_new_text is "+FirstClass_new_text);
		if(FirstClass_new=="1003"||FirstClass_new=="1006"||FirstClass_new=="1009"||FirstClass_new=="1012"||FirstClass_new=="1015"||FirstClass_new=="1018"||FirstClass_new=="1021"||FirstClass_new=="1024"||FirstClass_new=="1027"||FirstClass_new=="1030"||FirstClass_new=="1033"||FirstClass_new=="1036"||FirstClass_new=="1039"||FirstClass_new=="1083")
		{
			//xl add for huxl �ǿ����� begin
			if (document.all.spEnterCode.value == "")
			{
				rdShowMessageDialog("SP��ҵ���벻����Ϊ��!");
				return;
			}
		 
			//end �ǿ�
			//xl add for fanyan sp��ҵ�����spҵ�����Ϊ������ begin document.all.spTranCode.value="";
			if (document.all.spTranCode.value == "")
			{
				rdShowMessageDialog("SPҵ����벻����Ϊ��!");
				return;
			}
			//xl add for fanyan sp��ҵ�����spҵ�����Ϊ������ end
			if(document.all.ywsysj.value=="")
			{
				rdShowMessageDialog("������ҵ��ʹ��ʱ��!");
				return;
			}
			//ҵ��ʹ��ʱ���ʽ��֤ begin
			/*
			var aaa=document.all.ywsysj.value;
			tt2=aaa.match(/\d{4}\/\d{1,2}\/\d{1,2} \d{1,2}:\d{1,2}:\d{1,2}/);
			var sysj_len = document.all.ywsysj.value.length;
			if(tt2==null)
			{
				rdShowMessageDialog("��������ȷ��ҵ��ʹ��ʱ���ʽ!");
				return false;
			}
			*/
			//ҵ��ʹ��ʱ���ʽ��֤ end
			//�˼�ʱ����֤ begin
			if(document.all.hjsj.value=="")
			{
				rdShowMessageDialog("������˼�ʱ��!");
				return;
			}
			var aa1=document.all.hjsj.value;
			tt3=aa1.match(/\d{4}\d{1,2}\d{1,2}\d{1,2}\d{1,2}\d{1,2}/);
			tt4=aa1.match(/\d{4}\d{1,2}\d{1,2} \d{1,2}:\d{1,2}:\d{1,2}/);
			
			if(tt3==null)// &&tt4==null) 
			{
				rdShowMessageDialog("��������ȷ�ĺ˼�ʱ���ʽ!");
				return false;
			}
			document.all.ywsysj.value=document.all.ywsysj.value.trim();
			document.all.hjsj.value=document.all.hjsj.value.trim();
			 
			//�˼�ʱ����֤ end
			var spCodeNew = document.all.spEnterCode.value;
			var ThirdClass_new = document.all.ThirdClass[document.all.ThirdClass.selectedIndex].value;
			//alert("ThirdClass_new is "+ThirdClass_new+" and spCodeNew.substring(0,1) is "+spCodeNew.substring(0,1));
			if((ThirdClass_new=="2176" &&spCodeNew.substring(0,1)!="9")||(ThirdClass_new=="2187" &&spCodeNew.substring(0,1)!="9")||(ThirdClass_new=="2202" &&spCodeNew.substring(0,1)!="9")||(ThirdClass_new=="2213" &&spCodeNew.substring(0,1)!="9")||(ThirdClass_new=="2228" &&spCodeNew.substring(0,1)!="9")||(ThirdClass_new=="2239" &&spCodeNew.substring(0,1)!="9")||(ThirdClass_new=="2254" &&spCodeNew.substring(0,1)!="9")||(ThirdClass_new=="2265" &&spCodeNew.substring(0,1)!="9")||(ThirdClass_new=="2280" &&spCodeNew.substring(0,1)!="9")||(ThirdClass_new=="2291" &&spCodeNew.substring(0,1)!="9")||(ThirdClass_new=="2306" &&spCodeNew.substring(0,1)!="9")||(ThirdClass_new=="2317" &&spCodeNew.substring(0,1)!="9")||(ThirdClass_new=="2332" &&spCodeNew.substring(0,1)!="9")||(ThirdClass_new=="2343" &&spCodeNew.substring(0,1)!="9")||(ThirdClass_new=="2358" &&spCodeNew.substring(0,1)!="9")||(ThirdClass_new=="2369" &&spCodeNew.substring(0,1)!="9")||(ThirdClass_new=="2384" &&spCodeNew.substring(0,1)!="9")||(ThirdClass_new=="2395" &&spCodeNew.substring(0,1)!="9")||(ThirdClass_new=="2436" &&spCodeNew.substring(0,1)!="9")||(ThirdClass_new=="2410" &&spCodeNew.substring(0,1)!="9")||(ThirdClass_new=="2421" &&spCodeNew.substring(0,1)!="9")||(ThirdClass_new=="2447" &&spCodeNew.substring(0,1)!="9")||(ThirdClass_new=="2462" &&spCodeNew.substring(0,1)!="9")||(ThirdClass_new=="2473" &&spCodeNew.substring(0,1)!="9")||(ThirdClass_new=="2488" &&spCodeNew.substring(0,1)!="9")||(ThirdClass_new=="2499" &&spCodeNew.substring(0,1)!="9"))
			{
				rdShowMessageDialog("��ҵ�������������ַ�9��");
				return;
			}
			
		}
		else
		{
			document.all.kjlx[document.all.kjlx.selectedIndex].value="";
			document.all.jflx[document.all.jflx.selectedIndex].value="";
			document.all.ywsysj.value="";
			document.all.hjsj.value="";
		}
		//xl add 4141 �ֻ���Ϸ begin
		var ThirdClass_new = document.all.ThirdClass[document.all.ThirdClass.selectedIndex].value;
		var ThirdClass_new_text = document.all.ThirdClass[document.all.ThirdClass.selectedIndex].text;
		//alert("test ThirdClass_new_text is "+ThirdClass_new_text);
		//xl add 4141 �ֻ���Ϸ end
		// xl add new end
		if(document.all.ivrcheck.checked)
		{
			document.all.ivrflag.value="1";
		}
		else if(ThirdClass_new_text=="�ֻ���Ϸ")
		{
			document.all.ivrflag.value="2";
		}
		// xl add for ��ѩ��
		else if(ThirdClass_new_text=="�ƶ�����վ" ||ThirdClass_new_text=="������������"||ThirdClass_new_text=="�ֻ��㲥"||ThirdClass_new_text=="���ж���"||ThirdClass_new_text=="�¸�����ͨ"||ThirdClass_new_text=="��Ϣ�㲥ҵ��"||ThirdClass_new_text=="�����ֻ���")
		{
			document.all.ivrflag.value="3";
		}
		else
		{
			document.all.ivrflag.value="0";
		}
		//xl add for fanyan ��ѡ��ͻ�ԭ��ҳ������չʾ���ͻ�ԭ�����ҹ�˾�е��˷ѽ��޷���SP�����п۳��������ء����ڡ���ע���������˷ѵ�ԭ��˵�������Ҹñ�ע�ǿա�
		//alert(document.all.FirstClass[document.all.FirstClass.selectedIndex].text);
		if(document.all.FirstClass[document.all.FirstClass.selectedIndex].text=="�ͻ�ԭ��")
		{
			if(document.all.op_note.value=="")
			{
				rdShowMessageDialog("�������˷ѱ�ע��Ϣ!");
		 		return;
			}
			document.all.op_note.value=document.all.op_note.value+";"+document.all.phoneno1.value+"�˷�:"+document.all.compMoney.value;
			 
		}
		//xl add for fanyan �������begin
		var s_money=document.all.compMoney.value;
		//alert("s_money is "+s_money);
		var s_login_flag="";
		var s_money_flag="";
		if("<%=work_no%>"=="801001"||"<%=work_no%>"=="800107"||"<%=work_no%>"=="800227"||"<%=work_no%>"=="800219"||"<%=work_no%>"=="800236"||"<%=work_no%>"=="800294")//fanyanȷ������ô�ھ�
		{
			s_login_flag="1";
		}
		else if("<%=work_no.substring(0,2)%>"=="80")
		{
			s_login_flag="2";
		}
		else
		{
			s_login_flag="3";
		}
		//alert("falg is "+s_login_flag);
		/*
		if(s_login_flag=="1" &&s_money>300)
		{
			rdShowMessageDialog("�˷��ܽ����Դ���300Ԫ!");
			return;
		}
		else if(s_login_flag=="2" &&s_money>150)
		{
			rdShowMessageDialog("�˷��ܽ����Դ���150Ԫ!");
			return;
		}
		else if(s_login_flag=="3")
		{
			 
		}*/
		if("<%=work_no.substring(0,2)%>"=="80")
		{
			if("<%=i_login_count%>">=1 &&s_money>300)
			{
				rdShowMessageDialog("�˷��ܽ����Դ���300Ԫ!");
				return;
			}
			else if("<%=i_login_count%>"==0 &&s_money>150)
			{
				rdShowMessageDialog("�˷��ܽ����Դ���150Ԫ!");
				return;
			}
			else if(s_login_flag=="3")
			{
				 
			}
		}
		
		//xl add for fanyan �������end
		frm.action="f4141_1Cfm.jsp";
		frm.submit();
	}
	if(document.all.opFlag[1].checked==true)
	{
	 	if (document.all.phoneno.value == "")
		{
		 	rdShowMessageDialog("������Ʒ��û�����!");
		 	return;
		}
	
		if (document.all.backaccept.value == "")
		{
		 	rdShowMessageDialog("������ҵ����ˮ!");
		 	return;
		}
 		frm.action="f4141_2.jsp";
 		frm.submit();
	}
	if(document.all.opFlag[2].checked==true)
	{	
		var begin_time = document.all.begin_time.value.substring(0,4)+document.all.begin_time.value.substring(5,7)+document.all.begin_time.value.substring(8,10);
		var end_time1 = document.all.end_time1.value.substring(0,4)+document.all.end_time1.value.substring(5,7)+document.all.end_time1.value.substring(8,10);
		var phone_no = document.all.phone_no.value;
		var op_code = document.all.op_code.value;
		
		//alert("��ʼʱ��"+begin_time);
		//alert("����ʱ��"+end_time1);

		if(phone_no=="")
		{
			rdShowMessageDialog("��ѯ���벻��Ϊ�գ�");
			return;
		}
		if(begin_time=="")
		{
			rdShowMessageDialog("��ʼʱ�䲻��Ϊ�գ�");
			return;
		}
		if(end_time1=="")
		{
			rdShowMessageDialog("����ʱ�䲻��Ϊ�գ�");
			return;
		}

		document.all.phone_no.disabled=true;
		document.all.begin_time.disabled=true;
		document.all.end_time1.disabled=true;
		
		document.getElementById("qryOprInfoFrame").style.display="block";
		
		document.qryOprInfoFrame.location = "f4141_getInfo.jsp?begin_time="+begin_time+"&phone_no="+phone_no+"&end_time="+end_time1+"&op_code"+op_code;
	}
	if(document.all.opFlag[3].checked==true)
	{
		//alert("������ѯ");
		var begin_time = document.all.begin_tm.value.substring(0,4)+document.all.begin_tm.value.substring(5,7)+document.all.begin_tm.value.substring(8,10);
		var end_time1 = document.all.end_tm.value.substring(0,4)+document.all.end_tm.value.substring(5,7)+document.all.end_tm.value.substring(8,10);
		var phone_no = document.all.phone_no.value;
		
		//alert("��ʼʱ��"+begin_time);
		//alert("����ʱ��"+end_time1);

		/*
		if(phone_no=="")
		{
			rdShowMessageDialog("��ѯ���벻��Ϊ�գ�");
			return;
		}
		*/
		if(begin_time=="")
		{
			rdShowMessageDialog("��ʼʱ�䲻��Ϊ�գ�");
			return;
		}
		if(end_time1=="")
		{
			rdShowMessageDialog("����ʱ�䲻��Ϊ�գ�");
			return;
		}
		 
		  
		 	  
		// xl add end
		//xl add new �˷Ѳ�ѯor ������ѯ cxfw
		//var ThirdClass_new = document.all.ThirdClass[document.all.ThirdClass.selectedIndex].value
		var qry_region = document.all.cxfw[document.all.cxfw.selectedIndex].value ;
		var qry_value = document.getElementById("qryValue").value;//�˷�or�����Ĳ�ѯ
		
		//alert(qry_region);
		document.getElementById("qryOprInfoFrame").style.display="block";
document.qryOprInfoFrame.location =   "f4141_queryall.jsp?begin_time="+begin_time+"&phone_no="+phone_no+"&end_time="+end_time1+"&qry_value="+qry_value+"&qry_region="+qry_region;
		//alert(document.qryOprInfoFrame.location);
 
	}	
	return true;
}

function accountbackfee()
{
	var varFeeMoney = document.all.backMoney.value; //�˷ѽ��
	
	var varFeeFlag = 0;  //�˷ѵ���˫��
	
	if (document.all.phoneno1.value == "")
	{
		rdShowMessageDialog("������Ʒ��û�����!");
		return;
	}
	
	if (document.all.acceptno.value == "")
	{
		rdShowMessageDialog("������Ͷ�ߵ�����ˮ!");
		return;
	}
	
	if (document.all.UnPayLevel.value == 0)
	{
		rdShowMessageDialog("��ѡ���˷�����!");
		return;
	}
	else
	{
		if (document.all.UnPayLevel.value == 1)
		{
			varFeeFlag = 1;
	 
			document.all.feeflag.value=1;
		}else{
			varFeeFlag = 2;
	 
			document.all.feeflag.value=2;
		}	
	}
	
	if (document.all.UnPayKind.value == 0)
	{
		rdShowMessageDialog("��ѡ���˷�����!");
		return;
	}
	
	
	
	/*xl add for �˷� �ж������sp�Ļ� ����=�˷ѽ��*/
	var FirstClass_new = document.all.FirstClass[document.all.FirstClass.selectedIndex].value;
	//alert("FirstClass_new is "+FirstClass_new);
	if(FirstClass_new=="1003"||FirstClass_new=="1006"||FirstClass_new=="1009"||FirstClass_new=="1012"||FirstClass_new=="1015"||FirstClass_new=="1018"||FirstClass_new=="1021"||FirstClass_new=="1024"||FirstClass_new=="1027"||FirstClass_new=="1030"||FirstClass_new=="1033"||FirstClass_new=="1036"||FirstClass_new=="1039"||FirstClass_new=="1083")
	{
		var dj = document.all.dj.value;
		var sl = document.all.sl.value;
		if(dj=="")
		{
			rdShowMessageDialog("�����뵥��!");
			return;
		}
		if(sl=="")
		{
			rdShowMessageDialog("����������!");
			return;
		}
		document.all.compMoney.value = varFeeFlag*dj*sl;
		document.all.backMoney.value = document.all.compMoney.value ;
		
	}
	else
	{
		if (document.all.backMoney.value == "")
		{
			rdShowMessageDialog("�������˷ѽ��!");
			return;
		}
		document.all.compMoney.value = varFeeMoney*varFeeFlag;
	}
	
	 
	 
	
	document.all.confirm.disabled=false;
	
	document.all.backMoney.disabled = true;
	
	document.all.backMoney1.value=document.all.backMoney.value;
	
	document.all.phoneNo.value=document.all.phoneno1.value;
	
	//xl add for fanyan ���˷�ԭ���ǿͻ�ԭ��ʱ ���ֵ��ӪҵԱ���뱸ע��Ϣ���ټ���
	document.all.op_note.value ="";
	if(document.all.FirstClass[document.all.FirstClass.selectedIndex].text!="�ͻ�ԭ��")
	{
		document.all.op_note.value = document.all.phoneno1.value+"�˷�:"+document.all.compMoney.value;
	}
	
}

function change()
{
	document.all.confirm.disabled = true;
}


function clearnew(){
	//alert("ssssssssss");
	if(document.all.opFlag[0].checked==true)
	{
		document.all.phoneno1.value="";		
		document.all.acceptno.value="";		
		document.all.UnPayLevel.value = 0;
		document.all.UnPayKind.value = 0;		
		document.all.FirstClass.value = 0;
		document.all.SecondClass.value = 0; 
		document.all.ThirdClass.value = 0;
		document.all.spEnterCode.value="";
		document.all.spTranCode.value="";
		document.all.useing_time.value="";
		document.all.sp_login_accept.value="";
		document.all.op_time.value="";
		document.all.end_time.value="";
		document.all.backMoney.value="";
		document.all.compMoney.value="";
		document.all.op_note.value="";	
		//document.all.backMoney.disabled=false;
	}
	if(document.all.opFlag[1].checked==true)
	{
	 	document.all.phoneno.value = "";
		document.all.backaccept.value = "";
	}
	if(document.all.opFlag[2].checked==true)
	{
		document.all.phone_no.value="";
		document.all.begin_time.value="";
		document.all.end_time1.value="";
		document.all.phone_no.disabled=false;
		document.all.begin_time.disabled=false;
		document.all.end_time1.disabled=false;
	}
	
	if(document.all.opFlag[3].checked==true)
	{
		document.all.phone_no.value="";
		document.all.begin_tm.value="";
		document.all.begin_tm.value="";
		document.all.phone_no.disabled=false;
		document.all.begin_tm.disabled=false;
		document.all.begin_tm.disabled=false;
		//��ѡ�򶼲�ѡ
		var regionChecks = document.getElementsByName("regionCheck");
		for(var i=0;i<regionChecks.length;i++){
			regionChecks[i].checked=false;
		}
		//end ��ѡ��
	}
	
}
 
 

///////////////////
function init()
{
	document.all.kjlx[document.all.kjlx.selectedIndex].value="";
	document.all.jflx[document.all.jflx.selectedIndex].value="";
	document.all.ywsysj.value="";
	document.all.hjsj.value="";
}

//ȫѡ
function doSelectAllNodes()
{
	//document.all.sure.disabled=false;
	if(document.getElementById("check_all_id").checked)
	{
		var regionChecks = document.getElementsByName("regionCheck");
		for(var i=0;i<regionChecks.length;i++){
			regionChecks[i].checked=true;
		}
	}
	
	 
}
function doCancelChooseAll()
{
	if(document.getElementById("check_not_id").checked)
	{
		var regionChecks = document.getElementsByName("regionCheck");
		for(var i=0;i<regionChecks.length;i++){
			regionChecks[i].checked=false;
		}
	}	
}

function cx_new()
{
	window.location.href='f4141_cx.jsp';
}
</script>

<style type="text/css">
	<!--
    body {
      margin:0;
      padding:0;
      font:  12px/1.5em Verdana;
    }
		
    #tabsJ {
      float:left;
      width:100%;
      background:#f6f6f6;
      font-size:93%;
      line-height:normal;
    }
    #tabsJ ul {
      margin:0;
      padding:10px 10px 0 5px;
      list-style:none;
    }
    #tabsJ li {
      display:inline;
      margin:0;
      padding:0;
    }
    #tabsJ a {
      float:left;
      background:url("/nresources/default/images/tableftJ.gif") no-repeat left top;
      margin:0;
      padding:0 0 0 5px;
      text-decoration:none;
      cursor:hand;
    }
    #tabsJ a span {
      float:left;
      display:block;
      background:url("/nresources/default/images/tabrightJ.gif") no-repeat right top;
      padding:5px 15px 4px 6px;
      color:#24618E;
    }
    /* Commented Backslash Hack hides rule from IE5-Mac \*/
    #tabsJ a span {
    	float:none;
    }
    /* End IE5-Mac hack */
    #tabsJ a:hover span {
      color:#FFF;
    }
    #tabsJ a:hover {
      background-position:0% -42px;
    }
    #tabsJ a:hover span {
      background-position:100% -42px;
    }

    #tabsJ .current a {
      background-position:0% -42px;
    }
    #tabsJ .current a span {
			font: bold;
      background-position:100% -42px;
      color:#FFF;
    }

	
	-->
	</style>

</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
<input type="hidden" value="<%=i_login_count%>">
<input type="hidden" id="qryValue" value="1" >
<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">
<input type="hidden" name="op_code" id="op_code" value="<%=opCode%>">
<input type="hidden" name="sysAccept" value="<%=sysAccept%>">
<input type="hidden" name="backMoney1" value="">
<input type="hidden" name="phoneNo" value="">
<input type="hidden" name="ivrflag" value="">
<!--xl add for ����or˫��-->
<input type="hidden" name="feeflag" value="">
	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi">Ͷ���˷ѹ��� </div>
	</div>
	<table  cellspacing="0" >          
 		<TR> 
      		<TD width="25%" class="blue">��������</TD>
      		<TD colspan="3">		
      	<q vType='setNg35Attr'>
					<input type="radio" name="opFlag" value="zero" onclick="opchange()" checked>�˷�
				</q>
				<q vType='setNg35Attr'>
				<input type="radio" name="opFlag" value="one" onclick="opchange()" >����
				</q>
				<q vType='setNg35Attr'>
				<input type="radio" name="opFlag" value="two" onclick="cx_new()" >��ѯ
				</q>
				<q vType='setNg35Attr'>
				<input type="radio" name="opFlag" value="three" onclick="opchange()" >������ѯ
				</q>
			</td>
 		</TR>
	</table>
	<table>
 		<TR style="display:none" id="inputinfo_id"> 
			<TD class="blue">�Ʒ��û�����</TD>
			<TD>
				<input type="text" name="phoneno"  maxlength=11>
				<font color="orange">*</font>
			</TD>
			<TD class="blue">ҵ����ˮ</TD>
			<TD>
				<input type="text" name="backaccept"  maxlength=14>
				<font color="orange">*</font>
			</TD>
		</TR>
		
		<tr id="add_no"> 
	        <td class=blue nowrap>�Ʒ��û�����</td>
	        <td nowrap> 
	            <input type="text" name="phoneno1" v_must=1  v_type="mobphone" onBlur="if(this.value!=''){if(checkElement(this)==false){return false;}}" maxlength=11 >
	            <font class="orange">*</font>              
	        </td>
	        <td class=blue nowrap>Ͷ�ߵ�����ˮ</td>
	        <td nowrap> 
	            <input type="text" name="acceptno" v_must=1   onBlur="if(this.value!=''){if(checkElement(this)==false){return false;}}" maxlength=30 size="30">
	            <font class="orange">*</font>
	        </td>
	    </tr>
	    <tr id="add_type"> 
	        <td nowrap class=blue>�˷�����</td>
	        <td nowrap> 
	            <select name="UnPayLevel" class="button">
	            	<option value="0">--��ѡ��--</option>
	                <option value="1">��������</option>
	                <option value="2">˫������</option>
	            </select>
	            <font class="orange">*</font>
	        </td>
	        <td nowrap class=blue>�˷�����</td>
	        <td nowrap> 
	            <select name="UnPayKind" class="button">
	            	<option value="0">--��ѡ��--</option>
	                <!--<option value="1">���ֽ�</option>-->
	                <option value="2" selected>��Ԥ��</option>
	            </select>
	            <font class="orange">*</font>
	        </td>
	    </tr>
	    <tr id="add_FirstClass"> 
	        <td nowrap class=blue>�˷�һ��ԭ��</td>
	        <td nowrap> 
	            <select name="FirstClass" class="button" onChange="tochange('secondclass')">
	            	<option value="0">--��ѡ��--</option>
					<%for(int i = 0 ; i < returnStr1.length ; i ++){%>
						<option value="<%=returnStr1[i][1]%>"><%=returnStr1[i][0]%></option>
					<%}%>
	            </select>
	            <font class="orange">*</font>
	        </td>
	        <td class="blue" >IVRҵ��ѡ��</td>
	        <!--<td nowrap class=blue>&nbsp;</td><td nowrap> 
				<input type="hidden" name="a" v_must=1  v_type="mobphone" onBlur="if(this.value!=''){if(checkElement(this)==false){return false;}}" maxlength=11 >
				
	        </td>-->

			<!--xl add for �������� begin-->
		    <td class="blue" style="display:none" id="sptime6">
				<input type="checkbox" name="ivrcheck" onclick="ivrCheck()">
			</td>
			
			
			 
				
	  
	    <!--xl add for �������� end-->
	    </tr>
		
	    <tr id="add_SecondClass"> 
	        <td nowrap class=blue>�˷Ѷ���ԭ��</td>
	        <td nowrap> 
	            <select name="SecondClass" class="button" onChange="tochange('thirdclass')" >
	            	<option value="0">--��ѡ��--</option>
	            </select>
	            <font class="orange">*</font>
	        </td>
	        <td nowrap class=blue>�˷�����ԭ��</td>
	        <td nowrap> 
	            <select name="ThirdClass" class="button" onchange="change();">
	            	<option value="0">--��ѡ��--</option>
	            </select>
	            <font class="orange">*</font>
	        </td>
	    </tr>
	    

		<tr class="blue" style="display:none" id="spname_show"> 
	        <td nowrap class=blue>Spҵ������ </td>
	        <td nowrap >
					<input name="spywname" type="text" id="spywnameid" >
					<input class="b_text" type="button" name="qryId_No" value="��ѯ" onClick="getxdMsg()" disabled >
			</td>
			<td nowrap class=blue>Spҵ�����</td>
	        <td nowrap> 
	            <input type="text" name="spTranCode"  id="spTranCode" disabled >
				<font class="orange">*</font>
				
	        </td>
	    </tr>
		<tr class="blue" style="display:none" id="spinfo"> 
	        <td nowrap class=blue>Sp��ҵ���� </td>
	        <td nowrap >
					<input name="spname" type="text" id="spnameid" >
			</td>
			<td nowrap class=blue>Sp��ҵ���� </td>
	        <td nowrap>
							<input name="spEnterCode" type="text" id="spEnterCode" disabled>
							<font class="orange">*</font>
				<!--<input class="b_text" type="button" name="qryId_No" value="��ѯ" onClick="getInfo_code()" disabled >-->
	            
				
	        </td>
	        
	    </tr>
	    <tr class="blue" style="display:none" id="sptime1">
					<td class="blue">Sp�״ζ���ʱ��</td>
	        <TD>
							<input name="useing_time" type="text" class="InputGrey" id="useing_time" v_format="yyyymmdd" readonly>
	        </TD>		
	        <td nowrap class=blue>Sp������ˮ</td>
					<td>
						<input name="sp_login_accept" type="text" class="InputGrey" id="sp_login_accept" readonly>
					</td>
	    </tr>
	    <tr class="blue" style="display:none" id="sptime2"> 
					<td class="blue">Sp����ʱ��</td>
	        <TD>
							<input name="op_time" type="text" class="InputGrey" id="op_time" v_format="yyyymmdd" readonly>
	        </TD>
					<td class="blue">Sp����ʱ��</td>
	        <TD>
							<input name="end_time" type="text" class="InputGrey" id="end_time" v_format="yyyymmdd" readonly>
	        </TD>
	    </tr>
		<!--xl add -->
		<tr class="blue" style="display:none" id="sptime3">
					<td class="blue">�˼�����</td>
	        <TD>
							<select size=1 name=kjlx  >
							  <%for(int i = 0 ; i < sCheckTypeStr.length ; i ++){
							  if(sCheckTypeStr[i][1].equals("�˷�")){
									%>
									<option value="<%=sCheckTypeStr[i][0]%>" selected >
						
						                  <%=sCheckTypeStr[i][1]%></option>
									<%
								}
							   else
							   {
									%>
									<option value="<%=sCheckTypeStr[i][0]%>"><%=sCheckTypeStr[i][1]%></option>
							 		<%
							   }		 
							 
							  }%>
							</select>
							<font class="orange">*</font>
	        </TD>		
	        <td nowrap class=blue>�Ʒ�����</td>
					<td>
						<select size=1 name=jflx  >
							  <%for(int i = 0 ; i < sBillTypeStr.length ; i ++)
								{
								if(sBillTypeStr[i][1].equals("����/�����Ʒ�")){
									%>
									<option value="<%=sBillTypeStr[i][0]%>" selected >
						
						                  <%=sBillTypeStr[i][1]%></option>
									<%
								}else{
									%>
									<option value="<%=sBillTypeStr[i][0]%>">
						
									         <%=sBillTypeStr[i][1]%></option>
									<%
									}
							    }
							  %>
						</select>
					</td>
	    </tr>
		<tr class="blue" style="display:none" id="sptime4">
					<td class="blue">ҵ��ʹ��ʱ��</td>
					
	        <TD>
							<input name="ywsysj" type="text" id="ywsysjId" maxlength="8" >(YYYYMMDD)
							<font class="orange">*</font>
	        </TD>		
	        <td nowrap class=blue>�˼�ʱ��</td>
					<td>
						<input name="hjsj" type="text" id="hjsjId" value="<%=returnTime[0][0]%>" >
						<font class="orange">*</font>
					</td>
	    </tr>
		<tr class="blue" style="display:none" id="sptime5">
					<td class="blue">����</td>
	        <TD>
							<input name="dj" type="text"  id="dj" onKeyPress="return isKeyNumberdot(1)">
	        </TD>		
	        <td nowrap class=blue>����</td>
					<td>
						<input name="sl" type="text" id="sl" onKeyPress="return isKeyNumberdot(1)">
					</td>
	    </tr>
		<!--xl add end-->
		
		<tr id="add_mon"> 
	        <td nowrap class=blue>�˷ѽ��</td>
	        <td nowrap> 
	            <input type="text" name="backMoney" maxlength="10" value="" onKeyPress="return isKeyNumberdot(1)" >
	            <font class="orange">*</font>
	            <input type=button class="b_text" name="buttonclick" style="cursor:hand" onClick="accountbackfee()" value=���� ></td>
	        </td>
	        <td nowrap class=blue>�⳥���</td>
	        <td nowrap> 
	            <input class="InputGrey" type="text" name="compMoney" value="" readonly >
	        </td>
	    </tr>
		
	    <tr id="add_note">
	        <td nowrap class=blue>��ע</td>
	        <td colspan="3"> 
	            <input type="text" name="op_note" v_must=1 size="100" onBlur="if(this.value!=''){if(checkElement(this)==false){return false;}}" maxlength=50 >
	        </td>
	    </tr>
		<!--xl add for fanyan ����һ����ʾ�� begin-->
		<tr style="display:none" id="khyy_note">		
			<td colspan=4 class="blue" nowrap><font color='red'>�ͻ�ԭ�����ҹ�˾�е��˷ѽ��޷���SP�����п۳���������</font></td>
			 
			 
		</tr>
		<!--end of fanyan-->
		<tr style="display:none"  id="add_no3">
			<td width="15%" class="blue" nowrap>��ѯ����</td>
			<td width="35%"><input type="text" name="phone_no" id="phone_no"  maxlength=11 size="18" value=""> &nbsp;&nbsp;</td>
			<td width="15%" class="blue" nowrap>&nbsp</td>
			<td width="35%">
			<input type="hidden" name="login_no" value="">&nbsp;&nbsp;	</tr>
		</tr>
		<input type="hidden" name="login_no" value="">
<!-- 20091220 ע�͵������޸�Ϊ���ڿؼ�
		<tr style="display:none"  id="add_time3">		
			<td width="15%" class="blue" nowrap>��ʼʱ��</td>
			<td width="35%"><input type="text" name="begin_time" id="begin_time"  v_must=1 size="18" maxlength="8" value=""><font class="orange">*(��ʽYYYYMMDD)</font>&nbsp;&nbsp;</td>
			<td width="15%" class="blue" nowrap>����ʱ��</td>
			<td width="35%"><input type="text" name="end_time1" id="end_time1"  v_must=1 size="18" maxlength="8" value=""><font class="orange">*(��ʽYYYYMMDD)</font>&nbsp;&nbsp;
		</tr>
-->
<!--20091220 begin -->
		<tr style="display:none" id="add_time3">		
			<td width="15%" class="blue" nowrap>��ʼʱ��</td>
			<td width="35%">
				<input type="text" name="begin_time" id="begin_time" size="18" readonly="true"/>&nbsp;
				<img src='<%=contextPath%>/js/common/date/button.gif' style='cursor:hand' onclick='fPopUpCalendarDlg(begin_time);return false' alt=�������������˵� align=absMiddle readonly></td>
			</td>
		
			<td width="15%" class="blue" nowrap>����ʱ��</td>
			<td width="35%">
				<input type="text" name="end_time1" id="end_time1" size="18" readonly="true"/>&nbsp;
				<img src='<%=contextPath%>/js/common/date/button.gif' style='cursor:hand' onclick='fPopUpCalendarDlg(end_time1);return false' alt=�������������˵� align=absMiddle readonly></td>
			</td>
		</tr>
<!-- 20091220 end -->
<!--xl add for zhangshuo begin-->
		<tr style="display:none" id="query_all">
			<table style="display:none" id="query_all_new">
						 <tr>
							<td width="15%" class="blue" nowrap>��ʼʱ��</td>
			<td width="35%">
				<input type="text" name="begin_tm" id="begin_tm" size="18" readonly="true"/>&nbsp;
				<img src='<%=contextPath%>/js/common/date/button.gif' style='cursor:hand' onclick='fPopUpCalendarDlg(begin_tm);return false' alt=�������������˵� align=absMiddle readonly></td>
			</td>
		
			<td width="15%" class="blue" nowrap>����ʱ��</td>
			<td width="35%">
				<input type="text" name="end_tm" id="end_tm" size="18" readonly="true"/>&nbsp;
				<img src='<%=contextPath%>/js/common/date/button.gif' style='cursor:hand' onclick='fPopUpCalendarDlg(end_tm);return false' alt=�������������˵� align=absMiddle readonly></td>
			</td>
						 </tr>
			</table>
			
		</tr>
		<tr style="display:none" id="check_all">
			<table style="display:none" id="check_all_new">
			<tr>
				<td>
					<q vType='setNg35Attr'>
					<input type="radio" name="qryFlag" value="1" onclick="qryChg()" checked>�˷Ѳ�ѯ
				</q>
				<q vType='setNg35Attr'>
				<input type="radio" name="qryFlag" value="2" onclick="qryChg()" >������ѯ
				</q>
				</td>
			 
			</tr>
			<!--xl add for fanyan ���Ӱ������ӡ���ѯ��Χ����ѯ����--> 
			<tr>
				��ѯ���У�<select name="cxfw" class="button">
	            	<%for(int i = 0 ; i < ret_val_new.length ; i ++){%>
						<option value="<%=ret_val_new[i][0]%>"><%=ret_val_new[i][1]%></option>
					<%}%>
	            </select>
			</tr>
			 
			<!--
			<tr>
				<td>
					<input type="checkbox" id="check_all_id" onclick="doSelectAllNodes()">ȫѡ &nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox" id="check_not_id" onclick="doCancelChooseAll()">ȡ��ȫѡ 
				</td>
			</tr>
			-->
			</table>
			 
		</tr>
	    
	 
<!--xl add for zhangshuo end-->
	</table>
	
	<table cellspacing="0">
		<tr id="add_3">
			<td style="height:0;">
				<iframe frameBorder="0" id="qryOprInfoFrame" align="center" name="qryOprInfoFrame" scrolling="yes" style="height:300px;overflow-y:auto; visibility:inherit; width:1300px; z-index:1; display:none;"  onload="document.getElementById('qryOprInfoFrame').style.height=qryOprInfoFrame.document.body.scrollHeight+'px'"></iframe>
			</td>
		</tr>
	</table>
	
	<table  cellspacing="0" >
	<tr>
		<td id="footer">     
   			<input type=button name="confirm"class="b_foot" disabled value="ȷ��" onClick="docomm(this)">    
  			<input type=button name=back value="���" class="b_foot" onmouseup="clearnew()" onClick="clearnew()">
	  		<input type=button name=qryP value="�ر�" class="b_foot" onClick="removeCurrentTab();">             
		</td>
	</tr>
	</table>
<%@ include file="/npage/include/footer.jsp" %>   
</form>
</body>
</html>
<script language="javascript">
	function gethjsj()
	{
		var myDate = new Date();
		//var mytime=myDate.toLocaleTimeString(); //��ȡ��ǰʱ�� toLocaleString
		var mytime = myDate.toLocaleString();
		alert("mytime is "+mytime+" and myDate is "+myDate);
		var mytime_str = "";
	}
	function checkIvr()
	{
		if(document.all.ivrcheck.checked)
		{
			//document.all.SecondClass[0].selected;
			//alert("1");
			document.all.SecondClass.options[0].selected = true;
		}
		else
		{
			//alert("2.");
			//document.all.SecondClass[0].selected;
			document.all.SecondClass.options[0].selected = true;
		}	
		
	}
	
</script>