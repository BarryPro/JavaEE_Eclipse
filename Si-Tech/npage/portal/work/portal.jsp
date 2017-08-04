
<%@ page import="java.util.*"%>

<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page errorPage="/npage/common/errorpage.jsp" %>

<%!
/**  modified by hejwa in 20110725 ��OP����  begin **/

boolean havingPriv(HttpSession session,String opcode)
{
	String[][] func = (String[][])session.getAttribute("favInfo");
	
	for(int i=0;i<func.length;i++)
	{
		if(func[i][0]!=null&& func[i][0].compareTo(opcode)==0)
		{
			return true;
		}
	}
	return false;
}
/**  modified by hejwa in 20110725 ��OP���� end **/
%>

<%
   String workNo = (String)session.getAttribute("workNo");
   String org_code = (String)session.getAttribute("orgCode");
	 String regionCode=org_code.substring(0,2);
	 String cssPath = WtcUtil.repNull((String)session.getAttribute("themePath"));
	 int length1=0;
	 int length2=0; 
%>

<wtc:service name="sIndexFuncSel" outnum="6" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=workNo%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />
	
<%	 
	 String strSql=" SELECT count(*) " 
								+" FROM dservordermsg e,sServOrderState f "
								+" WHERE  e.LOGIN_NO='"+workNo.trim()+"' AND e.order_status = f.status " 
								+" AND f.status in(100,110) and rownum<500 ";
	 System.out.println("strSql=="+strSql);
%>
<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:sql><%=strSql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="retCustOrder" scope="end"/>	

<!-- huangrong add ��ѯ������Ϣ -->	
<%
		String sqlStmt = 
		" SELECT title " + 
	    " FROM dbinfoadm.DMESSAGEPUB A, dbinfoadm.SMSGTYPEDETCODE B, dbinfoadm.DMESSAGEPUBPEOPLE C,"+
	    " dbinfoadm.SCHNWORKFLOWSWITCH D " +
	    " WHERE A.MESSAGE_ID = B.MESSAGE_ID "+
	    " AND A.LOGIN_ACCEPT IN C.MESSAGE_ID "+
	    " AND A.SEND_STATUS = D.SRC_STATUS "+
	    " AND D.FUNC_TYPE = '0' "+
	    " AND C.LOGIN_NO = '"+workNo+"' "+
	    " AND D.FUNC_CODE = '9633' "+
	    " AND IS_READ = 'N' "+
	    "  ORDER BY A.LEVEL_ID, A.BEGIN_TIME DESC ";
%>

		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"   retcode="retCode2" retmsg="retMsg2"  outnum="1">
			<wtc:sql><%=sqlStmt%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result_productMessage" scope="end" />	
<%
					if(retCode2.equals("000000")){
					length1=result_productMessage.length;
					System.out.println("-----------------------------------------------------------------------------"+length1);
					}
			
%>					
				
<!-- huangrong add ��ѯ������� -->	
<%
		String sqlStmt1 = 
		" SELECT A.LOGIN_ACCEPT, A.TITLE, C.GROUP_NAME, B.LOGIN_NAME," + 
		"  D.LEVEL_NAME, A.LOGIN_TIME, A.IS_APPROVAL " +
	    " FROM dbinfoadm.DFAULTREPORTMSG A, DLOGINMSG B, DCHNGROUPMSG C, "+
	    " dbinfoadm.SMSGESIGENCECODE D, dbinfoadm.SCHNWORKFLOWSTATUS E, " +
	    " dbinfoadm.SCHNWORKFLOWSWITCH F "+
	    " WHERE A.LOGIN_NO = B.LOGIN_NO "+
	    " AND B.GROUP_ID = C.GROUP_ID "+
	    " AND A.LEVEL_ID = D.LEVEL_CODE "+
	    " AND A.WF_STATUS = E.WF_STATUS "+
	    " AND A.WF_TYPE = E.WF_TYPE "+
	    " AND F.FUNC_TYPE = '0' "+
	    " AND F.WF_TYPE = A.WF_TYPE "+
	    " AND A.WF_STATUS = F.DEST_STATUS "+
	    " AND A.ACCEPT_LOGIN IN "+
	    " (SELECT LOGIN_NO "+
	    " FROM dbinfoadm.SFAULTREPORTACCEPTDPTMT AAA "+
	    " WHERE AAA.DPTMT_ID IN (SELECT DPTMT_ID "+
	    " FROM dbinfoadm.SFAULTREPORTACCEPTDPTMT AA "+
	    " WHERE 1 = 1)) "+
	    " AND A.ACCEPT_LOGIN IN "+
	    " (SELECT LOGIN_NO "+
	    " FROM dbinfoadm.SFAULTREPORTACCEPTDPTMT AAA "+
	    " WHERE AAA.DPTMT_ID IN "+
	    " (SELECT DPTMT_ID "+
	    " FROM dbinfoadm.SFAULTREPORTACCEPTDPTMT AA "+
	    " WHERE 1 = 1  AND AA.LOGIN_NO = '"+workNo+"')) AND  F.FUNC_CODE = '9666' ORDER BY A.WF_STATUS ASC, LOGIN_TIME DESC ";
%>

		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="7">
			<wtc:sql><%=sqlStmt1%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result_reportName" scope="end" />
<%
					if(retCode3.equals("000000")){
					length2=result_reportName.length;
					System.out.println("-----------------------------------------------------------------------------"+result_reportName.length);
					}
			
%>
<!-- �벻Ҫɾ����ע�ͣ�������ʽ���ҡ� -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">	
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title>�ҵĹ�����</title>
	<link href="/nresources/default/css/portalet.css" rel="stylesheet" type="text/css">
	
	<link href="/nresources/<%=cssPath%>/css/portal.css" rel="stylesheet" type="text/css" />
	<link href="/nresources/<%=cssPath%>/css/block.css" rel="stylesheet" type="text/css" />
	<link href="/nresources/<%=cssPath%>/css/rightmenu.css" rel="stylesheet" type="text/css" />
	<link href="/nresources/<%=cssPath%>/css/jq.ui.datepicker.css" rel="stylesheet" type="text/css" />
	
	<script src="<%=request.getContextPath()%>/njs/system/jquery-1.3.2.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/njs/system/system.js"></script>	
	<script type="text/javascript" src="/njs/si/festival.js"></script>
	
	<script type="text/javascript" src="/njs/extend/jquery/portalet/interface_pack.js"></script>
	<script type="text/javascript" src="/njs/si/core_sitech_pack.js"></script>	
	<script type="text/javascript" src="/njs/extend/jquery/ui.datepicker-zh-CN.js"></script>
	<script type="text/javascript" src="/njs/extend/jquery/ui/ui1.6rc2.js"></script>
	<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
	<script language="JavaScript" src="/njs/si/validate_pack.js"></script>
	<script type="text/javascript" src="/njs/extend/jquery/jquery.form.js"></script>
	<script language="javascript" type="text/javascript" src="/njs/si/autocomplete.js"></script>
	<script language="javascript" type="text/javascript" src="/njs/si/common.js"></script>
	<%-- /**  modified by hejwa in 20110725 ��OP����--��������  begin **/ --%>
	<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/My97DatePicker/WdatePicker.js"></script>
	<%-- /**  modified by hejwa in 20110725 ��OP����--��������  end **/ --%>
	<style type="text/css">
	    
	    /*�Զ����ݼ�*/
        #layer1 
        {
        	position: absolute;
        	top:300px;
            left:400px;
        	width:300px;
        	background-color:#f0f5FF;
        	border: 1px solid #000;
        	z-index: 150;
        }
        
        /*�������ⷴ��*/
        #layer2 
        {
        	position: absolute;
        	top:300px;
            left:200px;
        	width:250px;
        	background-color:#f0f5FF;
        	border: 1px solid #000;
        	z-index: 150;
        }
        /*���ó��ù���*/
        #layer3 
        {
        	position: absolute;
        	top:300px;
            left:200px;
        	width:250px;
        	background-color:#f0f5FF;
        	border: 1px solid #000;
        	z-index: 50;
        }
        #layer8 
        {
        	position: absolute;
        	top:180px;
            left:700px;
        	width:250px;
        	background-color:#f0f5FF;
        	border: 1px solid #000;
        	z-index: 50;
        }
        .layer_handle 
        {
        	background-color:#5588bb;
        	padding:2px;
        	text-align:center;
        	font-weight:bold;
        	cursor: move;
        	color: #FFFFFF;
        	vertical-align:middle;
        }
        
        .layer_content {
        			padding:5px;
        }

        .close {
          float:right;
          text-decoration:none;
          color:#FFFFFF;
        }
    </style>
	<script>	
	<%
	if(retCode.equals("000000"))
	{
		String length = retCustOrder[0][0];
    if(Integer.parseInt(length)>0){
	  %>
		 alert("�˹�����<%=length%>��δ�����������봦�������ҪΪ�û�����������ͨ���ϵ�ָ�����ɡ� ����˱�ҵ����Ҫ����������ͨ�����ŵ�¼�������½Ǵ���'δ��������ѯ->�쳣������ѯ'���г�����������ӪҵԱ��ÿ��Ӫҵ����ǰͨ��'�쳣������ѯ'���ܲ鿴�Ƿ���δ��������");	
    <%
    }
	}
 %>		
</script>	
	
	<%@ include file="/npage/include/public_hotkey.jsp" %>
	<style>
	html,
	body
	{
		_overflow-x:hidden;
	}
	</style>
</head>
<%

/**  modified by hejwa in 20110725 ��OP����--����������  begin **/
String wkSetRetArr = "div1~div9~div6~div10~div5~div4~div7~div11~div3~div8~";
							//��ѯ������Ϣ����������ѡ��
							String wkSetSql = "select wkspace_arr from dwkspace where login_no=:login_no";
							String wkSetParam = "login_no="+workNo;	
							ArrayList wkSetList = new ArrayList();
						%>
							<wtc:service name="TlsPubSelCrm" outnum="1" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeWKSet" retmsg="retMsgWKSet">
						    <wtc:param value="<%=wkSetSql%>"/>
						    <wtc:param value="<%=wkSetParam%>"/>
							</wtc:service>
							<wtc:array id="wkSetReturn" scope="end"/>
						<%	
							
							if("000000".equals(retCodeWKSet)){
								if(wkSetReturn.length>0){
									String[] wkSetArr	= wkSetReturn[0][0].split("~");	
									for(int i=0;i<wkSetArr.length;i++){
											wkSetList.add(wkSetArr[i]);
									}	
								}else{
									String[] wkSetArr	= wkSetRetArr.split("~");	
									for(int i=0;i<wkSetArr.length;i++){
											wkSetList.add(wkSetArr[i]);
									}	
								}
							}
//���ݽ�ɫȨ�޲�ѯ������ģ��

String wkReturnArr[][] = new String[][]{
						{"div1","��ݼ���ʾ","getHotKey.jsp","1"},
						{"div3","��ܰ��ʾ","getNotice2.jsp","1"},
						{"div4","�ҵĳ��ù���","getFavFunc.jsp","1"},
						//{"div5","ϵͳ����","getNotice.jsp","1"},
						//{"div7","��Ϣչ��","getMessage.jsp","1"},
						{"div7","�ص�Ӫ����Ϣ�ͷ�����Ϣ","getHallMessage.jsp","1"},
						{"div8","��������","taskInfo.jsp","2"},
						{"div9","δ��������ѯ","custordersTip.jsp","1"},
						{"div10","������Ϣ","getProduceMessage.jsp","1"},
						{"div11","������","getReportName.jsp","1"},
						{"div6","�����´������¹�����Ϣ","getSysnotice.jsp","1"}
						};
							String powerCode = (String)session.getAttribute("powerCode");
							String wksql = "select a.wkspace_id,a.wkspace_name,a.wkspace_src ,b.WKSPACE_LEN from dwkspacemsg a ,dwkspacerole_rel b  where a.wkspace_id=b.wkspace_id and a.is_effect='1' and b.op_role=(select trim(h.m_rolecode) from dmoprolerela h where h.b_rolecode=:powerCode)   order by order_id ";
							String wkPowerCode = "powerCode="+powerCode;
					
						%>
						<wtc:service name="TlsPubSelCrm" outnum="4" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeWK" retmsg="retMsgWK">
						    <wtc:param value="<%=wksql%>"/>
						    <wtc:param value="<%=wkPowerCode%>"/>
						</wtc:service>
						<wtc:array id="wkReturn" scope="end"/>
							<%
							
	
							/**  modified by hejwa in 20110725 ��OP����--����������  end **/
							%>
<body id="work-portal"><!-- qidp -->
    
<!--�����˵�-->
<DIV class="menu" id=floater onFocus=this.blur() style="display:none;">
<ul>
	<li class="white"><a href="#this">ѡ���������</a>
		<table>
			<tr>
				<td>
					<ul>
											</ul>
				</td>
			</tr>
		</table>
	</li>
</ul>
</DIV>
<br>

<div id="page-warp"><!-- qidp -->

<%
String show8Str = "<div class='item'  id='div8_show'>"+
		        	"<div class='caption'>"+
		        	"	<div class='text'>��������</div>"+
		        	"	<div class='option'>"+
		           "        <div class='sub'>"+
		           "        	<DIV class='li'><a href='#this' id='setTask'><img src='/nresources/"+cssPath+"/images/arrow_set.gif' width='21' height='15' border='0' /></a></DIV>"+
		           "            <DIV><img id='div8_switch' class='closeEl' src='/nresources/"+cssPath+"/images/jia.gif' style='cursor:hand' width='15' height='15'></DIV>"+
		           "            <DIV><img class='hideEl' src='/nresources/"+cssPath+"/images/cha.gif'   style='cursor:hand' width='15' height='15'></DIV>"+
		           "        </div>"+
		        	"	</div>"+
		        	"</div>"+
		        	"<div class='content'>"+
		        	"    <DIV class='itemContent' id='mydiv8'>"+
		        	"		<DIV id='wait5'><img src='/nresources/"+cssPath+"/images/blue-loading.gif'  width='32' height='32'></DIV>"+
		        	"	</DIV>"+
		        	"</div>"+
		        	"</div>";	
					
/*String show5Str ="<div class='item' id='div5_show'>"+
			     "   	<div class='caption'>"+
			     "   		<div class='text'>ϵͳ����</div>"+
			     "   		<div class='option'>"+
			     "               <div class='sub'>"+
			     "                   <DIV class='li'><img id='div5_switch' class='closeEl' src='/nresources/"+cssPath+"/images/jia.gif' style='cursor:hand' width='15' height='15'></DIV>"+
			     "                   <DIV><img class='hideEl' src='/nresources/"+cssPath+"/images/cha.gif'   style='cursor:hand' width='15' height='15'></DIV>"+
			     "               </div>"+
			     "   		</div>"+
			     "   	</div>"+
			     "   	<div class='content'>"+
			     "   	    <DIV class='itemContent' id='mydiv5'>"+
			     "   			<DIV id='wait5'><img src='/nresources/"+cssPath+"/images/blue-loading.gif'  width='32' height='32'></DIV>"+
			     "   		</DIV>"+
			     "   	</div>"+
			     "   </div>		";	        	*/
		        	
String show7Str = "<div class='item'  id='div7_show'>"+
		          " 	<div class='caption'>       "+ 
		        	"	<div class='text'>��Ϣչ��</div>"+ 
		        	"	<div class='option'>"+ 
		          "          <div class='sub'>"+ 
		          "              <DIV class='li'><img id='div7_switch' class='closeEl' src='/nresources/"+cssPath+"/images/jia.gif' style='cursor:hand' width='15' height='15'></DIV>"+ 
		          "              <DIV><img class='hideEl' src='/nresources/"+cssPath+"/images/cha.gif'   style='cursor:hand' width='15' height='15'></DIV>"+ 
		          "          </div>"+ 
		        	"	</div>"+ 
		        	"</div>"+ 
		        	"<div class='content'>"+ 
		        	"    <DIV class='itemContent' id='mydiv7'>"+ 
					"<DIV id='wait7'><img src='/nresources/"+cssPath+"/images/blue-loading.gif'  width='32' height='32'></DIV>"+ 
					"</DIV>"+ 
			      "  	</div>"+ 
			      "  </div>"	;	
String show1Str = "<div class='item'  id='div1_show'>    "+
			       " 	<div class='caption'>"+
			       " 		<div class='text'>��ݼ���ʾ</div>"+
			       " 		<div class='option'>"+
			       "             <div class='sub'>"+
			       "                 <DIV class='li'><a href='#this' id='hotKeyLink'><img src='/nresources/"+cssPath+"/images/arrow_set.gif' width='21' height='15' border='0' /></a></DIV>"+
			       "                 <DIV><img id='div1_switch' class='closeEl' src='/nresources/"+cssPath+"/images/jia.gif' style='cursor:hand' width='15' height='15'></DIV>"+
			       "                 <DIV><img class='hideEl' src='/nresources/"+cssPath+"/images/cha.gif'   style='cursor:hand' width='15' height='15'></DIV>"+
			       "             </div>"+
			       " 		</div>"+
			       " 	</div>"+
			       " 	<div class='content'>"+
			       " 	    <DIV class='itemContent' id='mydiv1'>"+
			       " 			<DIV id='wait1'><img src='/nresources/"+cssPath+"/images/blue-loading.gif'  width='32' height='32'></DIV>"+
			       " 		</DIV>"+
			       " 	</div>"+
			       " </div>"	;
			       
String show4Str = "<div class='item'  id='div4_show'>    "+
			      "  	<div class='caption'>             "+
			      "  		<div class='text'>�ҵĳ��ù���</div>"+
			      "  		<div class='option'>"+
			      "              <div class='sub'>"+
			      "                  <DIV class='li'><a href='#this' id='favFuncLink'><img src='/nresources/"+cssPath+"/images/arrow_set.gif' width='21' height='15' border='0' /></a></DIV>"+
			      "                  <DIV><img id='div4_switch' class='closeEl' src='/nresources/"+cssPath+"/images/jia.gif' style='cursor:hand' width='15' height='15'></DIV>"+
			      "                  <DIV><img class='hideEl' src='/nresources/"+cssPath+"/images/cha.gif'   style='cursor:hand' width='15' height='15'></DIV>"+
			      "              </div>"+
			      "  		</div>"+
			      "  	</div>"+
			      "  	<div class='content'>"+
			      "  	    <DIV class='itemContent' id='mydiv4'>"+
					"	<DIV id='wait4'><img src='/nresources/"+cssPath+"/images/blue-loading.gif'  width='32' height='32'></DIV>"+
					"</DIV>"+
			      "  	</div>"+
			      "  </div>"	;	
String show10Str = "<div class='item'  id='div10_show'>"+
			        "	<div class='caption'>"+
			        "		<div class='text'>������Ϣ</div>"+
			        "		<div class='option'>"+
			        "            <div class='sub'>"+
			        "                <DIV class='li'><img id='div10_switch' class='closeEl' src='/nresources/"+cssPath+"/images/jia.gif' style='cursor:hand' width='15' height='15'></DIV>"+
			        "                <DIV><img class='hideEl' src='/nresources/"+cssPath+"/images/cha.gif'   style='cursor:hand' width='15' height='15'></DIV>"+
			        "            </div>"+
			        "		</div>"+
			        "	</div>"+
			        "	<div class='content'>"+
			        "	    <DIV class='itemContent' id='mydiv10'>"+
			        "		    <DIV id='wait10'><img src='/nresources/"+cssPath+"/images/blue-loading.gif'  width='32' height='32'></DIV>"+
			        "		</DIV>"+
			        "	</div>"+
			        "</div>    ";	
String show3Str = "<div class='item'  id='div3_show'>"+
			      "  	<div class='caption'>"+
			      "  		<div class='text'>��ܰ��ʾ</div>"+
			      "  		<div class='option'>"+
			      "              <div class='sub'>"+
			      "                  <DIV class='li'><img id='div3_switch' class='closeEl' src='/nresources/"+cssPath+"/images/jia.gif' style='cursor:hand' width='15' height='15'></DIV>"+
			      "                  <DIV><img class='hideEl' src='/nresources/"+cssPath+"/images/cha.gif'   style='cursor:hand' width='15' height='15'></DIV>"+
			      "              </div>"+
			      "  		</div>"+
			      "  	</div>"+
			      "  	<div class='content'>"+
			      "  	    <DIV class='itemContent' id='mydiv3'>"+
					"<DIV id='wait3'><img src='/nresources/"+cssPath+"/images/blue-loading.gif'  width='32' height='32'></DIV>"+
					"</DIV>"+
			      "  	</div>"+
			      "  </div>		";	  
String show6Str = "<div class='item'  id='div6_show'>"+
			      "  	<div class='caption'>"+
			      "  		<div class='text'>�����´������¹�����Ϣ</div>"+
			      "  		<div class='option'>"+
			      "              <div class='sub'>"+
			      "                  <DIV class='li'><img id='div6_switch' class='closeEl' src='/nresources/"+cssPath+"/images/jia.gif' style='cursor:hand' width='15' height='15'></DIV>"+
			      "                  <DIV><img class='hideEl' src='/nresources/"+cssPath+"/images/cha.gif'   style='cursor:hand' width='15' height='15'></DIV>"+
			      "              </div>"+
			      "  		</div>"+
			      "  	</div>"+
			      "  	<div class='content'>"+
			      "  	    <DIV class='itemContent' id='mydiv6'>"+
			      "  		    <DIV id='wait6'><img src='/nresources/"+cssPath+"/images/blue-loading.gif'  width='32' height='32'></DIV>"+
			      "  		</DIV>"+
			      "  	</div>"+
			      "  </div>		";	
String show9Str = "<div class='item'  id='div9_show'>"+
			      "  	<div class='caption'>"+
			      "  		<div class='text'>δ��������ѯ</div>"+
			      "  		<div class='option'>"+
			      "              <div class='sub'>"+
			      "                  <DIV class='li'><img id='div9_switch' class='closeEl' src='/nresources/"+cssPath+"/images/jia.gif' style='cursor:hand' width='15' height='15'></DIV>"+
			      "                  <DIV><img class='hideEl' src='/nresources/"+cssPath+"/images/cha.gif'   style='cursor:hand' width='15' height='15'></DIV>"+
			      "              </div>"+
			      "  		</div>"+
			      "  	</div>"+
			      "  	<div class='content'>"+
			      "  	    <DIV class='itemContent' id='mydiv9'>"+
					"<DIV id='wait9'><img src='/nresources/"+cssPath+"/images/blue-loading.gif'  width='32' height='32'></DIV>"+
					"</DIV>"+
			      "  	</div>"+
			      "  </div>		";	    
String show11Str="<div class='item'  id='div11_show'>"+
			     "   	<div class='caption'>"+
			     "   		<div class='text'>������</div>"+
			     "   		<div class='option'>"+
			     "               <div class='sub'>"+
			     "                   <DIV class='li'><img id='div11_switch' class='closeEl' src='/nresources/"+cssPath+"/images/jia.gif' style='cursor:hand' width='15' height='15'></DIV>"+
			     "                   <DIV><img class='hideEl' src='/nresources/"+cssPath+"/images/cha.gif'   style='cursor:hand' width='15' height='15'></DIV>"+
			     "               </div>"+
			     "   		</div>"+
			     "   	</div>"+
			     "   	<div class='content'>"+
			     "   	    <DIV class='itemContent' id='mydiv11'>"+
			     "   		    <DIV id='wait11'><img src='/nresources/"+cssPath+"/images/blue-loading.gif'  width='32' height='32'></DIV>"+
			     "   		</DIV>"+
			     "   	</div>"+
			     "   </div>    	";
			     
   
      		                    		      	       		              
%>
<div id="info">
    <div class="item">
    	<div class="caption">
    		<div class="text">�����������
    		</div>
    	</div>
    	<div class="content">
    		<table>
				<tr>
				<td class="blue">
<%					
if(wkReturn.length==0){
	wkReturn = wkReturnArr;
}

	String lenDivqStr_1 = " <div id='info'>";
	String lenDivqStr_2 = "</div>";
	
	String bdivCls = "";    	
    String bdivCls_1 = "item-col col-1";
    String bdivCls_2 = "item-col col-2";
    String eDivStr = "</div>";
    
    String outStr1 = "";
    String outStr2 = "";
    String outStr3 = "";
    int hi=0;
					if("000000".equals(retCodeWK)){		
										outStr1 += lenDivqStr_1;
										outStr2 += "<div class='"+bdivCls_1+"'>";
										outStr3 += "<div class='"+bdivCls_2+"'>";
									for(int i = 0;i<wkReturn.length;i++){
											String wkspace_id = wkReturn[i][0].trim();
											String wkspace_name = wkReturn[i][1];
											String wkspace_src = wkReturn[i][2];
											String wkspace_len = wkReturn[i][3].trim();
									if(wkspace_len.equals("2")){
										if(wkspace_id.equals("div1")){
											outStr1 += show1Str;
										}else if(wkspace_id.equals("div10")){
											outStr1 += show10Str;
										}else if(wkspace_id.equals("div11")){
											outStr1 += show11Str;
										}else if(wkspace_id.equals("div3")){
											outStr1 += show3Str;
										}else if(wkspace_id.equals("div4")){
											outStr1 += show4Str;
										}
										/*else if(wkspace_id.equals("div5")){
											outStr1 += show5Str;
										}*/
										else if(wkspace_id.equals("div6")){
											outStr1 += show6Str;
										}else if(wkspace_id.equals("div7")){
											outStr1 += show7Str;
										}else if(wkspace_id.equals("div8")){
											outStr1 += show8Str;
										}else if(wkspace_id.equals("div9")){
											outStr1 += show9Str;
										}
									}else if(wkspace_len.equals("1")){
										hi++;
										System.out.println("-------hi------"+hi+"----hi%2----"+(hi%2));
										if(hi%2==1){
											if(wkspace_id.equals("div1")){
												outStr2 +=show1Str;
											}else if(wkspace_id.equals("div10")){
												outStr2 +=show10Str;
											}else if(wkspace_id.equals("div11")){
												outStr2 +=show11Str;
											}else if(wkspace_id.equals("div3")){
												outStr2 +=show3Str;
											}else if(wkspace_id.equals("div4")){
												outStr2 +=show4Str;
											}
											/*else if(wkspace_id.equals("div5")){
												outStr2 +=show5Str;
											}*/
											else if(wkspace_id.equals("div6")){
												outStr2 +=show6Str;
											}else if(wkspace_id.equals("div7")){
												outStr2 +=show7Str;
											}else if(wkspace_id.equals("div8")){
												outStr2 +=show8Str;
											}else if(wkspace_id.equals("div9")){
												outStr2 +=show9Str;
											}	
										}else{
											if(wkspace_id.equals("div1")){
												outStr3+=show1Str;
											}else if(wkspace_id.equals("div10")){
												outStr3 +=show10Str;
											}else if(wkspace_id.equals("div11")){
												outStr3 +=show11Str;
											}else if(wkspace_id.equals("div3")){
												outStr3 +=show3Str;
											}else if(wkspace_id.equals("div4")){
												outStr3 +=show4Str;
											}
											/*else if(wkspace_id.equals("div5")){
												outStr3 +=show5Str;
											}*/
											else if(wkspace_id.equals("div6")){
												outStr3 +=show6Str;
											}else if(wkspace_id.equals("div7")){
												outStr3 +=show7Str;
											}else if(wkspace_id.equals("div8")){
												outStr3 +=show8Str;
											}else if(wkspace_id.equals("div9")){
												outStr3 +=show9Str;
											}	
										}
										
									}
												
											
%>											
    				<input   type="checkbox"  name="<%=wkspace_id%>"  v_name="<%=wkspace_name%>" id="<%=wkspace_id%>"  style='cursor:hand' <%if(wkSetList.contains(wkspace_id)){%>checked<%}%> > <%=wkspace_name%></a></li>
<%
}

outStr1 += lenDivqStr_2;
outStr2 += eDivStr;
outStr3 += eDivStr;

}



%>    				
				</td>
			</tr>
		</table>
    	</div>
    </div>
</div>

	
<div id="info">
    <div class="item">
    	<div class="caption">
    		<div class="text">�ҵ���Ϣ
    		</div>
    	</div>
    	<div class="content">
    	    <DIV class="itemContent" id="mydiv0">
		 		<DIV id="wait0"><img src="/nresources/<%=cssPath%>/images/blue-loading.gif"  width="32" height="32"></DIV>
		    </DIV>
    	</div>
    </div>
</div>



<div id='more-info-items'>
	
<%=outStr1%>
<%=outStr2%>
<%=outStr3%>
    
    
</div>


<!--�Զ����ݼ�-->
	<DIV id="layer1" style="display:none" >
		<DIV id="layer1_handle" class="layer_handle" >			
			<a href="#this" id="close1" class="close" >[ x ]</a>
			�Զ����ݼ�
		</DIV>
		<DIV class="layer_content" >
			<form id="layer1_form" method="post" action="setHotKey.jsp">
<%if(retCode.equals("000000")){
		if(result.length>0){
%>			
				<table width=90% >
					<tr>
						<td>��ݼ�</td>
						<td>����</td>
					</tr>
					<tr>
						<td>
							Ctrl+0
						</td>
						<td>
							<select name="Ctrl0">
							<%for(int i=0;i<result.length;i++){%>
															<option value='<%=result[i][0]%>' <%if(i==0)out.print("selected");%> ><%=result[i][0]%>-<%=result[i][1]%></option>	
							<%}%>
							</select>
						</td>
					</tr>
					<tr>
						<td>Ctrl+1</td>
						<td>
							<select name="Ctrl1" >
						<%for(int i=0;i<result.length;i++){%>
														<option   value='<%=result[i][0]%>'   <%if(i==1)out.print("selected");%> ><%=result[i][0]%>-<%=result[i][1]%></option>	
						<% }%>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							Ctrl+2
						</td>
						<td>
							<select name="Ctrl2" >
<%for(int i=0;i<result.length;i++){%>
								<option   value='<%=result[i][0]%>'   <%if(i==2)out.print("selected");%> ><%=result[i][0]%>-<%=result[i][1]%></option>	
<% }%>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							Ctrl+3
						</td>
						<td>
							<select  name="Ctrl3" >
<%for(int i=0;i<result.length;i++){%>
								<option   value='<%=result[i][0]%>'   <%if(i==3)out.print("selected");%> ><%=result[i][0]%>-<%=result[i][1]%></option>	
<% }%>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							Ctrl+4
						</td>
						<td>
							<select  name="Ctrl4" >
<%for(int i=0;i<result.length;i++){%>
								<option   value='<%=result[i][0]%>'   <%if(i==4)out.print("selected");%> ><%=result[i][0]%>-<%=result[i][1]%></option>	
<% }%>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							Ctrl+5
						</td>
						<td>
							<select  name="Ctrl5" >
<%for(int i=0;i<result.length;i++){%>
								<option   value='<%=result[i][0]%>'   <%if(i==5)out.print("selected");%> ><%=result[i][0]%>-<%=result[i][1]%></option>	
<% }%>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							Ctrl+6
						</td>
						<td>
							<select   name="Ctrl6" >
<%for(int i=0;i<result.length;i++){%>
								<option   value='<%=result[i][0]%>'   <%if(i==6)out.print("selected");%> ><%=result[i][0]%>-<%=result[i][1]%></option>	
<% }%>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							Ctrl+7
						</td>
						<td>
							<select   name="Ctrl7" >
<%for(int i=0;i<result.length;i++){%>
								<option   value='<%=result[i][0]%>'   <%if(i==7)out.print("selected");%> ><%=result[i][0]%>-<%=result[i][1]%></option>	
<% }%>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							Ctrl+8
						</td>
						<td>
							<select   name="Ctrl8" >
<%for(int i=0;i<result.length;i++){%>
								<option   value='<%=result[i][0]%>'   <%if(i==8)out.print("selected");%> ><%=result[i][0]%>-<%=result[i][1]%></option>	
<% }%>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							Ctrl+9
						</td>
						<td>
							<select  name="Ctrl9" >
<%for(int i=0;i<result.length;i++){%>
								<option   value='<%=result[i][0]%>'   <%if(i==9)out.print("selected");%> ><%=result[i][0]%>-<%=result[i][1]%></option>	
<% }%>
							</select>
						</td>
					</tr>
					<tr>
						<td align=center colspan=2>
								<input type="button" id=save1 name="submit" value="����" >
						</td>
					</tr>
				</table>
<% }
}%>
			</form>
		</DIV>
	</DIV>
	
	
<!--�������ⷴ��-->
	<DIV id="layer2" style="display:none" >
		<DIV id="layer2_handle"class="layer_handle"  >			
			<a href="#this" id="close2" class="close" >[ x ]</a>
			�������ⷴ��
		</DIV>
		<DIV class="layer_content" >
			<form id="layer2_form" method="post" action="">
				<table width=90% >			
		     <tr>
	         <td>
	              �������
	         </td>
	         <td>
			     	<input name=bugsubject   type="text"  maxlength="15"  v_type="String" v_must=1 >
	         </td>
			 	 </tr>
			 	 <tr>
         	<td>
          	���⼶��
          </td>
          <td>
					  <select name="buglevel">
					    <option value='L'>��</option>	
					    <option value='M'>��</option>	
					    <option value='H'>��</option>	
						</select>
          </td>
			 		</tr>
			 		<tr>
          	<td>
            	��������
            </td>
            <td>
						  <select name="pater_id">
						    <option value='0'>������</option>	
							</select>
            </td>
			 		</tr>
			 		<tr>
          	<td>
            	��������
            </td>
            <td>
		          <textarea name="bugContent"   rows=10 cols= 20  > </textarea>
            </td>
			 		</tr>
					<tr >
						<td align=center colspan=2>
								<input type="button" id=save2 name="submit" value="ȷ��" >
						</td>
					</tr>
				</table>
			</form>
		</DIV>
	</DIV>
	<DIV id="layer8" style="display:none" >
		<DIV id="layer8_handle" class="layer_handle" >			
			<a href="#this" id="close8" class="close"  >[ x ]</a>
			����������ʾ
		</DIV>
		<DIV class="layer_content" >
			<form id="layer8_form" method="post" >
				<table width=90% >
						<td align=center colspan=2>
							  <input type="button" id=save8 name="submit1" value="��ʾ��" onclick="setTaskf('showInWeek')">
							  <input type="button" id=save8 name="submit1" value="��ʾ��" onclick="setTaskf('showInMonth')"  >
						</td>
					</tr>
				</table>
			</form>
		</DIV>
	</DIV>
</div><!-- qidp -->

	
<!--���ó��ù���-->
	<DIV id="layer3" style="display:none" >
		<DIV id="layer3_handle" class="layer_handle" >			
			<a href="#this" id="close3" class="close" onclick="close3Div()" >[ x ]</a>
			�����ù���
		</DIV>
		<DIV class="layer_content" >
			<form id="layer3_form" method="post" >
				 <input type='hidden'  id='manageflag' name='manageflag' value=''/> 
				<table width=90% >
					<tr>
					  <td>
             ���빦�ܴ���
            </td>
				<td   nowrap="nowrap">
		          <input type='text' id='tb' onFocus="clearQuickNav()"  style='font-family:verdana;width:120px;font-size:12px'  value=''/> 
						  <input type='hidden' id='tb_h'    value='-1'/>
						  <input type='hidden' id='function_code1'  name='function_code'    value=""/>  
						  <input type='hidden'  name='op_type'  id="op_type"  value=""/>  
						  
		        </td>
		     </tr>
		     <tr>
		     	<td>ѡ�����</td>
						<td nowrap="nowrap">
							 <select name="selCls"  style='width:120px;'>
				 			<option value='2'>��ѯ��</option>
				 			<option value='1'>ҵ����</option>
				 			<option value='0'>δ����</option>
				 		</select>
						</td>
					</tr>
					 <tr >
						<td align=center colspan=3>
							  <input type="button" id=save3 name="submit1" value="���"  >
								<!--<input type="button" id=save6 name="submit2" value="ɾ��"  > -->
						</td>
					</tr>
				</table>
			</form>
		</DIV>
	</DIV>
</div><!-- qidp -->

<script>
	$("#wait1").hide();
	/*
	var setdd=document.getElementById("setDD");
	function ddhide()
	{
		var ddshow=document.getElementById("showDD");
		ddshow.onclick=function()
		{	
			if(setdd.style.display=='none')
			{
				setdd.style.display='block';
			}
			else
			{
				setdd.style.display='none';
			}
		}
	} 
	ddhide(); 
	*/
</script>
<script type="text/javascript">
	
	
	<%-- /**  modified by hejwa in 20110725 ��OP����--����������  begin **/ --%>
	function setTaskf(funcName){
		$("#mydiv8").load("taskInfo.jsp?funcName="+funcName);
		$("#layer8").hide();
	}
	var _jspPage = {
		<%
		if("000000".equals(retCodeWK)){
				for(int i = 0;i<wkReturn.length;i++){
						String wkspace_id = wkReturn[i][0];
						String wkspace_name = wkReturn[i][1];
						String wkspace_src = wkReturn[i][2];	
						if(i==0){
							out.print("'"+wkspace_id.trim()+"_switch':['my"+wkspace_id.trim()+"','"+wkspace_src+"','f']");
						}else{
							out.print(",'"+wkspace_id.trim()+"_switch':['my"+wkspace_id.trim()+"','"+wkspace_src+"','f']");
						}
				}
		}
		%>
	}
	
	/*
	var _jspPage = {
	 "div1_switch":["mydiv1","getHotKey.jsp","f"]
	,"div3_switch":["mydiv3","getNotice2.jsp","f"]
	,"div4_switch":["mydiv4","getFavFunc.jsp","f"]
	,"div7_switch":["mydiv7","getMessage.jsp","f"]
	,"div5_switch":["mydiv5","getNotice.jsp","f"]
	,"div10_switch":["mydiv10","getProduceMessage.jsp","f"]	
	,"div6_switch":["mydiv6","getSysnotice.jsp","f"]
	,"div9_switch":["mydiv9","custordersTip.jsp","f"]	
	,"div11_switch":["mydiv11","getReportName.jsp","f"]	
	};
	*/
	
	//Ĭ��ȫ�����ܵ�Ϊ��������,����Ȩ�����þ����Ƿ���ʾ
	function wkdivHide(){
		$("#div1_show").hide();
		$("#div3_show").hide();
		$("#div4_show").hide();
		$("#div5_show").hide();
		$("#div6_show").hide();
		$("#div7_show").hide();
		
		$("#div8_show").hide();
		$("#div9_show").hide();
		$("#div10_show").hide();
		$("#div11_show").hide();
	}
	
	//�������ù��ܵ���ʾ
	function wkdivShow(){
		<%
		if("000000".equals(retCodeWK)){
				for(int i = 0;i<wkReturn.length;i++){
						String wkspace_id = wkReturn[i][0];
						if(wkSetList.contains(wkspace_id)){//������������ñ�dwkspace��������ѡ��������ʾ
						%>
							$("#<%=wkspace_id%>_show").show();
							$("#<%=wkspace_id%>_show").children().find("div:eq(0)").text("<%=wkReturn[i][1]%>");
						<%
						}
				}
		}
		%>
	}
	
	//���ù�����
	function setWkSpaceDiv(wkspace_id,checkinfo){
		var packet =  new AJAXPacket("setWkspaceDiv.jsp");
		packet.data.add("wkspace_id",wkspace_id);
		packet.data.add("checked",checkinfo);
		core.ajax.sendPacket(packet,doSet,true);
		packet = null;
	}
	
	function doSet(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode=="000000"){
								
			}else{
				rdShowMessageDialog('����ʧ��!',0);
			}
	}
	<%-- /**  modified by hejwa in 20110725 ��OP����--����������  end **/ --%>
	
	
	
	
	function hiddenSpider()
	{
		if(document.getElementById("mydiv1")!=null)
			document.getElementById("mydiv1").style.display='none'; 
		if(document.getElementById("mydiv3")!=null)	
			document.getElementById("mydiv3").style.display='none';
		if(document.getElementById("mydiv4")!=null)	
			document.getElementById("mydiv4").style.display='none';
		if(document.getElementById("mydiv5")!=null)			
			document.getElementById("mydiv5").style.display='none';
		if(document.getElementById("mydiv10")!=null)	
			document.getElementById("mydiv10").style.display='none';		
		if(document.getElementById("mydiv6")!=null)	
			document.getElementById("mydiv6").style.display='none';
		if(document.getElementById("mydiv9")!=null)	
			document.getElementById("mydiv9").style.display='none';
		if(document.getElementById("mydiv11")!=null)	
			document.getElementById("mydiv11").style.display='none';		
		if(document.getElementById("mydiv7")!=null)	
			document.getElementById("mydiv7").style.display='none';	
		if(document.getElementById("mydiv8")!=null)	
			document.getElementById("mydiv8").style.display='none';	
	}

/** add by hejwa 2011-7-26 ��ܰ��ʾ���� begin **/
var promptTime = new Array();//��ʾʱ��
var promptTitle = new Array();//��ʾ����
var promptContent = new Array();//��ʾ����	
//������ܰ��ʾ
function  showPrompt()
{
	var packet = new AJAXPacket("getPrompt.jsp");
		packet.data.add("checked","");
		core.ajax.sendPacket(packet,doShowPrompt,true);
    	packet =null;
}

function doShowPrompt(packet){
  promptTime = packet.data.findValueByName("promptTime"); 
  promptTitle = packet.data.findValueByName("promptTitle"); 
  promptContent = packet.data.findValueByName("promptContent"); 
  var retCode = packet.data.findValueByName("retCode"); 
  var retMsg = packet.data.findValueByName("retMsg");
  if(retCode!="000000"){//��ѯʧ��
  	rdShowMessageDialog("��ѯʧ��<br>������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
  	return false;
  }  
}

//�˷���ÿһ������һ�Σ�����ʱ��Ƚϣ�����ʾ��Ϣ����
function showPrompting(promptTime,promptTitle,promptContent){
  var promptLength = promptTime.length;
	var digital = new  Date();
	var year = digital.getYear();
	var month = digital.getMonth()+1;
	var dates = digital.getDate();
	//var time = digital.toLocaleTimeString();
	var hours = digital.getHours();
	var minus = digital.getMinutes();
	var ss = digital.getSeconds();
	if(month<10){
  		month = "0"+month;
  	}
  if(dates<10){
  		dates = "0"+dates;
  }
  if(hours<10){
  		hours = "0"+hours;
  	}
	if(minus<10){
  		minus = "0"+minus;
  	}
  if(ss<10){
  		ss = "0"+ss;
  	}
  	//alert("promptTime "+promptTime+"\n��ʾʱ��   "+year+"-"+month+"-"+dates+" "+hours+":"+minus+":"+ss);
	for(var i = 0; i < promptLength; i++){
		//��ǰʱ�������ʾʱ�䣬����ʾ��Ϣ
		if(year+"-"+month+"-"+dates+" "+hours+":"+minus+":"+ss == promptTime[i]){
				rdShowMessageDialog(promptContent[i],2);
		}
	}
	//ÿһ������һ��
	setTimeout("showPrompting(promptTime,promptTitle,promptContent)",1000);
}
/** add by  hejwa 2011-7-26  ��ܰ��ʾ���� end **/


$(document).ready(function () {
		//���ؽ�����
		hiddenSpider();
		//$('.set').bind('click',hiden);
		
		$('img.closeEl').bind('click', toggleContent);

		$('img.hideEl').bind('click', hideContent);
 /**  modified by hejwa in 20110725 ��OP����--����������  begin **/ 
 	  $("input[type='checkbox']").bind('click',hiden);
	  wkdivHide()
	  wkdivShow();
	  $('#setTask').click(function()
		{
			var tSrc = $("#div8_switch").attr("src").trim();
			tSrc = tSrc.substring(tSrc.lastIndexOf("/")+1,tSrc.length);
			if(tSrc=="jian.gif"){
				$("#layer8").show();
			}else{
				rdShowMessageDialog("����չ����������");
			}
		});
		$('#close8').click(function(){
				$("#layer8").hide();
		});
 /**  modified by hejwa in 20110725  ��OP����--����������  end **/ 
//begin huangrong add �����ж����������Ϣ�����ݴ�������ҳ��ֱ��չʾ�� 2011-3-1		
			if(<%=length1%>!=0)
			{
				var div10_switch=document.getElementById("div10_switch");
				div10_switch.click();
			}

			if(<%=length2%>!=0)
			{
				var div11_switch=document.getElementById("div11_switch");
				div11_switch.click();
			}

//end huangrong add �����ж����������Ϣ�����ݴ�������ҳ��ֱ��չʾ��				
		$('DIV.groupWrapper').Sortable({
				accept: 'groupItem',
				helperclass: 'sortHelper',
				activeclass : 	'sortableactive',
				hoverclass : 	'sortablehover',
				handle: 'DIV.itemHeader',
				opacity: 0.7,
				tolerance: 'intersect',
				onChange : function(ser)
				{
				},
				onStart : function()
				{
					$.iAutoscroller.start(this, document.getElementsByTagName('body'));
				},
				onStop : function()
				{
					$.iAutoscroller.stop();
				}
		});
		
		/*
		 *��ݼ���ʾ
		 */
		$('#hotKeyLink').click(function(){
				$("#layer1").show();
			});
			
		/*
		$('#layer1').Draggable({
						zIndex: 	20,
						ghosting:	false,
						opacity: 	0.7,
						handle:	'#layer1_handle'
		 });	
		*/
		
		$('#save1').click(function(){
       $("#layer1").hide();
			 var options = {
			    url:'setHotKey.jsp',	
			    dataType: 'script',					
			    success: function(ret_code) {
			    	       	ret_code=ret_code.trim();
						    	 	if(ret_code.trim()=="000000"){
						    	  	$("#mydiv1").load("getHotKey.jsp");							    	   							    	  							 
						    	    rdShowMessageDialog("��ݼ����óɹ�",2);
						    	    //parent.getSetSelf();
						    	    //��ݼ���������
						    	    parent.getHotKey();
						    	  }else if(ret_code=="999999"){
						    	    rdShowMessageDialog("��ݼ�����ʧ��,������!",0);	
						       	}
					 }
			    };
		    $('#layer1_form').ajaxSubmit(options);
		}); 		
		
		$('#close1').click(function(){
				$("#layer1").hide();
		});
			
				
	  /*
	   *���ⷴ��
	   */
	  $('#close2').click(function(){
				$("#layer2").hide();
			});
			  
		$('#layer2').Draggable({
						zIndex: 	20,
						ghosting:	false,
						opacity: 	0.7,
						handle:	'#layer2_handle'
		});	

		$('#setdiv2').click(function(){
			$("#layer2").show();
		});
 
 		//����
		$('#save2').click(function(){
       $("#layer2").hide();
			 var options = {	
			    url:'setBugData.jsp',	
			    dataType: 'html',					
			    success: function(ret_code){
				    	       ret_code=ret_code.trim();
							    	 if(ret_code.trim()=="000000"){
							    	   	$("#mydiv2").load("getBugData.jsp");
							    	    rdShowMessageDialog("�����������óɹ�",2);
							    	  }else if(ret_code=="999999"){
							    	    rdShowMessageDialog("������������ʧ��,������!",0);	
							       }
								 }
			    };
		    $('#layer2_form').ajaxSubmit(options);
		}); 
		
		//ɾ��
		$('#deldiv2').click(function()
		{
			// by shibc ����checked��֤bug
			if(document.all.checkbug.length==undefined)
			{
				if(!document.all.checkbug.checked)
				{
					rdShowMessageDialog("û��ѡ������,��ѡ��!",0);	
					return false;
				}
			}
			else
			{
				var checklen = document.all.checkbug.length;
				var checkflag=false;
				for(var checkindex=0;checkindex<checklen;checkindex++)
				{
					if(document.all.checkbug[checkindex].checked)
					{
						checkflag=true;
						break;
					}
				}
				if(!checkflag)
				{
					rdShowMessageDialog("û��ѡ������,��ѡ��!",0);	
			 		return false;
				}

			}
			
			  var options = {
			    url:'delBugData.jsp',	
			    dataType: 'script',
			    success: function(ret_code) {
				    	       ret_code=ret_code.trim();
							    	 if(ret_code.trim()=="000000"){
							    	    $("#mydiv2").load("getBugData.jsp");
							    	    rdShowMessageDialog("ɾ������ɹ�",2);
							    	  }else if(ret_code=="999999"){
							    	    rdShowMessageDialog("ɾ����������ʧ��,������!",0);
							       }
					 }
			    };
		    $('#bug_form').ajaxSubmit(options);         // �ύ��			   
		 }); 		
		
		
    /*
     *�ҵĳ��ù���
     */
		$('#layer3').Draggable({
						zIndex: 	20,
						ghosting:	false,
						opacity: 	0.7,
						handle:	'#layer3_handle'
		});	
	
		$('#close3').click(function(){
				$("#layer3").hide();
		});
		
			
		//���ٵ���
		var quickFlag = true;
		
		$('#favFuncLink').click(function()
		{
			if(parent.content_array==undefined)
			{
				parent.document.getElementById('tb').focus();
				rdShowMessageDialog("���ȼ�����ٵ�¼������!");
				$("#layer3").hide();
			}
			if(quickFlag&&parent.content_array!=undefined)
			{
				quickFlag=false;
				op_array = parent.opStr_quick;
				content_array = parent.content_array;
				var obj = actb(document.getElementById('tb'),document.getElementById('tb_h'),eval(op_array));
			}
			
			if(!quickFlag&&parent.content_array!=undefined)
			{
				$("#layer3").show();
				$('#tb').focus();
			}
		});
		
		//����
		$('#save3').click(function()
		{
			 op_array = parent.opStr_quick;
			 content_array = parent.content_array;
			
			 document.getElementById('manageflag').value="i";
			 var arr=content_array[document.getElementById('tb_h').value];
			 if((typeof(arr)=='undefined')||(typeof(arr.length)=='undefined')||arr.length<2)			 
			 {	
			 		rdShowMessageDialog("���ܴ��벻��Ϊ�գ�����������!",1);
			 		document.getElementById('tb').focus();
			 		return false;
			 }
			 document.getElementById('function_code1').value=arr[1];
			 
			 $("#op_type").val("i");
       		 $("#layer3").hide();
			 var options = {
			    url:'favfunc_cfm.jsp',	
			    dataType: 'script',					
			    success: function(retCode) {
			    	
			    	retCode = retCode.trim();
							    	 if(retCode.trim()=="000000"){
	                      $("#mydiv4").load("getFavFunc.jsp");
	                      parent.doFavfuncshow(retCode,"");
	                      //parent.getFavFunc();
							    	    //rdShowMessageDialog("���ù������óɹ�",2);
							    	    if(document.getElementById('tb_h').value!=-1)
												{
												document.getElementById("tb").value="";
												}
							    	  }else if(retCode=="999999"){
							    	   // rdShowMessageDialog("���ù�������ʧ��,������!",0);	
							       }
					 }
			    };
		    $('#layer3_form').ajaxSubmit(options);
		}); 
			
		//ɾ��
		$('#save6').click(function()
		{
			 document.getElementById('manageflag').value="d";
			 var arr=content_array[document.getElementById('tb_h').value];
			 if((typeof(arr)=='undefined')||(typeof(arr.length)=='undefined')||arr.length<2)			 {			 	 rdShowMessageDialog("���ܴ��벻��Ϊ�գ�����������!",1);			 	 	document.getElementById('tb').focus();			 	 return false;			}
			 document.getElementById('function_code1').value=arr[1];
			 
			  $("#op_type").val("d");
       $("#layer3").hide();
			 var options = {	
			    url:'favfunc_cfm.jsp',	
			    dataType: 'script',					
			    success: function(retCode) {
				    	       retCode=retCode.trim();
							    	 if(retCode.trim()=="000000"){
		                     $("#mydiv4").load("getFavFunc.jsp");
		                    parent.doFavfuncshow(retCode,"");
		                     //parent.getFavFunc();
									    	// rdShowMessageDialog("���ù���ɾ���ɹ�",2);
									    	 if(document.getElementById('tb_h').value!=-1)
													{
													document.getElementById("tb").value="";
													}
							    	 }else if(ret_code=="999999"){
							    	    // rdShowMessageDialog("���ù���ɾ��ʧ��,������!",0);	
							       }
					 }
			    };
		    $('#layer3_form').ajaxSubmit(options);         // �ύ��			   
		}); 	
		
}

);

function setThisShow(did){
	$("#div"+did+"_switch").attr({ src: "../../../nresources/<%=cssPath%>/images/jia.gif"}); 
	$("#mydiv"+did).hide();
}
var hiden = function()
{
	//��ѡ��
	if(this.checked)
	{
		if(this.id=="div1")
		{
			$("#div1_show").show();
			$("#div1_show").children().find("div:eq(0)").text($(this).attr("v_name"));
			setThisShow(1);
			
		}else if(this.id=="div3")
		{
			$("#div3_show").show();
			$("#div3_show").children().find("div:eq(0)").text($(this).attr("v_name"));
			setThisShow(3);
		}else if(this.id=="div4")
		{
			$("#div4_show").show();
			$("#div4_show").children().find("div:eq(0)").text($(this).attr("v_name"));
			setThisShow(4);
		}
		else if(this.id=="div5")
		{
			$("#div5_show").show();
			$("#div5_show").children().find("div:eq(0)").text($(this).attr("v_name"));
			setThisShow(5);
		}
		else if(this.id=="div6")
		{
			$("#div6_show").show();
			$("#div6_show").children().find("div:eq(0)").text($(this).attr("v_name"));
			setThisShow(6);
		}
		else if(this.id=="div7")
		{
		  $("#div7_show").show();	
		  $("#div7_show").children().find("div:eq(0)").text($(this).attr("v_name"));
		  setThisShow(7);
		}
		else if(this.id=="div8")
		{
		  $("#div8_show").show();	
		  $("#div8_show").children().find("div:eq(0)").text($(this).attr("v_name"));
		  setThisShow(8);
		}	
		else if(this.id=="div9")
		{
		  $("#div9_show").show();	
		  $("#div9_show").children().find("div:eq(0)").text($(this).attr("v_name"));
		  setThisShow(9);
		}				
		<%-- /**  modified by hejwa in 20110725 ��OP����--����������  begin **/ --%>
		else if(this.id=="div10")
		{
		  $("#div10_show").show();	
		  $("#div10_show").children().find("div:eq(0)").text($(this).attr("v_name"));
		  setThisShow(10);
		}else if(this.id=="div11")
		{
		  $("#div11_show").show();	
		  $("#div11_show").children().find("div:eq(0)").text($(this).attr("v_name"));
		  setThisShow(11);
		}
		setWkSpaceDiv(this.id,"1");
		<%-- /**  modified by hejwa in 201107256 ��OP����--����������  end **/ --%>		
	}
	else//ȡ��ѡ��
	{
		if(this.id=="div1")
		{
			$("#div1_show").hide();
		}else if(this.id=="div3")
		{
			$("#div3_show").hide();
		}else if(this.id=="div4")
		{
			$("#div4_show").hide();
		}else if(this.id=="div5")
		{
			$("#div5_show").hide();
		}
		else if(this.id=="div6")
		{
			$("#div6_show").hide();
		}
		else if(this.id=="div7")
		{
		  $("#div7_show").hide();
		}
		else if(this.id=="div8")
		{
		  $("#div8_show").hide();
		}
		else if(this.id=="div9")
		{
		  $("#div9_show").hide();
		}				
		<%-- /**  modified by hejwa in 20110725 ��OP����--����������  begin **/ --%>
		else if(this.id=="div10")
		{
		  $("#div10_show").hide();	
		}else if(this.id=="div11")
		{
		  $("#div11_show").hide();	
		}
		setWkSpaceDiv(this.id,"0");
		<%-- /**  modified by hejwa in 201107256 ��OP����--����������  end **/ --%>			
	}
};

var hideContent = function(e)
{
	var targetContent = $(this.parentNode.parentNode.parentNode.parentNode.parentNode);
	targetContent.hide();
	var div_id = $(this.parentNode.parentNode.parentNode.parentNode.parentNode).attr('id');
	if(div_id=="div1_show")
	{
		$("#div1").attr({checked:false});
	}
	else if(div_id=="div3_show")
	{
		$("#div3").attr({checked:false});
	}else if(div_id=="div4_show")
	{
		$("#div4").attr({checked:false});
	}else if(div_id=="div5_show")
	{
		$("#div5").attr({checked:false});
	}
	else if(div_id=="div5_show")
	{
		$("#div5").attr({checked:false});
	}
	else if(div_id=="div6_show")
	{
		$("#div6").attr({checked:false});
	}	
	else if(div_id=="div7_show")
	{
	  $("#div7").attr({checked:false});
	}
	else if(div_id=="div8_show")
	{
	  $("#div8").attr({checked:false});
	}	
	else if(div_id=="div9_show")
	{
	  $("#div9").attr({checked:false});
	}	
	else if(div_id=="div10_show")
	{
	  $("#div10").attr({checked:false});
	}	
	else if(div_id=="div11_show")
	{
	  $("#div11").attr({checked:false});
	}		
};
function loadLoginMdl(){
	$("#mydiv4").load("getFavFunc.jsp");
}
var toggleContent = function(e)
{
	var targetContent = $('DIV.itemContent', this.parentNode.parentNode.parentNode.parentNode.parentNode);
	
	if (targetContent.css('display') == 'none') {
		targetContent.slideDown(300);
		$(this).attr({ src: "../../../nresources/<%=cssPath%>/images/jian.gif"}); 
		//���÷���
		try{
			var tmp = $(this).attr('id');
			var tmp2 = eval("_jspPage."+tmp);
			//alert(tmp2[2]);
			if(tmp2[2]=="f"&&tmp2[1]!=''&&tmp2[1]!=undefined)
			{
				$("#"+tmp2[0]).load(tmp2[1]);
				//tmp2[2]="t";
			}
		}catch(e)
		{
		}
		
	} else {
		targetContent.slideUp(300);
		$(this).attr({ src: "../../../nresources/<%=cssPath%>/images/jia.gif"}); 
	}
	return false;
};


$("#mydiv0").load("getLoginInfo.jsp");

function clearQuickNav()
{
 	document.getElementById('tb').value="";
}

function quicknav(arr)
{
	
}

function close3Div(){
	$("#layer3").hide();
}

function showFunctionButn(obj){
  $(obj).find(":img").show();
}

function hiddenFunctionButn(obj){
  $(obj).find(":img").hide();
}

function deleteCommonFunction(obj){
  var function_code = obj.v_commonFunctionValue;
  var selCls = obj.v_commonFunctionSelCls;
  document.getElementById('manageflag').value="d";
  
  document.getElementById('function_code1').value=function_code;
  $("#op_type").val("d");
  $("#layer3").hide();
  var options = {	
    url:'favfunc_cfm.jsp',	
    dataType: 'script',					
    success: function(retCode) {
       retCode=retCode.trim();
    	 if(retCode.trim()=="000000"){
        $("#mydiv4").load("getFavFunc.jsp");
        parent.doFavfuncshow(retCode,"");
        //parent.getFavFunc();
        // rdShowMessageDialog("���ù���ɾ���ɹ�",2);
        if(document.getElementById('tb_h').value!=-1)
        {
          document.getElementById("tb").value="";
        }
        parent.reloadFavFunc();
    	 }else if(ret_code=="999999"){
    	    // rdShowMessageDialog("���ù���ɾ��ʧ��,������!",0);	
       }
  	 }
    };
  $('#layer3_form').ajaxSubmit(options);         // �ύ��	
}

</script>
</body>
</html>
