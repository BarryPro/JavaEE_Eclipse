<%

/*****************************************************
 Copyright (c) SI-TECH  Version V2.0
 All rights reserved
******************************************************/

%>
<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.01.15
 ģ��:�û�������ҵ��
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<!--��������java �ļ� ��class-->
<%@ page import="java.util.*"%>
<%@ page import="java.util.StringTokenizer"%>

<%
	
	String sLoginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String orgId = (String)session.getAttribute("orgId");
	String org_code = (String)session.getAttribute("orgCode");
	String password = (String)session.getAttribute("password");
	String selfIp = (String)session.getAttribute("ipAddr");
	
%>


<%  
    String pageName="IPTV�û���Ϣ���";
    String opName = "�û�������ҵ��";
    String opCode = "1984";
	String error_msg = "";
	String errCode = "";
     
	String sys_note = ""; 
	String phone_no = request.getParameter("phone_no");
	String id_no = request.getParameter("id_no");
	String deal_flag = request.getParameter("deal_flag");
	String note = request.getParameter("op_note");
	String loginGrpId = request.getParameter("loginGrpId");
	String sm_code = request.getParameter("sm_code");
	String belong_code = request.getParameter("belong_code");
	String tfc_code = request.getParameter("tfc_code");
	String add_mode = request.getParameter("add_mode");
	String op_time = request.getParameter("op_time");
	String id_type = request.getParameter("opType");
	String cust_id = request.getParameter("cust_id");
	String swtch_type_list = request.getParameter("switch_type_list");
	String swtch_type=request.getParameter("switch_type");
	String flag199=request.getParameter("flag199");


	System.out.println("swtch_type_list"+swtch_type_list);
	System.out.println("swtch_type"+swtch_type);

	sys_note=phone_no+"�û�����ҵ����";

	String hand_fee="0";
	//-----for print
	String bill_year = "";
	String bill_month = "";
%>

<%

    try
	{		
		StringTokenizer token=new StringTokenizer(swtch_type_list,"|");
		StringTokenizer tokenop=new StringTokenizer(swtch_type,"|");
		
		int length=token.countTokens();
		int lengthop=tokenop.countTokens();
		System.out.println(length);
		String temp[]=new String [length];
		String fieldValue[]=new String [lengthop];


		int i=0;
		//���������ַ���
		while (token.hasMoreElements()){
			temp[i]=(String)token.nextElement();
			System.out.println("temp["+i+"]"+temp[i]);
			fieldValue[i]=request.getParameter("f"+temp[i]);//��������ȡ�ô������Ĳ���
			
			System.out.println("fieldValue["+i+"]"+fieldValue[i]);
			i++;
		}
		i=0;
		while (tokenop.hasMoreElements() ){
			fieldValue[i]=(String)tokenop.nextElement();
			System.out.println("fieldValue["+i+"]"+fieldValue[i]);
			i++;
		}
		
		String number = request.getParameter("f199");
		if("1".equals(number))
		{
			;
		}
		else
		{
			number= "5";
		}
	
		System.out.println("number value = "+number);
		ArrayList paramsIn = new ArrayList();

        paramsIn.add(new String[]{org_code         });
        paramsIn.add(new String[]{sLoginNo         });
        paramsIn.add(new String[]{password     });
        paramsIn.add(new String[]{selfIp        });
        paramsIn.add(new String[]{opCode       });
        paramsIn.add(new String[]{phone_no        });
        paramsIn.add(new String[]{id_no         });
        paramsIn.add(new String[]{note         });
        paramsIn.add(new String[]{belong_code        });
        paramsIn.add(new String[]{sm_code         });
        paramsIn.add(new String[]{cust_id         });
        paramsIn.add(new String[]{sys_note         });
        paramsIn.add(swtch_type_list );
        paramsIn.add(swtch_type                    );
        paramsIn.add(number                    );
        paramsIn.add(flag199                    );

        

		//�����������
        //retStr = callView.callService("s1984Cfm", paramsIn, "2");
		//callView.printRetValue();
%>
		<wtc:service name="s1984Cfm" routerKey="phone" routerValue="<%=phone_no%>" retcode="retCode1" retmsg="retMsg1" outnum="2">			
		<wtc:param value="<%=org_code%>"/>	
		<wtc:param value="<%=sLoginNo%>"/>	
		<wtc:param value="<%=password%>"/>	
		<wtc:param value="<%=selfIp%>"/>	
		<wtc:param value="<%=opCode%>"/>	
		<wtc:param value="<%=phone_no%>"/>	
		<wtc:param value="<%=id_no%>"/>	
		<wtc:param value="<%=note%>"/>	
		<wtc:param value="<%=belong_code%>"/>	
		<wtc:param value="<%=sm_code%>"/>	
		<wtc:param value="<%=cust_id%>"/>	
		<wtc:param value="<%=sys_note%>"/>
		<wtc:param value="<%=swtch_type_list%>"/>	
		<wtc:param value="<%=swtch_type%>"/>	
		<wtc:param value="<%=number%>"/>	
		<wtc:param value="<%=flag199%>"/>			
		</wtc:service>	
		<wtc:array id="result1"  scope="end"/>
<%
        errCode = retCode1;
        error_msg= retMsg1;
        String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+sLoginNo+"&loginAccept="+""+"&pageActivePhone="+phone_no+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime;
%>
		<jsp:include page="<%=url%>" flush="true" />
<%    
    }catch(Exception e){
		e.printStackTrace();
        errCode = "-1";    
        error_msg= "���÷�������쳣";    
        System.out.println("exception:"+e.toString()); 
    }   
	
	%>


<html  xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<OBJECT classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05" codebase="/ocx/printatl.dll#version=1,0,0,1" id="printctrl" style="DISPLAY: none" VIEWASTEXT>
		</OBJECT>
		<script language="JavaScript">
			function Cancel(){
  				window.location.href="f1984_1.jsp";
  			}
  		</script>
	</head>
	<body onload="ifprint()">

	</body>
</html>

<!------------------------------------->

<SCRIPT language="JavaScript">
function ifprint() {
	var temp="<%=errCode%>";
	
	if(temp=="000000"){
		rdShowMessageDialog("<%=error_msg%>",2);
		showPrtDlg();
	}else{
		rdShowMessageDialog("<%=error_msg%>",0);
	}


}
function showPrtDlg()
{

   var h=105;
   var w=260;
   var t=screen.availHeight-h-20;
   var l=screen.availWidth/2-w/2;
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" 
   var ret=rdShowConfirmDialog("�Ƿ��ӡ���������");
    if(typeof(ret)!="undefined")
    {
        if(ret==1)                      //����Ͽ�
        {
   
            conf();                          
        }
        else if(ret==0)                 //���ȡ��,���Ƿ��ύ
        {    
            removeCurrentTab();                
        }
    }
}


function conf()
{
   var h=200;
   var w=300;
   var t=screen.availHeight-h-20;
   var l=screen.availWidth/2-w/2;

var infoStr="";


infoStr+="<%=sLoginNo%>"+"|";
infoStr+="<%=loginName%>"+"|";

infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+'<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+'<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";


infoStr+= "<%=phone_no%>"+"|";
infoStr+="<%=swtch_type_list%>"+"|";
infoStr+="<%=swtch_type%>"+"|";

//dirtPate = "/npage/s1984/f1984_1.jsp";

location="/npage/s1984/f1984_print.jsp?retInfo="+infoStr+"&dirtPage=/npage/s1984/f1984_1.jsp";
 }

/*
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի���
   var h=210;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

   var pType="subprint";                                      // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
   var billType="1";                                          //  Ʊ�����ͣ�1���������2��Ʊ��3�վ�
   var sysAccept="";                                          // ��ˮ��
   var printStr=printInfo(printType);                         //����printinfo()���صĴ�ӡ����
   var mode_code=null;                                        //�ʷѴ���
   var fav_code=null;                                         //�ط�����
   var area_code=null;                                        //С������
   var opCode="1984";                                         //��������
   var phoneNo="<%=phone_no%>";                               //�ͻ��绰

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
   path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   var ret=window.showModalDialog(path,printStr,prop);
   return ret;
}

function printInfo(printType)
{
	var cust_info=""; //�ͻ���Ϣ
	var opr_info=""; //������Ϣ
	var note_info1=""; //��ע1
	var note_info2=""; //��ע2
	var note_info3=""; //��ע3
	var note_info4=""; //��ע4
    var retInfo = "";  //��ӡ����
	
	cust_info+="�ֻ����룺"+"<%=phone_no%>"+"|";
	opr_info+="������" + "|";
	note_info1="��ע��"+"|";
	
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	return retInfo;	
 }
*/
</SCRIPT>