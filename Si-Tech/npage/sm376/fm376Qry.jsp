<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-13 ҳ�����,�޸���ʽ
*
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="/npage/properties/getRDMessage.jsp" %>

<%!

%>
<%        
	
	String regionCode =  (String)session.getAttribute("regCode");	
	String accepts  = request.getParameter("accepts");	
	String work_no = (String)session.getAttribute("workNo");
	String ywtypes  = request.getParameter("ywtypes");		

	
	//add by diling for ��ȫ�ӹ��޸ķ����б�
	String password = (String) session.getAttribute("password");	
	String  inputParsm [] = new String[17];
	inputParsm[0] = "0";
	inputParsm[1] = "01";
	inputParsm[2] = "m376";
	inputParsm[3] = work_no;
	inputParsm[4] = password;
	inputParsm[5] = "";
	inputParsm[6] = "";
	inputParsm[7] = accepts;
	
	String  divmsg="";
	if("0".equals(ywtypes)) {
		divmsg="ǿ�ƿ��ػ��ָ�(����)-���������ѯ���";
		inputParsm[2] = "2355";
	}else if("1".equals(ywtypes)) {
		divmsg="ǿ��Ԥ��(����)-���������ѯ���";
		inputParsm[2] = "1216";
	}
	else if("2".equals(ywtypes)) {
		divmsg="��λ�ͻ�Ԥ��(����)-���������ѯ���";
		inputParsm[2] = "m407";
	}
	else if("3".equals(ywtypes)) {
		divmsg="ǿ������(����)-���������ѯ���";
		inputParsm[2] = "1218";
	}
	


	
%>
     <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAccept" />
     	
	<wtc:service name="sm376Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="8">
			<wtc:param value="<%=inputParsm[0]%>"/>
			<wtc:param value="<%=inputParsm[1]%>"/>
			<wtc:param value="<%=inputParsm[2]%>"/>
			<wtc:param value="<%=inputParsm[3]%>"/>
			<wtc:param value="<%=inputParsm[4]%>"/>
			<wtc:param value="<%=inputParsm[5]%>"/>
			<wtc:param value="<%=inputParsm[6]%>"/>
			<wtc:param value="<%=inputParsm[7]%>"/>
	</wtc:service>

    <wtc:array id="result2" scope="end"  />
	
<HTML><HEAD><TITLE></TITLE>
<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>


<script type="text/javascript">
var miguFlag="N";
function go_check407Print(){
	var pactket2 = new AJAXPacket("/npage/sm407/fm407ChkPrint.jsp","���ڽ��е��ӹ���״̬�޸ģ����Ժ�......");
	pactket2.data.add("iLoginAccept",<%=accepts%>);
	core.ajax.sendPacket(pactket2,do_checkPrint);
	pactket2=null;
	
}
function do_checkPrint(packet){
	
	var s_ret_code = packet.data.findValueByName("retCode");
	var s_ret_msg = packet.data.findValueByName("retMsg");
	if(s_ret_code=="000000")
	{
		miguFlag=packet.data.findValueByName("miguFlag");
	}
}

function daYin(){
	go_check407Print();
	if("N"==miguFlag){
		if($.trim($("#phoneNums").val())!=""){
			var returnflag=showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
			if(returnflag!=undefined){
				var pactket2 = new AJAXPacket("/npage/sm407/fm407UpDserv.jsp","���ڽ��е��ӹ���״̬�޸ģ����Ժ�......");
				pactket2.data.add("id_no","0");
				pactket2.data.add("paySeq",<%=accepts%>);
				core.ajax.sendPacket(pactket2,doserv);
				pactket2=null;
			}
		}
		else{
			rdShowMessageDialog("��ǰִ�н�����ɴ�ӡ!ֻ��ȫ��ִ����ɲſɴ�ӡ,��ֻ��ӡ�ɹ�����!");
		}
 		
	}
	else{
		rdShowMessageDialog("�������ظ���ӡ���!");
	}
}	

function doserv(packet)
{
	var s_ret_code = packet.data.findValueByName("s_ret_code");
	var s_ret_msg = packet.data.findValueByName("s_ret_msg");
	if(s_ret_code!="000000")
	{
		//rdShowMessageDialog("���µ��ӹ���״̬ʧ��!�������:"+s_ret_code+",����ԭ��:"+s_ret_msg);
	}else{
		//location = location;
	}
}
		  
		  function showPrtDlg(printType,DlgMessage,submitCfm){  //��ʾ��ӡ�Ի��� 
		      var h=180;
		      var w=350;
		      var t=screen.availHeight/2-h/2;
		      var l=screen.availWidth/2-w/2;		   	   
		      var pType="subprint";             				 	//��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
		      var billType="1";              				 			  //Ʊ�����ͣ�1���������2��Ʊ��3�վ�
		      var sysAccept =<%=accepts%>;             	//��ˮ��
		      var printStr = printInfo(printType);
		      
			 		                      //����printinfo()���صĴ�ӡ����
		      var mode_code=null;           							  //�ʷѴ���
		      var fav_code=null;                				 		//�ط�����
		      var area_code=null;             				 		  //С������
		      var opCode="m407" ;                   			 	//��������
		      var phoneNo="";                  //�ͻ��绰
		      
		      var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		      var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
		      path+="&mode_code="+mode_code+
		      	"&fav_code="+fav_code+"&area_code="+area_code+
		      	"&opCode=m407&sysAccept="+sysAccept+
		      	"&phoneNo="+phoneNo+
		      	"&submitCfm="+submitCfm+"&pType="+
		      	pType+"&billType="+billType+ "&printInfo=" + printStr;
		      var ret=window.showModalDialog(path,printStr,prop);
		      return ret;
		    }				
		    
		    var print_info_arr = new Array();
		    /*
		     ���������
						�ͻ�����
						֤������
						֤������
						����������
						������֤������
						���ʷ�����
						���ʷ�����
		���Ρ��±��0��ʼ
		*/

				//��ӡģ��idΪ��93
		    function printInfo(printType){
		      var cust_info="";
		      var opr_info="";
		      var note_info1="";
		      var note_info2="";
		      var note_info3="";
		      var note_info4="";
		      var retInfo = "";
		      var array = new Array();
		      array["8"]="Ӫҵִ��";
		      array["A"]="��֯��������";
		      array["B"]="��λ����֤��";
		      array["C"]="��λ֤��";
		      
		      cust_info+="֤�����ͣ�"+array[$("#zjLxHm").val().split("|")[0]]+"|";
				cust_info+="֤�����룺"+$("#zjLxHm").val().split("|")[1]+"|";
		      
				opr_info+="ҵ�����ƣ���λ�ͻ�Ԥ��(����)"+"|";
				opr_info+="������ˮ��<%=accepts%>"+"|";
				opr_info+="�Ƿ�ѡ����Ȩ��������|";
				opr_info+="����Ԥ���ֻ����룺"+$("#phoneNums").val()+"|";
				
				
				var zchmLxhm_Arr = $("#zchmLxhm").val().split("|");
				
				if(zchmLxhm_Arr.length == 5){
					if(zchmLxhm_Arr[2]=="Y"){
						opr_info+="ת���ֻ����룺"+zchmLxhm_Arr[3]+"    �ͻ���ϵ�绰��"+zchmLxhm_Arr[4]+"|";
					}
				}
				
		      
		      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		      return retInfo;
		    }
</script>
</HEAD>
<body>
    	
	
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi"><%=divmsg%></div>
			</div>
	    <table cellspacing="0" name="t1" id="t1">
	      <tr align="center"> 
	        <th>�ֻ�����</th>
	        <th>����ʱ��</th>
	        <th>��������</th>
	        <th>ִ�н��</th>
			<th>ʧ��ԭ��</th>			
	      </tr>
		<%
		if(retCode.equals("000000")) {
		//System.out.println(result2.length);
		String phoneNums="";
		boolean resultFlag=false;
		if(result2.length>0) {
			String tbClass="";
			if("2".equals(ywtypes)) {
				%>
				<input type="hidden" id="zjLxHm" name="zjLxHm" value="<%=result2[0][6]%>"/>
				<input type="hidden" id="zchmLxhm" name="zchmLxhm" value="<%=result2[0][7]%>"/>
				<%
			}
			int phoneIndex=0;
			for(int y=0;y<result2.length;y++){
				if(y%2==0){
					tbClass="Grey";
				}else{
					tbClass="";
				}
				if("0".equals(result2[y][3])){
					resultFlag=true;
				}
				if("2".equals(result2[y][3])){
					phoneNums+=result2[y][0]+",";
					if(phoneIndex%5==0){
						phoneNums+="|";
					}
					phoneIndex++;
				}
		%>
						<tr align="center">
						<td class="<%=tbClass%>"><%=result2[y][0]%></td>					
						<td class="<%=tbClass%>"><%=result2[y][1]%></td>
						<td class="<%=tbClass%>"><%=result2[y][2]%></td>
						<td class="<%=tbClass%>"><%=result2[y][5]%></td>
						<%
						if("0".equals(result2[y][3]) || "2".equals(result2[y][3])){
						%>
						<td class="<%=tbClass%>"></td>
					  <%}else{%>
						<td class="<%=tbClass%>"><%=result2[y][4]%></td>
						<%}%>
						
		        </tr>
		<%
		    }
			if(resultFlag){
				phoneNums="";
			}
			if("2".equals(ywtypes)) {%>
					<tr align="center">
						<td colspan="5"><input type="hidden" id="phoneNums" name="phoneNums" value="<%=phoneNums%>"/><input type="button" class="b_foot_long" value="��ӡ���" onclick="daYin();"/></td>
		        	</tr>
		<%}
			
		  }else {
		%>
<tr height='25' align='center' ><td colspan='5'>��ѯ���������ϢΪ�գ�</td></tr>
<%}}else {
			%>
			<tr height='25' align='center'><td colspan='5'>��ѯʧ�ܣ�<%=retCode%>--<%=retMsg%></td></tr>

					<%
	}%>
		</table>

	</BODY>
</HTML>