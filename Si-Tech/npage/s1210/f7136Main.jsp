<%
/********************
 *version v2.0
 *������: si-tech
 *update by qidp @ 2009-01-05
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.pub.util.*" %>

<%
  request.setCharacterEncoding("GBK");
  //session.setActiveInterval(0);
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>�ʷѰ��ط����</title>
<%
    Logger logger = Logger.getLogger("f7136Main.jsp");
    //SPubCallSvrImpl co=new SPubCallSvrImpl();
    String  vPayCode = "0";
    String opCode="7136";
    String opName="�ʷѰ��ط����";

    String work_no = (String)session.getAttribute("workNo");
    String loginName =(String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
	String op_code = "7136";

    String[][] temfavStr=(String[][])session.getAttribute("favInfo");
	String[] favStr=new String[temfavStr.length];
	for(int i=0;i<favStr.length;i++)
	  favStr[i]=temfavStr[i][0].trim();
	boolean hfrf=false;


 	//ArrayList initArr = new ArrayList();
 	//ArrayList srvArr = new ArrayList();

String retFlag="",retMsg="";  
	//String [][]srvStr;

	String [][]initStr_2;
	String [][]initStr_3;
	int    srvStrIndex = 0;
	ArrayList mySrvArr=new ArrayList();
	String [][]mySrvStr;
 	String srv_no=WtcUtil.repNull(request.getParameter("srv_no"));
	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
 	//-----------���������-------------
	//String sqHf="select hand_fee ,trim(favour_code) from snewFunctionFee where region_code=substr('"+org_code+"',1,2) and FUNCTION_CODE=1219";
	//ArrayList handFeeArr=co.sPubSelect("2",sqHf,"phone",srv_no); 
	
	String sqHf="select hand_fee ,trim(favour_code) from snewFunctionFee where region_code=substr(:org_code,1,2) and FUNCTION_CODE=1219";
	String [] paraIn = new String[2];
    paraIn[0] = sqHf;    
    paraIn[1]="org_code="+org_code;
%>
    <wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=srv_no%>" retcode="retCode22" retmsg="retMsg22" outnum="2" >
        <wtc:param value="<%=paraIn[0]%>"/>
        <wtc:param value="<%=paraIn[1]%>"/> 
    </wtc:service>
    <wtc:array id="tlsHandFeeArr" scope="end"/>
<%
	String oriHandFee="0";
	String oriHandFeeFlag="";
    if(tlsHandFeeArr.length>0 && retCode22.equals("000000"))
	{
	   oriHandFee=tlsHandFeeArr[0][0];
	   oriHandFeeFlag=tlsHandFeeArr[0][1];
       if(Double.parseDouble(oriHandFee) < 0.01)
		   hfrf=true;
	   else
	   {
         if(!WtcUtil.haveStr(favStr,oriHandFeeFlag.trim()))
			hfrf=true;
	   }
	}
    else
	  hfrf=true;

 	//------------��÷������˳�ʼ����Ϣ����-----------
 	//S1210Impl im1210=new S1210Impl();
 	//SPubCallSvrImpl im1210n=new SPubCallSvrImpl();
 	int inputNumber = 4;
	String  inputParsm [] = new String[inputNumber];
  inputParsm[0] = srv_no;
	inputParsm[1] = work_no;
	inputParsm[2] = op_code;
	inputParsm[3] = org_code;
	String   outputNumber = "37";
	String[] initBack = new String[37];
  	//String [] initBack =im1210n.callService("s7136Init",inputParsm,outputNumber,"phone",srv_no);
%>
<wtc:service name="s7136Init" routerKey="phone" routerValue="<%=srv_no%>" retcode="s7136InitCode" retmsg="s7136InitMsg" outnum="37">
	<wtc:param value="<%=inputParsm[0]%>"/>
    <wtc:param value="<%=inputParsm[1]%>"/>
    <wtc:param value="<%=inputParsm[2]%>"/>
    <wtc:param value="<%=inputParsm[3]%>"/>
</wtc:service>
<wtc:array id="s7136InitArr" scope="end" />
<%
  String errCode = s7136InitCode;
  System.out.println("ssssssssssssssssssssserrCode"+errCode);
  String errMsg = s7136InitMsg;
  System.out.println(errMsg);
  
    if(s7136InitArr.length>0 && errCode.equals("000000")){
        for(int i=0;i<s7136InitArr[0].length;i++){
        	if(null == s7136InitArr[0][i]){
        		initBack[i] = "";
        	}
        	else{
            	initBack[i] = s7136InitArr[0][i];
            }
        }
    }
  
  if (!errCode.equals("000000")){
        System.out.println("qqqqqqqqqqqqqqqqqqqqqqqqqqqqq");
        response.sendRedirect("f7136_1.jsp?activePhone="+srv_no+"&ReqPageName=f7136Main&errCode="+String.valueOf(errCode)+"&retMsg="+errMsg);
   	%>
   	
	 <script language="JavaScript">
    <!--
        rdShowMessageDialog("������룺<%=errCode%>������Ϣ��<%=errMsg%>",0);
        history.go(-1);
  	//-->
  </script>
<%	 
 } 
 //	initArr=im1210.s1219Init(srv_no,work_no,op_code,org_code,"phone",srv_no);
	//String[] twoFlag=im1210.s1210Index(srv_no,"phone",srv_no);
%>
        
<%
	String sqlProdId4 = "select b.sel_flag from product_offer_instance a, product_offer_detail b, dcustmsg c "+
	" where a.offer_id = b.offer_id "+
	" and a.eff_date > sysdate "+
	" and b.element_type = '10E' "+
	" and a.serv_id = c.id_no "+
	" and c.phone_no = :vPhoneNo "+
	" and b.element_id = to_number(:vProductID)";
	String [] paraIn4 = new String[2];
    paraIn4[0] = sqlProdId4;    
    paraIn4[1]="vPhoneNo="+srv_no+",vProductID="+initBack[33];
%>
<wtc:service name="TlsPubSelCrm" retcode="err_code10" retmsg="err_message10" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
        <wtc:param value="<%=paraIn4[0]%>"/>
        <wtc:param value="<%=paraIn4[1]%>"/> 
    </wtc:service>
    <wtc:array id="retBindType" scope="end"/>
<%
		String BindType = "";
		if(retBindType.length > 0){
			BindType = retBindType[0][0];
		}
		if(!BindType.equals("0")){
			BindType = "1";
		}
		System.out.println("BindType="+BindType);
		String[] twoFlag = new String[2];
		twoFlag[0] = "0";
		twoFlag[1] = "SUCCESS!";
		String fStr[][] = new String[0][];
		String sq1 = "select trim(attr_code) from dcustMsg where phone_no='?' and substr(run_code,2,1)<'a' and rownum<2";
		String temFlag = "";

%>

    <wtc:pubselect name="spubqry32" retcode="err_code" retmsg="err_message" routerKey="phone" routerValue="<%=srv_no%>" outnum="2">
        <wtc:sql><%=sq1%></wtc:sql>
        <wtc:param value="<%=srv_no%>"/>
    </wtc:pubselect>
    <wtc:array id="sPubQry32Arr" scope="end"/>
<%
			twoFlag[0] = err_code;
			twoFlag[1] = err_message;
			if (Integer.parseInt(err_code) == 0)
				fStr = sPubQry32Arr;
			if (fStr[0][1] == null)
				temFlag = "00000";
			else
				temFlag = fStr[0][1];
			if (!temFlag.equals(""))
			{
				String bigFlag = temFlag.substring(2, 4);
				String grpFlag = temFlag.substring(4, 5);
				System.out.println("bigFlag="+bigFlag);
				String sq2 = "select trim(card_name) from sBigCardCode where card_type='?'";
				String sq3 = "select trim(grp_name) from sGrpBigFlag where grp_flag='?'";
				System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
				System.out.println("bigFlag="+bigFlag);
				System.out.println("grpFlag="+grpFlag);
			
%>
<wtc:pubselect name="sPubMultiSel" retcode="err_code2" retmsg="err_message2" routerKey="phone" routerValue="<%=srv_no%>" outnum="2">
        <wtc:sql><%=sq2%></wtc:sql>
        <wtc:param value="<%=bigFlag%>"/>
</wtc:pubselect>
<wtc:array id="sPubMultiSelArr1" scope="end"/>
<%
System.out.println("*********************************err_message2="+err_message2);
                twoFlag[0] = err_code2;
				if (Integer.parseInt(err_code2) == 0)
				{
					twoFlag[0] = sPubMultiSelArr1[0][0];
				}
%>
<wtc:pubselect name="sPubMultiSel" retcode="err_code3" retmsg="err_message3" routerKey="phone" routerValue="<%=srv_no%>" outnum="2">
        <wtc:sql><%=sq3%></wtc:sql>
        <wtc:param value="<%=grpFlag%>"/>
</wtc:pubselect>
<wtc:array id="sPubMultiSelArr2" scope="end"/>
<%
     System.out.println("*********************************err_message3="+err_message3);
				twoFlag[1] = err_message3;
				if (Integer.parseInt(err_code3) == 0)
				{
					twoFlag[1] = sPubMultiSelArr2[0][0];
				}
			}

	if(twoFlag==null || twoFlag.length==0)
	       response.sendRedirect("s1219Login.jsp?activePhone="+srv_no+"&ReqPageName=s1219Main&retMsg=2");
 	 
 	String sqlProdId1 = "select to_char(b.element_id) element_id from product_offer_instance a, product_offer_detail b, dcustmsg c "+
		" where a.offer_id = b.offer_id "+
		" and a.eff_date > sysdate "+
		" and b.element_type = '10E' "+
		" and a.serv_id = c.id_no "+
		" and c.phone_no = :vPhoneNo";
	String [] paraIn1 = new String[2];
    paraIn1[0] = sqlProdId1;    
    paraIn1[1]="vPhoneNo="+srv_no;
%>
<wtc:service name="TlsPubSelCrm" retcode="err_code7" retmsg="err_message7" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
        <wtc:param value="<%=paraIn1[0]%>"/>
        <wtc:param value="<%=paraIn1[1]%>"/> 
    </wtc:service>
    <wtc:array id="retProdID1" scope="end"/>
<%
     System.out.println("wangzl11111111111111111111111111111");
     String sqlProdId2 = "select to_char(l.element_id) element_id "+
		" from product_offer_instance h, product_offer_relation i, product_offer j, band k, product_offer_detail l, dcustmsg n "+
		" where i.offer_a_id = h.offer_id "+
		" and i.offer_z_id = j.offer_id "+
		" and j.band_id=k.band_id "+
		" and sysdate between j.eff_date and j.exp_date "+
		" and i.relation_type_id = '5' "+
		" and i.group_id in (select m.parent_group_id from dchngroupinfo m "+
		" where trim(m.group_id) = trim(n.group_id)) "+
		" and sysdate between h.eff_date and h.exp_date "+
		" and j.offer_id = l.offer_id "+
		" and l.element_type = '10E' "+
		" and exists(select 1 from sfunclist o where l.element_id = o.product_id and o.command_code = '19') "+
		" and h.serv_id = n.id_no "+
		" and n.phone_no = :vPhoneNo";
	String [] paraIn2 = new String[2];
    paraIn2[0] = sqlProdId2;    
    paraIn2[1]="vPhoneNo="+srv_no;
%>
<wtc:service name="TlsPubSelCrm" retcode="err_code8" retmsg="err_message8" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
        <wtc:param value="<%=paraIn2[0]%>"/>
        <wtc:param value="<%=paraIn2[1]%>"/> 
    </wtc:service>
    <wtc:array id="retProdID2" scope="end"/>
<%
     System.out.println("wangzl2222222222222222222222222222222222");
     String sqlProdId3 = "select trim(to_char(d.element_id)) element_id "+
		" from sRegionNormal a, product_offer b, pricing_combine c, product_offer_detail d "+
		" where to_number(a.mode_code) = b.offer_id "+
		" and b.pricing_plan_id=c.pricing_plan_id "+
		" and c.detail_type = 'Y' "+
		" and c.detail_code = (select h.detail_code from product_offer_instance e,product_offer f, dcustmsg g, pricing_combine h "+
		"  where e.offer_id = f.offer_id "+
		"  and f.offer_type = '10' "+
		"  and sysdate between e.eff_date and e.exp_date "+
		"  and f.pricing_plan_id = h.pricing_plan_id "+
		"  and h.detail_type='Y' "+
		"  and e.serv_id = g.id_no "+
		"  and g.phone_no = :vPhoneNo) "+
		"  and a.region_code = substr(:org_code,1,2) "+
		"  and b.offer_id = d.offer_id "+
		"  and d.element_type = '10E' "+
		"  and exists(select 1 from sfunclist i where d.element_id = i.product_id and i.command_code = '19')";
	String [] paraIn3 = new String[2];
    paraIn3[0] = sqlProdId3;    
    paraIn3[1]="vPhoneNo="+srv_no+",org_code="+org_code;
%>
<wtc:service name="TlsPubSelCrm" retcode="err_code9" retmsg="err_message9" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
        <wtc:param value="<%=paraIn3[0]%>"/>
        <wtc:param value="<%=paraIn3[1]%>"/> 
    </wtc:service>
    <wtc:array id="retProdID3" scope="end"/>
<%
	//System.out.println("yanpx+++++++++++++++++++++++++++"+paraIn3[0]+"|"+paraIn3[1]);
     //-----------��÷��������ط���Ϣ����-------------
     
     vPayCode = initBack[9];
    //String sq1="select trim(FUNCTION_CODE),trim(FUNCTION_NAME),FUNCTION_FEE,decode('"+vPayCode+"','4',0,PREPAY_LIMIT),sm_code,trim(addno_flag) from sFuncList where region_code=substr('"+org_code+"',1,2)  and sm_code='"+initBack[1].trim()+"' and show_flag='Y'  and command_code='19' order by order_code";
    String sq2="select trim(product_id),trim(FUNCTION_NAME),FUNCTION_FEE,decode(:vPayCode,'4',0,PREPAY_LIMIT),sm_code,trim(addno_flag) from sFuncList where region_code=substr(:org_code,1,2)  and sm_code=:sm_code and show_flag='Y'  and command_code='19' and product_id = to_number(:ProductID) order by order_code";
    
	//srvArr=co.sPubSelect("6",sq1,"region",org_code.substring(0,2));
	
    paraIn[0] = sq2;  
    if(retProdID1.length > 0)  
    	paraIn[1]="vPayCode="+vPayCode+",org_code="+org_code+",sm_code="+initBack[1].trim()+",ProductID="+retProdID1[0][0];
    else if(retProdID2.length > 0)  
    	paraIn[1]="vPayCode="+vPayCode+",org_code="+org_code+",sm_code="+initBack[1].trim()+",ProductID="+retProdID2[0][0];
	else
		paraIn[1]="vPayCode="+vPayCode+",org_code="+org_code+",sm_code="+initBack[1].trim()+",ProductID="+retProdID3[0][0];
	
	System.out.println(""+paraIn[1]);
%>
    <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=org_code.substring(0,2)%>" retcode="retCode1" retmsg="retMsg1" outnum="6" >
    	<wtc:param value="<%=paraIn[0]%>"/>
    	<wtc:param value="<%=paraIn[1]%>"/> 
    </wtc:service>
    <wtc:array id="srvStr" scope="end"/>
<%
	//srvStr=(String[][])srvArr.get(0);
    if(srvStr.length==0)
      response.sendRedirect("s1219Login.jsp?activePhone="+srv_no+"&ReqPageName=s1219Main&retMsg=13");
      
   //��ˮ   
   String paraStr[]=new String[1];
	   //comImpl co1=new comImpl();
	   //String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
	   //paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();
%>
	   <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=srv_no%>"  id="seq"/>
<%
    paraStr[0] = seq;
	   System.out.println("11111111111��" +paraStr[0]);   
  %>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
  var js_srv = new Array(new Array(),new Array(),new Array(),new Array(),new Array());
  var aa_info=new Array(new Array(),new Array(),new Array(),new Array(),new Array(),new Array());

  var delStr="";
  var modValidStr="";
  var modInvalidStr="";
  var addValidStr="";
  var addInvalidStr="";
  var addShortnoStr="";

  onload=function()
  {//rdShowMessageDialog(document.all.yu_funccode.value);
  	
  		if(document.all.yu_funccode.value.length == 0)
 	{
 	 		document.all.bz.value = "1";
 	 	document.all.sq.style.display = "";
 	 	document.all.qx.style.display = "none";
	}else
	{
		document.all.bz.value = "0";
		document.all.qx.style.display = "";
		document.all.sq.style.display = "none";
	}
  	functionchg();
 	self.status="";

  	<%
	//-----------��ÿͻ��˷�����Ϣ����-------------
	for(int i=0;i<srvStr.length;i++)
    {
	  for(int j=0;j<srvStr[i].length;j++)
	  {
%>
	    aa_info[<%=j%>][<%=i%>]="<%=srvStr[i][j].trim()%>";
<%
 	  }
	}
%>
	
	

  }

 //-------2--------ʵ����ר�ú���----------------
 function ChkHandFee()
	 {
       if(((document.all.oriHandFee.value).trim()).length>=1 && ((document.all.t_handFee.value).trim()).length>=1)
	   {
         if(parseFloat(document.all.oriHandFee.value)<parseFloat(document.all.t_handFee.value))
	     {
          rdShowMessageDialog("ʵ�������Ѳ��ܴ���ԭʼ�����ѣ�");
		  document.all.t_handFee.value=document.all.oriHandFee.value;
		  document.all.t_handFee.select();
		  document.all.t_handFee.focus();
		  return;
	     }
	   }
	  
	   if(((document.all.oriHandFee.value).trim()).length>=1 && ((document.all.t_handFee.value).trim()).length==0)
	   {
         document.all.t_handFee.value="0";
	   }
	 }
    function getFew()
    {
     if(window.event.keyCode==13)
     {
       var fee=document.all.t_handFee;
       var fact=document.all.t_factFee;
       var few=document.all.t_fewFee;
       if(((fact.value).trim()).length==0)
       {
 	     rdShowMessageDialog("ʵ�ս���Ϊ�գ�");
 	     fact.value="";
	     fact.focus();
	     return;
       }
       if(parseFloat(fact.value)<parseFloat(fee.value))
       {
  	     rdShowMessageDialog("ʵ�ս��㣡");
	     fact.value="";
	     fact.focus();
	     return;
       }

	   var tem1=((parseFloat(fact.value)-parseFloat(fee.value))*100+0.5).toString();
	   var tem2=tem1;
	   if(tem1.indexOf(".")!=-1) tem2=tem1.substring(0,tem1.indexOf("."));
       few.value=(tem2/100).toString();
       few.focus();
	 }
	}
	
/*************liucm add function***************/
 var arrfunccode = new Array();//�ֻ��ͺŴ���
 var arrfuncname = new Array();//�ֻ��ͺ�����
 var arrfuncfee = new Array();//�����̴���
 var arrfunclimt = new Array();
 var arrfuncaddno = new Array();
 <%  
  for(int m=0;m<srvStr.length;m++)
  {
	out.println("arrfunccode["+m+"]='"+srvStr[m][0]+"';\n");
	out.println("arrfuncname["+m+"]='"+srvStr[m][1]+"';\n");
	out.println("arrfuncfee["+m+"]='"+srvStr[m][2]+"';\n");
	out.println("arrfunclimt["+m+"]='"+srvStr[m][3]+"';\n");
	out.println("arrfuncaddno["+m+"]='"+srvStr[m][5]+"';\n");
  }  
  %>
function functionchg(){

   	var x3 ;
   
       for ( x3 = 0 ; x3 < arrfunccode.length  ; x3++ )
   	{
      		if ( arrfunccode[x3] == document.all.function_code.value )
      		{
        		document.all.new_funcname.value=arrfuncname[x3];
        		document.all.new_funcfee.value=arrfuncfee[x3];
        		document.all.new_funclimt.value=arrfunclimt[x3];
        	
        		
      		}
   	}
}

function docheck()
{          
	// in here form check
	var j=0;
	var u=0;
	if(document.all.yu_funccode.value.length == 0){//����
	 	if(document.all.new_begin.value.length==0){
	 			rdShowMessageDialog("�����뿪ʼʱ��");
	 			return false;
		}
		//if(document.all.new_end.value.length==0){
	 			//rdShowMessageDialog("���������ʱ��");
	 			//return false;
		//}
	var d= (new Date().getFullYear().toString()+(((new Date().getMonth()+1).toString().length>=2)?(new Date().getMonth()+1).toString():("0"+(new Date().getMonth()+1)))+(((new Date().getDate()).toString().length>=2)?(new Date().getDate()):("0"+(new Date().getDate()))).toString());
    if(to_date(document.all.new_begin)<=d)
      {
        document.all.new_begin.value="";
        rdShowMessageDialog("��ʼʱ�䲻�����ڵ�ǰʱ�䣬���������룡");
	    document.all.new_begin.focus();
	    return false;
      }
      if(document.all.new_end.value.length>0){
       	if(to_date(document.all.new_begin)>to_date(document.all.new_end))
      	{
       		document.all.new_begin.value="";
       		document.all.new_end.value="";
       		rdShowMessageDialog("��ʼʱ�䲻�����ڽ���ʱ�䣬���������룡");
	   			document.all.new_begin.focus();
	   			return false;
      	}
    	}
      
   
	}else{
		if(document.all.yu_check.checked){
				rdShowMessageDialog("û��ȡ�����ط�������ȷ�ϣ�");
				return false;
		}
	}

}
//ת������
function to_date(obj)
{
    var theTotalDate = "";
    var one = "";
    var flag = "0123456789";
    for (i = 0; i < obj.value.length; i++)
    {
        one = obj.value.charAt(i);
        if (flag.indexOf(one) != -1)
            theTotalDate += one;
    }
    return theTotalDate;
}
/***************liucm end**************/


 //-----------��֤���Ϸ��Ե�ϵ�к���--------------
 function chkCancelStr(i)
 {
	return true;
 }

 function chkMod_ValidStr(i)
 {	
   var d= (new Date().getFullYear().toString()+(((new Date().getMonth()+1).toString().length>=2)?(new Date().getMonth()+1).toString():("0"+(new Date().getMonth()+1)))+(((new Date().getDate()).toString().length>=2)?(new Date().getDate()):("0"+(new Date().getDate()))).toString());
 
   if(document.all.t_st[i].disabled==false && document.all.t_et[i].disabled==false)
   {
     if(document.all.t_st[i].value.length!=0)
     {
      rdShowMessageDialog("��֣��ط�"+i+"���ڿ�ͨ״̬����ʼʱ��ȴ��Ϊ�գ�");
	  return false;
     }
     else
     {
       if(!forDate(document.all.t_et[i]))
	   {
		return false;
	   }
	   else
	   {
         if(to_date(document.all.t_et[i])<=d)
	     {
           rdShowMessageDialog("����ʱ�䲻�����ڵ�ǰʱ�䣬���������룡");
	       document.all.t_et[i].focus();
		   return false;
	     }
	   }
     }
   }
   else if
(document.all.t_st[i].disabled==true && document.all.t_et[i].disabled==false)
   {
      if(((document.all.t_et[i].value).trim()).length>0)
      {
        if(!forDate(document.all.t_et[i]))     
  	      return false;
	 
        if(to_date(document.all.t_et[i])<=d)
        {
         rdShowMessageDialog("����ʱ�䲻�����ڵ�ǰʱ�䣬���������룡");
	     document.all.t_et[i].focus();
		 return false;
        }
	  }
   }
   return true;
 }

 function chkMod_InvalidStr(i)
 {
   if(document.all.t_st[i].disabled==true && document.all.t_et[i].disabled==true)
   {
     return true;
   }
   var d= (new Date().getFullYear().toString()+(((new Date().getMonth()+1).toString().length>=2)?(new Date().getMonth()+1).toString():("0"+(new Date().getMonth()+1)))+(((new Date().getDate()).toString().length>=2)?(new Date().getDate()):("0"+(new Date().getDate()))).toString());
		 
   if(document.all.t_st[i].disabled==false && document.all.t_et[i].disabled==true)
   {
      if(!forDate(document.all.t_st[i])) return false;
	  if(to_date(document.all.t_st[i])<=d)
      {
        document.all.t_st[i].value="";
        rdShowMessageDialog("��ʼʱ�䲻�����ڵ�ǰʱ�䣬���������룡");
	    document.all.t_st[i].focus();
	    return false;
      }
   }
   if(document.all.t_st[i].disabled==false && document.all.t_et[i].disabled==false)
   {
      if(!forDate(document.all.t_st[i])) return false;
	  if(!forDate(document.all.t_et[i])) return false;

      if(to_date(document.all.t_st[i])>=to_date(document.all.t_et[i]))
      {
       document.all.t_st[i].value="";
       document.all.t_et[i].value="";
       rdShowMessageDialog("��ʼʱ�䲻�����ڽ���ʱ�䣬���������룡");
	   document.all.t_st[i].focus();
	   return false;
      }
	  if(to_date(document.all.t_st[i])<=d)
      {
        document.all.t_st[i].value="";
        rdShowMessageDialog("��ʼʱ�䲻�����ڵ�ǰʱ�䣬���������룡");
	    document.all.t_st[i].focus();
	    return false;
      }
	  if(to_date(document.all.t_et[i])<=d)
      {
        document.all.t_et[i].value="";
        rdShowMessageDialog("����ʱ�䲻�����ڵ�ǰʱ�䣬���������룡");
	    document.all.t_et[i].focus();
	    return false;
      }
   }
   if(document.all.t_st[i].disabled==true && document.all.t_et[i].disabled==false)
   {
      if(!forDate(document.all.t_et[i])) return false;

	  if(to_date(document.all.t_et[i])<=d)
      {
        document.all.t_et[i].value="";
        rdShowMessageDialog("����ʱ�䲻�����ڵ�ǰʱ�䣬���������룡");
	    document.all.t_et[i].focus();
	    return false;
      }
   } 
   return true;
 }

 function chkAdd_ValidStr(i)
 {
  if(document.all.t_et[i].disabled==false)
  {
    if(((document.all.t_et[i].value).trim()).length>0)
    {
     if(!forDate(document.all.t_et[i]))
     
  	   return false;
	 
      var d= (new Date().getFullYear().toString()+(((new Date().getMonth()+1).toString().length>=2)?(new Date().getMonth()+1).toString():("0"+(new Date().getMonth()+1)))+(((new Date().getDate()).toString().length>=2)?(new Date().getDate()):("0"+(new Date().getDate()))).toString());
      if(to_date(document.all.t_et[i])<=d)
      {
         rdShowMessageDialog("����ʱ�䲻�����ڵ�ǰʱ�䣬���������룡");
	     document.all.t_et[i].focus();
		 return false;
      }
	}
	
  }
  return true;
 }

 function chkAdd_InvalidStr(i)
 {
   if(document.all.t_st[i].disabled==true && document.all.t_et[i].disabled==true)
   {
     return true;
   }
   var d= (new Date().getFullYear().toString()+(((new Date().getMonth()+1).toString().length>=2)?(new Date().getMonth()+1).toString():("0"+(new Date().getMonth()+1)))+(((new Date().getDate()).toString().length>=2)?(new Date().getDate()):("0"+(new Date().getDate()))).toString());
   if(document.all.t_st[i].disabled==false && document.all.t_et[i].disabled==true)
   {
      if(!forDate(document.all.t_st[i])) return false;
	  if(to_date(document.all.t_st[i])<=d)
      {
        document.all.t_st[i].value="";
        rdShowMessageDialog("��ʼʱ�䲻�����ڵ�ǰʱ�䣬���������룡");
	    document.all.t_st[i].focus();
	    return false;
      }
   }
   if(document.all.t_st[i].disabled==false && document.all.t_et[i].disabled==false)
   {
      if(!forDate(document.all.t_st[i])) return false;
	  if(!forDate(document.all.t_et[i])) return false;

      if(to_date(document.all.t_st[i])>=to_date(document.all.t_et[i]))
      {
       document.all.t_st[i].value="";
       document.all.t_et[i].value="";
       rdShowMessageDialog("��ʼʱ�䲻�����ڽ���ʱ�䣬���������룡");
	   document.all.t_st[i].focus();
	   return false;
      }
	  if(to_date(document.all.t_st[i])<=d)
      {
        document.all.t_st[i].value="";
        rdShowMessageDialog("��ʼʱ�䲻�����ڵ�ǰʱ�䣬���������룡");
	    document.all.t_st[i].focus();
	    return false;
      }
	  if(to_date(document.all.t_et[i])<=d)
      {
        document.all.t_et[i].value="";
        rdShowMessageDialog("����ʱ�䲻�����ڵ�ǰʱ�䣬���������룡");
	    document.all.t_et[i].focus();
	    return false;
      }
   }
   if(document.all.t_st[i].disabled==true && document.all.t_et[i].disabled==false)
   {
      if(!forDate(document.all.t_et[i])) return false;

	  if(to_date(document.all.t_et[i])<=d)
      {
        document.all.t_et[i].value="";
        rdShowMessageDialog("����ʱ�䲻�����ڵ�ǰʱ�䣬���������룡");
	    document.all.t_et[i].focus();
	    return false;
      }
   } 
   return true;
 }

 function chkAdd_ShortnoStr(i)
 {   
   return true;
 }



function printCommit()
{          
    getAfterPrompt();
	// in here form check
	if (docheck()==false)
	{return false;}
	showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");  	 
}

 //--------4---------��ʾ��ӡ�Ի���----------------
 function showPrtDlg(printType,DlgMessage,submitCfm)
 {
	 delStr="";
     modValidStr="";
     modInvalidStr="";
     addValidStr="";
     addInvalidStr="";
     addShortnoStr="";

//forѭ��

     if(((document.all.assuId.value).trim()).length>0)
	 {
        if(document.all.assuId.value.length<5)
		{
          rdShowMessageDialog("֤�����볤������(����5λ)��");
	      document.all.assuId.focus();
		  return false;
		}
	 }

     if(check(frm))
     {
      document.all.t_sys_remark.value="�û�"+"<%=initBack[3].trim()%>"+"�ʷѰ��ط����";
	  if(((document.all.t_op_remark.value).trim()).length==0)
      {
			  document.all.t_op_remark.value="����Ա<%=work_no%>"+"���û�"+"<%=initBack[3].trim()%>"+"�����ʷѰ��ط����"
	  }
	  if(((document.all.assuNote.value).trim()).length==0)
      {
			  document.all.assuNote.value="����Ա<%=work_no%>"+"���û�"+"<%=initBack[3].trim()%>"+"�����ʷѰ��ط����"
	  }
	  
		 
		 //��ʾ��ӡ�Ի��� 
		//var h=150;
		//var w=350;
		//var t=screen.availHeight/2-h/2;
		//var l=screen.availWidth/2-w/2;
        //
		//var printStr = printInfo(printType);
        //
		//var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
		//var path = "<%=request.getContextPath()%>/page/innet/hljPrint.jsp?DlgMsg=" + DlgMessage;
		//var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
		//var ret=window.showModalDialog(path,"",prop);
		
        var h=198;
        var w=400;
        var t=screen.availHeight/2-h/2;
        var l=screen.availWidth/2-w/2;
        
        var pType="subprint";
        var billType="1";
        var sysAccept = "<%=paraStr[0]%>";
        var mode_code = null;
        var fav_code = null;
        var area_code = null;
        var printStr = printInfo(printType);
        var phoneno = "<%=srv_no%>";
        
        var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
        var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
        var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneno+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
        var ret=window.showModalDialog(path,printStr,prop);


		if(typeof(ret)!="undefined")
		{
			if((ret=="confirm")&&(submitCfm == "Yes"))
			{
				if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
				{
					conf();
				}
			}
			if(ret=="continueSub")
			{
				if(rdShowConfirmDialog('ȷ��Ҫ�ύ�ʷѰ��ط������Ϣ��')==1)
				{
					conf();
				}
			}
		}
		else
		{
			if(rdShowConfirmDialog('ȷ��Ҫ�ύ�ʷѰ��ط������Ϣ��')==1)
			{
				conf();
			}
		}
	 }	
 }
 
function setTranPreTimeLine(){
 
	var strPreTime = "";
 	 
 	//ȡ����ԤԼʱ�� 

	 return strPreTime;
 } 
 
//ȡ�����ط�ʱ�� 
function getPreTranName(){
 
	var strPreTranName = "";
 	 
 	//ȡ����ԤԼʱ�� 

	 return strPreTranName;
 } 
 
//ȡ��ԤԼ�ط���Ŀ 
function setCancelTranPreTimeLine(){

	var strLine = "";
	var	strTimeLine = "";
	var strBeginTime = "";
	var  strEndTime = "";
 	//ȡ��ԤԼ�ط���Ŀ 
 	

	
	document.all.strCancelPreName.value  = strLine;
	document.all.strCancelPreTime.value  = strTimeLine;
	 return ;
 } 


//ȡ������Ч��ʱ��
function setTranNowTimeLine(){
 
	var strReturn = "";
	var strInLine = document.all.strTranTmp.value;
  var iPos = 0;
  
  rdShowMessageDialog("strInLine:"+strInLine);
  
  iPos = strInLine.indexOf(",");
  while(iPos != -1){
   	if(strReturn == ""){
   		strReturn+="����";
   	}else{
   		strReturn+=",����"
   	}
   	strInLine = strInLine.substring(strInLine.indexOf(",")+1,strInLine.value.length - strInLine.indexOf(","));
//   	rdShowMessageDialog("strInLine:"+strInLine);
   }

	 return strReturn;
 } 

function printInfo(printType)
{

	document.all.delStr.value=delStr;
	document.all.modValidStr.value=modValidStr;
	document.all.modInvalidStr.value=modInvalidStr;
	document.all.addValidStr.value=addValidStr;
	document.all.addInvalidStr.value=addInvalidStr;
	document.all.addShortnoStr.value=addShortnoStr;
	
    var cust_info="";
    var opr_info="";
    var note_info1="";
    var note_info2="";
    var note_info3="";
    var note_info4="";

    var retInfo = "";
    
    var	strLine = "";
    var	strFullLine = "";
    var	strCancelLine = "";
    var	strAddLIine = "";
    var	strTranLine = "";		  //�����ط�
    var	strTranTimeLine = ""  //�����ط�����ʱ��
  
	//retInfo+="����"+'<%=work_no%>'+"  "+'<%=loginName%>'+"|";
	//retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	
	cust_info+="�ͻ�������" +document.all.cust_name.value+"|";
	cust_info+="�ֻ����룺"+document.all.srv_no.value+"|";
	cust_info+="�ͻ���ַ��"+"<%=initBack[11].trim()%>"+"|";
	cust_info+="֤�����룺"+'<%=initBack[14].trim()%>'+"|";

	document.all.strTmp.value = "";
	document.all.strTmp.value = "�û�Ʒ��: "+document.all.sm_name.value+"  ����ҵ��: �ʷѰ��ط����  ������ˮ: "+document.all.loginAccept.value;
	opr_info+=document.all.strTmp.value+"|";
		
	//����������Ч
	strTranLine = "";
	strAddLIine = retOtherStr(addValidStr,"|",",",aa_info[0],aa_info[1]);
	if (strAddLIine != ""){
		strTranLine+="�����ط�(24Сʱ֮����Ч):"+strAddLIine+" ";
	}else{
		strTranLine+="�����ط�(24Сʱ֮����Ч):"+strAddLIine+" ";
	}	
	opr_info+=strTranLine+"|";
	
	
  //����ԤԼ��Ч
	strTranLine = ""; 
	if(document.all.yu_funccode.value.length == 0){
	strTranLine ="�����ط�(ԤԼ��Ч):" + document.all.new_funcname.value; 
}else{
	strTranLine ="�����ط�(ԤԼ��Ч):" 
}
	opr_info+=strTranLine+"|";
		
	
	//��Чʱ��
	strTranTimeLine = ""
	strTranTimeLine+="��Чʱ��:"+document.all.new_begin.value+"   ����ʱ��:"+document.all.new_end.value;
	opr_info+=strTranTimeLine+"|";	
	
	//ȡ���ط�������Ч
	strCancelLine="";
	strTranLine = "";
	strCancelLine = retOtherStr(delStr,"|",",",aa_info[0],aa_info[1]);
	//if (strCancelLine != ""){
		strTranLine+="ȡ���ط�(24Сʱ֮����Ч):"+document.all.yu_funcname.value+" ";
	//}else{
	//	strTranLine+="ȡ���ط�(24Сʱ֮����Ч):"+strCancelLine+" ";
	//}
	opr_info+=strTranLine+"|";
	
	
	setCancelTranPreTimeLine();
	//ȡ���ط�ԤԼ��Ч
	opr_info+="ȡ���ط�(ԤԼ��Ч):"+"|";
	
	//��Чʱ��
	opr_info+="��Чʱ��:"+document.all.strCancelPreTime.value+"|";			
	
		
	//retInfo+="�޸��ط�����Ч����"+retOtherStr(modValidStr,"|",",",aa_info[0],aa_info[1])+"|";
	//retInfo+="�޸��ط���δ��Ч����"+retOtherStr(modInvalidStr,"|",",",aa_info[0],aa_info[1])+"|";

	//retInfo+=document.all.t_sys_remark.value+"|";
	//if(document.all.radio3.value=="19")
  //{	
	//	retInfo+=document.all.assuNote.value+"  "+document.all.radio2.value+" "+document.all.simBell.value+"|";
	//}else{
	//	 retInfo+=document.all.assuNote.value+" "+document.all.simBell.value+"|";
	//}

    note_info1+="��ע"+"|";
    
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 

	return retInfo;	
}

function retOtherStr(str,tok1,tok2,pack1,pack2)
{

  var num=getTokNums(str,tok1);
  var temStr="";
  var retStr="";
  for(var i=1;i<num+1;i++)
  {
    temStr=oneTok(str,tok1,i).substring(0,2);
    for(var j=0;j<pack1.length;j++)
    {
      if(pack1[j]==(temStr).trim())
      {
        retStr+=pack2[j]+tok2;
	    break;
      }
    }
  }
  if(((retStr).trim()).length==0) return "";
  return retStr.substring(0,retStr.length-1);
}	

 //--------5----------�ύ������-------------------
 function conf()
 {
	 document.all.b_print.disabled=true;
	 document.all.b_clear.disabled=true;
	 document.all.b_back.disabled=true;

	 document.all.delStr.value=delStr;
	 document.all.modValidStr.value=modValidStr;
	 document.all.modInvalidStr.value=modInvalidStr;
	 document.all.addValidStr.value=addValidStr;
	 document.all.addInvalidStr.value=addInvalidStr;
	 document.all.addShortnoStr.value=addShortnoStr;

     frm.action="f7136_conf.jsp";
     frm.submit();
 }

 function canc()
 {
   frm.submit();
 }

 </script>
</head>
<body>
<form name="frm" method="POST" onMouseDown="hideEvent()" onKeyDown="hideEvent()">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">�û���Ϣ</div>
</div>

<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1219Main">
<input type="hidden" name="bz">
<input type="hidden" name="cust_id" id="cust_id" value="<%=initBack[0].trim()%>">
<input type="hidden" name="srv_no" id="srv_no" value="<%=srv_no%>">
<input type="hidden" name="sm_name" id="sm_name" value="<%=initBack[2].trim()%>">
<input type="hidden" name="cust_name" id="cust_name" value="<%=initBack[3].trim()%>">
<input type="hidden" name="iccid" id="iccid" value="<%=initBack[14].trim()%>">
<input type="hidden" name="comm_addr" id="comm_addr" value="<%=initBack[11].trim()%>">
<input type="hidden" name="userPrepay" id="userPrepay" value="<%=initBack[16].trim()%>">
<input type="hidden" name="vSmCode"  value="<%=initBack[1].trim()%>">
<input type="hidden" name="transFeeCode" id="transFeeCode">
<input type="hidden" name="transFeeName" id="transFeeName">
<input type="hidden" name="oriHandFee" id="oriHandFee" value="<%=oriHandFee.trim()%>">
<input type="hidden" name="loginAccept" value="<%=paraStr[0]%>">
<input type=hidden name=simBell value="   �ֻ�������ѡ�ײ��Żݵ�GPRS������ָCMWAP�ڵ����������.  �������أ�1.��������꿨,�ͼ�ֵ88Ԫ������ء�  2.��½������ɣ�wap.hljmonternet.com��ʹ���ֻ�����������ͼ�����ء�������Ѷ�����������������������������ʱ������,������Ϣ�ѣ�����1860��ͨGPRS ��">
<input type=hidden name=worldSimBell value="    �������ҵ��󣬼���Ϊ�ҹ�˾ȫ��ͨǩԼ�ͻ�����ǩԼ������ʹ���ҹ�˾ҵ�񼰲�Ʒ��ͬʱִ���µ����������ߡ������ɵ�Ԥ�����������������������ϣ�ͬʱ�������Ļ����ڻ���ʹ�����޺󷽿�ʹ�á�       ��Э����Ч�������������ʷѱ�׼�������������µ��ʷ�����ִ�С�       ��Ϊȫ��ͨ�ͻ������������ҹ�˾Ϊ���ṩ��������">


<table cellspacing="0">
    <tr> 
        <td nowrap class="blue"> 
            <div align="left">��ͻ���־</div>
        </td>
        <td nowrap> 
            <div align="left"><b><font class="orange"><%=twoFlag[0]%></font></b></div>
        </td>
        <td class=blue nowrap> 
            <div align="left">���ű�־</div>
        </td>
        <td nowrap> 
            <div align="left"><%=twoFlag[1]%></div>
        </td>
    </tr>
    <tr> 
        <td class=blue nowrap> 
            <div align="left">�û�ID</div>
        </td>
        <td nowrap > 
            <div align="left"><%=initBack[0].trim()%></div>
        </td>
        <td class=blue nowrap> 
            <div align="left">�ͻ�����</div>
        </td>
        <td nowrap> 
            <div align="left"><%=initBack[3].trim()%></div>
        </td>
    </tr>
    <tr> 
        <td class="blue" nowrap> 
            <div align="left">��ǰ״̬</div>
        </td>
        <td nowrap > 
            <div align="left"><%=initBack[6].trim()%></div>
        </td>
        <td nowrap class=blue> 
            <div align="left">����</div>
        </td>
        <td nowrap> 
            <div align="left"><%=initBack[8].trim()%></div>
        </td>
    </tr>
    
    
    <tr> 
        <td class=blue nowrap> 
            <div align="left">֤������</div>
        </td>
        <td nowrap> 
            <div align="left"><%=initBack[13].trim()%></div>
        </td>
        <td nowrap class=blue> 
            <div align="left">֤������</div>
        </td>
        <td nowrap> 
            <div align="left"><%=initBack[14].trim()%></div>
        </td>
    </tr>
    
    
    <tr> 
        <td class=blue nowrap> 
            <div align="left">��ǰԤ��</div>
        </td>
        <td nowrap> 
            <div align="left"><%=initBack[16].trim()%></div>
        </td>
        <td nowrap class=blue> 
            <div align="left">��ǰǷ��</div>
        </td>
        <td nowrap > 
            <div align="left"><%=initBack[15].trim()%></div>
        </td>
    </tr>
</table>
<table cellspacing="0">
    <tr style="display:none "> 
        <td class="blue" nowrap> 
            <div align="left">����������</div>
        </td>
        <td nowrap colspan="2"> 
            <input name=assuName v_must=0 v_maxlength=30 v_type="string" maxlength="30" size=20 index="0" value="<%=initBack[19].trim()%>">
        </td>
        <td nowrap class=blue> 
            <div align="left">�����˵绰</div>
        </td>
        <td nowrap colspan="2"> 
            <input name=assuPhone v_must=0 v_maxlength=20 v_type="string" maxlength="20" size=20 index="1" value="<%=initBack[20].trim()%>">
        </td>
    </tr>
    <tr style="display:none "> 
        <td class=blue nowrap> 
            <div align="left">������֤������</div>
        </td>
        <td nowrap colspan="2"> 
            <select name="assuIdType" id="assuIdType"  index="2">
                <wtc:qoption name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="3">
                    <wtc:sql>select trim(ID_TYPE), ID_NAME,ID_NAME from sIdType order by id_type</wtc:sql>
                </wtc:qoption>
            </select>
        </td>
        <td nowrap class=blue style="display:none "> 
            <div align="left">������֤������</div>
        </td>
        <td nowrap colspan="2"> 
            <input name=assuId index="3" value="<%=initBack[22].trim()%>">
        </td>
    </tr>
    <tr style="display:none "> 
        <td nowrap class="blue"> 
            <div align="left">������֤����ַ</div>
        </td>
        <td nowrap colspan="5"> 
            <input name=assuIdAddr  size=60 index="4" value="<%=initBack[23].trim()%>">
        </td>
    </tr>
    <tr style="display:none "> 
        <td nowrap class=blue> 
            <div align="left">��������ϵ��ַ</div>
        </td>
        <td nowrap colspan="5"> 
            <input name=assuAddr index="5" value="<%=initBack[24].trim()%>">
        </td>
    </tr>
    <tr style="display:none"> 
        <td nowrap class=blue> 
            <div align="left">�����˱�ע��Ϣ</div>
        </td>
        <td nowrap colspan="5"> 
            <input name=assuNote0 index="6" value="<%=initBack[25].trim()%>">
        </td>
    </tr>
</table>
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">�ʷ��������ط���Ϣ</div>
</div>
<table cellspacing="0" id="tr_iframe">
    <tr> 
        <th nowrap> 
            <div align="center">����</div>
        </th>
        <th nowrap> 
            <div align="center">����</div>
        </th>
        <th nowrap> 
            <div align="center">��ͨ��־</div>
        </th>
        <th nowrap> 
            <div align="center">���ط�����ʱ��</div>
        </th>
    </tr>
    
    <tr> 
    
        <td nowrap> 
            <div align="center"> 
                <input class=InputGrey type=text name=t_srvno size=5 value="<%=initBack[26].trim()%>" style="text-align:center" readonly>
            </div>
        </td>
        <td nowrap> 
            <div align="center"><%=initBack[32].trim()%></div>
            <input type=hidden type="text" name="t_func_name" size="10" value="<%=initBack[32].trim()%>"  readonly>
        </td>
        
        
        <td nowrap> 
            <div align="center"> 
                <!----------s-----��ͨ״̬-------------------->
                <div align="center"><%=initBack[28].trim()%></div>
                <!----------e-----��ͨ״̬-------------------->
            </div>
        </td>
        <td nowrap> 
            <div align="center"> 
                <!----------s-----�̺���-------------------->
                <div align="center"><%=initBack[27].trim()%></div>
                <!----------e-----�̺���-------------------->
            </div>
        </td>
    </tr>

</table>

</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">�����ط���Ϣ</div>
</div>
<!--**************************Ҫ��Ļ�����ԤԼ��**********************-->
<table id="sq" cellspacing="0">
	<tr align="center"> 
        <th colspan="8"> 
            <div align="center">���԰��������ط�</div>
        </th>
    </tr>
    <tr align="center"> 
        <th nowrap> 
            <div align="center">����</div>
        </th>
        <th nowrap> 
            <div align="center">����</div>
        </th>
        <th nowrap> 
            <div align="center">�·�</div>
        </th>
        <th nowrap> 
            <div align="center">Ԥ��</div>
        </th>
        <th nowrap> 
            <div align="center">��ʼʱ��</div>
        </th>
        <th nowrap> 
            <div align="center">����ʱ��</div>
        </th>
        <th nowrap> 
            <div align="center">��ͨ��־</div>
        </th>
    </tr>
    <tr align="center"> 
        <td>
            <SELECT id="function_code" name="function_code" v_must=1 onchange="functionchg()">  
                <%for(int i = 0 ; i < srvStr.length ; i ++){%>
                    <option value="<%=srvStr[i][0]%>"><%=srvStr[i][0]%>--><%=srvStr[i][1]%></option>
                <%}%>
            </select>
        </td>
        <td>
            <input  class=InputGrey type="text" name="new_funcname" size="10" style="text-align:center" readonly>
        </td>
        <td>
            <input  class=InputGrey type="text" name="new_funcfee" size="10" style="text-align:center" readonly>
        </td>
        <td>
            <input  class=InputGrey type="text" name="new_funclimt" size="10" style="text-align:center" readonly>
        </td>
        <td>
            <input type="text" name="new_begin" size="20"  value="" maxlength=8 v_must=0 v_maxlength=8 v_type=date v_format="yyyyMMdd">
        </td>
        <td>
            <input type="text" name="new_end" size="20"  value="" maxlength=8 v_must=0 v_maxlength=8 v_type=date v_format="yyyyMMdd">
        </td>
        <td>
            <input  class=InputGrey type="text" name="new_off" value="ԤԼ" size="10" style="text-align:center" readonly>
        </td>
    </tr>
</table>
              
<table id="qx" cellspacing="0">
    <tr align="center"> 
        <th colspan="8"> 
            <div align="center">����ȡ�������ط�</div>
        </th>
    </tr>
    <tr align="center"> 
        <th nowrap> 
            <div align="center">ѡ��</div>
        </th>
        <th nowrap> 
            <div align="center">����</div>
        </th>
        <th nowrap> 
            <div align="center">����</div>
        </th>
        <th nowrap> 
            <div align="center">��ʼʱ��</div>
        </th>
        <th nowrap> 
            <div align="center">����ʱ��</div>
        </th>
        <th nowrap> 
            <div align="center">��ͨ��־</div>
        </th>
    </tr>
    <tr align="center"> 
        <td>
            <input   type="checkbox" name="yu_check" checked <%if(BindType.equals("0")){%> disabled <%}%> >
        </td>
        <td>
            <input  class=InputGrey type="text" name="yu_funccode" value="<%=initBack[33].trim()%>" size="10" style="text-align:center" readonly>
        </td>
        <td>
            <input  class=InputGrey type="text" name="yu_funcname" value="<%=initBack[36].trim()%>" size="10" style="text-align:center" readonly>
        </td>
        <td>
            <input  class=InputGrey type="text" name="yu_begin" value="<%=initBack[34].trim()%>" size="10" style="text-align:center" readonly>
        </td>
        <td>
            <input  class=InputGrey type="text" name="yu_end" value="<%=initBack[35].trim()%>" size="10" style="text-align:center" readonly>
        </td>
        <td>
            <input  class=InputGrey type="text" name="yu_off" value="ԤԼ" size="10" style="text-align:center" readonly>
        </td>
    </tr>
</table>

</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">ҵ����Ϣ</div>
</div>
<!--*************liucmend***************-->
<table cellspacing="0">
    <tr> 
        <td nowrap class=blue> 
            <div align="left">������</div>
        </td>
        <td nowrap> 
            <div align="left"> 
                <input type="text" class="InputGrey" name="t_handFee" id="t_handFee" size="16"
                    value="<%=(oriHandFee.trim().equals(""))?("0"):(oriHandFee.trim()) %>" v_type=float <%if(hfrf){%>readonly<%}%> onblur="ChkHandFee()">
            </div>
        </td>
        <td nowrap class="blue"> 
            <div align="left">ʵ��</div>
        </td>
        <td nowrap> 
            <div align="left"> 
                <input type="text" name="t_factFee" id="t_factFee" size="16" onKeyUp="getFew()" v_type=float 
                <%
                    if(hfrf)
                    {									
                %>
                        class="InputGrey" readonly
                <%									 
                    }
                %>
                    >
            </div>
        </td>
        <td nowrap class=blue> 
            <div align="left">����</div>
        </td>
        <td nowrap> 
        <div align="left"> 
            <input type="text" class="InputGrey" name="t_fewFee" id="t_fewFee" size="16" readonly>
        </div>
        </td>
    </tr>
    <tr> 
        <td nowrap class=blue> 
            <div align="left">��&nbsp;&nbsp;ע</div>
        </td>
        <td nowrap colspan="5"> 
            <div align="left"> 
                <input type="text" class="InputGrey" name="t_sys_remark" id="t_sys_remark" size="60" maxlength=30 readonly>
            </div>
        </td>
    </tr>
    <tr style="display:none"> 
        <td nowrap class=blue > 
            <div align="left">�û���ע</div>
        </td>
        <td nowrap colspan="5"> 
            <div align="left"> 
                <input type="text" name="t_op_remark" id="t_op_remark" size="60"  v_maxlength=60  v_type=string  maxlength=60>
            </div>
        </td>
    </tr>
    <tr style="display:none">
        <td nowrap class=blue> 
            <div align="left">�û���ע</div>
        </td>
        <td nowrap colspan="5"> 
            <input name=assuNote v_must=0 v_maxlength=60 v_type="string" maxlength="60" size=60 index="6" value="">
        </td>
    </tr>
    <tr id="footer"> 
        <td colspan="6" > 
            <input class="b_foot" type="button" name="b_print" value="ȷ��&��ӡ" onClick="printCommit();">
            <input class="b_foot" type="button" name="b_clear" value="���" onClick="frm.reset();">
            <input class="b_foot" type="button" name="b_back" value="����" onClick="history.go(-1)">
        </td>
    </tr>
</table>

<input type="hidden" name="radio2" value="�𾴵��û��������ҹ�˾�µ׳��ʣ�����������ʾԤԼȡ�����û���ԤԼȡ���������һ����18:00 �������賿û��������ʾ���ܡ������½⣡">
<input type="hidden" name="radio3" value="">
<input type=hidden name=delStr id=delStr>
<input type=hidden name=modValidStr id=modValidStr>
<input type=hidden name=modInvalidStr id=modInvalidStr>
<input type=hidden name=addValidStr id=addValidStr>
<input type=hidden name=addInvalidStr id=addInvalidStr>
<input type=hidden name=addShortnoStr id=addShortnoStr>
<input type=hidden name=strTmp class="button"  size=60  value="">				
<input type=hidden name=strLengthTmp class="button"  size=60 value="40">	
<input type=hidden name=strTranTmp class="button"  size=60  value="">	
<input type=hidden name=strCancelPreName class="button"  size=100 value="">
<input type=hidden name=strCancelPreTime class="button"  size=100  value="">	

<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
